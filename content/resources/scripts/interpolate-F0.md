---
title: Interpolate F0 continuum
type: book
weight: 60
#date: '2021-01-01'
---

This script creates an F0 continuum for two segmentally matching words (e.g., *SUBject* vs. *subJECT*). First, it matches the two words in duration and then interpolates the F0 contour linearly in 11 steps (steps 1 and 11 being the original contours), controlling for intensity.

> You can also [download the script](../interpolate-F0.praat) as a .praat file.

```
#____________________________________ HEADER __________________________________####
# date:         31.01.2023, run in Praat 6.2.12 on Windows 11
# author:       Ronny Bujok (adapted from Hans Rutger Bosker)
# email:        Ronny.Bujok@mpi.nl
# filename:     F0_stress continuum_interpolation.praat
# project:      Audiovisual Perception of Lexical Stress
# license:		CC BY-NC 4.0

####################################################################################################################
# This script takes recordings of segmentally identical, disyllabic minimal stress pairs with lexical stress on the first 
# (strong-weak; SW) or second (weak-strong; WS) syllable (e.g., VOORnaam vs. voorNAAM) and interpolates their F0-contours linearly. 
# The manipulated F0-contours are applied to the SW recording to create an F0-based lexical stress continuum.
# Duration and Intensity are set to mean, ambiguous values.
#
# This script requires minimal pairs to match in their name. Stress pattern in input files is denoted with "_sw" or "_ws" 
# (e.g., voornaam_sw.wav & voornaam_ws.wav). No other underscore characters are allowed.
# Textgrids for each recording are required, with boundaries at word onset, second syllable onset and word offset.
#
# Note that the parameters for pitch estimation are set to match a male voice. When working with a female voice,
# please adjust the arguments of the functions "Lengthen (overlap-add)" and "To Manipulation".
####################################################################################################################


# Define input and output directory
input_directory$ = "C:\input folder"
output_directory$= "C:\output folder"

# create file list of all files with the ending "_sw.wav" (just sound files, one per minimal pair (sw))
Create Strings as file list... list 'input_directory$'\*_sw.wav
n = Get number of strings

# _________________________________ CREATE FILELIST ____________________________________________________

# create list again because it removes itself after every iteration
for x from 1 to n
	Create Strings as file list... list 'input_directory$'\*_sw.wav

# get only the word name without extension or stress identifier (sw or ws)
	select Strings list
	current_file$ = Get string... x
	idx = rindex (current_file$, "_")
	word$ = left$(current_file$,idx-1)

#_____________________________________ DURATION ___________________________________________________________

# To interpolate F0 contours, recordings must be of equal length. So duration must be manipulated first. 

#---------------------------------- get values from SW word ---------------------------------------------
# open SW word and convert to mono
		wavfile_sw$ = "'word$'_sw"
		Read from file... 'input_directory$'\'wavfile_sw$'.Textgrid
		Read from file... 'input_directory$'\'wavfile_sw$'.wav
		Convert to mono
		Rename: "mono_sw"
		wav_sw_id = selected()
# select the mono file and the corresponding textgrid and extract all intervals
		selectObject: "TextGrid 'wavfile_sw$'"
		plusObject: "Sound mono_sw"
		Extract all intervals: 1, "no"
# select the second interval (first syllable) and get the total duration and the intensity	
		select (wav_sw_id+2)  
		sw_dur1= Get total duration
		sw_int1= Get intensity (dB)
		Rename: "sw_1"
# select the third interval (second syllable) and get the total duration and the intensity		
		select (wav_sw_id+3)
		sw_dur2= Get total duration
		sw_int2= Get intensity (dB)
		Rename: "sw_2"

# select and rename the first and last interval (silences) for future reference, to concatenate the final audio
		select (wav_sw_id+1)
		Rename: "pre_silence_sw"
		select (wav_sw_id+4)
		Rename: "post_silence_sw"
		
#---------------------------------- get values from WS word -----------------------------------------

# open WS word and convert to mono		
		wavfile_ws$ = "'word$'_ws"
		Read from file... 'input_directory$'\'wavfile_ws$'.Textgrid
		Read from file... 'input_directory$'\'wavfile_ws$'.wav
		Convert to mono
		Rename: "mono_ws"
		wav_ws_id = selected()
# select the mono file and the corresponding textgrid and extract all intervals		
		selectObject: "TextGrid 'wavfile_ws$'"
		plusObject: "Sound mono_ws"
		Extract all intervals: 1, "no"
# select the second interval (first syllable) and get the total duration and the intensity			
		select (wav_ws_id+2)
		ws_dur1= Get total duration
		ws_int1= Get intensity (dB)
		Rename: "ws_1"	
# select the third interval (second syllable) and get the total duration and the intensity		
		select (wav_ws_id+3)
		ws_dur2= Get total duration
		ws_int2= Get intensity (dB)
		Rename: "ws_2"	


#---------------------------------- Manipulate duration ------------------------------------------

# Set the duration of syllable 1 of the SW word to the average, ambiguous duration
		select Sound sw_1
		targetdur_1 = ((sw_dur1+ws_dur1)/2)
		Lengthen (overlap-add)... 75 250 (targetdur_1/sw_dur1)
		Rename: "sw_1_durmatched"			
# Set the duration of syllable 2 of the SW word to the average, ambiguous duration
        select Sound sw_2
		targetdur_2 = ((sw_dur2+ws_dur2)/2)
		Lengthen (overlap-add)... 75 250 (targetdur_2/sw_dur2)
		Rename: "sw_2_durmatched"	
		
# Set the duration of syllable 1 of the WS word to the average, ambiguous duration
        select Sound ws_1
		Lengthen (overlap-add)... 75 250 (targetdur_1/ws_dur1)
		Rename: "ws_1_durmatched"		
# Set the duration of syllable 2 of the WS word to the average, ambiguous duration
        select Sound ws_2
		Lengthen (overlap-add)... 75 250 (targetdur_2/ws_dur2)
		Rename: "ws_2_durmatched"
		


# Concatenate duration-manipulated SW word
		select Sound sw_1_durmatched
		plusObject: "Sound sw_2_durmatched"
		Concatenate recoverably
		select Sound chain
		Rename: "durmatched_sw"
# Concatenate duration-manipulated WS word
        select Sound ws_1_durmatched
		plusObject: "Sound ws_2_durmatched"
		Concatenate recoverably
		select Sound chain
		Rename: "durmatched_ws"
		
# save TextGrid with the boundary between the syllables. Necessary for intensity manipulation
		select TextGrid chain
		Rename: "syl_boundary"
		

		
#__________________________________________ F0 INTERPOLATION ________________________________________________

# Extract the pitch tiers
		select Sound durmatched_sw
		s1_dur = Get total duration
		To Manipulation... 0.01 50 300
		Extract pitch tier

		select Sound durmatched_ws
		s2_dur = Get total duration
		To Manipulation... 0.01 50 300
		Extract pitch tier

# create 10 ms time bins for interpolation
		timebinsize = 0.01
		nbins = floor(s1_dur/timebinsize)

		for currentbin from 1 to 'nbins'
			currentbin_start = (currentbin*timebinsize)-timebinsize
			currentbin_end = (currentbin*timebinsize)
			currentbin_mid = (currentbin_start + currentbin_end)/2
			select PitchTier durmatched_sw
			currentbin_f0_s1 = Get value at time... currentbin_mid
			f0_bin_s1 [currentbin] = currentbin_f0_s1
			select PitchTier durmatched_ws
			currentbin_f0_s2 = Get value at time... currentbin_mid
			f0_bin_s2 [currentbin] = currentbin_f0_s2
		endfor

#define number of steps for interpolation
		nsteps = 11
		step_ratio = 1/('nsteps'-1)
		# This means that...
		#	the stepsize is 10% of the difference between SW and WS;
		#	step 1 of the continuum is the original SW contour;
		#	step 11 of the continuum is the original WS contour. 
		

# interpolate the pitch tiers 
		for currentstep from 1 to 'nsteps'
			select PitchTier durmatched_sw
			Copy... interpol_'currentstep'

			# first remove all original F0 points
			Remove points between... 0 's1_dur'
			
			# now add a point for each time bin
			for currentbin from 1 to 'nbins'
				currentbin_start = (currentbin*timebinsize)-timebinsize
				currentbin_end = (currentbin*timebinsize)
				currentbin_mid = (currentbin_start + currentbin_end)/2
				currentbin_f0_s1 = f0_bin_s1 [currentbin]
				currentbin_f0_s2 = f0_bin_s2 [currentbin]
				currentbin_f0_diff = currentbin_f0_s1 - currentbin_f0_s2
				currentbin_f0_ratio = currentbin_f0_diff * 'step_ratio'
				currentbin_f0_interpol = currentbin_f0_s1 - (currentbin_f0_ratio * ('currentstep'-1))
				
				Add point... 'currentbin_mid' 'currentbin_f0_interpol'
			endfor
			
# select original audio (in this case SW recording) and replace the pitch contour
			select Manipulation durmatched_sw
			Copy... interpol_'currentstep'			
			plusObject: "PitchTier interpol_'currentstep'"
			Replace pitch tier
			minusObject: "PitchTier interpol_'currentstep'"
			Get resynthesis (overlap-add)
			
			interval_id = selected()

#__________________________________________ INTENSITY____________________________________________________

# extract each syllable again for intensity manipulation
			plusObject: "TextGrid syl_boundary"
			Extract all intervals: 1, "no"

# set (average) target intensity per syllable
            targetint_1 = ((sw_int1+ws_int1)/2) 
            targetint_2 = ((sw_int2+ws_int2)/2) 
			
# adjust the intensities to an average/ambigous value
			select (interval_id+1)
			Scale intensity... targetint_1
			Rename: "final_syl_1"
			
			select (interval_id+2)
			Scale intensity... targetint_2
			Rename: "final_syl_2"

#______________________________________ CONCATENATE & SAVE ______________________________________________

# copy final segment of the recording (silence post word offset), so Praat concatenates in the correct order
			select Sound post_silence_sw
			Copy... post_silence_sw_copy
# select remaining segments
			plusObject: "Sound pre_silence_sw"
			plusObject: "Sound final_syl_1"
			plusObject: "Sound final_syl_2"
			plusObject: "post_silence_sw_copy"
# concatenate
			Concatenate recoverably
			select Sound chain
			Rename: "'word$'_step_'currentstep'"
			Save as WAV file... 'output_directory$'\'word$'_step_'currentstep'.wav
			select TextGrid chain
			Save as text file... 'output_directory$'\'word$'_step_'currentstep'.TextGrid

		endfor
	
	select all
	Remove
	
endfor

################################################################################
# End of script
################################################################################

```
