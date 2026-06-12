Run a five-axis code review for the current change.

## When to use

- Before merging any PR or change
- After completing a feature implementation
- When another agent or model produced code you need to evaluate
- After any bug fix (review both the fix and the regression test)

## Process

### Step 1 — Understand context

Read:
- proposal.md (what problem is being solved)
- specs/*.md (requirements)
- review-checklist.md (pre-generated checklist for this change)
- The diff / changed files

### Step 2 — Review tests first

Before reading implementation code, check:
- Do tests exist for every spec scenario?
- Do tests test behaviour (not implementation details)?
- Were tests written before the code (RED phase happened)?
- Do negative / edge-case tests exist?

### Step 3 — Apply the five-axis framework

#### Axis 1: Correctness
- Does the code accomplish its stated purpose per specs?
- Are error paths handled explicitly?
- Are there race conditions in async code?
- Does behaviour match every WHEN/THEN scenario?

#### Axis 2: Readability & Simplicity
- Understandable without author explanation?
- No premature abstractions?
- Change size reviewable? (≤100 ideal, ≤300 acceptable, >300 must split)
- Refactoring separate from feature work?

#### Axis 3: Architecture
- Fits existing system design and patterns?
- Module boundaries and dependency direction respected?
- Circular dependencies introduced?

#### Axis 4: Security
- All external input validated and sanitised?
- No secrets in code, logs, or version control?
- Parameterised queries used?
- Output encoded to prevent XSS?
- Auth checks present and correct?
- LLM / AI-generated output treated as untrusted?

#### Axis 5: Performance
- N+1 queries introduced?
- Unbounded loops without pagination?
- Blocking I/O where async is needed?
- Performance baselines from test-plan regressed?

### Step 4 — Categorise findings

Label every finding with severity:
- **CRITICAL** — must fix before merge
- **IMPORTANT** — must fix before proceeding
- **NIT** — style / minor; fix if easy
- **OPTIONAL** — good idea, not blocking
- **FYI** — informational

### Step 5 — Write the review

Format:
```
## Review: [change title]

### Summary
[1-2 sentence overall assessment]

### Findings

CRITICAL: [location] — [finding]
IMPORTANT: [location] — [finding]
NIT: [location] — [finding]

### Verdict
[ ] Approved
[ ] Approved with nits
[ ] Requires changes
```

## Standards

- Approve when the change definitely improves code health, even if not perfect.
- Never "LGTM" without reading the code.
- Do not block a change because it isn't exactly how you would have written it.
- Apply technical facts over opinions when resolving disputes.
- Respond within one business day.
