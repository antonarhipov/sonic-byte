# Builds and Drops

The build is a promise. The drop is keeping it.

A good build makes the audience *need* the drop. They know it's coming. They're waiting for it. And when it finally hits, it's not just sound — it's release. All that tension, resolved in one moment.

Get this wrong and people check their phones. Get it right and they throw their hands up.

## The Basic Cycle

```
LOW ENERGY → BUILD → TENSION → DROP → HIGH ENERGY
```

Each phase has specific techniques:

## The Build

### 1. Filter Opening

The most common build technique — start filtered, open up:

```ruby
in_thread do
  with_fx :lpf, cutoff: 50, cutoff_slide: 32 do |fx|
    control fx, cutoff: 110  # Opens over 32 beats
    8.times { bassline 0.8 }
  end
end
```

The sound gets brighter as energy builds.

### 2. Adding Elements

Layer in elements progressively:

```ruby
# Bar 1-2: Kicks only
in_thread do
  8.times { kick 0.7; sleep 1 }
end

# Bar 3-4: Add hats
in_thread do
  sleep 8
  8.times { hat 0.5; sleep 0.5 }
end

# Bar 5-6: Add snares
in_thread do
  sleep 16
  snare 0.6; sleep 2; snare 0.6; sleep 2
  snare 0.7; sleep 2; snare 0.7; sleep 2
end

# Bar 7-8: Add bass
in_thread do
  sleep 24
  2.times { bassline 0.7 }
end

sleep 32
```

### 3. Rising Volume

Gradually increase amplitude:

```ruby
8.times do |i|
  drums (0.6 + i*0.05), (0.5 + i*0.05), (0.4 + i*0.04)
end
```

Volume rises from 0.6 to 0.95 over 8 bars.

### 4. Increasing Density

More notes = more energy:

```ruby
# Sparse (early build)
kick; sleep 1; kick; sleep 1; kick; sleep 1; kick; sleep 1

# Dense (late build)
kick; sleep 0.5; kick; sleep 0.5
kick; sleep 0.5; kick; sleep 0.5
kick; sleep 0.5; kick; sleep 0.5
kick; sleep 0.5; kick; sleep 0.5
```

### 5. Risers

Noise or synth rising in pitch/volume:

```ruby
define :riser do |dur, v=1|
  use_synth :noise
  play :g2, amp: 0.4*v, attack: dur*0.9, release: dur*0.1,
       cutoff: 50, cutoff_slide: dur
  with_fx :lpf, cutoff: 50, cutoff_slide: dur do |fx|
    control fx, cutoff: 120
  end
end

# Use at end of build
in_thread do
  sleep 24  # Wait until 8 beats before drop
  riser 8, 0.8
end
```

## The Tension

The moment before the drop — maximum anticipation:

### 1. Strip the Kick

Remove the foundation:

```ruby
# TENSION: 4 bars - no kick
in_thread do
  16.times { hat 0.4; sleep 0.5 }
end

in_thread do
  with_fx :hpf, cutoff: 90 do  # Remove bass frequencies
    4.times { snare 0.5; sleep 2 }
  end
end

sleep 16
```

### 2. High-Pass Everything

Remove low frequencies to create yearning for bass:

```ruby
with_fx :hpf, cutoff: 100 do
  with_fx :reverb, room: 0.9, mix: 0.6 do
    melody 0.5
  end
end
```

### 3. Increase Reverb

Sound floats, untethered:

```ruby
with_fx :reverb, room: 0.95, mix: 0.7 do
  with_fx :echo, phase: 1, decay: 6, mix: 0.55 do
    lead :d4, 2, 0.5
  end
end
```

### 4. The Pause

Sometimes, silence:

```ruby
# Last beat before drop
sleep 0.75
# Silence...
sleep 0.25
hit 1.5  # DROP
```

## The Drop

### 1. The Hit

Impact sound at the moment of drop:

