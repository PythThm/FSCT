# Mac Forensics: Study Notes
## Top things to know cold

- **No key, no data.** FileVault 2 and hardware encryption mean the password or recovery key is the evidence key. [S10, S39]
- **A powered-on, unlocked Mac beats a powered-off encrypted Mac.** Never shut down to "preserve" it. [S45, S47]
- **2018+ Macs (T2 and Apple silicon): you cannot "pull the drive and image it."** The NAND holds ciphertext. [S9, S38]
- **Fusion Drive = two devices.** Acquire both tiers or reconstruction breaks. [S6, S43]
- **Catalina (10.15)+ splits System (read-only) and Data (mutable) volumes**, joined by firmlinks. [S35]
- **SQLite: always copy `.sqlite` + `.wal` + `.shm` together** and work on forensic copies only. [S21]
- **Timestamps:** Unix = 1970, Mac Absolute/Cocoa = 2001, HFS+ = 1904, WebKit/Chrome = 1601 (microseconds). [S14, S16]
- **KnowledgeC to Biome:** since Ventura, most streams go to Biome first. Parse both. [S56, S60]
- **Verify tool output.** Check at least one item against the source file and raw record. [S5]
- **Document everything:** build number, hardware model, chip family, FileVault state, user context, SIP state, and every command run on the evidence Mac. [S5, S46]

---

## 1. The Apple ecosystem [S2-S3]

|OS|Runs on|Notes|
|---|---|---|
|**macOS**|Mac desktops/laptops (MacBook Air/Pro, iMac, Mac mini, Mac Studio, Mac Pro)|Current: macOS 27 "Golden Gate" (27.0.1, 28 Sep 2026)|
|**iOS**|iPhone only|iPod touch ended at iOS 15 (discontinued 2022)|
|**iPadOS**|iPad, mini, Air, Pro|Split from iOS in 2019 (iPadOS 13)|
|**watchOS**|Apple Watch||
|**tvOS**|Apple TV HD (2015) and later|Older ones ran "Apple TV Software"|
|**visionOS**|Vision Pro||
|**bridgeOS**|T2 chip inside 2018-2020 Intel Macs||

**Key point:** same company, same kernel (**Darwin/XNU**), same artifact families (**plists, SQLite, Biome, Unified Logs**). But different version numbers, support lists, and acquisition rules.

### Oldest supported devices (current versions) [S3]

|Device|Oldest supported|
|---|---|
|Mac (macOS 27)|M1 Macs (2020) and MacBook Neo (A18 Pro). **No Intel.** Tahoe 26.7.1 still updated for Intel Macs|
|iPhone (iOS 27)|iPhone 11 (2019), iPhone SE 2nd gen|
|iPad|iPad 9th gen, iPad mini 6, iPad Air 4 (2018-2020 Pros dropped)|
|Apple Watch|Series 9, Ultra 2, SE 3rd gen|
|Apple TV|Apple TV 4K 2nd gen (2021)|
|Vision Pro|M2 and M5 models|

---

## 2. macOS versions and forensic impact [S4-S5, S13]

|macOS|Version|Forensic impact|
|---|---|---|
|**Catalina**|10.15 (2019)|Read-only System volume + separate Data volume; paths resolve through **firmlinks**|
|**Big Sur to Sonoma**|11-14 (2020-2023)|**Signed System Volume**, **APFS snapshots**, **Biome replaces most of KnowledgeC**, heavier **TCC** privacy controls|
|**Sequoia**|15 (2024)|iPhone Mirroring artifacts, Passwords app, more Apple Intelligence traces on M-series|
|**Tahoe**|26 (2025)|Year-based numbering begins. **Last macOS to run on Intel Macs.** Liquid Glass UI|
|**Golden Gate**|27 (Sept 2026)|**Apple silicon only.** Last with full Rosetta 2. AFP, Boot Camp, AirPort Utility removed|

### OS changes that matter to investigators [S5]

- Do not assume one path, one DB schema, or one timestamp pattern works across all releases.
- The same artifact family can **move, split, or lose fields** after major upgrades.
- Always document: **exact build number, hardware model, chip family, FileVault state, user account context.**
- When a commercial tool shows a result, **verify at least one item** by locating the source file and checking the raw record.

---

## 3. Mac hardware generations [S6-S9]

### Mac iterations [S7]

|Era|Years|What changed|Examiner impact|
|---|---|---|---|
|Motorola 68k|1984-1994|Original Macintosh, HFS|Museum pieces; HFS/HFS+ epochs show in old media|
|PowerPC|1994-2006|Mac OS 8/9, then Mac OS X (2001), HFS+|Rare; removable IDE/SATA; no default encryption|
|**Intel**|2006-2020|Boot Camp, EFI, **FileVault 2 (2011)**, **APFS (2017)**|Removable SATA/NVMe on most; classic dead-box imaging works|
|**Intel + T2**|2018-2020|T2 chip: Secure Enclave, SSD controller, always-on encryption|Storage removal gives **ciphertext**; need credentials + boot-based or live acquisition|
|**Apple silicon**|2020-today|M1-M5 (and A18 Pro in MacBook Neo). SoC with unified memory, SSD controller, Secure Enclave on one die|**No Target Disk Mode** (use Share Disk), **no Boot Camp**, sealed boot chain|

