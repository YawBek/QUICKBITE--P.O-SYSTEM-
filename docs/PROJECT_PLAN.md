# QuickBite: Three-week plan for three members

## Members
**A:** team lead, requirements and customer frontend; **B:** API and MySQL; **C:** staff dashboard, alerts, QA and DevOps. Each member reviews another member's work.

## Week 1 — Requirements, diagrams, design, and setup
| Day | Member A | Member B | Member C | Evidence |
|---|---|---|---|---|
| 1 | Charter, scope | Technical feasibility | Backlog and risks | Meeting notes |
| 2 | Functional/nonfunctional requirements and use cases | ERD and table relationships | Acceptance criteria and threat list | SRS revision |
| 3 | Customer Figma wireframes | API contract | Staff Figma wireframes | Prototype link |
| 4 | Design tokens and UI states | SQL schema + seed strategy | QA plan and status rules | Reviewed designs |
| 5 | Vite/React app scaffold | Express API scaffold | Repo issues, workflow and lint/test setup | Separate PRs |
| 6 | Menu page prototype | DB connectivity | Smoke tests and CI review | Demo |
| 7 | Consolidate SRS | Architecture walkthrough | Audit issues and milestones | Week 1 sign-off |

## Week 2 — Ordering
| Day | A | B | C |
|---|---|---|---|
| 8 | Menu/cards | Menu endpoint and seed | Staff login shell |
| 9 | Scan QR + enter session PIN | Session open/join endpoints | Staff table control |
| 10 | Cart and submit | Transaction-safe order creation | Order queue |
| 11 | Customer order statuses | Status endpoints/events | Status updates + alert sound |
| 12 | Running bill UI | Accurate sum of orders | Table bill overview |
| 13 | Error/empty/mobile states | Validation/auth/rate limits | Integrated tests |
| 14 | Joint demo and PR review | Joint demo and PR review | Defect triage |

## Week 3 — Settlement and delivery
| Day | A | B | C |
|---|---|---|---|
| 15 | Bill request UI | Lock session from further orders | Bill notification |
| 16 | Receipt UI | Payment records + verify route | Cash/MoMo verification screen |
| 17 | UI regression fixes | Concurrent submission/idempotency tests | End-to-end tests |
| 18 | Accessibility | Authorization/security tests | Test evidence |
| 19 | Production build | Deployment settings and migrations | CI/deploy |
| 20 | SRS/screenshots/user guide | Backend documentation | Test report |
| 21 | Full presentation/demo | Full presentation/demo | Handover |

## Weekly acceptance gates
**W1:** approved scope, ERD, APIs, Figma customer + staff wireframes, runnable frontend/backend scaffold, shared repo and 3 member commits.
**W2:** two diners at same table create separate orders that appear on a single bill; staff changes status.
**W3:** cashier verifies payment, correct single receipt, session closes and old session QR/PIN cannot place orders; all tests documented.

## Decision rules
Out of scope: delivery, advance deposits, automated MoMo charge, inventory procurement, loyalty points, advanced analytics.
Daily 15-minute stand-up; peer-reviewed PRs to main; never commit .env or credentials.
