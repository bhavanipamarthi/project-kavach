# Current Architecture - BEFORE Hardening
## Meridian FinServe Network Segment (As-Is)

### Security Gaps Identified (from PCAP analysis):
1. ❌ **No network segmentation** - Internal server 10.1.30.101 can directly reach internet
2. ❌ **No egress filtering** - Outbound connections to 185.27.134.154 (C2 server) succeeded
3. ❌ **Missing east-west inspection** - Lateral movement undetected
4. ❌ **No DNS filtering** - Queries to malicious domains (scxzswx.lovestoblog.com) resolved
5. ❌ **No TLS inspection** - Encrypted C2 traffic (TLSv1.2) invisible to security tools
6. ❌ **No outbound alerting** - 6.8MB data exfiltration at 4-5 seconds triggered no alerts
7. ❌ **Flat network** - Compromised host can reach any internal resource

### Mermaid Diagram:

` ` `mermaid
graph TB
    subgraph "Branch Offices (9 cities)"
        B1[Branch Router]
        B2[Branch Users<br/>No MFA]
    end
    
    subgraph "Data Center - Flat Network"
        subgraph "No Segmentation"
            WEB[Web Server<br/>Customer Portal]
            DB[(Database<br/>Unencrypted)]
            APP[App Server<br/>Internal Tools]
            COMPROMISED[Compromised Host<br/>10.1.30.101<br/><b>ACTIVE BREACH</b>]
        end
        FW[Firewall<br/>Allow All Outbound]
    end
    
    subgraph "Internet"
        C2[Malicious C2 Server<br/>185.27.134.154<br/>PhantomStealer]
        IPCHECK[icanhazip.com<br/>IP Discovery]
    end
    
    B1 --> FW
    B2 --> WEB
    WEB --> DB
    WEB --> APP
    COMPROMISED --> FW
    FW --> C2
    FW --> IPCHECK
    
    style COMPROMISED fill:#ff0000,color:white
    style C2 fill:#ff0000,color:white
    style FW fill:#ff9999
    style DB fill:#ff9999
` ` `

### Vulnerabilities Demonstrated in PCAP:
| Finding | Evidence from Analysis | Business Impact |
|---------|----------------------|----------------|
| No egress filtering | 6,498 packets to 185.27.134.154 | Data exfiltration undetected |
| No DNS filtering | DNS queries to exczx.com, lovestoblog.com | C2 communication successful |
| No network segmentation | Direct outbound from internal host | Lateral movement possible |
| No TLS inspection | TLSv1.2 Application Data (frames 8685-8688) | Encrypted C2 invisible |
| No data loss prevention | 6.8MB transfer in 1 second | Customer data theft |

*(Remove spaces between backticks - write as ```mermaid)*
