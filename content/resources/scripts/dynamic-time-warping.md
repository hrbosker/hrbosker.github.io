---
title: "Praat: Dynamic Time Warping"
type: book
weight: 90
#date: '2021-01-01'
---

This Praat script takes pairs of items (e.g., bet and bit) from a directory and matches the duration of individual speech sounds in word1 to the duration of individual speech sounds in word2 (...a kind of simplistic Dynamic Time Warping).

In order for this script to work, you'll need to have a TextGrid for each individual .wav file that contains segmentations of each individual speech sound. Moreover, the TextGrids for the two members of a pair will need to have the same number of intervals segmented.

Note that it helps if the intervals in the TextGrids are segmented in a relatively fine-grained manner. For instance, segmenting pauses, stop closures, stop bursts, etc. as separate intervals will make the output sound more natural. Also note that the duration scaling is linear: if interval1 is 200 ms in word1 but 250 ms in word2, then the duration of interval1 is expanded by a factor of 1.25.

> You can also [download the script](../dynamic-time-warping.praat) as a .praat file.

```
################################################################################
### Hans Rutger Bosker, Radboud University
### HansRutger.Bosker@donders.ru.nl
### Date: 20 July 2023, run in Praat 6.3.08 on Windows 10
### License: CC BY-NC 4.0
################################################################################


	###>> This script takes pairs of items (e.g., bet and bit) from a directory
	###>>	and matches the duration of individual speech sounds in word1
	###>>	to the duration of individual speech sounds in word2.
	
	###>> IMPORTANT: Please provide a list of word pairs in a .txt file in the
	###>>	input directory. This file should contain two tab-separated columns
	###>>	with the labels "word1" and "word2".For example:
	
	###>>	word1	word2
	###>>	bet	bit
	###>>	get	git
	###>>	set	sit

	###>> IMPORTANT: Each sound file should have an accompanying TextGrid with
	###>>	one interval tier. This tier should contain segmentations for each
	###>>	individual speech sound. It's best to segment as many sound segments
	###>>	as possible. For instance, for stop consonants, segmenting the closure
	###>>	separately from the burst avoids misaligned output.
	###>>	The TextGrids for the two members of a word pair should contain an
	###>>	identical number of (matching) intervals.

	
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

## Let's clear the Info window so we can print fresh new log data of our stimuli.
## This log keeps track of the individual word durations and interval durations.
clearinfo
echo item	word1_dur	word2_dur	interval_nr	interval_dur_1	interval_dur_2	interval_dur_dtw	scaleFactor	word_dtw_dur



Read from file... 'dir_in$'\'table_name$'.txt
nItems = Get number of rows

for ItemCnt from 1 to nItems
	select Table 'table_name$'
	word1$ = Get value... 'ItemCnt' word1
	word2$ = Get value... 'ItemCnt' word2
	
	Read from file... 'dir_in$'\'word1$'.TextGrid
	Rename... word1
	word1_nInts = Get number of intervals... 1
	Read from file... 'dir_in$'\'word1$'.wav
	Rename... word1
	word1_dur = Get total duration
	word1_int = Get intensity (dB)
	
	Read from file... 'dir_in$'\'word2$'.TextGrid
	Rename... word2
	word2_nInts = Get number of intervals... 1
	Read from file... 'dir_in$'\'word2$'.wav
	Rename... word2
	word2_dur = Get total duration
	word2_int = Get intensity (dB)

	
	## Check if the number of intervals in the two TextGrids match
	if word1_nInts <> word2_nInts
		# if that file wasn't readable, that means that the directory wasn't valid. 
		printline 'word1$' has 'word1_nInts' intervals but 'word2$' has 'word2_nInts' intervals.
		exit The number of intervals in the two input TextGrids do not match. Adjust the TextGrids.
	endif


	for thisInt to word1_nInts
		select TextGrid word1
		thisStart = Get start time of interval... 1 'thisInt'
		thisEnd = Get end time of interval... 1 'thisInt'
		word1_thisInt_startArray ['thisInt'] = thisStart
		word1_thisInt_endArray ['thisInt'] = thisEnd
		thisDur = thisEnd - thisStart
		word1_thisInt_durArray ['thisInt'] = thisDur

		select TextGrid word2
		thisStart = Get start time of interval... 1 'thisInt'
		thisEnd = Get end time of interval... 1 'thisInt'
		word2_thisInt_startArray ['thisInt'] = thisStart
		word2_thisInt_endArray ['thisInt'] = thisEnd
		thisDur = thisEnd - thisStart
		word2_thisInt_durArray ['thisInt'] = thisDur
	endfor


	select Sound word1
	To Manipulation... 0.01 'minpitch' 'maxpitch'
	Extract duration tier
	for thisIntNumber to word1_nInts
		start_of_1 = word1_thisInt_startArray ['thisIntNumber']
		end_of_1 = word1_thisInt_endArray ['thisIntNumber']
		dur_of_1 = word1_thisInt_durArray ['thisIntNumber']
		dur_of_2 = word2_thisInt_durArray ['thisIntNumber']
		scaledDur = dur_of_2
		word1_thisInt_scaledDurArray ['thisIntNumber'] = scaledDur
		durScaleFactor = scaledDur/dur_of_1
		word1_thisInt_scaleFactorArray ['thisIntNumber'] = durScaleFactor
		Add point: ('start_of_1' + 0.001), durScaleFactor
		Add point: ('end_of_1' - 0.001), durScaleFactor
	endfor
	plus Manipulation word1
	Replace duration tier
	select Manipulation word1
	Get resynthesis (overlap-add)
	Scale intensity... 'word1_int'
	dtw_dur = Get total duration
	Rename... word_dtw
	
	To TextGrid: "intervals", ""
	
	boundarytimepoint = 0
	for thisIntNumber to word1_nInts
		start_of_1 = word1_thisInt_startArray ['thisIntNumber']
		end_of_1 = word1_thisInt_endArray ['thisIntNumber']
		dur_of_1 = word1_thisInt_durArray ['thisIntNumber']
		dur_of_2 = word2_thisInt_durArray ['thisIntNumber']
		scaledDur = word1_thisInt_scaledDurArray ['thisIntNumber']
		durScaleFactor = word1_thisInt_scaleFactorArray ['thisIntNumber']
		
		if thisIntNumber <> word1_nInts
			boundarytimepoint = boundarytimepoint + scaledDur
			select TextGrid word_dtw
			Insert boundary... 1 'boundarytimepoint'
		endif

		printline 'word1$'	'word1_dur'	'word2_dur'	'thisIntNumber'	'dur_of_1'	'dur_of_2'	'scaledDur'	'durScaleFactor'	'dtw_dur'
	endfor

	#######################################
	## Save the final result sound
	#######################################
	select Sound word_dtw
	Save as WAV file: "'dir_out$'\'word1$'_dtw.wav"
	select TextGrid word_dtw
	Save as text file: "'dir_out$'\'word1$'_dtw.TextGrid"

	select all
	minus Table 'table_name$'
	Remove
endfor



################################################################################
# End of script
################################################################################

```
