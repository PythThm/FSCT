1. **Explain the Packet and Circuit Switching. What are the pros and cons of each type?**
	1. circuit: dedicated fixed route, good for consistency, low and constant latency, ideal for real-time communication and simple in order delivery 
	2. bad for resource intensive, poor scalability, slow setup time and not fault tolerant
	3. Packet: data into small chunks as packets, individually routed through the network and reassemble at the destination
	4. good efficiency bandwidth use, highly scalable, fault tolerant and cost effective
	5. bad for latency, out of order delivery, not ideal for real time stuff
2. **What are the four types of network delay? Briefly describe each**
	1. Processing Delay: time needed for a router to examine a packet's header and decide where to forward it. error checking and looking up route table
	2. Queuing Delay: packet waitting in a buffer before it can be transmitted
	3. Transmission Delay: Time to push all the bits of a packet onto the link
		1. Transmission Delay = Packet Size (bits) / Link Bandwidth (bps)
	4. Propagation Delay: time for a bit to physically travel from one end of the link to other
		1. Propagation Delay = Distance / Propagation Speed
3. **What is DNS poisoning, and how does it affect users?**
	1. attacker injects fraudulent DNS records into a resolver's cache
	2. causing it to return a malicious IP address instead of a legit one
	3. also known as DNS cache poisoning or DNS spoofing
	4. Phishing, malware distribution, MITM attack, DoS
4. **Name and explain three vulnerabilities from the OWASP Top Ten as well as their mitigation techniques**
	1. Injections
		- sql injection, code injections
		- testing the code
		- simulate difference scenarios of faulty codes
		- test fault tolerance of that software, quality control 
		- manipulate http request
		- XSS, scripts loaded into web app 
	2. Broken Access Control
		- auth, wrong privilege
		- privilege escalation
		- purpose is to gain control, access, admin rights
	3. Security Misconfiguration
		- poorly managed firewall
		- just update software from time to time
5. **What is the difference between symmetric and asymmetric encryption?**
	1. one shared key vs key pairs (pub priv)
6. **What is the purpose of the TLS handshake?**
	1. for authentication, key exchange, cipher negotiation
	2. symmetric encryption for confidentiality
	3. mac and hash verification for integrity
	4. certificate chain for authentication
7. **Compare:  • Stateless Firewall vs Stateful Firewall  • Firewall vs IDS**
	1. Stateless Firewall 
		1. based on static rules on each packet in isolation
		2. no memory of previous packets
		3. checked individually based on its header information
		4. fast, simple to config, low cost
		5. easily spoofed, no context awareness, vulnerable to attacks (fragmentation)
	2. Stateful Firewall
		1. tracks the state of the active connections in a state table 
		2. understands the context of each packet
		3. makes decisions based on that context
		4. context aware, stronger security, harder to spoof
		5. slower, more memory, vulnerable to state table exhaustion (SYN flood)
	3. Firewall
		1. preventive, enforcement tool, actively blocks or allow packets based on rule
		2. access control, enforce network segmentation, prevent known bad traffic
		3. cannot detect attacks within allowed traffic
		4. cannot identify internal threats from already admitted traffic
		5. cannot recognize sophisticated attack patterns
	4. IDS
		1. passive, monitoring tool, detects and alert but not block traffic
		2. signature based or anomaly based
		3. good in detecting attacks within allowed traffic
		4. identifies suspicious patterns and behaviors
		5. provides visibility and forensics logging
		6. bad at no blocking traffic at all
		7. not detecting zero-day attacks it has no signature for
		8. does not act in real time to stop an ongoing attack
	5. IPS 
		1. is an IDS but can block traffic inline, combining detection with active response
