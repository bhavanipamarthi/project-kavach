# Project KAVACH - Meridian FinServe Security Assessment

**Sprint 2-3 Combined Engagement** | IIT Roorkee × Futurense AI Clinic  
**Two-Surface Security Assessment**: Network Forensics + Web Application Security

## Team Members
- **Bhavani** - Scrum Master
- **Vinod** - Threat Researcher / Network Analyst
- **Vignesh** - Defense Analyst
- **Priya** - AppSec Engineer
- **Abhishek M** - GitHub Lead

## Project Overview
This engagement follows the official **PROJECT KAVACH** brief. It involves:
- **Workstream A**: Network Forensics on a public PCAP
- **Workstream B**: Web Application Security Assessment (DVWA + OWASP Juice Shop)
- **Workstream C**: Joint Threat Model + Defense-in-Depth + Executive Readout

## Chosen PCAP Analogue
**File**: `2021-05-13-Hancitor-traffic-with-Ficker-Stealer-and-Cobalt-Strike.pcap`  
**Source**: [malware-traffic-analysis.net](https://malware-traffic-analysis.net/2021/05/13/index.html)

**Justification**: Contains Command & Control (C2) beaconing, data exfiltration indicators, and lateral movement — strong match for the anomalous east-west and outbound traffic reported in the Meridian FinServe scenario.

## Test Environments
- DVWA (Damn Vulnerable Web Application)
- OWASP Juice Shop  
Both deployed via Docker.

## Repository Structure
├── network/              # Workstream A (Forensics)
├── webapp/               # Workstream B (Web Assessment)
├── synthesis/            # Workstream C (Synthesis)
├── prompts/              # LLM Prompt Logs
├── reflections/          # Individual Reflections
└── retro.md


**Status**: In Progress | All artifacts will be reproducible with free/open-source tools only.
