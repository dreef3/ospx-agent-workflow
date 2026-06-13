# Engineering Workflow

This project uses the **ospx-best-practices** OpenSpec schema
(`openspec/schemas/ospx-best-practices/schema.yaml`).

All engineering practices are baked into the schema: TDD gates in
`test-plan`, five-axis code review in `review-checklist`, STRIDE threat
modelling in `design`, and a comprehensive implementation protocol in
the `apply` phase.

---

## Skill Discovery

```
Task arrives
    │
    ├── Exploring an idea or problem?              → openspec-explore
    ├── Ready to create a change with artifacts?   → openspec-propose
    ├── Implementing tasks from a change?          → openspec-apply-change  ← includes TDD, review, security
    ├── Done implementing, ready to archive?       → openspec-archive-change
    ├── Something broke mid-implementation?        → openspec-debug
    └── Ready to commit/merge?                     → openspec-ship
```

## Skills

| Skill | When to use |
|-------|-------------|
| `openspec-explore` | Think through ideas, investigate problems before committing to a change |
| `openspec-propose` | Start a new change — creates proposal, specs, design, tasks in one step |
| `openspec-apply-change` | Work through implementation tasks; TDD, review, and security are built in |
| `openspec-archive-change` | Finalise a completed change; syncs delta specs to main |
| `openspec-sync-specs` | Sync delta specs to main without archiving |
| `openspec-debug` | Reproduce → localise → fix root cause → guard |
| `openspec-ship` | Pre-merge / pre-deploy checklist |
| `openspec-tdd` | Standalone TDD cycle when working outside a change |
| `openspec-review` | Standalone five-axis code review |
| `openspec-security` | Standalone STRIDE + OWASP audit |

---

## Document Lifecycle

Every non-trivial change produces these documents in order:

```
proposal.md
    └── specs/*.md
            └── test-plan.md       ← TDD contract (all tests PENDING before coding)
            └── design.md          ← includes STRIDE threat model
                    └── review-checklist.md  ← five-axis pre-merge criteria
                            └── tasks.md     ← implementation checklist with gates
```

Do not skip phases.  A problem is cheapest to fix in an earlier document.

---

## Non-Negotiable Rules

### 1. Surface Assumptions Before Starting
State every assumption explicitly before writing code or documents:

```
ASSUMPTIONS I'M MAKING:
1. [assumption] → if wrong, this affects [impact]
2. …
→ Correct me now or I'll proceed with these.
```

Silent assumptions are the most common failure mode.

### 2. TDD — No Production Code Without a Failing Test

```
RED    → write the test; run it; confirm it fails for the RIGHT reason
GREEN  → write the minimum code to pass it; nothing more
REFACTOR → clean up; all tests must stay green
```

- If a test passes immediately: the test is wrong.  Delete it and start over.
- DAMP over DRY: each test tells a complete story independently.
- Test observable behaviour, not implementation details.
- Negative / edge-case tests are equally mandatory as happy-path tests.

### 3. Stop-the-Line

When tests fail, the build breaks, or behaviour diverges from specs:

1. **STOP** — no new features, no unrelated changes.
2. **PRESERVE** evidence: error output, logs, reproduction steps.
3. **DIAGNOSE**: reproduce → localise → reduce to minimal case → find root cause.
4. **FIX** the root cause (not the symptom).
5. **GUARD**: write a regression test.
6. **RESUME** only after verification passes.

### 4. Root-Cause Rule

Never fix a symptom.  Ask "why?" until you reach the actual cause.
Three failed fix attempts = the problem is architectural.  Redesign.

### 5. Scope Discipline

Touch only what the current task requires:
- No adjacent cleanup
- No refactoring orthogonal to the task
- No features not in the spec because they "seem useful"
- No deleting code that seems unused without explicit approval
- Refactoring goes in a separate commit from feature work

### 6. Verify Before Claiming Done

Run verification fresh.  Read the full output.  Confirm it supports the claim.
"Should work" / "probably" / "seems" = stop and verify first.
Evidence, not confidence.

### 7. Push Back When Warranted

Point out problems directly.  Quantify downsides where possible.
Propose an alternative.  Accept the human's decision with full information.
Sycophancy is a failure mode.

### 8. Manage Confusion Actively

When you hit inconsistent requirements or unclear specs:
1. STOP — do not guess and proceed.
2. Name the specific confusion.
3. Ask the clarifying question.
4. Wait for resolution.

---

## Five-Axis Code Review

Every change is reviewed on five axes before merge:

| Axis | Key Questions |
|------|--------------|
| Correctness | Does it satisfy every spec scenario? Edge cases covered? |
| Readability | Understandable without the author? No premature abstractions? |
| Architecture | Fits system design? Module boundaries respected? |
| Security | Input validated? No secrets? Auth checks present? |
| Performance | No N+1 queries? Bounded loops? Baselines not regressed? |

Severity labels: **CRITICAL** (block merge) | **IMPORTANT** (fix before next task) | **NIT** | **OPTIONAL** | **FYI**

Approval standard: approve when the change improves overall code health,
even if imperfect.  Never "LGTM" without evidence.

---

## Security Non-Negotiables

Always required, no exceptions:
- Validate and sanitise all external input at system boundaries
- Parameterised queries / ORM only — never string-interpolated SQL
- Encode output to prevent XSS
- No secrets in code, logs, or version control
- LLM / AI-generated output = untrusted; apply same rules as user input

Requires explicit approval before implementation:
- New auth flows, sensitive data storage, external integrations,
  CORS changes, file upload changes

---

## Commit Format

```
<type>: <short description — WHY, not just what>

<optional body>
```

Types: `feat` | `fix` | `refactor` | `test` | `docs` | `chore`

- Atomic commits: one logical change per commit
- Refactoring in a separate commit from feature work
- ≤300 lines per commit; >300 requires splitting

---

## Failure Modes to Avoid

1. Wrong assumptions without surfacing them
2. Plowing ahead when confused
3. Sycophancy to approaches with clear problems
4. Overcomplicating code (3 similar lines > premature abstraction)
5. Modifying code orthogonal to the task
6. Removing things you don't fully understand
7. Writing tests after the implementation
8. Claiming done without running verification
