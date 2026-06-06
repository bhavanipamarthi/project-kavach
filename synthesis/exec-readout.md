# Executive Readout: Security Assessment for Meridian FinServe

**Project Kavach**  
**Date:** 06/06/2026 
**Prepared by:** Bhavani Pamarthi , Vignesh , Priya , Abhishek and Vinod
**Classification:** Internal Use Only

---

## Executive Summary

Project Kavach was a controlled security assessment engagement designed to evaluate Meridian FinServe’s resilience against modern cyber threats, specifically focusing on **network-borne malware** and **web application vulnerabilities**.

The assessment successfully demonstrated realistic attack scenarios using industry-standard vulnerable applications (DVWA and OWASP Juice Shop) within an isolated Docker environment. Key findings include active Command-and-Control (C2) communication and multiple high-severity web vulnerabilities that could lead to data breaches, financial loss, and reputational damage if left unmitigated.

**Overall Risk Level:** **High**

---

## Key Findings

### 1. Network Forensics – Advanced Persistent Threat Simulation
- Identified Hancitor-style malware with Cobalt Strike C2 beaconing.
- Observed outbound encrypted traffic to suspicious infrastructure.
- **Business Impact:** Potential for data exfiltration, ransomware deployment, and lateral movement across the network.

### 2. Web Application Vulnerabilities (OWASP Top 10)
- Multiple critical vulnerabilities confirmed in web applications, including:
  - SQL Injection
  - Cross-Site Scripting (XSS)
  - Broken Access Control
  - Insecure File Uploads
  - Security Misconfiguration
- **Business Impact:** Attackers could steal customer data, compromise admin accounts, or achieve remote code execution.

### 3. Environment & Configuration Risks
- Weak container network isolation.
- Insufficient monitoring and logging for anomalous behavior.
- Lack of defense-in-depth controls.

---

## Risk Assessment

| Risk | Likelihood | Impact | Overall Risk | Primary Concern |
|------|------------|--------|--------------|-----------------|
| C2 Beaconing & Data Exfiltration | High | High | **Critical** | Intellectual Property & Customer Data |
| Web Application Compromise | High | High | **Critical** | Financial Fraud & Regulatory Violation |
| Lateral Movement via Network | Medium | High | High | Full Infrastructure Breach |
| Insufficient Monitoring | High | Medium | High | Delayed Detection & Response |

---

## Strategic Recommendations

### Immediate (0–30 days)
1. Implement network segmentation and strict egress filtering.
2. Deploy behavioral monitoring (e.g., Suricata, Zeek, or EDR solutions).
3. Conduct full web application penetration testing on production systems.

### Short-term (30–90 days)
1. Adopt **Defense-in-Depth** architecture:
   - Web Application Firewall (WAF)
   - Input validation & secure coding practices
   - Regular container image scanning
2. Establish formal Incident Response playbooks for C2 and web attacks.

### Long-term (90+ days)
- Implement Zero Trust principles.
- Continuous security awareness training.
- Regular red team exercises using environments like Project Kavach.

---

## Positive Observations
- Strong foundational Docker-based lab environment.
- Excellent documentation and reproducibility.
- Team demonstrated solid understanding of attack chains and mitigation strategies.

---

## Next Steps

1. Schedule a debrief session with technical and leadership teams.
2. Prioritize remediation of Critical risks.
3. Use Project Kavach as an internal training platform for blue team / SOC analysts.
4. Re-assess environment after implementing top recommendations.

---

**Conclusion**

The simulated attacks in Project Kavach clearly demonstrate that Meridian FinServe faces **material cyber risk** from both sophisticated malware and common web application weaknesses. However, with targeted investment in detection, prevention, and response capabilities, these risks can be reduced to acceptable levels.

This assessment highlights both the **threat landscape** and the **path forward** toward a more resilient security posture.

---
**Note:** This document is a high-level executive summary. Detailed technical findings, PoCs, and threat models are available in the full assessment report.
