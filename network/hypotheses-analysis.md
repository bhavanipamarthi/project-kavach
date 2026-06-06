# Hypothesis-Driven Analysis - Workstream A.3

**PCAP Chosen**: 2021-05-13-Hancitor-traffic-with-Ficker-Stealer-and-Cobalt-Strike.pcap

## Competing Hypotheses

### Hypothesis 1: Command & Control (C2) Beaconing
**What would confirm it**: Periodic outbound connections, consistent JA3 fingerprints, suspicious domains/IPs.  
**What would refute it**: Traffic to known legitimate services.  
**Verdict**: **Confirmed** - Strong matching patterns observed.

### Hypothesis 2: Legitimate Administrative / Update Traffic
**What would confirm it**: Standard user-agents, known benign domains.  
**What would refute it**: Use of malware-specific infrastructure.  
**Verdict**: **Refuted**

### Hypothesis 3: DNS Tunnel Data Exfiltration
**What would confirm it**: High volume of unusual DNS TXT records.  
**What would refute it**: Low volume and normal query patterns.  
**Verdict**: **Partially Supported**

**Final Conclusion**: The traffic is most consistent with malware C2 beaconing, aligning with the SOC's report of anomalous east-west and outbound activity.

---
Linked to: triage-notes.md and iocs.csv
