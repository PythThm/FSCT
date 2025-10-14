# Detailed Lecture Notes: File Systems, RAIDs, Bits and Bytes

## 1. Bits, Bytes, and Hexadecimal Systems

### 1.1 Bits and Bytes
- **Bit (Binary Digit)**: The smallest unit of digital information. Can hold only two values: **1 (on)** or **0 (off)**.
- **Byte**: A group of **8 bits**. The basic addressable unit of data in most systems.
- **Sector**: Standard storage unit on magnetic disks.  
  - Typical size: **512 bytes**  
  - Advanced Format (AF) drives: **4096 bytes** per sector  
- **Cluster**: A group of sectors (e.g., 4 sectors = 1 cluster). The smallest allocatable unit of storage.
- **Nibble**: Half of a byte (4 bits). Used for hexadecimal conversions.
- **Word**: 2 bytes (16 bits).

### 1.2 Binary and Decimal Conversion
Binary numbers use powers of 2. Each bit represents 2ⁿ:
| Bit Position | Value | Example (8-bit) |
|---------------|--------|----------------|
| 7 | 128 | 1 |
| 6 | 64 | 0 |
| 5 | 32 | 0 |
| 4 | 16 | 1 |
| 3 | 8 | 1 |
| 2 | 4 | 0 |
| 1 | 2 | 0 |
| 0 | 1 | 1 |

Example: `10011011` → 128 + 16 + 8 + 3 = **155** (decimal)

### 1.3 Hexadecimal System
- Uses **base 16**, represented by 0–9 and A–F.  
  - 10 = A, 11 = B, 12 = C, 13 = D, 14 = E, 15 = F
- **Binary to Hex Conversion**: Split byte into two nibbles (4 bits each).  
  Example: `10011110` → `1001` (9) and `1110` (E) → **9E (hex)**.
- Representations:  
  - `0x9E` (C-style notation)  
  - `9Eh` (assembly notation)

---

## 2. FAT File System (File Allocation Table)

### 2.1 Overview
- Early Microsoft file system used in **floppy disks, USB drives, SD cards, and exFAT**.
- Variants: **FAT12, FAT16, FAT32, exFAT**.
- Still relevant for **cross-platform compatibility (Windows/macOS/Linux)**.

### 2.2 Structure
| Level | Unit | Description |
|--------|------|-------------|
| 1 | Bit | 1 or 0, smallest unit |
| 2 | Byte | 8 bits |
| 3 | Sector | 512 bytes (traditional) |
| 4 | Cluster | Group of sectors (e.g., 4) |
| 5 | File | Occupies 1 or more clusters |

### 2.3 Cluster Allocation Example
If a file is **1030 bytes** and each sector = 512 bytes:
- Sector 1: 512 bytes (full)
- Sector 2: 512 bytes (full)
- Sector 3: 6 bytes used → remaining **506 bytes unused**
- Sectors 1–3 = part of a single **cluster** (2048 bytes total)

### 2.4 Slack Space
| Type | Description | Content | Forensic Value |
|-------|--------------|----------|----------------|
| **RAM Slack** | Unused bytes in the last *used* sector | Filled with zeros | Low |
| **File Slack** | Unused sectors in the last *cluster* | May contain remnants of old files | High |

### 2.5 Volume Boot Record (VBR)
- Located at **sector 0 of each partition** (logical sector 0).  
- Contains metadata about partition layout:
  - Volume serial number
  - File system type (FAT16/FAT32/exFAT)
  - Bytes per sector, sectors per cluster
  - Reserved sectors, FAT count, total sectors

---

## 3. NTFS (New Technology File System)

### 3.1 Overview
- Default Windows file system since Windows NT (1993).  
- Supports large volumes, advanced permissions, journaling, and rich metadata.
- Less “forensic-friendly” due to complexity.

