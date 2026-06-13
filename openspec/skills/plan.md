---
name: ospx-plan
description: Spec-driven planning — create or complete the artifact chain for a change
---

# Plan

Spec-driven planning or task breakdown for the current change.

## Determine mode first

- **No `proposal.md` yet** → run §A (full planning from scratch)
- **Proposal + specs exist, no `tasks.md`** → run §B (task breakdown only)
- **All documents exist** → re-read everything and resume at the earliest missing piece

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

### Step 3 — `proposal.md`

Write the proposal covering:
**Why** / **What Changes** / **Capabilities** (new + modified) / **Assumptions** / **Impact** / **Out of Scope**.

Keep to 1–2 pages. The Capabilities section is the contract with specs.
Research existing specs before finalising it.

### Step 4 — `specs/*.md`

One file per capability. Every requirement needs ≥1 GIVEN/WHEN/THEN scenario.
If a requirement cannot be expressed as a scenario it is too vague — sharpen it.
Include negative scenarios (invalid input, error paths, boundary conditions).

Requirement format:
```
### Requirement: <name>
The system SHALL … (use SHALL/MUST for normative; never "should"/"may")

#### Scenario: <name>
- GIVEN <precondition>
- WHEN <action>
- THEN <expected outcome, observable from outside the system>
```

### Step 5 — `test-plan.md`

Map every scenario to a test entry (status: PENDING).
All tests must be in RED before implementation starts.
This is the TDD gate — no production code until this document is reviewed.

| ID     | Type        | Spec Scenario | Arrange / Act / Assert sketch | Status  |
| UT-001 | unit        | …             | …                             | PENDING |

### Step 6 — `design.md`

Required unless ALL of these are true: single module, no new dependencies,
no data model changes, no security surface changes, no migration needed.

Security threat model (STRIDE) is **always** required even for simple changes:

| Threat                 | Surface | Severity | Mitigation |
| Spoofing               | …       | H/M/L    | …          |
| Tampering              | …       | H/M/L    | …          |
| Repudiation            | …       | H/M/L    | …          |
| Information Disclosure | …       | H/M/L    | …          |
| Denial of Service      | …       | H/M/L    | …          |
| Elevation of Privilege | …       | H/M/L    | …          |

### Step 7 — Validate before proceeding

Present all documents. Surface any open questions.
Do not begin task breakdown until assumptions and open questions are resolved.

---

## §B — Task Breakdown

### Step 1 — Read the full context

Read `proposal.md`, `specs/*.md`, `test-plan.md`, `design.md`.
Verify all open questions in `design.md` are resolved.

### Step 2 — `review-checklist.md`

Generate the five-axis checklist populated with items specific to this change.
Pull security items from the STRIDE table in `design.md`.

### Step 3 — `tasks.md`

Required sections:
- **§0 Pre-implementation gate** — all tests PENDING, design signed off
- **§1–N Feature work** — one task per spec scenario, TDD-sized (S or M)
- **Final — Verification gate** — test suite, build, checklist, secret scan

Task sizing: S (one class/component) or M (one feature end-to-end) max.
L+ tasks must be split before work begins.

## Verification

Planning is complete when:
- [ ] Every spec scenario has a test-plan entry
- [ ] Every task has unambiguous acceptance criteria
- [ ] No task is larger than M
- [ ] Verification gate section exists in `tasks.md`
- [ ] No unresolved open questions remain
