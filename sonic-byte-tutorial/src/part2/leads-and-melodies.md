# Leads and Melodies

Melodies give tracks emotional identity. In dark electronic music, leads walk the line between menacing and beautiful — they should feel dark but remain musically satisfying.

## Lead Synth Design

### The Prophet Sound

Our primary lead synth is `:prophet` — warm, analog-style:

```ruby
define :lead do |n, dur=0.5, v=1|
  use_synth :prophet
  play n, 
    amp: 0.4*v,
    attack: 0.05,
    decay: dur*0.25,
    sustain: dur*0.45,
    release: dur*0.5,
    cutoff: 90
end
```

**Parameters explained:**
- `attack: 0.05` — Quick but not instant (softer entry)
- `cutoff: 90` — Bright enough to cut through, not harsh

### Layering for Richness

Single synths can sound thin. Layer for fullness:

```ruby
define :lead do |n, dur=0.5, v=1|
  # Main layer
  use_synth :prophet
  play n, amp: 0.4*v, attack: 0.05, 
       decay: dur*0.25, sustain: dur*0.45, 
       release: dur*0.5, cutoff: 90
  
  # Shimmer layer (octave up, quiet)
  use_synth :saw
  play n+12, amp: 0.1*v, attack: 0.1,
       sustain: dur*0.3, release: dur*0.5, cutoff: 75
end
```

The high octave adds presence without overpowering.

### Dark Atmosphere Layer

For darker tracks:

```ruby
define :lead do |n, dur=0.5, v=1|
  use_synth :prophet
  play n, amp: 0.4*v, attack: 0.08, 
       decay: dur*0.3, sustain: dur*0.4, 
       release: dur*0.6, cutoff: 88
  
  use_synth :dark_ambience
  play n, amp: 0.12*v, attack: 0.1, release: dur*0.8
end
```

## Writing Dark Melodies

### Minor Keys

All album tracks use minor keys. Common notes in minor scales:

| Key | Notes |
|-----|-------|
| D Minor | D, E, F, G, A, Bb, C |
| E Minor | E, F#, G, A, B, C, D |
| A Minor | A, B, C, D, E, F, G |
| G Minor | G, A, Bb, C, D, Eb, F |

### The "Dark but Pleasant" Balance

**Too dark** (dissonant, uncomfortable):
```ruby
# Harsh intervals
lead :d4; sleep 0.5
lead :eb4; sleep 0.5  # Minor 2nd - tense
lead :ab4; sleep 0.5  # Tritone - very dark
```

**Too bright** (sounds like pop):
```ruby
# Major-sounding
lead :d4; sleep 0.5
lead :f4; sleep 0.5   # Major 3rd if you're not careful
lead :a4; sleep 0.5   # Sounds happy
```

**Dark but musical:**
```ruby
# Use minor intervals, resolve nicely
lead :d4; sleep 0.5
lead :f4; sleep 0.5   # Minor 3rd
lead :a4; sleep 0.5   # Fifth - strong
lead :g4; sleep 0.5   # Step down - tension
lead :f4; sleep 0.5   # Continue descent
lead :d4; sleep 1     # Resolve to root
```

### Melodic Patterns

**Ascending (builds energy):**
```ruby
define :mel_rise do |v=1|
  lead :d4, 0.5, v; sleep 0.5
  lead :f4, 0.5, v*0.95; sleep 0.5
  lead :a4, 0.5, v; sleep 0.5
  lead :d5, 1, v; sleep 1
end
```

**Descending (releases tension):**
```ruby
define :mel_fall do |v=1|
  lead :d5, 0.5, v; sleep 0.5
  lead :c5, 0.5, v*0.9; sleep 0.5
  lead :a4, 0.5, v*0.95; sleep 0.5
  lead :g4, 0.5, v*0.85; sleep 0.5
  lead :d4, 1, v; sleep 1
end
```

**Call and response:**
```ruby
define :mel1 do |v=1|  # The "question"
  lead :d4, 0.5, v; sleep 0.5
  lead :f4, 0.5, v; sleep 0.5
  lead :a4, 0.75, v; sleep 0.75
  sleep 0.25
end

define :mel2 do |v=1|  # The "answer"
  lead :a4, 0.5, v; sleep 0.5
  lead :g4, 0.5, v*0.9; sleep 0.5
  lead :f4, 0.5, v*0.95; sleep 0.5
  lead :d4, 1, v; sleep 1
end

# Usage
4.times do
  mel1 0.8; mel2 0.75
end
```

### Velocity Variation

Static velocity is boring. Create expression:

