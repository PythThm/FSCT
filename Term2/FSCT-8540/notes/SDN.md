# Software Defined Networking
## Overview 
- modern networking paradigm designed to overcome the limitations of traditional network
- Seperates Control Plane (decision-making) and Data Plane (Packet forwarding)
- centralizes network intelligence into a controller

## Control Plane vs Data Plane
### Control Plane
- make decisions about traffic
- like routing protocols (Open Shortest Path First - OSPF, Border Gateway Protocol - BGP)
- or firewall/middle configuration
### Data Plane
- forwards packets based on rules 
- like IP forwarding or layer 2 switching

## Traditional vs SDN
### Traditional
- Each device has its own control + data plane
- distributed intelligence
- hard to scale and manage
### SDN
- centralized controller
- where switches become ismple forwarding devices 
- network is programmable 

## SDN Architecture
- Application Layer, Control Layer, Infrastructure Layer
- Northbound and Southbound API
- Apps talk down via the Northbound API to the controller, controller talks down through the Southbound API to switches and multiple controllers talk sideways through East or West Interfaces
![[Pasted image 20260408132158.png]]

## SDN Benefits
- Global networkq complexity
- Faster deployment of services
- Intelligent decision-making
- Automation of configuration
- Simplified management
- Better analytics and monitoring
- Created for Automation, Scalability and Centralized control

## Where SDN helps
- Data Centers with VM migration and layer 2 routing
- Routing for more flexible control logic
- Security with Traffic Filtering, Network Segmentation and Access Control

## How OpenFlow works (Southbound API)
Open flow is the most common Southbound protocol. Every SDN switch maintain a flow table with three columns:
- Rule - match fields like source IP, destination MAC, TCP port, VLAN ID
- Action - what to do: forwardtoq a port, drop, send to controller, or sent to normal processing
- Stats - packet and byte coutners

The logic on every packet arrival: match the header against the flow table, if matched, the action is executed, if not matched, the packet header is sent to the controller and ask what to do. The controller than installs a new rule fore future packets of that flow.

## SDN Controllers
![[Pasted image 20260408135351.png]]
Mininet is a network emulator that sins up virtual hosts, switches, and controllers on a single laptop. Used heavily for SDN research and testing 

## SDN Security 
The centralized controller is a main target as a common attack vector include DoS attacks on the controller, spoofing API messages (North and Southbound), an attacker spinning up their own rogue controller too hijack switches, and attacking overlay protocols like VXLAN or NVGRE which often lacks built-in authentication and encryption.

SDN can enable powerful new security tools as well. Six use cases are covered:
1. Traffic Filtering: 
	1. SDN switches as firewalls
	2. Anything not permitted is dropped
	3. Cisco ACI/APIC and ISE integration for device profilling and TrustSec tagging
2. Network Segmentation: 
	1. Spit one physical network into logically isolated slices segments
	2. Enforce strong isolation
	3. Actions in one slice cannot affect another 
3. DDoS Mitigation: 
	1. Detects attacks, sends data to detection system, controller updates policy
	2. controller pushes drop-rules to all edge switches, blocking entry points
4. Network Access Control
	1. Checks device's security posture before granting network access (IP, MAC)
	2. Quarantine compromised hosts automatically (AMQ)
5. Security Traffic Monitoring
	1. SDN controller uses cheap commodity switches as tap aggregators