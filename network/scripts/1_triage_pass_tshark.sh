#!/bin/bash
PCAP="$1"
if [ -z "$PCAP" ]; then
    echo "Usage: ./1_triage_pass.sh <path-to.pcap>"
    exit 1
fi

BASE=$(basename "$PCAP" .pcap)
OUTPUT_DIR=$(dirname "$PCAP")

echo "[*] Analyzing $PCAP..."

tshark -r "$PCAP" -q -z io,phs > "$OUTPUT_DIR/${BASE}_protocols.txt"
tshark -r "$PCAP" -T fields -e ip.src -e ip.dst | grep -Eo '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' | sort | uniq -c | sort -nr > "$OUTPUT_DIR/${BASE}_top_ips.txt"
tshark -r "$PCAP" -Y "dns.qry.name" -T fields -e dns.qry.name | sort -u > "$OUTPUT_DIR/${BASE}_domains.txt"

echo "[+] Outputs saved to $OUTPUT_DIR/${BASE}_*.txt"
