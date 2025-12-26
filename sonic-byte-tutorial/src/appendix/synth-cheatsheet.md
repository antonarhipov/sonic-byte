# Synth Cheat Sheet

Quick reference for synths used in *Sonic Byte*.

## Primary Synths

### :tb303
**Character:** Acid bass, squelchy, aggressive  
**Best for:** Bass, acid lines

```ruby
use_synth :tb303
play :d2,
  amp: 0.8,
  attack: 0.01,
  decay: 0.2,
  sustain: 0.1,
  release: 0.15,
  cutoff: 80,      # 60-100 typical
  res: 0.3,        # 0.2-0.5 typical
  wave: 0          # 0=saw, 1=square
```

### :prophet
**Character:** Warm, fat, analog  
**Best for:** Bass, leads, pads

```ruby
use_synth :prophet
play :c4,
  amp: 0.5,
  attack: 0.05,
  decay: 0.2,
  sustain: 0.3,
  release: 0.4,
  cutoff: 85,
  res: 0.2
```

### :dsaw
**Character:** Aggressive, wide, detuned  
**Best for:** Bass layers, stabs, aggressive leads

```ruby
use_synth :dsaw
play :d2,
  amp: 0.5,
  attack: 0.01,
  decay: 0.2,
  release: 0.15,
  cutoff: 85,
  detune: 0.2      # 0.1-0.3 typical
```

### :sine
**Character:** Pure, clean, no harmonics  
**Best for:** Sub bass layer

```ruby
use_synth :sine
play :d1,          # Usually octave below main bass
  amp: 1,
  attack: 0.01,
  sustain: 0.3,
  release: 0.2
```

### :pulse
**Character:** Hollow, rhythmic, retro  
**Best for:** Arpeggios, rhythmic patterns

```ruby
use_synth :pulse
play :d4,
  amp: 0.25,
  attack: 0.01,
  decay: 0.1,
  release: 0.1,
  cutoff: 100,
  pulse_width: 0.3  # 0.1-0.5 typical
```

### :dark_ambience
**Character:** Atmospheric, eerie, evolving  
**Best for:** Pads, texture layers

```ruby
use_synth :dark_ambience
play :d3,
  amp: 0.35,
  attack: 1.5,
  sustain: 2.5,
  release: 3,
  cutoff: 75
```

### :hollow
**Character:** Ethereal, breathy, haunting  
**Best for:** Pads, high texture

```ruby
use_synth :hollow
play :d4,
  amp: 0.25,
  attack: 0.3,
  decay: 0.5,
  sustain: 0.2,
  release: 0.8,
  cutoff: 90
```

### :mod_saw / :mod_dsaw
**Character:** Modulated, moving, alarm-like  
**Best for:** Hooks, alarm sounds, special effects

```ruby
use_synth :mod_saw
play :g4,
  amp: 0.35,
  attack: 0,
  decay: 0.08,
  sustain: 0.04,
  release: 0.06,
  mod_phase: 0.15,  # Speed of modulation
  mod_range: 7,     # Depth of modulation
  cutoff: 110
```

## Quick Comparison

| Synth | Warmth | Aggression | Best Use |
|-------|--------|------------|----------|
| :tb303 | Medium | High | Acid bass |
| :prophet | High | Low | Leads, warm bass |
| :dsaw | Low | High | Aggressive bass/stabs |
| :sine | Neutral | None | Sub layer |
| :pulse | Low | Medium | Arps |
| :dark_ambience | Medium | Low | Atmospheric pads |
| :hollow | High | None | Ethereal textures |
| :mod_saw | Low | High | Hooks, effects |

## Parameter Ranges

### cutoff (Filter Frequency)
- **40-60**: Very dark, muffled
- **60-75**: Dark, subby
- **75-90**: Balanced, present
- **90-110**: Bright, cutting
- **110+**: Very bright, harsh

### res (Resonance)
- **0.1-0.2**: Subtle color
- **0.3-0.4**: Classic analog feel
- **0.5-0.6**: Pronounced, acid-style
- **0.7+**: Screaming (use carefully)

### detune (for :dsaw)
- **0.05-0.1**: Subtle thickening
- **0.15-0.25**: Classic detuned sound
- **0.3+**: Very wide, aggressive

## Common Layering Combinations

### Heavy Bass
```ruby
:tb303 (character) + :sine (sub)
```

### Warm Bass
```ruby
:prophet (character) + :sine (sub)
```

### Aggressive Bass
```ruby
:dsaw (aggression) + :tb303 (grit) + :sine (sub)
```

### Rich Lead
```ruby
:prophet (main) + :saw (shimmer, octave up)
```

### Dark Lead
```ruby
:prophet (main) + :dark_ambience (texture)
```

### Atmospheric Pad
```ruby
:dark_ambience (body) + :hollow (high texture)
```
