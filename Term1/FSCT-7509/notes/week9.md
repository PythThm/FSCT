# Clone vs Image
- Clone: A disk-to-disk copy. The target drive becomes a bootable replica of the source
- Image: A file (or sets of files) that acts as a container for the evidence. It cannot be booted directly but can be mounted or analyzed by softwares

### **Logical Images**

- A logical image captures all the **“active” data** on a hard drive, mirroring what is viewable when browsing a drive through a standard operating system interface, such as the C drive in My Computer.
- Logical captures **do not capture** deleted space, deleted files, or file fragments.
- The resulting image size is dependent only on the amount of active data. For instance, a 1 TB drive with only 30 GB of active files will produce a 30 GB uncompressed logical image.
- In FTK Imager, logical images are stored as **AD files** (AD1 format) and are simply a collection of files chosen for preservation.
- Because they exclude sector information, logical images created from the contents of a folder cannot be converted to a sector image format like E01.

### **Physical Images**

- A physical image captures **all the ones and zeroes** contained on the drive, making it an **exact bit-for-bit copy** of the target media.
- This capture includes deleted space, deleted files, and file fragments, even if the media was recently formatted.
- An uncompressed physical image of a 1 TB drive will result in a file (or files) that is also 1 TB.
- The **E01** format is a recognized standard and considered the best practice for storing physical images. FTK Imager supports this format, along with others like Raw (dd) and AFF.
- E01 files are generally referred to as **containers** or "evidence files" because they hold the bit-for-bit data plus other information to **“bag-and-tag”** the evidence, which preserves the chain of custody.
- **E01 Container Components:**
    - **Header:** Contains case information (Evidence name, Case number, Notes, Examiner, Acquisition Date/Time, and the acquisition tool version). The header is sealed for integrity—it is subjected to a Cyclic Redundancy Check (CRC) and is always compressed.
    - **Data Blocks:** Hold the image data. The size of these blocks can be configured during the imaging process.
    - **File Integrity Component (CRC and MD5/SHA1):** This exists throughout the container. Each data block is verified with its own CRC, and the entire data block section is subjected to the acquisition hash (MD5/SHA-1).
- The **acquisition hash** is calculated **only on the data**, excluding the header and all CRCs.
- The creation process allows setting the compression level and image fragment size. Higher compression levels will generally slow the imaging process. Note that when compression is applied, there are no CRCs following the individual data blocks.
- When imaging large drives, the container may be segmented into multiple files, starting with extensions like .e01, .e02, and so on.

### **Custom Content Image**

- A Custom Content Image allows investigators to selectively pick specific files and/or folders from different locations and consolidate them into a single file.
- This feature is typically useful when conducting **on-site searching or triaging** when time is limited.
- It is also valuable when a search warrant or investigation limits access to only specific information, requiring only a few items out of a large system or server.
- FTK Imager supports creating these images, often stored as AD1 files.

### **Live Memory Capture**

- FTK Imager provides the functionality to **capture live memory** from a machine.
- During this process, the user specifies the destination path and filename for the memory dump.
- Options available during memory capture include the choice to **include the `pagefile.sys`** and to **create an AD1 file** of the capture.
- In addition to memory, FTK Imager can also acquire **Protected Registry Files** from the live machine, which is helpful for tasks such as login password recovery.

# Forensic Imaging and Data Acquisition

#### Logical Images

• A logical image captures only the **“active” data** on a hard drive—what is visible through a standard operating system view (e.g., browsing My Computer).
• This capture **excludes** deleted space, deleted files, and file fragments.
• The size of the resulting image reflects only the active files, not the total size of the media.
• Logical images are typically stored in formats like AD files (AD1 format). They cannot be converted into sector images (like E01) because they lack underlying sector information.

#### Physical Images

