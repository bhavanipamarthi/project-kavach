**LLM Prompt**

What I asked DeepSeek:

    *"Analyze this PCAP file for Cobalt Strike beaconing patterns. I have a pcap called 'suspicious.pcap' - here's the tshark output of the first 50 packets. Identify indicators of Cobalt Strike based on known JA3 signatures, HTTP metadata, and beacon intervals. Focus on post-exploit HTTPS traffic to port 443. Provide specific evidence or say 'no Cobalt Strike detected'."*

*(I then pasted 50 lines of tshark -T json output)*
📌 Step 2: DeepSeek's Response (Initial)

DeepSeek said:

    "I cannot directly analyze a binary PCAP file, but based on your tshark JSON snippet:

        No clear JA3 hash matching known Cobalt Strike signatures (e.g., 72a589da586844d7f0818ce684948eea for default CS HTTPS stager)

        *HTTP User-Agent observed: 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)' - too common to be conclusive*

        *Beacon intervals appear irregular (2.1s, 5.4s, 12.8s, 3.2s) - not typical 60s default*

        *Missing '/jquery-3.3.1.min.js' or other known CS URI paths*

    Conclusion: Weak evidence of Cobalt Strike. Consider checking for SSL certificate issuer: 'Let's Encrypt' or self-signed with unusual CN."

📌 Step 3: What Went Wrong ❌
Problem	Why it happened
Too little data	Only first 50 packets - Cobalt Strike beaconing often starts after initial compromise (packets 200+)
Wrong protocol focus	I only showed HTTP, but modern CS uses HTTPS with encrypted metadata
No JA3S (server-side)	I provided client JA3 only - CS detection often relies on JA3S from the team server
Ignored DNS	CS often uses DNS A/AAAA queries for staging domain resolution before beaconing
Missing TCP reassembly	tshark JSON snippet didn't include reassembled SSL/TLS handshake details
False time assumption	I assumed CS always uses 60s beacon - but sleep can be jittered (e.g., sleep 5 with jitter 20%)
📌 Step 4: How I Corrected It 🔧
Correction 1: Expanded packet capture

I went back and extracted full conversation using better filters:
bash

# Extract ALL traffic to/from suspicious IPs
tshark -r suspicious.pcap -Y "ip.addr == 185.130.5.253 or ip.addr == 192.168.1.105" -T fields -e frame.time -e ip.src -e ip.dst -e tcp.stream -e tls.handshake.certificate -e http.user_agent -e dns.qry.name

Correction 2: Added JA3/JA3S fingerprinting
bash

# Extract JA3 fingerprints
tshark -r suspicious.pcap -Y "tls.handshake" -T fields -e ja3.hash -e ja3s.hash

Result found: JA3S f2caeadc7e3f9bdc9f5e7b4b7c8d9e0f - *known Cobalt Strike 4.5+ default certificate*
Correction 3: Looked for beacon math
python

# Quick Python check for periodic traffic
import pyshark
capture = pyshark.FileCapture('suspicious.pcap', display_filter='tls and ip.src==192.168.1.105')
timestamps = [float(pkt.sniff_timestamp) for pkt in capture]
diffs = [timestamps[i+1] - timestamps[i] for i in range(len(timestamps)-1)]
print(f"Avg beacon interval: {sum(diffs)/len(diffs):.2f}s")
# Output: Avg beacon interval: 58.34s ← CLASSIC CS DEFAULT

Correction 4: Checked for CS-specific URI patterns

Despite HTTPS encryption, CS leaves clues in SNI (Server Name Indication):
bash

tshark -r suspicious.pcap -Y "tls.handshake.extensions_server_name" -T fields -e tls.handshake.extensions_server_name

Found: cloud.cdn-azure.com - Not a real Microsoft domain (CS malleable profile)
Correction 5: DNS staging detection
bash

tshark -r suspicious.pcap -Y "dns.qry.name contains 'amazonaws' or dns.qry.name contains 'cloudfront'"

Found: d2c9x8k7l4m3n2.cloudfront.net - Resolves to same IP as HTTPS beacon → CS staging via CDN
📌 Step 5: Final Corrected Response to DeepSeek (What I Should Have Asked)

Improved Prompt:

    *"Analyze this PCAP for Cobalt Strike 4.5+ HTTPS beaconing. I'll provide:*

        Full tshark output with JA3S hashes

        Timestamps of all TLS flows from internal host 192.168.1.105 to external IPs

        DNS queries for staging domains

        Beacon interval math (calculated via Python)

    Specific indicators to check:

        JA3S: f2caeadc7e3f9bdc9f5e7b4b7c8d9e0f (CS default)

        *Beacon interval consistency (58-62s range)*

        SNI domains that are deceptive CDN names

        Post-ex GET/POST size patterns (small requests, large responses)

    Is this Cobalt Strike? If yes, extract the team server IP and any staging domains."

DeepSeek's Corrected Response:

    *"✅ Confirmed Cobalt Strike 4.5+ *

    Evidence:

        JA3S match: f2caeadc7e3f9bdc9f5e7b4b7c8d9e0f = Cobalt Strike default HTTPS certificate

        Beacon interval: 58.3s avg (jitter ±3s) - matches CS sleep 60 with 5% jitter

        SNI pattern: cloud.cdn-azure[.]com - known malleable profile ("azure" template)

        Request/response ratio: 450 bytes → 124KB response (CS tasking download)

    Team Server IP: 185.130.5.253 (port 443)
    Staging Domain: d2c9x8k7l4m3n2.cloudfront[.]net
    Beaconing Hosts: 192.168.1.105, 192.168.1.112

    Next steps: Extract RC4 key from memory dump of 192.168.1.105 to decrypt HTTPS traffic."*
