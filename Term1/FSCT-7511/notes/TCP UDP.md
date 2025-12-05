## **Part 1: Transport Layer Protocols (TCP and UDP)**

The Transport Layer is responsible for providing **logical communication** between **application processes** running on different hosts.

|**Feature**|**TCP (Transmission Control Protocol)**|**UDP (User Datagram Protocol)**|
|---|---|---|
|**Reliability**|**Reliable ordered delivery**.|**Unreliable**. Best effort delivery.|
|**Connection**|**Connection-oriented**. Requires handshaking to initialize state.|**Connectionless**. No handshaking required.|
|**Flow/Congestion Control**|Includes **Flow control** (sender won't overwhelm receiver) and **Congestion control**.|**No** flow or congestion control.|
|**Data Handling**|**Stream-oriented** (bytes).|**Message-oriented** (preserves datagram boundaries).|
|**Speed**|Possible delays due to reliability checks.|**Lightweight and fast**. No transport level delay.|
|**Buffers**|Uses send and receive buffers.|No send or receive buffers.|

---

### **1.1 Transport Layer Multiplexing (Ports)**

- **Logical Communication:** The Network Layer (IP) provides communication between **hosts** (terminated at the interface), while the Transport Layer provides communication between **processes** (terminated at the application).
    
- **Application Identification:** An application is identified by a transport layer address: `<IP address, port>`.
    
    - **IP Address:** Gets you to the host interface.
        
    - **Port Number:** Gets you to a specific application process or thread on that host.
        
- **Port Range:** Historically a **16-bit** unsigned number (0 - 65535).
    
- **Port Mapping:** Services are mapped to ports, often defined in the `/etc/services` file.
    

#### **Common Ports and Services**

|**Port**|**Service**|**Function**|
|---|---|---|
|**20 and 21**|**FTP** (File Transfer Protocol)|Used for transferring files between hosts.|
|**22**|**SSH** (Secure Shell)|Used for connecting to remote systems and executing commands.|
|**23**|**Telnet**|Used for connecting to remote systems and executing commands (**unencrypted**).|
|**25**|**SMTP** (Simple Mail Transfer Protocol)|Used to send email.|
|**53**|**DNS** (Domain Name Service)|Used to translate hostnames to IP addresses.|
|**80**|**HTTP** (Hypertext Transfer Protocol)|Used to communicate with web servers.|
|**110**|**POP3** (Post Office Protocol)|Used to retrieve email.|

---

### **1.2 UDP (User Datagram Protocol) Details**

- **Point-to-Point:** Exactly two participants.
    
- **Message-Oriented:** Preserves message boundaries (each datagram is an independent unit).
    
- **Minimal Mechanisms:** Has minimal protocol mechanisms, contributing to its speed and lightweight nature.
    

#### **UDP Segment Format**

The UDP segment includes Source and Destination Port numbers, **Length** (in bytes), and a **Checksum**.

#### **Checksums**

- Used at the transport, network, and link layers for **error detection** (e.g., flipped bits).
    
- **Sender** computes a function on the data, adds the checksum, and sends it.
    
- **Receiver** computes the same function and checks if the computed checksum equals the received one.
    

---

### **1.3 TCP (Transmission Control Protocol) Details**

- **Connection-Oriented:** Requires a **handshake** before data exchange.
    
- **Full Duplex Data:** Supports bi-directional data flow within the same connection.
    
- **Reliable, In-Order Byte Stream:** Ensures data is received completely and in the correct order.
    
- **Flow Controlled:** Sender will not overwhelm the receiver.
    

#### **TCP Connection Establishment (Three-Way Handshake)**

TCP uses a **"three-way handshake"** to establish a connection and initialize sender/receiver state.

![Image of TCP three-way handshake](https://encrypted-tbn0.gstatic.com/licensed-image?q=tbn:ANd9GcS8qNi-UY7AMaNrhVQ8bpHkfF_3ZHQWmMX3JiNelf8einUXf_lE6yApanRR4a-wJ6Q10hCmHsjwZ2heHZwf9kb-n86QMEqvJNR4JpLn1DQLV20j77o)

Shutterstock

Explore

1. **Client $\rightarrow$ Server (SYN):** The client sends an initial **SYN** (synchronize) message, specifying its initial sequence number.
    
2. **Server $\rightarrow$ Client (SYN/ACK):** The server responds with a **SYN/ACK** message. It confirms the client's sequence number (**ACK**) and specifies its own initial sequence number (**SYN**).
    
3. **Client $\rightarrow$ Server (ACK):** The client sends a final **ACK** (acknowledgement) message to confirm the server's sequence number.
    

#### **Sequence Numbers and ACKs**

- **Sequence Numbers:** Each **byte** of data in a TCP stream has a sequence number. The sequence number of a segment is the sequence number of its first byte.
    
- **Acknowledgements (ACKs):** ACKs are **cumulative**. They correspond to the sequence number of the **next byte expected** from the other side.
    

---

## **Part 2: Network Layer - Internet Protocol (IP)**

### **2.1 Core Functions**

The Network Layer (IP) is responsible for delivering packets between hosts.

- **Routing:** Determines the **entire path/route** taken by packets from the source to the final destination. (Analogy: Planning the trip from start to finish).
    
- **Forwarding:** Moves packets from a router's input to the **appropriate router output**. (Analogy: Getting through a single intersection).
    

### **2.2 IP Addressing**

- **IPv4:**
    
    - Uses **32-bit** binary numbers, represented in **dotted decimal notation** (four octets separated by dots).
        
    - Provides approximately **4.3 billion** possible addresses.
        
- **IPv6:**
    
    - Uses **128-bit** hexadecimal numbers, providing a much larger address pool to overcome IPv4 address shortage.
        

#### **Class-Based Addressing (Obsolete but foundational)**

Historically, IPv4 addresses were divided into classes based on the first few bits:

|**Class**|**Prefix**|**Network Size (bits)**|**Example Range**|
|---|---|---|---|
|**A**|0|8|1.x.x.x to 126.x.x.x|
|**B**|10|16|128.x.x.x to 191.x.x.x|
|**C**|110|24|192.x.x.x to 223.x.x.x|

- **Reserved Class A Networks:** Network **10** is reserved for **Private networks**, and network **127** is the **Local host (loopback)** address.
    

#### **CIDR (Classless Inter-Domain Routing)**

- CIDR is the current standard, replacing the rigid class system.
    
- **Format:** `IP Address/Prefix Length` (e.g., 200.23.18.4/**22**).
    
- **Prefix Length:** The number after the slash (`/`) indicates the number of bits reserved for the **network part**.
    
- **Network Address:** To find the network address, replace the **host bits** (the remaining bits after the prefix length) with zero.
    
- **Netmask:** The prefix length corresponds directly to the netmask (e.g., a `/8` prefix is `255.0.0.0`).
    

---

## **Part 3: Network Address Translation (NAT)**

### **3.1 Purpose**

- **The Problem:** The world ran out of public IPv4 addresses.
    
- **The Solution:** **NAT** allows multiple hosts in a private network to share a **single public IP address**.
    
- **Mechanism:** The edge router (NAT router) translates **private IP addresses** to the router's **public IP address**.
    

### **3.2 How NAT Works (The NAT Table)**

The NAT router uses a **NAT table** to track and map internal connections to external connections.

**When an internal client sends a message out:**

1. The router converts the packet's **source IP** to the router's public IP.
    
2. The router converts the **source port** to an available port (the **NAT Port**).
    
3. The router adds an entry to the NAT table to record this mapping: `Internal IP, Internal Port, Remote IP, Remote Port, Protocol` maps to `NAT IP, NAT Port`.
    

**When a remote server sends a reply back:**

1. The NAT router receives the reply packet addressed to its public IP and the NAT Port.
    
2. The router checks its NAT table, finds the corresponding internal IP and port, and reverses the translation.
    
3. The packet is forwarded to the correct internal host.
    

### **3.3 Server on the Inside**

- A remote machine **cannot** connect to an internal server spontaneously because the router has no NAT table entry for an unsolicited incoming connection.
    
- To allow an external connection to an internal server (e.g., web server), the NAT table entry must be configured **manually** (known as **Port Forwarding**) or via protocols like UPnP.