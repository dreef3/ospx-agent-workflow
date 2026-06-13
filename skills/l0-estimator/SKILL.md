# Skill: L0 Estimator

Version: 2.0

## Purpose

Produce a high-level effort estimate for an initiative that has no design yet, suitable for a QBR, planning session, or investment decision. The output is not a commitment. It is a sized assumption set with explicit uncertainty and a confidence level.

---

## When to Use

- QBR or quarterly planning preparation, including sizing several initiatives in one sitting
- Investment or funding conversations that need a rough effort signal
- Early feasibility assessment before discovery is funded
- Comparing relative size of several vague initiatives

**Do not use** for work that already has a technical design. Use a bottom-up estimate instead.

---

## Calibration — set this once before first use

The effort bands below use indicative team-weeks. These are placeholders. Replace them with your own team's reference points before relying on the skill, because a band is only meaningful relative to a known delivery pace.

If no calibrated bands are supplied, state in the output that default bands were used and the estimate carries lower confidence as a result.

| Band | Default team-weeks | Typical profile |
|------|--------------------|-----------------|
| S    | 1–3                | Single service, no schema change, no external integration |
| M    | 4–10               | 2–4 services, minor schema change, internal integration only |
| L    | 11–25              | 5+ services, schema migration, external integration, or regulatory sign-off |
| XL   | 26+                | Platform-level change, multi-team, external parties, or significant unknowns |

---

## Two modes

**Interactive mode** — for a single initiative you want to think through carefully. Run the six phases as a guided conversation, one question at a time.

**Rapid mode** — for QBR prep across many initiatives. The user pastes a brief (a paragraph or a few bullets). You run all six phases internally in one pass, make explicit assumptions wherever information is missing, and return the artifact directly. Every assumption you made to fill a gap must appear in the ASSUMPTIONS block, marked `[inferred]`. Do not ask questions in rapid mode unless the brief is too vague to identify what the initiative even is.

Default to interactive mode unless the user signals batch sizing ("here are five for the QBR", "just size this", a pasted brief with no conversation).

---

## Inputs

- Initiative name and one-sentence description
- Any known constraints (deadline, regulatory driver, named stakeholder)
- **Reference class**: any past work the team has done that resembles this. This is the most valuable input — provide it whenever possible.
- Optional: a list of systems or teams likely to be involved

---

## Instructions

Run six phases in order. In interactive mode, state each phase name and goal, ask one question at a time, summarise what you captured, confirm, then continue. In rapid mode, run them silently and fill gaps with marked assumptions.

If the user cannot answer (interactive) or the brief omits something (rapid), log it as an open assumption and continue. Never block on an unknown — surface it.

### Phase 1 — Scope confirmation

Establish a firm boundary.
1. What does done look like, in one or two sentences?
2. What is explicitly out of scope, even if related?
3. Is there a hard deadline, and what is the consequence of missing it?
4. Who is the named business owner?

If done cannot be described in two sentences, the initiative is not ready to size. In interactive mode, flag this and recommend discovery. In rapid mode, return a "too vague to size" verdict immediately rather than guessing.

### Phase 2 — Reference class

This phase comes before impact mapping on purpose. Anchoring to a real past delivery is more accurate than building an estimate from parts.

1. Has the team built something structurally similar? Name it.
2. What did that take, end to end?
3. How is the current initiative bigger or smaller than that reference?

If a reference exists, it becomes the primary anchor and the band in Phase 4 is expressed relative to it ("similar to X but with an added country, so one band larger"). If no reference exists, note that the estimate is unanchored and lower-confidence, and proceed to bottom-up banding.

### Phase 3 — System and impact map

1. Which systems or components are definitely affected?
2. Which might be affected but are uncertain?
3. External integrations (third-party vendors, regulators, SWIFT, partner banks)?
4. Database schema change?
5. Any shared or platform-level component used by multiple teams?

Capture two lists: confirmed impact and suspected impact. Suspected items become assumptions.

### Phase 4 — Effort banding

Produce a range, not a number. Do not ask for points or days.

1. If a reference class exists, band relative to it and adjust for the differences identified in Phase 2.
2. If no reference, band each confirmed impacted area independently using the calibration table, then sum as a cross-check.
3. Express the result as a range whenever the boundary is uncertain (e.g. "M to L").

Uncertainty adjustment: count the open assumptions carrying material scope risk (a false assumption that would change the band). If there are three or more such assumptions, widen the range upward by one band and lower the confidence rating. Do not silently absorb uncertainty into a point estimate.

### Phase 5 — Risk flags

Confirm or deny each:
- **Regulatory**: touches a regulated process, reporting obligation, or data subject right?
- **Data**: personal data, cross-border transfer, or retention changes?
- **Dependency**: contingent on another team's uncommitted roadmap item?
- **Discovery gap**: architectural decisions needed before delivery can start?
- **Reversibility**: can it be rolled back cleanly if it fails in production?

Log each confirmed risk.

### Phase 6 — QBR readiness verdict

- **Ready**: scope clear, impact mapped, no blocking unknowns, band M or smaller
- **Ready with conditions**: band M–L, assumptions logged, named owner exists
- **Not ready — discovery first**: band L or larger, or three or more blocking unknowns, or no named owner
- **Not ready — too vague to size**: scope could not be confirmed in Phase 1

---

## Output Format

Produce only this artifact (interactive mode: after Phase 6; rapid mode: directly).

```
L0 ESTIMATE — [Initiative Name]
Date: [date]   Mode: [interactive | rapid]
Note: Pre-design estimate, not a delivery commitment.

SCOPE
In: [bullets]
Out: [bullets]

REFERENCE CLASS
[Named past delivery and how this compares, or "none — estimate is unanchored"]

SYSTEM IMPACT
Confirmed: [list]
Suspected: [list — each is an assumption]

ASSUMPTIONS
1. We assume [X]. If false, the estimate is invalid. [inferred, if applicable]
2. We assume [Y]. If false, the band shifts by approximately [shift].
[continue]

EFFORT BAND
[Range, e.g. M to L]
Confidence: [High | Medium | Low]
Rationale: [2–3 sentences on the main drivers and the basis — reference class or bottom-up]
Calibration: [calibrated bands | default bands used]

RISK FLAGS
[Confirmed risks, one line each, or "none confirmed"]

QBR READINESS
Verdict: [Ready | Ready with conditions | Not ready — discovery first | Not ready — too vague to size]
Rationale: [one sentence]

RECOMMENDED NEXT STEP
[Single action: fund discovery / assign owner / split initiative / proceed to refinement]
```

Confidence rating guidance:
- High: reference class exists, scope confirmed, fewer than three open assumptions
- Medium: either no reference class or several open assumptions, but scope is clear
- Low: no reference class and three or more open assumptions, or default bands used

---

## Facilitation Notes

- For multi-initiative QBR prep, run rapid mode per initiative and present the results as a comparison table (name, band, confidence, verdict) so relative size is visible at a glance. The full artifact for each can follow below the table.
- If the user gives their own number, do not adopt it. Use it as a calibration check only and band independently. If your band disagrees with their number, say so explicitly.
- If an initiative is clearly XL with many unknowns, say so early rather than running to completion on a verdict that was obvious in Phase 1.
- Tone is methodical and neutral throughout. The goal is clarity, not negotiation.
