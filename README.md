# Project KAVACH - Meridian FinServe Security Assessment

**Sprint 2-3 Combined Engagement**  
**IIT Roorkee × Futurense AI Clinic**  
**Two-Surface Security Assessment**: Network Forensics + Web Application Security

---

## 📋 Project Overview

**Project KAVACH** is a comprehensive security assessment conducted for **Meridian FinServe** (fictional client). It demonstrates real-world cybersecurity skills across two critical attack surfaces:

- **Network Forensics** – Analysis of malicious PCAP traffic (Hancitor + Cobalt Strike)
- **Web Application Security** – Vulnerability assessment and exploitation of DVWA + OWASP Juice Shop

The project was completed as part of the **PG Certification in AI-Enabled Cybersecurity** at Futurense AI Clinic.

## 👥 Team

| Role                  | Name            |
|-----------------------|-----------------|
| **Scrum Master**      | Bhavani        |
| **Network Analyst**   | Vinod          |
| **Defense Analyst**   | Vignesh        |
| **AppSec Engineer**   | Priya          |
| **GitHub Lead**       | Abhishek M     |

## 🚀 Quick Start

### Prerequisites
- Docker Desktop
- Git
- 16GB RAM (recommended)

### Setup (Under 5 Minutes)

```bash
# 1. Clone the repository
git clone https://github.com/bhavanipamarthi/project-kavach.git
cd project-kavach

# 2. Start the vulnerable applications
docker compose up -d

# 3. Verify environment
./verify.sh

Access Points:

DVWA: http://localhost:8085 (admin / password)
Juice Shop: http://localhost:4280

📁 Repository Structure
textproject-kavach/
├── deliverables/           # Final reports and executive deliverables
├── diagrams/               # Architecture and threat model diagrams
├── network/                # PCAP analysis, triage scripts, IOCs
├── web/                    # Web app vulnerability reports
├── webapp/                 # Application source and configs
├── synthesis/              # Joint deliverables (Threat Model, Defense-in-Depth, Exec Readout)
├── prompts/                # LLM prompts used during the project
├── retro.md                # Team retrospective
├── TEAM_SETUP.md           # Team onboarding guide
├── verify.sh               # Environment verification script
└── docker-compose.yml
🎯 Deliverables Summary
Workstream A – Network Forensics

PCAP analysis (Hancitor/Cobalt Strike C2 traffic)
Triage notes, hypotheses, and Indicators of Compromise (IOCs)
Network architecture diagrams

Workstream B – Web Application Security

5+ OWASP Top 10 vulnerabilities demonstrated
Exploitation walkthroughs (DVWA & Juice Shop)
Remediation recommendations

Workstream C – Synthesis

Joint Threat Model
Defense-in-Depth strategy
Executive Readout (for C-level stakeholders)

✅ Status
Complete — Fully reproducible using only free and open-source tools.
