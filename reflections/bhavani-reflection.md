# Individual Reflection - Bhavani (Scrum Master)

## Q1: Packet that changed my thinking
Packet range ~245-300 showed periodic DNS TXT queries. Initially thought it was legitimate monitoring. After seeing the consistent timing with HTTPS beacons, I realized it was likely DNS tunneling / C2.

## Q3: Vulnerability Payload Walkthrough (SQLi)
First tried: `1' OR 1=1` → failed due to quoting.  
Final: `admin' --` → worked. Understood that comment operator bypasses the rest of the query.

## Q5: LLM Mislead
LLM suggested fake IOC IPs not present in PCAP. Caught it by cross-checking with tshark output.

## Q6: Cross-Surface Chain
Web SQLi → Shell on web server → Outbound C2 beacon (matches PCAP).

## Q8: Proud Commit & Redo
Proud: Created the Defense-in-Depth file.  
Redo: Early README was too generic.

**Overall Learning**: Defense-in-depth is not just layers — it's connecting findings across surfaces.
