# Network Triage Notes - Workstream A.2

**PCAP Chosen**: 2021-05-13-Hancitor-traffic-with-Ficker-Stealer-and-Cobalt-Strike.pcap  
**Source**: malware-traffic-analysis.net

## High-Level Triage Summary

### Protocols Observed
- DNS (high volume, suspicious queries)
- HTTPS/TLS (periodic beaconing on 443)
- HTTP (C2 check-ins)
- SMB (possible lateral movement)

### Key Observations
- Anomalous outbound traffic spikes every 2-5 minutes
- Consistent User-Agent and JA3 fingerprints
- East-West traffic suggesting internal reconnaissance
- Deviation from normal low-variance server segment traffic

### Commands Used
```bash
tshark -r capture.pcap -q -z conv,tcp -z conv,dns -z io,stat,300
