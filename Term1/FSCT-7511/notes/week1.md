1. OS
	- Resource management
	- efficient and resourceful way to manage the system
	
	> OS security
		- as computers are highly interconnected, vulnerabilities appears
		- why are we talking about cloud (literally why tho)
		- how is OS managed on cloud servers
		- there are more security concerns with larger systems

	- CIA Triad
		> Confidentiality
		> Integrity
		> Availability
	
	- Vulerability and Attacks
		- Common weakness exposure
		- the breakdown of the CIA Triad
		- a threat or risk
		- opens the door for attacker to break in
		- cloud storage s3 bucket	
			- if you make it publicly availalbe then everyone will have the access to it, read and write
			- unauthorized access
		> Attacks
			- Passive: attacker is not visible, collect data, eavesdropping
			- Active: attempt to actively make changes to your system
			- Insider: more access, priviliges, part of the organization
			- outsider: need to find security holes and try to exploit it 

		> Countermeasures
			- Difference in depth, different layers of protection for the system
			- Pen testing 
			- It may result in new vulnerabilities (no software is bug free)
			- no system is 100% secure, 0-day vulnerability
	
2. Linux
	- Kernel is the main "brain" of linux 
	- Main component for the software to communicate with hardware level
	- Shells, cmd or script to control the system
	> File System
	> Command Execution




In-class activity 1 - ATM 
	- The PIN is your Confifentiality (your own information)
	- The machine always being on
	- Integrity, everything you access should match with your actions (money remains the same)
	- You put the money in your account, you have that money in your account
	- The money is always available for you
	- All 3 needs to be in place to be "secure"
	- The card belongs to yours
	
	Vulnerability
	 	- Card reader
		- Stealing your card
		- If the code of banking is vulnerable, and you are withdrawing money that does not match, no integrity
		- If there's an insider to manipluate the software
		- If there's a hardware failure, bots in the system, hajacking the system 
		- Confidentiality is more vulnerable in this scenario

In-class activity 2 - CLI is more secure or GUI? why?
	- If you put the same logic in both, but since the GUI is a software and with an extra layer of code, there are more vulnerabilities 
	- Minimal component that does not bring extra vulnerability to the software 
	- IMO still if you are talking about a well configed GUI and admin level access (secure) to the CLI, GUI is more secure as you can restrict what a user can do within the GUI even though there might be more vulnerabilities due to more code. If an attacker have access to the CLI (which usually have way more priviliges and power than a normal user using the GUI), CLI is less secure in this case.
	- And also you can segament out user that is using the GUI, its called access control

