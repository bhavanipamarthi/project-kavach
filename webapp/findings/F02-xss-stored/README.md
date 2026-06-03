# Finding F02 - Stored XSS (OWASP A03: Injection)

**Vulnerable Application**: OWASP Juice Shop

**Attack Type**: Stored Cross-Site Scripting

**Payload**:
```html
<script>alert('XSS')</script>

Reproduction:

Log in as a normal user
Submit a review containing the above payload
Payload executes for other users viewing the review

Root Cause: User input stored and displayed without output encoding.
Business Impact at Meridian FinServe:
Attacker can steal session cookies of merchants or customers, leading to account takeover and fraudulent transactions.
Remediation:

Output encoding (escape HTML)
Implement Content Security Policy (CSP)
Input sanitization

Status: Remediated with code-level fix.


---

#### 2. Create **F03 - IDOR**

**Filename**: `webapp/findings/F03-idor/README.md`

Paste this content:

```markdown
# Finding F03 - IDOR (OWASP A01: Broken Access Control)

**Vulnerable Application**: OWASP Juice Shop

**Attack Type**: Insecure Direct Object Reference (IDOR)

**Payload / Attack**:
- Access: `/rest/user/1` or `/rest/user/2` (change user ID in URL)

**Reproduction Command**:
```bash
curl http://localhost:3000/rest/user/1

Root Cause: No proper authorization check on object access — user can view/modify other users' data by changing ID.
Business Impact at Meridian FinServe:
Attacker can view or modify other customers' loan statements, EMI details, or merchant reconciliation data.
Remediation:

Implement proper per-request authorization checks
Use indirect object references (UUIDs) instead of sequential IDs

Status: Fixed in remediation branch.




