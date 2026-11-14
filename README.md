# QuickBite — Table Ordering & Running Bill

QR-code-based dine-in restaurant ordering and consolidated billing system.

## Workflow
Staff opens table session → guest scans QR and enters session PIN → orders snacks → staff receives order and updates status → guest orders again → guest requests final bill → pays cash or MoMo → staff verifies payment → session closes.

## Scope
- Dine-in table ordering only; multiple guests can order against one active table session.
- No account required for customers; authenticated staff.
- No online gateway: manual cash/MoMo verification by authorized staff.
- GH₵ values stored as integer pesewas. The API calculates totals using server-side item prices.
- QR code alone must not authorize orders: require staff-issued per-session PIN or equivalent session join token.

## Project guides
- [Three-week team plan](docs/PROJECT_PLAN.md)
- [Requirements](docs/REQUIREMENTS.md)
- [API specification](docs/API.md)
- [Figma layout guide](design/FIGMA_LAYOUT.md)
- [MySQL schema](database/schema.sql)
- [Git Bash and VS Code guide](docs/GIT_GUIDE.md)

This is a Week 1 planning scaffold, not a running application.
