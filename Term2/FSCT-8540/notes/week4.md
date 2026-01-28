# OWASP Top 10 Vulnerability
#### Broken Access Control
- auth, wrong privilege
- privilege escalation
- purpose is to gain control, access, admin rights

#### Security Misconfiguration
- poorly managed firewall
- just update software from time to time

#### Software Supply Chain Failures
- 3rd party code or tools
- libraries, frameworks being vulnerable
- XZ case 

#### Cryptographic Failures
- sensitive data does not need to be kept and should be protected 
- middle man attack, weak encryption and TLS 

####  Injections
- sql injection, code injections
- testing the code
- simulate difference scenarios of faulty codes
- test fault tolerance of that software, quality control 
- manipulate http request
- XSS, scripts loaded into web app 

#### Insecure Design
- flaws in application architecture
- systematic bugs on a design level
- threat modeling, what type of attack might exist 

#### Authentication Failure
- 2FA, verify by the server 
- Credential stuffing, password security, session cookies exploitation

#### Insecure Deserialization
- when structured data is taken and turned into an object
- metadata is used to reconstruct the object again after transit
- man-in-the-middle attack, tempering the data
- integrity check 

#### Logging and Alerting Failure
- insufficient loggings
- logging and monitoring data can reduce impact, alert the user

#### Mishandling of Exceptional Conditions
- Secure error handling, what happens when the system crashes
- design the software in a secure way 
- logs can leak the state of the system and can be exploited

# 