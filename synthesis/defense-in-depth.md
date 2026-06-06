# Defense-in-Depth Proposal - Workstream C.2

**Project KAVACH** | Meridian FinServe Security Assessment

## Layered Security Controls

This proposal is built directly from findings in **Workstream A (Network)** and **Workstream B (Web App)**.

### 1. Identity & Access Management
- **Control**: Enforce MFA on all portals + SSO (SAML/OIDC)
- **Motivation**: Addresses Broken Authentication (F04) and weak session management
- **Effort**: Medium
- **Trade-off**: Slight increase in user friction, but significantly reduces account takeover risk

### 2. Perimeter Defense
- **Control**: Egress filtering + DNS Firewall + Web Application Firewall (WAF)
- **Motivation**: Blocks C2 beaconing and suspicious outbound traffic observed in PCAP (Workstream A)
- **Effort**: Medium
- **Trade-off**: May block some legitimate API calls initially (requires tuning)

### 3. Network Segmentation
- **Control**: East-West micro-segmentation + Jump hosts for server access
- **Motivation**: Limits lateral movement seen in PCAP and contains web server compromise
- **Effort**: Large
- **Trade-off**: Higher complexity and potential impact on legacy applications

### 4. Application Layer
- **Control**: Parameterized queries, Output encoding + CSP, Proper authorization checks
- **Motivation**: Directly remediates SQLi, Stored XSS, and IDOR findings (Workstream B)
- **Effort**: Small
- **Trade-off**: Minimal — improves code quality

### 5. Data Protection
- **Control**: Tokenization of sensitive data + Encryption at rest
- **Motivation**: Reduces impact of successful data exfiltration (T1 & T3 in threat model)
- **Effort**: Medium
- **Trade-off**: Performance overhead on database queries

### 6. Observability
- **Control**: Network Security Monitoring (Zeek/Suricata) + SIEM with baseline alerting
- **Motivation**: Early detection of anomalies like those in the 72-hour PCAP window
- **Effort**: Medium
- **Trade-off**: Requires tuning to reduce alert fatigue

### 7. Response & Recovery
- **Control**: Incident Response Playbooks + Regular tabletop exercises
- **Motivation**: Faster containment of cross-surface attacks
- **Effort**: Small
- **Trade-off**: Ongoing training cost

## Implementation Roadmap

| Priority | Layer | Control | Timeline | Owner |
|----------|-------|---------|----------|-------|
| High     | App   | SQLi + XSS fixes | 2 weeks | Dev Team |
| High     | Perimeter | IOC blocking + WAF | 3 weeks | SecOps |
| Medium   | Segmentation | Micro-segmentation | 6-8 weeks | Infrastructure |
| Medium   | Identity | MFA rollout | 4 weeks | IT |

**Total Estimated Effort**: Mix of Quick Wins and Strategic Projects.

---
**This proposal directly maps findings to actionable, funded controls.**
