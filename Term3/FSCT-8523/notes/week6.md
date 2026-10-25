# Introduction - GPT, create a note from this lecture make no mistakes
- every apple system have their own artifacts, same company kernel but different acquisition rules
- starting from 2019, there are a lot of changes, bringing APFS to mobile systems
- apple like changing sutff around unlike windows, shifting artifacts location, types and what they contain, every september you relearn shit 
- meaning big vendors for extractions needs time to update their software around the same time each year, and we have to be careful around that period of time
## SSD
- embedded memory on board, it is upsetting cuz you cannot do your own upgrade
- sometimes dying prematurely, then data recovery is shitter 
## Apple devices are hard :fire:
- you need a mac to analyze a mac, mostly true. 
- security shit the keep adding is annoying, 72 hours feature <- annoying 
- celebrite comes up with solutions and options that can over come BFU after 72 hours
## Database
- does not have to have the same name and extension
- carvable header tho for SQLite
- memory file are extremely important for forensics in SQLite db
- Plist:
	- stand-alone file, small in size, contains setting or user information
	- can be helpful for finding small bit and pieces of data 
	- something like airdrop feature on mac if its enabled or not 
	- comes in different filetypes that might require tools to anaylsis
## Mac SIP 
- if enable SIP, apple says you lost warranty 
## Mac acquisition decision tree
- do i have the tool
- what do i do with time ticking down, what artifacts do i have to look at first 

## Demo
- setup: mac, using blackbag special dongle, formatted ssd drive, adapter to plug the whole thing in
- 2 ways, live collection or boot from it
- 5 volumes, windows app you can launch it in windows (god knows why)
- launch MacOS app volume, see if we do deadbox collection
- **browser** allows you to browse files (who would have thought)
- right click add to collection will start process to custom file collection
- **search** option, usual stuff and add them to the file collection
- **collection** is a nice feature that creates a summary of things it found, software update, sys logs, OS version, user data, wifi data, download folder. Super convenient for fast collection
- 