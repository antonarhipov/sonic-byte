# A Sonic Byte

> *A guide to programming dark electronic music with Sonic Pi*

---

## Listen First

Before reading a single line of code, **[listen to the album on SoundCloud](https://soundcloud.com/antonkeks/sets/sonic-byte)**.

Eight tracks. Forty minutes. All made with code.

Hear what we're building. Then come back and learn how it's done.

---

## Welcome

You're holding a tutorial that will teach you how to create a complete 8-track dark electronic album using nothing but code. No DAW. No piano roll. No mouse clicking. Just pure, expressive code.

**Sonic Byte** — 8 tracks of dark clubbing, industrial electronic, and darksynth music, composed entirely in [Sonic Pi](https://sonic-pi.net/). This book will teach you how it was made, and give you the skills to create your own.

## Why Code?

In a traditional DAW, you click and drag. You draw notes on a grid. You twist virtual knobs with a mouse.

In Sonic Pi, you type this:

```ruby
play scale(:d4, :minor).choose
```

One line. A random note from D minor. Every time.

Or this:

```ruby
16.times do |i|
  play :d2, cutoff: 50 + i*4
  sleep 0.25
end
```

A bass note that gets brighter with each hit. The filter opens automatically. No automation lanes. No clicking. Just *describe what you want* and it happens.

Code lets you:
- **Generate patterns** that never repeat exactly the same way
- **Control everything** with variables and math
- **Build systems** that make creative decisions for you
- **Share your music** as text anyone can run

This isn't about replacing DAWs. It's about discovering what's possible when music becomes code.

## What You'll Learn

By the end of this tutorial, you'll understand:

- **Sound Design** — How to craft punishing kicks, grinding basslines, and atmospheric pads
- **Rhythm Programming** — Building drum patterns that drive the dancefloor
- **Melody Writing** — Creating dark, emotional melodies that cut through the mix
- **Arrangement** — Structuring tracks with builds, drops, and DJ-friendly sections
- **The Power of Code** — Using functions, threads, and generative patterns to create music that evolves

## Who This Book Is For

This tutorial assumes:

- **Basic programming knowledge** — You understand variables, functions, and loops
- **Some musical interest** — You don't need to read music, but curiosity helps
- **Sonic Pi installed** — Download it free at [sonic-pi.net](https://sonic-pi.net/)

> **New to Sonic Pi?** The [official tutorial](https://sonic-pi.net/tutorial) is excellent for learning the basics. We'll cover what you need here, but the built-in docs go deeper.

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

**Part I: Foundations** covers the vision and Sonic Pi basics. Start here if you're new.

**Part II: Sound Design** dives deep into creating individual elements — drums, bass, leads, and effects.

**Part III: Arrangement** teaches you how to structure complete tracks.

**Part IV: The Album** walks through each track, explaining the creative and technical decisions. Each chapter ends with **Hacker Challenges** — modifications for you to try.

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
