# Volume Automation

Volume changes over time create movement and energy. Static volumes sound lifeless.

## The Volume Parameter

Every sound function uses a volume parameter:

```ruby
define :kick do |v=1|
  sample :bd_tek, amp: 2.2*v
end

kick 1      # Full volume (amp = 2.2)
kick 0.5    # Half volume (amp = 1.1)
kick 1.2    # Boosted (amp = 2.64)
```

## Progressive Volume Changes

### Building Up

```ruby
8.times do |i|
  # i goes: 0, 1, 2, 3, 4, 5, 6, 7
  volume = 0.6 + i*0.05  # 0.6, 0.65, 0.7, 0.75, 0.8, 0.85, 0.9, 0.95
  drums volume, volume*0.85, volume*0.7
end
```

### Fading Down

```ruby
6.times do |i|
  volume = 1.0 - i*0.12  # 1.0, 0.88, 0.76, 0.64, 0.52, 0.4
  drums volume, volume*0.9, volume*0.7
end
```

### Custom Curves

```ruby
# Exponential build (slow start, fast finish)
volumes = [0.5, 0.55, 0.62, 0.71, 0.82, 0.9, 0.96, 1.0]
volumes.each do |v|
  drums v, v*0.9, v*0.7
end

# S-curve (slow-fast-slow)
volumes = [0.5, 0.55, 0.65, 0.8, 0.9, 0.95, 0.98, 1.0]
```

## Section Volume Levels

### Intro
```ruby
drums 0.7, 0, 0.4        # Kicks + hats, no snare
bassline 0.5, 50         # Quiet, filtered
```

### Build
```ruby
drums 0.85, 0.7, 0.55    # Growing
bassline 0.75, 68        # More present
```

### Main
```ruby
drums 1, 0.9, 0.7        # Full
bassline 1, 80           # Full
melody 0.8               # Present but not dominant
```

### Break
```ruby
drums 0, 0, 0.35         # Just hats (or nothing)
# No bass
melody 0.5               # Quiet, reverbed
```

### Peak
```ruby
drums 1.15, 1.05, 0.85   # Louder than main
bassline 1.1, 88         # Louder, brighter
melody 0.95              # Strong
```

### Outro
```ruby
# Fading over 6 bars
6.times { |i| drums (1-i*0.12), (0.85-i*0.1), (0.7-i*0.08) }
```

## Element Balance

Not everything should be the same volume:

| Element | Typical Range | Role |
|---------|---------------|------|
| Kick | amp: 2.0-2.5 | Foundation |
| Snare | amp: 0.8-1.1 | Accent |
| Hat | amp: 0.2-0.3 | Texture |
| Bass | amp: 0.6-0.9 (synth) | Body |
| Sub | amp: 1.0-1.2 | Weight |
| Lead | amp: 0.35-0.45 | Melody |
| Arp | amp: 0.2-0.3 | Rhythm |
| Pad | amp: 0.25-0.4 | Atmosphere |

## Velocity Variation Within Patterns

Add life with subtle variation:

```ruby
define :bassline do |v=1, c=80|
  bass :d2, v, c; sleep 0.5
  bass :d2, v*0.7, c-10; sleep 0.5    # Ghost note
  bass :f2, v*0.9, c; sleep 0.5       # Slightly softer
  bass :d2, v*0.8, c; sleep 0.5       # Medium
  bass :a2, v, c+5; sleep 0.5         # Accent (full)
  bass :d2, v, c; sleep 1.5           # Resolution (full)
end
```

## Automation Patterns

### Swell
```ruby
# Quiet → loud → quiet
volumes = [0.4, 0.6, 0.8, 1.0, 0.8, 0.6, 0.4]
volumes.each do |v|
  melody v
end
```

### Pulse
```ruby
# Alternating loud/soft
8.times do |i|
  v = i.even? ? 1.0 : 0.7
  drums v, v*0.9, v*0.7
end
```

### Ramp
```ruby
# Steady increase
16.times do |i|
  v = 0.5 + (i * 0.03125)  # 0.5 to 1.0 over 16 bars
  drums v, v*0.9, v*0.7
end
```

## Quick Reference

```ruby
# Building volume
8.times { |i| drums (0.6+i*0.05) }

# Fading volume
6.times { |i| drums (1-i*0.12) }

# Section volumes
# Intro:  0.5-0.7
# Build:  0.7-0.95
# Main:   1.0
# Break:  0.3-0.5
# Peak:   1.1-1.2
# Outro:  1.0→0.3

# Velocity variation in patterns
v, v*0.7, v*0.9, v*0.8, v  # Full, ghost, medium, medium, full
```
