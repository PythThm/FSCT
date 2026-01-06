# Week 1 

#### Course Info
- "hands on labs"
- March 3rd guest speaker from Celebrite
- Final and midterm in person, same format as term 1
- Keep the answers organized, like in the final for Intro for Digital forensics 
- Email him for office hour, make sure to mention 8500 FULL TIME on subject line

#### Introduction 
- Finding and identifying
- Preserving and analyzing SIMs and Media cards
- getting artifacts and evidence needed
- Interpreting geo-location data and apply to the case
- Note taking, submitting full forensics report to describe steps taken during investigation
- phones can be kept as evidence up to 6 months 

#### Mobile Forensics
- 50% of the job is collecting the data, complicated process
- mobile phone can be simulated to our "digital DNA", reveal key info about a person
- Message communications are almost exclusively done through out phones
- Photos and videos, Phone > dedicated cameras
- "winevt" - window's Event log, "windows/system32 config" - window registry 
- Compare PC to mobile, can you access the system files easily?
- to access the specific folders to collect data, how hard it is compared to PCs?

#### Data recovery
1. Logical: Can be viewed through the GUI, does not require any tools, programs 
2. Physical: Requires special tools and training to view and interpret, such as metadata, geo-data

- How accurate is the data we collected? 
- celebrite can pull the data but misinterpret the data, what if the timezone?
- compare the actual text message with the info celebrite given, make sure its accurate

#### Validation
- "Trust your eyes", Cross tools and compare 2 reports 
- Call detail Records, verify the CDR with the provider to remove concerns about the number being spoofed 
- Manual carving, navigate into the file system and locate the artifact in raw encoded state

#### SOP - Standard Operating Procedures
- Starting from assembling disassembling device to collecting data
- Organization have their own SOP to handle mobile device
- How the mobile evidence should be examined and verified
- Different way from handling HDD
- its like a flow chart, step by step guide on what to do when making a decision
- When new approaches examining mobile phone comes up, we change to them 

#### Data Contamination
- phones data are volatile
- environmental contamination or unintentional contamination
-  OTA, application that wipe stuff, remote wipes on Andriod
- Other device with remote control capability
- Airplane mode, keeping the cellular signal blocked but can allow WiFi and Bluetooth signal to come through 
- Faraday bags, aluminium methods, faraday room, tents boxes

#### Legal aspects of mobile acquisition
- charter rights chapter 8, search and seizure
- obstruction with search can happen? 
- Search warrants are usually the legal requirement for a search and seize process
- Outline specific mobile phones are required in the warrants, if not the evidence will be disqualified 
- supplementary search warrant to complete the investigation
- additional information: subscriber information from cell companies 

####  2 ways of collecting data
1. Destructive
	- Break something 
	- unsort somthing
	- will not get back to its original state
	- you will need to get another warrant for this

#### Civil search (Civil Subpoena) (Anton Piller)
- rarely happens as its very hard to get one approved 
- family, company conflicts  
- even more restrictive than a search warrant 
- Judge will have to think of how a warrant can be intrusive towards a person's life 

#### MNO vs MVNO
- Mobile network Operator vs mobile Virtual Network Operator
- Rogers, Bell, Telus, Freedom 
- 90% on MNOs, 10% on MVNOs
- 