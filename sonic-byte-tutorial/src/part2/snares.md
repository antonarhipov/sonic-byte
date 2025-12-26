# Snares and Claps

The snare provides the backbeat — the accent that defines the groove. In dark electronic music, snares should crack without being harsh.

## The Basic Snare

```ruby
define :snare do |v=1|
  sample :sn_dub, amp: v, rate: 0.85
end
```

### Why :sn_dub?

`:sn_dub` has a deep, weighty character that fits dark electronic. The `rate: 0.85` lowers the pitch further, making it less "snappy" and more "thuddy."

## Key Parameters

### rate (Pitch)

Lower rate = deeper, darker snare:

```ruby
sample :sn_dub, rate: 1.0   # Original pitch
sample :sn_dub, rate: 0.85  # Deeper, darker (our standard)
sample :sn_dub, rate: 0.75  # Very deep (Skull Fracture)
```

### amp (Volume)

Snares are typically quieter than kicks:

```ruby
kick 1      # Kick at 100%
snare 0.9   # Snare slightly under
```

## Snare Variations

### Standard (Most tracks)
```ruby
define :snare do |v=1|
  sample :sn_dub, amp: v, rate: 0.85
end
```

### Industrial (Track 2 - Nerve Damage)
```ruby
define :snare do |v=1|
  sample :sn_dub, amp: v, rate: 0.8
  sample :drum_snare_hard, amp: 0.4*v, rate: 0.9
end
```
Two layers: `:sn_dub` for body, `:drum_snare_hard` for crack.

### Heavy (Track 4 - Skull Fracture)
```ruby
define :snare do |v=1|
  sample :sn_dub, amp: v*1.1, rate: 0.75
  sample :drum_snare_hard, amp: 0.5*v, rate: 0.85
end
```
Lower rates across both layers for maximum weight.

### Tight (Track 3 - Chrome Cathedral)
```ruby
define :snare do |v=1|
  sample :sn_dub, amp: v*0.9, rate: 0.88
end
```
Slightly higher rate for a more controlled sound in the atmospheric track.

## Snare Samples

### Body Samples
- `:sn_dub` — Deep, weighty (primary choice)
- `:sn_dolf` — Snappy, electronic
- `:sn_zome` — Punchy, tight

### Crack/Layer Samples
- `:drum_snare_hard` — Sharp attack
- `:drum_snare_soft` — Gentler layer
- `:elec_snare` — Electronic character

## Claps

Claps can replace or layer with snares:

```ruby
define :clap do |v=1|
  sample :drum_snare_hard, amp: v*0.6, rate: 1.1
  sample :sn_dub, amp: v*0.4, rate: 0.9
end
```

Or use actual clap samples:

```ruby
sample :perc_snap, amp: 0.8, rate: 0.9
```

## Snare Placement

### Standard (Beats 2 and 4)
```ruby
in_thread do
  sleep 1; snare; sleep 1; snare; sleep 2
end
```

### Single (Beat 3 only - Chrome Cathedral)
```ruby
in_thread do
  sleep 2; snare; sleep 2
end
```
Half as many snares = more space, more atmospheric.

### Syncopated
```ruby
in_thread do
  sleep 1.5; snare 0.7; sleep 0.5  # Ghost snare
  snare; sleep 2
end
```

## Velocity Variation

```ruby
in_thread do
  sleep 1
  snare 1      # Beat 2: Full
  sleep 1
  snare 0.95   # Beat 4: Slightly softer
  sleep 2
end
```

Subtle variation creates groove.

## Quick Reference

```ruby
# Basic snare
define :snare do |v=1|
  sample :sn_dub, amp: v, rate: 0.85
end

# Layered snare (industrial)
define :snare do |v=1|
  sample :sn_dub, amp: v, rate: 0.8
  sample :drum_snare_hard, amp: 0.4*v, rate: 0.9
end

# Placement (beats 2 and 4)
in_thread do
  sleep 1; snare; sleep 1; snare; sleep 2
end

# Rate guide:
# 0.9+ = snappy, bright
# 0.85 = balanced (standard)
# 0.75-0.8 = deep, heavy
```
