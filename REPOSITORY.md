# Repository Structure - Project KAVACH

This document provides a detailed map of the repository to help reviewers, team members, and future contributors quickly navigate all artifacts.

## Project Overview
**Project KAVACH** is a combined **Network Forensics** and **Web Application Security** assessment for the fictional client **Meridian FinServe**.  
It was completed as part of the **Futurense AI Clinic — PG Certification in AI-Enabled Cybersecurity** at IIT Roorkee.

## Full Repository Tree
project-kavach/
├── deliverables/              # Consolidated final reports and key artifacts
├── diagrams/                  # Architecture, threat models, and visual aids (Mermaid + exports)
├── network/                   # Network forensics workstream
│   ├── analysis/              # Tshark/Wireshark notes, timelines
│   ├── architecture/          # Network diagrams
│   ├── iocs/                  # Indicators of Compromise (CSV + Markdown)
│   ├── pcap/                  # Sample PCAPs (or .gitignore'd large files)
│   ├── reports/               # Detailed forensics report
│   ├── scripts/               # tcpdump, triage, extraction scripts
│   └── README.md
├── webapp/                    # Web Application Security workstream
│   ├── dvwa/                  # DVWA findings
│   ├── juice-shop/            # OWASP Juice Shop findings
│   ├── findings/              # Individual vulnerability PoCs (F01–F05)
│   ├── screenshots/           # Evidence screenshots
│   ├── patches/               # Code fixes & remediation
│   └── README.md
├── web/                       # SAST, dependency scanning, and web-related analysis
├── synthesis/                 # Cross-workstream synthesis
│   ├── threat-model.md        # Joint threat model
│   ├── defense-in-depth.md    # Layered security recommendations
│   ├── exec-readout.md        # Executive summary
│   └── exec-readout.pdf       # Polished PDF version
├── prompts/                   # LLM prompts used for report generation & analysis
├── reflections/               # Team reflections and retrospectives
├── deliverables/              # Final packaged outputs
├── diagrams/                  # All visual assets
├── .gitignore
├── LICENSE
├── README.md                  # ← You are here (high-level overview)
├── REPOSITORY.md              # ← This file
├── TEAM_SETUP.md
├── retro.md                   # Full project retrospective
├── docker-compose.yml         # Reproducible environment
├── verify.sh                  # Setup validation script
└── ...

## Purpose of Each Major Directory

| Directory          | Purpose |
|--------------------|-------|
| **deliverables/**  | Final consolidated PDFs, executive decks, and one-stop artifacts for submission |
| **diagrams/**      | All architecture, data flow, attack chain, and threat model diagrams (source + exported PNG/SVG) |
| **network/**       | Complete Hancitor/Cobalt Strike PCAP analysis, IOCs, timelines, and scripts |
| **webapp/**        | DVWA + Juice Shop vulnerability demonstrations, PoCs, screenshots, and remediations |
| **web/**           | SAST results, dependency checks, and additional web security artifacts |
| **synthesis/**     | Threat modeling, defense-in-depth strategy, and executive-level reporting |
| **prompts/**       | All LLM prompts used for analysis and report writing (great for reproducibility) |
| **reflections/**   | Individual and team learning, challenges faced, and lessons learned |

## How to Use This Repository

1. **Quick Exploration** — Start with `README.md`
2. **Deep Dive** — Use this `REPOSITORY.md`
3. **Reproduce Environment** — Run `docker-compose up -d` followed by `./verify.sh`
4. **Review Deliverables** — Check the `deliverables/` folder or individual workstream reports

## Contribution & Maintenance

- Follow the folder structure above
- Keep large binaries (PCAPs, screenshots) either in `.gitignore` or hosted externally
- Document any new tools/scripts in the relevant README
- See [`CONTRIBUTING.md`](CONTRIBUTING.md) for guidelines (if added later)

---

**Status**: Complete & Fully Reproducible with free/open-source tools only.

**Last Updated**: June 5th 2026
