---
title: "Praat: Manipulate ITD/IID"
type: book
weight: 50
#date: '2021-01-01'
---

This Praat script allows you to create a 'virtual auditory reality' by implementing interaural time differences (ITD) and interaural intensity differences (IID) for two sounds. Thus we simulate naturalistic perception of two fully lateralized sound sources.

When you want to play two talkers as coming from opposite sides (talker1 from the left, talker2 from the right), you could simply present the talkers in different channels of a stereo sound file. This way, when your listeners use headphones, talker1 is the only signal played in the left ear and talker2 is the only signal played in the right ear. This design, however, does not reflect naturalistic acoustic environments where the speech of a given talker typically reaches *both ears*. Moreover, such a simplistic 2-channel design also completely avoids any energetic masking from one talker onto the next.

In order to simulate more naturalistic multitalker environments, one can present the same sound to both ears, but with a slight delay (interaural time difference; ITD) and at a slightly lower intensity in one ear vs. the other (interaural intensity difference; IID). This way we simulate the shadowing effect of the listener's head, maintaining naturalistic energetic masking.

See [this demo]({{< ref "../../demos/cocktail-party" >}}) for some examples and further details. Also see [this paper](/publication/papoutsi-zimianiti-etal-2023-pbr) for an example of how we applied this technique to a statistical learning paradigm.

> You can also [download the script](../manipulate-ITD-IID.praat) as a .praat file.

```
################################################################################
### Hans Rutger Bosker, Radboud University
### HansRutger.Bosker@donders.ru.nl
### Date: 19 July 2023, run in Praat 6.3.08 on Windows 10
### License: CC BY-NC 4.0
################################################################################


    ###>> This script takes two input sounds and applies interaural time differences (ITD)
    ###>>	and interaural intensity differences (IID) in order to induce 'virtual' spatial
    ###>>	segregation of the two sosunds. This makes one sound be perceived as coming
    ###>>	from the left and the other sound as coming from the right, despite the fact
    ###>>   that both sounds are physically present in either channel. Use headphones
    ###>>   (i.e., not speakers) to best experience this spatial segregation. And remember:
    ###>>   wear the headphones appropriately (i.e., with L on your left ear, R on the right)

    ###>> In its current form, the script simply reads in two pre-defined mono sounds
    ###>>   and gives as output two stereo wav files: one wav file with sound1 perceived
    ###>>   as coming from the left and another with sound1 perceived as coming from the right.
    ###>>   Combine this script with the batch-processing.praat script to process
    ###>>   a larger number of files.

    ###>> Remember: the two sounds should be mono sound files (1-channel) with
    ###>>   the same sampling frequency.

################################################################################
### Variables you will definitely need to customize:
################################################################################

### Where can the files be found?

dir_in$ = "C:\Users\hanbos\Desktop\mysounds"

### Where should the output files be saved?

dir_out$ = "C:\Users\hanbos\Desktop\mysounds"





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

## Enter the filenames of the two sounds in the variables below.
## Remember to include the file extension (e.g., "firstsound.wav")
## but the filenames themselves should not contain any [.] character.

soundfile1$ = "firstsound.wav"
extposition = index(soundfile1$, ".")
soundname1$ = left$(soundfile1$, ('extposition'-1))

Read from file... 'dir_in$'\'soundfile1$'
Rename... original_s1
Convert to mono
Rename... soundone
fs_1 = Get sampling frequency
int_1 = Get intensity (dB)

soundfile2$ = "secondsound.wav"
extposition = index(soundfile2$, ".")
soundname2$ = left$(soundfile2$, ('extposition'-1))

Read from file... 'dir_in$'\'soundfile2$'
Rename... original_s2
Convert to mono
Rename... soundtwo
fs_2 = Get sampling frequency
int_2 = Get intensity (dB)

if fs_1 <> fs_2
	# if the two files have different sampling frequencies
	printline 'soundfile1$' has a sampling frequency of 'fs_1' Hz.
    printline 'soundfile2$' has a sampling frequency of 'fs_2' Hz.
	exit The two files have different sampling frequencies. Resample to match the sampling frequencies.
endif





## The ITD implemented here is 0.6 ms = 600 microseconds.
## This ITD simulates fully lateralized sound sources (Hartmann, 1999)
itd = 0.0006
Create Sound from formula: "itd", 1, 0, 0.0006, 'fs_1', "0"

## The ITD silence should precede the other two sounds in the Objects window
select Sound soundone
Copy... sound1
select Sound soundone
Remove
select Sound soundtwo
Copy... sound2
select Sound soundtwo
Remove




## The IID implemented here is -6 dB, simulating fully lateralized sound sources (Hartmann, 1999)

## Create the left channel, with sound1 appearing as coming from the left
select Sound itd
plus Sound sound2
Concatenate
Scale intensity... ('int_2'-6)
Formula... self + Sound_sound1[]
Rename... channel_L

## Create the right channel, with sound2 appearing as coming from the right
select Sound itd
plus Sound sound1
Concatenate
Scale intensity... ('int_1'-6)
Formula... self + Sound_sound2[]
Rename... channel_R

select Sound channel_L
plus Sound channel_R
Combine to stereo
Rename... L_s1_R_s2
Write to WAV file... 'dir_in$'\L_'soundname1$'_R_'soundname2$'.wav
Remove

## And the opposite localization:

select Sound channel_R
Copy... channel_left
select Sound channel_L
Copy... channel_right
plus Sound channel_left
Combine to stereo
Rename... R_s1_L_s2
Write to WAV file... 'dir_in$'\L_'soundname2$'_R_'soundname1$'.wav
Remove

## And clear up the mess
select Sound channel_L
plus Sound channel_R
plus Sound channel_left
plus Sound channel_right
plus Sound original_s1
plus Sound original_s2
plus Sound itd
plus Sound sound1
plus Sound sound2
Remove



################################################################################
# End of script
################################################################################

```
