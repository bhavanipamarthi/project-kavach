```markdown
# Network Forensics - Workstream A

**Part of Project KAVACH —Security Assessment**

This directory contains all artifacts related to the **Network Forensics** investigation of suspected Hancitor and Cobalt Strike command-and-control traffic.

## Objectives
- Perform triage and detailed analysis of provided PCAP files
- Identify Indicators of Compromise (IOCs)
- Reconstruct attacker timeline and techniques
- Document findings with clear evidence
- Support synthesis with defense recommendations

## Contents
network/
├── analysis/           # Detailed Wireshark/tshark notes and timelines
├── architecture/       # Network diagrams (Mermaid + exported images)
├── iocs/               # Extracted Indicators of Compromise
├── pcap/               # Sample / reference PCAP files (large files gitignored)
├── reports/            # Full forensics report
├── scripts/            # Automation and extraction scripts
└── README.md           # ← This file


## Key Deliverables

- [Main Network Report](../network/report.md) (or in `reports/`)
- [IOCs List](iocs/iocs.md)
- [Attack Timeline](analysis/timeline.md)
- [Architecture Diagrams](architecture/)

## Tools Used (All Open Source)
- Wireshark / tshark
- tcpdump
- Zeek (optional)
- CyberChef
- Python scripts for parsing

## Quick Analysis Workflow

```bash
# Example commands (run inside Docker or local environment)
cd network

# Basic PCAP info
tshark -r pcap/sample.pcap -z io,stat,0

# Extract HTTP objects
tshark -r pcap/sample.pcap --export-objects http,export/

# Filter suspicious traffic
tshark -r pcap/sample.pcap -Y "http.request or dns or smb"

