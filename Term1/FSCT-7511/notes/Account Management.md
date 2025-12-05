## **1. Core Security Concepts**

### **Principle of Least Privilege (PoLP)**

- **Definition:** An information security concept requiring that every user, process, application, or system is granted only the minimum level of access necessary to perform its legitimate purpose1.
    
- **Key Benefits:**
    
    - Prevents unauthorized access to sensitive data2.
        
    - Creates a smaller attack surface3.
        
    - Results in better operational performance4.
        
    - Improves compliance audits5.
        
- **Application:** It is applied to files, directories, groups, and system resources6.
    

### **File Search Tools: Locate vs. Find**

- **`locate`**: Uses a pre-built database to find files. It is faster but may not find recently created files until the database is updated7777.
    
- **`find`**: Searches the actual filesystem in real-time. It is slower but always correct/up-to-date8888.
    

---

## **2. Managing Group Accounts**

Groups are used to allow special access to system resources or prevent access to them9.

### **Group Types**

- **Primary Group:** The main group a user belongs to (e.g., `maryam`).
    
- **Secondary Groups:** Additional groups the user belongs to (e.g., `developers`, `docker`)10.
    

### **User Private Groups (UPG)**

- Every user has their own private group, usually identical to their username.
    
- _Example:_ Creating user `alice` automatically creates a group `alice`11.
    

### **Group Configuration Files**

- **`/etc/passwd`**: Defines the user's _primary_ group membership using the GID1212.
    
- **`/etc/group`**: Stores group names, GIDs, and _secondary_ user memberships1313.
    
- **`/etc/gshadow`**: Stores group administrator information and group passwords. Viewable only by root14141414.
    

### **Key Group Commands**

|**Command**|**Usage**|**Example**|**Citation**|
|---|---|---|---|
|**`id`**|Displays user identity, primary GID, and secondary groups.|`id maryam`|15|
|**`groupadd`**|Creates a new group. Can specify GID with `-g`.|`groupadd -g 5000 payroll`|16|
|**`groupmod`**|Modifies a group (e.g., renaming).|`groupmod -n payables payroll`|17|
|**`groupdel`**|Deletes a group. **Warning:** Files owned by this group must be reassigned _before_ deletion, or they will be owned by a useless GID.|`groupdel payroll`|18181818|
|**`chgrp`**|Changes the group ownership of a file.|`chgrp games sample.txt`|19|
|**`usermod`**|Adds users to groups.<br><br>  <br><br>**`-G`**: Sets secondary groups (overwrites existing).<br><br>  <br><br>**`-a -G`**: Appends to secondary groups (keeps existing).|`usermod -a -G adm student`|20|
|**`gpasswd`**|Manages group administrators.<br><br>  <br><br>**`-A`**: Assign admin.<br><br>  <br><br>**`-a`**: Add user.<br><br>  <br><br>**`-d`**: Remove user.|`gpasswd -A student games`|21|

---

## **3. Managing User Accounts**

User accounts are critical for granting access, securing files, and enabling privilege escalation22.

### **User Configuration Files**

- **`/etc/passwd`**: Contains primary account data (User, UID, GID, Comment, Home, Shell). Despite the name, it does _not_ contain password data232323232323232323.
    
- **`/etc/shadow`**: Contains secure password data (hashed password, expiration, warning dates). Viewable only by root24.
    

### **Special & Network Accounts**

- **Special Groups/Users:** Usually have IDs under 1000. Examples include `root`, `adm`, `lp` (printing), `mail`, and `bind` (DNS)252525252525252525.
    
- **Network Accounts:** Provided by servers like LDAP, NIS, or Active Directory26.
    

### **Key User Commands**

|**Command**|**Usage**|**Example**|**Citation**|
|---|---|---|---|
|**`useradd`**|Creates a new user. Default is locked.|`useradd -u 1005 timmy`|27|
|**`passwd`**|Sets or changes the password for an account.|`passwd timmy`|28|
|**`usermod`**|Modifies account properties (expiration `-E`, home dir `-d`, shell `-s`).|`usermod -e 2025-12-31 bob`|29|
|**`userdel`**|Deletes a user.<br><br>  <br><br>**`-r`**: Deletes the home directory and mail spool as well.|`userdel -r steve`|30|

### **Restricted Shell (`rbash`)**

A restricted shell limits what a user can do. It is assigned via useradd -s /bin/rbash31.

Restrictions include:

- Cannot use `cd` to change directories.
    
- Cannot change environment variables like `PATH` or `SHELL`.
    
- Cannot run commands containing a `/` (slash).
    
- Cannot redirect output to a file32.
    

---

## **4. Privilege Escalation (`su` vs `sudo`)**

### **`su` (Switch User)**

- Switches to another user account entirely.
    
- **Command:** `su - student` (The `-` ensures the new user's initialization files/environment are loaded)33.
    
- **Requirement:** You must be root _or_ know the target account's password34.
    

### **`sudo` (SuperUser Do)**

- Executes a single task as another user (usually root) without switching shells.
    
- **Command:** `sudo apt-get install joe`35.
    
- **Configuration:** Managed in `/etc/sudoers`.
    
- **Best Practice:** Never edit `/etc/sudoers` directly; use the `visudo` command36.
    

---

## **5. Pluggable Authentication Modules (PAM)**

PAM is a set of libraries called by authentication-based software to verify users without changing application code373737.

### **PAM Features**

- Limit access by time/date38.
    
- Limit system resource utilization39.
    
- Create additional logs for login events40.
    
- Configuration is typically found in `/etc/pam.d/` (one file per application)41.
    

### **PAM Management Categories**

PAM rules are organized into four facility categories42:

1. **`account`**: Verifies if the account is valid, enabled, or allowed to log in at this time.
    
2. **`auth`**: Authenticates the user (verifies they are who they claim to be, usually via password).
    
3. **`password`**: Updates authentication tokens (changing passwords).
    
4. **`session`**: Performs setup/teardown tasks (mounting directories, logging) before/after service.
    

### **PAM Control Flags**

These flags dictate how the system reacts to the success or failure of a module43:

- **`required`**: Module must succeed. If it fails, the system continues checking others but will ultimately return a failure.
    
- **`requisite`**: Module must succeed. If it fails, the process stops immediately and returns a failure.
    
- **`sufficient`**: If this module succeeds, the process stops immediately and returns success (unless a previous `required` module failed).
    
- **`optional`**: Success/failure is ignored unless it is the only module defined.
    

### **Common Modules**

- `pam_unix`: Standard Unix authentication44.
    
- `pam_tally`: Counts login attempts (for lockouts)45.
    
- `pam_time`: Enforces time-based access control46.
    
- `pam_mkhomedir`: Creates a home directory on login if one doesn't exist47.
    

---

### **Review Questions (From Slides)**

1. **Modify PATH:** To include `/opt`, modify the `PATH` variable48.
    
2. **Groups:** Which command creates a group `finance` with GID `5020`?
    
    - _Answer:_ `groupadd -g 5020 finance`49.
        
3. **User Mod:** How to add `alice` to `developers` without removing current groups?
    
    - _Answer:_ `usermod -a -G developers alice`50.
        
4. **PAM:** What is the role of PAM?
    
    - _Answer:_ It manages user authentication and authorization through modular components51.
        

**Next Step:** Would you like me to generate a set of practice quiz questions based on the PAM control flags and user management commands?