# **Part 1: Firewalls**

### **1. Introduction and Components**
* **Definition:** A firewall is a network appliance (hardware, built-in router, or software) designed to **allow or block network traffic** based on a predefined set of rules.
* **Function:** It acts as a gatekeeper between networks, typically between a **Local Area Network (LAN)** and a **Wide Area Network (WAN)** (like the Internet). 



* **Linux Tool:** **iptables** is one of the most common firewall applications available for Linux.
* **Essential Components:**
    * **Rule Set (Access Control List - ACL):** The defined list of rules for managing traffic.
    * **Policy:** The overall approach to traffic management, usually **"default deny"** (block everything unless explicitly allowed) for maximum security.
    * **Logging/Alerting:** The ability to record and notify administrators of traffic events.

### **2. Firewall Types and Operation**

#### **A. Packet Filtering Firewall**
* **Layer of Operation:** Works at the **Network (Layer 3) and Transport (Layer 4)** layers.
* **Mechanism:** Examines individual packets based on header information.
* **Criteria:** Uses simple rules like:
    * Source/Destination **IP Address**
    * Source/Destination **Port Number**
    * **Protocol** (TCP, UDP, ICMP)
* **Vulnerability:** Cannot check the **context** of the connection or the **data content**. Easily fooled by IP address spoofing.

#### **B. State Table (Stateful) Firewall**
* **Mechanism:** Maintains a **state table** (or connection table) that tracks the state of every active connection.
* **Operation:** Once a connection is established (e.g., after the TCP 3-way handshake), subsequent packets belonging to that *established* connection are automatically allowed, regardless of the explicit rules.
* **Advantage:** Significantly more secure than stateless filtering because it prevents unsolicited, incoming packets.
* **The Key Difference:** A stateful firewall can tell the difference between a packet from a new connection and a packet that is simply a *reply* to a previously allowed *outgoing* connection.

#### **C. Application Layer (Proxy) Firewall**
* **Layer of Operation:** Works at the **Application Layer (Layer 5)**.
* **Mechanism:** Acts as an intermediary (a **proxy**) between the internal client and the external server. It effectively terminates the original connection and establishes a new one on behalf of the client.
* **Inspection:** Can inspect the actual **data payload** of the application traffic (e.g., HTTP headers, file contents).
* **Highest Security:** Provides the highest level of security and granular control.

### **3. Network Address Translation (NAT) with Firewalls**
* **NAT** is a technique that translates private (internal) IP addresses into one or more public (external) IP addresses.
* **Source NAT (SNAT):** When internal hosts connect *out* to the Internet. The **source** address is translated.
* **Destination NAT (DNAT) / Port Forwarding:** Used to allow external traffic to reach an **internal server**. The **destination** address (and often port) is translated.

---

# **Part 2: Intrusion Detection Systems (IDS)**

### **1. Purpose and Types**

* **Definition:** An IDS is a security mechanism that **monitors network or system activity** for malicious activity or policy violations and reports them. Unlike a firewall, an IDS typically **does not block traffic** (unless it is an IPS).

#### **A. Classification by Response**
* **Passive IDS:** Simply **detects intrusions** and **notifies administrators** (alerts, logging).
* **Reactive (or Active) IDS / Intrusion Prevention System (IPS):** Detects intrusions and automatically attempts to **react or respond** to them (e.g., by dropping packets, blocking a source IP at the firewall).

#### **B. Classification by Scope**
* **Network-based IDS (NIDS):** Discovers intrusions by **monitoring key network segments** (often via a mirrored or tapped port). **Snort** is a common example.
* **Host-based IDS (HIDS):** Runs on a **specific system** (server, workstation) and monitors local activity, such as file integrity, system logs, and user activity. **Tripwire** and **AIDE** are examples.

### **2. Detection Methods**

| Method | Mechanism | Advantages | Disadvantages |
| :--- | :--- | :--- | :--- |
| **Signature-based** | Uses a database of **known attack patterns** (signatures). | Highly effective at detecting known attacks with high accuracy. | Cannot detect **zero-day** or novel attacks. Requires constant updating. |
| **Anomaly-based** | Establishes a **baseline** of normal network/system behavior. Alerts when deviations from the baseline are observed. | Can detect **novel (zero-day)** attacks and new policy violations. | High potential for **false positives** (alerting on legitimate but new behavior). Requires a training period to build the baseline. |

### **3. IDS Tools**

* **Snort:** A classic NIDS tool that provides **real-time analysis of traffic** and can log network packets. It is signature-based.
* **Tripwire / AIDE:** HIDS tools that focus on **file integrity monitoring**. They report when key system files have been changed (often used to detect rootkits or configuration tampering).
* **Security Onion:** A specialized Linux distribution that primarily focuses on integrating and running a suite of IDS and network security monitoring tools.