```ruby
define :hit do |v=1|
  sample :bd_boom, amp: 2*v, rate: 0.4
  sample :drum_splash_hard, amp: 0.7*v, rate: 0.6
end

# End of tension
hit 1.5
# DROP begins
drums 1.2, 1.1, 0.85
```

### 2. Everything Returns

All elements at full power:

```ruby
# DROP: 12 bars
in_thread do
  12.times { drums 1.15, 1.05, 0.8 }
end

in_thread do
  12.times { bassline 1.1, 88 }  # Brighter cutoff
end

in_thread do
  6.times { melody 0.9 }
end

sleep 48
```

### 3. Louder Than Before

The drop should be louder than the section before the build:

| Section | Drums | Bass |
|---------|-------|------|
| Main A | 1.0 | 1.0 |
| Build | 0.6→0.95 | 0.7→0.9 |
| Tension | 0 (no kick) | 0 |
| **Drop** | **1.15** | **1.1** |

### 4. Filter Fully Open

Bass cutoff at maximum brightness:

```ruby
# Before drop
bassline 0.9, 75  # Cutoff 75

# At drop  
bassline 1.1, 90  # Cutoff 90 - brighter!
```

## Complete Build-Drop Example

```ruby
# BUILD: 8 bars
in_thread do
  with_fx :lpf, cutoff: 50, cutoff_slide: 28 do |fx|
    control fx, cutoff: 100
    8.times { |i| drums (0.65+i*0.04), (0.5+i*0.05), (0.45+i*0.04) }
  end
end

in_thread do
  with_fx :lpf, cutoff: 55, cutoff_slide: 28 do |fx|
    control fx, cutoff: 85
    8.times { bassline (0.6+i*0.04) }
  end
end

in_thread do
  sleep 24
  riser 8, 0.7
end

sleep 32

# TENSION: 4 bars
in_thread do
  with_fx :hpf, cutoff: 95 do
    16.times { hat 0.35; sleep 0.5 }
  end
end

in_thread do
  with_fx :reverb, room: 0.9, mix: 0.65 do
    melody 0.5
  end
end

sleep 15.75
# Brief silence
sleep 0.25

# DROP
hit 1.5

in_thread do
  12.times { drums 1.15, 1.05, 0.85 }
end

in_thread do
  12.times { bassline 1.1, 90 }
end

in_thread do
  with_fx :reverb, room: 0.5, mix: 0.3 do
    6.times { melody 0.95 }
  end
end

sleep 48
```

## Drop Variations

### The Fake Drop

Build expectation, then deny it:

```ruby
# FAKE DROP: Silence instead of drop
sleep 16  # Tension...
# Listeners expect drop here
sleep 4   # More silence!
hit 1.8   # REAL drop (bigger because delayed)
```

Used in: Skull Fracture

### The Half Drop

Partial return of elements:

```ruby
# HALF DROP: Just drums, no bass
in_thread do
  4.times { drums 1, 0.9, 0.7 }
end
sleep 16

# FULL DROP: Everything
in_thread do
  12.times { drums 1.15, 1.05, 0.85 }
end
in_thread do
  12.times { bassline 1.1, 90 }
end
```

### The Slow Drop

Elements fade in rather than slam:

```ruby
# SLOW DROP: 4 bars of building into full
in_thread do
  4.times { |i| drums (0.7+i*0.12), (0.6+i*0.12), (0.5+i*0.1) }
  12.times { drums 1.15, 1.05, 0.85 }
end
```

Used in: Chrome Cathedral (atmospheric track)

## Quick Reference

**Build techniques:**
- Filter opening (lpf cutoff slide up)
- Adding elements progressively
- Rising volume
- Increasing note density
- Risers

**Tension techniques:**
- Remove kick
- High-pass filter
- Increase reverb
- Silence/pause

**Drop techniques:**
- Hit/impact sound
- All elements return
- Louder than before
- Filter fully open
