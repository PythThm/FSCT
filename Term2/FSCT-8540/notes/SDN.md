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
