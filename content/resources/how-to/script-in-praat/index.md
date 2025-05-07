---
title: ...script in Praat
type: book
weight: 30
#date: '2021-01-01'
---

{{% callout note %}}
Here's a brief intro into the Praat scripting language. We'll cover how to write and run a script, point you to some tutorials, highlight some of the strange quirks in the Praat scripting language, and provide some scripts we find useful ourselves.
{{% /callout %}}

## Run your first script

- Open Praat, and go to *Praat > New Praat script*.

{{< figure src="open_praatscript.png" >}}

- You'll find a rather empty-looking window popping up on your screen, with the menus *File, Edit, Search, Convert, Font, Run* at the top.
- Now type this into that scripting window:

```
Create Sound from formula: "demo", 1, 0, 1, 44100, "1/2 * sin(2*pi*377*x)"
Play
```

- Now turn on your speakers...
- ...and click *Run > Run* or hit [CTRL+R] to execute the script.
- Congratulations, you've run your first script that creates and plays a short 377 Hz tone.

## Every line is a click

The Praat scripting language is a Graphical User Interface (GUI) scripting language. This means that, put rather bluntly, **every line in the script is like a click in the Praat object window**. The two lines in the code above are identical to:
- selecting *New > Sound > Create Sound from formula...*, and entering some parameters
- clicking Play

This also means that you can click around in Praat and then ask Praat to give you the code for those particular clicks. That is, Praat actually keeps track of every click you perform.
- Go to the scripting window
- click *Edit > Paste history*

This asks Praat to paste every action you performed since opening Praat. This is particularly handy when you don't know how to script a certain action. For instance, you wanna know how to open a sound file in Praat using a script?

- Go to the Praat object window
- click *Open > Read from file...* and open a sound file
- Now go to the scripting window
- click *Edit > Paste history*

It should show you something along the lines of:

```
Read from file: "C:\Users\hanbos\mysounds\demo.wav"
```

but then with a different directory and filename.

So remember: **perform the functions in the object window, paste history in the scripting window, and edit the code from there**.

## Tutorials

Praat offers a scripting tutorial itself. Go to *Help > Praat Intro* and scroll down to find *Scripting*. You can also find it online: https://www.fon.hum.uva.nl/praat/manual/Scripting.html. This tutorial is not too bad actually. There's also these quick intro slides by Eleanor Chodroff: https://www.eleanorchodroff.com/tutorial/PraatScripting.pdf. More **comprehensive guides** are:

