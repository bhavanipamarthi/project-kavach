# Finding F04 - Broken Authentication (OWASP A07)

**Vulnerable Application**: OWASP Juice Shop

**Attack Type**: Weak Password Reset / Authentication Bypass

**Payload / Method**:
- Use weak password reset token or brute-force weak credentials
- Example: Reset password using predictable token

**Root Cause**: 
Insufficient password policy, weak reset mechanisms, and lack of rate limiting.

**Business Impact at Meridian FinServe**:
An attacker could take over customer or merchant accounts, leading to fraudulent loan applications or unauthorized EMI changes.

**Remediation**:
- Enforce strong password policy
- Implement rate limiting on login/reset
- Use secure session management

**Status**: Remediated.
