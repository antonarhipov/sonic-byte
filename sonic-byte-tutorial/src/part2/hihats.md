# Hi-Hats and Percussion

Hi-hats provide rhythmic texture and forward momentum. In dark electronic music, they should be crisp and metallic without being harsh.

## The Basic Hi-Hat

```ruby
define :hat do |v=1|
  sample :drum_cymbal_closed, amp: 0.25*v, rate: 2.2, release: 0.05
end
```

### Key Parameters

**rate: 2.2** — Higher rate = higher pitch = more metallic  
**release: 0.05** — Short release = tight, crisp  
**amp: 0.25** — Quiet relative to kick/snare

## Hi-Hat Samples

### Closed Hi-Hats
- `:drum_cymbal_closed` — Our primary choice
- `:drum_cymbal_pedal` — Softer attack
- `:elec_tick` — Electronic, clicky

### Open Hi-Hats (Accents)
- `:drum_cymbal_open` — Sustained ring
- `:drum_cymbal_soft` — Gentle accent

## Rate Variations

```ruby
sample :drum_cymbal_closed, rate: 1.5  # Lower, softer
sample :drum_cymbal_closed, rate: 2.0  # Balanced
sample :drum_cymbal_closed, rate: 2.2  # Bright, metallic (standard)
sample :drum_cymbal_closed, rate: 2.5  # Very bright, aggressive
```

Higher rate = brighter, more cutting.

## Hi-Hat Patterns

### Eighth Notes (Standard)
```ruby
in_thread do
  8.times { hat; sleep 0.5 }
end
```
Hi-hat on every eighth note. Classic, driving.

### Sixteenth Notes (Intense)
```ruby
in_thread do
  16.times { hat; sleep 0.25 }
end
```
Double the density for aggressive tracks (Nerve Damage, Skull Fracture).

### Syncopated
```ruby
in_thread do
  hat; sleep 0.5
  hat; sleep 0.25
  hat; sleep 0.25
  hat; sleep 0.5
  hat; sleep 0.5
  hat; sleep 0.5
  hat; sleep 0.25
  hat; sleep 0.25
  hat; sleep 0.5
end
```

## Velocity Variation

Static hi-hats sound mechanical. Add subtle variation:

```ruby
in_thread do
  8.times do |i|
    v = [1, 0.7, 0.85, 0.75, 0.95, 0.7, 0.8, 0.9][i]
    hat v
    sleep 0.5
  end
end
```

Or randomize slightly:

```ruby
in_thread do
  8.times do
    hat (0.7 + rand(0.3))  # Random between 0.7 and 1.0
    sleep 0.5
  end
end
```

## Open Hi-Hat Accents

Add open hats for emphasis:

```ruby
define :hat_open do |v=1|
  sample :drum_cymbal_open, amp: 0.3*v, rate: 1.8, release: 0.2
end

# Pattern with open hat accent
in_thread do
  3.times { hat; sleep 0.5 }
  hat_open  # Accent before beat 3
  sleep 0.5
  4.times { hat; sleep 0.5 }
end
```

## Hi-Hats by Track Type

### Standard (Most tracks)
```ruby
define :hat do |v=1|
  sample :drum_cymbal_closed, amp: 0.25*v, rate: 2.2, release: 0.05
end
```

### Aggressive (Tracks 2, 4)
```ruby
define :hat do |v=1|
  sample :drum_cymbal_closed, amp: 0.22*v, rate: 2.4, release: 0.04
end
```
Lower amp (more hats = less per hat), higher rate (brighter).

### Atmospheric (Track 3)
```ruby
define :hat do |v=1|
  sample :drum_cymbal_closed, amp: 0.28*v, rate: 2.0, release: 0.06
end
```
Lower rate for a softer, less aggressive sound.

## Hi-Hat Dynamics Through Sections

| Section | Hi-Hat amp | Character |
|---------|------------|-----------|
| Intro | 0.4-0.5 | Quiet, atmospheric |
| Build | 0.55-0.7 | Growing presence |
| Main | 0.7-0.8 | Full presence |
| Break | 0.35-0.45 | Stripped back |
| Peak | 0.8-0.85 | Maximum energy |
| Outro | 0.7→0.3 | Fading |

## Percussion Beyond Hi-Hats

### Shakers
```ruby
sample :drum_cymbal_closed, amp: 0.15, rate: 3.0, release: 0.03
```
Very high rate, very short = shaker-like.

### Rides
```ruby
sample :drum_cymbal_open, amp: 0.2, rate: 1.5, release: 0.3
```
Lower rate, longer release = ride cymbal.

### Metallic Textures
```ruby
sample :elec_tick, amp: 0.3, rate: 1.2
sample :elec_ping, amp: 0.2, rate: 0.8
```

## Quick Reference

```ruby
# Basic hi-hat
define :hat do |v=1|
  sample :drum_cymbal_closed, amp: 0.25*v, rate: 2.2, release: 0.05
end

# Open hi-hat
define :hat_open do |v=1|
  sample :drum_cymbal_open, amp: 0.3*v, rate: 1.8, release: 0.2
end

# Eighth note pattern
in_thread do
  8.times { hat; sleep 0.5 }
end

# Sixteenth note pattern
in_thread do
  16.times { hat; sleep 0.25 }
end
```