### Hardware generation and collection consequence [S6]

|Generation|Storage/security pattern|Collection consequence|
|---|---|---|
|Older Intel|Removable SATA/NVMe|Dead-box removal may work; still confirm FileVault and APFS|
|Intel with T2|Controller + Secure Enclave tied to internal storage|Prefer live/booted acquisition when credentials available|
|Apple silicon|Integrated storage, sealed boot chain, Secure Enclave|User credentials and trusted boot state often decisive; plan live capture carefully|
|Fusion Drive|SSD + HDD combined by CoreStorage/APFS|Acquire the logical set, not just the visible HDD|

### Intel vs Apple silicon [S8]

|Topic|Intel|Apple silicon|
|---|---|---|
|**Where keys live**|On the drive, protected by FileVault password|In the **Secure Enclave**, never leave the chip. Internal SSD is encrypted **even with FileVault off**|
|**How you boot it**|Cmd+R, Option-boot from USB, **Target Disk Mode (T)**|Hold power for Options, **Share Disk over SMB**, **DFU restore** via Apple Configurator|
|**Who may change security**|n/a|SIP, external boot, kernel extensions tied to a **volume owner (Secure Token user)**. No owner password = no changes|
|**Memory**|n/a|Unified memory shared with GPU. **Live RAM capture is the only way** to get it|

### The SSD [S9]

- **Soldered NAND** started with the 12" MacBook (2015) and Touch Bar MacBook Pro (2016). Every Apple silicon MacBook, iMac, Mac mini and MacBook Neo has soldered NAND.
- **Only Mac Studio and Mac Pro** use removable NAND modules, and even those are **paired to that machine's Secure Enclave**.
- The SSD **controller is inside the T2 or M-series SoC**. Every block is written encrypted with a key that exists only in that chip. **FileVault merely wraps that key** with the user password.
- **Consequence:** chip-off, board swap, or NAND reader = **ciphertext**.
- **What works instead:**
    1. Live acquisition on the running, unlocked Mac
    2. Boot into Recovery and use **Share Disk** or a collector (e.g., Digital Collector)
    3. Obtain the password or recovery key first
- Fusion Drive and Apple RAID iMacs (2012-2020) are two devices that must be acquired together.

---

## 4. Why Apple devices are hard [S10]

- **Encryption by default:** FileVault on Macs, Data Protection on iPhone, keys sealed in hardware. _The password is the evidence key._
- **The OS fights your tools:** SIP and Signed System Volume block access unless the tool has **Full Disk Access**; Gatekeeper and notarization refuse unsigned binaries.
- **You need a Mac to examine a Mac:** APFS, FileVault, Apple silicon boot, and keychain parse best on Apple hardware.
- **Annual churn (every September):** artifacts move, rename, or vanish. Examples: KnowledgeC to Biome, `airport.preferences` to `known-networks`, `.sfl2` to `.sfl3`. Tools lag by months.
- **Privacy features:** Unified Log redaction, Lockdown Mode, Advanced Data Protection for iCloud, iPhone inactivity reboot (back to BFU after 72 h), USB Restricted Mode.
- **Cloud is the other half:** iCloud Drive, Messages in iCloud, Photos may not be on the device; placeholders hold metadata only.

---

## 5. iPhone notes [S11-S12]

### iPhone Duo (Sept 2026, first foldable) [S11]

- Two screens, two UI states: **document the folded/unfolded state at seizure.**
- **Touch ID** in the side button plus Apple Watch unlock; **no Face ID.** Plan the biometric window before it locks.
- Ships on iOS 27.1 (23 Oct 2026): expect weeks to months before extraction tools support it.
- Up to 2 TB storage: full file system extractions become multi-hour, multi-hundred-GB jobs.
- New Duo-only apps/streams (Smart Take, Duo Preview) mean new Biome/KnowledgeC stream names.

### Every new iPhone, same questions [S12]

|Topic|Key point|
|---|---|
|**BFU vs AFU**|**Before First Unlock:** data keys not in memory. **After First Unlock:** they are. A device folded shut but never powered off is still AFU. **Keep it powered.**|
|**Inactivity reboot**|Since iOS 18.1, reboots after ~**72 hours** without unlock and drops to BFU. Clock starts at seizure|
|**USB Restricted Mode / Lockdown Mode**|Data over Lightning/USB-C cut off **one hour after lock** unless a trusted computer connects. A Faraday bag does **not** stop this timer|
|**Stolen Device Protection**|Away from trusted locations, changing Apple ID or passcode needs Touch ID plus a one-hour delay. Affects consent-based collections|
|**Tool reality**|Cellebrite, GrayKey, and Magnet are among the only tools that support Mac|

---

## 6. Timestamps on Mac [S14-S16]

