# Filters
- filter drop down or the filter manager 
- filter Bookmark > conditions? > look at what the conditions are 
- evidence tab > additional analysis > flag dupe files, ftk hash everything and compare and flag dupe
- how to check dupe on multiple images
	- add new column > all features > duplicated files > swap to the column you made
	- filter manager > exclude duple files 
- how to exclude email files
	- ftk is not the best tool to process email files
	- we export the archives to other tools 
	- go filter > exclude email file and attachment 
- make sure "match all" is selected

# Carving 
-  evidence tab > additional analysis > miscellaneous tab > carving options
- you can make custom carving from that as well
## manual carving 
- Index search > terms > search your strings
- click search now > options > apply filter 
- click on hex > ctrl + f > search for text > find next (in unallocated space)
- right click on content field > save selection as carved file > add bookmark option and add to case > bookmark creation 
- overview > file status > Data carved files

# Compound Files
- evidence tab > additional analysis > Compound file expansion options > expand compound files
- when previewing the file, exif file created by ftk for that jpg file, contains metadata of that jpg file 

# Artifacts
## Prefetch files
- windows XP introduced this 
- when anything launches, windows monitor what is being done on the system for ten seconds 
- data is recorded in a file stored in the prefetch directory
- basically a cache database
- holds up to 128 files, window periodically removes them
- finding a prefetch file can be important if that file was launch
- the data contained within it is important 
- name location time of the executable run
- list of files read within ten seconds of launching the app
- times the app launched
- cc-cleaner wiping unallocated partition > prefetch files recorded this > suspicious 
- c:/windows/prefetch, file extension of .pf
- dependency are dependent application of an application that is cached and preloaded 

## Shortcuts
- for user experience 
- 4 ways shortcut is created 
	- when installing a software
	- when opening a file or volume using file explorer
	- microsoft office file
	- manually create shortcut 
- usually user do not delete shortcuts, making them valuable 
- user > 'user' > Roaming > microsoft > windows > recent 
- you can find even removable drives shortcuts 

# Labels
- right click on the file > labels 
- you can share labels with your friends and family
- you can import labels (theme or existing evidence)
- you can mark multiple labels for the same file 
- you can exclude include them as well 
- you can include labels in reports 
- they are temporary placeholders unlike bookmarks 

# Email
- email status: attachments, details of emails
- email archives: any container that holds emails
- email by date: need any more explanation?
- email address: by domain name, sender, etc
- email: message types 
- you can right click on the email and select where to view the email (location of the email) (bottom option)(explore)

# Bookmark
- you can only remove an item's bookmark under the bookmark's tab 
- bookmark information, comments, etc
- you can bookmark partially of a file 
- if you want to move an item to a different bookmark, just right click and add to another bookmark, and remove it from the old bookmark 

# Report
 - SCP - Solicitor-client privilege
 - every client communications with their lawyer is private, no outsiders should get that information
 - often federal investigation we will be searching for things with index, privilege information, bookmark but not include in report 
 - other details refer back to week 3 notes 

# System Information
- manage evidence
- you can take screenshot in ftk (3rd button next toe filter manager)
-  the report will shot the screenshot as well
- everything in ftk is labelled with an id 
