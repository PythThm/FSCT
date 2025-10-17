#==Week 6==

# What is vulnerabilities
- attackable surface area
- different entry points
- apis, file transfers, packets

> Software Management policy
> 	- use standard software installers/package installer
> 	- `sudo apt update && sudo apt upgrade -y`
> 	- keep system up-to-date, update to fix bugs or security vulnerability
> 	- keep logs of system updates
> 	- Don't auto update in critical environment, don't do it with crontab 
> 	- Be prepared to undo updates

> Removing Bloatwares
> 	- outdated webservers
> 	- unnecessary compilers
> 	- depends on type of system, keep only required packages

> How to install "GOOD" packages
> 	- check sources
> 	- rpm -qi
> 	- should point to the url to the trusted source

# CVE
- Hell yeah, Common Vulnerability and Exposures
- bro just go back to shanti's notes if needed lmao
- she literally talked about it for 3 mins 

# xinetd
- collection of legacy service
- /etc/xinetd.conf
- "super daemon"
- will start other daemons or stop one when needed

> Configs
	- cpu: limit connection attempts 
	- instance: how manay concurrent connections are allowed
	- per_source: how many concurrent connections from a specific host are allowed
	- includedir: the directory where additional rules can be includeed

> FIles in /etc/xinetd.d
> 	- the file in this directory override and supplement setting from conf file
> 	- options to do stuff
> 	- 