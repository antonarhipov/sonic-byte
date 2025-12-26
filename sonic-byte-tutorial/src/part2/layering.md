# Layering Techniques

Single sounds are rarely enough. Layering combines multiple sounds to create fuller, more powerful, and more interesting textures.

## Why Layer?

A single synth playing a bass note covers a limited frequency range. Layering fills the gaps:

```ruby
# Single synth - thin
use_synth :tb303
play :d2

# Layered - full
use_synth :tb303
play :d2, cutoff: 80        # Mid frequencies
use_synth :sine
play :d1, amp: 1.1          # Sub frequencies
```

## The Three-Layer Model

Most sounds in *Sonic Byte* use up to three layers:

### 1. Character Layer
The main sound that defines the timbre.
```ruby
use_synth :tb303
play :d2, cutoff: 80, res: 0.3
```

### 2. Sub Layer
Pure low frequency for physical weight.
```ruby
use_synth :sine
play :d1  # One octave below
```

### 3. Texture Layer (Optional)
Adds width, grit, or atmosphere.
```ruby
use_synth :dsaw
play :d2, cutoff: 70, detune: 0.15, amp: 0.4
```

## Bass Layering

### Two-Layer (Standard)
```ruby
define :bass do |n, v=1, c=80|
  use_synth :tb303
  play n, amp: 0.8*v, cutoff: c, res: 0.3
  
  use_synth :sine
  play n-12, amp: 1.1*v  # Octave below
end
```

### Three-Layer (Aggressive)
```ruby
define :bass do |n, v=1, c=80|
  use_synth :tb303
  play n, amp: 0.75*v, cutoff: c, res: 0.3
  
  use_synth :dsaw
  play n, amp: 0.4*v, cutoff: c-10, detune: 0.18
  
  use_synth :sine
  play n-12, amp: 1.15*v
end
```

## Lead Layering

### Prophet + Shimmer
```ruby
define :lead do |n, dur=0.5, v=1|
  use_synth :prophet
  play n, amp: 0.4*v, attack: 0.05, cutoff: 90
  
  use_synth :saw
  play n+12, amp: 0.1*v, cutoff: 75  # Octave up, quiet
end
```

### Prophet + Atmosphere
```ruby
define :lead do |n, dur=0.5, v=1|
  use_synth :prophet
  play n, amp: 0.4*v, attack: 0.05, cutoff: 88
  
  use_synth :dark_ambience
  play n, amp: 0.12*v, attack: 0.1, release: dur*0.8
end
```

## Drum Layering

### Kick
```ruby
define :kick do |v=1|
  sample :bd_tek, amp: 2.2*v, rate: 0.9      # Attack/punch
  sample :bd_boom, amp: 0.5*v, rate: 1.2     # Sub/weight
end
```

### Snare
```ruby
define :snare do |v=1|
  sample :sn_dub, amp: v, rate: 0.8          # Body
  sample :drum_snare_hard, amp: 0.4*v        # Crack
end
```

## Volume Balance

Each layer needs proper level:

| Layer | Role | Typical Amp |
|-------|------|-------------|
| Character | Primary | 0.6-0.8 |
| Texture | Supporting | 0.3-0.5 |
| Sub | Foundation | 1.0-1.2 |
| Shimmer | Sparkle | 0.08-0.12 |

**Rule:** Sub can be loudest (low frequencies need more energy to be perceived).

## Frequency Separation

Filter layers to avoid mud:

```ruby
define :bass do |n, v=1, c=80|
  use_synth :tb303
  play n, cutoff: c        # Main cutoff
  
  use_synth :dsaw
  play n, cutoff: c-10     # Darker (less overlap)
  
  use_synth :sine
  play n-12                # No filter needed
end
```

## ADSR Alignment

Layers should have similar timing:

```ruby
# All layers: quick attack, similar decay
use_synth :tb303
play n, attack: 0.01, decay: 0.2, release: 0.15

use_synth :dsaw
play n, attack: 0.01, decay: 0.15, release: 0.12

use_synth :sine
play n-12, attack: 0.01, sustain: 0.25, release: 0.2
```

## When to Layer

**Use more layers for:**
- Peak/drop sections
- Main hooks
- When you need to fill the mix

**Use fewer layers for:**
- Intros/outros
- Atmospheric sections
- When other elements need space

## Quick Reference

```ruby
# Two-layer bass
define :bass do |n, v=1, c=80|
  use_synth :tb303
  play n, amp: 0.8*v, cutoff: c
  use_synth :sine
  play n-12, amp: 1.1*v
end

# Three-layer bass
define :bass do |n, v=1, c=80|
  use_synth :tb303
  play n, amp: 0.75*v, cutoff: c
  use_synth :dsaw
  play n, amp: 0.4*v, cutoff: c-10, detune: 0.18
  use_synth :sine
  play n-12, amp: 1.15*v
end

# Layered lead
define :lead do |n, dur=0.5, v=1|
  use_synth :prophet
  play n, amp: 0.4*v, cutoff: 90
  use_synth :saw
  play n+12, amp: 0.1*v, cutoff: 75
end
```
