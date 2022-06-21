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
- {{< icon name="circle-play" pack="fas" >}} **MediaPipe**
  - [mediapipe.dev](https://mediapipe.dev/)
  - 2D video motion-tracking tool in Python, developed by Google
  - input: video file of a single person ([OpenPose](https://cmu-perceptual-computing-lab.github.io/openpose/web/html/doc/) is preferred for multi-person tracking).
  - output: x, y, (estimated) z coordinates of body landsmarks + video with superimposed tracking skeleton.
  - here's a great tutorial by Wim Pouw and James Trujillo at [Envision Bootcamp](https://wimpouw.github.io/EnvisionBootcamp2021/).
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
- {{< icon name="box-archive" pack="fas" >}} **Severens et al.**
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
  - Dutch word list, allowing searching with regular expressions ("spraa*") and with particular word characteristics (number of syllables, stress on syllable *n*, etc.)
  - **NOTE.** I've found that the search lists are *not exhaustive*. Failure to find certain words in ANW does not necessarily mean they do not exist.
- {{< icon name="box-archive" pack="fas" >}} **Lombard speech corpora**
  - [Acted clear speech corpus](https://datashare.ed.ac.uk/handle/10283/343): English; 1 male talker; 'normal' sentences; 25 items; babble-modulated noise; Mayo et al. (2012), doi:[10.7488/ds/138](https://datashare.ed.ac.uk/handle/10283/343).
  - [Hurricane natural speech corpus](https://datashare.ed.ac.uk/handle/10283/347): English; 1 male talker; Harvard sentences (720 items) and MRT sentences (300 items); speech-modulated noise; Cooke et al. (2013), doi:[10.7488/ds/140](https://datashare.ed.ac.uk/handle/10283/347).
  - [DELNN](https://datashare.ed.ac.uk/handle/10283/3012): L1 Dutch and L2 English from 30 native speakers of Dutch (+9 native speakers of US English as control); speech-shaped noise; Marcoux (2022, PhD thesis).
  - [RaLoCo](https://zenodo.org/record/4040685): Dutch; 78 talkers; 48 sentences; speech-shaped noise; Shen (2022, PhD thesis). [Additional info](https://zenodo.org/record/5645385), including human listening effort ratings and HEGP scores (spectral glimpsing metric of intelligibility).
  - Also see our very own [NiCLS corpus of Lombard speech](../corpora/#nicls).

## Writing tools
- {{< icon name="pen" pack="fas" >}} **Thesaurus**
  - [thesaurus.com](https://www.thesaurus.com/) for looking up synonyms
  - [indispensable](https://www.thesaurus.com/browse/indispensable) [gizmo](https://www.thesaurus.com/browse/gizmo) when [scribbling](https://www.thesaurus.com/browse/scribbling) [palimpsests](https://www.thesaurus.com/browse/palimpsest), particularly useful for L2 writers of English like myself
  - also gives antonyms, example sentences, and related words
  - links to definitions at [dictionary.com](https://www.dictionary.com/)
- {{< icon name="pen" pack="fas" >}} **Zotero**
  - [zotero.org](https://www.zotero.org/) reference manager
  - use the Zotero Connector in your browser to store a paper, including fulltext and all bibliographic specs
  - use the Zotero Word Plugin to cite papers in a Word document, automatically generating a bibliography at the end of the document
  - easily change bibliography styles (from author-year in APA to numbered-lists in IEEE)
  - supports open fulltext search, notes and tags, organize in folders, etc.
  - preferred over other reference managers because Zotero is institute-independent, free, open-source, and very flexible.
- {{< icon name="pen" pack="fas" >}} **Overleaf**
  - [Overleaf Online LaTeX editor](https://www.overleaf.com/)
  - it's like Google Docs but then in LaTeX
  - collaborative writing, commenting, track changes

## Online experimenting
- {{< icon name="microscope" pack="fas" >}} **Prolific**
  - [Prolific online participant pool](https://www.prolific.co)
  - [representative human sample](https://www.prolific.co/#audience), supporting very precise in/exclusion criteria (gender, language, speech disorders, etc.)
  - very fast: data collection typically a matter of days, first participant a matter of hours
- {{< icon name="microscope" pack="fas" >}} **Gorilla**
  - [Gorilla Experiment Builder](https://gorilla.sc/)
  - {{< icon name="circle-plus" pack="fas" >}} graphical interface so easy to use, no scripting or code, supports video stimuli, reliable audiovisual synchrony, [headphone screening tests](../tools/#headphone-screening-tests), great support, validated reaction times, build for free
  - {{< icon name="circle-minus" pack="fas" >}} graphical interface is less efficient for tweaking and copy-pasting (compared to code, so prepare for lots of clicking...), pay for data collection per participant (paid tokens), some institutes including RU and MPI have institution licenses ('free' tokens) but many do not, whether you can use Gorilla depends to a large extent on what institute you're at.
- {{< icon name="microscope" pack="fas" >}} **PsyToolkit**
  - [psytoolkit.org](https://www.psytoolkit.org/)
  - {{< icon name="circle-plus" pack="fas" >}} free to build, free to run, code-based so efficient, works well with audio stimuli, extensive documentation and how-to's, [headphone screening tests](../tools/#headphone-screening-tests), institute-independent
  - {{< icon name="circle-minus" pack="fas" >}} code-based so steep learning curve, not great with audiovisual stimuli, little support
- {{< icon name="microscope" pack="fas" >}} I have also used **FindingFive** (used to be free, now paid) and **Testable** (paid but free tokens for new users, has its own online participant pool) but I prefer the tools above.

## Mailing lists
*Did you know there was life before Twitter?* In those days, people shared conference announcements, job opportunities, and new research tools with each other by means of mailing lists. And what's more: did you know they still exist? Sign up and receive daily/weekly emails with announcements from your peers.
- {{< icon name="at" pack="fas" >}} **amlap-list**
  - [http://www.amlap.org/amlap-list.html](http://www.amlap.org/amlap-list.html)
  - mostly EU-focused
  - associated with the annual AMLAP conference (Architectures and Mechanisms for Language Processing)
- {{< icon name="at" pack="fas" >}} **sentproc**
  - [https://lists.qc.cuny.edu/mailman/listinfo/sentproc](https://lists.qc.cuny.edu/mailman/listinfo/sentproc)
  - mostly US-focused
  - associated with the annual HSP conference (Human Sentence Processing; what used to be CUNY in the olden days)
- {{< icon name="at" pack="fas" >}} **sprosig**
  - [Speech Prosody Special Interest Group](http://sprosig.org/index.html)
  - international
  - associated with the biannual Speech Prosody conference
- {{< icon name="at" pack="fas" >}} **LOT**
  - [Landelijke Onderzoekschool Taalwetenschap](https://lotschool.nl/)
  - not really a mailing list (phony!) but a weekly newsletter by and for the Dutch linguistics community
  - associated with the Netherlands National Graduate School of Linguistics that publishes almost every PhD thesis in the field of Linguistics in the Netherlands (except for Donders and MPI theses)
