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
- `Extract part... 0 0.1 rectangular 1 no` (before Praat 5.3.44, Apr 2013)
- `do("Extract part", 0, 0.1, "rectangular", 1, "no")` (before Praat 5.3.63, Jan 2014)
- `Extract part: 0, 0.1, "rectangular, 1, "no"` (*current*)

Current Praat versions are fully compatible with older and newer syntax types. The scripts shared here primarily use the first type of syntax, with occasional lines using the latest type of syntax.

```
this is a block of code
and a second line
```

*Not finding what you were looking for?* There are various other webpages with really useful Praat scripts available online. Three particularly useful ones are:
- [Vocal Toolkit plugin](http://www.praatvocaltoolkit.com/) is plugin for Praat
- [Matt Winn's Listen Lab](http://www.mattwinn.com/praat.html) with some really fun [Youtube Praat tutorials](https://www.youtube.com/playlist?list=PL6niCBwOhjHga4bCS83VJ2uKzQ8ZjEVeG)
- [Holger Mitterer's website](http://holgermitterer.eu/research.html)

## List of available scripts

{{< list_children >}}

## License

{{< spoiler text="Are there prerequisites?" >}}
There are no prerequisites for the first course.
{{< /spoiler >}}
