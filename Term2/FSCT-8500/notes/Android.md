# Android
#### File system
1. Journaling Flash File system 2
	1. shift data so much it kills the drive
2. Yet Another Flash File System
	1. replace journaling
	2. it is hard to determine which chunk is which
3. Robust File System
	1. replace YAFFS, created by Samsung
	2. Easy extractable
	3. fully supported by Cellebrite
4. Extended File System (EXT)
	1. Linux based (ofc)
	2. big data files, way more efficient 
	3. fully backward compatible 
	4. there are not secret backdoors, very secure 
5. Flash Friendly File System
	1. newest file system
	2. a lot of small files in Android system
	3. better read write performance
	4. improving wear leveling performance
	5. fine tuned parameter to maximize the performance of the hardware 
----
# Android Security 
#### Android Encryption
1. 5.0, "Nexux" devices will be encrypted by default
2. but not all vendors follow up with this due to performance issues
3. starting from 5.0, hardware accelerated encryption mechanism 
#### Software vs hardware Encryption
1. Software
	1. OS based, flexible and more security features 
	2. relies on the OS or the software it is based 
2. Hardware
	1. used on board security to perform encryption and decryption
	2. self contained and does not require additional software
	3. free from possibility of contamination, malicious code injection, vulnerability 
---
# Acquisition
#### Rooting
- Getting root access to sensitive data 
- physical extraction or true file system extraction need temp root access
- each running app created a new user and setting up permissions for it 
- new type of root user is created to gain access to anywhere
- "rooting" is basically hacking into the Android system, exploiting a vulnerability 
- different phones are different to root into 
- debloating improve performance, altering system files, rooting for newer Android OS 

#### How to root
- most of the apps are paid (good ones)
- look for bootloader mode and evaluate access
- xda-developer forum
- manual root - "Odin3", step by step manual instructions
- often root procedure will wipe the phone, memory is being wiped during rooting process
-  rooting is no no in forensics 
- with ADB to access files folders and get complete physical image of the device

#### Tools
- SuperSU 
- KingoRoot
- xdadevelopers (most are android device)

#### Bootloader
- loaded at boot level
- have their own env, meaning it can be replaced 
- verify the hash signature of the system before booting, only OEM 
- keeping your phones safe and under warranty, but no modified kernel/OS
- unlocked Bootloader does not do verification on system, which can easily brick your phone

#### Soft vs Hard Brick
1. Soft Brick
	1. flashing the wrong rom
	2. phone stuck on the booting stage or reset itsefl
2. Hard Brick
	1. cannot power it on
	2. constant restart 
	3. the hardware is physically or logically damaged 
---
# Potential Evidence Extraction
## Physical Extraction
- always best case scenario
- bit for bit copy of the memory chip on the device
- getting a DD (clone) or E01 of a HDD
- able to carve for deleted files
- EDL mode, allow full access to data while encrypting data, cellebrite can force EDL mode
- downside is long time to complete depending on the size of memory 
- usually "data" partition is the main partition you want to obtain that contains user created data
#### Tools and techniques
1. enable developer mode
2. stay awake 
3. UFED touch and MOBILedit will load a temporary exploit to get root privileges
4. temporary exploits is not copied into your user partition, its onto the system partition
5. if it is the only option, document it and court would not challenge it 
6. you dont even need to know the password from physical bypass exploits
7. Attempting to root the device or flash a custom recovery partition will risk wiping or modifying user data
8. physical extraction when everything else fails
#### Physical Extraction Mode
1. ADB (Android Debug Bridge)
	1. allows device debugging, to perform physical or file system extraction
	2. if device not rooted, forensics tool will try to get root privilege
2. Boot Loader Mode
	1. Like BIOS mode
	2. OS is not running, the device cannot connect to mobile network
	3. bypass any user lock 
	4. Bootloader extraction does not support extraction from a memory card 
3. ADB rooted
	1. only when phone is rooted
	2. for sure physically extraction is possible
---
## File System Extraction
- Still requires root priviliges
- Full file system = all active files (allocated only)
- faster acquisition time, better than chip-off 
#### Android Backup
1. not a full filesystem extraction but will give you some system files and all media files 
2. Facebook and WhatsApp are omitted from the Android Backup
3. Downgrade the backup APK may allow you get the data from those blocked apps not in backup
4. only nothing works then android backup
#### APK downgrade
- downgrade a version of an app
- very risky, you can logout of a software
- it support 4.1 and above
- this is the last step you should take
#### Tools and techniques
- if device cannot be unlocked, physical extraction might be required
- JTAG or chip-off are the next step
---
## Logical Extraction
- no deleted data, no carving
- UFED 2 speaks with the device in its native language 
- while requesting all the information available by the device through API call
- from 5.0 to 8.0, there is a chance the device will be encrypted and encrypted on by default
- there are ways to brute the pin code
#### File-Base Encryption
- new shit to copy iOS
- Cellebrite cannot bypass it, requires an actual password
- not all phones are like this YET
----
# Determining what is possible
- How much memory on the device?  
- What Android OS version shipped at the release date?  
- What Android OS version it can be upgraded to?  
- What type of data and tools can be used to gain the maximum information out of the device.  
- If you want to do a chip off, beware of Android 5.0 or newer devices that potentially have encryption turned on by default.
---
# Flash Memory
#### Definition
- Non-volatile
- small physical size
- increasing memory capacity
- shock resistant
- low power consumption (no need high voltage power)
- fast read write speed

#### EEPROM - Electronically Erasable Programmable Read-Only Memory
- can be written a lot of time
- depends of the parameters and the quality of the Memory
- After reaching the max amount it wears out and bad sectors it is

#### NOR vs NAND
1. NOR
	1. old chip
	2. much more reliable than NAND
	3. different factories 
	4. good for high speed random access
2. NAND
	1. partitioned, divided into blocks, each block divided into pages
	2. much cheaper than NOR
	3. more manufacturing for NAND
	4. better with sequential logical address, slower when random access
---
# FTK Imager
- android system have a lot of partitions
- a lot of them are unallocated
- partition 20 usually stores the user data 
- all kinds of tool does one type of extraction (so different tool different purpose)
- data > com.android.browser > database > browser2.db > right click export and save on your computer > lanuch app "DB browser for SQLite" > open database open the saved db > browse data > Tables (different information) 