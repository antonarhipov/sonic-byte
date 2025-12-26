# Synthetic Apocalypse: A Sonic Byte

> *A guide to programming dark electronic music with Sonic Pi*

---

## Welcome

You're holding a tutorial that will teach you how to create a complete 8-track dark electronic album using nothing but code. No DAW. No piano roll. No mouse clicking. Just pure, expressive code.

**Synthetic Apocalypse** is a "Sonic Byte" — 8 tracks of dark clubbing, industrial electronic, and darksynth music, composed entirely in [Sonic Pi](https://sonic-pi.net/). This book will teach you how it was made, and give you the skills to create your own.

## What You'll Learn

By the end of this tutorial, you'll understand:

- **Sound Design** — How to craft punishing kicks, grinding basslines, and atmospheric pads using Sonic Pi's built-in synths
- **Rhythm Programming** — Building drum patterns that drive the dancefloor
- **Melody Writing** — Creating dark, emotional melodies that cut through the mix
- **Arrangement** — Structuring tracks with builds, drops, and DJ-friendly sections
- **Live Coding Techniques** — Using threads, functions, and effects to create complex, evolving music

## Who This Book Is For

This tutorial assumes:

- **Basic programming knowledge** — You understand variables, functions, and loops
- **Some musical interest** — You don't need to read music, but curiosity helps
- **Sonic Pi installed** — Download it free at [sonic-pi.net](https://sonic-pi.net/)

If you've never touched Sonic Pi before, don't worry. We'll cover the essentials before diving into the deep end.

## The Album

Here's what we're building:

| # | Track | BPM | Key | Character |
|---|-------|-----|-----|-----------|
| 01 | System Override | 100 | D Minor | Aggressive opener |
| 02 | Nerve Damage | 105 | E Minor | Industrial crusher |
| 03 | Chrome Cathedral | 98 | A Minor | Atmospheric cyberpunk |
| 04 | Skull Fracture | 108 | F Minor | Maximum aggression |
| 05 | Midnight Protocol | 102 | C Minor | Synthwave triumph |
| 06 | Void Walker | 95 | B Minor | Dark power |
| 07 | Core Meltdown | 106 | G Minor | Peak-time climax |
| 08 | Terminal Velocity | 100 | D Minor | Cinematic finale |

Each track teaches different techniques. By the final chapter, you'll have built all eight.

## How to Use This Book

**Part I: Foundations** covers the vision and Sonic Pi basics. If you're new to Sonic Pi, start here.

**Part II: Sound Design** dives deep into creating individual elements — drums, bass, leads, and effects.

**Part III: Arrangement** teaches you how to structure complete tracks.

**Part IV: The Album** walks through each track, explaining the creative and technical decisions.

**Appendix** provides quick reference materials you'll use constantly.

---

Let's make some noise.

```ruby
use_bpm 100
sample :bd_tek, amp: 2.5, rate: 0.9
sleep 1
sample :bd_tek, amp: 2.5, rate: 0.9
```

*Press Run.*
