# The ADSR Envelope

Every sound has a shape over time. The ADSR envelope controls that shape.

## What is ADSR?

ADSR stands for:
- **A**ttack — How quickly the sound reaches full volume
- **D**ecay — How quickly it drops to the sustain level
- **S**ustain — The level held while the note plays
- **R**elease — How quickly it fades after the note ends

```
Volume
  │    ┌──────┐
  │   /│      │\
  │  / │      │ \
  │ /  │      │  \
  │/   │      │   \
  └────┴──────┴────────► Time
   A    D   S    R
```

## In Sonic Pi

```ruby
use_synth :prophet
play :c4,
  attack: 0.1,    # 0.1 beats to reach full volume
  decay: 0.2,     # 0.2 beats to drop to sustain
  sustain: 0.5,   # Hold for 0.5 beats
  release: 0.3    # 0.3 beats to fade out
```

Total note duration = attack + decay + sustain + release = 1.1 beats

## ADSR for Different Sounds

### Punchy Bass (short, percussive)
```ruby
attack: 0.01,   # Instant attack
decay: 0.2,     # Quick drop
sustain: 0.1,   # Short sustain
release: 0.15   # Quick release
```
**Character:** Tight, rhythmic, punchy

### Pad (slow, evolving)
```ruby
attack: 1.5,    # Slow fade in
decay: 0.5,     # Gentle drop
sustain: 2.0,   # Long sustain
release: 2.0    # Long fade out
```
**Character:** Atmospheric, washy, ambient

### Lead (expressive)
```ruby
attack: 0.05,   # Quick but not instant
decay: 0.25,    # Moderate drop
sustain: 0.4,   # Medium sustain
release: 0.5    # Smooth fade
```
**Character:** Musical, expressive, singable

### Stab (aggressive hit)
```ruby
attack: 0,      # Instant
decay: 0.1,     # Very quick
sustain: 0.05,  # Almost none
release: 0.1    # Quick fade
```
**Character:** Aggressive, punchy, rhythmic

## Relative vs Absolute Duration

You can make ADSR relative to a note duration parameter:

```ruby
define :lead do |n, dur=0.5, v=1|
  use_synth :prophet
  play n,
    amp: v,
    attack: dur * 0.1,     # 10% of duration
    decay: dur * 0.25,     # 25% of duration
    sustain: dur * 0.4,    # 40% of duration
    release: dur * 0.5     # 50% of duration (overlaps next note slightly)
end

lead :c4, 0.5   # Short note
lead :c4, 2.0   # Long note (same proportions)
```

This keeps the same "feel" regardless of note length.

## Attack Shapes

### Zero Attack (instant)
```ruby
attack: 0
```
- Used for: Drums, stabs, bass
- Creates: Punchy, percussive sounds

### Short Attack (0.01-0.05)
```ruby
attack: 0.03
```
- Used for: Most bass, leads
- Creates: Quick but slightly softer entry

### Medium Attack (0.05-0.2)
```ruby
attack: 0.1
```
- Used for: Expressive leads, pads
- Creates: More musical, less aggressive

### Long Attack (0.5+)
```ruby
attack: 1.5
```
- Used for: Pads, atmospheric sounds
- Creates: Swelling, evolving textures

## Release and Legato

Release affects how notes connect:

### Short Release (staccato)
```ruby
play :c4, release: 0.1
sleep 1
play :d4, release: 0.1
```
Notes are clearly separated.

### Long Release (legato)
```ruby
play :c4, release: 0.8
sleep 0.5
play :d4, release: 0.8
```
Notes overlap, creating smoother transitions.

## ADSR in the Album

### Kick Drum Pattern
Kicks don't use ADSR directly (samples), but the concept applies:
- Instant attack (the transient)
- Quick decay (the punch)
- Minimal sustain
- Short release (tight low end)

### TB303 Bass
```ruby
use_synth :tb303
play :d2,
  attack: 0.01,
  decay: 0.2,
  sustain: 0.1,
  release: 0.15
```
Quick attack for punch, short overall for rhythmic bass lines.

### Prophet Lead
```ruby
use_synth :prophet
play :d4,
  attack: 0.05,
  decay: 0.25,
  sustain: 0.4,
  release: 0.5
```
Slightly softer attack for musical feel, longer release for expression.

### Dark Ambience Pad
```ruby
use_synth :dark_ambience
play :d3,
  attack: 1.5,
  sustain: 2.5,
  release: 3
```
Slow everything for atmospheric, evolving texture.

## Quick Reference

| Sound Type | Attack | Decay | Sustain | Release |
|------------|--------|-------|---------|---------|
| Punchy Bass | 0.01 | 0.2 | 0.1 | 0.15 |
| Lead | 0.05 | 0.25 | 0.4 | 0.5 |
| Stab | 0 | 0.1 | 0.05 | 0.1 |
| Pad | 1.5 | 0.5 | 2.0 | 2.0 |
| Arp Note | 0.01 | 0.1 | 0.05 | 0.1 |

## Tips

1. **Start with presets** — Use the values above as starting points
2. **Match the rhythm** — Faster BPM often needs shorter ADSR
3. **Leave space** — Not everything needs long sustain
4. **Release > Sleep** — Notes can ring past the next sleep for legato
5. **Attack affects feel** — Even 0.01 vs 0.05 changes the vibe significantly