|Family|Epoch|Common places|
|---|---|---|
|**Unix**|1970-01-01 UTC|APFS metadata in many tools, log exports, browser artifacts, shell history|
|**Mac Absolute / Cocoa**|**2001-01-01 UTC**|KnowledgeC, Biome, Core Data DBs, many Apple app timestamps|
|**HFS+**|1904-01-01 UTC|Legacy HFS+ metadata, older Mac artifacts|
|**WebKit / Chrome**|1601-01-01 UTC, **microseconds**|Chromium history, cookies, login data, other browser DBs|

**Conversion:** `Mac Absolute + 978,307,200 = Unix epoch`

**Tools:** DCode (digital-detective.net/dcode), CyberChef (gchq.github.io/CyberChef), `epochalypse.py` (pstirparo).

---

## 7. SQLite databases [S17-S23]

- Most Mac software stores data (user data, settings, logs) in **SQLite** databases.
- Mac uses **SQLite format 3**. The header signature is `53 51 4C 69 74 65 20 66 6F 72 6D 61 74 20 33 00` ("SQLite format 3"). Because the signature is constant, the database can be **carved**.
- **No constant file extension.** Best way to identify: **view the header** or open it in a DB viewer.
- View with **DB Browser for SQLite** (sqlitebrowser.org).

### WAL and SHM files [S19, S21]

|File|Meaning|Forensic note|
|---|---|---|
|`.wal`|**Write-Ahead Log**|May contain records **newer** than the main DB. Newest record may be in the WAL while the main DB looks stale|
|`.shm`|**Shared Memory** file|Not normally an evidence target itself, but confirms shared-memory WAL activity|

**Rules:**

- Opening a live DB can **checkpoint or alter WAL state.** Work on **forensic copies only.**
- Never open the original evidence DB directly. Document the exact query used and source files in the copy set. [S23]

### Common macOS SQLite databases [S22]

|Artifact|Path|Value|
|---|---|---|
|**Safari History**|`~/Library/Safari/History.db`|Visited URLs, visit times, redirect chains|
|**Messages**|`~/Library/Messages/chat.db`|iMessage/SMS chats, handles, attachments|
|**KnowledgeC**|`~/Library/Application Support/Knowledge/knowledgeC.db`|App focus, device/user activity, pattern-of-life|
|**TCC**|`~/Library/Application Support/com.apple.TCC/TCC.db`|Privacy permissions granted/denied to apps|
|**Notes**|`~/Library/Group Containers/group.com.apple.notes/NoteStore.sqlite`|Notes metadata and content (schema and encryption caveats)|

---

## 8. Property lists (plists) [S24-S28]

- A **property list (.plist)** is a small settings file: **keys and values** (e.g., `LastOpened = ...`, `RecentFiles = [a,b,c]`).
- Windows keeps this in the **Registry** (one big central DB). Apple spreads it over **thousands of small plist files**, one per app/setting.

### Three types [S24-S25]

|Type|Identification|
|---|---|
|**XML**|Human readable, starts with `<?xml`|
|**Binary**|Starts with **`bplist00`**; default since 2002|
|**Nested archives (NSKeyedArchiver)**|A plist whose values are more plists; needs a parser|

**Why we care:** recent files, Wi-Fi networks, mounted volumes, login items, Dock contents, app accounts, last-run times, and more.

### Reading plists [S26]

- **Python `plistlib`**: built in, loads XML and binary into dictionaries
- **plistutil (libplist)**: command-line converter for Windows/Linux
- **Plist Editor Pro**: Windows GUI (verify its date decoding)
- **Forensic suites:** Magnet AXIOM, X-Ways, Cellebrite Physical Analyzer and Inspector

### Plist locations worth checking [S27]

|Artifact|Path|Shows|
|---|---|---|
|User preferences|`~/Library/Preferences/*.plist`, `~/Library/Containers/<bundle>/Data/Library/Preferences/`|App settings, recent values, identifiers, account state|
|Global preferences|`~/Library/Preferences/.GlobalPreferences.plist`|Locale, UI, keyboard, behavior|
|Dock items|`~/Library/Preferences/com.apple.dock.plist`|Pinned apps, recent apps, persistent items|
|Login/background items|**Ventura+:** `/private/var/db/com.apple.backgroundtaskmanagement/BackgroundItems-v*.btm`; **Monterey and earlier:** `~/Library/Application Support/com.apple.backgroundtaskmanagementagent/backgrounditems.btm`|Persistence|
|Launch agents|`~/Library/LaunchAgents/*.plist`|User persistence and scheduled execution|

---

## 9. macOS file system domains [S29-S33]

Domains separate files by usage to maintain **access controls** and prevent unintended alteration.

|Domain|Contents|
|---|---|
|**User**|User-specific data (pictures, documents, music). Logged-on user can only access own home directory in `/Users` (except "Public"). The hidden **`Library`** folder holds app-specific data|
|**Local**|**Applications** folder and the main **Library** folder; files shared among users|
|**System**|Apple system software; contains **System Library**, where many plist files live|
|**Network**|Local network resources and apps, usually controlled by net admin (NAS drives, Time Capsules, network printers)|

### User home high-value targets [S37]

