# GitHub Copilot Instructions

This project uses the **ospx-best-practices** engineering workflow.
The full workflow spec lives in `openspec/schemas/ospx-best-practices/schema.yaml`.

---

## Development Workflow

Every non-trivial change goes through these phases in order:

```
proposal.md → specs/*.md → test-plan.md → design.md
    → review-checklist.md → tasks.md → apply (implement)
```

Do not skip phases.  Phases exist because problems are cheaper to fix in
earlier documents than in production code.

---

## Non-Negotiable Rules

### TDD — Tests Before Code
Write a failing test BEFORE writing any production code.

1. **RED**: Write the test.  Run it.  Confirm it fails for the right reason.
2. **GREEN**: Write the minimum code to make it pass.
3. **REFACTOR**: Clean up.  All tests stay green.

If a test passes immediately: the test is wrong.  Start over.

### Stop-the-Line
When tests fail or the build breaks: **stop adding features**.
Diagnose root cause.  Fix.  Guard with a test.  Then resume.

### Root Cause Only
Never fix a symptom.  Ask "why?" until you reach the actual cause.
Three failed fix attempts = architectural problem.  Redesign.

### Scope Discipline
Touch only what the current task requires.  No unsolicited cleanup,
no adjacent refactors, no speculative features.

### Verify Before Claiming Done
Run tests, read the output, confirm it passes.
"Should work" is not evidence.

### Surface Assumptions
Before implementing anything non-trivial, state assumptions explicitly.
Silent assumptions are the most common failure mode.

---

## Five-Axis Code Review

Every change is reviewed across five axes before merge:

1. **Correctness** — Does it do what the spec says?  Edge cases covered?
2. **Readability** — Understandable without the author explaining it?
3. **Architecture** — Fits the system design?  Boundaries respected?
4. **Security** — Input validated?  No secrets?  Auth checks present?
5. **Performance** — No N+1 queries?  Bounded operations?

Severity: CRITICAL (block merge) | IMPORTANT (fix before next task) |
NIT (minor) | OPTIONAL | FYI

---

## Security Non-Negotiables

- Validate all external input at system boundaries
- Parameterised queries only — no string-interpolated SQL
- No secrets in code or logs
- Output encoded to prevent XSS
- LLM/AI output treated as untrusted — same rules as user input

---

## Commit Format

```
<type>: <short description>

<optional body — explain why, not what>
```

Types: `feat` | `fix` | `refactor` | `test` | `docs` | `chore`
Refactoring and feature work go in separate commits.
Maximum ~300 lines per commit; >300 requires splitting.
