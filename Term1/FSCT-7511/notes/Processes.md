Here are detailed study notes for **FSCT 7511: Cybersecurity Foundations - Process Control and System Logging**, based on the provided lecture slides.

# **Part 1: Process Control**

### **1. Concepts: Processes vs. Jobs**

- **Process:** Any program currently running on the system1.
    
- **Job:** A process that is executed specifically from the command line2.
    
- **Foreground vs. Background:**
    
    - **Foreground:** The default state. The shell is unavailable until the process finishes3.
        
    - **Background:** The process runs independently, leaving the shell available for other commands4.
        

---

### **2. Monitoring Processes**

#### **The `ps` Command**

Used to display information about active processes.

- **Basic usage:** `ps` (lists child processes of the current shell)5.
    
- **Output columns:**
    
    - `PID`: Process ID6.
        
    - `TTY`: The terminal window that started the process7.
        
    - `TIME`: CPU time used8.
        
    - `CMD`: The command that launched the process9.
        
- **Full Listing:** `ps -f` displays full information including UID (User ID), PPID (Parent Process ID), C (Execution state), and STIME (Start time)10101010.
    
- **Combination:** `ps -e | grep <name>` finds specific processes11.
    

#### **The `pgrep` Command**

A specialized command that combines `ps` and `grep` functionality12.

- **Syntax:** `pgrep <process_name>` returns the PID13.
    
- **Options:**
    
    - `-G name`: Match by group name14.
        
    - `-l`: Display process name and PID15.
        
    - `-n`: Display the most recently started process first16.
        
    - `-u name`: Match by username17.
        

#### **The `top` Command**

Displays process information updated at regular intervals (default is every 2 seconds)18.

- **Change Interval:** `top -d #` (where # is seconds)19.
    
- **Display Sections:**
    
    1. **Summary:** Uptime, task count, CPU stats, Memory stats (Physical and Virtual)20.
        
    2. **Process List:** Sorted by CPU utilization by default21.
        
- **Interactive Commands (while running):**
    
    - `h`: Help22.
        
    - `k`: Kill a process (requires PID)23.
        
    - `q`: Quit24.
        
    - `s`: Set update interval25.
        
    - `Z`/`B`: Toggle color/bold26.
        
    - `<` or `>`: Move sort column left or right27.
        

#### **System Status Commands**

- **`uptime`**: Shows how long the system has been running and the **load average**28.
    
    - Load average is relative to CPU count. On a single CPU, 1.0 = 100% utilization. On a dual-core, 1.0 = 50% utilization29.
        
- **`free`**: Displays memory statistics30.
    
    - Options: `-k` (kilobytes), `-m` (megabytes), `-g` (gigabytes), `-t` (show totals line), `-s #` (update every # seconds)31.
        

---

### **3. Managing Process Execution**

#### **Background and Foreground**

- **Start in Background:** Append `&` to the command (e.g., `xeyes &`)32.
    
- **List Jobs:** `jobs` command shows running and stopped jobs33.
    
- **Pause:** Press `Ctrl+z` to pause a foreground program34.
    
- **Resume in Background:** `bg` command35.
    
- **Resume in Foreground:** `fg` command36.
    

#### **Persistence (`nohup`)**

- **Problem:** When a parent process stops, it sends a HUP (Hangup) signal to child processes, stopping them37.
    
- **Solution:** Use `nohup <command>` to allow a child process to continue running even if the shell closes38.
    

---

### **4. Terminating Processes**

- **`kill`**: Stops a process using its PID (e.g., `kill 1234`)39.
    
- **`pkill`**: Kills processes based on name, user, or group40.
    
    - `-u <user>`: Kill processes owned by user41.
        
    - `-G <group>`: Kill processes by group42.
        
- **`killall`**: Stops _all_ processes with a specific name (e.g., `killall firefox`)43.
    
    - `-I`: Case-insensitive match44.
        
    - `-i`: Interactive (prompts before killing)45.
        
    - `-u`: Kill only for a specific user46.
        
- **`xkill`**: GUI utility. Run the command, then click on a graphical window to kill it47.
    

---

### **5. Process Priority (Niceness)**

- **Concept:** "Nice" values determine CPU priority.
    
- **Range:** `-20` (Highest priority) to `19` (Lowest priority). **Default is 0**48.
    
- **`nice`**: Sets priority when _starting_ a new process (e.g., `nice -n 5 firefox`)49.
    
    - Only `root` can assign negative (high priority) values50.
        
- **`renice`**: Changes priority of an _existing_ process51.
    
    - Regular users can only lower priority (increase the nice value)52.
        
    - `-u <user>` or `-g <group>` can bulk change priorities53.
        
- **Viewing Priority:** Use `ps -o nice,pid,cmd`54.
    

---

# **Part 2: System Logging**

### **1. Logging Daemons (`syslog`)**

- **Evolution:**
    
    - Original `syslog` (1980s)5555.
        
    - `syslog-ng` (Late 90s): Added TCP support and remote logging5656.
        
    - `rsyslog` (Mid 2000s): Modular, extendable capabilities5757.
        
- **Configuration Files:**
    
    - Main config: `/etc/syslog.conf` or `/etc/rsyslog.conf`585858.
        
    - Options config: `/etc/default/rsyslog` (Ubuntu) or `/etc/sysconfig/rsyslog` (Fedora)59.
        
- **Daemon Options (`syslogd`/`rsyslogd`):**
    
    - `-d`: Debug mode60.
        
    - `-r`: Accept logs from remote systems61.
        
    - `-x`: Disable DNS lookups62.
        
    - `-m x`: Timestamp every _x_ minutes63.
        

### **2. Log File Locations**

Standard location is `/var/log`. Common files include64:

- `/var/log/auth.log`: Authentication events.
    
- `/var/log/syslog`: General system messages.
    
- `/var/log/cron.log`: Crontab and `at` daemon entries.
    
- `/var/log/kern.log`: Kernel messages.
    
- `/var/log/mail.log`: Mail server entries.
    

### **3. Log Management (`logrotate`)**

- **Purpose:** Prevents log partitions from filling up by backing up old logs and removing the oldest ones65.
    
- **Configuration:** `/etc/logrotate.conf` and `/etc/logrotate.d/` directory66.
    
- **Automation:** Typically runs as a cron job67.
    

### **4. Systemd Journal (`journald`)**

Modern systems use the `systemd-journald` service for logging68.

#### **The `journalctl` Command**

Used to query the journal logs.

- **Options:**
    
    - `--all` or `-a`: Show full format69.
        
    - `-r`: Reverse order (newest first)70.
        
    - `-k`: Show only kernel messages71.
        
    - `--priority=<value>`: Filter by priority (e.g., `crit`, `err`, `warning`, `info`)72.
        

#### **Configuration**

- **File:** `/etc/systemd/journald.conf`73.
    
- **Key Settings:**
    
    - `Storage=`: Controls where data is stored.
        
        - `volatile`: Memory only.
            
        - `persistent`: Stored in `/var/log/journal`.
            
        - `auto`: Persistent if the directory exists74.
            
    - `Compress=`: Set to `1` (true) to compress entries before writing75.