### 3.2 Key Concepts
- **Journaling**: Every operation (create, delete, modify) is logged as a **transaction**.  
  - If interrupted (e.g., power loss), NTFS rolls back incomplete actions.  
  - Logged in `$LogFile`.
- **Metadata**: Data describing other data (author, timestamps, permissions).

### 3.3 NTFS System Files
| System File | Function |
|--------------|-----------|
| `$MFT` | Master File Table; stores all file records and metadata |
| `$MFTMirr` | Backup of first 4 MFT records for recovery |
| `$LogFile` | Transaction log (journaling) |
| `$Volume` | Contains volume info, label, dirty flag |
| `$Bitmap` | Tracks used/free clusters |
| `$Boot` | Boot sector (cluster 0) |
| `$BadClus` | Marks bad sectors |
| `$UpCase` | Case sensitivity mapping table |

### 3.4 NTFS Boot Process
1. **MBR (Master Boot Record)** – Sector 0, points to partitions.  
2. **VBR (Volume Boot Record)** – Start of each partition; identifies NTFS volume.  
3. **MFT** – Loaded to locate files and metadata.  

### 3.5 Forensic Insights
- MFT entries persist even after deletion → possible recovery.  
- `$LogFile` reveals file creation/move times.  
- `$Bitmap` and `$BadClus` show file usage and disk health.  
- `$MFTMirr` can partially restore corrupted volumes.

---

## 4. RAID (Redundant Array of Independent Disks)

### 4.1 Purpose
Combines multiple drives for **speed**, **redundancy**, or **capacity**.  
Used in servers, NAS devices, and forensic environments.

### 4.2 RAID Types
| RAID | Method | Fault Tolerance | Drives | Features |
|------|---------|----------------|---------|-----------|
| **RAID 0 (Striping)** | Data split across drives | 0 | ≥2 | High speed, no redundancy |
| **RAID 1 (Mirroring)** | Duplicate copy of all data | 1 drive | 2 | High safety, slow write, half storage |
| **RAID 5 (Striping + Parity)** | Parity block per stripe | 1 drive | ≥3 | Fast, rebuilds with 1 failed drive |
| **RAID 6 (Dual Parity)** | Two parity blocks | 2 drives | ≥4 | Survives 2 drive failures |
| **RAID 10 (1+0)** | Mirrored pairs striped | 2 drives | ≥4 | Combines speed + safety, 50% efficiency |
| **JBOD** | Sequential storage, no parity | 0 | ≥2 | Just concatenated drives, no redundancy |

### 4.3 Fault Tolerance Summary
| RAID | Drives Lost Allowed | Forensic Imaging Rule |
|-------|---------------------|------------------------|
| 0 | 0 | Must image all drives |
| 1 | 1 | One drive sufficient |
| 5 | 1 | Image n–1 drives |
| 6 | 2 | Image n–2 drives |
| 10 | Up to 2 (different mirrors) | Two drives minimum |

### 4.4 RAID Rebuild Example
- **RAID 5** uses XOR-based parity:  
  - A ⊕ B ⊕ C = P (parity)  
  - If any drive fails, missing block = A ⊕ B ⊕ P  
- **Hot Swapping**: Drives can be replaced without shutting down.

### 4.5 Forensic Considerations
- Identify RAID type before imaging.  
- Record disk order and controller metadata.  
- Tools can rebuild arrays (even with missing drives).  
- Imaging priority: RAID 1 → one drive; RAID 5 → n–1; RAID 6 → n–2.

---

## 5. Summary and Takeaways
- **Bits → Bytes → Sectors → Clusters** form the hierarchy of digital storage.  
- **FAT** provides simplicity and forensic clarity (recoverable slack space).  
- **NTFS** offers reliability, journaling, and extensive metadata (complex but rich).  
- **RAID** improves fault tolerance and performance, but recovery depends on configuration knowledge.  
- Understanding these layers is **essential in digital forensics** for accurate data recovery, analysis, and evidence handling.

---
*End of Detailed Notes*
