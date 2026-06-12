# Engineering Workflow — Claude Code

This project uses the **ospx-best-practices** OpenSpec schema.
Run `openspec start` to begin a new change, or `openspec apply` to
implement pending tasks.

---

## Skill Discovery

When a task arrives, find the right approach first:

```
Task arrives
    │
    ├── Don't know what you want yet?      → /interview
    ├── Have a concept, need a spec?       → /plan  (spec-driven)
    ├── Have a spec, need tasks?           → /plan  (task breakdown)
    ├── Implementing code?                 → /tdd
    │   ├── Something broke?              → /debug
    │   └── Stakes high / unfamiliar?     → pause, list assumptions first
    ├── Code ready for review?            → /review
    │   ├── Too complex?                  → simplify first, then /review
    │   └── Security concerns?           → /security
    └── Ready to commit/merge?           → /ship
```

---

## Non-Negotiable Behaviours

### 1. Surface Assumptions First
Before implementing anything non-trivial, state every assumption explicitly:

```
ASSUMPTIONS I'M MAKING:
1. [assumption] → if wrong, this affects [impact]
2. …
→ Correct me now or I'll proceed with these.
```

Silent assumptions are the most common failure mode.

### 2. TDD — No Production Code Without a Failing Test
```
RED    → write the test; confirm it fails for the right reason
GREEN  → write the minimum code to pass it
REFACTOR → clean up; all tests stay green
```

Violating the letter of TDD violates the spirit. No exceptions.

### 3. Stop-the-Line
When anything unexpected happens — tests fail, build breaks, behaviour
diverges from specs — **STOP**. Preserve evidence. Diagnose root cause.
Fix → guard → resume. Never push past a failing test.

### 4. Root-Cause Rule
Never fix a symptom. Ask "why does this happen?" until you reach the
actual cause. If three or more fix attempts fail, stop patching —
the problem is architectural.

### 5. Scope Discipline
Touch only what the current task requires. Do **NOT**:
- Clean up adjacent code
- Refactor orthogonal systems as a side effect
- Add features not in the spec
- Delete code that seems unused without explicit approval

### 6. Verify Before Claiming Done
Run verification, read the full output, confirm it supports the claim.
"Should work", "probably", "seems" → stop and verify first.

### 7. Push Back When Warranted
Point out problems directly. Quantify downsides when possible.
Propose an alternative. Accept the human's decision if they override
with full information. Sycophancy is a failure mode.

### 8. Manage Confusion Actively
When you hit inconsistencies or conflicting requirements:
1. **STOP** — do not proceed with a guess.
2. Name the specific confusion.
3. Present the tradeoff or ask the question.
4. Wait for resolution.

---

## Failure Modes to Avoid

1. Making wrong assumptions without surfacing them
2. Plowing ahead when confused or stuck
3. Not surfacing inconsistencies you notice
4. Sycophancy ("Of course!") to approaches with clear problems
5. Overcomplicating code — three similar lines > premature abstraction
6. Modifying code orthogonal to the task
7. Removing things you don't fully understand
8. Writing tests after (instead of before) the implementation
9. Saying "done" without running verification

---

## Slash Commands

| Command      | When to use                                              |
|-------------|----------------------------------------------------------|
| `/plan`      | Spec-driven planning or task breakdown                   |
| `/tdd`       | Test-driven implementation cycle (RED → GREEN → REFACTOR) |
| `/review`    | Five-axis code review before merge                      |
| `/debug`     | Structured debugging (reproduce → localise → fix → guard) |
| `/security`  | Security audit using STRIDE + OWASP                     |
| `/ship`      | Pre-merge / pre-deploy checklist                        |

---

## OpenSpec Workflow

```
openspec start          # generates proposal.md
openspec generate specs # generates specs/*.md
openspec generate test-plan
openspec generate design
openspec generate review-checklist
openspec generate tasks
openspec apply          # implements tasks.md
```