```ruby
define :melody do |v=1|
  lead :d4, 0.5, v; sleep 0.5
  lead :f4, 0.5, v*0.85; sleep 0.5    # Softer
  lead :a4, 0.75, v; sleep 0.75       # Strong
  lead :g4, 0.5, v*0.9; sleep 0.5     # Medium
  lead :f4, 0.5, v*0.8; sleep 0.5     # Softer
  lead :d4, 1, v; sleep 1             # Resolve strong
end
```

## Rhythmic Considerations

### Locking to the Grid

Melodies should feel rhythmic. Use consistent beat divisions:

```ruby
# Good: Clear rhythmic feel
lead :d4, 0.5, v; sleep 0.5   # Half beat
lead :f4, 0.5, v; sleep 0.5   # Half beat
lead :a4, 1, v; sleep 1       # Full beat

# Awkward: Doesn't groove
lead :d4, 0.7, v; sleep 0.7   # Odd timing
lead :f4, 0.4, v; sleep 0.4   # Feels random
```

### Leaving Space

Don't fill every beat:

```ruby
define :melody do |v=1|
  lead :d4, 0.5, v; sleep 0.5
  lead :f4, 0.5, v; sleep 0.5
  lead :a4, 1, v; sleep 1
  sleep 1                      # Rest - space to breathe
  lead :g4, 0.5, v; sleep 0.5
  lead :d4, 0.5, v; sleep 0.5
end
```

## Effects on Leads

### Standard Processing

```ruby
with_fx :reverb, room: 0.6, mix: 0.4 do
  with_fx :echo, phase: 0.5, decay: 3, mix: 0.3 do
    4.times { melody 0.8 }
  end
end
```

### Ethereal (for breaks/intros)

```ruby
with_fx :reverb, room: 0.95, mix: 0.6 do
  with_fx :echo, phase: 1, decay: 6, mix: 0.5 do
    melody 0.5
  end
end
```

### Tight (for peak sections)

```ruby
with_fx :reverb, room: 0.5, mix: 0.25 do
  with_fx :echo, phase: 0.5, decay: 2, mix: 0.2 do
    4.times { melody 0.9 }
  end
end
```

## Arpeggios

Arpeggios (broken chords) add movement without complex melodies:

```ruby
define :arp do |v=1|
  use_synth :pulse
  pattern = [:d4, :f4, :a4, :d5, :a4, :f4, :d4, :a3]
  
  pattern.each do |n|
    play n, amp: 0.25*v, attack: 0.01, 
         decay: 0.1, release: 0.1, cutoff: 100
    sleep 0.5
  end
end
```

**Arp variations:**
```ruby
# Rising
[:d4, :f4, :a4, :d5, :f5, :a5]

# Falling
[:a5, :f5, :d5, :a4, :f4, :d4]

# Wave
[:d4, :f4, :a4, :d5, :a4, :f4, :d4, :a3]

# Pulsing
[:d4, :d4, :f4, :f4, :a4, :a4, :d5, :d5]
```

## The Melody Arrangement

### Entry Strategy

Don't start with melody. Let it enter after groove is established:

```ruby
# MAIN section
in_thread do
  12.times { drums 1, 0.9, 0.7 }
end

in_thread do
  12.times { bassline 1, 80 }
end

in_thread do
  sleep 16                        # Wait 4 bars
  8.times { melody 0.8 }          # Then enter
end

sleep 48
```

### Building Through the Track

```ruby
# Build: Melody teases
with_fx :reverb, room: 0.8, mix: 0.5 do
  sleep 16
  melody 0.5; melody 0.45  # Quiet, distant
end

# Main: Melody present
with_fx :reverb, room: 0.6, mix: 0.35 do
  4.times { melody 0.8 }
end

# Peak: Melody strong
with_fx :reverb, room: 0.5, mix: 0.25 do
  4.times { melody 0.95 }
end
```

## Quick Reference

```ruby
# Basic lead
define :lead do |n, dur=0.5, v=1|
  use_synth :prophet
  play n, amp: 0.4*v, attack: 0.05, 
       decay: dur*0.25, sustain: dur*0.45, 
       release: dur*0.5, cutoff: 90
end

# Basic arp
define :arp do |v=1|
  use_synth :pulse
  [:d4,:f4,:a4,:d5,:a4,:f4,:d4,:a3].each do |n|
    play n, amp: 0.25*v, release: 0.1, cutoff: 100
    sleep 0.5
  end
end

# Melody with effects
with_fx :reverb, room: 0.6, mix: 0.4 do
  with_fx :echo, phase: 0.5, decay: 3, mix: 0.3 do
    4.times { melody 0.8 }
  end
end
```

---

You now have the building blocks for dark, musical melodies. The key is balance: dark enough to fit the genre, musical enough to be memorable.
