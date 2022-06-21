---
title: Research tools
linkTitle: Research tools
summary: Open research tools for data collection, annotation, and analysis.
type: book
weight: 20

# display table-of-contents for this particular page on the right-hand side?
toc: true

#date: '2021-01-24'
#tags:
#  - previous
---

{{< figure src="featured.jpg" >}}

{{< toc hide_on="xl" >}}

## TSR
*Table showing example TSR scores for various responses*
{{< figure src="tokensortratio_table.jpg" >}}
> Bosker, H. R. (2021). Using fuzzy string matching for automated assessment of listener transcripts in speech intelligibility studies. *Behavior Research Methods, 53*(5), 1945-1953. doi:[10.3758/s13428-021-01542-4](https://doi.org/10.3758/s13428-021-01542-4). [［PDF］](https://pure.mpg.de/rest/items/item_3277028_4/component/file_3356415/content)
- **Token Sort Ratio**: automatically quantifying response accuracy for speech intelligiblity experiments.
- {{< icon name="user" pack="fas" >}} Author: {{< mention "admin" >}}.
- {{< icon name="link" pack="fas" >}} [https://tokensortratio.netlify.app](https://tokensortratio.netlify.app)
- {{< icon name="circle-info" pack="fas" >}} The **Token Sort Ratio [TSR]** score is a fuzzy string matching metric that – at the most basic level – quantifies the orthographic match between a target string and a response string (value between 0 = no match and 100 = perfect match). The TSR score has been shown to strongly correlate with human-generated scores of percentage words correct (Bosker, 2021). It is an efficient, reliable, and accurate tool for use in speech perception research (e.g., studies that examine the perception of speech in adverse listening conditions, or degraded speech) or for generating listener intelligibility measures in clinical disciplines such as speech-language pathology or audiology.

<br />

## PraatVSCode
<img src="https://github.com/orhunulusahin/praatvscode/blob/main/assets/syntax_after.png?raw=true" alt="PraatVSCode screenshot example" width="600"/>

- {{< icon name="user" pack="fas" >}} Author: {{< mention "orhun-ulusahin" >}}.
- {{< icon name="link" pack="fas" >}} [https://github.com/orhunulusahin/praatvscode](https://github.com/orhunulusahin/praatvscode)
- {{< icon name="circle-info" pack="fas" >}} Praat is an excellent software package for speech analysis, annotation, and manipulation. However, it's scripting interface is - let's put it this way - 'suboptimal'. PraatVSCode is an extension for Visual Studio Code (see screenshot) that provides syntax highlighting, autocompletion, and even an array of code snippets that writes itself. Moreover, it allows running and debugging of the script by Praat from inside Visual Studio Code.
- {{< icon name="download" pack="fas" >}} **How to install:**
  - Download and install [Visual Studio Code](https://code.visualstudio.com/).
  - Under *View* > *Extensions*, search for PraatVSCode, and click install.
- {{< icon name="creative-commons" pack="fab" >}} [MIT license](https://en.wikipedia.org/wiki/MIT_License#License_terms)

<br />

## POnSS
<img src="https://media.springernature.com/full/springer-static/image/art%3A10.3758%2Fs13428-020-01449-6/MediaObjects/13428_2020_1449_Fig2_HTML.png?as=webp" alt="POnSS screenshot example" width="600"/>

> Rodd. J., Decuyper, C., Bosker, H. R., & ten Bosch, L. (2021). A tool for efficient and accurate segmentation of speech data: Announcing POnSS. *Behavior Research Methods 53*, 744-756. doi:[10.3758/s13428-020-01449-6](https://doi.org/10.3758/s13428-020-01449-6). [［PDF］](https://pure.mpg.de/rest/items/item_3240668_6/component/file_3318713/content)
- **Pipeline for Online Speech Segmentation [POnSS]**
- {{< icon name="user" pack="fas" >}} Lead author: Joe Rodd.
- {{< icon name="link" pack="fas" >}} [https://git.io/Jexj3](https://git.io/Jexj3)
- {{< icon name="circle-info" pack="fas" >}} POnSS is a browser-based system that is specialized for the task of segmenting the onsets and offsets of words, that combines automatic speech recognition (WebMAUS) with limited human input.
- {{< icon name="creative-commons" pack="fab" >}} [MIT license](https://en.wikipedia.org/wiki/MIT_License#License_terms)

<br />

## Headphone screening tests
- When running experiments online, you may want your participants to use headphones or in-ear buds (i.e., no speakers). Moreover, you may want to verify that they are wearing them 'the right way around': [L] in their left ear, [R] in their right ear. This is particularly important when testing multitalker listening conditions and/or virtual auditory environments. Several tools exist to verify whether participants are using headphones (as instructed) or not (exclude 'm!), based on different psychoacoustic binaural phenomena. We have implemented these on *Gorilla* and *PsyToolkit*.
- **Tone attenuation based on phase-cancellation**
  > Woods, K. J. P., Siegel, M. H., Traer, J., & McDermott, J. H. (2017). Headphone screening to facilitate web-based auditory experiments. *Attention, Perception, & Psychophysics, 79*(7), 2064–2072. doi:[10.3758/s13414-017-1361-2](https://doi.org/10.3758/s13414-017-1361-2)
  - General idea: binaural tones are played and participants are asked to indicate which tone out of three is quietest. Some binaural tones are played 180° out-of-phase, attenuating perceived loudness if using speakers, but not when using headphones/in-ear buds.
  - 3min test, shared by authors on [Github](https://github.com/mcdermottLab/HeadphoneCheck)
  - We have implemented this headphone screening test on *Gorilla* and *PsyToolkit*. Send us [an email]({{< ref "contact/index.md" >}}) and we'd be happy to share!
- **Huggins Pitch illusion**
  > Milne, A. E., Bianco, R., Poole, K. C., Zhao, S., Oxenham, A. J., Billig, A. J., & Chait, M. (2021). An online headphone screening test based on dichotic pitch. *Behavior Research Methods, 53*(4), 1551–1562. doi:[10.3758/s13428-020-01514-0](https://doi.org/10.3758/s13428-020-01514-0)
  - General idea: participants are played white noise in one ear and the same white noise but with a phase shift of 180° over a narrow frequency band to the other ear. This results in the perception of a faint tone embedded in the noise but only when using headphones/in-ear buds. Otherwise, listeners only perceive white noise (i.e., without the faint embedded tone).
  - 3min test, shared by authors on [Gorilla](https://app.gorilla.sc/openmaterials/100917)
  - We have also implemented this headphone screening test on *PsyToolkit*. Send us [an email]({{< ref "contact/index.md" >}}) and we'd be happy to share!
- **ITD and ILD manipulations**
  - General idea: participants are played six trials of three binaural white noise sounds. Interaural time differences (ITDs) and interaural level differences (ILDs) are applied to the L/R channels of the stereo stimuli such that two noise sounds are perceived as coming from the left, and one as coming from the right. Participants indicate which out of the three white noise sounds comes from the right, which is easily perceived when using headphones/in-ear buds and only when wearing them 'the right way around': [L] in left ear, [R] in right ear.
  - 3min test, implemented on *Gorilla* and *PsyToolkit*. Send us [an email]({{< ref "contact/index.md" >}}) and we'd be happy to share!