- `~/Desktop`, `~/Documents`, `~/Downloads`, `~/Pictures`: user-created and downloaded files
- `~/Library`: app data, caches, preferences, saved states, logs, databases
- Hidden files: `.zsh_history`, `.bash_history`, `.ssh`, `.gitconfig`, tool configs
- **Group Containers and Containers:** sandboxed app data (Notes, Safari, Mail, iCloud, third-party)

---

## 10. APFS [S34-S36]

### APFS structure to document [S34]

|Layer|Meaning|Why it matters|
|---|---|---|
|**Physical disk**|Real internal/external device|May not expose user data directly on T2/Apple silicon|
|**Container**|APFS space-sharing pool|Can hold multiple volumes and snapshots; **image the right level**|
|**Volume group**|System + Data pairing|Recent macOS stores OS and user data separately|
|**Snapshots**|Read-only historical states|May preserve files/metadata gone from live view|

### Catalina and later: System/Data split [S35]

- macOS 10.15 introduced a dedicated **read-only System volume** and a separate **Data volume** for mutable files.
- The user sees a **merged** filesystem, but acquisition may expose separate volumes.
- **Firmlinks/HardLinks** make directories appear in familiar locations while data resides on the Data volume.
- Forensic tools must understand the split or the examiner may **miss user files, system files, or historical snapshots.**

### APFS snapshots [S36]

- Read-only copies of the parent volume at a point in time.
- Can preserve previous states of files, metadata, and directories.
- **Confirm:** snapshot name, date created, UUID/XID, and whether the tool processed it.

### Deleted data limits [S71]

- APFS, **SSD TRIM**, and encryption reduce traditional unallocated-space recovery.
- **Snapshots, caches, QuickLook, Spotlight, app databases, cloud sync, backups** often matter more than raw carving.
- Deleted SQLite rows may persist in **WAL, freelists, or journal fragments** (depends on timing and vacuuming).
- In reports, explain whether recovery is from: live file, snapshot, cache, database residue, or carved fragment.

---

## 11. Mac acquisition [S38-S47]

### Overview [S38]

- **Intel Macs up to ~2017:** standalone SATA drive or NVMe blade. Dead-box removal is the cleanest option (see ifixit.com).
- **Soldered NAND** from 2015/2016. **T2 Macs (2018-2020)** and **every Apple silicon Mac (2020+)** add hardware-bound encryption.
- On those, removing storage is **pointless**, not just difficult: NAND holds ciphertext and the key never leaves the chip.
- **Practical paths:** live acquisition on the unlocked Mac, or boot the Mac itself (Recovery, Share Disk, or boot collector like Digital Collector) with the password or recovery key.

### Encryption [S39, S47]

|Item|Detail|
|---|---|
|**Legacy FileVault** (10.3-10.6)|Encrypted only the user's **home folder** as a sparse bundle|
|**FileVault 2** (10.7 Lion onward)|**Full volume encryption**, XTS-AES-128 with a 256-bit key. On T2/Apple silicon, hardware already encrypts everything; FileVault adds the password wrap|

**Ways in, in order of likelihood:**

1. User password
2. **Personal recovery key** (24 characters, shown at setup)
3. **Institutional recovery key** or **MDM-escrowed key** (managed Macs)
4. Key escrowed to **iCloud** by the user

**FileVault facts [S47]:**

- Without credentials or a recovery key, the **Data volume stays sealed**.
- The **System volume** (read-only, Apple-signed) is **never encrypted** and holds nothing user-specific.
- On T2/Apple silicon, FileVault decides only whether the **user password is required to unwrap the key at boot**.
- **Decision rule:** a powered-on unlocked Mac beats a powered-off encrypted Mac. **Do not shut down to "preserve" it.**
- Document the output type: encrypted or decrypted, logical or physical, sparseimage, DMG, E01, AFF4, or targeted folder.

### SIP: System Integrity Protection [S40-S42]

- Introduced in **10.11 El Capitan.** Stops even **root** from modifying protected system locations, loading unsigned kernel extensions, or attaching a debugger to Apple processes.
- Since **Big Sur**, the whole System volume is also a **Signed System Volume (SSV)**: a cryptographic seal verified at boot.
- **Why it matters:** live collection tools needing kernel access (memory capture, raw disk reads) may be blocked while SIP is on; some agent-based collectors need **Full Disk Access in TCC** instead.
- **SIP state can only be changed from Recovery.** Changing it **modifies the evidence system**: document it, and prefer a boot-based or agent-based collection that does not require it.

**How to check or change SIP [S42]:**

|Action|Steps|
|---|---|
|**Check (any Mac, no reboot)**|Terminal: `csrutil status`|
|**Intel Mac**|Restart, hold **Cmd+R** until Apple logo. Utilities > Terminal, `csrutil disable` (or `enable`). Restart|
|**Apple silicon**|Shut down, **hold power button** until "Loading startup options". Options > Continue, pick a volume, enter **admin (volume owner) password**. Utilities > Terminal, `csrutil disable`. Restart|

> On Apple silicon, disabling SIP also drops the security policy to **Reduced Security.** Note it in your report and restore it when done.

### Fusion Drive (2012-2020) [S43-S44]

