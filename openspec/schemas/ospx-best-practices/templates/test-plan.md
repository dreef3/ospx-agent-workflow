# Test Plan: [Change Title]

<!-- TDD CONTRACT: all tests listed here must be in a FAILING (RED) state
     before any production code is written.  Implementation begins only
     after this document is reviewed and accepted. -->

## Test Pyramid Allocation

| Layer       | Target % | Rationale                        |
|-------------|----------|----------------------------------|
| Unit        | ~80%     | Fast, isolated logic checks      |
| Integration | ~15%     | Component interactions, API seams |
| E2E         | ~5%      | Critical user paths only         |

## Tests Derived from Specs

<!-- Map every spec scenario to a test entry.
     ID format: UT-NNN (unit), IT-NNN (integration), E2E-NNN (end-to-end) -->

| ID      | Type        | Spec Scenario                  | Arrange / Act / Assert Skeleton       | Status  |
|---------|-------------|-------------------------------|---------------------------------------|---------|
| UT-001  | unit        | [Scenario name from spec]     | Arrange: … / Act: … / Assert: …       | PENDING |
| IT-001  | integration | [Scenario name from spec]     | Arrange: … / Act: … / Assert: …       | PENDING |
| E2E-001 | e2e         | [Scenario name from spec]     | Arrange: … / Act: … / Assert: …       | PENDING |

## Edge Cases & Negative Tests

<!-- Boundary conditions, invalid inputs, error paths — each needs a row above. -->

| ID      | Type  | Condition                    | Expected Behaviour                    | Status  |
|---------|-------|------------------------------|---------------------------------------|---------|
| UT-NEG-001 | unit | [invalid input description] | [error / rejection / safe default]   | PENDING |

## Test Isolation Strategy

- **State reset**: [describe how test state is reset — DB transactions rolled back, mocks cleared, etc.]
- **Test doubles policy**: [which doubles are acceptable and why — prefer real code over mocks where feasible]
- **DAMP over DRY**: Each test tells a complete story independently; shared helpers only for non-trivial setup.

## Performance Baselines

<!-- Any latency or throughput thresholds that must not regress.
     These become hard assertions in the test suite, not comments. -->

| Operation        | Baseline   | Measurement Method          |
|------------------|------------|-----------------------------|
| [e.g., API P99]  | ≤ 200 ms   | [tool / test name]          |

## Anti-Patterns to Avoid

- Testing implementation details instead of observable behaviour
- Mocking everything (high mock count = low confidence)
- Snapshot tests as a substitute for behaviour assertions
- Flaky tests left unresolved ("we'll fix it later" → never)
- Tests that pass immediately without a prior failing state
