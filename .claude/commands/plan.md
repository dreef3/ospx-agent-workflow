Spec-driven planning or task breakdown for the current change.

## Determine mode first

**No proposal.md yet** → run §A (spec-driven planning).
**Proposal + specs exist, no tasks.md** → run §B (task breakdown).
**All documents exist** → re-read everything and resume at the earliest
  missing piece.

---

## §A — Spec-Driven Planning

### Step 1 — Read before writing
Read all relevant code and context in read-only mode.
Do not write anything until you understand the existing system.

### Step 2 — Surface assumptions
Before touching any document:
```
ASSUMPTIONS I'M MAKING:
1. [assumption] → if wrong, this affects [impact]
→ Correct me now or I'll proceed with these.
```

### Step 3 — proposal.md
Write the proposal covering:
Why / What Changes / Capabilities (new + modified) / Assumptions / Impact / Out of Scope.

Keep to 1-2 pages.  The Capabilities section is the contract with specs.
Research existing specs before finalising it.

### Step 4 — specs/*.md
One file per capability.  Every requirement needs ≥1 GIVEN/WHEN/THEN scenario.
If a requirement cannot be expressed as a scenario it is too vague — sharpen it.
Include negative scenarios (invalid input, error paths, boundary conditions).

### Step 5 — test-plan.md
Map every scenario to a test entry (status: PENDING).
All tests must be in RED before implementation starts.
This is the TDD gate — no production code until this document is reviewed.

### Step 6 — design.md
Required unless all of these are true: single module, no new dependencies,
no data model changes, no security surface changes, no migration needed.
Security threat model (STRIDE) is always required even for simple changes.

### Step 7 — Validate before proceeding
Present all documents.  Surface any open questions.
Do not begin task breakdown until assumptions and open questions are resolved.

---

## §B — Task Breakdown

### Step 1 — Read the full context
Read proposal.md, specs/*.md, test-plan.md, design.md.
Verify all open questions in design.md are resolved.

### Step 2 — review-checklist.md
Generate the five-axis checklist populated with items specific to this change.
Pull security items from the STRIDE table in design.md.

### Step 3 — tasks.md
Structure:
- **§0 Pre-implementation gate** (all tests PENDING, design signed off)
- **§1–N Feature work** (each task = one spec scenario, TDD-sized: S or M)
- **Final section — Verification gate** (test suite, build, checklist, secret scan)

Task sizing: S (one class/component) or M (one feature end-to-end) maximum.
L+ tasks must be split before work begins.

### Verification
Planning is complete when:
- [ ] Every spec scenario has a test-plan entry
- [ ] Every task has unambiguous acceptance criteria
- [ ] No task is larger than M
- [ ] Verification gate section exists in tasks.md
- [ ] No unresolved open questions remain
