# Hypothesis-Driven Analysis - Workstream A.3

**PCAP**: 2021-05-13-Hancitor-traffic-with-Ficker-Stealer-and-Cobalt-Strike.pcap

## Competing Hypotheses

### Hypothesis 1: Command & Control (C2) Beaconing (Primary)
**Description**: The periodic outbound traffic represents malware phoning home to a C2 server.  
**What would confirm**: Consistent timing, matching JA3 fingerprints, suspicious domains/IPs, low data volume per connection.  
**What would refute**: Traffic matches known legitimate update services.  
**Verdict**: **Confirmed** - Strong evidence from periodic beacons, consistent fingerprints, and known malicious infrastructure.

### Hypothesis 2: Legitimate Administrative Activity / Updates
**Description**: The traffic is caused by scheduled updates, monitoring agents, or admin tools.  
**What would confirm**: Known benign domains, standard user-agents, signed binaries.  
**What would refute**: Use of DGA domains, non-standard ports, or malware-specific patterns.  
**Verdict**: **Refuted** - Traffic patterns do not match legitimate update services.

### Hypothesis 3: Data Exfiltration via DNS Tunnel
**Description**: Attackers are using DNS queries to tunnel and exfiltrate data.  
**What would confirm**: Abnormally large DNS responses, high volume of TXT records.  
**What would refute**: Low volume and standard query types.  
**Verdict**: **Partially Supported** - Some suspicious DNS activity observed, but primary vector appears to be HTTPS beaconing.

## Conclusion
The most credible scenario is **initial compromise leading to C2 beaconing**, with potential for data exfiltration and lateral movement. This aligns with the anomalous east-west and outbound traffic reported by the SOC.

---
**Linked to IOCs and Architecture recommendations.**
