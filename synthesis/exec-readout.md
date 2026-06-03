# Executive Readout - Project KAVACH

**Meridian FinServe Security Assessment**  
**Two-Surface Review** (Network + Web Application)  
**Date**: June 2026

---

### Key Findings

**1. Network Surface**  
Our analysis of the 72-hour captured traffic revealed clear signs of **Command & Control (C2) beaconing** and suspicious outbound activity from the server segment.  
**Risk**: Attacker could be exfiltrating customer data or preparing for lateral movement.

**2. Web Application Surface**  
The customer and partner portals contain critical weaknesses including:
- SQL Injection
- Broken Access Control (IDOR)
- Stored Cross-Site Scripting (XSS)
- Weak Authentication

**3. Combined Risk**  
These two surfaces are connected. A web vulnerability can easily lead to the type of network behavior observed in the PCAP — creating a high-impact attack path to sensitive borrower and merchant data.

---

### Business Impact
- Potential exposure of **180,000+ borrower records**
- Risk of merchant data theft and reputational damage
- Regulatory exposure (RBI compliance implications)

---

### Recommendations (Prioritized)

| Priority | Recommendation | Expected Benefit | Effort |
|----------|----------------|------------------|--------|
| **High** | Immediately patch web vulnerabilities (SQLi, IDOR, XSS) + block IOCs from PCAP | Stops active attack paths | Low |
| **High** | Deploy MFA across all portals + WAF on perimeter | Prevents account takeover & C2 | Medium |
| **Medium** | Implement network segmentation (East-West controls) | Contains breaches | High |
| **Medium** | Improve monitoring with baseline anomaly detection | Early warning of threats | Medium |

---

### Ask to the Board

Approve funding and resources for the **Top 3 recommendations** within the next quarter.  
This will significantly reduce the risk of a material breach and demonstrate strong security governance.

**Prepared by**: Project KAVACH Team  
**Status**: Ready for Board Review

---
**One-Page Summary** — Designed for non-technical leadership.