- **Two physical devices presented as one:** a 1, 2, or 3 TB hard drive + a small SSD (128 GB at launch; 1 TB model later cut to 24 GB, then 32 GB).
- **Not RAID 0.** It is **tiered storage:** hot blocks on the SSD, cold blocks on the HDD, so any file may live on either device.
- Tied together by **Core Storage** (2012-2018) or **APFS Fusion** (Mojave 10.14 onward).
- **Forensic consequence:** imaging only the HDD gives a **broken file system with holes** where hot data was. **Acquire both devices** and let a Fusion-aware tool rebuild the logical volume.
- Physical note: the HDD is easy to see after removing the glass, but the SSD is hidden behind the motherboard.

### Mac acquisition decision tree [S45]

1. **Running and unlocked?** The clock is ticking: capture **RAM**, running state, and user-context artifacts before it sleeps/locks.
2. **FileVault on?** Obtain password, recovery key, or escrowed key if legally available. Without one, a powered-off Mac is a brick.
3. **Which generation?** Intel (pull the drive), T2 (boot it or live), Apple silicon (boot it or live; owner password needed for security changes).
4. **What is the goal?** Full image, targeted collection, triage package, or live-response snapshot.
5. **Can the tool handle it?** APFS containers, volume groups, snapshots, FileVault, Fusion. If not, you will miss data and not know it.

### Live acquisition: what to grab, in order [S46]

1. **Identity:** logged-in user, hostname, serial, model, chip, OS version/build, local time zone, current time (compare to a trusted clock)
2. **Volatile state:** **RAM image first**, then running processes, network connections, mounted volumes, logged-in sessions, open files
3. **Security state:** FileVault status, Secure Token holders, SIP status, recovery key escrow, MDM enrolment
4. **User activity:** recent downloads, browser history, shell history, persistence locations, Biome and KnowledgeC, app databases
5. **Integrity:** hashes and tool logs for every package; note every command run on the evidence Mac

---

## 12. Cellebrite Digital Collector [S72-S73]

- Born as **BlackBag MacQuisition (2008)**, the first tool to image Macs from a bootable Mac environment. Cellebrite acquired BlackBag in **January 2020**, renamed it **Digital Collector** in **2021**.
- One licensed USB device with three jobs: **live acquisition** (Mac or Windows), **targeted collection**, and **full forensic imaging**.
- **Boots Intel, T2, and Apple silicon Macs** from the Collector device, so the evidence Mac becomes the imaging station. Also runs as an app on a live system.
- Understands what generic imagers don't: **APFS containers and snapshots, FileVault 2, Fusion Drives, Core Storage, HFS+.**
- **Companion tool:** **Cellebrite Inspector** (formerly BlackLight) for analysis.

|Capability|Mac|Windows|Note|
|---|---|---|---|
|RAM capture|Live|Live|First job on an unlocked machine|
|Targeted (logical) collection|Yes|Yes|Files, folders, artifact packs|
|Full disk image|Booted or live|Booted|E01, DMG, or raw, hashed on the fly|
|Boot evidence machine from Collector|Intel, T2, M1-M3+|UEFI PCs|Apple silicon: **reduced security + owner password**|
|FileVault / BitLocker|Password or recovery key|Recovery key|No key: you still get the **encrypted** image|
|APFS snapshots, Fusion, Core Storage|Yes|n/a|Rebuilds the Fusion logical volume|

---

## 13. Core macOS artifact map [S49]

|Question|Artifact families to check|
|---|---|
|**What did the user do?**|KnowledgeC, Biome, ScreenTime, ARD, Recent Items, Saved State, Unified Logs|
|**What files were touched?**|FSEvents, Spotlight, QuickLook, APFS metadata, Document Revisions, app databases|
|**What was downloaded?**|Browser DBs, quarantine xattrs, LSQuarantine, Mail attachments, iCloud metadata|
|**What ran or persisted?**|LaunchAgents, LaunchDaemons, Login Items, shell history, Gatekeeper, XProtect, Unified Logs|
|**What devices/networks were used?**|Wi-Fi plists, Bluetooth, NetworkInterfaces.plist, mounted volume history, USB logs|

---

## 14. Artifact deep dives (can prove / cannot prove)

### Users, accounts, identity [S50]

- **Where:** `/private/var/db/dslocal/nodes/Default/users/*.plist` (UID, GID, UUID, home path, shell, password hint, creation date); `/Users/<name>`; Unified Logs (`loginwindow`, `opendirectoryd`); KnowledgeC/Biome device-unlock streams.
- **Can prove:** which local accounts existed, creation dates, group membership (admin, Secure Token), who was logged in at a given time.
- **Cannot prove:** that a **specific person** was at the keyboard (shared passwords, auto-login, screen sharing break the account-to-person link).
- **Tip:** correlate with Apple ID sign-in plists (`MobileMeAccounts.plist`) and iCloud device names.

### Shell and terminal [S51]

