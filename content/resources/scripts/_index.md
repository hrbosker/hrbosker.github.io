---
title: Scripts
linkTitle: Scripts
summary: Scripts for speech synthesis, analysis, and manipulation
type: book
weight: 30

# display table-of-contents for this particular page on the right-hand side?
toc: true

date: '2022-07-07'

#tags:
#  - previous
---

<!-- {{< figure src="featured.jpg" >}} -->

{{< toc hide_on="xl" >}}

{{% callout note %}}
The scripts shared here are first and foremost intended as a **lab archive**, providing script snippets we frequently use. This means **they require customization** for each individual new project. *Use at your own risk!*
{{% /callout %}}

## Praat

Many (but not all!) of the scripts shared here are for use in [Praat](https://www.fon.hum.uva.nl/praat/), the most commonly used software package for phonetic research. Over the years, Praat has had three types of syntax:
- `Extract part... 0 0.1 rectangular 1 no` *(Praat versions 5.3.43 and older; before April 2013)*
- `do("Extract part", 0, 0.1, "rectangular", 1, "no")` *(between 5.3.44 and 5.3.62; April 2013 - January 2014)*
- `Extract part: 0, 0.1, "rectangular, 1, "no"` *(5.3.63 and after; after January 2014)*

Current Praat versions are compatible with older and newer syntax types, and mixes thereof. The Praat scripts shared here primarily use the first type of syntax (...shows my age), with occasional lines using the latest type of syntax. **[ADVERTISEMENT:]** *Did you know the syntax highlighting in [PraatVSCode](../tools/#praatvscode) works with either syntax?*

<br />

## List of available scripts

{{< list_children >}}

<br />

## Helpful links

*Not finding what you were looking for?* There are thousands of other Praat scripts available online. Some resources with particularly useful code are:
- [Vocal Toolkit plugin](http://www.praatvocaltoolkit.com/) is a plugin for Praat. When installed, you can call various new functions from a button within Praat. However, it's a little risky if you don't know the ins-and-outs of a particular function, so **always check the raw code** here:
  - [WINDOWS] "C:\Users\\*(Username)*\Praat\plugin_VocalToolkit"
  - [MAC] "/Users/*(UserName)*/Library/Preferences/Praat Prefs/"
- [Matt Winn's Listen Lab](http://www.mattwinn.com/praat.html) with some really fun [Youtube Praat tutorials](https://www.youtube.com/playlist?list=PL6niCBwOhjHga4bCS83VJ2uKzQ8ZjEVeG)
- [Holger Mitterer's website](http://holgermitterer.eu/research.html)
- [Will Styler's repo](https://github.com/stylerw/styler_praat_scripts)
- [Christopher Carignan's formant optimization script](https://github.com/ChristopherCarignan/formant-optimization)

## License

{{< icon name="creative-commons" pack="fab" >}} All scripts are shared under an [MIT license](https://en.wikipedia.org/wiki/MIT_License#License_terms).

*2023, Hans Rutger Bosker*
