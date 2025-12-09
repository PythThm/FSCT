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
9. 