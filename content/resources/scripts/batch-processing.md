---
title: Batch processing
type: book
weight: 30
#date: '2021-01-01'
---

This script is an in-house template / starting point for batch processing multiple files. Adapt it to your own needs to apply a particular function to multiple files or multiple time intervals within each file.

In its current form, the script reads each .wav file *plus* accompanying TextGrid in a given input directory, extracts all non-empty intervals individually, and then loops over those to find the ones labelled "vowel". It then allows the user to apply a particular function to those intervals (such as `Scale intensity: 65`), after which it concatenates the individual intervals back together, and saves the output in an output directory.

**NOTE:** In its current form, the script does not run any function on its input. It really only serves as a starting point, including snippets of code we regularly use and now do not need to look up every time we want to do batch processing in Praat.

> You can also [download the script](../batch-processing.praat) as a .praat file.

```
################################################################################
### Hans Rutger Bosker, Radboud University
### HansRutger.Bosker@ru.nl
### Date: 6 July 2022, run in Praat 6.2.12 on Windows 10
### License: CC BY-NC 4.0
################################################################################


	###>> This script is a starting point for batch processing a set of files.
	###>>	The script basically reads files in an input directory and runs a
	###>>	a to-be-defined function [see 'Perform your function here' below]
	###>>	and writes the output to an output directory . This saves me having
	###>>	to look up how to create a file list, how to loop over files, etc.
	###>>	
	###>> Since this was basically intended for in-house use, I've added in bits
	###>>	and pieces that I find useful to have ready-to-go, such as:
	###>>	'beginPause' for manually specifying variables.

################################################################################
### Variables you will definitely need to customize:
################################################################################

### Where can the files be found?

dir_in$ = "C:\Users\hanbos\mysounds"

### Where should the output files be saved?

dir_out$ = "C:\Users\hanbos\mysounds\output"





################################################################################
### Let's check whether the directories specified above exist...
################################################################################

### Let's check if the input directory exists.
### This script will throw an error if the directory doesn't exist
### (i.e., it won't write to a mysterious temp directory).

### First check whether the input directory ends in a backslash (if so, removed)

if right$(dir_in$,1)="/"
	dir_in$ = left$(dir_in$,length(dir_in$)-1)
elsif right$(dir_in$,1)="\"
	dir_in$ = left$(dir_in$,length(dir_in$)-1)
endif

### Then create a temporary txt file in the folder
### and try to write it to the input folder.

### NOTE: The "nocheck" below asks Praat not to complain if the folder
### does *not* exist. We'll manually check whether the saving of this
### temp txt file has succeeded or not further down below.

temp_filename$ = dir_in$ + "/" + "my_temporary_Praat_file.txt"
nocheck writeFileLine: temp_filename$, "This is just to check if the directory exists"

### Can the file be found?

file_exists_yesno = fileReadable(temp_filename$)

if file_exists_yesno = 1
	# if you *could* read that temp txt file,
	# this confirms that the directory is valid.
	# Then you can delete it.
	deleteFile: temp_filename$
else
	# if that file wasn't readable, that means that the directory wasn't valid. 
	printline The folder 'dir_in$' was not found
	exit Your input directory doesn't exist. Check spelling. The directory must *already* exist.
endif

## Now re-do this for the output directory:

if right$(dir_out$,1)="/"
	dir_out$ = left$(dir_out$,length(dir_out$)-1)
elsif right$(dir_out$,1)="\"
	dir_out$ = left$(dir_out$,length(dir_out$)-1)
endif

### Then create a temporary txt file in the folder
### and try to write it to the input folder.

### NOTE: The "nocheck" below asks Praat not to complain if the folder
### does *not* exist. We'll manually check whether the saving of this
### temp txt file has succeeded or not further down below.

temp_filename$ = dir_out$ + "/" + "my_temporary_Praat_file.txt"
nocheck writeFileLine: temp_filename$, "This is just to check if the directory exists"

### Can the file be found?

file_exists_yesno = fileReadable(temp_filename$)

if file_exists_yesno = 1
	# if you *could* read that temp txt file,
	# this confirms that the directory is valid.
	# Then you can delete it.
	deleteFile: temp_filename$
else
	# if that file wasn't readable, that means that the directory wasn't valid. 
	printline The folder 'dir_out$' was not found
	exit Your output directory doesn't exist. Check spelling. The directory must *already* exist.
endif





###########################################################################
##	FORM TO MANUALLY SPECIFY VARIABLES
###########################################################################
#beginPause: "Enter settings"
#	comment: "Provide instructions here"
#	real: "minPitch", 70
#	real: "maxPitch", 250
#	choice: "method", 1
#	   option: "Flip F0 contour"
#	   option: "Expand/Contract F0 contour"
#	   option: "Flatten F0 contour"
#clicked = endPause ("Cancel", "OK", 2)
###########################################################################
###########################################################################





## Let's create a list of all the files in the input directory.

Create Strings as file list: "list_of_files", "'dir_in$'/*.wav"

nfiles = Get number of strings
if nfiles = 0
	exit The directory 'dir_in$' does not contain any .wav files.
endif

## Now we'll loop through the list...

for i from 1 to 'nfiles'
	select Strings list_of_files
	
	fileplusext$ = Get string... 'i'
	extposition = index(fileplusext$, ".wav")
	name$ = left$(fileplusext$, ('extposition'-1))

	Read from file... 'dir_in$'\'name$'.wav
	Read from file... 'dir_in$'\'name$'.TextGrid
	plus Sound 'name$'
	Extract non-empty intervals... 1 no
	
	nSelected = numberOfSelected()

	## Assign an object number to each object (e.g., 1-5),
	## and save the id numbers of each object to an array.

	for thisObject to nSelected
		objectArray ['thisObject'] = selected('thisObject')
	endfor

	for j to nSelected
		curr_objectId = objectArray ['j']
		select 'curr_objectId'
		curr_objectName$ = selected$("Sound")
		
		if curr_objectName$ = "vowel"

			########################################################################
			# Perform your function here!
			#	Example: Scale intensity... 65
			########################################################################

		endif
	endfor

	for j from 1 to nSelected
		curr_objectId = objectArray ['j']
		if j = 1
			select 'curr_objectId'
		else
			plus 'curr_objectId'
		endif
	endfor
	Concatenate recoverably

	select Sound chain
	Write to WAV file... 'dir_out$'\'name$'_manipulated.wav
	select TextGrid chain
	Write to text file... 'dir_out$'\'name$'_manipulated.TextGrid

	## Cleaning up...
	for j from 1 to nSelected
		curr_objectId = objectArray ['j']
		if j = 1
			select 'curr_objectId'
		else
			plus 'curr_objectId'
		endif
	endfor
	plus Sound chain
	plus TextGrid chain
	plus Sound 'name$'
	plus TextGrid 'name$'
	Remove

endfor

select Strings list_of_files
Remove

################################################################################
# End of script
################################################################################

```
