---
title: Cocktail party listening
summary: Trying to attend one talker, while ignoring others...
date: '2022-07-07'
weight: 40
show_date: false

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

## A very dull cocktail party

In everday life, we often encounter situations where there's more than just one talker speaking, like having a conversation in a busy bar, listening to a presenter at a crowded poster session, or talking to someone on the phone while walking on the street. Somehow our brain has little trouble honing in on that one talker we want to attend to, while ignoring others. **How do we that?**

Speech researchers like ourselves tend to investigate this research question by creating terribly dull 'cocktail parties'. These cocktail parties include one listener, two talkers (A and B), and a lamentable lack of any cocktails. Still, such a situation does allow the researcher to play with particular auditory and visual cues to see if that helps or hinders the listener to attend to Talker A and ignore Talker B.

{{< spoiler text="*Why call this a 'cocktail party' in the first place?*" >}}
[Colin Cherry](https://asa.scitation.org/doi/abs/10.1121/1.1907229) came up with 'the cocktail party problem' in 1953: "how do we recognize what one person is saying when others are speaking at the same time". His experiments involved playing speech from two different talkers over the same speaker, covering such topics as "the really complex nature of the causes and uses of birds' colors" and about how "religious convictions, legal systems, and politics have been so successful in accomplishing their aims". How prof. Cherry arrived at the term 'cocktail party' in light of these topics remains an outright mystery. [Scientists and parties...](https://www.youtube.com/watch?v=mCx4T8MKbjk)
{{< /spoiler >}}

## The time between your ears

One such cue is the *interaural time difference* (ITD). This is the difference in arrival time of a sound between two ears. Imagine Talker A is talking on your left, while Talker B is talking on your right. Their speech needs to travel through the air before reaching your ears, which takes (a very short amount of) time. Their opposite locations in space mean that the speech of Talker A will hit your left ear a fraction of a second earlier than your right ear. Likewise, the speech of Talker B will hit your right ear earlier than your left ear. Remarkably, your brain can use this difference in arrival time (ITD) to locate speakers in space, helping you to separate the speech from Talker A from the speech from Talker B.

We can try to construct a situation where ITD is the *only cue* to speakers' locations in space, creating a *virtual auditory scene*:
- Put on your headphones/ear buds
- **Do not use speakers**; this works better with headphones
- Let's take two recordings: one from a female Google, another from a male Alexa

> **FEMALE GOOGLE**
{{< audio src="female_g_left.mp3" >}}
**MALE ALEXA**
{{< audio src="male_a_right.mp3" >}}

- Now let's simply mix these two recordings:

> **GOOGLE/ALEXA MIX**
{{< audio src="multitalker_mid.mp3" >}}

When listening to this mixture, we can already notice three things:
1. *They're lying.* In defiance of their words, the positioning of the two talkers in (virtual) space is acutally identical. Most listeners would judge the two talkers as being positioned 'right in front of them', or even 'talking inside their heads'. That is because *both voices reach both of your ears instantaneously*. The audio clip is a mono file with only one channel, containing the mixed speech from both talkers. The browser sends this single channel to both sides of your headphones (if all went well...), so the female speech reaches your left ear at the same point in time as it reaches your right ear (ITD = 0 ms), and the same for the male speech. In reality, this hardly ever happens (if at all), unless a speaker is standing perfectly in front of you.

2. *Our brains are remarkable.* Despite the unrealistic virtual positions of the two talkers, we can still freely direct our attention to the female talker (and ignore the male talker), or to the male talker (and ignore the female talker). Apparently, we can use other cues (i.e., other than ITDs) to attend one talker and ignore others, such as their (markedly different) pitch.

3. *This truly is a dull party...*

## Virtual reality

Now let's see if we can move these two talkers around in virtual space. Imagine the female talker is on your left and the male is on your right. This would mean that the female speech reaches your left ear before it reaches your right ear. And vice versa: the male speech would reach your right ear before reaching your left.

We can mimick this by applying ITDs to the individual speech signals. First, we take the mono clip above and copy it to another channel, resulting in a stereo clip with two identical channels (see illustration in the clip below). Second, we take *the female speech* (given in red below) and delay it *in the right channel* by 0.0006 seconds = 0.6 milliseconds = 600 μs. Finally, we take *the male speech* (in blue) and delay it *in the left channel* by the same minute amount of time. Now we have a stereo clip with opposite ITDs for the two talkers!

In the clip below, you'll first hear the 'old' mixture we had initially, followed by the 'new' clip with manipulated ITDs. **Can you hear the difference?**

{{< video src="itd.mp4" controls="yes" >}}

This is quite a different experience:
1. *Now they're finally speaking the truth!* While in the first mixture (with ITD = 0 ms) the two talkers sound as coming from the same central position, in the second mixture (with ITD = 600 μs) you should have heard **the female voice on your left and the male voice on your right**. Note, however, that this *does not mean* that 'the female voice was in your left ear'. The speech from either talker was presented to *both your ears* (see illustration of 'L / R' channels in the clip). Your brain 'constructed' the talkers' virtual positions based on the ITD.
2. *Our brains are even more remarkable!* Your brain told you that the female talker is on the left because it can pick up on less than a millisecond of a time difference!
3. *Can we get to the cocktails now?*

## Why is this important?

Speech perception is presumably the hardest in noisy listening conditions. Even if we manage to understand what our interlocutor is trying to say in the midst of all the other speech, it takes our brain considerable effort and resources to do so. Knowing which acoustic and visual cues help humans 'tune in' to talkers (such as rhythm; Bosker & Cooke, [2018](/publication/bosker-etal-2018-jasa); [2020](/publication/bosker-etal-2020-jasa)) can inspire innovations in hearing aid technology and telephony. Likewise, knowing which acoustic aspects are hard to ignore for listeners (i.e., 'immune' to selective attention, such as speech rate; Bosker et al., [2020a](/publication/bosker-etal-2020-scirep); [2020b](/publication/bosker-etal-2020-app)) can motivate signal processing algorithms that aim to filter these acoustic properties from unattended talkers.

## Relevant papers

> {{< cite page="/publication/bosker-etal-2020-scirep" view="4" >}}

> {{< cite page="/publication/bosker-etal-2020-app" view="4" >}}

> {{< cite page="/publication/bosker-etal-2020-jasa" view="4" >}}

> {{< cite page="/publication/bosker-etal-2018-jasa" view="4" >}}