8. **DDoS Attacks & Cloud Security**
	1. What is a DDoS Attack?
		1. Distributed Denial of service, attacker flood a target with massive traffic from many sources at the same tiem
		2. to make the service unavailable to users
	2. Why effective against cloud service
		1. auto scaling = $ $ $
		2. Shared infrastrucutre, 
		3. Volumetric exhaustion
		4. Complex and distributed origin
		5. Amplification
	3. DDoS Mitigation Techniques in the Cloud
		1. Rate limiting, Filtering, Dynamic reconfiguration
		2. prevention, monitoring, detection, mitigation cycle
9. **What is the main difference between traditional networking and Software Defined Networking (SDN)?**
	1. Explain two important benefits of SDN?  
		1. Centralized SDN controller handles all routing logic 
		2. Programmability and Flexibility
	2. Explain two attack vectors compromising SDN infrastructure.  
		1. Controller compromise 
		2. Control plane saturation (DDoS on Controller)
	3. Explain two SDN-based techniques for enhancing security in the cloud
		1. Dynamic security policy enforcement
		2. Programmable traffic monitoring and anomaly detection
10. **OAuth**  
	1. What problem does OAuth solve?  
		1. Authorization problem, how does a user grant a 3rd party app access to their resource without sharing their password
		2. OAuth allows a User to say this app can access "X" on my behalf without revealing their credentials to that app
		3. scoped and revocable access without entering your personal data
	2. Identify the role of resource owner, resource service and client in real world examples.
		1. resource owner, user who owns the data and grans permission to access it
		2. resource server, API/service that hosts the protected data and accepts access token
		3. Client, 3rd party application requesting access to the resource on the user='s behalf
11. **DNS Attack Scenario - A user is redirected to a fake banking website despite entering the correct URL.** 
	1. What attack is likely happening?  
		1. DNS Cache Poisoning
		2. Attacker injected a fake DNS record it the resolver's cache
		3. user redirected to a spoofed banking site
	2. How can it be mitigated?
		1. DNSSEC
			1. digitally signs DNS records using pub key
			2. authentic and untampered with
			3. forged records will fail signature vaalidation and be rejected
		2. Short TTL
12. **TLS Scenario - An attacker intercepts communication between a client and server.**  
	1. How does TLS prevent this attack? 
		1. Encryption, data transmitted after the handshake is symmetrically encrypted with session key 
		2. secure key exchange, key is never transmitted over the network, both sides independently derive it
		3. Integrity Verification with MAC - message authentication code
	2. What happens if certificates are not verified?
		1. MITM
		2. Impersonation
		3. broken trust chain
13. **Firewall vs IDS A company wants to: Block malicious traffic and Detect suspicious behavior. Which technologies should they use and why?**
	1. Firewall for all traffic that blocks packets based on rules
	2. stateful firewall to block out unauthorized access attempts, traffic from bad IPs
	3. IDS for monitoring and analyzes traffic that has been allowed through
	4. detect attacks hidden within legit traffic
	5. signature based for know attack patterns
	6. anomaly based detection to flag unusual behavior
14. **DDoS Scenario - A website becomes unavailable due to massive traffic from multiple sources.**  
	1. What type of attack is this?  
		1. DDoS, attacker use a botnet to overwhelm the server
		2. legit user cannot reach the server, availability is compromised 
	2. Suggest two mitigation strategies
		1. Traffic Scrubbing through CDN
			1. routing all traffic through a CDN like cloudflare or aws shield
			2. malicious traffic is filtered and dropped 
		2. Rate limiting and auto scaling 
			1. Caps the number of requests per IP per second
			2. blocks IP exceeding the threshold is throttled or temporarily blocked
			3. automatically spins up additional servers to handle traffic spikes
			4. combine with load balancing to distribute traffic across multiple servers 
15. **In SDN, what happens if the controller is compromised**
	1. full network takeover where attacker can install, modify or delete flow rules on every switch
	2. traffic manipulation, redirect traffic to malicious destination, MITM
	3. Security policy Bypass, Firewall, ACLs, security policies 
	4. Data Exfiltration, reroutes sensitive traffic through a controlled node for interception
