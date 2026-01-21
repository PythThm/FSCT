# Introduction to Cellular Technology

## What Is a Cellular Phone

- A cellular phone is a telecommunication device that uses radio waves to communicate over a network divided into geographic areas called **cells**
- Communication is handled through **cell sites / base stations**
- Enables wireless calls to other mobile devices, landlines, or via the internet
- Identified as a **mobile system** consisting of:
    - Physical device (hardware)
    - SIM card (if applicable)
- Also known as a **cellphone** or **mobile phone**

---

## What Qualifies as a Cellular Device

- A device must be able to **connect to a cellular network**
- Example:
    - Tablet without SIM card → not a cellular device
    - Tablet with SIM card → cellular device

---

## Cellular Devices as Computer Systems

**Criminal Code Sec 342.1 (2): Computer System**  
A computer system is:

- A device (or group of devices) that:
    - Contains computer programs or data
    - Performs logic and control functions
- Cellular devices meet this definition

---

## Cellular Device Capabilities

### Direct (Carrier-Driven)

- Voice calls
- SMS
- MMS
- Mobile data

### Indirect (Third-Party / App-Based)

- GPS applications
- Social media
- Camera, audio, video
- Email
- Games
- NFC
- Cloud storage

---

## Historical Types of Cellphones

### Basic / Flip Phones

- Voice calls and SMS only
- Very limited storage
- Little to no MMS, email, or internet

### iDEN (Integrated Digital Enhanced Network)

- Developed by Motorola in 1991
- Known for Push-To-Talk (PTT)
- Combined cellular and walkie-talkie functionality
- Network decommissioned around 2016

### Burner Phones

- Cheap, prepaid, disposable
- Used as backup or emergency phones
- Advantage: not registered to the user
- Commonly associated with criminal use

---

## Smartphones

- Allow app installation and removal
- Touchscreen with large display
- Storage typically starts around 4 GB
- Major operating systems:
    - iOS
    - Android
    - BlackBerry OS
    - Windows Phone (7–10)
    - Symbian
    - Others: Tizen, MeeGo, WebOS, Firefox OS

---

## CDMA (Code Division Multiple Access)

### Key Characteristics

- No SIM card
- Difficult roaming
- Operates on specific frequency bands
- No CDMA networks left in Canada
- Previously used by Bell, Telus (Canada), Sprint, Verizon (USA)

### Concept

- Devices transmit using unique code patterns
- Receiver must know the same pattern
- Allows many devices to communicate simultaneously

---

## CDMA Device Identification

### ESN (Electronic Serial Number) – 2G

- 11-digit decimal or 8-digit hexadecimal
- Ran out in 2008
- Structure:
    - First 3 digits: Manufacturer
    - Last 8 digits: Serial number

### MEID (Mobile Equipment Identifier) – 3G

- 14–15 hexadecimal characters
- Structure:
    - 2 digits: Regional code
    - 6 digits: Manufacturer
    - 6 digits: Serial number
    - Optional checksum
- Pseudo-ESN used for backward compatibility

### Other Identifiers

- MDN (Mobile Directory Number): phone number on CDMA network

---

## GSM (Global System for Mobile Communications)

### Key Characteristics

- Uses SIM cards
- Most common technology in Canada
- Based on TDMA (Time Division Multiple Access)
- Without a SIM card, only emergency numbers can be dialed

---

## GSM Device Identification

### IMEI (International Mobile Equipment Identity)

- 15–16 digit number
- Unique to the device
- Structure:
    - First 8 digits: TAC (manufacturer/model)
    - Next 6 digits: Serial number
    - Last digit(s): Checksum or software version

### SIM-Based Identifiers

- ICCID: SIM card serial number
- IMSI: Subscriber identity tied to SIM
- MSISDN: Phone number assigned to SIM (can change)

### IMEI Uses

- Blacklisting stolen devices
- Carrier locking
- Device tracking by carriers
- IMEI modification services exist (often illegal or fraudulent)

---

## Locating Device Identifiers

- Under battery
- Back of device
- SIM tray
- Device box
- Settings menu
- Dial code: `*#06#`

---

## BlackBerry-Specific Identifier

- PIN: 8-character hexadecimal number
- First character indicates network type:
    - 2xxxxxxx → GSM/UMTS/LTE
    - 3xxxxxxx → CDMA
    - 4xxxxxxx → iDEN

