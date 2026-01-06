1. **Explain difference between software and hardware write blockers, when would you use either.**
	1. HWB blocks any write command at the hardware level and read-only access is allowed, strongest level of protection in terms of industry standard even if the OS tries to write metadata or mount the drive. Highly reliable and testable 
	2. SWB is a program or driver installed in the workstation that prevents write commands through the OS, OS-level write commands interception. Runs as a service, kernel extension, registry, and application and prevents mounting volumes in write mode. 
	3. SWB is usually low-cost or free, flexible and easy to deploy. In contrast HWB can be expensive and limiting to interfaces, and bulky to carry around.
	4. Most of the time use HWB to guarantee no risk of altering evidence to preserver court-admissible evidence imaging, unless you need to dealing with virtual or cloud environments where HWB cannot be attached
	5. Key thing with both is to test them quarterly to make sure they don't fail
2. **Potential risk of connecting or imaging the device without write protection**
	1. Contaminating the drive and making it inaccessible in court
3. **Define cluster slack or file slack explain how its different than unallocated space**
	1. Leftover unused space inside the final cluster of a file, it exist as filesystem clusters are fixed sizes and rarely ends exactly on the cluster boundary, and the unused portion of the last cluster remain unfilled by the file's data
	2. File slack can contain old data from previously deleted files, RAM fragments, and leftover bytes not overwritten by the new files. Often a source of hidden residual evidence
	3. Unallocated space is space on the drive not assigned to any file, free space on disk. Contains whole deleted files, remnants, orphaned data, file fragments
4. **Define file carving how it works and what are the conditions to succeed**
	1.  Based on signature-based file recovery to retrieve files that are no longer tracked by the file system manager.
	2. When a file is deleted, even with the sector being overwritten the files may still have potential to remain recoverable within the unallocated part of the drive, and even when overwritten, file slack may still potentially store some residual data
	3. Carving relies on file structures because most files have signature like a header or footer, carving searches the raw data for these known signatures to identify the beginning or the end of a deleted file
	4. Limitation is only do-able on physical images, requires that raw data still exists on the disk
5. **Describe 2 methods to wipe drive and whats the difference between wiping and destroying**
	1. Overwriting: Normal disk sanitation, involves writing a known character, such as 00h, to all addressable locations on the media then verifying the action. Usually done through WinHex, Encase, or any other forensically sound applications or tools. However it is not approved to Top Secret Information.
	2. Degaussing: This method uses a strong magnetic field to randomize the magnetic domains on the storage media, usually renders the drive unusable in the process.
	3. Difference between wiping and destroying is wiping is designed to make the data unrecoverable through software means or by magnetically scrambling the media.
	4. Destroying is basically physical destruction methods to ensure the media is permanently rendered unusable and data retrieval is impossible by any means.
6. **Explain whats the purpose of wiping the drive before using it as a target and whats the danger if you do not**
	1. It prevents recovery of sensitive material, as data remains intact until it is overwritten or physically destroyed.
	2. It prevents cross-contamination to prevent any preexisting data on the host media from contaminating the evidence that will be placed onto.
	3. Danger: 
		1. Data recovery risk of sensitive material that was previously on the drive that could be potentially be recovered
		2. Cross contamination compromises the integrity of the evidence, making the evidence inadmissible in court
7. **Define hashing and what makes it useful in DF**
	1. Hashing is an algorithm used to verify data integrity be creating a message digest of varying length from a data input, which may be a message of any length. This message digest should be unique to that specific data as a fingerprint is to the specific individual
	2. Hashing in DF functions is to establish the integrity and authenticity of evidence to make it admissible in court. Hashing verifies file integrity to confirm that the evidence has not been altered or tampered with, or no external data has compromised the evidence. This helps maintain the chain of custody by providing a verifiable checksum to eliminate any suspicion off 3rd party intervention and leaves no room for errors regarding the data's state
	3. Hashing is used to create and utilize Hash sets or a Hash library. A hash set is a database of known hash values that forensic investigators use to steamline case processing
		1. Remove known good files by matching hashes against a database of common legitimate operating system or application file to eliminate the known good files from their case review
		2. Oppositely, it can match against databases of illegal or malicious files
	4. In Canada Evidence act, it addresses the authentication of electronic documents, where hashing provides integrity and regulates forensics investigators.
8. **Why is MD5 not used?**
	1. MD5 is known to suffer from extensive hash collision vulnerabilities
	2. Hash collision occurs when different messages result in the same hash value, and can undermine the verification of data integrity, which is the primary purpose of hashing
9. **Can you reverse hash values**
	1. Hash functions are designed to create a unique message like a fingerprint, but certain hashing algorithms can suffer from hash collision
	2. Tools can be used like Miracle Salad or CrackStation on be used to reverse hash values
