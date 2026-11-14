-- QuickBite prototype MySQL 8+ baseline; schema to review before production
CREATE DATABASE IF NOT EXISTS quickbite CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE quickbite;
CREATE TABLE staff_users (
 id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 full_name VARCHAR(120) NOT NULL,
 email VARCHAR(255) NOT NULL UNIQUE,
 password_hash VARCHAR(255) NOT NULL,
 role ENUM('WAITER','CASHIER','ADMIN') NOT NULL,
 active BOOLEAN NOT NULL DEFAULT TRUE,
 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE restaurant_tables (
 id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 table_number VARCHAR(20) NOT NULL UNIQUE,
 qr_identifier CHAR(36) NOT NULL UNIQUE,
 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE menu_items (
 id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 name VARCHAR(120) NOT NULL,
 description TEXT,
 image_url VARCHAR(500),
 price_pesewas INT UNSIGNED NOT NULL,
 category VARCHAR(60) NOT NULL,
 available BOOLEAN NOT NULL DEFAULT TRUE
);
CREATE TABLE dining_sessions (
 id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 table_id BIGINT UNSIGNED NOT NULL,
 opened_by BIGINT UNSIGNED NOT NULL,
 status ENUM('OPEN','BILL_REQUESTED','PAID','CLOSED','VOID') NOT NULL DEFAULT 'OPEN',
 pin_hash VARCHAR(255) NOT NULL,
 opened_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 closed_at TIMESTAMP NULL,
 CONSTRAINT fk_session_table FOREIGN KEY (table_id) REFERENCES restaurant_tables(id),
 CONSTRAINT fk_session_staff FOREIGN KEY (opened_by) REFERENCES staff_users(id),
 INDEX idx_table_session(table_id,status)
);
CREATE TABLE orders (
 id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 session_id BIGINT UNSIGNED NOT NULL,
 idempotency_key VARCHAR(100) NOT NULL,
 status ENUM('NEW','PREPARING','READY','SERVED','CANCELLED') NOT NULL DEFAULT 'NEW',
 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 UNIQUE KEY uq_session_request(session_id,idempotency_key),
 CONSTRAINT fk_order_session FOREIGN KEY (session_id) REFERENCES dining_sessions(id)
);
CREATE TABLE order_items (
 id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 order_id BIGINT UNSIGNED NOT NULL,
 menu_item_id BIGINT UNSIGNED NOT NULL,
 quantity INT UNSIGNED NOT NULL,
 unit_price_pesewas INT UNSIGNED NOT NULL,
 CONSTRAINT fk_item_order FOREIGN KEY (order_id) REFERENCES orders(id),
 CONSTRAINT fk_item_menu FOREIGN KEY (menu_item_id) REFERENCES menu_items(id),
 CHECK (quantity > 0)
);
CREATE TABLE payments (
 id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 session_id BIGINT UNSIGNED NOT NULL,
 amount_pesewas INT UNSIGNED NOT NULL,
 method ENUM('CASH','MOMO') NOT NULL,
 reference_code VARCHAR(120) NULL,
 status ENUM('PENDING','VERIFIED','REJECTED') NOT NULL DEFAULT 'PENDING',
 verified_by BIGINT UNSIGNED NULL,
 verified_at TIMESTAMP NULL,
 CONSTRAINT fk_payment_session FOREIGN KEY (session_id) REFERENCES dining_sessions(id),
 CONSTRAINT fk_payment_staff FOREIGN KEY (verified_by) REFERENCES staff_users(id)
);
CREATE TABLE audit_logs (
 id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 actor_staff_id BIGINT UNSIGNED NULL,
 action VARCHAR(100) NOT NULL,
 entity_type VARCHAR(80) NOT NULL,
 entity_id BIGINT UNSIGNED NOT NULL,
 reason VARCHAR(500),
 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 CONSTRAINT fk_audit_staff FOREIGN KEY (actor_staff_id) REFERENCES staff_users(id)
);
-- Application must serialize session opening under table lock to prevent duplicate active sessions.
-- Never store guest session PIN in plaintext; use salted hashes and rate-limit attempts.