## IMSI (International Mobile Subscriber Identity)

- Linked to the SIM card
- Used by the network to authenticate subscribers
- Usually 15 digits
- Moving SIM to another phone changes IMEI but not IMSI

---

## ICCID (Integrated Circuit Card Identifier)

- Unique SIM serial number
- Printed on SIM
- Used in forensic analysis
- IMSI can sometimes be derived from ICCID if SIM is locked

---

## Device Identification for Forensics

- Photograph and document the device
- Visual inspection and branding
- Identify removable SIM and memory cards
- Check manuals and carrier/manufacturer websites
- FCC ID is not a unique identifier
- Temporary identifiers: Wi-Fi or Bluetooth MAC address
- IMEI is ultimately required for carrier records (CDRs)

---

## Cellular Network Fundamentals

### Cells and Base Stations

- Coverage area divided into **cells**
- Each cell served by a **Base Transceiver Station (BTS)**
- BTS commonly called a cell tower
- Radio coverage is radial, not perfectly shaped

### Urban vs Rural

- Urban: more BTS due to interference and density
- Rural: fewer, taller towers covering larger areas

---

## Cell Sectors and Antennas

- Towers usually have 3 antennas
- Each covers ~120 degrees
- Sectors labeled as:
    - 1 / 2 / 3
    - A / B / C
    - Alpha / Beta / Gamma
- Azimuth:
    - Direction antenna faces
    - Measured in degrees from true north

---

## Generations of Cellular Networks

- 1G: Analog
- 2G: Digital, limited data
- 3G: Faster digital data
- 4G: High-speed data (LTE)
- 5G: IoT-focused, ultra-low latency

---

## 2G Cellular Networks

### 2G GSM

- Rogers (Canada)
- Introduced SIM cards
- GPRS and EDGE enabled mobile data
- Still used in limited or backup scenarios

### 2G CDMA

- Bell and Telus (Canada)
- No SIM cards
- Incompatible with GSM
- Introduced SMS texting

---

## 3G Cellular Networks

### UMTS (3G GSM)

- Developed by 3GPP
- Uses W-CDMA
- Supports GSM fallback
- Required new towers and frequencies

### 3G CDMA (cdma2000)

- Developed by 3GPP2
- EV-DO revisions improved data speeds
- Eventually replaced by UMTS and LTE
- Telus CDMA shutdown: 2017
- Bell CDMA shutdown: 2018

---

## 4G LTE

- Developed by 3GPP
- IP-based (TCP/IP backend)
- LTE Advanced provides higher speeds
- Backbone of modern mobile data

---

## 5G Networks

### Key Features

- Up to 10 Gbps speeds
- ~1 ms latency
- Supports 1 million devices per km²
### Capabilities

- Instant downloads
- Real-time gaming
- Smart homes and wearables
- Remote healthcare
- AI-driven applications

---

## Canadian Carrier Networks

### Rogers

- GSM (shutdown 2018)
- UMTS (HSPA+)
- LTE / LTE Advanced

### Bell

- CDMA (shutdown 2018)
- UMTS (HSPA+)
- LTE / LTE Advanced

### Telus

- UMTS (HSPA+)
- LTE / LTE Advanced

### Freedom Mobile

- UMTS / DC-HSPA+
- LTE (ongoing rollout)

---

## GSM Network Architecture

### Mobile Station (MS)

- Mobile Equipment (ME) + SIM
- Contains IMEI
- IMEI checked against stolen device lists

---

## Base Station Subsystem (BSS)

- **BTS**: Handles radio communication with phones
- **BSC**: Manages multiple BTS units
    - Handles handovers
    - Allocates radio channels

---

## Network Switching Subsystem (NSS)

- **MSC**: Call switching, routing, mobility management
- **HLR**: Subscriber database and last known location
- **VLR**: Temporary subscriber data for visited areas
- **EIR**: Controls device access (allowed, barred, monitored)
- **AuC**: Authentication and encryption keys
- **GMSC**: Entry point for incoming calls
- **SMS-G**: Handles SMS routing

---

## Operation and Support Subsystem (OSS)

- Monitors and controls network operations
- Manages performance and traffic 
- Supports scalability and maintenance