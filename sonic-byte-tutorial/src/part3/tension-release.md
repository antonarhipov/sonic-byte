# Tension and Release

The tension-release cycle is fundamental to music. Creating tension makes release satisfying; constant intensity becomes exhausting.

## What Creates Tension

### 1. Removing Elements (Subtraction)

The most powerful technique — take things away:

```ruby
# MAIN section: Full elements
in_thread do
  drums 1, 0.9, 0.7
  bassline 1, 80
  melody 0.8
end

# BREAK section: Stripped
in_thread do
  # No kick, no bass
  hat 0.4
  with_fx :reverb, room: 0.9 do
    melody 0.5
  end
end
```

When elements return, the contrast is powerful.

### 2. High-Pass Filtering

Remove bass frequencies to create yearning:

```ruby
with_fx :hpf, cutoff: 90 do
  # Everything sounds thin, incomplete
  melody 0.6
  drums 0.5, 0.4, 0.5  # Even drums lose weight
end
```

### 3. Increasing Reverb

Sound becomes untethered, floating:

```ruby
# Normal
with_fx :reverb, room: 0.6, mix: 0.35 do
  melody 0.8
end

# Tension
with_fx :reverb, room: 0.95, mix: 0.65 do
  melody 0.5  # Sounds distant, yearning
end
```

### 4. Harmonic Tension

Use dissonant notes:

```ruby
# In D minor, these create tension:
lead :bb4  # b6 - dark, unresolved
lead :e4   # 2nd - wants to resolve
lead :ab4  # tritone - maximum tension
```

### 5. Risers

Building noise or synth:

```ruby
define :riser do |dur, v=1|
  use_synth :noise
  play :g2, amp: 0.4*v, attack: dur*0.9, release: dur*0.1,
       cutoff: 50, cutoff_slide: dur
end

# 8-beat riser before drop
riser 8, 0.8
```

## What Creates Release

### 1. Elements Returning

After subtraction, addition feels powerful:

```ruby
# After stripped break...
hit 1.5  # Impact!
drums 1.2, 1.1, 0.85  # Everything back, louder
bassline 1.1, 90      # Brighter than before
```

### 2. Filter Opening

Bass returning after high-pass:

```ruby
# Tension: high-passed
with_fx :hpf, cutoff: 90 do
  4.times { melody 0.5 }
end

# Release: full frequency
melody 0.9
bassline 1, 85  # Bass is back!
```

### 3. Resolution to Root

Melodies resolving to the key's root note:

```ruby
# Tension
lead :bb4; sleep 0.5  # Dark, unresolved
lead :a4; sleep 0.5   # Still tense

# Release
lead :d4; sleep 1     # Root note = home
```

### 4. The Hit/Impact

A punctuation mark signaling release:

```ruby
define :hit do |v=1|
  sample :bd_boom, amp: 2*v, rate: 0.4
  sample :drum_splash_hard, amp: 0.7*v
end

# After tension...
hit 1.5
# Release begins
```

## The Tension-Release Pattern

```ruby
# MAIN A: Full energy (48 beats)
in_thread do
  12.times { drums 1, 0.9, 0.7 }
end
in_thread do
  12.times { bassline 1, 80 }
end
sleep 48

# TENSION: Stripped (16-24 beats)
in_thread do
  with_fx :hpf, cutoff: 90 do
    16.times { hat 0.35; sleep 0.5 }
  end
end
in_thread do
  with_fx :reverb, room: 0.9, mix: 0.6 do
    melody 0.5
  end
end
in_thread do
  sleep 12
  riser 8, 0.8
end
sleep 24
hit 1.5

# RELEASE/MAIN B: Full energy, louder (48 beats)
in_thread do
  12.times { drums 1.15, 1.05, 0.8 }
end
in_thread do
  12.times { bassline 1.1, 88 }  # Brighter!
end
sleep 48
```

## Tension Duration

| Track Type | Tension Duration | Effect |
|------------|------------------|--------|
| Aggressive | 2-4 bars | Quick, punchy |
| Standard | 4-6 bars | Balanced |
| Atmospheric | 6-8 bars | Building dread |
| Climactic | 6 bars | Maximum anticipation |

## Tension Intensity

### Light Tension
Just reduce some elements:
```ruby
drums 0.6, 0.5, 0.6  # Quieter, but present
bassline 0.7, 70     # Filtered
```

### Medium Tension
Remove kick, high-pass:
```ruby
with_fx :hpf, cutoff: 80 do
  drums 0, 0.4, 0.5  # No kick
end
```

### Heavy Tension
Remove most elements:
```ruby
# Just hats and reverbed melody
hat 0.35
with_fx :reverb, room: 0.95, mix: 0.7 do
  melody 0.4
end
```

## Quick Reference

```ruby
# Creating tension:
# 1. Remove kick
drums 0, s, h

# 2. High-pass filter
with_fx :hpf, cutoff: 90 do ... end

# 3. More reverb
with_fx :reverb, room: 0.95, mix: 0.65 do ... end

# 4. Riser
riser 8, 0.8

# Creating release:
# 1. Hit/impact
hit 1.5

# 2. Everything returns, louder
drums 1.2, 1.1, 0.85
bassline 1.1, 90

# 3. Resolve to root note
lead :d4, 1, v  # Home
```
