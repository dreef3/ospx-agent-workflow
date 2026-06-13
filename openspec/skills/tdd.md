---
name: ospx-tdd
description: Run the TDD cycle — RED → GREEN → REFACTOR — for the current task
---

# TDD

Run the TDD cycle for the current task. No production code without a failing test first.

## Pre-conditions

- [ ] A failing test exists for this task (or is about to be written)
- [ ] `test-plan.md` has an entry for this scenario (status: PENDING)
- [ ] You know which spec scenario this test covers

## Phase 1 — RED: Write the failing test

1. Read the spec scenario for this task.
2. Write a test that expresses the scenario's WHEN/THEN behaviour.
   - Use Arrange / Act / Assert structure.
   - Test observable behaviour, not implementation details.
   - DAMP over DRY — the test tells a complete story on its own.
3. Run the test. Confirm it **fails for the right reason**.
   - "Right reason" = the feature is not yet implemented, not a test infrastructure error.
   - If it passes immediately: the test is wrong. Delete it and start over.

## Phase 2 — GREEN: Minimum code to pass

4. Write the minimum production code to make the test pass.
   - Do not add anything beyond what the test requires.
   - Do not optimise, refactor, or generalise yet.
5. Run the test. Confirm it passes.
6. Run the full suite. Confirm no regressions.

## Phase 3 — REFACTOR: Clean up

7. Improve clarity, remove duplication, rename for intent.
   - No behaviour changes — all tests must stay green.
8. Run the full suite again. All green.
9. Ask: "Would a staff engineer say 'why didn't you just…'?" If yes, simplify.
   Three similar lines > one over-engineered helper.

## Stop-the-Line Rule

If the full test suite fails at any point: **STOP**.
Do not add features. Do not make unrelated changes.
Diagnose the regression → fix root cause → verify → resume.

## Verification (before marking complete)

- [ ] All tests pass — run fresh, read the full output
- [ ] Build succeeds with no type errors or lint violations
- [ ] No secrets in the diff
- [ ] `test-plan.md` entry updated PENDING → PASS
- [ ] Commit is atomic: `<type>: <short description — WHY>`
