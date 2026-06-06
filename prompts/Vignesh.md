## Prompt 3
**Date:** $(date +%Y-%m-%d)
**Tool:** ChatGPT
**Prompt:** My tshark PCAP analysis script fails because tshark isn't installed. Write a bash script that checks if tshark is installed, installs it via apt if missing (with sudo), and then runs my existing analysis script. Include error handling if apt fails or if the user isn't sudo-enabled. Also add a function to verify the PCAP file exists and is readable before analysis.
**Response:** Provided a wrapper script with dependency checking, installation logic, and pre-flight validation.
**What I did:** Saved as `network/scripts/0_run_triage.sh`, made it executable with `chmod +x`, and tested on a sample PCAP.
**What went wrong:** Initially forgot to add `-y` flag to apt install for non-interactive mode, but fixed it after testing.
