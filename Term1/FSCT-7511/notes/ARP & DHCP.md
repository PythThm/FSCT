## **Part 1: Address Resolution Protocol (ARP)**

### **1. Purpose and Operation**
* **Purpose:** The Address Resolution Protocol (ARP) is essential for communication within a **Local Area Network (LAN)**. Its sole function is to resolve a **Network Layer (IP) address** to a corresponding **Link Layer (MAC) address**.
    * The IP address is used for routing across the Internet (Network Layer).
    * The MAC address (hardware address) is used for direct delivery between adjacent devices on the same subnet (Link Layer).
* **Scenario:** Host A knows Host B's IP address but needs B's MAC address to place the IP datagram inside an Ethernet frame for transmission.
* **Resolution Steps (on a single LAN):**
    1.  **ARP Request (Broadcast):** Host A broadcasts an **ARP Request** message onto the LAN. The message contains B's IP address and asks, "Who has this IP address? Tell me their MAC."
    2.  **ARP Reply (Unicast):** Only Host B (the owner of the IP) responds. It sends an **ARP Reply** message directly back to A, containing its MAC address.
    3.  **Caching:** Host A receives the reply and stores the IP-to-MAC mapping in its **ARP cache** for a limited time to avoid future requests. 

### **2. ARP Security**

ARP operates with the assumption of a secure network, making it vulnerable to certain attacks.

* **ARP Spoofing / Man-in-the-Middle (MITM) Attack:**
    * **Goal:** The attacker seeks to intercept traffic between two devices (A and B).
    * **Mechanism:** The attacker sends **gratuitous ARP replies** to both A and B.
        * To **A**, the attacker sends a reply claiming its own MAC is B's MAC.
        * To **B**, the attacker sends a reply claiming its own MAC is A's MAC.
    * **Impact:** All traffic between A and B is now funneled through the attacker's machine, allowing them to sniff, modify, or drop the data.
* **ARP Cache Poisoning:** This is the technique used in ARP Spoofing, where the attacker injects false IP-to-MAC mappings into the ARP caches of other hosts.

---

## **Part 2: Dynamic Host Configuration Protocol (DHCP)**

### **1. Purpose and Operation (DORA)**
* **Purpose:** DHCP is an application-layer protocol used to **dynamically assign IP addresses** and configuration information (Subnet Mask, Gateway, DNS Servers) to client machines upon connecting to a network.

* **The DORA Process (Four Steps):**
    1.  **D**iscover: The client (which has no IP) broadcasts a **DHCP Discover** message to find any available DHCP servers.
    2.  **O**ffer: Available DHCP servers respond with a **DHCP Offer** message, proposing an IP address and lease time.
    3.  **R**equest: The client selects one offer and broadcasts a **DHCP Request** message, confirming its acceptance of the offered IP address.
    4.  **A**cknowledge: The chosen server sends a final **DHCP Acknowledge (ACK)** message, confirming the lease and sending all the final configuration parameters. 

### **2. DHCP Security**
DHCP can be exploited to disrupt network availability or reroute traffic.

* **Rogue DHCP Server:**
    * **Goal:** To hijack network configuration and/or perform a Man-in-the-Middle attack.
    * **Mechanism:** An unauthorized DHCP server (controlled by an attacker) responds to DHCP Discover messages with malicious configuration (e.g., setting the default gateway to the attacker's IP).
    * **Impact:** Clients receive the malicious configuration and route their traffic through the attacker's device.
* **DHCP Starvation:**
    * **Goal:** To launch a Denial of Service (DoS) attack, preventing legitimate users from obtaining an IP address.
    * **Mechanism:** An attacker floods the network with DHCP Discover requests, each spoofing a unique MAC address.
    * **Impact:** The legitimate DHCP server exhausts its entire pool of available IP addresses, preventing new, legitimate clients from connecting.

---

## **Part 3: Link-Layer Attack Mitigations**

Several security controls are implemented at the switch level to combat common link-layer attacks.

| Attack Type | Mitigation Technique(s) | Key Concept |
| :--- | :--- | :--- |
| **ARP Spoofing/Poisoning** | **Dynamic ARP Inspection (DAI)** and **Port Security** | DAI intercepts all ARP traffic and verifies it against the switch's trusted DHCP Snooping table before forwarding. |
| **Rogue DHCP Server** | **DHCP Snooping** | The switch inspects DHCP messages and separates **trusted ports** (where the legitimate server is) from **untrusted ports** (all client ports). It blocks unauthorized DHCP Offer/ACK messages. |
| **DHCP Starvation** | **Port Security** and **Rate Limiting** | **Port Security** limits the number of MAC addresses allowed to be learned on a single port. **Rate Limiting** sets limits on the number of IP leases a single port can request. |
| **Unauthorized Devices** | **802.1X (Port-Based Network Access Control)** | Requires devices to authenticate (via credentials or certificates) before being granted network access, preventing rogue devices from connecting. |