- ["Speech Signal Processing with Praat"](https://www.fon.hum.uva.nl/david/sspbook/sspbook.pdf) by David Weenink himself!
- ["Using Praat for Linguistic Research"](https://github.com/stylerw/usingpraat/raw/main/UsingPraatforLinguisticResearchLatest.pdf) by Will Styler
- https://praatscripting.lingphon.net: by Jörg Mayer
- https://praatscriptingtutorial.com/: by Daniel Riggs
- http://www.mauriciofigueroa.cl/04_scripts/04_scripts.html: by Mauricio A. Figueroa Candia

## Strange quirks

Praat has some peculiarities that make the Praat scripting language stand out compared to other languages, like *python* and *R*.

- Over the years, Praat has had three types of syntax. Current Praat versions are compatible with older and newer syntax types, and mixes thereof.

```
# This line of code extracts the first 100 ms of a sound object...
# ... in Praat versions 5.3.43 and older; before April 2013
Extract part... 0 0.1 rectangular 1 no
# ... in Praat versions between 5.3.44 and 5.3.62; April 2013 - January 2014
do("Extract part", 0, 0.1, "rectangular", 1, "no")
# ... in Praat versions 5.3.63 and later; after January 2014
Extract part: 0, 0.1, "rectangular", 1, "no"
```

- Praat variables **always** start in lowercase. Capitals are reserved for functions:

```
play = 2
for i to play
    Play
endfor
```

- Praat does not distinguish between single and double equal signs:

```
intensityLevel = 75
if intensityLevel = 75
    newIntensityLevel = 80
endif
```

- Praat uses single quotes to access the value of a variable. This is, for instance, important when concatenating the values of different string variables:

```
myDirectory$ = "C:\Users\hanbos\mysounds"
myFilename$ = "demo.wav"
Read from file: "'myDirectory$'\'myFilename$'"
```

- Praat's spelling is `elsif`, **not** `elseif` (don't ask me why...)

```
if intensityLevel = 80
    Scale intensity: 75
elsif intensityLevel = 75
    Scale intensity: 80
else
    Scale intensity: 65
endif
```

- Praat's symbol for "not equal to" is `<>` (...duh!)

```
# skip measurements on the first interval
if interval_number <> 1
    dur_measurement = Get total duration
endif
```

- Different objects in Praat have different functions. For Sound objects, you can run functions like `Play`, `Resample...`, `Scale intensity...`, etc., while for TextGrid objects, you can run functions like `Duplicate tier...`, `Insert boundary...`, etc. Therefore, it is important to **keep track of which object is selected**:

```
myDirectory$ = "C:\Users\hanbos\mysounds"
myFilename$ = "demo.wav"
Read from file: "'myDirectory$'\'myFilename$'"
To TextGrid: "words", ""
Play
```

... will throw an error because the newly created TextGrid is automatically selected after `To TextGrid:` and Praat cannot play TextGrids. The solution is:

```
myDirectory$ = "C:\Users\hanbos\mysounds"
myFilename$ = "demo.wav"
Read from file: "'myDirectory$'\'myFilename$'"
To TextGrid: "words", ""
select Sound demo
Play
```

- Praat's Object window replaces periods, spaces, and special characters in filenames with "_". This can get you into trouble when you first read a file called "word1 (talker4) v1.3.wav" and later on want to select it in the Object window:

```
myDirectory$ = "C:\Users\hanbos\mysounds"
myFilename$ = "word1 (talker4) v1.3"
Read from file: "'myDirectory$'\'myFilename$'.wav"
To TextGrid: "words", ""
select Sound 'myFilename$'
Play
```

... will throw an error upon reaching the `select` statement. This is because the Object window only lists a Sound object with the name "word1__talker4__v1_3" and hence cannot find "word1 (talker4) v1.3". The best solution is to avoid periods, spaces, and special characters in your filenames; only use "_" and "-"!

## Ready-made scripts

See our [Scripts](/resources/scripts/) archive for snippets of code we frequently use. Note, however, that **they require customization** for each individual new project. *Use at your own risk!*

Other scripts resources available online are:
- [Vocal Toolkit plugin](http://www.praatvocaltoolkit.com/) is a plugin for Praat. When installed, you can call various new functions from a button within Praat. However, it's a little risky if you don't know the ins-and-outs of a particular function, so **always check the raw code** here:
  - [WINDOWS] "C:\Users\\*(Username)*\Praat\plugin_VocalToolkit"
  - [MAC] "/Users/*(UserName)*/Library/Preferences/Praat Prefs/"
- [Matt Winn's Listen Lab](http://www.mattwinn.com/praat.html) with some really fun [Youtube Praat tutorials](https://www.youtube.com/playlist?list=PL6niCBwOhjHga4bCS83VJ2uKzQ8ZjEVeG)
- [Holger Mitterer's website](http://holgermitterer.eu/research.html)
- [Will Styler's repo](https://github.com/stylerw/styler_praat_scripts)

## PraatVSCode

The scripting interface in Praat itself is not the best. It's basically a plain text editor with a Run button. There's no syntax highlighting, no autocompletion, no regular expression search options...

Therefore, many users tend to write and edit their scripts in other editors, like TextPad, Notepad++, or Sublime. Some of these even provide things like syntax highlighting and autocompletion, see [this overview](https://praatpfanne.lingphon.net/praat-ressourcen/resources-english/) for editor plugins for Sublime, Kate, Atom, Notepad++, Vim, and Ace. However, **none of these can run Praat code**. Instead, users need to write their code in Notepad++, copy it, paste it into Praat, and then hit Run. You can't imagine how cumbersome this is and it can introduce all sorts of human errors.

A great solution is [PraatVSCode](/resources/tools/#praatvscode):

{{< figure src="https://github.com/orhunulusahin/praatvscode/blob/main/assets/syntax_after.png?raw=true" width="600">}}

Created by our very own {{< mention "orhun-ulusahin" >}}, PraatVSCode is an extension for Visual Studio Code, providing syntax highlighting, autocompletion, and even an array of code snippets that writes itself. Moreover, it allows **running of scripts by Praat from inside Visual Studio Code**. [Try it now!](/resources/tools/#praatvscode)

*Happy coding!*
