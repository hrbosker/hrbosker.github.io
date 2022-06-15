---
widget: slider
weight: 1
active: true
headless: true

design:
  # Slide height is automatic unless you force a specific height (e.g. '400px')
  slide_height: ''
  is_fullscreen: true
  # Automatically transition through slides?
  loop: true
  # Duration of transition between slides (in ms)
  interval: 4000

content:
  slides:
    - title: 👋 Welcome to the group
      content: Testing speech...
      align: center
      background:
        position: right
        color: '#666'
        brightness: 0.7
        media: 'Fig1_Bosker_2018_JASAEL.jpg'
    - title: Slide 2
      content: 'Testing gestures'
      align: left
      background:
        position: center
        color: '#555'
        brightness: 0.7
        media: coders.jpg
    - title: Slide 3
      content: 'Testing stock image'
      align: right
      background:
        position: center
        color: '#333'
        brightness: 0.5
        media: coders.jpg
      link:
        icon: graduation-cap
        icon_pack: fas
        text: Join Us
        url: ../contact/
---
