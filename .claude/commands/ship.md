Pre-merge and pre-deploy checklist.

## Pre-Merge Gate

Run through review-checklist.md, then verify:

### Quality Gates
- [ ] Full test suite passes (run fresh — don't rely on cached results)
- [ ] Build succeeds with no type errors or lint violations
- [ ] All CRITICAL and IMPORTANT items in review-checklist.md resolved
- [ ] Performance baselines from test-plan.md not regressed
- [ ] No secrets in the diff (`git diff HEAD | grep -iE 'password|secret|token|key'`)

### Git Hygiene
- [ ] Commits are atomic — each addresses one logical change
- [ ] Commit messages explain WHY, not just what
  Format: `<type>: <short description>` (types: feat/fix/refactor/test/docs/chore)
- [ ] Refactoring is in a separate commit from feature work
- [ ] No force-push to shared branches
- [ ] `.gitignore` covers build artefacts and secrets

### Documentation
- [ ] Public API changes documented
- [ ] Architectural decisions documented in design.md or an ADR
- [ ] CHANGELOG updated if this is a user-facing change

### Deployment Readiness
- [ ] Feature flags configured if needed (gradual rollout)
- [ ] Migration plan from design.md reviewed
- [ ] Rollback plan is known and documented
- [ ] Monitoring / alerting in place for new critical paths
- [ ] On-call knows this is shipping

## Commit Format

```
feat: add CSV data export endpoint

Resolves the user request from #123.  Uses streaming to avoid loading
large datasets into memory.  Pagination is enforced server-side;
client receives chunks of ≤1000 rows per request.
```

Types:
- `feat` — new capability
- `fix` — bug fix
- `refactor` — code change with no behaviour change
- `test` — test additions or fixes
- `docs` — documentation only
- `chore` — build, tooling, dependency updates

## Red Flags (do not ship if any are true)

- Failing tests disabled or skipped
- "I'll fix it in the next commit"
- Build warnings ignored
- Manual testing skipped because "the tests cover it"
- Rollback plan is "re-deploy the previous version manually"
