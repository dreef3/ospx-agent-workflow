# Design: [Change Title]

<!-- Only create this file when ≥1 of these applies:
     - Cross-cutting change or new architectural pattern
     - New external dependency or significant data model changes
     - Security, performance, or migration complexity
     - Ambiguity needing upfront technical decisions -->

## Context

<!-- Background, current state, constraints, stakeholders. -->

## Goals / Non-Goals

**Goals:**
-

**Non-Goals (explicitly out of scope):**
-

## Decisions

<!-- Key technical choices.  For each: state what was chosen, why, and what
     alternatives were considered. -->

### Decision: [Name]

**Chosen:** [approach]

**Rationale:** [why]

**Alternatives considered:**
- [alternative A] — rejected because [reason]
- [alternative B] — rejected because [reason]

## Security Threat Model

<!-- Always required.  Complete even for "small" changes — small changes
     introduce large vulnerabilities. -->

### Trust Boundaries

<!-- Where does untrusted data enter the system? -->

| Boundary        | Untrusted Input          | Control in Place              |
|-----------------|--------------------------|-------------------------------|
| [e.g., HTTP API] | user-supplied JSON body  | schema validation + sanitise  |

### Valuable Assets

<!-- PII, credentials, payment data, session tokens, … -->

-

### STRIDE Analysis

| Threat             | Surface                  | Severity | Mitigation                  |
|--------------------|--------------------------|----------|-----------------------------|
| Spoofing           | [describe]               | [H/M/L]  | [control]                   |
| Tampering          | [describe]               | [H/M/L]  | [control]                   |
| Repudiation        | [describe]               | [H/M/L]  | [control]                   |
| Information Disclosure | [describe]           | [H/M/L]  | [control]                   |
| Denial of Service  | [describe]               | [H/M/L]  | [control]                   |
| Elevation of Privilege | [describe]           | [H/M/L]  | [control]                   |

### Requires Explicit Approval Before Implementation

<!-- New auth flows, sensitive data storage, external service integrations,
     CORS changes, file upload changes. -->

- [ ] [item requiring approval]

## Risks / Trade-offs

| Risk                         | Impact | Mitigation                    |
|------------------------------|--------|-------------------------------|
| [risk description]           | [H/M/L] | [mitigation strategy]        |

## Migration Plan

1. [Step 1]
2. [Step 2]

**Rollback strategy:** [how to revert if something goes wrong]

## Open Questions

<!-- Unresolved decisions to close before coding starts. -->

- [ ] [question] — owner: [name] — due: [date]
