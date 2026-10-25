1. SQL Injection on a DB server.
SQL injection happens because an application builds database queries from invalid user inputs, letting an attacker alter the query. The main way to handle it would be the use of prepared statements with paarameterized queries which can ensure that the user input is always treated as data and never executes as SQL query. This should be supported by the server-side input validation that allows only expected type, length and format on entering fields. The database account should also follow the least privilige principle, so even a successful injection would not have full administrative functions or unrelated tables. A web application firewall can also be added as another layer by filtering known injection patterns, and database activity monitoring and loggin helps with identifying injection attacks, Additionally, backups and updates should be done regularly.

2. Cross Site Scripting Attack.
XSS happens when an applicdation includes a untrusted input in a webpage iwthout proper handling, allowing the attacker to run script on the victim's browser. The main way to deal with this attack is output encoding, which converts user data into a safe, non-executable format before rendering into the browser, also supported by validations and sanitizations. A content security policy (CSP) can be used to prevent contents from being loaded and blocking inline scripts. Adding cookie attributes like secure flags can prevents injectied scripts from stealling session tokens. 

3. Unauthorized access to a NAS (Network Attached Storage) device.
Default credentials should be changed, strong passwords or multi-factor authentication should be enforeced, permission for access control lists and role based access should be set with least privilege. At the network level, the NAS should be on a VLAN behind a firewall, with unused service or ports disabled. Data should be encrypted when in rest and in transit, like TLS. Logging and auditing functions should be enabled for alerts when there are repeated failed logins, regular updates to keep firmwares up to date and backups. Physical unathorized access should be handled with strong security with keeping NAS device in locked room with its own logging system to monitor peronsals who came to the room, in order to prevent direct tampering, 

4. Repudiation Attack.
Reudiation attack is when a user denies having performed an action but denied they have done it and the organization cannot prove otherwise. Digital signatures are strong technical controls as only the holder of the private key could have produced the signature, and certificates issued through a PKI bind that key to a verified identity. Strong authentication with layers of security to tie each action to a single person can help prevent repudiation attacks, like multi-factor authentication, no share accounts, unqiue IDs. Tamper resistant loggin with timestamps, userID, and source addresses stored on a protected server, procides the evidence and time trail.

5. DDoS utilizing a Botnet.
A bonet DDoS attack floods a target with traffic from a lot of compormised machines and cannot be fully prevented and it can mask as real user communications. Ingress and egress filtering and rate limigting at routers and firewalls reduce the traffic that reaches the target server. Having redundant bandwidth, load balancing, and CDN (content delivery network) can help with the surge of DDoS attacks. IDS/IPS and traffic monitoring provides early detection of abnormal traffic. Moreover, the remaining risks can be resolved by external 3rd party DDoS mitigation, or from ISP. More risks can be resolved with CP (contingency planning), where it allows operation on main server functionality to fail over to an alternate server if the hot server is exhausted.


>1. Security Association Database
A database used by IPsec to store security associations including encryption algorithms, keys and other parameters used to secure network traffic. 
>2. Stored XSS
A vulnerability where malicious JavaScript that is stored on a server, like on a database and executes in user's browsers when they view the affected content

3. Metamorphic Worm
A type of worm that changes it own code and spreads to avoid detection by antiviruses while doing its own function of attacking its victim

4. APT
Adanvced persistent threats is a prolonged, targeted cyberattacks in which the attacker gains access to a network and attempts to reamin undetected while stealing information or cause damages 

5. Mobile code
software codes that is obtained from remote information system, transmitted through a network and executed on a local device without installation or execution by the victim. 

6. Certificate Revocation 
The process of invalidating a digital certificate before the expiration time, happens when the certificate is no longer trustworthy and the private key is comprimised, security or bad issuance by CAs 