- **Where:** `~/.zsh_history` (default shell since Catalina; epoch timestamps if `EXTENDED_HISTORY` is on), `~/.bash_history`, `~/Library/Saved Application State/com.apple.Terminal.savedState/`, `~/.ssh/` (known_hosts, config, keys), `~/.zsh_sessions/` (per-tab history).
- **Can prove:** commands run, hosts connected to, tools installed, files touched from the shell.
- **Cannot prove:** order/time without timestamps; that a command **succeeded**; **who typed it.** History is user-editable and can be disabled (`HISTSIZE=0`, unset `HISTFILE`).
- **Tip:** iTerm2, Warp, and VS Code keep their own terminal history.

### FSEvents [S52]

- **Where:** `/.fseventsd/` at the root of every APFS/HFS+ volume (including external drives and Time Machine backups). gzip-compressed logs named by event ID. Parse with **FSEParser**, **mac_apt**, or a suite.
- **Can prove:** a path was created, modified, renamed, removed, or had permissions changed (event sequence, directory granularity on recent macOS).
- **Cannot prove:** exact timestamps (records are **batched**), file content, that a file was **opened/read**, or which user caused it. Rolls over quickly on busy volumes.
- **Tip:** combine with Spotlight, APFS inode times, app DBs, and Unified Logs.

### Unified Logs [S53]

- **Where:** replaced syslog/ASL in **macOS 10.12 Sierra.** Stored as `.tracev3` under `/private/var/db/diagnostics`, UUID text under `/private/var/db/uuidtext`.
- **Collect:** `log collect --last 7d --output case.logarchive`
- **Review:** `log show --predicate 'process == "loginwindow"' case.logarchive`
- **Can prove:** process starts, authentication, screen lock/unlock, mounts and USB arrivals, network changes, Gatekeeper and TCC decisions, Time Machine and iCloud sync, with **millisecond timestamps.**
- **Cannot prove:** everything. Retention is **days to weeks**, and sensitive fields are replaced by `<private>`. **Absence of a log line is not absence of the event.**

### Install logs [S54]

- **Where:** `/var/log/install.log` (OS updates, pkg installs, App Store installs), `/var/db/receipts/*.bom` and `.plist`, `/var/log/system.log` (older Macs).
- **Can prove:** when software arrived, which installer, what files it laid down, when OS upgrades happened (useful for bounding artifact formats).
- **Cannot prove:** that the software **ran**, or who launched the installer. **Drag-and-drop `.app` installs leave no install.log entry.**
- **Tip:** correlate with quarantine xattrs, LaunchAgents, KnowledgeC/Biome.

### Execution and persistence [S55]

- **Persistence:** LaunchAgents (`~/Library`, `/Library`), LaunchDaemons (`/Library`, `/System/Library`), login/background items (`.btm`), cron, periodic, shell startup files, MDM Login Items.
- **Execution:** KnowledgeC `/app/inFocus`, Biome `App.InFocus`, Unified Logs, Spotlight `kMDItemLastUsedDate`, Saved Application State, code-sign and XProtect logs.
- **Can prove:** a program was configured to start, when the persistence file was written, an app was in the foreground at a given time.
- **Cannot prove:** that a daemon actually ran at a given moment, or that a user knowingly installed it (many legitimate apps install agents).
- **Tip:** Ventura+ shows background items in System Settings > General > Login Items; the `.btm` file behind it is the artifact.

---

## 15. KnowledgeC [S56-S60]

- **System context:** `/private/var/db/CoreDuet/Knowledge/knowledgeC.db`
- **User context:** `~/Library/Application Support/Knowledge/knowledgeC.db`
- The DB behind **Screen Time, Siri suggestions, "Continue on Mac"**: a diary of device activity, kept about **four weeks.**

**Common streams:** `/app/inFocus`, `/app/activity`, `/safari/history`, `/display/isBacklit` (screen on), `/device/isLocked`, `/media/nowPlaying`, `/app/install`

### Database structure [S57]

|Table/field|What to review|
|---|---|
|**ZOBJECT**|Primary event table: `ZSTREAMNAME`, `ZSTARTDATE`, `ZENDDATE`, `ZVALUESTRING`, `ZVALUEINTEGER`|
|**ZSOURCE**|Source app/service metadata; helps bundle ID attribution|
|**ZSTRUCTUREDMETADATA**|Extra metadata, often a blob/archived object; needs parser support|
|**ZSTREAMNAME**|Event type|
|**Timestamps**|Usually **Mac Absolute**. Add **978307200** to get Unix epoch|

### Worked example [S59]

|Stream|Raw start|Converted (PDT)|Value|Meaning|
|---|---|---|---|---|
|`/display/isBacklit`|813644048|13 Oct 2026 21:14:08|1|Screen on|
|`/device/isLocked`|813644071|21:14:31|0|Unlocked|
|`/app/inFocus`|813644102|21:15:02|com.apple.Safari|Safari to front|
|`/safari/history`|813644200|21:16:40|example.com/invoice|Page visited|
|`/app/inFocus`|813645072|21:31:12|com.apple.Terminal|Terminal to front|
|`/display/isBacklit`|813645655|21:40:55|0|Screen off|

**Conversion:** `813644048 + 978307200 = 1791951248` = 2026-10-14 04:14:08 UTC = **21:14:08 PDT** (`ZSECONDSFROMGMT = -25200`). `ZENDDATE - ZSTARTDATE` = duration.

### Limitations [S60]

