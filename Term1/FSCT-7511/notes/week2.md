= Week 2 =

## PoLP
- minimize the attack surface
- less access point
- Better performance
- Avoid accidental mistakes
- applicable to any resources


## Linux Groups
- Groups of user that have the same level of access to system resources (when individual configuration is not in place)
- Group membership can use to prevent acess to system resources
- Primary group: Main group
- Secondary groups: Other group a user belongs to
    > Example: Main group: masters, secondary groups: Jew victim card
- `id` command to see what group a user belongs to
- `/etc/passwd`, `/etc/group/`, `/etc/gshadow` -> Modify group information
- GID under 1000 are special group
    > Root: sys admin
    > adm: file access to sys montioring
    > lp, tty, mail, cdrom: OS background process to access files
    > sudo: sudo
- ACL: access control least
    > Teach proper use of permissions to all user
    > Consider allowing user to add new users to their own private groups

- `/etc/gshadow` File
    > Root level access
    > Contain group information
