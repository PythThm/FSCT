# iOS Advanced Forensics 
## Intro
- stuff that are not obvious 
- hidden database, artifacts that will help us to solve a case 
- sim cards are not as important compare to 6 7 years ago 
- different types of extraction, logical can hardly get the database 
- full file system allows us to get most of the files, usually the best possible extraction
- on iphone we can do that unless we are dealing with the newest phones and iOS version

## KnowledgeC.db
- one of the most important artifact on iOS up until iphone 16
- sql database, contains info about user and system activity 
- everytime the device interacts 
- device interaction error, values between 0 and 4 
- 0 means no one touched it
- 1 means device is awake
- 2 means app activity
- 4 is enhanced usage of the phone, like using maps or games 
- iphone can only register 1 user 
- you can run sql commands or use tools like cellebrite or magnet 

## Biome
- streaming files
- similar to knowledgeC but not a single files and named much differently 

## SpringBoard
- homescreen process
- phone activity

## WAL file, write ahead logging
- like KnowledgeC, updated on the fly
- a lot of activities? iOS no option to update everything to database
- so iOS creates the WAL files
- kinda like the page file 
- default journaling mode on iOS

## SMS.db
- incoming and outgoing messages stored in sql 
- iMessage vs SMS? 
	- SMS is global, iMessage is for apple to apple 
	- iMessage is encrypted

## InteractionC.db
- mainly contains interaction, like msgs, phone calls, email
- user data going into and out of the phone
- does not mean it will cover everything 

## Powerlog & battery artifacts
- charge and discharge of the device
- power on or off, activity of consumption of power
- its not indicative of a user activity 
- can be triggered by system, should not be a primary source of information

## Keychain
- credentials, logins, auto generate passwords 
- tricky to get, full file system collection does not mean you can get this 
- to get the full file system with keychain, the collection needs to be encrypted 
- as iOS does not release the keychain file if not encrypted 
- it needs to be encrypted backup to be released by the phone
- iAD records 
	- relates to advertisements 
	- data collection to show you better ads 

## Timestamps
- apple Epoch system, unix epoch, Nanoseconds (iOS 13+)
- from a specific time, 2001-01-01, 1970-01-01 

## Additional High value iOS artifacts
- Photo.sqlite
- lockdownd logs
- safari history
- locationd
- Springboard crashes
- WiFi logs 
- ^ there are just small percentage of the important artifacts 

## Establish human interaction
- cannot be determined by only one artifact
- there are level of confidence we put in our report
	- based on a certain event, how confident this is done by a human 
	- you have to build your case
- if we look at the timeline where there are activities one after another, then there is a high chance there is user activities here

## Recommend tools
- Cellebrite Physical Analyzer
- Magnet AXIOM
- APOLLO
- ILEAPP
- DB browser for SQLite
- Graykey / Cellebite Premium
