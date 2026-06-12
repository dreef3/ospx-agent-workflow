Run the spec-driven planning or task-breakdown workflow.

## Step 1 — Determine mode

If no proposal.md exists: spec-driven planning (go to §2).
If proposal + specs exist but no tasks.md: task breakdown (go to §3).

## Step 2 — Spec-Driven Planning

1. Read all relevant code and context in READ-ONLY mode before writing anything.
2. List ALL assumptions explicitly before drafting the proposal.
3. Generate `proposal.md` covering: Why / What Changes / Capabilities / Assumptions / Impact.
4. For each capability in the proposal, generate `specs/<name>/spec.md`.
   - Every requirement has ≥1 GIVEN/WHEN/THEN scenario.
   - Scenarios use SHALL/MUST — no "should" or "may".
5. Generate `test-plan.md` from the spec scenarios.
   - Map every scenario to a test entry with status PENDING.
   - All tests must be in RED state before implementation starts.
6. Generate `design.md` (skip only if the change is trivial and internal).
   - Security threat model is always required.
7. Present the full set of documents and surface any open questions
   before proceeding to tasks.

## Step 3 — Task Breakdown

1. Read proposal.md, specs/*.md, test-plan.md, and design.md.
2. Generate `review-checklist.md` with change-specific items under each axis.
3. Generate `tasks.md`:
   - Section 0: Pre-implementation gate
   - Sections 1–N: Feature work grouped logically
   - Final section: Verification gate (full test suite, build, checklist, secret scan)
   - Every task uses `- [ ] N.M description` format.
   - Maximum task size is M (one feature end-to-end); anything larger must split.

## Verification

The plan is complete when:
- [ ] All spec scenarios have test-plan entries
- [ ] All tasks have clear, testable acceptance criteria
- [ ] No task is larger than M
- [ ] Verification gate section is present in tasks.md
