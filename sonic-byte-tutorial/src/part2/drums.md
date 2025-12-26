# Drum Programming

Drums are the backbone of dark electronic music. They provide the driving force that moves bodies and creates hypnotic grooves.

## The Core Elements

### Kick Drum

The kick is the heartbeat. In dark electronic, it needs to hit hard.

```ruby
define :kick do |v=1|
  sample :bd_tek, amp: 2*v, rate: 0.9
  sample :bd_boom, amp: 0.5*v, rate: 1.2, cutoff: 70
end
```

**Why two layers?**
- `bd_tek` — Provides the punchy attack
- `bd_boom` — Adds low-end weight

**Key parameters:**
- `rate: 0.9` — Slightly lowers pitch for more weight
- `cutoff: 70` — Removes high frequencies from the boom layer

### Snare

The snare provides accent and groove:

```ruby
define :snare do |v=1|
  sample :sn_dub, amp: v, rate: 0.85
end
```

For more aggressive tracks:

```ruby
define :snare do |v=1|
  sample :sn_dub, amp: v, rate: 0.8
  sample :drum_snare_hard, amp: 0.5*v, rate: 0.88
end
```

### Hi-Hats

Hi-hats provide rhythmic texture:

```ruby
define :hat do |v=1|
  sample :drum_cymbal_closed, amp: 0.25*v, rate: 2.2, release: 0.05
end
```

**Key parameters:**
- `rate: 2.2` — Higher pitch, more metallic
- `release: 0.05` — Short, tight decay

## Basic Patterns

### Four-on-the-Floor

The classic electronic drum pattern:

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

**Pattern visualization:**
```text
Beat:   1       2       3       4
Kick:   X       X       X       X
Snare:          X               X
Hat:    x   x   x   x   x   x   x   x
```

### Syncopated Kicks

More interesting than straight four-on-the-floor:

```ruby
define :drums_synco do |k=1, s=1, h=1|
  in_thread do
    kick k; sleep 0.75
    kick k*0.6; sleep 0.25
    kick k*0.85; sleep 1
    kick k; sleep 0.75
    kick k*0.55; sleep 0.25
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

**Pattern:**
```text
Beat:   1   .   2       3   .   4
Kick:   X x     X       X x     X
        1 .75           1 .75
```

The ghost kicks at 0.75 create groove.

### Double-Time Kicks

For maximum aggression (used in Nerve Damage):

```ruby
define :drums_x do |k=1, s=1, h=1|
  in_thread do
    8.times do
      kick k * (0.7 + rand(0.3))  # Slight velocity variation
      sleep 0.5
    end
  end
  in_thread do
    sleep 1; snare s; sleep 1; snare s; sleep 2
  end
  in_thread do
    16.times { hat h * 0.8; sleep 0.25 }
  end
  sleep 4
end
```

8 kicks per bar = relentless energy.

### Half-Time Feel

Slower, heavier (used in Void Walker):

```ruby
define :drums_half do |k=1, s=1, h=1|
  in_thread do
    kick k; sleep 2
    kick k*0.7; sleep 0.5
    kick k*0.8; sleep 1.5
  end
  in_thread do
    sleep 2; snare s; sleep 2
  end
  in_thread do
    8.times { hat h; sleep 0.5 }
  end
  sleep 4
end
```

## Velocity Variation

Static velocity = robotic and boring. Add variation:

```ruby
define :drums do |k=1, s=1, h=1|
  in_thread do
    kick k        # Beat 1: Full
    sleep 1
    kick k*0.8    # Beat 2: Slightly softer
    sleep 1
    kick k*0.9    # Beat 3: Almost full
    sleep 1
    kick k*0.85   # Beat 4: Medium
    sleep 1
  end
  # ...
end
```

This creates groove even with straight timing.

## Building Energy

### Progressive Intensity

Drums should build through a track:

```ruby
# Intro: Reduced elements
8.times { drums 0.7, 0, 0.4 }      # Kicks + hats only

# Build: Add snares
8.times { drums 0.85, 0.6, 0.55 }  # All elements, building

# Main: Full power
12.times { drums 1, 0.9, 0.7 }     # Strong

# Peak: Maximum
12.times { drums 1.15, 1, 0.8 }    # Pushed
```

### Fading Out

For outros:

```ruby
6.times do |i|
  drums (1-i*0.12), (0.85-i*0.1), (0.7-i*0.08)
end
```

Each iteration gets quieter.

## Pattern Variations

Keep things interesting with multiple patterns:

```ruby
define :drums_a do |k=1, s=1, h=1|
  # Standard pattern
end

define :drums_b do |k=1, s=1, h=1|
  # Fill/variation pattern
end

# Usage
3.times { drums_a 1, 0.9, 0.7 }  # 3 bars normal
drums_b 1, 0.9, 0.7              # 1 bar fill
```

## The Hit Function

Impact moments need special treatment:

```ruby
define :hit do |v=1|
  sample :bd_boom, amp: 2*v, rate: 0.4
  sample :drum_splash_hard, amp: 0.7*v, rate: 0.6
end
```

Used at section transitions:

```ruby
8.times { drums 0.9, 0.7, 0.6 }
hit 1.2  # Impact before new section
8.times { drums 1, 0.9, 0.8 }
```

## Quick Reference

```ruby
# Basic kick
define :kick do |v=1|
  sample :bd_tek, amp: 2*v, rate: 0.9
  sample :bd_boom, amp: 0.5*v, rate: 1.2
end

# Basic snare
define :snare do |v=1|
  sample :sn_dub, amp: v, rate: 0.85
end

# Basic hat
define :hat do |v=1|
  sample :drum_cymbal_closed, amp: 0.25*v, rate: 2.2
end

# Standard pattern
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

---

Next chapters cover the individual drum elements in more detail: kick drums, snares, hi-hats, and pattern construction.
