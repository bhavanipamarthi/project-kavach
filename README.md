# Project Kavach

[![Status](https://img.shields.io/badge/status-active-success.svg)](https://github.com/bhavanipamarthi/project-kavach)
[![Docker](https://img.shields.io/badge/docker-compose_v2.20+-blue.svg)](https://docs.docker.com/compose/)
[![License](https://img.shields.io/badge/license-MIT-lightgrey.svg)](LICENSE)
[![Security](https://img.shields.io/badge/security-penetration%20testing-red.svg)](https://owasp.org/)

> Production-ready security assessment lab demonstrating network forensics, web application vulnerabilities, and defense-in-depth strategies.

## 📋 Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Quick Start](#quick-start)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Access Points](#access-points)
- [Project Structure](#project-structure)
- [Deliverables](#deliverables)
- [Testing](#testing)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)

## Overview

Project Kavach is a comprehensive security assessment environment that demonstrates:
- Network forensics and traffic analysis (Hancitor/Cobalt Strike)
- OWASP Top 10 web application vulnerabilities
- Defense-in-depth security strategies
- Executive-level security reporting

## Architecture
┌─────────────────────────────────────────────────────────────┐
│ Client Machine │
│ http://localhost:8085 │
│ http://localhost:4280 │
└─────────────────────┬───────────────────┬───────────────────┘
│ │
┌───────▼───────┐ ┌───────▼───────┐
│ DVWA │ │ Juice Shop │
│ Port: 8085 │ │ Port: 4280 │
└───────────────┘ └───────────────┘
│ │
┌───────▼───────────────────▼───────┐
│ Docker Network (bridge) │
└────────────────────────────────────┘


## Quick Start

```bash
# Clone the repository
git clone https://github.com/bhavanipamarthi/project-kavach.git
cd project-kavach

# Start the vulnerable applications
docker compose up -d

# Verify the environment
./verify.sh

Prerequisites
Requirement	Minimum Version	Installation Command
Docker Engine	20.10+	Docker Installation Guide
Docker Compose	2.20+	Included with Docker Desktop
Bash	5.0+	Pre-installed on Linux/macOS
curl	7.68+	sudo apt install curl (Ubuntu/Debian)
Resource Requirements

    CPU: 2+ cores

    RAM: 4GB minimum (8GB recommended)

    Disk: 5GB free space

    OS: Linux, macOS, or Windows (with WSL2)

Installation

1. Clone the Repository
git clone --depth 1 https://github.com/bhavanipamarthi/project-kavach.git
cd project-kavach

2. Start Services

# Start both containers
docker compose up -d

# View logs (optional)
docker compose logs -f

3. Verify Installation

# Make verification script executable
chmod +x verify.sh

# Run environment check
./verify.sh

Expected output:

✅ All core checks passed! Project KAVACH environment looks good.

Access Points
Service	URL	Credentials	Purpose
DVWA	http://localhost:8085	admin / password	Web vulnerability testing
Juice Shop	http://localhost:4280	Register new user	OWASP Top 10 practice
DVWA Configuration

After logging into DVWA:

    Navigate to DVWA Security tab

    Set security level to low for vulnerability testing

    Start practicing SQLi, XSS, and file upload attacks

Project Structure
project-kavach/
├── deliverables/           # Final reports and executive deliverables
├── diagrams/               # Architecture and threat model diagrams
├── network/                # PCAP analysis, triage scripts, IOCs
│   └── report.md          # Network forensics findings
├── web/                    # Web application vulnerability reports
├── webapp/                 # Application source code and configs
├── synthesis/              # Joint deliverables
│   ├── threat-model.md    # Risk assessment
│   ├── defense-in-depth.md # Security strategy
│   └── exec-readout.md    # C-level presentation
├── prompts/                # LLM prompts used during the project
├── retro.md                # Team retrospective
├── TEAM_SETUP.md           # Team onboarding guide
├── verify.sh               # Environment verification script
└── docker-compose.yml      # Container orchestration

Deliverables
Workstream A – Network Forensics

    PCAP analysis of Hancitor/Cobalt Strike C2 traffic

    Triage notes and hypotheses

    Indicators of Compromise (IOCs)

    Network architecture diagrams

Location: network/report.md
Workstream B – Web Application Security

    5+ OWASP Top 10 vulnerabilities demonstrated

    Exploitation walkthroughs (DVWA & Juice Shop)

    Remediation recommendations

    Security testing methodology

Location: webapp/report.md
Workstream C – Security Synthesis

    Joint Threat Model (STRIDE/LINDDUN)

    Defense-in-Depth strategy

    Executive Readout for C-level stakeholders

Location: synthesis/

Testing
Manual Testing
# Test DVWA endpoint
curl -I http://localhost:8085/login.php

# Test Juice Shop health endpoint
curl http://localhost:4280/api/health

# Check container health
docker compose ps

Automated Verification
# Run full environment validation
./verify.sh

# Check specific components
docker compose logs dvwa
docker compose logs juice-shop

Security Testing Commands
# SQL injection test (DVWA)
curl "http://localhost:8085/vulnerabilities/sqli/?id=1' OR '1'='1&Submit=Submit" \
  -b cookies.txt

# Directory enumeration
gobuster dir -u http://localhost:4280 -w /usr/share/wordlists/dirb/common.txt

# Network capture during testing
sudo tcpdump -i docker0 -w capture.pcap

Troubleshooting
Common Issue : Issue	Solution
Port already in use	Change ports in docker-compose.yml or stop conflicting services: sudo lsof -i :8085
Permission denied	Add user to docker group: sudo usermod -aG docker $USER (logout required)
Containers won't start	Check logs: docker compose logs and verify Docker is running
Verification script fails	Ensure containers are up: docker compose ps and wait 30 seconds after startup


Reset Environment
# Full cleanup
docker compose down -v
docker system prune -f

# Fresh start
docker compose up -d
./verify.sh

Debug Mode
# Run with debug output
bash -x verify.sh

# Access container shell
docker exec -it project-kavach-dvwa-1 /bin/bash
docker exec -it project-kavach-juice-shop-1 /bin/sh

# View real-time logs
docker compose logs -f --tail=100

Contributing

Development Workflow
# Create feature branch
git checkout -b feature/your-feature

# Make changes and commit
git add .
git commit -m "feat: add your feature"

# Run validation
./verify.sh

# Push and create PR
git push origin feature/your-feature

Commit Convention

    feat: New feature

    fix: Bug fix

    docs: Documentation

    test: Testing

    chore: Maintenance

License

This project is licensed under the MIT License - see the LICENSE file for details.
Acknowledgments

    OWASP Foundation for vulnerability research

    Docker for containerization platform

    Damn Vulnerable Web Application (DVWA) project

    OWASP Juice Shop project

Contact
Project Lead: Bhavani Pamarthi
Repository: github.com/bhavanipamarthi/project-kavach


