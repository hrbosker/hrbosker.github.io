---
title: ...generate speech
type: book
weight: 15
#date: '2021-01-01'
---

{{% callout note %}}
This shows you how to generate speech (speech synthesis) using text-to-speech from **Elevenlabs**. We'll take a list of prompts as input and generate individual .mp3 files for each prompt. We'll also automatically perform forced-alignment on the output speech using **WebMAUS**, giving you accompanying TextGrid files with word-level, syllable-level, and phoneme-level annotations.
{{% /callout %}}

{{< figure src="screenshot.gif" width="500">}}

## Why generate (and not record) speech?

Researchers in the field of speech perception usually play participants pre-recorded speech stimuli in their experiments. But as you've seen in our [how-to-record-speech](/resources/how-to/record-speech), it can be tough to make high-quality human speech recordings. Not only do you need to find a volunteer speaker, you also need to have the right equipment, a quiet recording room, and lots of patience. And then you end up with this hour-long audio file but what you actually need is separate audio files for 'sentence 1', 'sentence 2', 'sentence 3', etc. So you spend hours of extracting smaller chunks from this hour-long audio-file. Imagine only then finding out some words were mispronounced but your speaker has since then moved to another country...

Generating artificial speech is free, quick, clean, and flexible. Your 'speaker' never gets tired, is always available, always sounds the same even years later, and never has a cold on the day of the recordings. With our script, you get individual stimuli files with accompanying word, syllable, and phoneme level annotations.

Of course, there are downsides too: it's hard to control the acoustic specs of the generated audio (pitch, intensity, duration, emotion, ...) and some text-to-speech (TTS) systems simply sound robotic. But if you're looking for a quick way to record some simple word or sentence stimuli, it is a big time saver.

## Elevenlabs

{{< figure src="elevenlabs.gif" width="200">}}

