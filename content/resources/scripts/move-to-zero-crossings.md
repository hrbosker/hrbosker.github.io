---
title: "Praat: Move to zero-crossings"
type: book
weight: 40
#date: '2021-01-01'
---

This Praat script automatically moves all boundaries in a given tier in a TextGrid file to zero-crossings, which is important for extracting sound intervals. Specifically, it adds a tier 'to0x' at the top of the TextGrid that is identical to a given input tier, except that all boundaries are at zero-crossings.

> You can also [download the script](../move-to-zero-crossings.praat) as a .praat file.

```
################################################################################
### Hans Rutger Bosker, Radboud University
### HansRutger.Bosker@ru.nl
### Date: 22 July 2022, run in Praat 6.2.12 on Windows 10
### License: CC BY-NC 4.0
################################################################################

	###>> This script takes a single .wav and matching .TextGrid file as input
	###>>   and moves all boundaries in one particular tier to zero-crossings.

	###>>   Specifically, it *adds* a new 'to0x' tier at the top of the TextGrid
	###>>   that is identical to a given tier except that all boundaries are
	###>>   at zero-crossings. The old TextGrid is then overwritten with the
	###>>   new extended TextGrid, but no information is lost (only added).

	###>>   This script works best if the script also subtracts the mean from
	###>>   the audio signal, and overwrites the original audio:
	###>>	'method' option 1 (default).

	###>>	If you need to move the boundaries for more than one TextGrid file,
	###>>	you can merge this script with 'batch-processing.praat',
	###>>	see: https://hrbosker.github.io/resources/scripts/batch-processing/


################################################################################
### Form to enter variables
################################################################################
beginPause: "Enter settings"
	comment: "Provide the directory of the sound and TextGrid file (no slash at end of string)"
	text: "directory", "C:/Users/hanbos/mysounds"
	comment: "Provide the name of the sound file"
	comment: "(should be identical to TextGrid name)"
	comment: "NOTE: do NOT include any extension (no .wav)"
	text: "filename", "syll1"
	comment: "Provide the interval tier number (typically 1)"
	real: "tierNumber", 1
	choice: "method", 1
	   option: "Subtract mean and overwrite audio file"
	   option: "Do not subtract mean"
clicked = endPause ("Cancel", "OK", 2)



################################################################################
### Before we start, let's check whether you've entered sensible
### input for the variables above...
################################################################################

### Let's check if the directory exists.
### This script will throw an error if the directory doesn't exist
### (i.e., it won't write to a mysterious temp directory).

### First check whether the input directory ends in a backslash (if so, removed)

if right$(directory$,1)="/"
	directory$ = left$(directory$,length(directory$)-1)
elsif right$(directory$,1)="\"
	directory$ = left$(directory$,length(directory$)-1)
endif

### Then create a temporary txt file in the folder
### and try to write it to the input folder.

### NOTE: The "nocheck" below asks Praat not to complain if the folder
### does *not* exist. We'll manually check whether the saving of this
### temp txt file has succeeded or not further down below.

temp_filename$ = directory$ + "/" + "my_temporary_Praat_file.txt"
nocheck writeFileLine: temp_filename$, "This is just to check if the directory exists"

### Can the file be found?

file_exists_yesno = fileReadable(temp_filename$)

if file_exists_yesno = 1
	# if you *could* read that temp txt file,
	# this confirms that the directory is valid.
	# Then you can delete it.
	deleteFile: temp_filename$

	## Let's also check whether the specified wav and TextGrid filenames exist
	## inside this particular directory.

	filepath$ = directory$ + "/" + filename$ + ".wav"
	wavFileExists = fileReadable(filepath$)

	if wavFileExists = 0
		# if the wav file does not exist
		printline Could not find 'filename$'.wav in the folder 'directory$'
		exit Could not find 'filename$'.wav in the folder 'directory$'. Check spelling.
	endif

	filepath$ = directory$ + "/" + filename$ + ".TextGrid"
	tgFileExists = fileReadable(filepath$)

	if tgFileExists = 0
		# if the TextGrid file does not exist
		printline Could not find 'filename$'.TextGrid in the folder 'directory$'
		exit Could not find 'filename$'.TextGrid in the folder 'directory$'. Check spelling.
	endif
else
	# if the temporary file wasn't readable, that means that the directory wasn't valid. 
	printline The folder 'directory$' was not found
	exit Your directory doesn't exist. Check spelling. The directory must *already* exist.
endif



################################################################################
################################################################################
#################################    SCRIPT    #################################
################################################################################
################################################################################

Read from file... 'directory$'\'filename$'.wav
if method = 1
	Subtract mean
	Write to WAV file... 'directory$'\'filename$'.wav
endif
Read from file... 'directory$'\'filename$'.TextGrid
nInts = Get number of intervals... 'tierNumber'
Insert interval tier... 1 to0x

for i to ('nInts'-1)
	select TextGrid 'filename$'
	intEnd = Get end point... ('tierNumber'+1) 'i'
	intLab$ = Get label of interval... ('tierNumber'+1) 'i'
	select Sound 'filename$'
	zxEnd = Get nearest zero crossing... 1 'intEnd'
	select TextGrid 'filename$'
	Insert boundary... 1 zxEnd
	Set interval text... 1 'i' 'intLab$'
endfor
intLab$ = Get label of interval... ('tierNumber'+1) 'nInts'
Set interval text... 1 'nInts' 'intLab$'

Write to text file... 'directory$'\'filename$'.TextGrid
Remove
select Sound 'filename$'
Remove

################################################################################
# End of script
################################################################################

```
