# Authentication
## End-point authentication
- Goal: Bob wants Alice to prove her identity
- Option 1: Send message with identification but easily spoofed 
- Option 2: Includes IP known to bob, but can IP can be spoofed and eavesdrop
- Option 3: password, eavesdrop then password is leaked 
- Option 4: encrypted password, if password and encryption stays the same, replay attack 
- Option 5: Nonce, one-time message from Bob, Alice return same message encrypted with shared key, like timestamp, so replay attacks are impossible
- Option 6; Nonce, one-time message (*R*), alice returns with message encrypted with Ka-, only good if Bob can confirm Ka+ is actually Alice's 
---
# Building a Security Protocol
- Handshake, both parties use their certificates to authenticate eachother and private keys to share secret 
- Key Derivation, both parties use shared secret to derive keys
- Date transfer, series of messages ("records")
- Connection. securely close a connection

## Handshake
- TCP connection - first handshake for SYN & SYNACK
- Second handshake - ACK and reply with certificate
- Sender creates master secret key MS - used to generate all the other keys for session
- 3 round-trip times (RTTs) before data can be sent 

## Key Derivation
- Both parties generates the same 4 keys
- MAC (Message Authentication Code)
-  K <sub>B</sub> : encryption key for data sent from Bob to Alice  
- 𝑀<sub>B</sub>: MAC key for data sent from Bob to Alice  
- K<sub>A</sub>: encryption key for data sent from Alice to Bob  
- 𝑀<sub>A</sub>: MAC key for data sent from Alice to Bob

## Data Transfer
- Data is sent in small chunks ("records")
- letting the receiver verify each piece immediately, process data as it arrives
- each record includes a MAC, proving the data was not modified and is legit sender
- 𝑀<sub>A</sub> & 𝑀<sub>B</sub> is used
- suppose Message = m, Length of message = l 
- When Alice sends a message to bob
	1. E(K$_A$, l ) = Encrypted Length, prevents attacker from knowing message size
	2. E(K$_A$, m ) = Encrypted message, keeping the content a secret
	3. H(m, M$_A$) = MAC, ensure integrity and authenticity
$$
H( K_A(l, m) + M_A ), K_A(l, m)
$$
## Connection Termination
- possible attack on data steam, where attacker forges TCP connection close segment
- just send a sequence number n from receiver to sender (0 is regular message, 1 as closing)

### MAC - Message Authentication Code
***A Hash-liked Function over the message that uses a secret key***
- A locked checksum
- only someone with the secret can create the correct MAC
- anyone without the key cannot fake or modify the message 
- Alice computes the MAC from her MAC key (M$_A$)
- Alice sends m + MAC
- Bob recomputes the MAC using Alice's MAC key (M$_A$)
- If the MACs match, the message is authentic and unchanged 

***A MAC key is a symmetric secret key shared by both sender and receiver, used only for integrity and authentication***
- It is not an encryption key 
- The MAC key is derived from the master secret (MS)
- Using a Key Derivation Function (KDF)

***The Master Secret is a shared secret value that Alice and Bob established during the handshake and then sue as the root material to generate all session keys.***
- it produces the Encryption keys (K) and MAC keys (M)
- no master secret = no secure communication
- *Diffie-Hellman Key Exchange*
- Random, Temporary (per session), Shared only between receiver and sender
- MS → KDF → multiple keys

---
# TLS
- Confidentiality: Symmetrical Encryption
- Integrity: MAC (Message Authentication Code)
- Authentication: Public key Cryptography and certificates
- TLS support key gen, Encryption, MAC. Digital signature
- Cipher suites: chosen algorithms negotiated during handshake
- client sends supported cipher suites, server chooses one of the supported cipher suite

---
# QUIC
- Runs on top of UDP
- Speed of UDP, but provides reliability of TCP, plus TLS security 
- Deployed in 2012, 5-10% of internet traffic is QUIC in 2021
- HTTP/2 over QUIC = HTTP/3
- Traditional way: IP > TCP > TLS > HTTP/1 or HTTP/2
- Modern way: IP > UDP > QUIC <-> TLS 1.3 > HTTP/3 (handshake is not needed)
- QUIC runs in the user space (inside applications), not inside the OS's Kernel
- QUIC integrates TLS into Transport
- Completes both TCP and TLS handshake in one RTT
