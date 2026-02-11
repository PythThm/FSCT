# Cryptography
## Principle of Security
- CIA Triad
- Authentication
- what protocol to use? TCP is reliable but not secure, UDP is the same 
- What level should be responsible for security? 
	- network: IPsec
	- transport: QUIC
	- SSL, TLS, SSH
## The Actors
- 2 way communication
- alice and bob wants to communicate, intruder (attacker) wants to attack the communication between them
- Eavesdrop, impersonation, hijacking, denial of service 

## Encryption
- Secret key used in decryption and encryption, maybe pairs of key
- Caesar cipher with K = 13 (rot 13)
- m: plaintext, Ka(m): ciphertext, Kb(Ka(m)) = m
- Breaking Encryption
	- Ciphertext-only attack: bruteforce or statistical analysis (pattern recognizition)
	- Known-plaintext attack: know plaintext and cipher text, to break other ciphers
	- Chosen-plaintext attack: atker has the ability to encrypt any plaintext, but no key for decryption

## Symmetric Cryptography
Caesar Cipher: Plaintext Character + shift (if 26 or above minus 26)
CBC: Plaintext Character + salt + shift, using index as salt from the previous character 
- procession: 
	- Caesar cipher: egdrthhxdc
	- CBC: zfizszgdgi
- graffiti:
	- Caesar cipher: pajoorcr
	- CBC: ttcqevxn

## Asymmetric Encryption
- pub key priv key
- Math
	- Ka = key from Alice
	- Kb = key from Bob
	- K- = private key
	- K+ = public key
	- H(m) = Hashed message 
	- quiz: What is Ka-?
- Confidentiality:
	- Ciphertext = K+(m), encrypted with pub key from receiver
	- decryption = K-(K+(m)) = m, decrypt with priv key
	- only the receiver should be able to decrypt it 
- Authentication
	- Ciphertext = K-(m), encrypted with priv key from sender
	- decryption = K+(K-(m)) = m
	- verify the identify of sender
- Integrity
	- how to ensure the data is not manipulated during transit
	- sender hashes the message 
	- sender signs the message with their priv key (Signature)
	- sender sends hashed message + Signature
	- Receiver decrypt Signature with sender's pub key, K+(K-(m)) = m, where m is hashed
	- Receiver checks if the hash matches, comparing decrypting signature with sended plain hash values
- Integrity + confidentiality:
	- just do both, checks Signature at the same time 
#### Hash function
- also known as message digest
- Signed Message Digest
	- Bob sends message and sign with his priv key and hashes his message (Kb-(H(m)))
	- Alice receives plain message and computes hash of that message (Hnew(m))
	- Alice receive encrypted message and decrypts with Bob's public key (Kb+(Kb-(H(m))))
	- if the decrypted hashed message = Alice's computed hash message, the message is considered signed 
- Secure hash function should avoid hash collision 
#### MAC - Message Authentication Code
- used in symmetric cryptography
- Secret (s) used to generate the MAC
- provides authentication and integrity

## CA - Certification Authority

In-Class Activity 
1. (kb+(ks))
2. ka-(kb+(ks))