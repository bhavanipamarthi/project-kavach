# Network Triage Notes - Workstream A.2

**PCAP Chosen**: 2021-05-13-Hancitor-traffic-with-Ficker-Stealer-and-Cobalt-Strike.pcap  
**Source**: malware-traffic-analysis.net

## High-Level Inventory (Triage Pass)

### Protocols Observed
- **DNS**: High volume of queries (many to suspicious or DGA-like domains)
- **HTTPS/TLS**: Periodic beaconing on port 443
- **HTTP**: Some C2 check-ins
- **SMB**: Possible lateral movement attempts
- **Other**: TCP/UDP bursts, potential data exfiltration

### Top Talkers (Internal vs External)
- Internal server segment → Multiple external IPs (C2 infrastructure)
- Anomalous outbound traffic spikes every ~2-5 minutes

### Time Bounds
- Capture represents ~72-hour equivalent window of anomalous activity
- Baseline: Low-variance predictable flows turned into noisy periodic beacons

### Key Statistics (from tshark/Wireshark)
```bash
# Commands used:
tshark -r capture.pcap -q -z conv,tcp -z conv,dns -z io,stat,300
tshark -r capture.pcap -q -z http,treeObservations:

Observations:
Sudden increase in outbound connections to rare external IPs
Consistent User-Agent and JA3 fingerprints across sessions
DNS queries showing patterns consistent with C2 beaconing
East-West traffic suggesting possible internal reconnaissance

Baseline Characterization:
 Normal server segment traffic is low-volume, predictable (updates, monitoring). This window shows clear deviation.


Baseline Characterization: Normal server segment traffic is low-volume, predictable (updates, monitoring). This window shows clear deviation.

