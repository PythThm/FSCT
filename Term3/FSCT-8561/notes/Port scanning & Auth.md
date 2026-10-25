# Part 1: Port Scanning and Enumeration

## Learning Objectives

- Explain reconnaissance in cybersecurity
- Understand network scanning and enumeration
- Learn the types of port scanning
- Analyze security implications of exposed network services
- Apply ethical and legal considerations to scanning
- **Lab 2:** Developing a Python Nmap port scanner

**Prior week recap:** socket abstraction, UDP and TCP sockets in Python, key concepts of TCP client-server communication.

---

## 1. Reconnaissance (Recon)

- **Definition:** the process of gathering information about a target system, network, or organization.
- First phase of most cyber attacks.
- Also used by **defenders** for asset discovery and risk assessment.
- Focuses on **visibility**, not exploitation.

### Passive vs. Active Recon

||**Passive**|**Active**|
|---|---|---|
|Interaction|No direct interaction with target|Direct interaction with target system|
|Examples|DNS lookups, WHOIS records, public IP/service info|Ping sweeps, port scanning, service enumeration|
|Risk|Lower risk of detection|Higher risk, but more accurate results|

---

## 2. What Is Port Scanning?

Port scanning is the process of:

1. Sending packets to target ports
2. Observing the responses
3. Determining port states

### Common Port States

|State|Meaning|
|---|---|
|**Open**|A service is actively listening|
|**Closed**|No service listening|
|**Filtered**|A firewall or filtering device is blocking probes|

### What a Scan Tells You

- Which services are running
- Which ports are open
- Which services are exposed to the network

> **Security principle:** Every open port expands the attack surface.

---

## 3. Nmap (Network Mapper)

- Full-featured, widely used port scanning tool.
- Used for: **port scanning, service detection, OS fingerprinting, network inventory**.
- Website: www.insecure.org/nmap/
- **Zenmap** = the Nmap graphical user interface.

---

## 4. Port Scanning vs. Enumeration

|Aspect|Port Scanning|Enumeration|
|---|---|---|
|Primary question|What ports are open?|What services and details run on them?|
|Recon phase|Early discovery|Follows port scanning|
|Level of detail|Low-level exposure|High-detail information|
|Typical output|Port numbers & states|Service names, versions, banners|
|Risk / intrusiveness|Lower|Higher|
|Example|"Port 22 is open"|"Port 22 runs OpenSSH 8.2p1"|

> **Key takeaway:** Scanning _discovers_ exposure; enumeration _explains_ exposure.

---

## 5. Ethical and Legal Considerations

- Port scanning can be intrusive.
- Unauthorized scanning may be **illegal**.
- Only scan:
    - Systems you **own**
    - Systems you have **explicit permission** to test
- **Technical ability does not imply authorization.**

---

## 6. Common Types of Nmap Scans

1. TCP Connect
2. TCP SYN
3. TCP FIN, Xmas Tree, and Null
4. TCP ACK
5. FTP Bounce

### 6.1 TCP Connect Scan: "The Polite Scan"

- Completes the full **TCP three-way handshake** (SYN → SYN/ACK → ACK).
- Very **easy to detect**: the server's log shows a connection opened from the attacker's IP.
- Attackers therefore often prefer stealthier techniques.

### 6.2 TCP SYN Scan: "A Little Stealthier"

- Stops **two-thirds of the way** through the handshake (never sends the final ACK).
- If the port is closed, the scanner gets no response, a RESET, or an ICMP "port unreachable" (depends on target type and network architecture).
- **Benefits:** stealthier (a true connection never occurs) and faster.

**Interpreting responses:**

|Probe|Response|Result|
|---|---|---|
|SYN →|SYN/ACK|Port **OPEN**|
|SYN →|RST|Port **CLOSED**|
|SYN →|(no reply)|**FILTERED / BLOCKED**|

### 6.3 TCP FIN, Xmas Tree, and Null Scans: "Violate the Protocol Spec"

- A FIN packet tells the target a connection should be torn down.
- **Closed port** → responds with **RST**.
- **Open port** → responds with **nothing**.

|Probe|Response|Result|
|---|---|---|
|FIN →|RST|Port **CLOSED**|
|FIN →|(no reply)|Port **OPEN**|

_(Extra note: "no reply" can also mean filtered, so real tools report this as "open|filtered".)_

### 6.4 TCP ACK Scan: "Kicking the Ball Past the Goalie"

