################################################################################
### Hans Rutger Bosker, Radboud University
### HansRutger.Bosker@ru.nl
### Date: 23 June 2022, run in Praat 6.2.12 on Windows 10
### License: CC BY-NC 4.0
################################################################################

	###>> This script saves all selected objects to the directory 'dir_out$'
	###>>	with either:
	###>>   - their object name (e.g., "sentence1.wav")
	###>>			> set variable 'save_method$' to "name" [default]
	###>>   - their id number in the Praat object window (e.g., "42.wav")
	###>>			> set variable 'save_method$' to "id"
	###>>
	###>> Sounds are saved as .wav files,
	###>> other object types (TextGrids, Spectrum, etc.) are saved
	###>> with their own extension type (.TextGrid, .Spectrum).
	###>>
	###>> Default: the script will overwrite pre-existing files.
	###>> Set variable 'overwrite$' to "no" if you want Praat
	###>> to throw an error instead.



################################################################################
### Variables you will definitely need to customize:
################################################################################

### Where should the selected objects be saved?

dir_out$ = "C:\Users\hanbos\mysounds"

### Should Praat overwrite pre-existing files?

overwrite$ = "yes"
#overwrite$ = "no"

### Do you want to save each object by its object name or by its id number?
### If object name, then use "name" (e.g., "sentence1.wav").
### If object id number, then use "id" (e.g., "42.wav").

save_method$ = "name"
#save_method$ = "id"





################################################################################
### Before we start, let's check whether you've entered sensible
### input for the variables above...
################################################################################

### Let's check if the output directory exists.
### This script will throw an error if the directory doesn't exist
### (i.e., it won't write to a mysterious temp directory).

### First check whether the input directory ends in a backslash (if so, removed)

if right$(dir_out$,1)="/"
	dir_out$ = left$(dir_out$,length(dir_out$)-1)
elsif right$(dir_out$,1)="\"
	dir_out$ = left$(dir_out$,length(dir_out$)-1)
endif

### Then create a temporary txt file in the folder
### and try to write it to the output folder.

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
	exit Your directory doesn't exist. Check spelling. The directory must *already* exist.
endif





################################################################################
################################################################################
#################################    SCRIPT    #################################
################################################################################
################################################################################

### Make sure you've selected the objects you'd like to save in
### the Praat object window. If nothing is selected, the script exits.

nSelected = numberOfSelected()
if nSelected = 0
	exit No objects selected.
endif

### Store the object id numbers in an array

for thisObject to nSelected
	objectArray ['thisObject'] = selected('thisObject')
endfor

### Loop through this array and for each id number
### select the corresponding object and save it.

for thisArrayNumber to nSelected
	objectId = objectArray ['thisArrayNumber']
	select 'objectId'
	type$ = extractWord$(selected$(), "")
	name$ = extractLine$(selected$(), " ")
	
	if save_method$ = "name"
		if type$ = "Sound"
			does_file_exist = fileReadable("'dir_out$'\'name$'.wav")
			if does_file_exist = 1
				if overwrite$ = "no"
					exit The file 'dir_out$'\'name$'.wav' already exists! If you wish to overwrite, set the variable overwrite$ to "yes".
				endif
			endif
			Write to WAV file... 'dir_out$'\'name$'.wav
		else
			does_file_exist = fileReadable("'dir_out$'\'name$'.'type$'")
			if does_file_exist = 1
				if overwrite$ = "no"
					exit The file 'dir_out$'\'name$'.'type$' already exists! If you wish to overwrite, set the variable overwrite$ to "yes".
				endif
			endif
			Write to text file... 'dir_out$'\'name$'.'type$'
		endif
	elsif save_method$ = "id"
		if type$ = "Sound"
			does_file_exist = fileReadable("'dir_out$'\'objectId$'.wav")
			if does_file_exist = 1
				if overwrite$ = "no"
					exit The file 'dir_out$'\'objectId$'.wav' already exists! If you wish to overwrite, set the variable overwrite$ to "yes".
				endif
			endif
			Write to WAV file... 'dir_out$'\'objectId'.wav
		else
			does_file_exist = fileReadable("'dir_out$'\'objectId$'.'type$'")
			if does_file_exist = 1
				if overwrite$ = "no"
					exit The file 'dir_out$'\'objectId$'.'type$' already exists! If you wish to overwrite, set the variable overwrite$ to "yes".
				endif
			endif
			Write to text file... 'dir_out$'\'objectId'.'type$'
		endif
	endif
endfor

### Now set the selection back to what it was before running this script.

for current to nSelected
	objectId = objectArray ['current']
	if current = 1
		select 'objectId'
	else
		plus 'objectId'
	endif
endfor

################################################################################
# End of script
################################################################################