• A physical image captures **all the ones and zeroes** on the drive, making it an **exact bit-for-bit copy** of the media.
• This process captures **deleted space, deleted files, and file fragments**.
• The size of an uncompressed physical image will match the total capacity of the source drive.
• The E01 format is a recognized standard and considered the best practice for storing physical images.
• **E01 Containers** hold the data copy along with metadata to maintain the chain of custody:
	◦ The **header** includes case details (Evidence name, Case number, Notes, Examiner, Acquisition Date/Time). It is compressed and sealed with a Cyclic Redundancy Check (CRC).
	◦ **Data blocks** contain the image data.
	◦ A **file integrity component** (CRC and MD5/SHA-1) ensures integrity. The acquisition hash (MD5/SHA-1) is calculated exclusively on the data blocks, excluding the header and CRCs.
	
• Physical image creation allows for setting the image fragment size and compression level, although increased compression slows the imaging process.

#### Custom Content Image

• A Custom Content Image allows investigators to select specific files and/or folders from various locations and consolidate them into a single file, often an AD1 file.
• This method is useful when time is limited during on-site triaging or when the scope of access is legally restricted to specific information.

#### Live Memory Capture

• Forensic tools can capture live memory from an operating machine.
• Options during memory capture include specifying the destination path and filename, choosing to include the `pagefile.sys`, and creating an AD1 file of the capture.
• The process also often supports acquiring Protected Registry Files from the live machine for uses such as login password recovery.

--------------------------------------------------------------------------------

# Forensic Hardware and Media Sanitation

## Forensic Hardware

#### Dongles and Licensing

• Forensic software uses a **dongle** to control access, and the software will not run without the dongle connected to the PC.
• Some labs use a **dongle server** to manage network licenses, requiring the software to point to an IP address and port to find a license.
• Dongle servers can also enable remote connection to a physical dongle as if it were local.

#### Imaging Appliances

• **Hardware imaging appliances** are typically faster, handle errors better, and offer more functionality than software-based imaging.
• **Advanced disk imagers** require specialized training, but they are essential tools usually maintained by labs for use with damaged drives.

#### HD Write Blockers

• Traditional write blockers are manufactured by companies such as **Tableau and Wiebetech**. Tableau also produces write blockers designed to fit inside PC cases.
• Write blockers must be **tested at least quarterly**. This testing can be done using software or by hashing a drive with a known hash value.
• Investigators should **regularly check for firmware updates** for all forensic hardware.

## Media Sanitation

#### Principles of Sanitation
• Media sanitation serves two purposes:
1. To prevent sensitive material from being recovered from the media.
2. To prevent **cross-contamination** by ensuring pre-existing data does not contaminate evidence placed on the host media.

• A key principle is that all data remains intact until it is either **overwritten or physically destroyed**.
• **All electronic storage media** (such as hard drives) must be sanitized before being used as a target drive.

#### Sanitation Techniques

The three primary techniques are:

1. **Overwriting:** Writing new data over the existing data. Note: This method is **not approved for TOP SECRET information**.
2. **Degaussing:** Randomizing the magnetic domains. This process will most likely render the drive unusable. The Data Killer from Platform of Japan is an example of a degaussing tool.
3. **Physical Destruction:** Methods include incinerating, disintegrating, shredding, pulverizing, or melting the media.

#### Normal Disk Sanitation Procedure

• Normal disk sanitation involves writing a **known character** (e.g., `00h`) to all addressable locations on the drive, followed by a verification step.
• This procedure must utilize **forensically sound applications or tools**.
    ◦ _Software examples:_ Winhex, Encase, Wipe Drive, or Linux distributions like Paladin.
    ◦ _Hardware examples:_ Logicube Talon, Weibetech Ditto, or Tableau TD3.

#### Post-Sanitation Requirements

• Sanitized media must be clearly labeled as **“sanitized” or “wiped.”**
• The label must include the **date and time** of sanitization and the **initials and employee number** of the person who performed the sanitization.
• Sanitized media must be stored in a sealed anti-static bag and clearly identified.
• Removable media used by investigators in digital cameras **must be reformatted prior to each search**.