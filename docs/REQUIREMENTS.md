# Week 1 requirements and SRS baseline

## Problem
Manual table ordering creates queues, missed orders and split bills. QuickBite lets guests order from their table while staff manage fulfillment and payment.

## Roles
Guest (table-scoped session access), waiter (opens tables and updates orders), cashier/admin (verifies money and closes sessions).

## Functional requirements
- FR01 Staff log in with credentials and role-based permissions.
- FR02 Staff open a table session, generating a short-lived, non-reusable access PIN.
- FR03 Guests scan a QR code for the table, then enter the session PIN; a scan alone is not sufficient.
- FR04 Guests see available snacks, descriptions, prices (GH₵), and quantities.
- FR05 Cart addition/removal and server-calculated totals.
- FR06 Guest submits an order to an active session; every order has an order number.
- FR07 Staff receive an order on dashboard with visual/audio alert.
- FR08 Staff move orders NEW → PREPARING → READY → SERVED; only authorized changes.
- FR09 Multiple separate orders join one active session running bill.
- FR10 Guest requests final bill; session becomes BILL_REQUESTED and no further orders may be submitted.
- FR11 System calculates bill from all non-cancelled order items, including stored unit price snapshots.
- FR12 Cashier records cash or independently verifies customer MoMo transfer; customer reference alone does not mark paid.
- FR13 System closes paid session and makes table available.
- FR14 Staff-authorized cancellation or refund adjustment must record reason and actor.
- FR15 Staff can create/disable menu items and set availability.

## Non-functional requirements
- NFR01 Responsive on 360px mobile and 1280px desktop.
- NFR02 No plain-text staff passwords; secure salted hashes.
- NFR03 Database transactions for order insert, payment verification and session closure.
- NFR04 Avoid double charging/order duplication via idempotency key.
- NFR05 All privileged endpoints require role checks.
- NFR06 Accessible focus/labels and readable contrasts.
- NFR07 Retry and offline error notices; no silent order loss.
- NFR08 Environment configuration for credentials; never commit secrets.

## Key state rules
Dining session: OPEN → BILL_REQUESTED → PAID → CLOSED (or VOID, staff only).
Order: NEW → PREPARING → READY → SERVED (or CANCELLED, staff only).
Payment: PENDING → VERIFIED or REJECTED.
Only one OPEN/BILL_REQUESTED session per table; protect under DB transaction/lock. For prototype, staff manually checks real MoMo receipt; never request customers' MoMo PIN.

## Acceptance example
Given two diners joined the same table session, when A orders 2 pies (GH₵12 each) and B orders juice (GH₵10), then their shared bill shows GH₵34 and staff see both orders.
When bill requested, subsequent POST order returns 409.
Only authorized cashier can mark payment verified and close session.
