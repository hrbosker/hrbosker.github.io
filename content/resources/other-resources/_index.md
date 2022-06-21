---
title: Other resources
linkTitle: Other resources
summary: Open research resources that others have shared and we frequently use.
type: book
weight: 50

# display table-of-contents for this particular page on the right-hand side?
toc: true

#date: '2021-01-24'
#tags:
#  - previous
---

{{< figure src="featured.jpg" >}}

{{< toc hide_on="xl" >}}

## Video/audio editing
- {{< icon name="circle-play" pack="fas" >}} **Praat**
  - [praat.org](https://www.praat.org)
  - the *number 1* speech-editing software in academia
  - supports speech measurements, annotation in TextGrids, manipulation, synthesis
  - scripting interface supports batch processing
  - recommended scripting interface: [PraatVSCode]({{< ref "../tools/#praatvscode" >}})
- {{< icon name="circle-play" pack="fas" >}} **ffmpeg**
  - [ffmpeg.org](https://ffmpeg.org/)
  - a command line tool for batch video processing
  - 'lives' in the terminal (e.g., command prompt)
  - Adobe Premiere Pro is a great video-editor when working on individual files, but is not the best solution for batch processing. ffmpeg is great at efficiently and quickly extracting the audio channels from a large set of video files, converting mpg to mp4, manipulating audio/video temporal alignment (asynchrony), etc.
- {{< icon name="circle-play" pack="fas" >}} **WebMAUS**
  - [https://clarin.phonetik.uni-muenchen.de/BASWebServices/interface/WebMAUSBasic](https://clarin.phonetik.uni-muenchen.de/BASWebServices/interface/WebMAUSBasic)
  - forced-alignment tool taking wav files and txt files with orthographic transcripts as input, providing TextGrids as output
  - 'lives' online: you upload wav and txt files and download TextGrids
  - large set of languages available
  - annotations at word-level and at phone-level (not syllable-level)
- {{< icon name="circle-play" pack="fas" >}} **EasyAlign**
  - [http://latlcui.unige.ch/phonetique/easyalign.php](http://latlcui.unige.ch/phonetique/easyalign.php)
  - forced-alignment tool taking wav files and txt files with orthographic transcripts as input, providing TextGrids as output
  - 'lives' in Praat (plugin)
  - French, English, Spanish, Brazilian Portuguese, Taiwan Min
  - annotations at word-level, syllable-level and phone-level

## Corpora
- {{< icon name="box-archive" pack="fas" >}} **MultiPic**
  - [https://www.bcbl.eu/databases/multipic/](https://www.bcbl.eu/databases/multipic/)
  - standardized set of 750 drawings with multilingual name agreement and visual complexity norms
  - in color; 300 x 300 pixels; DPI=96 pixels/inch
  - Spanish, English (British), German, Italian, French, Dutch (Belgium), Dutch (Netherlands)
  - also useful when looking for 'imageable' words
- {{< icon name="box-archive" pack="fas" >}} **Severens**
  - [https://www.ugent.be/pp/experimentele-psychologie/en/research/documents/pnn/overview.htm](https://www.ugent.be/pp/experimentele-psychologie/en/research/documents/pnn/overview.htm)
  - timed naming norms for 590 pictures in Belgian Dutch
  - black-and-white line drawings
  - name agreement, freq, aoa, h-statistic, naming latencies
- {{< icon name="box-archive" pack="fas" >}} **SUBTLEX**
  - [http://crr.ugent.be/programs-data/subtitle-frequencies/subtlex-nl](http://crr.ugent.be/programs-data/subtitle-frequencies/subtlex-nl)
  - database of Dutch word frequencies based on 44 million words from film and television subtitles
  - also available for [other languages](http://crr.ugent.be/programs-data/subtitle-frequencies), including US English (SUBTLEX-US), UK English (SUBTLEX-UK), Mandarin Chinese (SUBTLEX-CH), Spanish (SUBTLEX-ESP), German (SUBTLEX-DE), Greek (SUBTLEX-GR), Polish (SUBTLEX-PL), Italian (SUBTLEX-IT), Brazilian Portuguese (SUBTLEX-PT-BR)
  - reliable predictor of lexical decision reaction times, outperforming Google Books Ngram=1 ([Brysbaert et al., 2011](https://www.frontiersin.org/articles/10.3389/fpsyg.2011.00027/full))
- {{< icon name="box-archive" pack="fas" >}} **ANW**
  - [Algemeen Nederlands Woordenboek](https://anw.ivdnt.org/search?type=feature)
  - Dutch dictionary
  - allows searching with regular expressions ("spraa*")
  - allows searching for particular word characteristics (number of syllables, stress on syllable n, etc.)
  - **NOTE** The word list is *not exhaustive*. Failure to find certain words in ANW does not necessarily mean they do not exist.
- {{< icon name="box-archive" pack="fas" >}} **Lombard speech corpora**
  - [Acted clear speech corpus](https://datashare.ed.ac.uk/handle/10283/343): English; 1 male talker; 'normal' sentences; 25 items; babble-modulated noise; Mayo et al. (2012), doi:[10.7488/ds/138](https://datashare.ed.ac.uk/handle/10283/343)
  - [Hurricane natural speech corpus](https://datashare.ed.ac.uk/handle/10283/347): English; 1 male talker; Harvard sentences (720 items) and MRT sentences (300 items); speech-modulated noise; Cooke et al. (2013), doi:[10.7488/ds/140](https://datashare.ed.ac.uk/handle/10283/347)
  - [DELNN](https://datashare.ed.ac.uk/handle/10283/3012): L1 Dutch and L2 English from 30 native speakers of Dutch (+9 native speakers of US English as control); speech-shaped noise
  - [RaLoCo](https://zenodo.org/record/4040685): Dutch; 78 talkers; 48 sentences; speech-shaped noise; Shen (2022, PhD thesis). [Additional info](https://zenodo.org/record/5645385), including human listening effort ratings and HEGP scores (spectral glimpsing metric of intelligibility).
  - Also see our very own [NiCLS corpus of Lombard speech](../corpora/#nicls)

## Writing
- {{< icon name="pen" pack="fas" >}} **Thesaurus**
- {{< icon name="pen" pack="fas" >}} **Zotero**
- {{< icon name="pen" pack="fas" >}} **Overleaf**
- {{< icon name="pen" pack="fas" >}} **Other**
- {{< icon name="pen" pack="fas" >}} **Other**
- {{< icon name="pen" pack="fas" >}} **Other**
- {{< icon name="pen" pack="fas" >}} **Other**
- {{< icon name="pen" pack="fas" >}} **Other**

## Online experimenting
- {{< icon name="microscope" pack="fas" >}} **Gorilla**
- {{< icon name="microscope" pack="fas" >}} **PsyToolkit**
- {{< icon name="microscope" pack="fas" >}} Testable, FindingFive less suitable

## Mailing lists
- {{< icon name="at" pack="fas" >}} **amlap**
- {{< icon name="at" pack="fas" >}} **sentproc**
- {{< icon name="at" pack="fas" >}} **prosig**
- {{< icon name="at" pack="fas" >}} **LOT**
