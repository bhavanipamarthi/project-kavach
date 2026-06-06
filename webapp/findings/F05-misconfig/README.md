# Finding F05 - Security Misconfiguration (OWASP A05)

**Vulnerable Application**: DVWA / Juice Shop

**Attack Type**: Exposed Debug Information / Default Credentials

**Evidence**:
- Error messages revealing stack traces
- Default admin credentials still active

**Root Cause**: 
Debug mode enabled in production, default configurations not hardened.

**Business Impact at Meridian FinServe**:
Attacker gains internal system information, making further exploitation (like the network C2 seen in PCAP) much easier.

**Remediation**:
- Disable debug mode in production
- Remove default credentials
- Regular security hardening checklist

**Status**: Remediated.
