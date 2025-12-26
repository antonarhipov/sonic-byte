# Arpeggios

Arpeggios are broken chords — playing chord notes one at a time rather than simultaneously. They add movement and hypnotic energy without complex melody writing.

## Basic Arpeggio

```ruby
define :arp do |v=1|
  use_synth :pulse
  notes = [:d4, :f4, :a4, :d5, :a4, :f4, :d4, :a3]
  
  notes.each do |n|
    play n, amp: 0.25*v, attack: 0.01, decay: 0.1,
         release: 0.1, cutoff: 100
    sleep 0.5
  end
end
```

### The Pattern
D minor chord: D, F, A

Arpeggio: D → F → A → D(up) → A → F → D → A(down)

Goes up through the chord, then back down.

## Synth Choice

### :pulse (Classic)
```ruby
use_synth :pulse
play :d4, pulse_width: 0.35, cutoff: 100
```
Hollow, rhythmic, synthwave feel.

### :dsaw (Aggressive)
```ruby
use_synth :dsaw
play :d4, detune: 0.1, cutoff: 95
```
Wider, more present.

### :saw (Bright)
```ruby
use_synth :saw
play :d4, cutoff: 90
```
Raw, cutting.

## Arpeggio Patterns

### Up and Down (Standard)
```ruby
[:d4, :f4, :a4, :d5, :a4, :f4, :d4, :a3]
#  1    3    5    8    5    3    1    5(low)
```

### Up Only
```ruby
[:d4, :f4, :a4, :d5, :f5, :a5, :d6, :a5]
```
Constantly rising = building energy.

### Down Only
```ruby
[:d5, :a4, :f4, :d4, :a3, :f3, :d3, :a2]
```
Falling = releasing energy.

### With Octaves
```ruby
[:d4, :d5, :f4, :f5, :a4, :a5, :d5, :d6]
```
Jumping octaves adds interest.

### Pulsing
```ruby
[:d4, :d4, :f4, :f4, :a4, :a4, :d5, :d5]
```
Repeated notes create drive.

## Arpeggio by Key

### D Minor
```ruby
[:d4, :f4, :a4, :d5, :a4, :f4, :d4, :a3]
```

### A Minor
```ruby
[:a3, :c4, :e4, :a4, :e4, :c4, :a3, :e3]
```

### G Minor
```ruby
[:g3, :bb3, :d4, :g4, :d4, :bb3, :g3, :d3]
```

### C Minor
```ruby
[:c4, :eb4, :g4, :c5, :g4, :eb4, :c4, :g3]
```

## Parameters

### Short Notes (Rhythmic)
```ruby
play n, attack: 0.01, decay: 0.1, release: 0.1
```

### Longer Notes (Flowing)
```ruby
play n, attack: 0.02, decay: 0.15, release: 0.2
```

### pulse_width (for :pulse synth)
```ruby
pulse_width: 0.5   # Square wave - hollow
pulse_width: 0.35  # Thinner - our standard
pulse_width: 0.2   # Very thin - reedy
```

## Multiple Arpeggios

Create variation with different patterns:

```ruby
define :arp1 do |v=1|  # Main pattern
  use_synth :pulse
  [:d4, :f4, :a4, :d5, :a4, :f4, :d4, :a3].each do |n|
    play n, amp: 0.25*v, release: 0.1, cutoff: 100
    sleep 0.5
  end
end

define :arp2 do |v=1|  # Higher variation
  use_synth :pulse
  [:a4, :d5, :f5, :a5, :f5, :d5, :a4, :f4].each do |n|
    play n, amp: 0.22*v, release: 0.1, cutoff: 95
    sleep 0.5
  end
end

# Usage: alternate
4.times do
  arp1 0.7; arp2 0.65
end
```

## Arpeggios with Effects

Arpeggios sound great with reverb and delay:

```ruby
with_fx :reverb, room: 0.7, mix: 0.45 do
  with_fx :echo, phase: 0.75, decay: 4, mix: 0.35 do
    4.times { arp1 0.6 }
  end
end
```

### Ethereal (For breaks)
```ruby
with_fx :reverb, room: 0.9, mix: 0.6 do
  with_fx :echo, phase: 1, decay: 6, mix: 0.5 do
    arp1 0.4
  end
end
```

## When to Use Arpeggios

- **Intros/Outros** — Atmospheric, hypnotic
- **Builds** — Rising arpeggios build energy
- **Behind melodies** — Rhythmic bed
- **Instead of chords** — More movement than pads

## Quick Reference

```ruby
# Basic arpeggio
define :arp do |v=1|
  use_synth :pulse
  [:d4, :f4, :a4, :d5, :a4, :f4, :d4, :a3].each do |n|
    play n, amp: 0.25*v, attack: 0.01, decay: 0.1,
         release: 0.1, cutoff: 100, pulse_width: 0.35
    sleep 0.5
  end
end

# With effects
with_fx :reverb, room: 0.7, mix: 0.45 do
  with_fx :echo, phase: 0.75, decay: 4, mix: 0.35 do
    4.times { arp 0.6 }
  end
end

# Pattern formulas (for any minor key):
# root, 3rd, 5th, octave, 5th, 3rd, root, 5th-below
```
