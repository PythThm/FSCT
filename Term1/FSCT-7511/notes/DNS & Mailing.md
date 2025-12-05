## **Part 1: Domain Name System (DNS)**

### **1. Purpose and Overview**

- **Definition:** DNS is a distributed database implemented by a hierarchy of name servers1. It is an application-layer protocol2.
    
- **The Problem:** Humans have trouble remembering numbers (IP addresses), and IP addresses can change3.
    
- **The Solution:** Map user-friendly names (e.g., `www.example.com`) to IP addresses4. This masks address changes from the user5.
    
- **Major Design Goals:**
    
    - **Scale:** Must handle millions of domains and users6.
        
    - **Ease of Management:** Administrative autonomy (e.g., who names a host "students" at UBC)7.
        
    - **Availability/Consistency:** Ensuring reliable answers8.
        
    - **Performance:** Handling billions of requests per day9.
        

### **2. DNS Hierarchy**

DNS uses a hierarchical design to achieve scalability10.

- **Root Name Servers:** The top of the hierarchy. There are 13 logical root name servers worldwide11. They know the addresses of TLD servers12.
    
- **Top-Level Domain (TLD) Servers:** Responsible for domains ending in `.com`, `.org`, `.edu` and country codes like `.ca`, `.uk`13.
    
- **Authoritative Name Servers:** Store the actual name-to-address mappings (resource records) for a specific organization (e.g., `ubc.ca`)14.
    
- **Local Name Server (Default Name Server):**
    
    - Does not belong to the hierarchy but is central to the user experience15.
        
    - Provided by the ISP, University, or Company16.
        
    - Acts as a proxy: The host sends a query to the local server, which forwards it into the hierarchy17.
        
    - **Command to find yours:** `scutil --dns` (MacOS) or `ipconfig /all` (Windows)18.
        

### **3. How Resolution Works (Iterative)**

1. **Request:** Host (`cis.poly.edu`) wants IP for `gaia.cs.umass.edu`19.
    
2. **Local Query:** Host contacts **Local DNS Server**.
    
3. **Root Query:** Local server contacts **Root Server**. Root replies with TLD server (`.edu`)20.
    
4. **TLD Query:** Local server contacts **TLD Server**. TLD replies with Authoritative server (`umass.edu`)21.
    
5. **Authoritative Query:** Local server contacts **Authoritative Server**. It returns the IP address22.
    
6. **Response:** Local DNS server sends the IP back to the host23.
    

### **4. Caching & Records**

- **Caching:** Essential to prevent root servers from becoming bottlenecks. Local DNS servers cache responses for a specific time defined by the **TTL (Time To Live)**24.
    
- **Resource Records (RR):**
    
    - Format: `(name, type, value, TTL)`25.
        
    - **Type A:** Hostname $\rightarrow$ IPv4 Address.
        
    - **Type AAAA:** Hostname $\rightarrow$ IPv6 Address.
        
    - **Type NS:** Domain Name $\rightarrow$ Authoritative Name Server.
        
    - **Type CNAME:** Alias $\rightarrow$ Canonical (Real) Name.
        

### **5. Protocol Details**

- **Transport:** Uses UDP on **Port 53**26.
    
- **Message Size:** Limited to 512 bytes (max UDP segment). Larger messages require EDNS27.
    
- **Reliability:** Achieved by repeating requests if a client times out28.
    
- **Commands:** `dig` is used to manually query DNS servers and trace resolution29.
    

---

## **Part 2: Electronic Mail**

### **1. Architecture & Components**

Email works on a "push" and "pull" system, similar to a physical post office30.

- **User Agents (UA):** The interface for the user (e.g., Outlook, Gmail). Used to compose, edit, and read mail31.
    
- **Mail Servers:** Maintain mailboxes for users and queues for outgoing messages32.
    
    - **MTA (Mail Transfer Agent):** Sends mail between servers (e.g., Postfix, Sendmail)33.
        
    - **MDA (Mail Delivery Agent):** Delivers mail to local storage (e.g., Procmail, Dovecot)34.
        

### **2. Email Protocols**

