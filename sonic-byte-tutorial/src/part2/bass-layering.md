# Layering Bass

A single bass synth rarely provides the full frequency spectrum needed for powerful bass. Layering fills the gaps.

## The Two-Layer Foundation

At minimum, every bass in *Sonic Byte* has two layers:

```ruby
define :bass do |n, v=1, c=80|
  # Character layer - defines the sound
  use_synth :tb303
  play n, amp: 0.8*v, cutoff: c, res: 0.3
  
  # Sub layer - provides weight
  use_synth :sine
  play n-12, amp: 1.1*v  # One octave below
end
```

### Why This Works

- **TB303** covers ~80-800 Hz (audible bass character)
- **Sine** covers ~30-80 Hz (felt sub bass)
- Together: full 30-800 Hz coverage

## The Three-Layer Stack

For maximum power:

```ruby
define :bass do |n, v=1, c=80|
  # Layer 1: Character (TB303)
  use_synth :tb303
  play n, amp: 0.75*v, attack: 0.01, decay: 0.2,
       sustain: 0.1, release: 0.15, cutoff: c, res: 0.3
  
  # Layer 2: Width/Grit (dsaw)
  use_synth :dsaw
  play n, amp: 0.4*v, attack: 0.01, decay: 0.15,
       release: 0.12, cutoff: c-10, detune: 0.18
  
  # Layer 3: Sub (sine)
  use_synth :sine
  play n-12, amp: 1.15*v, attack: 0.01, sustain: 0.25, release: 0.2
end
```

### Layer Roles

| Layer | Synth | Role | Frequency |
|-------|-------|------|-----------|
| Character | :tb303 | Defines sound | 80-500 Hz |
| Width | :dsaw | Adds stereo width, grit | 60-400 Hz |
| Sub | :sine | Physical weight | 30-80 Hz |

## Layer Combinations

### Aggressive (Tracks 1, 2, 4)
```ruby
:tb303 + :sine           # Track 1
:tb303 + :sine           # Track 2
:dsaw + :tb303 + :sine   # Track 4 (most aggressive)
```

### Warm (Tracks 3, 5)
```ruby
:prophet + :sine         # Smoother character
```

### Powerful (Tracks 6, 7)
```ruby
:prophet + :dsaw + :sine # Warm + wide + sub
```

## Volume Balancing

Each layer needs proper level:

```ruby
# Character: Primary presence
use_synth :tb303
play n, amp: 0.75*v  # Main volume

# Width: Supporting, not dominant
use_synth :dsaw
play n, amp: 0.4*v   # About half of character

# Sub: Felt, not heard
use_synth :sine
play n-12, amp: 1.1*v  # Can be louder (low frequencies need more energy)
```

**Rule:** If you can clearly hear the sub as a separate note, it's too loud.

## Cutoff Relationships

Filter each layer differently:

```ruby
# Character: Main cutoff
use_synth :tb303
play n, cutoff: c      # e.g., 80

# Width: Slightly darker
use_synth :dsaw
play n, cutoff: c-10   # e.g., 70

# Sub: No cutoff needed (sine has no harmonics)
use_synth :sine
play n-12
```

The width layer is darker so it doesn't compete with the character layer.

## ADSR Alignment

Layers should have similar envelopes:

```ruby
define :bass do |n, v=1, c=80|
  use_synth :tb303
  play n, amp: 0.75*v, 
       attack: 0.01, decay: 0.2, sustain: 0.1, release: 0.15,
       cutoff: c
  
  use_synth :dsaw
  play n, amp: 0.4*v,
       attack: 0.01, decay: 0.15, sustain: 0.08, release: 0.12,
       cutoff: c-10
  
  use_synth :sine
  play n-12, amp: 1.1*v,
       attack: 0.01, sustain: 0.25, release: 0.2
end
```

**Note:** The sine sub has slightly longer sustain/release — this gives weight without muddying attacks.

## When to Use Each Configuration

### Two Layers (:character + :sine)
- Standard bass lines
- Cleaner mixes
- Atmospheric tracks

### Three Layers (:character + :width + :sine)
- Maximum aggression
- Peak sections
- When you need to fill the stereo field

## Quick Reference

```ruby
# Two-layer bass
define :bass do |n, v=1, c=80|
  use_synth :tb303
  play n, amp: 0.8*v, cutoff: c, res: 0.3
  use_synth :sine
  play n-12, amp: 1.1*v
end

# Three-layer bass
define :bass do |n, v=1, c=80|
  use_synth :tb303
  play n, amp: 0.75*v, cutoff: c, res: 0.3
  use_synth :dsaw
  play n, amp: 0.4*v, cutoff: c-10, detune: 0.18
  use_synth :sine
  play n-12, amp: 1.15*v
end

# Volume guidelines:
# Character: 0.6-0.8
# Width: 0.3-0.5 (about half)
# Sub: 1.0-1.2 (can be loudest)
```