- Used to get past simple **packet-filter firewalls**.
- Such filters block incoming traffic when the SYN flag is set, but allow outgoing traffic and established responses.
- The attacker sends **ACK** packets to various destination ports (e.g., 1024, 1025, 1026). The filter treats them as part of an established connection and passes them; the internal host replies with **RESET**.
- A RESET coming back reveals which ports are reachable through the firewall.

### 6.5 FTP Bounce Scan: "Obscure the Source"

- Some **old FTP servers** let a user request that the server send a file to another system.
- Attack flow:
    1. Attacker connects to an FTP server that supports the bounce feature.
    2. Attacker's tool asks the "innocent" FTP server to open a connection to a given port on the target.
    3. The FTP server reports the port's status back to the attacker.
- Hides the attacker's true source address.

### 6.6 Don't Forget UDP

- UDP has **no three-way handshake, sequence numbers, or code bits**.
- Packets may arrive out of order and are **not retransmitted** if dropped.
- **False positives are common** in UDP scans.

---

## 7. Defenses Against Port Scanning

- **Harden systems:** close all unused ports; on critical systems, delete the programs tied to unneeded services.
- **Find the openings before attackers do:** scan your own systems and verify all ports are closed except those with a defined business need.
- **Add intelligence:** use **stateful packet filters** or **proxies**.

---

## Port Scanning: Summary

- Reconnaissance is foundational to cybersecurity.
- Port scanning reveals real security risks.
- Automation improves accuracy and scale.
- Ethical responsibility is critical.
- Understanding exposure is the first step to defense.

**Next topic:** Authentication · **Lab 2:** Developing a Python Nmap Port Scanner

---

---

# Part 2: Authentication

## Learning Objectives

- Differentiate authentication and authorization
- Understand password hashing
- Explain OTP-based authentication
- **Lab 3:** Implement OTP authentication in Python (building an OTP authentication server)

**Prior week recap:** recon is foundational, port scanning reveals real risks, automation improves accuracy and scale, build a Python Nmap port scanner.

---

## 1. What Is Authentication?

- Verifies the **identity** of a user or system.

### Authentication Factors

|Factor|Type|Examples|Notes|
|---|---|---|---|
|**Something You Know**|Knowledge|Passwords, PINs, security questions|Most common, but weakest factor|
|**Something You Have**|Possession|Smartphones (SMS/apps), security tokens, smart cards|Often used for 2FA|
|**Something You Are**|Inherence|Biometrics: fingerprint, Face ID, iris scan|Based on unique physical characteristics|

**Multi-Factor Authentication (MFA)** = combining factors for enhanced security.

## 2. Authentication vs. Authorization

||Question|
|---|---|
|**Authentication**|_Who are you?_|
|**Authorization**|_What are you allowed to do?_|

Both are required for secure systems.

---

## 3. End-Point Authentication: Evolution of Options

**Goal:** Bob wants Alice to "prove" her identity. (Trudy = the attacker.) _(Cartoon reference: "On the Internet, nobody knows you're a dog.")_

|Option|Approach|Weakness|
|---|---|---|
|1|Alice sends a message with her identification|Easily **spoofed** by Trudy|
|2|Alice includes her own IP address, known to Bob|Trudy can **spoof an IP** and eavesdrop on the connection|
|3|Use a **password**|If Trudy can eavesdrop, the password is **leaked**|
|4|Use an **encrypted password**|Trudy can **play it back unmodified** (no need to know the password if encryption is always the same) → **replay attack**|
|5|Use a **nonce** (like a one-time password)|Solves replay, see below|

### Option 5: Nonce / One-Time Password

- Alice and Bob both read the clock (e.g., 10:30:00); that is their "starting data."
- Both compute an HMAC hash:

```
OTP = HMAC(Key, Timestamp)
```

- Alice generates the code and gives it to Bob. Bob does the same calculation and checks whether his result matches hers.

---

## 4. One-Time Password (OTP)

- A **time-sensitive, single-use** password.
- Protects against **replay attacks**: even if intercepted, the password can't be reused.
- Adds a **second layer of authentication** beyond a static password.

### OTP Server Authentication Flow

|Step|Action|Description|
|---|---|---|
|1. Primary login|Client → Server|User submits username and password (_something you know_)|
|2. Identity check|Server side|Server checks the database; if correct, looks up the user's MFA settings|
|3. OTP generation|Server & device|Server and user's app both use a **shared secret + current time** to calculate the same code|
|4. Submission|Client → Server|User types the 6-digit code from their phone into the login screen|
|5. Validation|Server side|Server compares the submitted code with the one it generated|
|6. Success|Server → Client|If they match, a session is established and access is granted|