#### **SMTP (Simple Mail Transfer Protocol)**

- **Role:** Sending/Pushing email.
    
    - User Agent $\rightarrow$ Server (Submission)35.
        
    - Server $\rightarrow$ Server (Relay)36.
        
- **Ports:**
    
    - **Port 25:** Message relay37.
        
    - **Port 587:** Message submission38.
        
- **Operation:** Uses TCP.
    
    1. **Handshake:** Greeting (`HELO`/`EHLO`)39.
        
    2. **Transfer:** Sending the message (`MAIL FROM`, `RCPT TO`, `DATA`)40.
        
    3. **Closure:** `QUIT`41.
        
- **Vulnerability:** SMTP commands ("envelope") can differ from the message headers ("content"). This allows for **Spoofing** (e.g., "From" header says "CEO", but envelope sender is different)42424242.
    

#### **Mail Access Protocols (Retrieval)**

Used to "pull" email from the server to the user agent43.

1. **POP3 (Post Office Protocol 3):**
    
    - **Concept:** Download and delete (usually). Stateless and simple44.
        
    - **Commands:** `user`, `pass`, `list`, `retr` (retrieve), `dele` (delete), `quit`45454545.
        
2. **IMAP (Internet Message Access Protocol):**
    
    - **Concept:** Messages are kept on the server and organized into folders46.
        
    - **Ports:** TCP **143** (Standard), **993** (IMAPS/SSL)47.
        
    - **Features:** Syncs state (read/deleted) across multiple devices/sessions48.
        
3. **HTTP:** Used for web-based email (e.g., Gmail in a browser)49.
    

### **3. Email Security (Authentication)**

To combat spoofing, three major protocols are used:

- **SPF (Sender Policy Framework):** Uses DNS TXT records to list IP addresses authorized to send mail for a specific domain. Receiver checks the sender's IP against this list50.
    
- **DKIM (DomainKeys Identified Mail):** Uses cryptographic signatures attached to message headers to verify the domain and ensuring content integrity51.
    
- **DMARC:** Builds on SPF and DKIM. Provides policy (reject/quarantine) and reporting mechanisms for abuse52.
    

---

## **Part 3: Server Configuration & Storage**

### **1. Postfix (SMTP Server)**

- **Role:** The modern standard SMTP server (MTA) for UNIX/Linux53.
    
- **Configuration File:** `/etc/postfix/main.cf`54.
    
- **Key Settings:**
    
    - `myhostname`: FQDN of the system.
        
    - `mydomain`: Domain part of the hostname.
        
    - `inet_interfaces`: Network interfaces to listen on (set to `all` to receive external mail).
        
    - `mydestination`: Domains for which the server accepts mail locally.
        
    - `relayhost`: Outbound SMTP server to route mail through55.
        

### **2. Procmail (Filtering)**

- **Role:** Filters email (blocks spam, redirects, copies)56.
    
- **Usage:** Called by the MTA. Rules begin with `:0`57.
    
- **Flags:** `H` (Header match - default), `B` (Body match), `D` (Case-sensitive)58.
    

### **3. Dovecot (MDA/POP/IMAP Server)**

- **Role:** Standard MDA. Supports POP and IMAP59.
    
- **Configuration:** `/etc/dovecot/dovecot.conf`.
    

### **4. Mail Storage Formats**

- **mbox:**
    
    - All mail stored in a **single file** (usually in `/var/spool/mail/username`)60.
        
    - **Pros:** Easy to search (grep).
        
    - **Cons:** File locking issues when reading/writing simultaneously61.
        
- **Maildir:**
    
    - Directory structure for each user containing subdirectories: `new`, `cur`, `tmp`62.
        
    - **Pros:** Faster, no file locking required63.
        

---

### **Review Question (from Slides)**

Q: Which protocol does a user use to send a composed message to their own mail server?

**A:** **SMTP**64.

Q: Which protocols could a user use to read email from their server?

**A:** **POP3 or IMAP**65.

**Next Step:** Would you like me to generate a quiz based on these notes to test your knowledge of port numbers and DNS record types?