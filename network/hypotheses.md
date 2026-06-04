# Workstream A.3: Hypothesis-Driven Deep Dive

**PCAP**: PhantomStealer infection (2026-01-30)
**Analyst**: Bhavani Pamarthi
**Date**: 2026-06-04

## Hypothesis 1: C2 Beaconing & Data Exfiltration

### What would confirm this hypothesis:
- Periodic traffic to suspicious external IP with consistent intervals
- Large data transfers following beacon requests
- TLS encrypted tunnels to C2 server

### What would refute this hypothesis:
- Traffic matches known legitimate service patterns
- No correlation between beacon intervals and data transfers

### Evidence Found:
- **C2 IP**: 185.27.134.154 (6,498 packets - highest volume in capture)
- **Beacon pattern**: Traffic spikes at seconds 4-5 (4,860 frames, 6.8M bytes)
- **Data exfil**: HTTP GET to /arquivo_2026*.txt (Portuguese for "archive")
- **IP discovery**: GET to icanhazip.com

**Packet ranges**: 3000-4000, 5000-6000
**Key indicators**: Domain scxzswx.lovestoblog.com, IP 185.27.134.154

### Verdict: CONFIRMED
**Confidence**: High
**Reasoning**: Large data transfers to suspicious domain with random subdomain pattern, combined with IP discovery, indicates active data theft.

---

## Hypothesis 2: Initial Infection via Malicious Download

### What would confirm this hypothesis:
- HTTP GET to a suspicious domain delivering executable/content
- User-Agent strings indicating automated download
- Sequential file requests (archive files)

### What would refute this hypothesis:
- All downloads are to legitimate software repositories
- Traffic matches normal browsing patterns

### Evidence Found:
- Sequential requests to arquivo_20260129190534.txt and arquivo_20260129190545.txt
- Random subdomain pattern (scxzswx.lovestoblog.com) - not legitimate
- 5-second difference between file requests

**Packet ranges**: Around second 4-6
**Downloaded files**: Two .txt files from suspicious domain

### Verdict: CONFIRMED
**Confidence**: Medium
**Reasoning**: Sequential file downloads from suspicious domain suggest staged payload delivery.

---

## Hypothesis 3: DNS Tunneling for C2 Communication

### What would confirm this hypothesis:
- Long/encoded DNS query names
- TXT record requests to suspicious domains
- High volume of DNS traffic

### What would refute this hypothesis:
- DNS queries are for legitimate domains
- Query patterns match normal resolution

### Evidence Found:
- DNS queries to exczx.com (random string domain)
- DNS to scxzswx.lovestoblog.com (random subdomain pattern)
- Limited DNS volume (not primary channel)

**Suspicious domains**: exczx.com, scxzswx.lovestoblog.com
**Query patterns**: Random alphanumeric subdomains

### Verdict: PARTIALLY CONFIRMED
**Confidence**: Low-Medium
**Reasoning**: Suspicious domains present but DNS volume low; likely used for initial resolution, not primary tunneling.

---

## Summary Table

| Hypothesis | Verdict | Confidence | Key Evidence |
|------------|---------|------------|--------------|
| C2 Beaconing & Exfiltration | CONFIRMED | High | 185.27.134.154 (6,498 packets), 6.8MB transfer at 4-5 sec |
| Malicious Download | CONFIRMED | Medium | Sequential file downloads from suspicious domain |
| DNS Tunneling | PARTIALLY CONFIRMED | Low-Medium | Suspicious domains exczx.com, lovestoblog.com |

**Overall assessment**: The PhantomStealer infection shows clear C2 beaconing to 185.27.134.154 with large data exfiltration (6.8MB at 4-5 seconds). The malware first discovers the victim's public IP via icanhazip.com, then exfiltrates data to scxzswx.lovestoblog.com. This matches the Meridian FinServe scenario of anomalous east-west and outbound traffic.
