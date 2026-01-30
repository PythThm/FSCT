# IOS
#### History Background
- each year new security feature
- internal encryption
- over the year the more challenging problem is the phone physical design
- rate of update is quite high
- liquid glass feature is bad
- summary of your text can be retrieved by forensics investigator
- they change location of logs from updates to updates
- crucial to know what version you are running

#### Security features
- pin codes, password (default is 6 pin)
- data encrypted by that password 
- passcode required instead of TouchID? failsafe system
- this is important for us as TouchID might be locked from us, when and when we cannot use it 
- 10 fail attempt means lock yo phone, can setup to erase your data 
- if the phone is factory resetted there is no way for **ANYONE** to recover the data 
- Face ID key feature
	- works in any environment, even if you are wearing a mask
	- Secure Enclave - stores all encrypted data, you need manual extraction to get it 
	- not even identical twin can face unlock 
	- ML, learn how to identify you over time (holy creepy)
	- same security feature as TouchID
- Lock count - Timed delays are enforced by Secure Enclave (A7 or newer processor)
- Secure Enclave
	- Stand-alone unit
	- everything are encrypted on iphone
	- each item is encrypted with different key
	- and Secure enclave store all those keys
- key feature of Secure Enclave
	- cannot be accessed directly, only when something needs it 
	- it is performing real life action, always on standby 
	- Apple pay, data protection, ICloud chain, secure bot
- IOS and iCloud also offer "Activation Lock", wirelessly locking the phone 
- IOS's file are encrypted with different keys, no way to get info from Secure Enclave and reverse engineer it 
- Boot Process
	- multiple steps, do not engage before the last step is completed 
	- internal verification
	- cellebrite puts an agent into the bootloader to extract data 
- "Trust this Computer" alert to prevent data leak to random cables (like in YVR)
	- "pairing certificate" will be created on the compyter
	- stored on /private/var/db/lockdown or programData\apple\lockdown
- UDID
	- 40 characters long
	- SHA-1 
	- also contains the MAC address
- BFU & AFU - again AFU less secure than BFU cuz everything is unlocked 
- DFU (Device Firmware Update)
	- manage firmware updates
	- makes it easy when you need to restore a damaged device to a health state
	- you can downgrade the OS, or jailbreak, etc. 
	- Getting into DFU requires specific steps
	- cannot tell if the machine is in DFU mode by UI 

#### Jailbreak
- procedure to get top-level access to file system of a device 
- in forensics, it allows you to extract the full file system and keychain data from iOS devices
- **Tethered jailbreak** is a jailbreak where you are required to perform the procedure everytime the device is rebooted 
- security vulnerability (many)

#### Keychain
- secure passcode storage

#### SecureRom
- initial bootloader
- first thing to run when its powered on 
- checks the physical phone, memory, data
- Checkm8 exploit
	- allows you get elevated rights on all apple devices 
	- its permanent as it is on hardware level (bootROM)
	- form of tethered jailbreak
	- cellebrite provides this feature 

#### Physical extraction
 - follow what cellebrite tells you to do (in slides)
 - get all data, recover passcode
 - UFED bootloader 

#### File system Extraction
- for new phones because it is the best option

#### Logical Extraction
- primary extraction you obtain
- option is to use Cellebrite insights 
- controlled brute-forces
- password protected is not the end of the world 


#### What if IOS device is wiped?
- factory reset removes all decryption key, physical extraction does not solve this in any way 
- "per-file" key is wrapped with on of the class key and stored in the metadata
