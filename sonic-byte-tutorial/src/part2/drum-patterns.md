# Building Drum Patterns

Individual drum sounds combine into patterns. The pattern is where groove lives.

## The Standard Pattern

```ruby
define :drums do |k=1, s=1, h=1|
  in_thread do
    4.times { kick k; sleep 1 }
  end
  in_thread do
    sleep 1; snare s; sleep 1; snare s; sleep 2
  end
  in_thread do
    8.times { hat h; sleep 0.5 }
  end
  sleep 4
end
```

### Visualized
```
Beat:   1       2       3       4
Kick:   X       X       X       X
Snare:          X               X
Hat:    x   x   x   x   x   x   x   x
```

### The Final Sleep

The `sleep 4` at the end is crucial — it makes the function take 4 beats total, allowing:

```ruby
8.times { drums 1, 0.9, 0.7 }  # Plays 8 bars correctly
```

## Pattern Variations

### Syncopated Kicks
```ruby
define :drums_synco do |k=1, s=1, h=1|
  in_thread do
    kick k; sleep 0.75
    kick k*0.6; sleep 0.25  # Ghost kick
    kick k*0.85; sleep 1
    kick k; sleep 0.75
    kick k*0.55; sleep 0.25  # Ghost kick
    kick k*0.9; sleep 1
  end
  in_thread do
    sleep 1; snare s; sleep 1; snare s; sleep 2
  end
  in_thread do
    8.times { hat h; sleep 0.5 }
  end
  sleep 4
end
```

The ghost kicks at 0.75 create swing and groove.

### Double-Time (Aggressive)
```ruby
define :drums_x do |k=1, s=1, h=1|
  in_thread do
    8.times { kick k; sleep 0.5 }  # 8 kicks per bar
  end
  in_thread do
    sleep 1; snare s; sleep 1; snare s; sleep 2
  end
  in_thread do
    16.times { hat h; sleep 0.25 }  # 16th note hats
  end
  sleep 4
end
```

Used in: Nerve Damage, Skull Fracture

### Half-Time (Heavy)
```ruby
define :drums_half do |k=1, s=1, h=1|
  in_thread do
    kick k; sleep 2
    kick k*0.7; sleep 0.5
    kick k*0.8; sleep 1.5
  end
  in_thread do
    sleep 2; snare s; sleep 2  # Snare on beat 3 only
  end
  in_thread do
    8.times { hat h; sleep 0.5 }
  end
  sleep 4
end
```

Used in: Void Walker — fewer hits, more impact.

### Stripped (Intro/Outro)
```ruby
define :drums_intro do |k=1, h=1|
  in_thread do
    4.times { kick k; sleep 1 }
  end
  in_thread do
    8.times { hat h; sleep 0.5 }
  end
  sleep 4
end
```

No snare — creates anticipation.

## Combining Patterns

Use multiple patterns for variation:

```ruby
define :drums_a do |k=1, s=1, h=1|
  # Main pattern
end

define :drums_b do |k=1, s=1, h=1|
  # Fill/variation pattern
end

# Usage: 3 bars normal, 1 bar fill
3.times { drums_a 1, 0.9, 0.7 }
drums_b 1, 0.9, 0.7
```

## Velocity Curves

### Building Energy
```ruby
8.times do |i|
  drums (0.6 + i*0.05), (0.5 + i*0.05), (0.4 + i*0.04)
end
```
Volume rises from 0.6 to 0.95 over 8 bars.

### Fading Out
```ruby
6.times do |i|
  drums (1 - i*0.12), (0.9 - i*0.1), (0.7 - i*0.08)
end
```
Volume falls from 1.0 to 0.28 over 6 bars.

## Pattern Density by Section

| Section | Kicks/bar | Hats/bar | Feel |
|---------|-----------|----------|------|
| Intro | 4 | 8 | Driving, clean |
| Build | 4→8 | 8→16 | Increasing |
| Main | 4-6 | 8 | Groovy |
| Break | 0-2 | 8 | Floating |
| Peak | 6-8 | 8-16 | Intense |
| Outro | 4→0 | 8→0 | Fading |

## The Hit Function

For transitions:

```ruby
define :hit do |v=1|
  sample :bd_boom, amp: 2*v, rate: 0.4
  sample :drum_splash_hard, amp: 0.7*v, rate: 0.6
end

# Usage
8.times { drums 0.9, 0.8, 0.7 }
hit 1.2  # Impact!
8.times { drums 1, 0.9, 0.8 }
```

## Quick Reference

```ruby
# Standard 4/4 pattern
define :drums do |k=1, s=1, h=1|
  in_thread do
    4.times { kick k; sleep 1 }
  end
  in_thread do
    sleep 1; snare s; sleep 1; snare s; sleep 2
  end
  in_thread do
    8.times { hat h; sleep 0.5 }
  end
  sleep 4  # Important!
end

# Syncopated pattern
define :drums_synco do |k=1, s=1, h=1|
  in_thread do
    kick k; sleep 0.75
    kick k*0.6; sleep 0.25
    kick k*0.85; sleep 1
    kick k; sleep 0.75
    kick k*0.55; sleep 0.25
    kick k*0.9; sleep 1
  end
  # ... snare and hat threads
  sleep 4
end

# Building energy
8.times { |i| drums (0.6+i*0.05), (0.5+i*0.05), (0.4+i*0.04) }

# Fading out
6.times { |i| drums (1-i*0.12), (0.9-i*0.1), (0.7-i*0.08) }
```
