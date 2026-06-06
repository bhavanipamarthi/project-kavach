# High-Level Architecture - Meridian FinServe

```mermaid
flowchart TD
    subgraph External["External Network"]
        Attacker[Attacker\nHancitor Dropper]
        Internet[Internet]
    end

    subgraph DMZ["DMZ / Public Services"]
        WebApp[Web Applications\nDVWA + Juice Shop]
    end

    subgraph Internal["Internal Network"]
        Workstations[Employee Workstations]
        Servers[Application Servers]
        Database[(Customer Database)]
    end

    Attacker -->|Malware Delivery| Workstations
    Attacker -->|Web Exploitation| WebApp
    WebApp -->|Data Exfiltration| Internet
    Workstations -->|C2 Beaconing| Internet
    Workstations -->|Lateral Movement| Servers
    Servers --> Database

    style Attacker fill:#ff4d4d,stroke:#333,color:#fff
    style WebApp fill:#4da6ff,stroke:#333,color:#fff
