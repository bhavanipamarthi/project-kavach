# Network Forensics Report - Workstream A

**Project KAVACH** | Meridian FinServe Security Assessment

## Executive Summary
Analysis of the selected PCAP revealed clear indicators of **Command & Control (C2) beaconing** and potential data exfiltration from the server segment. This matches the anomalous east-west and outbound traffic reported by the SOC.

## Key Findings
1. **C2 Beaconing** - Periodic outbound connections to suspicious infrastructure (High Confidence)
2. **Suspicious DNS Activity** - Queries consistent with malware callback patterns
3. **Possible Lateral Movement** - Internal traffic anomalies observed
4. **Anomaly Duration** - Matches the 72-hour window described in the brief

## IOCs Summary
Refer to `network/iocs.csv` for the full machine-readable list.

## Architecture Recommendations
- **Before**: Flat network with no egress filtering (see `architecture/before.mmd`)
- **After**: Micro-segmentation + egress controls + jump hosts (see `architecture/after.mmd`)

## Confidence Levels
- C2 Beaconing: **High**
- Data Exfiltration: **Medium**
- Root Cause Isolation: **Medium-High**

**Conclusion**: The captured traffic is consistent with a compromised server phoning home. Immediate IOC blocking and network hardening are recommended.

---
**Artifacts**: triage-notes.md, hypotheses.md, iocs.csv, architecture diagrams
**Reproducible**: Yes, using tshark/Wireshark on the chosen public PCAP.
