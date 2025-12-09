# FTK Introduction
- AD encryption in hostile environment, usually not enabled
- FTK can make multiple image at the same time
- FTK well calculate hash by default, and then do a verification hash again when creating image

---

# Carving: Signature-Based File Recovery

## The Idea Behind Data Carving

- Carving is a process of **signature-based file recovery** used to retrieve files that are no longer tracked by the file system manager (such as the MFT or FAT).
- When a file is deleted, its sectors remain intact and untouched until they are eventually overwritten. These files have the potential to remain recoverable within the **unallocated part of the drive** for a long time.
- Even if the file sectors are overwritten, the **file slack** may still potentially store some residual data.
- Since the file system management structure cannot refer the user to the file's location after deletion, carving is the only way to identify and retrieve these files.

## Mechanism of Carving (Headers and Footers)

- Carving relies on file structures because most known files begin with a recognizable signature, called a **Header**. This signature allows the file system to properly classify and identify the file.
- Some file types also possess a known ending, referred to as a **Footer**.
- Carving involves searching raw data for these known signatures to identify the beginning and, if available, the end of a deleted file.

## Limitations

- The primary drawback of carving is the **loss of metadata**.
- Metadata is typically stored outside the file data itself. When a file is deleted, the connection between the file data and its corresponding metadata is lost, and carving recovers only the raw data content.

## Resources and Tools

- Tools such as **WinHex** or **X-Ways** are used to practically carve for files.
- Resources are available online to look up known file signatures.