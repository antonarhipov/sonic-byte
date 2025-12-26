# Synth Selection for Leads

Leads carry the melody. The right synth choice determines whether your melody sounds warm, aggressive, ethereal, or dark.

## The Primary Lead: Prophet

Most leads in *Sonic Byte* use `:prophet`:

```ruby
use_synth :prophet
play :d4, amp: 0.4, attack: 0.05, decay: 0.2,
     sustain: 0.3, release: 0.4, cutoff: 90
```

### Why Prophet?

- **Warm** — Analog-style warmth
- **Musical** — Good for melodic lines
- **Versatile** — Works dark or bright
- **Cuts through** — Present without harsh

## Lead Synth Options

### :prophet (Warm, Musical)
```ruby
use_synth :prophet
play :d4, cutoff: 90, res: 0.15
```
Best for: Main melodies, emotional lines

### :saw (Raw, Bright)
```ruby
use_synth :saw
play :d4, cutoff: 85
```
Best for: Shimmer layers (octave up)

### :mod_saw (Aggressive, Moving)
```ruby
use_synth :mod_saw
play :d4, mod_phase: 0.1, mod_range: 5, cutoff: 110
```
Best for: Hooks, alarms, aggressive accents

### :dark_ambience (Atmospheric)
```ruby
use_synth :dark_ambience
play :d4, attack: 0.1, release: 1
```
Best for: Pad layers, atmosphere under leads

### :hollow (Ethereal)
```ruby
use_synth :hollow
play :d4, attack: 0.3, release: 1.5, cutoff: 85
```
Best for: High texture, whisper layers

## Layering Leads

Single synths can sound thin. Layer for richness:

### Prophet + Shimmer
```ruby
define :lead do |n, dur=0.5, v=1|
  # Main layer
  use_synth :prophet
  play n, amp: 0.4*v, attack: 0.05, decay: dur*0.25,
       sustain: dur*0.4, release: dur*0.5, cutoff: 90
  
  # Shimmer (octave up, quiet)
  use_synth :saw
  play n+12, amp: 0.1*v, attack: 0.08,
       sustain: dur*0.3, release: dur*0.4, cutoff: 75
end
```

### Prophet + Dark Atmosphere
```ruby
define :lead do |n, dur=0.5, v=1|
  use_synth :prophet
  play n, amp: 0.4*v, attack: 0.05, decay: dur*0.25,
       sustain: dur*0.4, release: dur*0.5, cutoff: 88
  
  use_synth :dark_ambience
  play n, amp: 0.12*v, attack: 0.1, release: dur*0.8
end
```

## Attack Shapes

Attack time changes the feel:

```ruby
attack: 0      # Instant - percussive, aggressive
attack: 0.03   # Fast - punchy but softer
attack: 0.05   # Standard - musical
attack: 0.1    # Soft - expressive
attack: 0.3+   # Slow - pad-like
```

### By Track Type

| Track | Attack | Feel |
|-------|--------|------|
| Aggressive | 0.02-0.03 | Punchy |
| Standard | 0.05 | Musical |
| Atmospheric | 0.08-0.1 | Soft |
| Ethereal | 0.1+ | Floating |

## Cutoff for Leads

Higher cutoff than bass:

```ruby
# Bass cutoff: 70-85 typical
# Lead cutoff: 85-100 typical

use_synth :prophet
play :d4, cutoff: 90  # Bright enough to cut through
```

### By Section

| Section | Lead Cutoff |
|---------|-------------|
| Intro/Build | 85-88 |
| Main | 90-92 |
| Peak | 92-95 |
| Break | 85 (+ heavy reverb) |

## Lead Synth by Track

| Track | Lead Synth | Character |
|-------|------------|-----------|
| 1. System Override | :prophet | Balanced |
| 2. Nerve Damage | :mod_saw | Aggressive |
| 3. Chrome Cathedral | :pulse | Atmospheric |
| 4. Skull Fracture | :mod_saw | Alarm-like |
| 5. Midnight Protocol | :prophet | Warm, triumphant |
| 6. Void Walker | :prophet | Dark, sparse |
| 7. Core Meltdown | :prophet + :saw | Rich, ethereal |
| 8. Terminal Velocity | :prophet | Emotional |

## Quick Reference

```ruby
# Warm lead
use_synth :prophet
play :d4, amp: 0.4, attack: 0.05, cutoff: 90

# Aggressive lead
use_synth :mod_saw
play :d4, amp: 0.35, mod_phase: 0.1, mod_range: 5, cutoff: 110

# Shimmer layer (add to prophet)
use_synth :saw
play :d5, amp: 0.1, cutoff: 75  # Octave up

# Atmospheric layer
use_synth :dark_ambience
play :d4, amp: 0.12, attack: 0.1, release: 0.8

# Complete layered lead
define :lead do |n, dur=0.5, v=1|
  use_synth :prophet
  play n, amp: 0.4*v, attack: 0.05, cutoff: 90
  use_synth :saw
  play n+12, amp: 0.1*v, cutoff: 75
end
```
