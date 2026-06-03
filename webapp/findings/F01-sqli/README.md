# Finding F01 - SQL Injection (OWASP A03: Injection)

**Vulnerable Application**: DVWA (SQL Injection Lab)

**Attack Type**: SQL Injection

**Payload Progression**:
- Initial attempt: `1' OR '1'='1`
- Successful payload: `admin' --` or `1' UNION SELECT database(), user() --`

**Reproduction Command**:
```bash
curl "http://localhost:8080/vulnerabilities/sqli/?id=admin'%20--&Submit=Submit"

Root Cause:
Direct concatenation of user input into SQL queries without sanitization or parameterization.
Business Impact at Meridian FinServe:
An attacker could extract sensitive customer data (loan details, personal information of 180,000 borrowers), modify records, or delete data.
Remediation:

Use prepared statements / parameterized queries
Implement input validation and least privilege on database user

Status: Remediated in fix/sqli branch (code-level patch applied).