- Schemas and stream availability vary by macOS version and between system/user DBs.
- Some records **sync from other devices on the same Apple ID** (check `ZSOURCE` and device IDs), so a row is **not automatically local activity.**
- Retention ~4 weeks. An empty DB with a current timestamp usually means **retention, not wiping.**
- Since Ventura most streams go to **Biome first**; by macOS 27 several appear **only in Biome.** Parse both and compare.

---

## 16. Biome [S61-S63]

- Activity streams in a **folder hierarchy**, commonly under `/private/var/db/biome` (system) and `~/Library/Biome/streams/` (user).
- Streams may be **public or restricted**, often stored as **SEGB** binary files with metadata plists. Records inside are **protobuf.**
- High-value streams: app focus, Safari history, device status, activity level, power state.
- Parsing is **less mature** than SQLite artifacts. **Keep raw files** for reprocessing as tools improve.

**Interpretation notes [S62]:**

- Biome is **not a single database**; it is a **stream-based artifact family.**
- Check `metadata.plist` for stream properties (retention/max age).
- SEGB filenames can contain **Apple-epoch timestamp values** with sub-second precision (file name = Cocoa timestamp of first record).
- Expect rapid change across OS releases. Validate against stream path and raw record timing.

**Example streams:** `_DKEvent.App.InFocus`, `_DKEvent.Device.IsLocked`, `_DKEvent.Safari.History`, `_DKEvent.Activity.Level`, `Device.Power.BatteryLevel`, `Device.Power.PluggedIn`, `Device.Wireless.BluetoothGATTSession`, `OSAnalytics.Stability.Crash`

---

## 17. Other user-activity artifacts [S64-S67]

|Artifact|Details|
|---|---|
|**QuickLook thumbnails**|Previews of files viewed in Finder/apps; thumbnail indexes and data under user cache locations. Useful when a file is deleted, external, or briefly present. **Suggests preview generation, not necessarily deliberate opening by a specific user**|
|**Spotlight**|`.Spotlight-V100` holds metadata indexes: file names, paths, content hints, `kMDItemWhereFroms`, last-used dates, doc metadata. Good for files that existed, moved, or were indexed on external volumes. Depends on volume settings/exclusions|
|**Recent items**|`.sfl2`/`.sfl3` lists, older recentitems plists, app-specific MRU lists|
|**Finder preferences**|Window state, sidebar items, recent folders|
|**Dock plist**|Persistent apps, documents, recent apps|
|**Rule for recents/Finder/Dock**|**Navigation evidence:** what was available or recently referenced, **not proof of content**|

### Browser artifacts [S67-S68]

|Browser|Key artifacts|
|---|---|
|**Safari**|`~/Library/Safari/History.db`, Downloads metadata, bookmarks, tabs/session state, website data|
|**Chrome/Edge/Brave**|History, Cookies, Login Data, Favicons, Top Sites, Preferences, extension data (WebKit/Chrome time, 1601, microseconds)|
|**Firefox**|`places.sqlite`, `cookies.sqlite`, `favicons.sqlite`, sessionstore, downloads|

**Correlate:** history, downloads, quarantine, cached content, and file system timestamps.

**Safari `History.db` structure [S68]:**

|Table|Fields|Use|
|---|---|---|
|`history_items`|id, url, domain_expansion, visit_count|URL identity, aggregate visits|
|`history_visits`|history_item, visit_time, title, load_successful, redirect_source|Timeline and navigation chains|
|metadata/segments|Version-dependent|Extra page metadata|
|**WAL**|Uncheckpointed rows|May hold the most recent visits or deleted fragments|

---

## 18. Network, Wi-Fi, Bluetooth [S69]

|Item|Path / detail|
|---|---|
|**Ventura and later**|`/Library/Preferences/com.apple.wifi.known-networks.plist`: SSID, BSSID history, first/last joined, added-by (user, MDM, iCloud sync)|
|**Monterey and earlier**|`/Library/Preferences/SystemConfiguration/com.apple.airport.preferences.plist`|
|**Interface inventory**|`/Library/Preferences/SystemConfiguration/NetworkInterfaces.plist` (MAC addresses)|
|**Bluetooth**|`/Library/Preferences/com.apple.Bluetooth.plist`: paired devices, names, addresses, last-connected times|
|**Timing**|**Unified Logs** give the best timing for joins, DHCP leases, VPN, captive portals, AirDrop sessions|

---

## 19. Keychain and credentials [S70]

- Keychains store **passwords, certificates, Wi-Fi secrets, tokens, secure notes.**
- **User:** `~/Library/Keychains`. **System:** `/Library/Keychains/System.keychain`.
- Decryption usually needs the **user password**, key material, or tool-specific support.
- **Report carefully:** access to a secret does **not** automatically prove use.

---

## 20. Quick-reference tables

### Key paths cheat sheet