16. **VNF Placement  - You have:  -Edge node (low latency, low CPU)  -Core node (medium latency, medium CPU)  -Cloud node (high latency, high CPU)  Where would you place:  Firewall , IDS, Video processing function. Justify your answer.**
	1. Quick Reference — Node Capabilities
		1. **Edge** Low latency Low CPU Lightweight, time-sensitive functions
		2. **Core** Medium latency Medium CPU Balanced, stateful functions
		3. **Cloud** High latency High Heavy CPU, compute-intensive functions
	2. Firewall -> Edge node
		1. firewall need to inspect and filter traffic asap
		2. rule matching (IP, port, protocols) are lightweight, good low CPU
		3. low latency ensures low delay 
	3. IDS -> core Node
		1. IDS performs deep packet inspection, more CPU intensive than firewall
		2. need to analyze traffic after the firewall has filtered threats
		3. medium latency is fine, IDS is passive and monitors only
	4. Video processing -> cloud node
		1. video transcode, encode and processing is resource intensive 
		2. cloud high CPU capacity is purpose built for this
		3. cloud allows elastic scaling, more instances during high demands
		4. cost effective, only pay for compute when processing is needed
17. **Encryption Use Case  When should you use Symmetric encryption and Asymmetric encryption. Provide a real-world example**
	1. Symmetric
		1. Encrypting large volume of data quickly
		2. both parties already share a secret key securely
		3. performance and speed are priority
		4. encrypting data at rest (storing data)
		5. example like encrypting a databased, file disk encryption, encrypting data in transit after TLS handshake (all traffic after TLS establishes session key uses AES)
	2. Asymmetric 
		1. Parties need to communicate without a pre shared secrret
		2. identity verification and authentication are required 
		3. digitally signing data to prove authenticity
		4. securely exchange a symmetric key over an untrusted channel
		5. Example: TLS handshake (HTTPS), email signing, SSH login
18. **Compare IPSec and TLS in terms of:  Layer, Use case Advantage**
	1. Layer
		1. IPSec: network layer, works on IP packet directly
		2. TLS: Transport/Application layer (4-7), specific application sessions
	2. Use Case
		1. IPSec: VPN, transparent to application, like corporate network VPN tunnel
		2. TLS: Secure web traffic, emails, APIs, application specific (TLS required) 
	3. Advantages
		1. IPSec
			1. Application independent
			2. strong for network-wide security
			3. ideal for VPN tunnels
			4. can enforce security policies at the network level
		2. TLS
			1. widely supported (browser, apps, APIs)
			2. Easier to deploy with not network level config needed
			3. end to end encryption per session
			4. good for internet scale application
19. **What security risks are introduced by NFV in cloud environments?**
	1. Expanded attack surface
		1. Virtual Network Function runs on shared infrastructure
		2. more component = more potential entry points
		3. APIs, orchestration layers and hypervisors can be targeted
	2. Multi-tenancy risks
		1. multiple tenants share the same physical hardware
		2. risk of data leak or cross tenant attacks
		3. poor isolation can lead to unauthorized access
	3. Hypervisor vulnerability
		1. NFV relies heavily on virtualization platforms
		2. if Hypervisor is compromised attacker can access multiple VNFs or control entire virtual network
	4. Malicious insider
		1. physical access to a data center and damage physical resources, but can be done remotely with NFV
		2. rogue admin, privileged access rights and gain access and performs unauthorized configs of VNFs
	5. DDoS Attack
		1. Attacker takes an excessive amount of resources making the system unable to satisfy requests from other users
20. **Describe the basic steps in an OAuth authentication flow**
	1. User requests access, tries logging, app needs permission
	2. Redirect to authorization server
	3. User authenticates and grants consent
	4. Authorization code returned and redirects back to client, sends authorization code
	5. Exchange code for token, Client sends the code + client secret to auth server
	6. Access protected resources using access token