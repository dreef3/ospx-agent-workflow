# Engineering Workflow — Claude Code

This project uses the **ospx-best-practices** OpenSpec schema.
All engineering practices (TDD, code review, security, debugging) are
baked into the schema's artifact instructions and apply phase.

---

## Skill Discovery

```
Task arrives
    │
    ├── Don't know what you want yet?   → /interview
    ├── Have a concept, need a spec?    → /plan
    ├── Have a spec, need tasks?        → /plan
    ├── Implementing code?              → /tdd
    │   ├── Something broke?           → /debug
    │   └── Stakes high / unfamiliar?  → list assumptions, then /tdd
    ├── Code ready to merge?           → /review
    │   ├── Too complex?               → simplify first
    │   └── Security concerns?         → /security
    └── Ready to commit/merge?         → /ship
```

---

## Non-Negotiable Behaviours

### Surface Assumptions First
Before implementing anything non-trivial:
```
ASSUMPTIONS I'M MAKING:
1. [assumption] → if wrong, this affects [impact]
→ Correct me now or I'll proceed with these.
```

### TDD
```
RED    → write the test; confirm it fails for the right reason
GREEN  → minimum code to pass it
REFACTOR → clean up; all tests stay green
```
No production code without a failing test first. No exceptions.

### Stop-the-Line
Tests fail or build breaks → **STOP**. Diagnose root cause. Fix → guard → resume.
Never push past a failing test.

### Root-Cause Rule
Never fix a symptom. Three failed attempts = architectural problem; redesign.

### Scope Discipline
Touch only what the current task requires.
No adjacent cleanup, no speculative features, no unsolicited refactors.

### Verify Before Claiming Done
Run verification, read the full output. "Should work" is not evidence.

### Push Back When Warranted
Point out problems directly. Propose an alternative.
Sycophancy ("Of course!") is a failure mode.

### Manage Confusion Actively
Confused or facing conflicting requirements → STOP, name the confusion,
ask, wait for resolution. Never guess and plow ahead.

---

## Failure Modes to Avoid

1. Silent assumptions
2. Plowing ahead when confused
3. Sycophancy to approaches with clear problems
4. Three similar lines < premature abstraction — prefer the simpler thing
5. Modifying code orthogonal to the task
6. Removing things you don't fully understand
7. Tests written after (not before) implementation
8. Claiming done without running verification

---

## Skills

| Skill        | When to use                                               |
|-------------|-----------------------------------------------------------|
| `/plan`      | Spec-driven planning or task breakdown                    |
| `/tdd`       | TDD cycle: RED → GREEN → REFACTOR                        |
| `/review`    | Five-axis code review before merge                       |
| `/debug`     | Reproduce → localise → fix → guard                       |
| `/security`  | STRIDE + OWASP audit                                     |
| `/ship`      | Pre-merge / pre-deploy checklist                         |