[Elevenlabs](https://elevenlabs.io/) is an AI audio platform that can generate fairly realistic and contextually-aware speech, voices, and sound effects across **32 languages**. It takes orthographic words and sentences as input but can also generate speech based on **[IPA](https://www.internationalphoneticalphabet.org) and [CMU Arpabet](http://www.speech.cs.cmu.edu/cgi-bin/cmudict)** (see [the last section](#really-that-simple) below). The **free tier gives you 10,000 characters** of TTS per month, which is about 10 min of speech. This may not sound like a lot, but assuming an average sentence has 8 words, consisting of ca. 6 characters each, then you can generate around 180 sentence stimuli per month. And you get 50% discount (20,000 characters = around 360 sentences!) if you use their Turbo models that are quicker but slightly less quality (but not particularly noticably so, in my experience). But don't take my word for it, listen to these examples:

> Aria: *"She sells sea shells by the sea shore."* {{< audio src="ElevenLabs_2024-11-13T20_07_10_Aria_pre_s50_sb74_se0_b_m2.mp3" >}}

> Aria: *"She shouted: she sells sea shells by the sea shore!"* {{< audio src="ElevenLabs_2024-11-13T20_07_38_Aria_pre_s50_sb74_se0_b_m2.mp3" >}}

> Daniel: *"object"* {{< audio src="ElevenLabs_2024-11-13T21_14_34_Daniel_pre_s38_sb75_t2_isol.mp3" >}}

> Daniel: [CMU Arpabet] "AA0 B JH EH1 K T" (with final stress) {{< audio src="ElevenLabs_2024-11-13T21_14_13_Daniel_pre_s38_sb75_t2_01.mp3" >}}

> Daniel: [CMU Arpabet] "AA1 B JH EH0 K T" (with initial stress) {{< audio src="ElevenLabs_2024-11-13T21_14_23_Daniel_pre_s38_sb75_t2_10.mp3" >}}

> Will: note the breaths inside these sentences... {{< audio src="ElevenLabs_2024-11-13T21_19_11_Will_pre_s50_sb75_se0_b_m2.mp3" >}}

Still, there are of course relevant alternatives to consider too. I selected Elevenlabs here because other TTS systems are either paid (e.g., Amazon Polly stops being free after 12 months after sign-up) or of lower-quality in my experience (Microsoft, Google). One important disadvantage of Elevenlabs, however, is the lack of [Speech Synthesis Markup Language](https://www.w3.org/TR/speech-synthesis11/) (SSML) support, meaning it's hard to control the prosodic specs of the speech (for some suggestions, see [the last section](#really-that-simple) below). But if you're looking for some off-the-shelf speech, it's a great tool.

## WebMAUS

If you just want to generate some speech, you can simply use Elevenlabs' web interface. However, we often don't only need the speech, we also need to know **when in time each word, syllable, and phoneme was produced**. These kinds of data are called 'timestamps' or 'speech marks' in the TTS field, and annotations or segmentations by the phonetics crowd. Elevenlabs can actually give you timestamps that go with the speech it generated, but it only provides timestamps of each character (not words, syllables, or phonemes). Timestamps of characters often don't make any sense (*...what's the timestamp of -g in the word "thought"?*) and even in words where they do (the word "test"), they're actually not terribly accurate. Moreover, many phoneticians would like to see these kinds of data in TextGrid format to be used and analyzed in [Praat](https://www.fon.hum.uva.nl/praat/).

This is where [WebMAUS](https://clarin.phonetik.uni-muenchen.de/BASWebServices/interface/WebMAUSBasic) comes in. It's a forced-alignment tool that takes a speech file as input together with its orthographic transcription and returns a TextGrid with word, syllable, and phoneme annotations. The script provided here automatically feeds the speech from Elevenlabs to WebMAUS so that at the end you are left with speech *and* TextGrid data.

## OK, how do I get set up?

- Set up a free account in [Elevenlabs](https://elevenlabs.io/).
- Set up your personal API key for Elevenlabs. This is a long string of characters that allows the script to 'log in' to Elevenlabs.
  - Once you're logged into the Elevenlabs web app, go to your profile's menu in the bottom-left corner.
  - Click on "API Keys" and then "Create API Key"
  - Give your personal API key a (random) name; it's not particularly important...
  - ...and click "Create"
  - Your personal API key will be shown **once and only once!**
  - **Make sure to copy it immediately** and store it somewhere safe.
  - Anyone who has this API key can log into your Elevenlabs account, so **don't share it!**
- Install [Python](https://www.python.org/).
- Download our Python script [generate-speech.py](/resources/scripts/generate-speech.py)
- Install particular Python modules the script relies on.
  - Type "terminal" in the Start Menu in Windows to start Windows PowerShell
  - Paste this line and hit ENTER: ```pip install requests tgt pandas openpyxl```

## Let's go!

- Create a new folder where you store the [generate-speech.py](/resources/scripts/generate-speech.py) script.
- In the same folder, create an Excel file called **"input.xlsx"**. In this Excel file, create two columns: one with the name "filename" (in cell A1) and the other with the name "prompt" (in cell B1).
- Enter a list of filenames in A2, A3, A4, and so on. Example: item1_b, item1_p, item2_b, item2_p...
- Enter your prompts in B2, B3, B4, etc. Example: bear, pear, bull, pull...
- **Run the script!** For instance, right-click some empty space inside the script's folder shown in Windows Explorer, click "Open in Terminal", type: ```python generate-speech.py``` and hit Enter.
- Done!

> {{< spoiler text="*What are the five tiers in the TextGrid?*" >}}
1. **Characters:** Elevenlabs timestamps for each character in the prompt (inaccurate and nonsensical)
2. **ORT-MAU:** WebMAUS words, given in orthography (pauses are left empty)
3. **KAN-MAU:** WebMAUS words, canonical form in [X-SAMPA](https://en.wikipedia.org/wiki/X-SAMPA) (pauses are empty)
4. **MAU:** WebMAUS phonemes, in [X-SAMPA](https://en.wikipedia.org/wiki/X-SAMPA) (pauses are "<p:>")
5. **MAS:** WebMAUS syllables, in [X-SAMPA](https://en.wikipedia.org/wiki/X-SAMPA) (pauses are "<p:>")

{{< /spoiler >}}

## Really? That simple?

Well... yeah! But there's a zillion different specs and parameters you can tweak, if you like. The most relevant ones are **Elevenlabs models and settings, Elevenlabs voices, prompt specs, and WebMAUS parameters**.

### Models and settings

At present (Nov 2024), Elevenlabs offers two families of [models](elevenlabs.io/docs/product/speech-synthesis/overview#models): Standard (high-quality) models and Turbo models, which are optimized for low latency and cost 50% less credits. Only "Eleven English V1" and "Eleven Turbo V2" support [IPA](https://www.internationalphoneticalphabet.org) and [CMU Arpabet](http://www.speech.cs.cmu.edu/cgi-bin/cmudict). Select the model of your choice by changing line 140 in [generate-speech.py](/resources/scripts/generate-speech.py): ``` "model_id": "eleven_turbo_v2" ```

There's also some general [voice settings](https://elevenlabs.io/docs/product/speech-synthesis/overview#settings) you can tweak, but it's not entirely clear what they do. Note that Elevenlabs' AI is non-deterministic; even the exact same input and settings does not guarantee the exact same result every time. The default values recommended by Elevenlabs are used in the script:
```py
"voice_settings": {
            "stability": 0.5,
            "similarity_boost": 0.75,
            "style": 0.0,
            "use_speaker_boost": True
        }
```
### Voices

There's a large number of voices to choose from, covering 32 languages. Note that **Elevenlabs does not have a language setting**. The voice you select decides which language is spoken. The easiest way to explore voices is to log into Elevenlabs' web interface, go to Speech Synthesis: Text-to-Speech, and try out different voices. Listen to demo clips for each voice (free!) or simply type a word into the text box and press "generate" to listen to it in a particular voice. This will also automatically list this voice under your My Voices library, which you need if you want to use the voice inside a script. Please note that **each time you press "generate" anywhere on the website, it will deduct credits from your monthly quota**.

To select a voice in the script, you need the speaker's voice ID. This is a string of characters, like "9BWtsMINqrJLrRacOk9x" for the voice Aria. Replace this string in line 35 of the script with the voice ID of another speaker to change the voice. You can find the voice ID of a given speaker in your My Voices library in Elevenlabs' web interface or by running a short script: see [these instructions](https://help.elevenlabs.io/hc/en-us/articles/14599760033937-How-do-I-find-my-voices-ID-of-my-voices-via-the-website-and-through-the-API).

### Prompting

Elevenlabs AI **does not support SSML** ([Speech Synthesis Markup Language](https://www.w3.org/TR/speech-synthesis11/)). Instead, it infers much of the prosody from the context of your input prompts. It will generate a question intonation for a prompt ending in a "?" and will sound more assertive when using "!". It will also try its best to take the larger context into account to generate emotional prosody, like irony. However, the AI is non-deterministic and there's no guarantee it will do what you want it to do, even when re-using the exact same prompt.

There are a few explicit ways to guide the AI's output. You can, for intance, control the pauses and hesitations by entering "..." to your prompts or through explicit breaks:

``
"Give me a sec." <break time="1.0s" /> "OK, all good!"
``

You can also use [IPA](https://www.internationalphoneticalphabet.org) and [CMU Arpabet](http://www.speech.cs.cmu.edu/cgi-bin/cmudict) as input prompts, like ``AA1 B JH EH0 K T`` for *OBject* (noun, initial stress) and ``AA0 B JH EH1 K T`` for *obJECT* (verb, final stress). However, this is only supported by the models “Eleven English V1” and “Eleven Turbo V2”.

A strength of Elevenlabs is its contextual sensitivity. In the examples above, you can hear that adding "She shouted..." to a prompt actually makes the speaker 'speak up'. Likewise, adding "...he said, confused" or "...he replied angrily" will lead to audible changes in the output speech. Still, it's hard to control this behavior and it has its limits (e.g., "...he whispered" doesn't work).

For a complete overview, see [this page](https://elevenlabs.io/docs/product/speech-synthesis/prompting). Note also that adding explicit breaks or IPA inside the prompt may throw WebMAUS off, because the prompts also form the input to the forced-alignment.

### WebMAUS parameters

The most important parameter for using WebMAUS is **which language model** you'd like to use. You can see a list of languages supported by WebMAUS by inspecting the drop-down Language menu in their [web interface](https://clarin.phonetik.uni-muenchen.de/BASWebServices/interface/WebMAUSBasic). The script only accepts language codes, like "eng-US". These can be found [here](https://clarin.phonetik.uni-muenchen.de/BASWebServices/services/help) but it's a long page of text so search for "eng-US" to find the list. The parameter can then be set in the script under the WebMAUS parameters in lines 48-57.

{{% callout note %}}
Looking for a quick and easy way to go through the output in Praat? [This Praat script](/resources/scripts/annotate/) can streamline your workflow: it presents a speech recording with accompanying TextGrid for manual inspection to the user, let's you play it or perform some changes if necessary, and when you click Next, it automatically saves the changes and presents the next recording, and so on.
{{% /callout %}}

{{% callout warning %}}
Last but certainly not least: using Elevenlabs and WebMAUS means you agree to their Terms and Conditions, see [here](https://elevenlabs.io/terms-of-use) and [here](https://clarin.phonetik.uni-muenchen.de/BASWebServices/services/help). In summary: Elevenlabs' free tier allows you to use the content **non-commercially with attribution** and WebMAUS is only **free for members of an academic institution** to be used for non-profit research purposes only. Also, WebMAUS requests you **cite Kisler et al., 2017** (https://doi.org/10.1016/j.csl.2017.01.005) in any academic output.
{{% /callout %}}

*Happy synthesizing!*
