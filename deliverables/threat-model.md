# Threat Model - Meridian FinServe

**Project KAVACH** | Sprint 2-3 Combined Assessment  
**Date**: June 2026  
**Version**: 1.0

## 1. Scope & Objectives
This threat model combines findings from:
- **Network Forensics** (Hancitor + Cobalt Strike activity)
- **Web Application Security** (DVWA + OWASP Juice Shop)

**Goal**: Identify key threats, map them to assets, and provide prioritized mitigation recommendations.

## 2. Assets (What We Protect)

- Customer financial data
- Internal banking applications
- Employee workstations & endpoints
- Network infrastructure (servers, firewalls)
- Web applications (public-facing)

## 3. Threat Actors
- **Organized Crime** (Financial malware campaigns — Hancitor)
- **Skilled Attackers** (Cobalt Strike operators)
- **Opportunistic Hackers** (Web vulnerabilities exploitation)
- **Insider Threats** (misconfiguration / weak access control)

## 4. Identified Threats

### From Web Application Assessment
- **SQL Injection** — High risk of data exfiltration and authentication bypass
- **Insecure Direct Object References (IDOR)** — Unauthorized access to sensitive records
- **Broken Access Control** — Privilege escalation
- **Cross-Site Scripting (XSS)** — Session hijacking
- **Security Misconfiguration** — Exposed debug info / default credentials

### From Network Forensics
- **C2 Beaconing** (Cobalt Strike) — Persistent remote access
- **Data Exfiltration** over HTTP/DNS
- **Malware Delivery** (Hancitor dropper)
- **Lateral Movement** within internal network

### Cross-Domain Threats
- Web compromise → Internal network foothold (via compromised user session)
- Credential harvesting from web apps → Used in network attacks
- Data exfiltration combining web + network vectors

## 5. STRIDE Threat Modeling Summary

| STRIDE Category     | Threat Examples                          | Likelihood | Impact | Risk Level |
|---------------------|------------------------------------------|------------|--------|------------|
| **Spoofing**        | Fake login pages, session hijacking      | Medium     | High   | High       |
| **Tampering**       | SQL Injection, data manipulation         | High       | High   | Critical   |
| **Repudiation**     | Weak logging                             | Medium     | Medium | Medium     |
| **Information Disclosure** | IDOR, data exfiltration             | High       | Critical | Critical |
| **Denial of Service** | Resource exhaustion attacks            | Low        | High   | Medium     |
| **Elevation of Privilege** | Privilege escalation via IDOR        | High       | Critical | Critical |

## 6. Attack Scenarios (High Priority)

1. **Web → Network Pivot**
   - Attacker exploits SQLi/IDOR → steals credentials → uses them to trigger malware download.

2. **Malware Campaign**
   - Hancitor delivers Cobalt Strike → C2 beaconing → data theft.

3. **Data Breach**
   - Combined web + network exfiltration of customer financial records.

## 7. Recommended Mitigations
- Implement proper input validation & prepared statements (SQLi)
- Enforce strict access controls & object-level authorization (IDOR)
- Network segmentation & egress filtering (C2)
- Endpoint Detection & Response (EDR)
- Regular security scanning & patching
- Logging & monitoring (SIEM)

## 8. Residual Risk & Monitoring
- Continuous monitoring of anomalous DNS/HTTP traffic
- Regular web vulnerability scans
- User awareness training

---

**References**:
- [Network Analysis](../network/report.md)
- [Web Application Findings](../webapp/report.md)
- [Defense-in-Depth Strategy](../synthesis/defense-in-depth.md)
- [Executive Readout](../synthesis/exec-readout.md)

**Status**: Complete
