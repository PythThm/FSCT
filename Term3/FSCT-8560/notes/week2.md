
---
# Chapter 2: TCP/IP Concepts Review

## 📌 Objectives

- Describe the **TCP/IP protocol stack**
- Explain the basic concepts of **IP addressing**

---

## 1. Overview of TCP/IP

- **Protocol** = the "language" computers use to communicate
- **TCP/IP** (Transmission Control Protocol/Internet Protocol) is the most widely used protocol suite
- The **TCP/IP stack** has **4 layers** (bottom to top):
    1. **Network**
    2. **Internet**
    3. **Transport**
    4. **Application**

---

## 2. The Application Layer

- The **"front end"** — the layer users can see and interact with
- Hosts application programs (e.g., HTTP, FTP, DNS, email clients)

---

## 3. The Transport Layer

- **Encapsulates data into segments**
- Uses **TCP** or **UDP** to deliver data to a destination host

### TCP (Transmission Control Protocol)

- **Connection-oriented** protocol (reliable)
- Uses the **TCP three-way handshake** to establish a connection:
    1. Computer A → sends **SYN** to Computer B
    2. Computer B → replies with **SYN-ACK**
    3. Computer A → replies with **ACK**

### TCP Segment Headers — Critical Components

- **TCP flags**
- **Initial Sequence Number (ISN)**
- **Source and destination port numbers**
- ⚠️ These fields are commonly **abused by hackers** — understanding them is key to defending a network

### TCP Flags (6 total — each is 1 bit, on/off)

|Flag|Meaning|
|---|---|
|SYN|Synchronize|
|ACK|Acknowledgment|
|PSH|Push|
|URG|Urgent|
|RST|Reset|
|FIN|Finish|

### Initial Sequence Number (ISN)

- **32-bit number**
- Tracks packets received by a node; allows **reassembly** of large packets
- Sent during handshake steps 1 & 2:
    - Sender's ISN → sent with **SYN**
    - Receiver's ISN → sent back with **SYN-ACK**

### TCP Ports

- TCP packets have **two 16-bit fields**: source port & destination port
- A **port** is a _logical_ (not physical) connection component that identifies a running service
    - Example: HTTP = port 80
- Disabling unneeded services/ports reduces attack surface
- **Well-known ports** = first **1023** (list maintained by **IANA**, www.iana.org)

#### Key Well-Known Ports

|Port|Protocol|Notes|
|---|---|---|
|20, 21|FTP|File transfer; requires logon/password; more secure than TFTP|
|25|SMTP|Email servers listen here|
|53|DNS|Resolves URLs to IP addresses|
|69|TFTP|Trivial FTP; used for transferring router configs|
|80|HTTP|Web server connections|
|110|POP3|Retrieving email|
|119|NNTP|Newsgroups|
|135|RPC|Critical for MS Exchange Server & Active Directory|
|139|NetBIOS|MS NetBIOS Session Service|
|143|IMAP4|Retrieving email|

### UDP (User Datagram Protocol)

- **Fast but unreliable** delivery protocol
- Operates at the Transport layer; prioritizes **speed**
- Does **not** verify the receiver is listening/ready
- Relies on higher layers to handle errors
- Known as a **connectionless** protocol

---

## 4. The Internet Layer

- Routes packets to their destination using a **logical address (IP address)**
- IP packet delivery is **connectionless**

### ICMP (Internet Control Message Protocol)

- Sends messages about network operations; helps troubleshoot connectivity
- **Ping** — tests connectivity
- **Traceroute** — tracks the route a packet takes

---

## 5. IP Addressing

- An IP address = **4 bytes**, split into:
    - **Network address**
    - **Host address**
- Three main classes: **A, B, C**

### IP Address Classes

|Class|Network/Host Split|Hosts Supported|Format|Typical Use|
|---|---|---|---|---|
|**A**|1 byte network / 3 bytes host|16+ million|network.node.node.node|Large corporations/governments|
|**B**|2 bytes network / 2 bytes host|65,000+|network.network.node.node|Large corporations/ISPs|
|**C**|3 bytes network / 1 byte host|254|network.network.network.node|Small business/home|

### Subnet Mask

- Every network needs a subnet mask to distinguish **network bits** from **host bits**
- Important for **subnetting** and useful during **penetration testing**

### Planning IP Address Assignments

- Each network segment needs a **unique network address**
    - Cannot be all 0s or all 1s
- Each computer needs the IP address of its **gateway** to reach other networks
- Internet layer uses subnet mask to check if destination is on the same network:
    - If different → packet is relayed to the **gateway**, which forwards it toward its destination

---

## 6. IPv6 Addressing

- Developed to increase address space **and** improve security (IPv4 wasn't designed with security in mind)
- **128-bit (16-byte)** address → written in **hexadecimal**
- Provides **2^128** possible addresses
- Many OSs support IPv6 by default, but **many firewalls/IDS/routers may not filter it properly** — a potential security gap hackers can exploit

---

## 🔑 Quick-Review Summary

- **TCP/IP** = most widely used protocol; **4 layers**: Network, Internet, Transport, Application
- **Application layer** = front end
- **Transport layer** = encapsulation; TCP (connection-oriented) or UDP (connectionless)
- **TCP segment headers** = flags, ISN, source/destination ports
- **TCP ports** identify services; first 1023 = well-known
- **Internet layer** = handles packet routing (IP addressing)
- **IP addressing** = 4 bytes; Classes A, B, C
- **IPv6** = 16 bytes, hexadecimal notation

---
