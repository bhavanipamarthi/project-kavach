# Network Attack Chain (Hancitor + Cobalt Strike)

```mermaid
sequenceDiagram
    participant Attacker
    participant Workstation
    participant C2 as C2 Server
    participant Internal as Internal Servers

    %% Attack Flow
    Attacker ->> Workstation: 1. Deliver Hancitor Malware
    Workstation ->> C2: 2. C2 Beaconing (HTTP/DNS)
    C2 ->> Workstation: 3. Deploy Cobalt Strike Beacon
    Workstation ->> Internal: 4. Lateral Movement + Credential Dumping
    Workstation ->> C2: 5. Data Exfiltration

    Note over Attacker,Internal: Observed in PCAP Analysis
