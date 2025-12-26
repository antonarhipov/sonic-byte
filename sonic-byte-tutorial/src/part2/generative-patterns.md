# Generative Patterns

This is what DAWs can't do.

In a traditional DAW, every note is placed by hand. In code, you can write *rules* that generate music. Patterns that evolve. Melodies that never repeat exactly. Music that surprises even you.

## The Power of `.choose`

The simplest generative technique — random selection:

```ruby
# A melody that writes itself
use_synth :prophet
8.times do
  play scale(:d4, :minor).choose, release: 0.3
  sleep 0.5
end
```

Every time you run it, different notes. All from D minor. All musical.

## Controlled Randomness

Pure random sounds chaotic. **Controlled random** sounds intentional.

### Weighted Probability

Want the root note more often? Duplicate it in the array:

```ruby
# 50% D, 25% F, 25% A
notes = [:d2, :d2, :f2, :a2]

8.times do
  play notes.choose, release: 0.3
  sleep 0.5
end
```

The root (D) appears twice, so it's chosen twice as often. The pattern stays grounded.

### Conditional Randomness

Use `one_in()` for occasional variations:

```ruby
define :bass_gen do |v=1|
  use_synth :tb303
  n = :d2
  
  # 25% chance to jump to the fifth
  n = :a2 if one_in(4)
  
  # 10% chance to go an octave up
  n = n + 12 if one_in(10)
  
  play n, amp: 0.8*v, cutoff: rrand(70, 90), release: 0.3
end

16.times do
  bass_gen
  sleep 0.5
end
```

Mostly plays D2. Sometimes A2. Occasionally jumps up an octave. The cutoff varies randomly within a range. Every run is different, but it always *grooves*.

## Generative Basslines

### The Drunk Walk

Move up or down by small intervals:

```ruby
define :drunk_bass do
  use_synth :tb303
  
  n = :d2
  
  8.times do
    play n, cutoff: 80, release: 0.3
    sleep 0.5
    
    # Move up or down by 1-3 semitones, or stay
    n = n + [-3, -2, -1, 0, 0, 1, 2, 3].choose
    
    # Keep it in a reasonable range
    n = :d2 if n < :a1
    n = :d3 if n > :a3
  end
end
```

The bass "wanders" but stays in range. Run it multiple times — each version is different but plausible.

### Probability-Driven Patterns

```ruby
define :gen_bassline do |v=1, c=80|
  use_synth :tb303
  
  4.times do
    # Root note - always
    play :d2, amp: 0.8*v, cutoff: c, release: 0.3
    sleep 0.5
    
    # Ghost note - 70% chance
    if rand < 0.7
      play :d2, amp: 0.5*v, cutoff: c-15, release: 0.2
    end
    sleep 0.5
    
    # Movement note - pick from scale
    play [:f2, :g2, :a2, :c3].choose, amp: 0.7*v, cutoff: c, release: 0.3
    sleep 0.5
    
    # Return or variation
    play (one_in(4) ? :a2 : :d2), amp: 0.75*v, cutoff: c, release: 0.3
    sleep 0.5
  end
end
```

The pattern has structure (root → ghost → movement → return) but the specifics vary.

## Generative Melodies

### Scale-Based

```ruby
define :gen_melody do |v=1|
  use_synth :prophet
  
  notes = scale(:d4, :minor_pentatonic)  # D F G A C
  
  8.times do
    # Pick a note, maybe jump an octave
    n = notes.choose
    n = n + 12 if one_in(5)
    
    # Vary the duration
    dur = [0.25, 0.5, 0.5, 0.75].choose
    
    play n, amp: 0.4*v, release: dur * 0.8
    sleep dur
  end
end

with_fx :reverb, room: 0.7 do
  4.times { gen_melody 0.7 }
end
```

### Contour-Controlled

Sometimes you want shape, not just random notes:

```ruby
define :rising_phrase do |v=1|
  use_synth :prophet
  notes = scale(:d4, :minor)
  
  # Start low, end high
  start_idx = rrand_i(0, 2)   # Low note
  end_idx = rrand_i(5, 7)     # High note
  
  4.times do |i|
    # Interpolate between start and end
    idx = start_idx + ((end_idx - start_idx) * i / 3.0).round
    play notes[idx], amp: 0.4*v, release: 0.4
    sleep 0.5
  end
end
```

The phrase always rises, but the exact notes vary.

## Generative Rhythms

### Euclidean Rhythms

Spread hits evenly across beats:

```ruby
define :euclidean do |hits, steps|
  # Attempt to spread hits evenly across steps
  pattern = []
  steps.times do |i|
    if (i * hits) % steps < hits
      pattern << true
    else
      pattern << false
    end
  end
  pattern
end

# 5 hits spread across 8 steps
pattern = euclidean(5, 8)  # [true, false, true, false, true, false, true, true]

loop do
  pattern.each do |hit|
    kick 1 if hit
    sleep 0.5
  end
end
```

Try different combinations: `euclidean(3, 8)`, `euclidean(7, 16)`, `euclidean(5, 12)`.

### Probability Drums

```ruby
define :gen_drums do |k=1, s=1, h=1|
  in_thread do
    4.times do
      kick k if rand < 0.9           # 90% chance
      sleep 0.5
      kick k*0.6 if rand < 0.3       # 30% ghost kick
      sleep 0.5
    end
  end
  
  in_thread do
    4.times do
      sleep 0.5
      snare s if rand < 0.85         # 85% chance
      sleep 0.5
      snare s*0.4 if rand < 0.15     # 15% ghost snare
    end
  end
  
  in_thread do
    8.times do
      hat h * rrand(0.6, 1.0)        # Random velocity
      sleep 0.5
    end
  end
  
  sleep 4
end

8.times { gen_drums 1, 0.9, 0.7 }
```

The groove is recognizable but never exactly the same twice.

## Rings and Ticks

For patterns that cycle but evolve:

```ruby
# A ring loops forever
notes = ring(:d4, :f4, :a4, :g4, :f4, :e4, :d4, :c4)

# tick advances through the ring
16.times do
  play notes.tick, release: 0.3
  sleep 0.25
end

# Combine with randomness
16.times do
  n = notes.tick
  n = n + 12 if one_in(6)  # Sometimes octave up
  play n, release: 0.3
  sleep 0.25
end
```

## When to Use Generative Patterns

**Good for:**
- Background elements (arps, textures)
- Live performance (always fresh)
- Inspiration (let the code suggest ideas)
- Long-form music (patterns that don't bore)

**Careful with:**
- Main hooks (might lose memorability)
- Tight arrangements (unpredictable timing)
- Drop moments (need precision, not randomness)

## Quick Reference

```ruby
# Random from array
[:d2, :f2, :a2].choose

# Random from scale
scale(:d4, :minor).choose

# Weighted probability (D twice as likely)
[:d2, :d2, :f2, :a2].choose

# Conditional (25% chance)
one_in(4)

# Random in range
rrand(70, 90)      # Float between 70 and 90
rrand_i(0, 4)      # Integer 0, 1, 2, 3, or 4

# Cycling patterns
notes = ring(:d4, :f4, :a4)
notes.tick         # Advances each call

# Probability check
if rand < 0.7      # 70% chance
  # do something
end
```

## Try This

Take any pattern from the album and add one element of randomness. Start small:
- Randomize the velocity slightly
- Occasionally skip a note
- Pick cutoff from a range instead of a fixed value

Listen to how it changes the feel. Sometimes chaos. Sometimes life.
