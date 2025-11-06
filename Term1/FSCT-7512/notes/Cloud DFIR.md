# DFIR
- structure, step by step framework, company have their own procedures 

# IR Stages
1. Preparation
	- plan, roles
	- what is responsible for what, and who
	- who to call when incident happens 
2. Detection (Technically the first step)
	- Tools gives us notification
	- usually comes instantly
	- false alarms or true incidents
	- review logs of what trigger an alarm 
	- find patient 0, find if it is an actual incident
	- test, engineering attempts
3. Containment
	- Dealing with the actual "bad thing"
	- not as easy as it sounds
	- pull the plug, remove the drive, scan it with antivirus (home)
	- what if large company, government stuff, airport
	- identify which part to isolate 
	- fight against the clock
	- most action field 
	- faster you can block him, faster you can recover the damage
	- sometimes its simple like password changes, reboot, firewall reconfig
	- must preserve evidence in its original form, to analyze what happened 
4. Eradication and Recovery
	- Rebuild from scratch or from build
	- cooperate with other teams
5. Investigation and Analysis
	- where it started from
	- human factor, attacks 
6. Reporting
	- Documentation
	- analysis
	- not technical 
	- summary of what we did
7. Post-Incident Reviews
	- Review ports policies

# DFIR Tools and Technique
- collect artifacts and evidence
- we have to act fast 
- know what artifacts to collect 

# Windows host resources
- check XML files, prefetch files
- prefetch is a window feature to save time, a database
- windows event logs
	- IP address, auth logs, sesh ids, metadatas
	- services installs
	- drive changes
	- hardware changes
	- powershell script logs, we recover deleted powershell scripts
	- RDP activities, logins 
- Amcache, database stores information about application compatibility
- Registry
	- different hives, they are databases
	- 2 different forms, not used by system, or virtualized by windows when its active 
	- they are not concentrated in one place
	- SAM
		- user information, access to the system, policy, hash
		- Attacker will go here to get themselves access
	- SOFTWARE
		- if they tried installing anything
		- we will see the trace in the hive
		- policy for accounts
		- unsecure policy changes


# Linux 
- Crontab (event scheduler)
- var, event logs

# Other Artifacts
- inside and outside of the instance 
- usages 
- RAM, memory forensics
- it disappears when system shutdowns
- 