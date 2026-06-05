# LLM Prompt Log - Bhavani

# LLM Prompt Log - Bhavani
**Course:** Post Graduation Certificate Program In AI/GenAI Powered Cybersecurity - IIT Roorkee
**Student:** Bhavani
**Last Updated:** 2026-06-05

---

## Prompt 1: Docker Setup for Web Security Labs

| Field | Details |
|-------|---------|
| **Date** | 2026-06-05 |
| **LLM Tool** | ChatGPT |
| **Context** | Setting up vulnerable web applications for security testing |
| **Prompt** | "Help me set up Docker for DVWA and Juice Shop" |
| **LLM Response** | Provided docker-compose.yml configuration with both services |
| **What I did** | - Created docker-compose.yml file<br>- Changed DVWA port from 80 → 8085<br>- Changed Juice Shop port from 3000 → 4280<br>- Ran `docker-compose up -d` |
| **Issues/Blockers** | None yet - setup successful |
| **Screenshots/Code** | [Add if applicable] |
| **Next Steps** | Verify both apps are accessible at localhost:8085 and localhost:4280 |

---

## Prompt 2: TShark PCAP Analysis Script

| Field | Details |
|-------|---------|
| **Date** | 2026-06-05 |
| **LLM Tool** | ChatGPT |
| **Context** | Need automated script for malware PCAP triage |
| **Prompt** | "Need tshark script for PCAP analysis to extract HTTP traffic" |
| **LLM Response** | Provided bash script with tshark commands for HTTP filtering |
| **What I did** | - Created `network/scripts/1_triage_pass.sh`<br>- Script extracts: timestamps, source/dest IPs, HTTP URIs |
| **Issues/Blockers** | ⚠️ Script requires tshark (not installed by default on Ubuntu) |
| **Resolution** | Installed tshark: `sudo apt install tshark -y`<br>Granted non-root permissions during install |
| **Code Snippet** | ```bash
tshark -r malware.pcap -Y "http" -T fields \
  -e frame.time -e ip.src -e ip.dst -e http.request.full_uri
``` |
| **Next Steps** | Test script with sample pcap from malware-traffic-analysis.net |

---

## Prompt 3: PCAP File Permission Issues

| Field | Details |
|-------|---------|
| **Date** | 2026-06-05 |
| **LLM Tool** | ChatGPT |
| **Context** | TShark couldn't read pcap file due to permission denied errors |
| **Prompt** | "tshark error: The file doesn't exist / permission denied / not a capture file" |
| **LLM Response** | Provided troubleshooting steps including sudo ownership fixes, using /tmp vs home directory, tcpdump alternatives |
| **What I did** | - Used `sudo tcpdump -i lo -c 10 -w ~/captures/test.pcap`<br>- Fixed permissions with `sudo chown bhavani:bhavani`<br>- Switched from loopback to real interface (wlp2s0) |
| **Issues/Blockers** | - Empty pcap file initially<br>- Permission denied on /tmp files<br>- Loopback traffic not recognized as HTTP |
| **Resolution** | Captured on active interface wlp2s0 instead of loopback |
| **Next Steps** | Successfully extract HTTP fields from pcap |

---

## Prompt 4: [Add your next prompt here]

| Field | Details |
|-------|---------|
| **Date** | 2026-06-05 |
| **LLM Tool** | [ChatGPT / Claude / Gemini] |
| **Context** | [What problem were you solving?] |
| **Prompt** | [Your exact or approximate prompt] |
| **LLM Response** | [Summary of what the LLM provided] |
| **What I did** | [Actions taken based on the response] |
| **Issues/Blockers** | [Any problems encountered] |
| **Resolution** | [How you fixed them, if applicable] |
| **Next Steps** | [What's remaining] |

---

## Quick Stats
| Metric | Count |
|--------|-------|
| Total Prompts | 3 |
| Successful | 3 |
| Issues Resolved | 2 |
| Issues Pending | 0 |

---

## Lessons Learned
1. **Always check prerequisites** - TShark needs to be installed before running scripts
2. **Document errors immediately** - Makes troubleshooting faster
3. **Permission matters** - Use `~/captures/` instead of `/tmp/` for pcap files to avoid permission issues
4. **Interface selection** - Loopback (lo) may not show HTTP traffic; use active interface (wlp2s0/eth0)
5. **Save working commands** - The tshark filter syntax is worth keeping as a template

---

## Useful Commands Reference
```bash
# Install tshark
sudo apt install tshark -y

# Capture HTTP traffic on active interface
sudo tcpdump -i wlp2s0 -c 20 -w ~/captures/http.pcap

# Extract HTTP fields from pcap
tshark -r ~/captures/http.pcap -Y "http" -T fields \
  -e frame.time -e ip.src -e ip.dst -e http.request.full_uri

# Fix permissions on captured files
sudo chown $USER:$USER ~/captures/*.pcap
