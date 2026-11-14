# API contract (v1 draft; implement in Week 2)

Base: /api/v1. JSON. Authentication: staff secure cookie/session; guest short-lived table-scoped token after QR + PIN verification.

| Method | Path | Who | Purpose |
|---|---|---|---|
| GET | /menu | Public | Available items |
| POST | /staff/login | Staff | Login |
| POST | /tables/:id/sessions | Staff | Open new dining session + PIN |
| POST | /guest/join | Guest | Validate table QR identifier plus session PIN |
| GET | /guest/session | Guest | Active session summary |
| POST | /guest/orders | Guest | Submit order: items [{menuItemId,quantity}], idempotency key |
| GET | /guest/orders | Guest | Own table orders |
| POST | /guest/request-bill | Guest | Close orders and request consolidated bill |
| GET | /guest/bill | Guest | Itemized server-derived total |
| GET | /staff/orders | Staff | Queue |
| PATCH | /staff/orders/:id/status | Staff | Advance status |
| POST | /staff/payments | Cashier | Record manual cash/MoMo verification |
| POST | /staff/sessions/:id/close | Cashier | Close paid session |

Error shape: {error:{code,message}}; sample codes 400 validation, 401 unauthenticated, 403 forbidden, 404 missing, 409 closed session/conflict.
Server computes price from menu_items.price_pesewas; snapshot it in order_items.unit_price_pesewas.
Guest request must never trust client-supplied table_id, amount, role, or payment status.
Updates should use Socket.IO session/table rooms where possible; 3-second polling fallback.
