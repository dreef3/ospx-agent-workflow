# Skill: JIRA Critic

Version: 2.1

## Purpose

Review JIRA tickets for completeness, clarity, and deliverability. Produce a structured verdict with specific, actionable findings. Findings must be honest: incomplete tickets waste engineering time, but inventing problems in a good ticket wastes everyone's time too. Calibrate accordingly.

---

## When to Use

- Before a ticket is moved into sprint planning or refinement
- When a ticket is escalated as "unclear" by an engineer
- During backlog grooming to triage low-quality items
- As a pre-QBR check before committing to scope

## When Not to Use

- To rewrite a ticket for the author (this skill diagnoses, it does not author)
- To estimate effort (use the L0 Estimator skill)
- To review a ticket that already passed and is mid-delivery

---

## Inputs

Primary input is a **JIRA ticket key** (e.g. PROJ-1234). Retrieve the ticket yourself using the available JIRA retrieval skill before critiquing — do not ask the user to paste it.

Accepted inputs:
- A JIRA ticket key (primary path: fetch the full ticket via the JIRA skill)
- Pasted ticket text (fallback, when retrieval is unavailable for a given ticket)
- Optional: known constraints not in the ticket (regulatory, deadline, team ownership)

### Step 0 — Retrieve the ticket

Given a key, use the JIRA skill to pull the full ticket: summary, description, type, acceptance criteria, parent/linked issues, and comments. Critique the retrieved content, not a summary of it.

Because you are reading the whole ticket, an absent field is a **genuine gap**, not a paste omission — flag it as a finding. The only time you use a `NOT RETRIEVED` note is when the fetch itself fails or a field is inaccessible (permissions, broken link). List those once at the top and exclude them from findings, since you could not assess them.

---

## Instructions

First, classify the ticket type. Bugs use a different rubric from feature work (Story/Task/Epic). Then run the matching rubric below.

Do not produce a finding for a criterion that is satisfied. A ticket with three real problems should produce three findings, not seven padded ones. If the ticket is genuinely good, say so and return a short output — do not manufacture concerns to look thorough.

When you do raise a finding, quote the specific offending text from the ticket so the author can locate it. If the problem is an absence, name exactly what is missing.

### Rubric A — Feature work (Story / Task / Epic)

**A1. Business justification.** Is it clear why this work is needed? A feature must state the business or regulatory driver. "As requested by stakeholder" is not a driver.

**A2. Scope boundaries.** Is it clear what is in and explicitly out of scope? Watch for "and also", "as well as", "plus" — these often signal a ticket that should be split.

**A3. Acceptance criteria.** Each criterion must be independently testable. Reject criteria that restate the requirement, are unmeasurable ("user-friendly"), describe process rather than outcome ("developer will write tests"), or are missing.

**A4. Ownership and dependencies.** Is the owning team or component clear? If the ticket spans services or teams, are the interfaces and handoffs defined? Unowned dependencies are delivery risk.

**A5. Non-functional requirements.** For anything touching production, flag if these are absent or vague: performance / SLA, data volume or throughput, security or data classification, regulatory constraints (especially multi-country), rollback or reversibility.

**A6. Ambiguous language.** Flag domain-sensitive terms used without definition. In multi-country or multi-product platforms, words like account, statement, currency, customer may mean different things in different contexts. To test a term: ask whether two engineers on different squads would build the same thing from it. If not, it needs definition.

**A7. Size and type fit.** Is this sized appropriately for its type? A Story that exceeds one sprint for one team is an Epic. A Task with ten subtasks is a Story.

### Rubric B — Bugs

**B1. Reproduction.** Are there concrete reproduction steps? "Sometimes fails" with no path to reproduce is not actionable.

**B2. Expected vs actual.** Is the expected behaviour stated alongside the observed behaviour? A bug with only "it's broken" is incomplete.

**B3. Environment and scope.** Which environment, which countries/products, which versions? A production-only bug and a local-only bug are different tickets.

**B4. Impact and frequency.** Who is affected, how often, and what is the consequence? This drives priority and must be present.

**B5. Evidence.** Are there logs, IDs, screenshots, or a correlation/trace ID? For a regulated platform, "no evidence attached" is a major gap for anything touching financial output.

---

## Verdict Logic (deterministic)

Assign severity to each finding: BLOCKER, MAJOR, or MINOR. Then apply this rule exactly:

- Any BLOCKER finding -> **REJECT**
- No BLOCKER, but two or more MAJOR -> **REJECT**
- No BLOCKER, exactly one MAJOR -> **NEEDS WORK**
- No BLOCKER, no MAJOR, one or more MINOR -> **CONDITIONAL PASS**
- No findings -> **PASS**

Severity guidance:
- BLOCKER: the ticket cannot be refined or estimated as written (e.g. no testable AC, no business driver, scope undefined).
- MAJOR: refinement is possible but delivery risk is high if unaddressed (e.g. missing NFRs, unowned dependency).
- MINOR: should be fixed but does not block (e.g. one ambiguous term, slightly oversized).

---

## Output Format

```
VERDICT: [REJECT | NEEDS WORK | CONDITIONAL PASS | PASS]
TICKET TYPE: [Story | Task | Epic | Bug]

NOT RETRIEVED
[Fields the fetch could not return — permissions, broken links, fetch failure. Omit this block entirely if the full ticket was retrieved.]

SUMMARY
One or two sentences on overall quality.

FINDINGS
For each issue (omit this block if PASS):
  - Criterion: [code and name, e.g. A3 Acceptance Criteria]
  - Severity: [BLOCKER | MAJOR | MINOR]
  - Offending text: "[exact quote from the ticket, or 'ABSENT' if the field is genuinely missing]"
  - Finding: [specific description]
  - Suggested fix: [concrete action for the author]

RECOMMENDED NEXT STEP
One action: return to author / split ticket / escalate for requirements session / ready for refinement.
```

---

## Example

**Input (Story):**
```
Summary: Implement new statement format for DE customers
Description: Customers in Germany need a new PDF statement format. Should be done before Q3.
Acceptance Criteria: The statement looks correct.
```

**Output:**
```
VERDICT: REJECT
TICKET TYPE: Story

SUMMARY
No business driver, no testable acceptance criteria, and undefined scope. Cannot be refined or estimated as written.

FINDINGS
  - Criterion: A1 Business Justification
    Severity: BLOCKER
    Offending text: "Customers in Germany need a new PDF statement format"
    Finding: States a want, not a driver. No regulatory change, contractual obligation, or complaint volume is referenced.
    Suggested fix: State the specific driver and link the source document or request.

  - Criterion: A3 Acceptance Criteria
    Severity: BLOCKER
    Offending text: "The statement looks correct"
    Finding: Not testable. "Correct" is undefined.
    Suggested fix: Enumerate the fields, formatting rules, and layout. Reference the design spec if one exists.

  - Criterion: A2 Scope Boundaries
    Severity: MAJOR
    Offending text: "DE customers"
    Finding: Unclear whether this covers all account types and products, or only PDF and not CAMT.053. "DE customers" may span several products.
    Suggested fix: List the statement types, account types, and customer segments in and out of scope.

RECOMMENDED NEXT STEP
Return to author. Schedule a requirements session before re-submission.
```
