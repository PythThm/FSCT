## **Part 1: Networking Basics and Data Transfer**

### **1. The Internet: "Nuts and Bolts" View**

The Internet is a vast network consisting of billions of connected devices, known as **hosts** or **end-systems** (e.g., PCs, smartphones, IoT devices).

- **Hosts** run network applications.
    
- **Communication Links** use fiber, copper, radio, or satellite, and vary in **bandwidth** and **latency**.
    
- **Routers** are key network components that **forward packets** (chunks of data) between networks.
    

### **2. Protocols**

A **protocol** is essential for communication. A fully-defined protocol must provide a proper action for any event in any state.

- **Definition:** A protocol defines:
    
    - Roles of communicating entities.
        
    - Format and order of messages.
        
    - Actions taken on transmission, receipt, or other events.
        
- **Request-Response Protocols:** Many Internet protocols follow this model, where a **Requestor (Client)** sends a request and a **Receiver (Server)** sends a response.
    

### **3. Data Switching Methods (Circuit vs. Packet)**

|**Feature**|**Circuit Switching (Option 1)**|**Packet Switching (Option 2)**|
|---|---|---|
|**Path**|**Dedicated path** established before transmission.|**Independently routed** packets (chunks of data).|
|**Medium Use**|Path is **occupied** for the entire connection, even during silence.|Medium is occupied **only during packet transmission**.|
|**Multiplexing**|Time, Frequency, Code, or Orthogonal Division.|**Statistical Multiplexing** (shared based on demand).|
|**Best For**|Guaranteed service (steady rate), rare conversation starts.|Statistically good performance, **bursty demand**, frequent conversation starts.|
|**Outcome**|Less efficient utilization of the medium.|Allows more conversations and **better utilization** of the medium.|

---

## **Part 2: The Internet Protocol Stack and Encapsulation**

### **1. The 5-Layer Protocol Stack**

The Internet uses a layered approach, where each layer requests services from the layer below it.

|**Layer**|**Protocols**|**Primary Data Unit**|**Function / Responsibility**|
|---|---|---|---|
|**5. Application**|HTTP, Email (SMTP/POP/IMAP), DNS, Multimedia|**Message**|Provides interface for user applications (e.g., filing tax income).|
|**4. Transport**|**TCP, UDP**|**Segment**|Identifies the correct **process** on the machine. Ensures data arrives in order and recovers lost data (if required).|
|**3. Network**|**IP**|**Datagram**|**Routes datagrams** through routers to the final destination machine.|
|**2. Link**|Ethernet, 802.11b/g/n|**Frame**|Routes frames to **adjacent machines** (direct connection).|
|**1. Physical**|Operating System/Hardware|Bit|Encodes data appropriately for the physical medium (e.g., fiber, copper).|

### **2. Encapsulation**

- **Process:** As data moves down the stack, each layer takes the data unit from the layer above it, **adds its own header information** to it, and creates a new data unit before passing it to the layer below.
    
- **Result:** The original message is progressively wrapped in headers (Ht, Hn, Hl) until it becomes a **Frame** at the link layer.
    
- **Decapsulation:** At the destination, the reverse process occurs as the frame moves up the stack, and each layer strips off its corresponding header.
    

---

## **Part 3: Network Configuration Commands (Non-Persistent)**

These changes are **not persistent** across reboots.

|**Command**|**Usage / Purpose**|**Key Options/Parameters**|
|---|---|---|
|**`ifconfig`**|Displays and temporarily changes network interface settings. (Being replaced by `ip`)|`ifconfig eth0 192.168.1.16 netmask 255.255.255.0` (Set IP/Netmask).<br><br>  <br><br>`ifconfig eth0 promisc` (Enable promiscuous mode).<br><br>  <br><br>`ifup eth0`/`ifdown eth0` (Bring interface up/down).|
|**`route`**|Displays or changes the system's **routing table**.|Used without arguments to display the table.<br><br>  <br><br>`add` parameter to add a gateway.<br><br>  <br><br>`del` parameter to delete a gateway.<br><br>  <br><br>Output flag **UG** means **Up + Gateway**.|
|**`arp`**|Displays or makes changes to the **ARP table** (correlates **MAC addresses to IP addresses**).|`arp` (Display table).<br><br>  <br><br>`arp -I eth0 -d 192.169.1.11` (Delete an entry).|
|**`ip`**|A newer, powerful command designed to replace `ifconfig`, `arp`, and `route`.|`ip addr add 192.168.1.16/24 dev eth0` (Assign IP).<br><br>  <br><br>`ip link set eth0 up/down` (Bring interface up/down).<br><br>  <br><br>`ip route show` (View routing table).|

---

## **Part 4: Persistent Network Configuration Files**

To permanently set or modify network configurations, these files must be edited.

|**File Path**|**Purpose**|**Distribution Note**|
|---|---|---|
|**`/etc/hostname`**|Stores the local system's hostname.|Universal|
|**`/etc/hosts`**|Stores static hostname-to-IP address translation.|Universal|
|**`/etc/resolv.conf`**|Contains a list of the **DNS servers** for the system.|Universal|
|**`/etc/sysctl.conf`**|Defines parameters for the **kernel**.|Universal|
|**`/etc/sysconfig/network`**|Sets system hostname and if networking starts automatically at boot.|**Red Hat**-based distros (RHEL, Fedora, CentOS).|
|**`/etc/network/interfaces`**|Single file to specify IP address settings for all interfaces.|**Debian**-based distros (Debian, Ubuntu, Mint).|

---

## **Part 5: Network Troubleshooting Commands**

|**Command**|**Purpose**|
|---|---|
|**`ping`**|Verifies that a remote host can respond to a network connection (uses **ICMP**).|
|**`tracert`** (or `traceroute` on Linux)|Displays the **router hops** (path) from one system to another.|
|**`netstat`**|Displays a variety of network information, including active **TCP connections**.|
|**`host`**|Performs simple **hostname-to-IP address translation** activities (DNS queries).|
|**`dig`**|Performs advanced **DNS queries** on specific DNS servers.|
|**`netcat`** (`nc`)|Used for debugging network issues; can act as a listener on a specific port.|
|**`iwconfig`**|Displays the parameters of a **wireless interface**.|