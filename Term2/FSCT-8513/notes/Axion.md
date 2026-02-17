# Basic
- process & examine - basically same tool
- examine is basically same thing with ftk
## Create the evidence
- case type - feature you select axion will tweak the evidence for that, he uses others 
- case file - make sure its not on OS drive and have enough space 
- location for acquired file - where that evidence path it is 
- case detail 
	- source - like os, devices, cloud
- Processing Details
	- OCR - optical character recognition
		- finding documents like PDF/picture
		- good for financial cases
	- Hash values - identify good and bad files to filter, always hash 
	- Categorize chat, AI feature that helps you, another AI feature with pictures (not 100% but pretty accurate)
- Artifact details
	- computer artifacts that axion processed 
	- a lot of virus tries to access powershell nowadays
	- often there are artifacts are not available, like prefetch files
	- some randomwares now deletes prefetch files 
## Case Overview 
- artifact categories 
- click on the case dashboard
	- different panels 
	- file system 
		- you can look at a file
		- previews, detail, hex
	- Artifacts
		- all kinds of evidence types axion processed 
		- you can see the information of that artifacts and metadata 
	- date time, it better be in the right timezone, UTC is probably the best 
	- Timeline
		- if we are interested what happened for a period of time
		- you can set time range from date to date 
		- in a real computer you would see a lot more on a single day 
	- create report
		- portable case -  the receiver does not need special application to open that

___
# Features
## Basics
- DelllatitudeLaptop.E01 - 50gb pretty good evidence 
- place to start - gives you overview of where to start 
- Timeline categoried evidence - takes time to load (bottom of the page i think)
- Timezone (bottom left) - important 
	- how do we know what timezone the evidence is from
	- registry contains that information
- Connections, what files is connected to another things 
## Registry
- timezone , Control > timezoneinformation > change your axion timezone setting
- in an actual case, document everything, you would take a screenshot
- you cannot bookmark registry in axion? (maybe)
## Artifacts
- refined results - what axion think its important for us 
- magnet collect files and folders opened 
	- accessing files through file explore will mark as windows explore 
- OS 
- log files 
	- mtfs file manager manages it
	- delete, modifications
	- 3 dots, filter on columns
- prefetch files
	- basically why magnet is preferred over other tools lol
- Amcache
	- getting hash values of an application , compare good hash values
	- amcache file entries shows the information for executables, gold mine
	- program entries, tracks the whole things, paths to uninstall. gold mine, or what suspicious thing they run 
	- device containers, shows hardwares connected at some point
- Documents
	- Carving or parsing 
	- carving shows the location, and the file was usually deleted
---
# Report
## What is needed?
- timezones (est), how do we check again? 
- bookmarks (ofc)
## Bookmarks
- the tab is on the right
- selecting or create a new bookmark 
## Timeline
- documents have multiple entries
- based on their metadata, time of when it was accessed 
- you can see the artifact informations, like caches 
- you can copy and past the artifact information links and see what its about 
- should you browse to the link? it might be malicious, check the links (bitdefender)
## Export options
 - csv over excel, maybe when there are too much lines to export
 - portable case means a smaller version of the case, only the chosen portion is displayed 
 - magnet review, helps team that is scattered to group up, using aws cloud 
	 - encrypted s3 bucket
	 - making it easy for multiple people to work on the same case over cloud
 - VIC - for CPs (not CyberPunk)
## Items to include
- recommended doing, clean up the tags a bit 
- summary information, you can or choose not to include it 
- sending links to other people - don't check make external link clickable? could be malicious keep it text 
- 