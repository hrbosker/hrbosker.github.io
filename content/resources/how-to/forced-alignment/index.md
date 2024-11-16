---
title: ...do forced-alignment
type: book
weight: 16
#date: '2021-01-01'
---

{{% callout note %}}
This shows you how to perform forced-alignment using **[WebMAUS](https://clarin.phonetik.uni-muenchen.de/BASWebServices/interface/WebMAUSBasic)**. It takes pairs of sound files + text files with the same filename (item1.wav + item1.txt) as input and matches the orthographic words in the txt file to the sounds, syllables, and words in the sound file. The output are TextGrid files with word, syllable, and phoneme level annotations.
{{% /callout %}}

## Findings words, syllables, and sounds

When you have some speech recordings for your research, you may want to know when in time the target word occurs, or how long the vowels are. These measurements are often done **in TextGrids in [Praat](https://www.fon.hum.uva.nl/praat/)**. When you have a small set of recordings, you can manually create word-level, syllable-level, or phoneme-level intervals by hand (also see our [how-to-annotate-in-praat](/resources/how-to/annotate-in-praat/)). However, this is hard work and very time-consuming (and outright boring). So let's speed things up a bit!

## Forced alignment

Forced alignment is when you try to **automatically match orthographic transcriptions (text) to speech recordings (audio)**. The resulting output is sometimes called 'timestamps', 'speech marks', 'annotations', or 'intervals', for instance in TextGrids in Praat. There are various forced-aligners available nowadays, the most famous being [WhisperX](https://github.com/m-bain/whisperX), [Montreal Forced Aligner](https://montreal-forced-aligner.readthedocs.io/en/latest/), [Penn Forced Aligner (P2FA)](https://web.sas.upenn.edu/phonetics-lab/facilities/), [EasyAlign](https://github.com/evyaco/EasyAlignIPA), and [WebMAUS](https://clarin.phonetik.uni-muenchen.de/BASWebServices/interface/WebMAUSBasic).

## WebMAUS

I selected WebMAUS for this how-to because:
- it can handle a large number of languages
- it can do word-level AND syllable-level AND phoneme-level annotations
- it is pretty accurate
- it is accessible through a Python script as well as a fairly user-friendly web interface
- it gives TextGrids as output.

Here's an example of some WebMAUS output, showing words (in orthography and [X-SAMPA](https://en.wikipedia.org/wiki/X-SAMPA)), syllables, and phonemes in different tiers in a TextGrid:

{{< figure src="screenshot.png">}}

## Web interface

The [web interface of WebMAUS](https://clarin.phonetik.uni-muenchen.de/BASWebServices/interface/WebMAUSBasic) is fairly straight-forward. All you need to do is upload a speech recording (e.g., "sentence1.wav") together with a text file with the exact same name ("sentence1.txt"). This text file should contain the words of the sentence in regular orthography. Select the language, agree to the Terms of Usage, and a few seconds later you can download the "sentence1.TextGrid".

But there's a catch! **WebMAUS Basic does not give you syllable-level annotations by default!** For this, you need a work-around. The regular process is called WebMAUS Basic: `wav + txt` >> `TextGrid` (with only words & phonemes). WebMAUS *can* give you syllables too, but only through this extra process called *Pho2Syl*. The trick is to run WebMAUS Basic and Pho2Syl in a sequence:
1. WebMAUS Basic: `wav + txt` >> `BPF .par file`
2. Pho2Syl: `BPF .par file` >> `TextGrid` (with words, syllables, phonemes)

Doing this by hand is just a hassle, even if you only have a single recording. **So let's script it!**

## Let's get set up!

- Install [Python](https://www.python.org/).
- Install the Python module `requests`:
  - Type "terminal" in the Start Menu in Windows to start Windows PowerShell
  - Paste this line and hit ENTER: ```pip install requests```
- Download [forced-alignment.py](/resources/scripts/forced-alignment.py) and store it in a separate new folder.

## Let's go!

1. Select the **language of your choice** in line 29: `webmaus_language = 'eng-US'`
    - For a list of languages supported by WebMAUS, check out the drop-down Language menu in the [web interface](https://clarin.phonetik.uni-muenchen.de/BASWebServices/interface/WebMAUSBasic).
    - NOTE: the script only accepts language codes, like "eng-US". These can be found [here](https://clarin.phonetik.uni-muenchen.de/BASWebServices/services/help) (...it's a long page of text, so search for "eng-US" to find the list of languages).
2. Select the **extension of your audio files** in line 39 (wav or mp3): `audio_extension = "wav"`
3. **Copy** all your speech recordings with accompanying text files into the same folder as the script.
    - NOTE: the script only runs on **pairs of files** with the same name, like "item3.wav" + "item3.txt".
    - The txt files should contain the words in the speech in regular orthography.
4. **Run the script!** For instance, right-click some empty space inside the folder shown in Windows Explorer, click "Open in Terminal", type: ```python forced-alignment.py``` and hit Enter.
5. **Done!**

> {{< spoiler text="*What are the four tiers in the TextGrid?*" >}}
1. **ORT-MAU:** WebMAUS words, given in orthography (pauses are left empty)
2. **KAN-MAU:** WebMAUS words, canonical form in [X-SAMPA](https://en.wikipedia.org/wiki/X-SAMPA) (pauses are empty)
3. **MAU:** WebMAUS phonemes, in [X-SAMPA](https://en.wikipedia.org/wiki/X-SAMPA) (pauses are "<p:>")
4. **MAS:** WebMAUS syllables, in [X-SAMPA](https://en.wikipedia.org/wiki/X-SAMPA) (pauses are "<p:>")

{{< /spoiler >}}

{{% callout note %}}
Looking for a quick and easy way to go through the output in Praat? [This Praat script](/resources/scripts/annotate/) can streamline your workflow: it presents a TextGrid for manual inspection to the user, allows you to perform some changes if necessary, and when you click Next, it automatically saves the changes and presents the next TextGrid, and so on.
{{% /callout %}}

{{% callout warning %}}
Last but certainly not least: using WebMAUS means you agree to their [Terms and Conditions](https://clarin.phonetik.uni-muenchen.de/BASWebServices/services/help). In summary: WebMAUS is only **free for members of an academic institution** to be used for non-profit research purposes only. Also, WebMAUS requests you **cite Kisler et al., 2017** (https://doi.org/10.1016/j.csl.2017.01.005) in any academic output.
{{% /callout %}}


*Happy aligning!*
