# Figma implementation specification

Create one Figma file **QuickBite UI/UX** with pages:
1. Cover + design tokens
2. Low-fidelity customer wireframes
3. High-fidelity customer screens
4. Staff desktop screens
5. Prototype flow and handoff

## Frames
Customer mobile: 390×844 pixels. Staff desktop: 1440×900 pixels.
Palette: navy #14213D, orange #F59E0B, white #FFFFFF, off-white #F8FAFC, green #16A34A, red #DC2626.
Type: Inter. Spacing: 8 px base grid. Button height ≥44px, 12px radii.

## Customer screen layout
C01 Join Table: header/logo; table number badge; 6-digit session PIN entry; Join button; error state.
C02 Browse Menu: sticky header/table; search/filter categories; two-column cards with image/name/price/add button; bottom cart bar.
C03 Cart: items, plus/minus, subtotal, place-order confirmation; disable double submission.
C04 Order Status: grouped orders, each state chip; Add More and View Bill CTAs.
C05 Running Bill: each submitted order subtotal + grand total, Request Final Bill.
C06 Bill Requested: total, cash or MoMo instructions, pending verification (no auto-paid claim).
C07 Paid Receipt: payment verified, receipt number, return-to-start.

## Staff dashboard layout
S01 Login: simple email/password.
S02 Tables Overview: sidebar 240px; table cards with OPEN/BILL_REQUESTED/PAID status; Open Session action + PIN.
S03 Order Queue: order cards show table, timestamp, items; status action.
S04 Table Bill: order grouping, authorized adjustment reason; calculate total.
S05 Payment Verification: cash amount received or MoMo transaction reference plus independently verified checkbox; only cashier/admin can verify.
S06 Menu Manager: create/edit/disable snacks.

## Prototype links
C01→C02→C03→C04→C05→C06→C07; C04→C02 (add more).
S02→S03→S04→S05; S02→open session modal.
Connect variant states: loading, disabled, empty, error, successful. Use Auto Layout and components for card, button, status chip, navigation, input. Export SVG/PDF screenshots for docs.
