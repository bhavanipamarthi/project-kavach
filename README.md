# Project Kavach

[![Docker](https://img.shields.io/badge/Docker-Ready-2496ED?logo=docker)](https://www.docker.com)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)
[![Status](https://img.shields.io/badge/Status-Production_Ready-brightgreen)](https://github.com/bhavanipamarthi/project-kavach)

**Production-ready security assessment lab** demonstrating network forensics, web application vulnerabilities, and defense-in-depth strategies.

---

## 🚀 Quick Start

```bash
# 1. Clone the repository
git clone https://github.com/bhavanipamarthi/project-kavach.git
cd project-kavach

# 2. Start the vulnerable applications
docker compose up -d

# 3. Verify the environment
chmod +x verify.sh
./verify.sh

Expected output: 🎉 All core checks passed! Project Kavach environment is ready.

Table of Contents

Overview
Architecture
Prerequisites
Installation
Access Points
Project Structure
Deliverables
Testing
Troubleshooting
Contributing
License


Overview
Project Kavach is a comprehensive security assessment environment that demonstrates:

Network Forensics and traffic analysis (Hancitor/Cobalt Strike)
OWASP Top 10 web application vulnerabilities
Defense-in-Depth security strategies
Executive-level security reporting


Architecture
flowchart LR
    A[Client Machine] --- B[http://localhost:8085]
    A --- C[http://localhost:4280]
    B --- D[DVWA]
    C --- E[Juice Shop]
    D & E --- F[Docker Network<br/>kavach-network]

Prerequisites
Requirement,Minimum Version,Installation Command
Docker Engine,20.10+,Docker Installation
Docker Compose,2.20+,Included with Docker Desktop
Bash,5.0+,Pre-installed
curl / wget,Latest,sudo apt install curl wget

Resource Requirements:

CPU: 2+ cores
RAM: 4GB minimum (8GB recommended)
Disk: 5GB free
OS: Linux, macOS, or Windows + WSL2

Installation

1 Clone the repository:
git clone --depth 1 https://github.com/bhavanipamarthi/project-kavach.git
cd project-kavach

2 Start services:
docker compose up -d

3 Verify the environment:
chmod +x verify.sh
./verify.sh

Access Points
Service        URL                        Default Credentials        Purpose
DVWA           http://localhost:8085      admin / password            Web vulnerability testing
Juice Shop    http://localhost:4280       Register new user           OWASP Top 10 practice

DVWA Setup: Login → Go to DVWA Security tab → Set security level to low

Project Structure
project-kavach/
├── deliverables/           # Final reports & executive deliverables
├── diagrams/               # Architecture & threat model diagrams
├── network/                # PCAP analysis, IOCs, triage
├── web/                    # Web vulnerability reports
├── synthesis/              # Joint threat model & defense strategy
├── prompts/                # LLM prompts used
├── docker-compose.yml      # Container orchestration
├── verify.sh               # Environment validation
├── Makefile                # One-command shortcuts (coming soon)
├── CONTRIBUTING.md
└── README.md

Deliverables

Network Forensics: PCAP analysis, IOCs, timeline (see network/)
Web Application Security: 5+ OWASP Top 10 exploits with PoCs (see web/)
Security Synthesis: STRIDE threat model, defense-in-depth, executive readout (see synthesis/)

Testing
# Quick health checks
./verify.sh

# Manual tests
curl -I http://localhost:8085/login.php
curl http://localhost:4280/api/health

Troubleshooting
Issue                                        Solution
Port already in use                    docker compose down or change ports in docker-compose.yml
Containers won't start                 docker compose logsPermission deniedsudo usermod -aG docker $USER (then log out and back in)

Reset Environment:
docker compose down -v
docker compose up -d
./verify.sh

Contributing
See CONTRIBUTING.md for details.
License
This project is licensed under the MIT License - see the LICENSE file for details.

⚠️ Educational Purpose Only
This lab contains intentionally vulnerable applications. Never expose to the public internet.

Made with ❤️ by Bhavani Pamarthi, Priya, Vignesh, Vinod and Abhishek
Project Lead & Security Researcher
