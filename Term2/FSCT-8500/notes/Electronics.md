# Question from Quiz
1. **Describe the steps you would take when examining a water (or any other liquid) damaged device (at least 5 steps)?**
	1. plug in the usb voltage meter, and plug your phone into it, usually a phone will have a current around 1 amperes, 0 means there is no power flow and something is shorted, 4 or 5 amperers means something get shorted and gets grounded or the current flows directly back to the battery, 0.4 or 0.5 amperes means there is a flow of power but some of the major components got damaged, such as the CPU or memory . Find the component that is shorting the phone
	2. Take out the battery
	3. take out the board and examine the damage 
	4. use heat gun and remove the metal panels 
	5. manual cleaning the board with a good brush, isopropyl alcohol or branson solvent 
	6. ultra sonic device, remove the dirt and dust from the board 
	7. inspect the phone through a microscope, the potentially damaged components
	8. micro soldering to repair the damaged parts 
2. **What is the advantage of using the ZXW tool (the mobile device live schematic software tool) when repairing an electronically failed mobile device?**
	1. Allow the user to get access to any schematics of any phone, every component have its description about it and what it is connected to. 
3. **When examining a mobile device, name three the sources from which the examiner could harvest Geo location data:**
	1. GPS or location service logs
	2. Application data/cache (Google map)
	3. EXIF data from photos (Exchangeable Image File format metadata)
4. **Provide 3 examples of information you could extract from a plist file in iOS**
	1. pairing certificate
	2. UDID (Unique Device Identifier)
	3. WIFI interface MAC address
5. **Explain the logic behind the naming convention of iTunes backup folders.**
	1. Naming convention of iTunes backup folder is using the UDID (Unique Device Identifier), since the UDID is unique to each device (each calculated by serial number, ECID, MAC addresses), prevents conflict if multiple devices are backed up to the same computer. Everytime the same device is backed up it would write to its own backup folder. 