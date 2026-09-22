# Forensics report
## introduction
- report is the product
- the report is to show your work, and make you rememeber why exactly you wrote a sentence
- a strong report is a strong examination 
- judge, councel, HR management, clients, peer examiners, Law enforcement, and you from the future
- if you invented a step to guide you to a right point, you need to disclose that information
- vibe coding is a big part we are in rn, you are not going to take that to court but its not a standard tool
- is it objective? if you later were asked about your opinion (evne tho likely not)
- can it answer all the question, if you can't it does not look professional
- **Reproducible, transparent, objective, complete, clear, controlled**

## Forensicss notes
**RULE OF THUMB: if its not in the notes, it did not happen, if its in, you gotta explain**
- defined as a record made at the time an action was taken
- they are primary reocrd 
- notes are disclosable, you have to provide them 
- data, timezone, location, investigator, what did you do, action you take, tools used, version of tools, what did you observe, what did you do, explain you decision making, 
- different tools version might do things differently
- notes always have to be attached to the full report
- reference the notes in your report instead of copy pasting the content

## Chain of Custody
**The Second Foundation
- UTC timezone
- must be maintained, detailed, signed 
- maintained differently in different organization, Private vs public org

## Template of a Forensic report
- Coverpage: Your information, basic information, about the case
- Executive Summary: Simple words on what was done (The Abstract)
- Scope: What objective or questions are asked, why you didnt look this look that, "oh this is what i am doing, limitations"
- Evidence Received: artifacts
- Acquisirion: methods, tools 
- Examination environment and tools: Version, workstation, validation
- Methodology: what you did, in what order, why you did it
- Findings: Facts, numbers, data, things that are traceable to evidence and notes
- Analysis: opinion on the case, what limitation were you hit with 
- Appendice: where you put logs, COC, tools report
## Examination Environment and tools
- workstation, isloation, primary tool, acuisition tool, write blocker, hashing, time settings, validation
## Methodology
- tell your reader what you did 
- judge only cares about the scope, unless your unbias opinion
- this is what you show to the technical people 
## Findings
- number your findings
- show the artifacts, metadate of it, how did you find this bullshit
- no "axiom told me" - a better way would be "located by axiom, confirmed by going to the actual fucking location of the file system view and opening that fucking file"
- explain you went to the specific location, note your souce, how did you check manually
- Timestamp, in registry, do not mix your local timestamp (Always use UTC and just bracket the local timezone)
## Conclusion
- stay objective, answer questions, cites the finding it rests on, not to add new facts
- "I could not determin who was at the keyboard"
- we only state facts we see, no assumptions
## Glossary
- explain your terms, whats artifacts, hash, NTFs, etc
## Rules for attaching a tool report
- the tools you used should be attached as a reference 
- do not let the tool write your report, avoid shit like "the tool did this for me"
- did you check it yourself, if you let the question asked by someone, it means they are doubting your findings
## Verification Methods
- how your open the item, find the file, confirm the bits and byte
- Use a second tool, if second tool can find it, then the result is reputable 
## Language rules
- past tense what for you did, present tense for what evidence is 
- first person 
- don't talk too much, use exact nouns, not using words that can be interpreted as subjective
- you can define something, introduce the tool "Axiom"
- page 39 for what to say what to not say 

## Report mistakes
- consistency issue, in Summary what period are we talking about 
- missing appendix for evidence received 
- page 4 "mantooth downloaded these files" 
- hash does not match from appendix A 
- section 8.5 timestamps
- conclusion does not answer question C