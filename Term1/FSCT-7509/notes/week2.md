Week 2 notes - FSCT 7509

Our mistakes will cause us the case, even our career, so we need to be etra cautious

Its not easy to be relied on without having to monitor you

Always be prepared, always have more than one tool for each type of info, be prepared for different environments that you have to work on, system may lock you out, different cryptography, encryptions, hidden datas etc
Damage devices are sometimes dealt with as well

Theres a small ssd drive on old imac's motherboard????

^ so basically do your research, prepare for every scenario that can happen and think of the impossible 

ssd is less reliable than HDD 

How HDD works

Know your targets
	- Servers
	- OS
	- Large number of random systems 
	
	Do you need a sys admin?

Challenges on Site
	- Company servers
	- Devices that should never be shutdown
	- Limitations on Search warrants (you are allowed in at specific time, a lot of privacy issues)
	- The criminal code of canada outlines the boundaries we can go into
	- large amount of machines

Officer Safety
	- Its a primary concern (cuz we aint armed)
	- Protective clothings 
	- Ensure evidence is safe to handle
	- Ensure residence is secure before you enter (the environment is safe to enter)
	- Visiblitiy
	- video surveillance, assume you are always being watched

Handling The Computer
	- Should you power it on?
		> Press shift to wake up the Computer without making any changes to the machines
	
	- Privacy protection software
		> Reason to isloate computers ASAP entering the residence
		> Software pkgs to remove all traces of user activities on a computers
		> Marketed as "Privacy Protection:
		> May be configured in windows setup

	- Considering disabling remote access
		> Like ethernet ports
		> Things that can run scripts without human interactions
		> Advantage: prevent malicious activity
		> Disadvantage: you might just disconnect it from cloud servers or anything that is connected to the web 

	- Live memory and Processes
		> Consider the collection of the live memory, process information and connections
		> Certain programs might not have saved changes or update metadat until they are properly closed
		> other programs can overwrite potential evidence when closed
		> There is not a single procedire that fits into every investigation
		> DO DOCUMENTATION ON EACH OF YOUR STEPS THROUGHOUT THE INVESTIGATION
	
	Do not use the target computer unless it is necessary to preserve evidence
	Photograph Screen Contents
		- its a guided process
		- with a certain device/camera
		- never reuse a used storage device, wipe memory before next investigation

	- Preserving the whole computer
		> Sometimes you have to take the whole device with you if it is something you never dealt with

	- View Opened applciations
		> Take a picutre
		> Document the process and what you see
		> everything is an evidence
		> Whos the current user
		> version of the system
	
	- Consider pulling the plug
		> once we confirm we can obtain the data (meaning data is not encrypted)
		> we can turn off the device
		> It potentially triggers some scripts if you press the turn off button
		> You pull the plug, it keeps the most fresh state of the hard drive
			> this might corrupt the data
			> hard drive need a proper way of shutting down 
			> the pin might even get stuck, hence it would not spin up when you boot it up
			> Consider the situation, if HDD don't, SSD maybe
	
	When seizing a laptop, assume the hard drive remains inside, the battery should be removed if possible

	- Look inside the computer
		> See if there multiple drive, even if they are not connected
		> You will need to have another warrant for that
		> See if theres anything that will conteminate the investigation
		> Account for where the cables
			> Cuz you might need to return the device after the search
		> Passwords: 
			> Most people dont have a secure way to manage their password
			> Lots of people just write down their passwords 
			> Always look under the keyboard to see if they write down the password
			> Sometimes you have to look "Outside of the box" to help with your investigation
	
	- Cellphones
		> We dont really want to power them off
		> There are protection issues with the phone
		> Document the state of the phone
		> Capture the screen if the phone is ON
		> Remove the battery from the device if its off
		> Incase the battery is built-in, Power off the device only if you know that no password/encryption exist
		> BFU, AFU
			**** AFU is important in iOS forensics because it allows access to a much larger pool of data compared to the limited data available in a BFU (Before First Unlock) state.
			**** In an AFU state, investigators can retrieve user-generated content and application data that may be crucial to a case.
		> Some devices if removing SIM card it might remove the data
		> Tape the SIM to the device
		> Secure device in Faraday Bag, RF shielded bag (if the battery is built-in)
		> Document all actions taken when handling the seized device
		> Locate unique identifiers for the exhibit
			- Make
			- Model
			- IMEI/ PIN / serial number
			- SIM Card

	- Smart watches
		> Apple watch
			- Can be used to unlock a Mac computer when in proximity
			- Cannnot unlock iphone
		> Android Wear
			- Using trusted device, Android wear can use to unlock them 

Encryption
	- Trust your eyes
	 	> Examine the icons on the task bar
		> Look for cryptographic applications in the programs menu and desktop
		> Look for suspicious applciations or processes that might be runnning (in task managers)
		> Look for green files

Exhibit packaging and transportation
	All components to be seized must be:
		- Labeled with exhibit number
		- Datetime
		- Initials of officer/analysts seizing the components
	
	- Anti-static bags should be used first
	- Regular plastic evidence bags can generate static electricity
	- When we touch the device, always ground yourself (like touching the desktop case)
	- In Labs, we ground ourselves with special bracelets
	- Use grounding mats
	- Document serial unmber/ significant identifying marks
	- Docuemnt and photograph existing damages

Locard's Princicple of Transference
	Edmond Locard
	- Claims anyone will leave a trace of evidence behind them in a crime scne
	- If a suspect interaced with the computer there should be evidence to indicate that interaction
	- Take any external hard drive will leave traces, the registry already logged that interaction
	- We don't directly connect hard drives to the computer as it might temper with the data
	- Anyone who interact with digital system leaves something begind. Therefore imaging is importand to image ourselve in the environment
	
	Daubert Standard
		- Methods used should be reviewed and tested by scientific community
		- Any tools techniques or processes used should bre widely accepted in the computer forensic community
		- No inventing new test or procedures
		- Based on Daubert vs Merrel Dow Pharmaceuticals
		- Tools created -> tested -> investigated -> then widely used

Canada Bill of Right Chapter 8
	- Everyone has the right to be secure against unreasonable search or seizure
	- Reasonable expectation of privacy limits investigators and force us to strictly follow rules in search warrants
	- Police officers if have a reasonable doubt to search you, they can indeed search you
	- You only have to right to ask for the search AFTER the search, you can then file a complaint if theres not a good reason for the search 


Forensic tools and methods can basically get a hold of your personal life

1. Hard Drives
	- Main storage media for most computers
	- Holds Boot files, OS, program and data 
	- From 4800 to 15000 rpm
	- Hard then platters are magnetized and accessed by heads moving across their surfaces
	- Heads can write or read, detect or create microscopic changes in polarity as the move about the spinning platters
	- Positive charge being 1 and negative 0, the binary system

	- Bad sector on a drive means the area is not usable, so sometimes drives have less logical heads than physical heads (Just meaning that the number dont match)
	- Same as CPUs 
	
	PList
	- Defines the bad sectors of the drive
	- Hard drives always have reserved tracks to use available service area
	- it creates another module calls GList
		> keep track of all the bad sectors on the drive
 
 	Symptoms of bad drive
	- Slow 
	- OS constantly restarting/not botting/BSOD
	- Drive freezes upon imaging
	
	Solutions
	- Retry
	- Read without ECC (Check sum Corrector)
	- Increased skip
	- Reduced timeout
	- Reverse reading
