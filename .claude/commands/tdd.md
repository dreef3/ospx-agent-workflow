Run the TDD cycle for the current task.

## Pre-conditions (check before starting)

- [ ] A failing test exists for this task (or is about to be written)
- [ ] test-plan.md has an entry for this scenario (PENDING status)
- [ ] You know WHICH spec scenario this test covers

## The Cycle

### RED — Write the failing test

1. Read the spec scenario for this task.
2. Write a test that expresses the scenario's WHEN/THEN behaviour.
   - Use Arrange / Act / Assert structure.
   - Test observable behaviour, not implementation details.
   - DAMP over DRY — the test tells a complete story on its own.
3. Run the test. Confirm it **fails for the right reason**.
   - "Right reason" = the feature is not yet implemented, not a test error.
   - If it passes immediately: the test is wrong. Delete it and start over.

### GREEN — Minimum code to pass

4. Write the minimum production code to make the test pass.
   - Do not add anything beyond what the test requires.
   - Do not optimise, refactor, or generalise yet.
5. Run the test. Confirm it **passes**.
6. Run the full test suite. Confirm **no regressions**.

### REFACTOR — Clean up

7. Improve clarity, remove duplication, rename for intent.
   - No behaviour changes — all tests must stay green.
8. Run the full test suite again. All green.

## Stop-the-Line Rule

If the full test suite fails at any point: **STOP**.
Do not add features. Do not make other changes.
Diagnose the regression, fix it, and verify before resuming.

## Verification

Mark the task complete only when:
- [ ] All tests pass (run fresh, read the output)
- [ ] Build succeeds
- [ ] No secrets in the diff
- [ ] test-plan.md entry updated from PENDING to PASS
