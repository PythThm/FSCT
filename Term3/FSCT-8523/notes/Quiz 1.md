1. **Describe, in detail, 5 different forensic artifacts you learned about during this course, and outline the scenarios where those artifacts would benefit the investigation.**

	The 5 most important forensic artifacts are Prefetch files, Windows shortcuts, SAM hive, Windows Registry artifacts and USB device conection records. There artifacts help investifators reconstruct the user's activity and determine what actions were done by the user, identify files that has been accessed. 

2. Prefetch files
Prefetch files are Windows artifacts made to improve application launch performance by montioring the files an application reads during the first 10 seconds of execution and record information in a Prefetch file from the files that were read. Prefetch files also can reveal the name and location of an executable application, the files it accessed during startup, number of times it was ran, timestamp of its' last run.

If during an investigation we are examining a computer that was suspected of running malicious programs, Prefetch files can be used as evidence to determin if any malicious programs were ever executed on the computer. An investigator can find eveidence supporting a conclusion by examining other details from a prefetch file like run counter, last execution time, where it is executed and related files. Ultimately to determine if this application was launched or not.

2. Windows Shortcuts
Windows shortcuts are created for reasons like software installing, creating shortcuts manually, etc. Windows also automatically creates shortcuts in a user's recent directory when files or folders are accessed. This is an valuiable artifact as the contain datas like target name and path, file size, timestamps, volume name, serial numbers or informatiuon identifying the computer it was accessed.

It could be beneficial when examining a computer to show a files that was opened even after it has been deleted, shortcuts are rarely cleaned up and outlive the target files. Shortcut files might even point to documents or to files stored on an external drive, The data from it Window Shortcut can help determine which files were accesse and volumes involved.

3. USB device conection records (device artifacts)
The registry keeps a record of external storage devices that were connect to the computer, and each USB storage device has a built-in firmaware serial number which can then be identified no matter how it is formatted.

USB device artifacts can help identifying data theft or insider threats within an organization, amthcing the serial number of a suspect's USB drive to the registry to prove that a specific device was connected to the computer. This can also potentially points to other artifacts such as LNK files that references the same drive 

4.  SAM hive and Recycle Bin
The SAME hive holds user account management data that lives in system32\config, it records each account's SID and RID, each logon count, last logon time, last password change time, password requiredw flag, password hints, password hash and whether the account is online or not for newer Windows Systems. Windows also manages a recycle bin for each user, recycel bins contains folders named using the user's RID, by relating the RID with records in SAM hive, a specific windows user account can be identified. 

This can help in investigation when looking in a computer where confidential company documents have been deleted, the recycle bin contain evidence of deleted files, but investifator may need to evaluate which user account is linked to the deleted docuemnts. Checking the RID with records in SAM hive will provide a strong evidence linking the recycle bin data to the account. Useful when computers are shared by multiple user, to then find the deleted-file evidence with other artifacts to understand previous user activities done on the machine.

5. Web artifacats Browser histories, visits, URLs
Web artifacts that contains important data of where the user visited, web artifacts records websites that was visited, time of visit, times visited, typed count, visit source, transition types (like bookmarks, redirect, etc) or typed URLs to see if the user manually typed it in. 

This can help with identifying the intent, if a user typed out URL, it can highly suggest a deliberate visit to the website. Or to rebuild a timeline, user visits giving a precise swquence of navigation of redirects and click trails. 

Tracing malware or file arrival can be done as download records are stored in the same database. Web History combines well with cookies and cache to show even more information about a user's activity on a website.

2. **Describe the various browsing data repositories as taught in this course and provide examples of data to be found in them, their usage, and location.**

3. Browsing history and visits
Web History contians unique URL, page title, visit time, counts of visit and typed count. Web Visits includes the URL, title, visit time, transition type and visit source. It is used to give an overview of sites visited, how often they are visited and when was the last time accessed. It gives a precise timeline, navigation timeline, redirects and click trails. 

Location: 
Chrome: History (as SQLite), Web history from urls table and web visit from visits table (Path: Users\username\AppData\Local\Google\Chrome\User Data\Default\)
Edge: Similar to chrome, stored in a SQlite db as History (Path: Users\username\AppData\Local\Microsoft\Edge\User Data\Default\History)
FIrefox: Stored in places.sqlite (Path: Users\username\AppData\Roaming\Mozilla\Firefox\Profiles\xxxxxxxx.default\)

2. Typed URLs 
On chrome it holds a count, on firefox it holds a yes/kno flag to show the URL was typed or pasted into the address bar, even typing part of the URL counts. This show the user intentionally typed in the address, not accidentally clicking on a website

Location:
Insidte the same database for History (same place History in Chrome and places.sqlite for Firefox) AXIOM shows it in the web history and web visits category.

3. Web Cache
It is the code and resrouces downloaded to render webpages, such as scripte and images, Chromes cache contains the URL, first and last visited of the wbesite, last sync, file type, content size, and the cached content. Firefox's cache contains the URL, created time, MIME type, size and content cached. AXIOM can render the cached page or file to show what the user was shown.

