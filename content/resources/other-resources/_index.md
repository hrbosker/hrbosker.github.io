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
- {{< icon name="file-audio" pack="fab" >}} **Praat**
  - [praat.org](https://www.praat.org)
  - the *number 1* speech-editing software in academia
  - supports speech measurements, annotation in TextGrids, manipulation, synthesis
  - scripting interface supports batch processing
  - recommended scripting interface: [PraatVSCode]({{< ref "../tools/#praatvscode" >}})
- {{< icon name="file-audio" pack="fas" >}} **ffmpeg**
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
- {{< icon name="play" pack="fas" >}} **Other**
- {{< icon name="play" pack="fab" >}} **Other**
- {{< icon name="file-music" pack="fas" >}} **Other**
- {{< icon name="file-music" pack="fab" >}} **Other**
- {{< icon name="microphone" pack="fas" >}} **Other**
- {{< icon name="microphone" pack="fab" >}} **Other**
- {{< icon name="photo-film-music" pack="fas" >}} **Other**
- {{< icon name="photo-film-music" pack="fab" >}} **Other**
- {{< icon name="square-sliders-vertical" pack="fas" >}} **Other**
- {{< icon name="square-sliders-vertical" pack="fab" >}} **Other**
- {{< icon name="sliders-up" pack="fas" >}} **Other**
- {{< icon name="sliders-up" pack="fab" >}} **Other**

## Corpora
- {{< icon name="box-archive" pack="fab" >}} **MultiPic**
  - [https://www.bcbl.eu/databases/multipic/](https://www.bcbl.eu/databases/multipic/)
  - standardized set of 750 drawings with multilingual name agreement and visual complexity norms
  - in color; 300 x 300 pixels; DPI=96 pixels/inch
  - Spanish, English (British), German, Italian, French, Dutch (Belgium), Dutch (Netherlands)
  - also useful when looking for 'imageable' words
- {{< icon name="box-archive" pack="fas" >}} **SUBTLEX**
  - [http://crr.ugent.be/programs-data/subtitle-frequencies/subtlex-nl](http://crr.ugent.be/programs-data/subtitle-frequencies/subtlex-nl)
  - database of Dutch word frequencies based on 44 million words from film and television subtitles
  - also available for [other languages](http://crr.ugent.be/programs-data/subtitle-frequencies), including US English (SUBTLEX-US), UK English (SUBTLEX-UK), Mandarin Chinese (SUBTLEX-CH), Spanish (SUBTLEX-ESP), German (SUBTLEX-DE), Greek (SUBTLEX-GR), Polish (SUBTLEX-PL), Italian (SUBTLEX-IT), Brazilian Portuguese (SUBTLEX-PT-BR)
  - reliable predictor of lexical decision reaction times, outperforming Google Books Ngram=1 ([Brysbaert et al., 2011](https://www.frontiersin.org/articles/10.3389/fpsyg.2011.00027/full))
- {{< icon name="box-open" pack="fas" >}} **ANW**
- {{< icon name="box-open" pack="fab" >}} **Severens**
- {{< icon name="file-zipper" pack="fas" >}} **Lombard speech corpora from B2018**
- {{< icon name="file-zipper" pack="fab" >}} **Lombard speech corpus Shen**
- {{< icon name="cabinet-filing" pack="fas" >}} **Lombard speech corpus Marcoux**
- {{< icon name="cabinet-filing" pack="fab" >}} **Other**

## Writing
- {{< icon name="keyboard" pack="fab" >}} **Thesaurus**
- {{< icon name="keyboard" pack="fas" >}} **Zotero**
- {{< icon name="comment-pen" pack="fas" >}} **Overleaf**
- {{< icon name="comment-pen" pack="fab" >}} **Other**
- {{< icon name="pen" pack="fas" >}} **Other**
- {{< icon name="pen" pack="fab" >}} **Other**
- {{< icon name="memo" pack="fas" >}} **Other**
- {{< icon name="memo" pack="fab" >}} **Other**

## Online experimenting
- {{< icon name="microscope" pack="fas" >}} **Gorilla**
- {{< icon name="microscope" pack="fas" >}} **PsyToolkit**
- {{< icon name="microscope" pack="fas" >}} Testable, FindingFive less suitable

## Mailing lists
- {{< icon name="at" pack="fas" >}} **amlap**
- {{< icon name="at" pack="fas" >}} **sentproc**
- {{< icon name="at" pack="fas" >}} **prosig**
- {{< icon name="at" pack="fas" >}} **LOT**
