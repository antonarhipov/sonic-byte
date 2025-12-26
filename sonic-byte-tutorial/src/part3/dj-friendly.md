# DJ-Friendly Arrangements

Even if you never DJ, structuring tracks for DJ use makes them more professional. These principles create cleaner, more impactful music.

## Why DJ-Friendly?

1. **Clean transitions** — Intro/outro without melody clutter
2. **Predictable structure** — 8, 16, 32-bar phrases
3. **Energy flow** — Clear builds and drops
4. **Mixable** — Tracks can blend together

## Phrase Length

DJs count in 8-bar phrases. Structure your sections accordingly:

| Bars | Beats | Common Use |
|------|-------|------------|
| 4 | 16 | Short break, transition |
| 8 | 32 | Intro, outro, build |
| 12-16 | 48-64 | Main sections |

```ruby
# Good: 8-bar intro
8.times { drums 0.7, 0, 0.4 }  # 32 beats

# Good: 12-bar main
12.times { drums 1, 0.9, 0.7 }  # 48 beats

# Avoid: 7-bar section (awkward for DJs)
7.times { drums 1, 0.9, 0.7 }  # 28 beats - hard to mix
```

## Clean Intro

The intro should let DJs mix in smoothly:

### Do:
- Start with drums (kick, hats)
- Filter any bass/melodic elements
- Keep it rhythmically simple

### Don't:
- Start with full melody
- Use complex rhythms
- Change tempo

```ruby
# DJ-friendly intro
in_thread do
  8.times { drums 0.7, 0, 0.4 }  # Kicks + hats only
end
in_thread do
  with_fx :lpf, cutoff: 50, cutoff_slide: 32 do |fx|
    control fx, cutoff: 75
    8.times { bassline 0.5, 50 }  # Heavily filtered
  end
end
sleep 32
```

## Clean Outro

The outro should let DJs mix out:

### Do:
- End with drums fading
- Remove melodic elements early
- Provide 4-8 bars of minimal content

### Don't:
- End abruptly
- Have melody playing to the last beat
- Use complex fills at the end

```ruby
# DJ-friendly outro
in_thread do
  # Melody ends early
  with_fx :reverb, room: 0.9, mix: 0.55 do
    melody 0.4  # Once, then done
  end
end

in_thread do
  # Drums continue and fade
  6.times do |i|
    drums (1-i*0.15), 0, (0.6-i*0.08)
  end
end

sleep 24
```

## Predictable Changes

Changes should happen on expected beats:

```ruby
# Changes happen at bar boundaries
8.times { drums 0.7, 0, 0.4 }    # Bar 1-8: Intro
hit 1
8.times { drums 0.85, 0.7, 0.6 } # Bar 9-16: Build
hit 1.1
12.times { drums 1, 0.9, 0.7 }   # Bar 17-28: Main
```

DJs can predict when changes happen (every 8 bars).

## Energy Markers

Help DJs identify sections with clear audio cues:

### The Hit
```ruby
define :hit do |v=1|
  sample :bd_boom, amp: 2*v, rate: 0.4
  sample :drum_splash_hard, amp: 0.7*v
end

# Mark section changes
8.times { drums 0.8, 0.6, 0.5 }
hit 1.2  # Clear marker: new section coming
8.times { drums 1, 0.9, 0.7 }
```

### The Break
Clear tension before drops:

```ruby
# BREAK: Obviously different
in_thread do
  # No kick - clear signal
  16.times { hat 0.35; sleep 0.5 }
end
sleep 16
hit 1.5
# DROP: Everything returns
```

## The 4-Bar Warning

Professional tracks often "warn" 4 bars before major changes:

```ruby
# Main section
8.times { drums 1, 0.9, 0.7 }

# Warning: Something's changing
# (subtle fill, filter movement, added element)
in_thread do
  with_fx :lpf, cutoff: 85, cutoff_slide: 16 do |fx|
    control fx, cutoff: 60  # Filter starts closing
    4.times { drums 1, 0.9, 0.7 }
  end
end
sleep 16

# Change happens
hit 1.2
# New section...
```

## Standard DJ-Friendly Structure

```
INTRO     8 bars   Drums only, filtered bass
BUILD     8 bars   Add elements, filter opens
MAIN A   12 bars   Full groove
BREAK     4 bars   Stripped, tension
MAIN B   12 bars   Full groove, peak energy
OUTRO     6 bars   Drums fade, melody ends
```

Total: ~50 bars, ~3:20 at 100 BPM

## Quick Reference

```ruby
# DJ-friendly phrase lengths
8.times { ... }   # Intro, build, outro
12.times { ... }  # Main sections
4.times { ... }   # Breaks, transitions

# Clean intro (drums + filtered bass)
in_thread do
  8.times { drums 0.7, 0, 0.4 }
end
in_thread do
  with_fx :lpf, cutoff: 50, cutoff_slide: 32 do |fx|
    control fx, cutoff: 75
    8.times { bassline 0.5, 50 }
  end
end

# Clean outro (fade drums, melody ends early)
in_thread do
  melody 0.4  # Once
end
in_thread do
  6.times { |i| drums (1-i*0.15), 0, (0.6-i*0.08) }
end

# Mark changes with hits
hit 1.2
```