10. **What is the apple file system**
	1. HFS+ and AFPS
	2. **HFS+ (Hierarchical File System Plus):** When using Boot Camp to enable dual boot capability on an Apple computer, the process automatically resizes the HFS+ partition to create space for the second OS installation. On HFS+ volumes, each file receives a unique, sequentially numbered identification number called the **CATALOG NODE ID (CNID)**, which is deleted when the file is deleted and cannot be altered, offering a great benefit to forensic examiners
	3. macOS can read NTFS but cannot write to it
11. **Explain what is journalling in ntfs**
	1. "Transactional" file system
	2. The core purpose of journaling is to ensure the integrity and robustness of the file system
	3. Transaction can be defined as any operation that alters the file system data or directory structure
	4. Atomic Operations: Once a transaction begins, it must be completed or rolled back

# Final 
1. Hardware and Software to bring
	1. Hardware Write Blockers like Tableau, they must be tested quarterly by either hashing a drive and checking the hash value a know value to that drive or by testing with software, also check for firmware updates for the write blocker.
	2. Hardware Imagers like Tableau can be brought on site as it provides fast imaging speed and better error handling when capturing data from laptop and external medias
	3. Different types of Cables for different devices like thunderbolt, or USB C
	4. Sanitized Drives like external HDDs to store the images, overwriting is preferred to be done through WinHex or encase, prevents cross-contamination to prevent preexisting data on the drive from contaminating the evidence that will be placed onto
	5. Search Laptop that contains software tools like FTK imager, EDD, Encase Forensic Imager, Cellebrite, Blackbag Macquisition, OSXpmem, LIME or Magnet AXIOM. Between searches the laptop needs to be wiped and before each search it need to have software preinstalled with a image, you will need to prove it is wiped, also regularly check for firmware update
	6. USBs with live forensics tools like FTK imager, EDD, EnCase or even Linux live boots like Kali Linux
	7. Consider about internet connection, mobile hotspots, sim card or portable modems
	8. Cameras with SD cards to take photos from the crime scene, it needs to be wiped clean before the search. Also bring extra battery and SD card for the camera in case you run out of memory or battery.
	9. Faraday bags/box
	10. Flashlight
	11. Notebook
	12. Drive labels
	13. Chain of Custody Tags/Labels
	14. Evidence Worksheet for the computer and Hard Drive
2. Examination of Devices
	1. MacBook
		1. Take photos of it and document it on your notebook
		2. Check for the power lighting or how heated is the MacBook, it might give you clues to determine if it is in safe sleep mode or powered off, document your assumption
		3. Regardless of the above situation, do not turn the device on and treat it as dead acquisition and aim to perform TDM. As RAM contents is written to internal storage in safe sleep, waking the MacBook will result in internal storage being wiped. And we don't have any information on if filevault is present or not.
		4. Bag the MacBook and charger as evidence and document
	2. Lenovo Laptop
		1. Take photos of the state of the laptop and document it on your notebook
		2. By Order of Volatility, the most volatile data like RAM should be captured first, by using FTK imager. Take notes of your actions for why we are proceeding with live memory acquisition, in this case it to obtain remotely stored emails or encrypted data possible on the laptop
		3. Observe and check for any encryption software icons on taskbars or pop-ups, by using EDD to check if the drive is encrypted or not. 
		4. Prepare the Hardware Write Blocker for Live Acquisition
		5. Perform live Acquisition with FTK Imager to create a Custom Content Image to capture volatile evidence related to the open Chrome browser and the active Gmail account, like history, cookies, cache or passwords. 
		6. Using Magnet AXIOM to collect cloud artifacts 
		7. After volatile data is captured, hard power off and bag it as evidence and document
	3. iPhone17 mobile phone
		1. Take photos of the state of the phone and document it on your notebook
		2. Check for if it is in AFU or BFU state
		3. Isolate the device into a Faraday bag to block all signals to prevent any over the air remote wipe commands or contaminations. Might want to consider double bagging. If possible to turn off network connections like WiFi or BlueTooth, turn them off. Enable Airplane Mode. Document all process
		4. Try to unlock the phone using the provided password, if success use Cellebrite for live file system extraction to collect all accessible decrypted data, physical extraction is not recommend as it would be time consuming. 
		5. If the provided password is incorrect, do not attempt more entries. 
	4. Samsung S25 mobile phone
		1. Take photos of the state of the phone and document it on your notebook
		2. As it is powered off, remove the SIM and put the phone in a faraday bag
		3. Document your findings from this interaction
	5. External Hard Drive and USB flash drive
		1. Take photos of them and document it on your notebook
		2. Label each device, and put them in evidence bags and prepare to take them back to the lab
		3. Document anything related to the drives
3. Broken Drives
	1. 500GB external Seagate
		If is slightly clicking and not being recognized as a drive, it is a firmware issue. Turn it off. Solutions like ACElab to update the firmware, or rewrite a module but might risk damaging the disk
	2. 1TB internal WD
		Find a compatible PCB donor and replace the missing PCB. After swapping rebuild ROM with PC3000 on the new PCB using the service area of the HDD