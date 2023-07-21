################################################################################
### Hans Rutger Bosker, Radboud University
### HansRutger.Bosker@donders.ru.nl
### based on an earlier script created by Matthias Sjerps
### Date: 20 July 2023, run in Praat 6.3.08 on Windows 10
### License: CC BY-NC 4.0
################################################################################


	###>> This script takes pairs of items (e.g., bet and bit) from a directory
	###>>	that critically only differ in their F1 ("bet" has higher F1 than "bit").
	###>>	The script then creates a phonetic continuum from high F1 (bet) to low F1 (bit)
	###>>	using Burg's LPC method.
	
	###>> IMPORTANT: Please provide a list of word pairs in a .txt file in the
	###>>	input directory. This file should contain two tab-separated columns
	###>>	with the labels "word1" and "word2". Then script then loops over the
	###>>	rows in this list of pairs. For example:
	
	###>>	word1	word2
	###>>	bet	bit
	###>>	get	git
	###>>	set	sit

	###>> IMPORTANT: Every individual sound file should already have an accompanying
	###>>	.TextGrid file containing one tier. This tier should have 3 intervals:
	###>>	1. The interval preceding the critical vowel
	###>>	2. The interval of the critical vowel
	###>>	3. The interval following the critical vowel

	###>> The script includes transplantation of the intensity contour of the original
	###>>	word1 to the manipulated output sound. The script can also set the
	###>>	f0 of the manipulated vowel to a fixed average value calculated
	###>>	across the two members of an item pair. This is done by setting
	###>>	the variable control_f0$ to the value "yes".

	
################################################################################
### Variables you will definitely need to customize:
################################################################################

### Where can the files be found?

dir_in$ = "C:\Users\hanbos\Desktop\mysounds"

### Where should the output files be saved?

dir_out$ = "C:\Users\hanbos\Desktop\mysounds\continua"

### What is the name of the .txt file containing the list of word pairs?
### 	NOTE: Do **NOT** include the .txt extension; just the name!

table_name$ = "list_of_pairs"

### Next to the formant manipulations, do you also want to control the f0 and duration
### 	of the output sounds by setting them to the average value between the two words?

control_f0$ = "yes"

### Number of estimated formants (default: 5)
nformants = 5
### Provide the max. frequency for filtering (default for F1: 3000)
### 	Manipulations will be performed below this frequency only;
### 	the original signal is used above this frequency.
###		This helps to create natural-sounding (i.e., convincing) output speech.
filter = 3000
### Provide cutoff frequency for formant detection (default: 11000)
cutoff = 11000
### Provide the min and max pitch settings.
###		For female talker: 100 - 400
###		For male talker: 75 - 300
minpitch = 100
maxpitch = 400
### Define how many steps should be on your continua.
###		It helps if this value is an odd number so you have a 'true' average
###		in the middle. Default is 11 because this means the steps go up/down
###		by 10% every time. This means that step 1 has the mean F1 of the original
###		high-F1 member (e.g., bet) and step 11 has the mean F1 of the original
###		low-F1 member (e.g., bit).
nSteps = 11
### Define your manipulation method (default: burg)
methodLPC$ = "burg"
### Define your fade-in/fade-out overlap window in seconds (default: 0.01)
window = 0.01





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
## This log prints for each pair of items ("item"), for each created step,
##		the original word duration, vowel duration, mean f0, f1, f2, f3 for the 1st member of the item pair
##		the original word duration, vowel duration, mean f0, f1, f2, f3 for the 2nd member of the item pair
##		the word duration, vowel duration, mean f0, f1, f2, f3 for the manipulated output sound.
clearinfo
echo item	step	dur_1	voweldur_1	f0_1	f1_1	f2_1	f3_1	dur_2	voweldur_2	f0_2	f1_2	f2_2	f3_2	dur_manip	voweldur_manip	f0_manip	f1_manip	f2_manip	f3_manip





Read from file... 'dir_in$'\'table_name$'.txt
nItems = Get number of rows