Location:
Chrome: 
1. Users\username\AppData\Local\Google\Chrome\UserData\Default\Cache\
2. Users\username\AppData\Local\Google\Chrome\UserData\Default\GPUCache\
3. Users\username\AppData\Local\Google\Chrome\UserData\Default\MediaCache

Firefox: Users\username\AppData\Roaming\Mozilla\Firefox\Profiles\xxxxxxxx.default\cache2\entries 

Edge: 
1.Users\username\AppData\Local\Microsoft\Edge\User 
2.Data\Default\Users\username\AppData\Local\Microsoft\Edge\UserData\Default\GPUCach
3.Users\username\AppData\Local\Microsoft\Edge\UserData\Default\MediaCache\

4. Cookies
Cookies holds the Session IDs, preferences, login tokens, tracking info, visit timestamps and analytics IDs. Types are session, persisten and third party. Firefox paresed fields are host, name, value, created, accessed, expiry and path. It is used to build a user activity timeline, showing site visitation even after history is deleted, identifying users through login tokens, reconstructing sessions, showing intent of frequently visited websites and attribution through IP addresses or device fingerprints

Location:
Chrome: Users\username\AppData\Local\ Google\Chrome\UserData\Default\ (Stored in an SQLite database named cookies)
Firefox: Users\username\AppData\Roaming\Mozilla\Firefox\Profiles\xxxxxxxx.default\ (Stored in SQLite database named cookies.sqlite)
Edge: Users\username\AppData\Local\Microsoft\Windows\Edge\UserData\Default\Network

5. Downloads
The data hold from downloads are filename, sourced URL for the downloaded content, saved to path and state, start and end time of the download, bytes downloaded and file size, whether if it is opened by a user or not (In Chrome and Edge), Temporary path and referrer (In Firefox). It is to show what was downloaded, from where, when, where it was saved and whether the download ever completed or opened.

Location:
Chrome: Users\username\AppData\Local\Google\Chrome\UserData\Default\
Firefox: Users\username\AppData\Roaming\Mozilla\Firefox\Profiles\xxxxxxxx.default\ (Stored in SQLite database called places.sqlite)
Edge: \Users\username\AppData\Local\Microsoft\Edge\User Data\Default\History (Stored in .sqlite database names History)

6. Bookmarks and favourites
They hold a plain-text files named bookmarks in chrome, with shortcuts in a SQLite databaase in the same folder. In Firefox it stores the URL, added and modifed times, title and type. In Edge it holds the URL, added time, name, parent folder and type. For IE favourites it holds the name, URL, Modified time, user, root location, folder structure, and URL icon. This shows what the user wanted to access to frequently.

Location:
Chrome: Users\username\AppData\Local\ Google\Chrome\UserData\Default\
Firefox: Users\username\AppData\Roaming\Mozilla\Firefox\Profiles\xxxxxxxx.default\ (Stored in SQLite database as places.sqlite)
Edge: \Users\username\AppData\Local\Microsoft\Edge\UserData\Default\bookmarks (Stored as a .json file)
IE: \Users\username\Favorites (Favourite)

7. Autofill and form history
This golds the  ame, value, count, date created nad last used. The created date is the first use only, so you can tell when smething was first autoflled nad how many times it was autofilled in total. In Chrome, the data contains the name, email, phone, company, full addresses and date modified as Autofill Profiles. Firefox Form hisotry contains data like field name, value, first and last used, time used and ID. It reveals personal details and what the user entered into web forms.

Location:
Chrome: Users\username\AppData\ Local\Google\Chrome\User Data\Default\ (Stored in SQLite database named Web Data)
Firefox: Users\username\AppData\Roaming\Mozilla\Firefox\Profiles\xxxxxxxx.default\ (Stored in SQLite database called formhistory.sqlite in table named moz_formhistory)
Edge: \Users\username\AppData\Local\Microsoft\Edge\UserData\Default (Stored in a sqlite file named web data)

8. Chrome logins
It contains information when the user logs into a site using google chrome, identifies the sites the user logged into and which usernames were used. Contains the login URL, username, encrypted password and created time.

Location:
Users\AppData\Local\Google\Chrome\User Data\Default\Login Data

9. Chrome Top sites
It shows the sites the user visits most, which are deisplayed as cons on the browser's homepage, contains information like the URL, title, last updated time, the thumbnail of the website and rank based on freqeuncy of the site being visited. 

Location:
Users\AppData\Local\Google\Chrome\User Data\Default\Top Sites 

10. Search data 
 It holds the search terms, in chrome it holds the Chrome keyword search terms category, name column show the query header as "q=". Firefox stores earch searches into a built-in search box in formhistory.sqlite using field name searchbar-history. This could be used for understanding what the user was looking for, as a cross referencing with browing hisory and parsed search queries to find the srouce of a search. 

Location:
Chrome: Users\AppData\Local\Google\Chrome\User Data\Default
Firefox: Users\AppData\Roaming\Mozilla\Firefox\Profiles\xxxxxxxx.default\ 