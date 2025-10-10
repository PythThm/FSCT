= Week 3 = 

# Glist & Plist

When a block/sector is bad, every vendor will have a spare area
End of the plater
Instead of using bad sector, it will use the sector from the spare area
Growing List & Primary List
- Contains the address of the bad sector and the new sector
- PList is populated during the manufactor stage
- GList is usually empty
- What happens if time pass other sector fails
    > Hard drive will test itself
    > and relocate itself
    > GList gets populated from this

- Plist contains bad logs found during the manufactor stage
- GList is populated during the normal life span of the disk

## Translator

- using the PList & GList, it translate the physical address to Logical address
- Tells the computer which sector it should go to 
- using reserved area to avoid the defect area
- If translator gets erased, it does not recognize the bad sector, and the hard drive keeps trying to read the bad sector
- We can replace the bad translator, but professional only

## Malfunctions
1. Bad Sectors
    - red bad, green good
    - if a bad sector is found, and theres is nothing to do about it, the OS will panic -> Bluescreen of death
    - Very slow respond time, freeze or not boot
    - OS constant restart
    - Drive freezes upon imageing
    - Drive can be imaged up to a certain point
    **how to "fix" it without professional repair**
        - Multiple retries, Read with ECC (without checksum), increase skips (skip forward), reduce timeout (if takes more than 5ms, skip), Reverse Reading (Reading from the start, stop at bad, read from backwards 
2. Firmware Issue
    - Overflown logs (reallocation)
    - Common issue with BS inside the SA (surface area), different SA matrix, different durabliliy
    - SA is a collection of small logs and files, crucial to operation of the HDD, called **Modules**
    - If module goes bad, it can be rewritten/reallocated/rebuilt
    - modules are unique and required to implement special techniques to rebuild them
    - some modules can be copied fomr similar HDD or Database
    **Symptoms**
        - Spinning but not recognized
        - Slightly clicking
        - Not powering on (rarely)
        - Identified by lower capacity or dafault factory name
    **Solution**
        - ACElab
        - professional way to fix
        - rewritten a different module might damage the disk
3. PCB issues
    - Printed Circuit Board
    - control how the hard drive works and operate
    - electrical failure
    - Spike of voltage, bad soldering
    - connect a wrong type of adapter
    - bad shutdown process
    **Symtoms**
        - Burning smell
        - Drive not starting 
        - Clickings
        - Visual inspection
        - bloated hardware
    **Solutions**
        > Replacing the ROM chip from the PCB
        - ROM swap
        - ROM Transfer (if it is not completely damage) (copy and paste)
        - ROM Rebuild (manually replace and fix modules)
4. HSA - Head Stack Assembly
    - the heads get shocked
    - they stop floating 
    - the head gets destroyed
    - not enough time to properly speed down if shutdown improperly
    **Symtoms**
        - Slow
        - Freezing
        - Clcking, 3 clicks and stop
        - Reading partial information
        - Drive identified by factory default parameters
        - Humming noise when starting the drive (The head is stuck to the platter) 
        - [2]head crashes and scratches the platter, removing the magnetic properties on it
        - loud noise
        - black filter
    **Solutions**
        - Rarely all heads die at the same time
        - often 1 or 2 heads start to deteriorate, while others functions normally
        - Replace the head (Bro describing it like performing a organ transfer surgery)
        - [2] there is nothing we can do LMAO
        - new heads
        - Platters can be "Recoated" and reinstalled but the reading will have to be manually limited, very professional work
5. Motor issues
    - Failed/Jammed motor
    **Symtoms**
        - Disk won't spin, humming noise
    **Solutions**
        - New motor

## SMART
Self Monitoring Analysis Reporting Techonology
> What does it do?
    - Hard drive monitoring software (logs)
    - Inform us when the drive is going to fail
    - Logs bad sectors
> Definition
    - Monitoring system that are in most hdds and some ssds that detects and reports the drive reliability, to avoid hardware failures
    - SMART is a set of mini subprograms acting as parts of drive's firmware and defining the supported diagnostic features
    - Procide users with information about drive status that cannot be obtained with other methods 
> SMART Values
    - MTBF - Main Time Between Repairs
    - like time took to find a bad sector
    - if threshold not exceeded - drive ok, else go fuck the drive
    - it will alarm you if the threshold is getting closer 


## SSD Drive
> Wear leveling
    - NAND flahs memory cells can only be written to ~100,000 times
    - Controller spread the writting evenly
> Garbage Collection (TRIM)
    - When deleting data from PC, no actual data is erase, clusters are marked as avaliable
    - TRIM command is used as "Garbage collection" and capable of managing the deltetion of the data in these unallocated blocks to enhance performance
    - TRIM command must be supported by every piece of the puzzle
        - SSD drive
        - OS
        - File system (only NTDS in windows)

## Addressing - CHS vs LBA
Cylinder Head Sectors VS Logical Block Addresses
> CHS
    - Divides into 3 parts
    > Tracks
        - Concentric circular paths on each side of the platter
        - Track Zero, outer edge of platter
    > Sectors
        - Each tracks are divided into sectors
        - 512 bytes/sector
        - Smallest physical unit to be written to
        - To modify one byte, rewrite the whole sector
        - Data remains until overwritten
    > Cylinder
        - Set of tracks
        - All tracks across platters form a cylinder
    
    - Ability to physically locate any area of the disk by using 
        1. Cylinder
        2. Head
        3. Sector
    
    > How many sectors?
        - printed on drive, internet, manufacturer specs
        - Cylinders X Heads X Sectors/tracks = Total sectors

> LBA
    - Addressed by linear mapping of sectors
    - Must be supported by Hardware, OS, Software
    - Every sector gets its own number

> Shingled magnetic Recording
    - magnetic storage data recording technology
    - to increase storage density and capacity
    - every track is overlapping on another track
    - you cannot rewrite a sinlge track
    - bigger drive, slower performance
    

