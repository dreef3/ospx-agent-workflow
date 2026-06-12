Run a security audit of the current change.

## Framework: Always Required, Requires Approval, Never Acceptable

### Always Required (no exceptions)

- [ ] All external input validated and sanitised at system boundaries
- [ ] Parameterised queries / ORM — no string-interpolated SQL
- [ ] Output encoded to prevent XSS
- [ ] HTTPS enforced; no downgrade paths
- [ ] Passwords hashed with bcrypt/argon2 (never MD5/SHA1)
- [ ] Security headers set (CSP, X-Frame-Options, HSTS, etc.)
- [ ] LLM / AI-generated output treated as untrusted (same rules as user input)
- [ ] Tool / function call permissions scoped to minimum necessary
- [ ] Cross-tenant data excluded from AI prompts

### Requires Explicit Approval Before Merging

- [ ] New authentication flows or session management changes
- [ ] New storage of sensitive / PII data
- [ ] New external service integrations
- [ ] CORS policy changes
- [ ] File upload handling changes
- [ ] Changes to privilege escalation paths

### Never Acceptable (immediate block)

- Secrets committed to version control
- Sensitive data in logs
- `eval()` or equivalent with untrusted input
- Client-side validation as a security boundary
- Disabling security controls "temporarily"

## OWASP Top 10 Quick Check

| # | Risk | Check |
|---|------|-------|
| A01 | Broken Access Control | Auth check on every endpoint; no IDOR paths |
| A02 | Cryptographic Failures | Sensitive data encrypted at rest and in transit |
| A03 | Injection | Parameterised queries; input sanitisation |
| A04 | Insecure Design | Threat model in design.md |
| A05 | Security Misconfiguration | Secrets not in config files; debug off in prod |
| A06 | Vulnerable Components | Dependency audit clean |
| A07 | Auth Failures | Rate limiting; account lockout; MFA where relevant |
| A08 | Integrity Failures | Signed dependencies; CI/CD pipeline integrity |
| A09 | Logging Failures | Errors logged; PII not logged |
| A10 | SSRF | URL / redirect targets validated before fetching |

## Threat Modelling Checklist

1. Map trust boundaries: where does untrusted data enter?
2. Identify valuable assets: credentials, PII, payment data, session tokens.
3. Apply STRIDE to each boundary.
4. For each threat: is a control in place or planned?
5. Write abuse cases alongside use cases in specs.

## Output Format

```
## Security Review: [change title]

### Critical Findings
- [location]: [finding] — [recommended fix]

### Approval-Required Items
- [ ] [item] — status: [pending / approved by]

### Clean (no issues found)
- [axis]: [confirmation]

### Verdict
[ ] No security issues
[ ] Issues found — see Critical Findings
[ ] Requires approval for items listed above
```
