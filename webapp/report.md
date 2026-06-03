# Web Application Security Report - Workstream B

**Project KAVACH** | Meridian FinServe Security Assessment

## Executive Summary
We successfully stood up DVWA and OWASP Juice Shop environments and demonstrated **five OWASP Top 10 (2021)** vulnerabilities, including the three mandatory ones. All findings are reproducible.

## Test Environment
- **Docker Compose**: `webapp/env/docker-compose.yml`
- **Applications**: DVWA (Port 8080) + OWASP Juice Shop (Port 3000)
- **Reproduction Time**: Under 10 minutes

## Key Findings

### Mandatory Findings
- **F01 - SQL Injection (A03)** → `webapp/findings/F01-sqli/README.md`
- **F02 - Stored XSS (A03)** → `webapp/findings/F02-xss-stored/README.md`
- **F03 - IDOR / Broken Access Control (A01)** → `webapp/findings/F03-idor/README.md`

### Additional Findings
- **F04 - Broken Authentication (A07)**
- **F05 - Security Misconfiguration (A05)**

## Remediation Summary
- Code-level fixes applied for at least 3 findings (Parameterized queries, Output encoding, Authorization checks)
- SAST scan (Semgrep) performed before & after remediation
- Significant reduction in findings post-fix

## Business Impact
These vulnerabilities could allow attackers to:
- Steal or modify customer loan data
- Hijack merchant sessions
- Escalate to full server compromise (linking to Network C2 activity)

**Conclusion**: The customer/partner portals are in a high-risk state. Immediate remediation is strongly recommended.

---
**Artifacts**: findings/ folder, docker-compose.yml, SAST reports (to be added)
**Reproducible**: Yes using provided docker environment.
