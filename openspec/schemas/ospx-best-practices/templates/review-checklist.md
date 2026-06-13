# Review Checklist: [Change Title]

<!-- Five-axis code review framework.
     Severity prefixes: CRITICAL | IMPORTANT | NIT | OPTIONAL | FYI
     No merge until all CRITICAL items are resolved. -->

## 1. Correctness

- [ ] Change accomplishes its stated purpose (per proposal + specs)
- [ ] Every spec scenario has a corresponding test
- [ ] Edge cases and negative paths have tests
- [ ] No off-by-one errors; array bounds and loop conditions verified
- [ ] Error paths are handled explicitly; no silent swallowing of errors
- [ ] Race conditions considered for async / concurrent code
- [ ] No regression tests removed or disabled without justification
<!-- ADD change-specific correctness items -->

## 2. Readability & Simplicity

- [ ] Code is understandable without author explanation
- [ ] Naming is descriptive and consistent with codebase conventions
- [ ] No premature abstractions (three similar lines > one over-engineered helper)
- [ ] Control flow is direct; no deep nesting that can be flattened
- [ ] Change size is reviewable: ≤100 lines ideal, ≤300 acceptable, >300 must split
- [ ] Refactoring is separate from feature work (not mixed in this PR)
<!-- ADD change-specific readability items -->

## 3. Architecture

- [ ] Change fits the existing system design and established patterns
- [ ] Module boundaries and dependency direction are respected
- [ ] New abstractions are justified by their complexity cost
- [ ] No circular dependencies introduced
<!-- ADD change-specific architecture items -->

## 4. Security

- [ ] All external input validated and sanitised at system boundaries
- [ ] No secrets in code, logs, or version control
- [ ] Parameterised queries / ORM used; no string-interpolated SQL
- [ ] Output is encoded to prevent XSS
- [ ] Authentication and authorisation checks are present and correct
- [ ] New auth flows / sensitive data storage has explicit sign-off per design doc
- [ ] LLM / AI-generated output treated as untrusted — same rules as user input
- [ ] Dependencies are from trusted sources; no version pinning removed
<!-- ADD threat-model-specific items from design.md -->

## 5. Performance

- [ ] No N+1 queries introduced
- [ ] No unbounded loops over large datasets without pagination
- [ ] Async / non-blocking I/O used where appropriate
- [ ] Performance baselines from test-plan.md are not regressed
- [ ] No unnecessary re-renders (frontend) or redundant recomputation
<!-- ADD change-specific performance items -->

## Findings

<!-- Reviewers add findings here with severity prefix. -->

| Severity  | Location | Finding | Resolution |
|-----------|----------|---------|------------|
| CRITICAL  |          |         |            |

## Sign-Off

| Reviewer | Date | Status (Approved / Approved with nits / Requires changes) |
|----------|------|-----------------------------------------------------------|
|          |      |                                                           |

**Approval standard:** approve when the change definitely improves overall
code health, even if imperfect.  Never "LGTM" without evidence.
Do not block a change because it isn't exactly how you would have written it.
