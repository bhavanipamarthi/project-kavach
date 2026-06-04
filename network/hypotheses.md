# Workstream A.3: Hypothesis-Driven Deep Dive

**PCAP**: 2021-05-13-Hancitor-traffic-with-Ficker-Stealer-and-Cobalt-Strike.pcap
**Analyst**: [Your Name]

---

## Hypothesis 1: Initial Infection via Malicious Document Download

### What would confirm this hypothesis:
- HTTP GET request to a suspicious domain delivering a malicious payload (e.g., .doc, .docm)
- Subsequent DNS queries for additional domains
- Process creation events (if available) showing Office application launching script interpreters

### What would refute this hypothesis:
- No HTTP traffic containing Office documents
- All downloads hash to known legitimate software
- Traffic pattern matches normal user browsing behavior

### Evidence Found:
[You'll fill this in after analyzing the PCAP]

**Packet ranges**: e.g., frames 4500-5200
**Key indicators**: 
- URI: /invoice.doc
- Source IP: 192.168.1.105 → Destination: 185.130.5.253

### Verdict: [CONFIRMED / REFUTED / INCONCLUSIVE]
**Confidence**: High / Medium / Low
**Reasoning**: [2-3 sentences explaining your conclusion]

---

## Hypothesis 2: Cobalt Strike C2 Beaconing

### What would confirm this hypothesis:
- Periodic HTTPS traffic to the same destination at consistent intervals (e.g., every 60 seconds)
- JA3/JA3S fingerprints matching known Cobalt Strike patterns
- Response sizes following typical beacon patterns (e.g., small POST requests with varied response lengths)

### What would refute this hypothesis:
- No periodic traffic patterns detected
- Traffic matches known legitimate CDN or API endpoints
- JA3 fingerprints associated with legitimate software

### Evidence Found:
[Fill after analysis]

**Packet ranges**: 
**Beacon interval**: seconds
**Destination**: IP/domain

### Verdict: [CONFIRMED / REFUTED / INCONCLUSIVE]
**Confidence**: 
**Reasoning**:

---

## Hypothesis 3: Data Exfiltration via DNS Tunneling

### What would confirm this hypothesis:
- Long DNS queries with subfields containing encoded data
- High volume of TXT or MX record requests
- Unusually large DNS response packets

### What would refute this hypothesis:
- DNS traffic consistent with normal resolution patterns
- No TXT/AAAA/MX queries to suspicious domains
- Query lengths under 50 characters (normal range)

### Evidence Found:
[Fill after analysis]

**Packet ranges**:
**Suspicious domains**:
**Encoded patterns observed**:

### Verdict: [CONFIRMED / REFUTED / INCONCLUSIVE]
**Confidence**: 
**Reasoning**:

---

## Summary Table

| Hypothesis | Verdict | Confidence | Key Evidence |
|------------|---------|------------|--------------|
| Malicious document download | | | |
| Cobalt Strike beaconing | | | |
| DNS tunneling exfiltration | | | |

**Overall assessment**: [One paragraph synthesizing what the traffic actually represents]
