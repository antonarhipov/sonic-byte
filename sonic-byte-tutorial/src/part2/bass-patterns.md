# Writing Bass Patterns

Bass patterns drive the groove. They need to lock with the kick drum while providing harmonic interest.

## The Basic Pattern

A simple 4-beat bass pattern:

```ruby
define :bassline do |v=1, c=80|
  bass :d2, v, c; sleep 1
  bass :d2, v*0.7, c-10; sleep 1
  bass :f2, v*0.9, c; sleep 1
  bass :d2, v, c; sleep 1
end
```

### Pattern Elements

1. **Root note** (:d2) — Anchors the key
2. **Ghost note** (v*0.7, c-10) — Adds groove
3. **Movement** (:f2) — Harmonic interest
4. **Return** (:d2) — Resolution

## Velocity Variation

Static velocity = boring. Vary it:

```ruby
bass :d2, v, c        # Full velocity
bass :d2, v*0.7, c    # Softer (ghost)
bass :f2, v*0.9, c    # Slightly reduced
bass :d2, v*0.8, c    # Medium
bass :a2, v, c        # Full (accent)
```

**Rule:** Strong beats get full velocity, weak beats get reduced.

## Cutoff Variation

Add movement with filter changes:

```ruby
bass :d2, v, c        # Main cutoff
bass :d2, v*0.7, c-10 # Darker (muted)
bass :f2, v*0.9, c+5  # Brighter (accent)
```

Even ±5-10 on cutoff adds subtle life.

## Rhythmic Patterns

### Quarter Notes (Simple)
```ruby
bass :d2, v, c; sleep 1
bass :d2, v, c; sleep 1
bass :d2, v, c; sleep 1
bass :d2, v, c; sleep 1
```

### Eighth Notes (Driving)
```ruby
bass :d2, v, c; sleep 0.5
bass :d2, v*0.6, c-8; sleep 0.5
bass :d2, v*0.8, c; sleep 0.5
bass :d2, v*0.5, c-10; sleep 0.5
# ... continue
```

### Syncopated
```ruby
bass :d2, v, c; sleep 0.75
bass :d2, v*0.7, c-10; sleep 0.25
bass :f2, v*0.9, c; sleep 0.5
bass :d2, v*0.8, c; sleep 0.5
# ...
```

The 0.75 + 0.25 creates swing.

## Harmonic Movement

### In Key Movement (D Minor)

```ruby
# D minor scale: D E F G A Bb C
bass :d2, v, c; sleep 1    # Root
bass :f2, v, c; sleep 1    # Minor 3rd
bass :g2, v, c; sleep 1    # 4th
bass :a2, v, c; sleep 1    # 5th
```

### Common Intervals

| Interval | From D | Character |
|----------|--------|-----------|
| Root | D | Stable, home |
| Minor 3rd | F | Dark color |
| 4th | G | Movement |
| 5th | A | Power |
| Minor 6th | Bb | Very dark |
| Minor 7th | C | Tension |

### Pattern by Key

**D Minor (Tracks 1, 8):**
```ruby
bass :d2; bass :f2; bass :a2; bass :d2
```

**E Minor (Track 2):**
```ruby
bass :e2; bass :g2; bass :b2; bass :e2
```

**G Minor (Track 7):**
```ruby
bass :g2; bass :bb2; bass :d2; bass :g2
```

## Multiple Pattern Variations

Create variety with A/B patterns:

```ruby
define :bass1 do |v=1, c=80|
  bass :d2, v, c; sleep 0.5
  bass :d2, v*0.6, c-8; sleep 0.5
  bass :f2, v*0.85, c; sleep 0.5
  bass :d2, v*0.75, c; sleep 0.5
  bass :a2, v*0.9, c+5; sleep 0.5
  bass :d2, v, c; sleep 1.5
end

define :bass2 do |v=1, c=80|
  bass :d2, v, c; sleep 0.75
  bass :f2, v*0.8, c; sleep 0.25
  bass :g2, v*0.9, c; sleep 0.5
  bass :a2, v, c+5; sleep 0.5
  bass :bb2, v*0.85, c; sleep 0.5  # Dark note!
  bass :a2, v*0.7, c; sleep 0.5
  bass :d2, v, c; sleep 1
end

# Usage
4.times do
  bass1 1, 80
  bass2 1, 80
end
```

## Locking with Kick

Bass and kick should complement, not fight:

```ruby
# Kick on beats 1, 2, 3, 4
# Bass leaves space or aligns

# Good: Bass and kick together
kick; bass :d2; sleep 1

# Good: Bass between kicks
kick; sleep 0.5; bass :d2; sleep 0.5

# Careful: Bass just before kick (can muddy)
bass :d2; sleep 0.125; kick; sleep 0.875
```

## Space in Patterns

Don't fill every beat:

```ruby
# Too busy
bass :d2; sleep 0.5
bass :d2; sleep 0.5
bass :d2; sleep 0.5
bass :d2; sleep 0.5
# ... no rest

# Better: Leave space
bass :d2, v, c; sleep 1
bass :d2, v*0.7, c; sleep 1
bass :f2, v, c; sleep 1
sleep 1  # Rest - space to breathe
```

## Quick Reference

```ruby
# Basic pattern (4 beats)
define :bassline do |v=1, c=80|
  bass :d2, v, c; sleep 1
  bass :d2, v*0.7, c-10; sleep 1
  bass :f2, v*0.9, c; sleep 1
  bass :d2, v, c; sleep 1
end

# Velocity variation
v, v*0.7, v*0.9, v*0.8, v  # Full, ghost, medium, medium, full

# Cutoff variation
c, c-10, c+5, c  # Main, dark, bright, main

# Common movements (D minor)
:d2 → :f2 → :a2 → :d2  # Root, 3rd, 5th, root
:d2 → :g2 → :a2 → :d2  # Root, 4th, 5th, root
:d2 → :f2 → :bb2 → :a2 → :d2  # With dark Bb
```