### Time-Based One-Time Password (TOTP)

```
Shared Secret + Current Time  →  TOTP Algorithm  →  6-digit code
```

- Server and authenticator share the **same secret**.
- Both **independently calculate** the expected code from the secret and time.
- Code is valid only for a short window (commonly **30 seconds**).
- **Protect the TOTP secret:** anyone who obtains it can generate valid codes.

### Clock Dependency in OTP

- OTP uses **shared secret + current timestamp**.
- Valid for a short interval (commonly 30 s).
- Client and server clocks must be **synchronized**.
- **Clock drift > time window → OTP validation fails.**
- Use **NTP (Network Time Protocol)** on both client and server to keep clocks in sync.
- Keeps OTPs both secure and usable.

---

## 5. Password Storage on the Server

- **Never** store plaintext passwords.
- Use **cryptographic hashes**.
- **Compare hashes** during login.

### Cryptographic (Secure) Hash Functions

- **One-way:** given x, it is computationally infeasible to find m such that H(m) = x.
- **Collision resistant:** given m, it is computationally infeasible to find m′ ≠ m such that H(m) = H(m′).
- Examples: MD5, SHA-256, SHA-512.

### Hash Function Algorithms (as presented)

- **MD5:** widely used; computes a **128-bit** digest in a 4-step process; hard to compute the message from the hash.
- **SHA-1:** US NIST standard; **160-bit** digest.
- **Newer alternatives:** SHA-256, SHA-512.

> ⚠️ **Note:** The slide calls SHA-1 "more secure" than MD5, but a later slide says both **MD5 and SHA-1 are legacy/broken** for modern security use. Treat this as historical context.

### Hashing vs. Encryption

|**Encryption**|**Hashing**|
|---|---|
|Reversible with the correct key|Designed to be one-way|

- Passwords should be verified using **password hashes**, not decrypted from storage.
- MD5 and SHA-1 are legacy/broken for modern security.
- SHA-256 is a secure general-purpose hash, but **SHA-256 alone is not ideal for password storage** (it's too fast, which helps brute-forcing).
- **Production password storage:** **Argon2 / bcrypt / scrypt / PBKDF2 + salt**.
- _Lab 3 uses SHA-256 only to learn the authentication workflow._

### Password Hashing in Python

```python
import hashlib

password = "Cyber123!"

password_hash = hashlib.sha256(
    password.encode()
).hexdigest()

print(password_hash)
```

**Pipeline:** `String` → `.encode()` (bytes) → `sha256()` (hash object) → `.hexdigest()` (hex string)

**During login:** hash the entered password and compare it with the stored hash.

---

## Authentication: Summary

- Authentication ensures users are who they claim to be.
- Passwords must be hashed.
- OTPs provide time-based, single-use codes.
- Server validates **username + password hash + OTP**.
- Client-server interaction must handle errors and invalid input.
- Security considerations: **replay attacks, brute force, clock desynchronization**.

**Next topic:** Network Analysis · **Lab 3:** Building an OTP authentication server

---

---

# Quick-Review Cheat Sheet

|Concept|One-liner|
|---|---|
|Recon|Info gathering; passive (no contact) vs. active (direct contact)|
|Port states|Open / Closed / Filtered|
|Scan vs. enumeration|Scan = what's open; enumeration = what's running (versions, banners)|
|Connect scan|Full handshake; noisy, easy to log|
|SYN scan|Half-open; faster and stealthier|
|FIN / Xmas / Null|Closed → RST; open → silence|
|ACK scan|Maps firewall rules / gets through simple packet filters|
|FTP bounce|Use a third-party FTP server to hide the scan source|
|UDP scan|No handshake → unreliable, false positives|
|Scan defense|Harden, close unused ports, self-scan first, stateful filters/proxies|
|AuthN vs. AuthZ|Who you are vs. what you can do|
|Replay attack|Attacker re-sends captured credentials; stopped by nonces/OTP|
|TOTP|HMAC(shared secret, time window) → 6 digits, ~30 s validity|
|Clock drift|Beyond the time window, OTP validation fails; fix with NTP|
|Password storage|Hash, never plaintext; production: Argon2/bcrypt/scrypt/PBKDF2 + salt|