for ItemCnt from 1 to nItems
	## Create leading and trailing silence of 0.5 sec to append to the words to
	## improve spectral measurements at the onset/offset of the words.
	Create Sound from formula... silence1 Mono 0 0.5 cutoff  0

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
	To Pitch... 0 'minpitch' 'maxpitch'
	f0_1 = Get mean... 0 0 Hertz

	select Sound word1
	Resample: cutoff, 50
	Rename... word1_belowcutoff
	select Sound word1
	Remove

	Create Sound from formula... silence2 Mono 0 0.5 cutoff  0
	select Sound silence1
	plus Sound word1_belowcutoff
	plus Sound silence2
	Concatenate
	Rename... word1_pad

	Filter (pass Hann band)... 0 filter 10
	Rename... Low_Part_1
	lowInt_1 = Get intensity (dB)
	To Intensity... 100 0 no
	Down to IntensityTier
	select Intensity Low_Part_1
	Remove

	select Sound word1_pad
	To LPC (burg): ('nformants'*2), 0.025, 0.005, 50
	select Sound word1_pad
	plus LPC word1_pad
	Filter (inverse)
	Rename... Source_1
	select LPC word1_pad
	Remove
	
	Read from file... 'dir_in$'\'word1$'.TextGrid
	Rename... word1
	Shift times by... 0.5
	vowelonset_1 = Get start time of interval... 1 2
	voweloffset_1 = Get end time of interval... 1 2
	voweldur_1 = voweloffset_1 - vowelonset_1

	select Sound word1_pad
	To Formant ('methodLPC$')... 0 nformants (cutoff/2) 0.025 50
	maxForm = Get maximum number of formants
	for formCnt from 1 to maxForm
		origFormantsArray_1 ['formCnt'] = Get mean... 'formCnt' 'vowelonset_1' 'voweloffset_1' hertz
		f'formCnt'_1 = Get mean... 'formCnt' 'vowelonset_1' 'voweloffset_1' hertz
	endfor
	Remove
	
	
	
	
	
	#######################################
	## Read and measure acoustics of word2
	#######################################

	Read from file... 'dir_in$'\'word2$'.wav
	Rename... word2
	sampFreq_2 = Get sampling frequency
	dur_2 = Get total duration
	int_2 = Get intensity (dB)
	To Pitch... 0 'minpitch' 'maxpitch'
	f0_2 = Get mean... 0 0 Hertz

	select Sound word2
	Resample: cutoff, 50
	Rename... word2_belowcutoff
	select Sound word2
	Remove

	Create Sound from formula... silence2 Mono 0 0.5 cutoff  0
	select Sound silence1
	plus Sound word2_belowcutoff
	plus Sound silence2
	Concatenate
	Rename... word2_pad

	Filter (pass Hann band)... 0 filter 10
	Rename... Low_Part_2
	lowInt_2 = Get intensity (dB)
	To Intensity... 100 0 no
	Down to IntensityTier
	select Intensity Low_Part_2
	Remove

	select Sound word2_pad
	To LPC (burg): ('nformants'*2), 0.025, 0.005, 50
	select Sound word2_pad
	plus LPC word2_pad
	Filter (inverse)
	Rename... Source_2
	select LPC word2_pad
	Remove

	Read from file... 'dir_in$'\'word2$'.TextGrid
	Rename... word2
	Shift times by... 0.5
	vowelonset_2 = Get start time of interval... 1 2
	voweloffset_2 = Get end time of interval... 1 2
	voweldur_2 = voweloffset_2 - vowelonset_2

	select Sound word2_pad
	To Formant ('methodLPC$')... 0 nformants (cutoff/2) 0.025 50
	maxForm = Get maximum number of formants
	for formCnt from 1 to maxForm
		origFormantsArray_2 ['formCnt'] = Get mean... 'formCnt' 'vowelonset_2' 'voweloffset_2' hertz
		f'formCnt'_2 = Get mean... 'formCnt' 'vowelonset_2' 'voweloffset_2' hertz
	endfor
	Remove
	
	
	

	
	#######################################
	## Now loop over steps
	#######################################

	for stepCtr from 1 to nSteps

		# NOTE: we take word1 (here: the high-F1 member [bet]) as the basis for the manipulations.

		select Sound word1_pad
		To Formant ('methodLPC$')... 0 nformants (cutoff/2) 0.025 50
		maxForm = Get maximum number of formants
		nFrames = Get number of frames
		Rename: "New_Form_'stepCtr'"

		###############################################################################################################
		# if some items need custom formant shifts, you can define an item-specific constant here
		###############################################################################################################
		constant = 0
		#	if word1$ = "bet"
		#		constant = 30
		#	elsif word1$ = "get"
		#		constant = 50
		#	elsif word1$ = "set"
		#		constant = 40
		#	endif

		## NOTE: we create a continuum starting at the high-F1 member (on step 1)
		##	gradually going do to the low-F1 member.
		stepsize = (f1_1 - f1_2)/(nSteps-1)
		Formula (frequencies): "if row = 1 then (self-(((stepCtr-1)*stepsize)+constant)) else self fi"
		
		## You can also control other formants, for instance by setting the F2 to the average of the two vowels
		## thus creating an ambiguous F2 in between the two vowels that is fixed/constant at every step.
		## For instance:

		#ambF2 = (f2_1 + f2_2)/2
		#distanceToAmbF2 = f2_1 - ambF2
		#Formula (frequencies): "if row = 2 then (self-distanceToAmbF2) else self fi"
		
		## Filter the original source with the new formant filter
		select Formant New_Form_'stepCtr'
		plus Sound Source_1
		Filter

		## Restrict to lower-freq content only
		Filter (pass Hann band)... 0 filter 10
		Rename... word1_'stepCtr'_Low

		## Transplant the original intensity contour back onto the manipulated speech
		To Intensity... 100 0 no
		Down to IntensityTier
		Formula... self*-1
		plus Sound word1_'stepCtr'_Low
		Multiply... yes
		plus IntensityTier Low_Part_1
		Multiply... yes
		Scale intensity... lowInt_1

		## Remove leading and trailing silences
		Extract part: 0.5, (dur_1+0.5), "rectangular", 1, "no"
		Resample: sampFreq_1, 50
		Rename... word1_'stepCtr'_Low_nonpad

		## Combine with the original high-freq content
		Read from file... 'dir_in$'\'word1$'.wav
		Rename... word1
		Filter (pass Hann band)... filter sampFreq_1 10
		Rename... word1_High
		plus Sound word1_'stepCtr'_Low_nonpad
		Combine to stereo
		Convert to mono
		Rename... word1_'stepCtr'_manip
		Scale intensity... int_1
		selectObject: "Sound word1"
		Scale intensity... int_1

		select Sound word1_'stepCtr'_manip
		dur_manip = Get total duration
		To Manipulation... 0.01 'minpitch' 'maxpitch'
		Extract pitch tier
		f0_manip = Get mean (curve)... 0 0

		## Set the F0 to the average values across word1 & word2
		if control_f0$ = "yes"
			newWordF0 = (f0_1+f0_2)/2
			f0ScalingFactor = newWordF0/f0_manip

			select Manipulation word1_'stepCtr'_manip
			Extract pitch tier
			Multiply frequencies... 0 1000 'f0ScalingFactor'
			f0_manip = Get mean (curve)... 0 0
			plus Manipulation word1_'stepCtr'_manip
			Replace pitch tier
			select Manipulation word1_'stepCtr'_manip
			Get resynthesis (overlap-add)
			Rename... word1_'stepCtr'_manip
		endif
		
		## We've shifted the formants in the entire word but we really only want to keep
		## the critical manipulated vowel only. So here we combine:
		## 1. the original pre-vowel interval
		## 2. the manipulated vowel interval
		## 3. the original post-vowel interval
		## using a switch (man1Orig0Switch) that starts at 0 (set to original unmanipulated)
		## and switches back and forth to 1 (manipulated), then 0, etc.

		Read from file... 'dir_in$'\'word1$'.TextGrid
		Rename... word1
		nInterv = Get number of intervals: 1
		man1Orig0Switch = 0
		for intervCnt from 1 to nInterv
			selectObject: "TextGrid word1"
			
			intSta = Get start point: 1, intervCnt
			intEnd = Get end point: 1, intervCnt
			if intervCnt = 1
				intSta2 = intSta
				intEnd2 = intEnd + (window/2)
			elsif intervCnt = nInterv
				intSta2 = intSta - (window/2)
				intEnd2 = intEnd
			elsif intervCnt = 2
				intSta2 = intSta - (window/2)
				intEnd2 = intEnd + (window/2)
				vowelonset = intSta
				voweloffset = intEnd
				voweldur_manip = intEnd-intSta
			endif

			if man1Orig0Switch = 0
				selectObject: "Sound word1"
				Extract part: intSta2, intEnd2, "rectangular", 1, "no"
				Rename... 'intervCnt'
				man1Orig0Switch = 1
			elsif man1Orig0Switch = 1
				selectObject: "Sound word1_'stepCtr'_manip"
				Extract part: intSta2, intEnd2, "rectangular", 1, "no"
				Rename... 'intervCnt'
				man1Orig0Switch = 0
			endif
		endfor

		selectObject: "Sound 1"
		for intervCnt_2 from 2 to nInterv
			plusObject: "Sound 'intervCnt_2'"
		endfor
		Concatenate with overlap... 'window'
		Rename... Resynth____'stepCtr'

		## Save the final result sound
		Save as WAV file: "'dir_out$'\'word1$'_step'stepCtr'.wav"
		selectObject: "TextGrid word1"
		Save as text file: "'dir_out$'\'word1$'_step'stepCtr'.TextGrid"
		
		# Let's query the F1, F2, F3, F4 for the manipulated vowel interval
		select Formant New_Form_'stepCtr'
		f1_manip = Get mean... 1 (vowelonset+0.5) ((voweloffset)+0.5) hertz
		f2_manip = Get mean... 2 (vowelonset+0.5) ((voweloffset)+0.5) hertz
		f3_manip = Get mean... 3 (vowelonset+0.5) ((voweloffset)+0.5) hertz
		f4_manip = Get mean... 4 (vowelonset+0.5) ((voweloffset)+0.5) hertz
		
		select Sound Resynth____'stepCtr'
		dur_manip = Get total duration
			
		printline 'word1$'	'stepCtr'	'dur_1'	'voweldur_1'	'f0_1'	'f1_1'	'f2_1'	'f3_1'	'dur_2'	'voweldur_2'	'f0_2'	'f1_2'	'f2_2'	'f3_2'	'dur_manip'	'voweldur_manip'	'f0_manip'	'f1_manip'	'f2_manip'	'f3_manip'
	endfor

	select all
	minus Table 'table_name$'
	Remove
endfor



################################################################################
# End of script
################################################################################
