# Choosing Synths

Sonic Pi includes dozens of synths. For dark electronic music, you only need to master a handful.

## The Core Palette

These six synths cover 90% of *Sonic Byte*:

| Synth | Character | Primary Use |
|-------|-----------|-------------|
| `:tb303` | Acid, squelchy | Aggressive bass |
| `:prophet` | Warm, analog | Leads, warm bass |
| `:dsaw` | Wide, aggressive | Bass layers, stabs |
| `:sine` | Pure, clean | Sub bass layer |
| `:pulse` | Hollow, rhythmic | Arpeggios |
| `:dark_ambience` | Eerie, evolving | Pads, stabs |

## Synth Selection by Role

### For Bass

**Aggressive bass:** `:tb303`
```ruby
use_synth :tb303
play :d2, cutoff: 80, res: 0.3
```
The resonant filter creates the classic acid sound.

**Warm bass:** `:prophet`
```ruby
use_synth :prophet
play :d2, cutoff: 75, res: 0.2
```
Smoother, less aggressive, more musical.

**Wide bass:** `:dsaw`
```ruby
use_synth :dsaw
play :d2, cutoff: 82, detune: 0.2
```
The detuned oscillators create stereo width.

**Sub layer:** `:sine` (always)
```ruby
use_synth :sine
play :d1  # One octave below main bass
```
Pure low frequency, no harmonics. Mix it high.

### For Leads

**Musical lead:** `:prophet`
```ruby
use_synth :prophet
play :d4, attack: 0.05, cutoff: 90
```
Warm and expressive, good for melodic lines.

**Aggressive lead:** `:mod_saw`
```ruby
use_synth :mod_saw
play :d4, mod_phase: 0.1, mod_range: 6, cutoff: 110
```
The modulation creates movement and urgency.

**Shimmering layer:** `:saw`
```ruby
use_synth :saw
play :d5, amp: 0.1, cutoff: 75  # Octave up, quiet
```
Add sparkle to prophet leads.

### For Arpeggios

**Classic arp:** `:pulse`
```ruby
use_synth :pulse
play :d4, pulse_width: 0.35, cutoff: 100
```
Hollow, rhythmic, synthwave-appropriate.

**Aggressive arp:** `:dsaw`
```ruby
use_synth :dsaw
play :d4, detune: 0.1, cutoff: 95
```
Wider, more present.

### For Pads/Atmosphere

**Dark pad:** `:dark_ambience`
```ruby
use_synth :dark_ambience
play [:d3, :a3, :d4], attack: 2, sustain: 3, release: 4
```
Evolving, eerie texture.

**Ethereal pad:** `:hollow`
```ruby
use_synth :hollow
play :d4, attack: 0.5, release: 2, cutoff: 85
```
Breathy, ghostly presence.

### For Special Effects

**Alarm/hook:** `:mod_saw`
```ruby
use_synth :mod_saw
play :f4, mod_phase: 0.08, mod_range: 8, cutoff: 115
```
Fast modulation = alarm-like urgency.

**Stab:** `:dsaw` or `:dark_ambience`
```ruby
use_synth :dsaw
play [:d2, :a2, :d3], attack: 0, decay: 0.15, release: 0.1
```
Short, punchy chord hits.

## Synth Comparison

### Bass Synths

```ruby
# Same note, different character
use_bpm 100

use_synth :tb303
play :d2, cutoff: 80, res: 0.3
sleep 2

use_synth :prophet
play :d2, cutoff: 80
sleep 2

use_synth :dsaw
play :d2, cutoff: 80, detune: 0.2
sleep 2
```

Listen for:
- TB303: Brighter, more "squelchy"
- Prophet: Warmer, rounder
- Dsaw: Wider, more aggressive

### Lead Synths

```ruby
use_synth :prophet
play :d4, cutoff: 90
sleep 2

use_synth :saw
play :d4, cutoff: 90
sleep 2

use_synth :mod_saw
play :d4, cutoff: 100, mod_phase: 0.15, mod_range: 4
sleep 2
```

Listen for:
- Prophet: Musical, singable
- Saw: Raw, brighter
- Mod_saw: Movement, urgency

## Decision Framework

```text
Need bass?
├── Aggressive → :tb303
├── Warm → :prophet
├── Wide → :dsaw
└── Always add → :sine (sub layer)

Need lead?
├── Melodic → :prophet
├── Aggressive → :mod_saw
└── Add shimmer? → :saw (octave up)

Need arp?
├── Classic → :pulse
└── Aggressive → :dsaw

Need atmosphere?
├── Dark → :dark_ambience
└── Ethereal → :hollow

Need hook/alarm?
└── → :mod_saw (fast mod_phase)
```

## Exploring More Synths

Sonic Pi has many more synths. Some worth exploring:

- `:fm` — FM synthesis, metallic/bell tones
- `:mod_tri` — Modulated triangle, softer than mod_saw
- `:tech_saws` — Multiple detuned saws, huge sound
- `:blade` — Aggressive, cutting

To see all available synths:
```ruby
puts synth_names
```

But for *Sonic Byte*, the core six are all you need.

## Quick Reference

```ruby
# Aggressive bass
use_synth :tb303
play :d2, cutoff: 80, res: 0.3, wave: 0

# Warm bass
use_synth :prophet
play :d2, cutoff: 75, res: 0.2

# Sub layer
use_synth :sine
play :d1, amp: 1.1

# Lead
use_synth :prophet
play :d4, attack: 0.05, cutoff: 90

# Arp
use_synth :pulse
play :d4, pulse_width: 0.35, cutoff: 100

# Pad
use_synth :dark_ambience
play [:d3, :a3], attack: 2, release: 4
```