|What|Path|
|---|---|
|Safari history|`~/Library/Safari/History.db`|
|Messages|`~/Library/Messages/chat.db`|
|KnowledgeC (user)|`~/Library/Application Support/Knowledge/knowledgeC.db`|
|KnowledgeC (system)|`/private/var/db/CoreDuet/Knowledge/knowledgeC.db`|
|Biome (system / user)|`/private/var/db/biome/streams/` and `~/Library/Biome/streams/`|
|TCC|`~/Library/Application Support/com.apple.TCC/TCC.db`|
|Notes|`~/Library/Group Containers/group.com.apple.notes/NoteStore.sqlite`|
|User accounts|`/private/var/db/dslocal/nodes/Default/users/*.plist`|
|Unified Logs|`/private/var/db/diagnostics`, `/private/var/db/uuidtext`|
|Install log|`/var/log/install.log`, `/var/db/receipts/`|
|FSEvents|`/.fseventsd/`|
|Wi-Fi (Ventura+)|`/Library/Preferences/com.apple.wifi.known-networks.plist`|
|Bluetooth|`/Library/Preferences/com.apple.Bluetooth.plist`|
|Background items (Ventura+)|`/private/var/db/com.apple.backgroundtaskmanagement/BackgroundItems-v*.btm`|
|Keychains|`~/Library/Keychains`, `/Library/Keychains/System.keychain`|
|Dock|`~/Library/Preferences/com.apple.dock.plist`|
|Shell history|`~/.zsh_history`, `~/.bash_history`|

### Commonly confused

|Concept A|Concept B|
|---|---|
|**Legacy FileVault** (10.3-10.6): home folder only|**FileVault 2** (10.7+): full volume|
|**Intel**: keys on drive, wrapped by FileVault password|**Apple silicon**: keys in Secure Enclave, never leave chip|
|**Target Disk Mode** (Intel)|**Share Disk over SMB** (Apple silicon)|
|**Fusion Drive**: tiered storage|**RAID 0**: striping (Fusion is _not_ RAID 0)|
|**Core Storage** (2012-2018)|**APFS Fusion** (Mojave 10.14+)|
|**SIP**: protects system locations even from root|**SSV**: cryptographic seal on System volume (Big Sur+)|
|**BFU**: data keys not in memory|**AFU**: data keys in memory after unlock|
|**KnowledgeC**: SQLite, legacy|**Biome**: stream-based SEGB/protobuf, primary on modern macOS|
|**`.wal`**: may hold newest records|**`.shm`**: only confirms WAL activity|
|**Unix epoch** 1970 / **Mac Absolute** 2001 / **HFS+** 1904 / **WebKit** 1601|Always confirm which before converting|
|**Live acquisition** (running, unlocked)|**Boot-based acquisition** (Recovery/Share Disk/Collector)|
|**Dead-box imaging**: works on older Intel|Pointless on T2/Apple silicon (ciphertext)|

### Acquisition by hardware (summary)

|Hardware|Best approach|
|---|---|
|Older Intel (to ~2017)|Remove drive, image it; still confirm FileVault and APFS|
|Intel + Fusion|Acquire **both** SSD and HDD; use Fusion-aware tool|
|Intel + T2 (2018-2020)|Live or boot-based acquisition; need credentials|
|Apple silicon (2020+)|Live or boot-based (Recovery, Share Disk, Collector); need user/owner password; plan carefully|

---

## 21. Practice questions (from the quiz)

1. **2017 iMac, 1 TB HDD, imaged volume looks empty.** Most likely a **Fusion Drive**: the HDD is only one tier; acquire the SSD too.
2. **User denies a file existed; live FS shows nothing.** **APFS snapshots** may preserve it. Confirm name, date, UUID/XID, and whether the tool processed it.
3. **2022 MacBook Pro (Apple silicon, FileVault on).** Best: **live, booted acquisition with user credentials while unlocked.**
4. **Catalina image, can't find user files under System volume paths.** The **System volume is read-only; user data is on the Data volume**, joined by firmlinks.
5. **Copied only `.sqlite`, ignored `.wal`/`.shm`.** The **WAL may hold newer, un-checkpointed records**, so recent activity may be missed.

---

## 22. Examiner best-practice checklist

- [ ] Identify hardware model, chip family, OS version/build
- [ ] Check if the Mac is **running and unlocked**; if so, capture **RAM first**
- [ ] Do **not** power off an unlocked or FileVault-protected Mac
- [ ] Determine **FileVault** status and seek password/recovery/escrowed key (if legally available)
- [ ] Check **SIP** status with `csrutil status`; avoid changing it, and document any change
- [ ] Confirm **Fusion Drive** (two devices) and image both
- [ ] Image at the right **APFS level** (container/volume group); check for **snapshots**
- [ ] Hash everything and log every command run on the evidence Mac
- [ ] Copy **`.sqlite` + `.wal` + `.shm`** together; work only on **forensic copies**
- [ ] Confirm **timestamp epoch** before converting
- [ ] Parse **both KnowledgeC and Biome**; compare
- [ ] **Verify** tool output against the raw source for at least one item
- [ ] In the report, separate **what artifacts can prove** from **what they cannot** (e.g., account ≠ person, thumbnail ≠ deliberate opening, credential access ≠ use)
- [ ] For iPhones: keep **powered** (AFU), mind the **72 h inactivity reboot** and **1 h USB Restricted Mode** timers