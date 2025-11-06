# Mobile Forensics

# Introduction
- 99% of the investigation
- extremely important in terms of data
- vast majority of data and information
- Chats, communication, emails, digital media
- Legal case example: the warrant did not include the search on the mobile phone
- The search warrant would say any digital device can be searched 7-8 years ago
- the only removable device is the SIM card
- you cannot really separate the hardware from the phone, unlike PC where you can take it out and work on it as an individual unit
- the phone is the entire unit, you have to work with everything
- Geo-location is constantly tracked

# Whatever he is saying
- OS > Data > Boot
- Boot partition can be change be temp loading agents, side loader
- in order to get the phone to load itself in different mode
- kinda like jail breaking
- writing data into the phone

# SMS, MMS
- Short Message Service
- your daily messagers bruh 
- wechat in china is EVERYTHING 
- End to End encryption
- whatsapp have a decryption key in its database???
- Signal tried to cover the tracks and not able to recover msgs??
- Signal cellebrite, it started out shit, later forced 

# Cloud Stuff
- Dropbox, email, pornhub (JewJewJewJew)
- cloud storage, cloud app on yo phone
- Be caution

# Passwords
- People stores passwords in plain sights, like notes
- some uses password managers 
- passwords in text messages

# **Whatever we find in the phone are called artifacts**
- mobile artifacts
- logical and physical artifacts
1. Logical
	- logical is what we can see from the GUI 
	- Messages, what you can see, does not require any tools to view
	- it is limited piece of data the be used
2. Physical
	- Physical data is something you need tools, time, skills, training to collect
	- Deleted messages 
	- In any phone you have database, ie, sms.DB
	- inside a table, numbers, content of the message, datetime, from to, whatver, exist or not
	- metadatas, device model

# Ways of evidence contamination
- Whatsapp usually strips or alters file metadata to send msgs faster
- Physical corrosion caused by small micro organism
- proper cleaning with isopropyl alcohol

# Types of phones
1. old phones 
	- basic phones, flip phones, button phones
	- biggest challenges is how to connect to these phones
	- cellebrite divert most attention to new phones, old phones are not supported an loved
	- Old phones are still seen everywhere and people still uses them
2. Burner Phones
	- Better call Saul 
	- In canada, when you buy a phone line you have to identify yourself
	- unless it is a prepaid one
	- most of device you buy in canada you have to be know on the net
3. Smartphone
	- When they come out the definition is shit
	- if you have smartphone you have touchscreen, internal memory, can install softwares
	1.  IOS
		- Face id, fingerprint, surface security stuff
		- secure enclave, encryption only
		- Controlled brute-force, so it does not lock the phone
		- brute-force passcode are throttled and monitored
		- Uses APFS, 2 partitions, system and data (sometimes cache)
		- You can boot into boot or recovery mode
		- Default Data Encryption
	2. Android
		- Linux
		- not always encrypted by default
		- To extract data, we use more aggressive ways to get in
		> Rooting
			- Admin 
			- root user has all write
			- rooting the phone means introducing something to the phone
			- you can get all the data
			- xda developers - website for jailbreaking and rooting phones
			- it has become problematic
			- it requires viping of the phone

	3. Blackberry
		- Used to be good, protection was good
		- just not at the right place at the right time
		-  accent on security and encrpytion
		- good thing about it is smart enough to put a loophole in the os to provide you with data
		- meaning the police have backdoor access to a blackberry phone 

# Types of Forensic Extractions
### **Logical > File System > Physical

1. Logical Collection - User-level backup
	- Relies on the device itself or software agent to extract data
	- Data already interpreted
	- Fast 
	- cannot recover deleted data
	- What you see, what you get collection
2. File System - Full directory tree
	- when we not only collect data, but also the File system DB
	- DB that stores information
	- Geo-location, user database, metadatas, when the phone is updated, installed
3. Physical - Full raw image
	- copying from the first to last sector 
	- gives all databases access
	- Deleted files

### Additional way to extract mobile data
- what if cellebrite does not work
- no usb debugging, no manual extraction, literally taking photos of the screen
- how would this be legally accepted? no other choice but well-document it 
	1. JTAG
		- Physical connection onto TAPs on the motherboard
		- It is powered on, but the phone is not there
		- Bunch of adapters, connecters
		- Clone the content of the flash memory to outside
		- Does not help with chip level encryption device
	2. Chip-Off
		- Physical data extraction that removes the memory chip
		- read it raw
		- Works even if the device is physically broken, broken ports or unbootable OS
		- Rarely be reassembled
		- read it as external data, using external readers
	3. Microread
		- Read flash memory by electron microscope
		- Exist but rare??