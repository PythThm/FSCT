# Vulnerability on protocol stack
1. Physical
	1. physical security
	2. unauthorized physical access
2. Data link
	1. MAC Spoofing
	2. ARP poisoning
	3. VLAN hopping
	4. Switch CAM table flooding
3. Network
	1. IP spoofing
	2. route hijacking
	3. ICMP abuse (smurf attacks)
	4. Exposed routable IPs
	5. DDoS via spoofed IPs
4. Transport
	1. Exposed TCP/UDP ports
	2. SYN floods
	3. Port scanning
5. Application
	1. SQL injection
	2. command injections 
	3. code vulnerability

# Network metrics
#### Bandwidth
- Bits per seconds
- maximum rate of data can be sent over a link

#### Goodput and Throughput
- Goodput = Useful data to send / Time required to send
	- 10 MB = 83.8861 mb / 12s = 6.99Mbps
- Throughout = Actual Data to send / Time required to send
	- 11 MB = 92.2747 mb / 12s = 7.69Mbps
- Goodput = Useful data / Actual data x Throughput (Bandwidth)
#### In-Class activity 3
1. Throughout = 10Mbps
2. goodput = 10 x 484/530 = 9.13 Mbps (or 53 seconds from throughput and then divide with 484)
3. 484/530 = 0.913
4. total packet size = 41+46 = 87, time needed = 87/10 = 8.7s, goodput = 41/8.7 = 4.71
5. 41/87 = 0.471

#### Delay Calculation
- Transmission delay = Packet size / Transmission rate
- One way propagation delay = Distance over time = velocity, two way just multiple time by 2
- RTT = 2 x propagation delay + TD
- Traffic Intensity = Avg packet size (L) x Number of packets arriving per second (a) / Transmission Rate

#### Traffic Intensity vs Querying delay
1. La > R = congestion
2. La < R = not a problem just extra resources
3. La << R = Router is idle and utilization is low
