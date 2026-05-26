# 🚀 Project KAVACH - Team Setup Guide

## Welcome Team!

This guide will get you up and running in **under 15 minutes**.

## Prerequisites

| Requirement | Check | Download Link |
|-------------|-------|---------------|
| Docker Desktop | ☐ | https://www.docker.com/products/docker-desktop/ |
| Git | ☐ | https://git-scm.com/downloads |
| 16GB RAM recommended | ☐ | - |
| 5GB free disk space | ☐ | - |

## Quick Setup (3 Steps)

### Step 1: Get the Project

**Option A - GitHub (recommended):**
```bash
git clone https://github.com/bhavanipamarthi/project-kavach.git
cd project-kavach
```

**Option B - ZIP file:**
1. Download `project-kavach-team.zip`
2. Extract it: `unzip project-kavach-team.zip`
3. Enter folder: `cd project-kavach`

### Step 2: Start the Web Applications

```bash
docker compose up -d
```

Wait 30 seconds for containers to initialize.

### Step 3: Verify Everything Works

```bash
./verify.sh
```

**Expected output:**
```
✅ DVWA is running on http://localhost:8085
✅ Juice Shop is running on http://localhost:4280
Environment check complete!
```

## Access the Targets

| Application | URL | Login Credentials |
|-------------|-----|-------------------|
| DVWA | http://localhost:8085 | admin/password |
| Juice Shop | http://localhost:4280 | Register new user |

## Troubleshooting

If `./verify.sh` fails, wait 30 seconds and try again.

For permission issues with tshark, use:
```bash
./network/scripts/1_triage_tcpdump.sh network/pcap/your-file.pcap
```
