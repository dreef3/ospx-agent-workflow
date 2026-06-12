# Tasks: [Change Title]

<!-- Use `- [ ] N.M Description` format — the apply phase tracks this.
     Each task must have implicit or explicit acceptance criteria.
     "Done" = tests pass + build succeeds + review-checklist item checked. -->

## 0. Pre-Implementation Gate

- [ ] 0.1 All spec scenarios have entries in test-plan.md
- [ ] 0.2 Test skeleton committed and confirmed FAILING (RED state verified)
- [ ] 0.3 Design threat model reviewed; approval-required items signed off
- [ ] 0.4 review-checklist.md populated with change-specific items
- [ ] 0.5 Assumptions from proposal reviewed; none are blocking

## 1. Foundation

<!-- Data models, schema migrations, API contracts — no business logic yet.
     Build the skeleton that later tasks flesh out. -->

- [ ] 1.1 [data model / schema task]
- [ ] 1.2 [API contract / interface definition task]

## 2. Core Implementation

<!-- Implement business logic, one spec scenario at a time (TDD). -->

- [ ] 2.1 [implement feature slice A — tests go GREEN]
- [ ] 2.2 [implement feature slice B — tests go GREEN]

## 3. Integration & Wiring

<!-- Connect components; integration tests go GREEN here. -->

- [ ] 3.1 [wire up service / handler / UI component]
- [ ] 3.2 [integration test for end-to-end path]

## 4. Hardening

<!-- Security controls, error handling, edge cases. -->

- [ ] 4.1 [input validation at system boundary]
- [ ] 4.2 [error path handling]
- [ ] 4.3 [negative test cases go GREEN]

## 5. Simplification

<!-- Refactor for clarity after all tests are green.
     No behaviour changes — only readability improvements. -->

- [ ] 5.1 [remove duplication identified during implementation]
- [ ] 5.2 [improve naming / control flow where clarity is low]

## 6. Verification Gate (required before merge)

- [ ] 6.1 Full test suite passes (unit + integration + e2e)
- [ ] 6.2 Build succeeds with no type errors or lint violations
- [ ] 6.3 review-checklist.md fully checked — zero CRITICAL items open
- [ ] 6.4 Performance baselines from test-plan.md not regressed
- [ ] 6.5 Secret scan passes — no credentials in diff
- [ ] 6.6 Documentation updated if public API or behaviour changed
