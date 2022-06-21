---
title: Scripts
linkTitle: Scripts
summary: Open Praat scripts for speech analysis, manipulation, and synthesis
type: book
weight: 30

# display table-of-contents for this particular page on the right-hand side?
toc: true

#date: '2021-01-24'
#tags:
#  - previous
---

{{< figure src="featured.jpg" >}}

{{< toc hide_on="xl" >}}

## Scripting in Praat

Over the years, Praat has had three types of syntax:
- `Extract part... 0 0.1 rectangular 1 no` *(before Praat 5.3.44, Apr 2013)*
- `do("Extract part", 0, 0.1, "rectangular", 1, "no")` *(before Praat 5.3.63, Jan 2014)*
- `Extract part: 0, 0.1, "rectangular, 1, "no"` *(current)*

Current Praat versions are compatible with older and newer syntax types, and mixes thereof. The scripts shared here primarily use the first type of syntax, with occasional lines using the latest type of syntax.

{{% callout note %}}
The Praat scripts shared here are first and foremost intended as a **lab archive**, providing script templates for functions we frequently use. This means **they require customization** for each individual new project. *Use at your own risk!*
{{% /callout %}}

*Not finding what you were looking for?* There are various other webpages with really useful Praat scripts available online. Three particularly useful ones are:
- [Vocal Toolkit plugin](http://www.praatvocaltoolkit.com/) is a plugin for Praat. When installed, its scripts 'live' here: [WINDOWS] "C:\Users\\*(Username)*\Praat\plugin_VocalToolkit", or [MAC] "/Users/*(UserName)*/Library/Preferences/Praat Prefs/"
- [Matt Winn's Listen Lab](http://www.mattwinn.com/praat.html) with some really fun [Youtube Praat tutorials](https://www.youtube.com/playlist?list=PL6niCBwOhjHga4bCS83VJ2uKzQ8ZjEVeG)
- [Holger Mitterer's website](http://holgermitterer.eu/research.html)

## List of available scripts

{{< list_children >}}

## License

Copyright (c) 2022, Hans Rutger Bosker

{{< icon name="creative-commons" pack="fab" >}} All scripts are shared under an [MIT license](https://en.wikipedia.org/wiki/MIT_License#License_terms).
