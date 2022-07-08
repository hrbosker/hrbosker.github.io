---
title: Repackaging speech
summary: Making unintelligible speech intelligible again...
date: '2022-07-07'
weight: 30

# show author profile at bottom of page?
profile: false

# Show a link to the next article in the series?
pager: true

# Show breadcrumb navigation at top?
show_breadcrumb: true

# tags:
#   - CV
# external_link: http://github.com
---

## How fast can your ears go?

Listen to this clip of a talker saying the telephone number *496-0356*...

> *496-0356* -- [original]
{{< audio src="4960356_nopause_mono.mp3" >}}

You'll probably have no problem understanding the same digits when it's compressed by a factor of 2 (i.e., twice as fast)...

> *496-0356* -- compressed by 2
{{< audio src="4960356_nopause_mono_k2.mp3" >}}

And when it's compressed by a factor of 3?

> *496-0356* -- compressed by 3
{{< audio src="4960356_nopause_mono_k3.mp3" >}}

And compressed by 4?

> *496-0356* -- compressed by 4
{{< audio src="4960356_nopause_mono_k4.mp3" >}}

Or even by 5?

> *496-0356* -- compressed by 5
{{< audio src="4960356_nopause_mono_k5.mp3" >}}

Research has demonstrated that compression rates up to 3 are still doable (kinda...) but intelligibility breaks down quite dramatically for higher compression rates (e.g., [Ghitza, 2014](https://www.frontiersin.org/articles/10.3389/fpsyg.2014.00652/full); [Bosker & Ghitza, 2018](/publication/bosker-etal-2018-lcn)). So the last two clips are unintelligible to most listeners.

This has been suggested to be due to how our brain works. Our brain is known to 'track' incoming speech by aligning its 'brain waves' (neural oscillations in the *theta* range, 3-9 Hz) to the syllable rhythm of the speech (amplitude modulations in the temporal envelope). But when the syllables come in too rapidly (>9 Hz), the brain waves can't keep up, resulting in poor intelligibility.

## Making unintelligible speech intelligible again

But there's a trick to help the brain keep up. Let's take the unintelligible clip with the telephone number *496-0356* compressed by a factor of 5. Here it is again:

> *496-0356* -- compressed by 5
{{< audio src="4960356_nopause_mono_k5.mp3" >}}

That's tough, right? No wonder with a syllable rate of over 12 Hz!

Now let's chop this clip up into short snippets of 66 ms ("packages", cf. top panel in the figure at the top of this page) and space them apart by 100 ms (i.e., inserting silent intervals). This brings the package rate down to around 6 Hz. **Can your brain keep up with that?**

> *496-0356* -- repackaged
{{< audio src="4960356_nopause_mono_repack.mp3" >}}

What wizardry! What was unintelligible before is made (more...) intelligible by adding some 'breathing space' for the brain. *Note that the speech signal itself did not change*: it is the same acoustic content as before, but just presented at a slower pace so your brain can keep up!

## And now the exam!

Here is a new telephone number, also consisting of 7 digits. Can you tell me **what the last four digits are?**

{{< audio src="4960592_nopause_mono_k5.mp3" >}}

> {{< spoiler text="*Click here to see the correct answer...*" >}}
*0592*
{{< /spoiler >}}

And what about this one?

{{< audio src="4980137_nopause_mono_k5.mp3" >}}

> {{< spoiler text="*Click here to see the correct answer...*" >}}
*0137*
{{< /spoiler >}}

Presumably everybody has a hard time correctly hearing these digits, because these are again recordings that have been compressed by a factor of 5!

But now try these:

{{< audio src="4960723_nopause_mono_repack.mp3" >}}

> {{< spoiler text="*Click here to see the correct answer...*" >}}
*0723*
{{< /spoiler >}}

{{< audio src="8790164_nopause_mono_repack.mp3" >}}

> {{< spoiler text="*Click here to see the correct answer...*" >}}
*0164*
{{< /spoiler >}}

That probably sounded much more intelligible. These are two examples of 'repackaged speech': first compressed by a factor of 5, chopped up into 66 ms snippets, and then spaced apart by 100 ms. And your brain was presumably very grateful for that extra breathing space ("my pleasure, brain...").

## Why is this important?

This phenomenon can tell us something about what acoustic aspects support speech intelligibility. If we know what aspects of speech are critical for proper intelligibility, then that knowledge would be helpful, for instance, (i) for speech synthesizers, such as Automatic Announcement Systems in public transport, to generate speech signals that human listeners can understand well, (ii) for hearing aids to 'enrich' incoming speech signals and present those optimized signals to the listening brain, or (iii) for communication with the elderly who often experience difficulty with speech perception, especially in noise.

## Relevant papers

> {{< cite page="/publication/bosker-etal-2018-lcn" view="4" >}}
