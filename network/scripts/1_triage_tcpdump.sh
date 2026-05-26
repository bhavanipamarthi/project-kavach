#!/bin/bash
# Triage pass using tcpdump (no permission issues)

PCAP="$1"
if [ -z "$PCAP" ]; then
    echo "Usage: ./1_triage_tcpdump.sh <path-to.pcap>"
    exit 1
fi

BASE=$(basename "$PCAP" .pcap)
OUTPUT_DIR=$(dirname "$PCAP")

echo "[*] Analyzing $PCAP with tcpdump..."

# 1. Packet summary (first 50 packets)
echo "[1/5] Getting packet summary..."
tcpdump -r "$PCAP" -n -c 50 > "$OUTPUT_DIR/${BASE}_packet_summary.txt"

# 2. Unique IP addresses
echo "[2/5] Extracting IP addresses..."
tcpdump -r "$PCAP" -n ip 2>/dev/null | grep -Eo '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' | sort -u > "$OUTPUT_DIR/${BASE}_unique_ips.txt"

# 3. Top talkers (IPs with most traffic)
echo "[3/5] Finding top talkers..."
tcpdump -r "$PCAP" -n ip 2>/dev/null | grep -Eo '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' | sort | uniq -c | sort -nr | head -20 > "$OUTPUT_DIR/${BASE}_top_talkers.txt"

# 4. DNS queries
echo "[4/5] Extracting DNS queries..."
tcpdump -r "$PCAP" -n udp port 53 2>/dev/null | grep "A?" | awk -F' ' '{for(i=1;i<=NF;i++) if($i=="A?") print $(i+1)}' | sort -u > "$OUTPUT_DIR/${BASE}_dns_queries.txt"

# 5. Protocol distribution
echo "[5/5] Protocol statistics..."
tcpdump -r "$PCAP" -n 2>/dev/null | awk '{print $2}' | cut -d. -f1 | sort | uniq -c | sort -nr > "$OUTPUT_DIR/${BASE}_protocol_stats.txt"

echo "[+] Complete! Outputs saved to $OUTPUT_DIR/${BASE}_*.txt"
echo ""
echo "Files created:"
ls -la "$OUTPUT_DIR/${BASE}_"*.txt 2>/dev/null
