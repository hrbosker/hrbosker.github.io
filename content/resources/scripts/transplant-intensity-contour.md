---
title: "Praat: Transplant intensity contour"
type: book
weight: 80
#date: '2021-01-01'
---

This Praat script takes pairs of items (e.g., bet and bit) from a directory and transplants the intensity contour of word2 onto word1. It does so by first scaling the duration of word2 to be identical to that of word1, and then transplanting the duration-scaled intensity contour onto word1. This works best if all individual speech segments in the recordings are of similar duration in the two sounds.

> You can also [download the script](../transplant-intensity-contour.praat) as a .praat file.

```
################################################################################
### Hans Rutger Bosker, Radboud University
### HansRutger.Bosker@donders.ru.nl
### Date: 20 July 2023, run in Praat 6.3.08 on Windows 10
### License: CC BY-NC 4.0
################################################################################


	###>> This script takes pairs of items (e.g., bet and bit) from a directory
	###>>	and transplants the intensity contour of word2 onto word1.
	###>>	It does so by first scaling the duration of word2 to be identical to
	###>>	that of word1, and then transplanting the duration-scaled intensity
	###>>	contour onto word1. This works best if all individual speech segments
	###>>	in the recordings are of similar duration in the two sounds.
	
	###>> IMPORTANT: Please provide a list of word pairs in a .txt file in the
	###>>	input directory. This file should contain two tab-separated columns
	###>>	with the labels "word1" and "word2".For example:
	
	###>>	word1	word2
	###>>	bet	bit
	###>>	get	git
	###>>	set	sit

	
################################################################################
### Variables you will definitely need to customize:
################################################################################

### Where can the files be found?

dir_in$ = "C:\Users\hanbos\Desktop\mysounds"

### Where should the output files be saved?

dir_out$ = "C:\Users\hanbos\Desktop\mysounds\output"

### What is the name of the .txt file containing the list of word pairs?
### 	NOTE: Do **NOT** include the .txt extension; just the name!

table_name$ = "list_of_pairs"

### Provide the min and max pitch settings.
###		For female talker: 100 - 400
###		For male talker: 75 - 300
minpitch = 100
maxpitch = 400




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
	# Then you can delete that temp txt file.
	deleteFile: temp_filename$
else
	# if that file wasn't readable, that means that the directory wasn't valid. 
	printline The folder 'dir_out$' was not found
	exit Your output directory doesn't exist. Check spelling. The directory must *already* exist.
endif





################################################################################
################################################################################
#################################    SCRIPT    #################################
################################################################################
################################################################################

Read from file... 'dir_in$'\'table_name$'.txt
nItems = Get number of rows

for ItemCnt from 1 to nItems
	#######################################
	## Read and measure acoustics of word1
	#######################################

	select Table 'table_name$'
	word1$ = Get value... 'ItemCnt' word1
	word2$ = Get value... 'ItemCnt' word2
	
	Read from file... 'dir_in$'\'word1$'.wav
	Rename... word1
	sampFreq_1 = Get sampling frequency
	dur_1 = Get total duration
	int_1 = Get intensity (dB)
	
	
	
	#######################################
	## Read and measure acoustics of word2
	#######################################

	Read from file... 'dir_in$'\'word2$'.wav
	Rename... word2
	sampFreq_2 = Get sampling frequency
	dur_2 = Get total duration
	int_2 = Get intensity (dB)
	
	
	
	#######################################
	## Scale the duration of word2 to the word1 duration
	#######################################

	select Sound word2
	durScaleFactor = (dur_1/dur_2)
	Lengthen (overlap-add)... 'minpitch' 'maxpitch' 'durScaleFactor'
	Rename... word2_durscaled
	To Intensity... 100 0 no
	Down to IntensityTier

	#######################################
	## Transplant the intensity contour of word2_durscaled onto word1
	#######################################

	select Sound word1
	Copy... word1_manip

	To Intensity... 100 0 no
	Down to IntensityTier
	Formula... self*-1
	plus Sound word1_manip
	Multiply... yes
	plus IntensityTier word2_durscaled
	Multiply... yes
	Scale intensity... int_1

	#######################################
	## Save the final result sound
	#######################################
	Save as WAV file: "'dir_out$'\'word1$'_manip.wav"

	select all
	minus Table 'table_name$'
	Remove
endfor



################################################################################
# End of script
################################################################################

```
