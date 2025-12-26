# Writing Dark Melodies

Dark melodies walk the line between menacing and musical. They should feel dark but remain satisfying to hear.

## The Minor Key Foundation

All tracks in *Sonic Byte* use minor keys:

| Track | Key | Character |
|-------|-----|-----------|
| 1, 8 | D Minor | Dark, powerful |
| 2 | E Minor | Aggressive |
| 3 | A Minor | Atmospheric |
| 4 | F Minor | Very dark |
| 5 | C Minor | Emotional |
| 6 | B Minor | Deep |
| 7 | G Minor | Climactic |

## Dark vs Happy

**Too happy (avoid):**
```ruby
lead :d4; sleep 0.5
lead :fs4; sleep 0.5   # F# = major 3rd = happy
lead :a4; sleep 0.5
```

**Dark but musical:**
```ruby
lead :d4; sleep 0.5
lead :f4; sleep 0.5    # F = minor 3rd = dark
lead :a4; sleep 0.5
```

The difference: F vs F#. Minor third (F) sounds dark; major third (F#) sounds happy.

## Key Dark Intervals

From any root note, these intervals add darkness:

| Interval | Semitones | Character |
|----------|-----------|-----------|
| Minor 2nd | 1 | Tense, dissonant |
| Minor 3rd | 3 | Dark, sad |
| Tritone | 6 | Very tense |
| Minor 6th | 8 | Dark, yearning |
| Minor 7th | 10 | Bluesy, unresolved |

### Examples in D Minor
```ruby
lead :d4; lead :eb4   # Minor 2nd - tension
lead :d4; lead :f4    # Minor 3rd - dark
lead :d4; lead :ab4   # Tritone - extreme tension
lead :d4; lead :bb4   # Minor 6th - yearning
lead :d4; lead :c5    # Minor 7th - unresolved
```

## Melodic Patterns

### Rising (Builds energy)
```ruby
define :mel_rise do |v=1|
  lead :d4, 0.5, v; sleep 0.5
  lead :f4, 0.5, v*0.95; sleep 0.5
  lead :a4, 0.5, v; sleep 0.5
  lead :d5, 1, v; sleep 1
end
```

### Falling (Releases tension)
```ruby
define :mel_fall do |v=1|
  lead :d5, 0.5, v; sleep 0.5
  lead :c5, 0.5, v*0.9; sleep 0.5
  lead :a4, 0.5, v*0.95; sleep 0.5
  lead :f4, 0.5, v*0.85; sleep 0.5
  lead :d4, 1, v; sleep 1
end
```

### Tension and Resolution
```ruby
define :mel_tension do |v=1|
  lead :d4, 0.5, v; sleep 0.5
  lead :f4, 0.5, v; sleep 0.5
  lead :bb4, 0.75, v; sleep 0.75  # Bb = tension
  lead :a4, 0.5, v*0.9; sleep 0.5
  lead :d4, 1, v; sleep 1.25      # Resolve to root
end
```

## Velocity as Expression

Vary velocity for musical expression:

```ruby
lead :d4, 0.5, v; sleep 0.5       # Strong
lead :f4, 0.5, v*0.85; sleep 0.5  # Softer
lead :a4, 0.75, v; sleep 0.75     # Strong (peak)
lead :g4, 0.5, v*0.9; sleep 0.5   # Medium
lead :f4, 0.5, v*0.8; sleep 0.5   # Softer
lead :d4, 1, v; sleep 1           # Strong (resolution)
```

**Pattern:** Strong on important notes (root, peak), softer on passing notes.

## Rhythmic Considerations

### Stay on Grid
Melodies should feel rhythmic:

```ruby
# Good: Clean beat divisions
lead :d4, 0.5; sleep 0.5   # Half beat
lead :f4, 0.5; sleep 0.5   # Half beat
lead :a4, 1; sleep 1       # Full beat

# Awkward: Irregular timing
lead :d4, 0.7; sleep 0.7   # Doesn't groove
lead :f4, 0.4; sleep 0.4   # Feels random
```

### Leave Space
Don't fill every beat:

```ruby
lead :d4, 0.5, v; sleep 0.5
lead :f4, 0.5, v; sleep 0.5
lead :a4, 1, v; sleep 1
sleep 1                      # Rest - space to breathe
lead :g4, 0.5, v; sleep 0.5
lead :d4, 1, v; sleep 1.5
```

## Call and Response

Create conversation between phrases:

```ruby
define :mel1 do |v=1|  # "Question"
  lead :d4, 0.5, v; sleep 0.5
  lead :f4, 0.5, v; sleep 0.5
  lead :a4, 0.75, v; sleep 1
  sleep 0.25
end

define :mel2 do |v=1|  # "Answer"
  lead :a4, 0.5, v; sleep 0.5
  lead :g4, 0.5, v*0.9; sleep 0.5
  lead :f4, 0.5, v; sleep 0.5
  lead :d4, 1, v; sleep 1.5
end

# Usage
4.times do
  mel1 0.8; mel2 0.75
end
```

## Darkness Through Notes

### The b6 Note
The flat 6 (b6) is particularly dark:

```ruby
# In D minor, Bb is the b6
lead :d4; sleep 0.5
lead :bb4; sleep 0.5   # Very dark
lead :a4; sleep 0.5    # Resolves
lead :d4; sleep 0.5
```

### The Tritone
Six semitones from root — maximum tension:

```ruby
# In D, Ab is the tritone
lead :d4; sleep 0.5
lead :ab4; sleep 0.5   # Extreme tension!
lead :g4; sleep 0.5    # Resolves down
```

Use sparingly.

## Quick Reference

```ruby
# D Minor scale notes
:d4, :e4, :f4, :g4, :a4, :bb4, :c5, :d5

# Dark intervals from D
:f4   # Minor 3rd - dark
:bb4  # Minor 6th - very dark (b6)
:c5   # Minor 7th - unresolved

# Avoid (sounds happy)
:fs4  # Major 3rd
:b4   # Major 6th

# Melodic pattern template
define :melody do |v=1|
  lead :d4, 0.5, v; sleep 0.5        # Root
  lead :f4, 0.5, v*0.9; sleep 0.5    # Minor 3rd
  lead :a4, 0.75, v; sleep 0.75      # 5th (peak)
  lead :g4, 0.5, v*0.85; sleep 0.5   # Passing
  lead :d4, 1, v; sleep 1.5          # Resolve
end
```
