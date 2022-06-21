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
- {{< icon name="waveform" pack="fab" >}} **Praat**
  - [praat.org](https://www.praat.org)
  - the *number 1* speech-editing software in academia
  - supports speech measurements, annotation in TextGrids, manipulation, synthesis
  - scripting interface supports batch processing
  - recommended scripting interface: [PraatVSCode]({{< ref "../tools/#praatvscode" >}})
- {{< icon name="waveform" pack="fas" >}} **ffmpeg**
  - [ffmpeg.org](https://ffmpeg.org/)
  - a command line tool for batch video processing
  - 'lives' in the terminal (e.g., command prompt)
  - Adobe Premiere Pro is a great video-editor when working on individual files, but is not the best solution for batch processing. ffmpeg is great at efficiently and quickly extracting the audio channels from a large set of video files, converting mpg to mp4, manipulating audio/video temporal alignment (asynchrony), etc.
- {{< icon name="waveform-lines" pack="fas" >}} **WebMAUS**
  - [https://clarin.phonetik.uni-muenchen.de/BASWebServices/interface/WebMAUSBasic](https://clarin.phonetik.uni-muenchen.de/BASWebServices/interface/WebMAUSBasic)
  - forced-alignment tool taking wav files and txt files with orthographic transcripts as input, providing TextGrids as output
  - 'lives' online: you upload wav and txt files and download TextGrids
  - large set of languages available
  - annotations at word-level and at phone-level (not syllable-level)
- {{< icon name="waveform-lines" pack="fas" >}} **EasyAlign**
  - [http://latlcui.unige.ch/phonetique/easyalign.php](http://latlcui.unige.ch/phonetique/easyalign.php)
  - forced-alignment tool taking wav files and txt files with orthographic transcripts as input, providing TextGrids as output
  - 'lives' in Praat (plugin)
  - French, English, Spanish, Brazilian Portuegese, Taiwan Min
  - annotations at word-level, syllable-level and phone-level

## Corpora
- {{< icon name="album-collection" pack="fab" >}} **Multipic**
- {{< icon name="album-collection" pack="fas" >}} **Subtlex**
- {{< icon name="album-collection" pack="fas" >}} **ANW**
- {{< icon name="album-collection" pack="fas" >}} **Severens**
- {{< icon name="album-collection" pack="fas" >}} **Lombard speech corpora from B2018**
- {{< icon name="album-collection" pack="fas" >}} **Lombard speech corpus Shen**
- {{< icon name="album-collection" pack="fas" >}} **Lombard speech corpus Marcoux**

## Writing
<!-- alternative icon: file-pen -->
- {{< icon name="typewriter" pack="fab" >}} **Thesaurus**
- {{< icon name="typewriter" pack="fas" >}} **Zotero**
- {{< icon name="typewriter" pack="fas" >}} **Overleaf**

## Online experimenting
- {{< icon name="microscope" pack="fas" >}} **Gorilla**
- {{< icon name="microscope" pack="fas" >}} **PsyToolkit**
- {{< icon name="microscope" pack="fas" >}} Testable, FindingFive less suitable

## Mailing lists
- {{< icon name="at" pack="fas" >}} **amlap**
- {{< icon name="at" pack="fas" >}} **sentproc**
- {{< icon name="at" pack="fas" >}} **prosig**
- {{< icon name="at" pack="fas" >}} **LOT**
