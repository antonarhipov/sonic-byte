# Troubleshooting

When code doesn't work, here's where to look.

## No Sound

### Check the basics first
1. **Volume up?** System volume, Sonic Pi volume (top right)
2. **Correct audio output?** Preferences → Audio → Output Device
3. **Did you press Run?** Cmd+R (Mac) or Alt+R (Windows/Linux)

### Check your code
```ruby
# Does this make sound?
sample :bd_tek
```

If yes, the problem is in your code. If no, it's a system/audio issue.

### Common silent failures
```ruby
# Missing sleep — code runs instantly and "finishes"
4.times do
  play :c4
  # sleep 0.5  ← forgot this
end

# Volume of zero
play :c4, amp: 0

# Synth that doesn't exist
use_synth :not_a_real_synth
play :c4

# Note too low/high to hear
play :c0   # Too low
play :c9   # Too high
```

## Timing Problems

### Pattern ends too soon
```ruby
define :drums do |k=1, s=1, h=1|
  in_thread do
    4.times { kick k; sleep 1 }
  end
  in_thread do
    8.times { hat h; sleep 0.5 }
  end
  # MISSING: sleep 4
end

8.times { drums 1, 0.9, 0.7 }  # Loops overlap!
```

**Fix:** Always end multi-threaded functions with `sleep` equal to the pattern length.

### Elements out of sync
```ruby
# Problem: Threads drift
in_thread do
  loop { kick; sleep 1.001 }  # Tiny error accumulates
end

# Fix: Use live_loop for long-running patterns
live_loop :kick do
  sample :bd_tek
  sleep 1  # Always exactly 1 beat
end
```

## Sound Problems

### Muddy/cluttered sound
- Too many elements at once
- Bass and kick fighting
- Too much reverb/delay

**Fixes:**
```ruby
# Reduce element count
# Cut bass when kick hits
# Lower reverb mix: mix: 0.3 not mix: 0.6
```

### Harsh/piercing sound
- Cutoff too high
- Resonance too high
- Too much high frequency content

**Fixes:**
```ruby
# Lower cutoff: 80 instead of 110
# Lower resonance: res: 0.2 instead of res: 0.6
# Add low-pass filter
with_fx :lpf, cutoff: 100 do
  # code
end
```

### Thin/weak sound
- Missing sub frequencies
- Single-layer sounds
- Cutoff too low

**Fixes:**
```ruby
# Add sine sub layer
use_synth :sine
play :d1, amp: 1.1

# Layer synths
# Raise cutoff

# Check your rate isn't too high
sample :bd_tek, rate: 0.9  # Lower = more weight
```

## Error Messages

### "Syntax error"
Usually a typo. Look for:
- Missing `end` statements
- Unclosed strings or brackets
- Misspelled keywords

```ruby
# Wrong
define :kick do |v=1
  sample :bd_tek
end

# Right
define :kick do |v=1|  # Missing |
  sample :bd_tek
end
```

### "Unknown synth"
Check the synth name. Use `puts synth_names` to see all available.

```ruby
# Wrong
use_synth :prophet_5

# Right
use_synth :prophet
```

### "Buffer too large"
Sonic Pi has a buffer size limit. The code is too long.

**Fixes:**
- Split into multiple buffers
- Remove comments
- Condense repeated code into functions
- Use shorter variable names

### "Note out of range"
MIDI notes go from 0 to 127.

```ruby
play 150  # Too high
play -5   # Too low
```

## Performance Issues

### Crackly/glitchy audio
- CPU overloaded
- Too many effects
- Too many simultaneous sounds

**Fixes:**
```ruby
# Reduce polyphony
# Use fewer effects
# Simplify patterns
# Close other applications
```

### Late sounds / timing drift
- Code taking too long to execute
- Complex calculations inside loops

**Fixes:**
```ruby
# Pre-calculate values outside loops
notes = scale(:d4, :minor)  # Calculate once

live_loop :melody do
  play notes.choose  # Just access
  sleep 0.5
end

# NOT this:
live_loop :melody do
  play scale(:d4, :minor).choose  # Calculates every time
  sleep 0.5
end
```

## Quick Diagnostic

When something's wrong, isolate the problem:

```ruby
# 1. Does basic sound work?
sample :bd_tek

# 2. Does your synth work?
use_synth :tb303
play :d2, cutoff: 80

# 3. Does your function work alone?
kick 1

# 4. Does your pattern work alone?
drums 1, 0.9, 0.7

# 5. Do multiple patterns work together?
# Add one at a time until it breaks
```

## Still Stuck?

1. Check the [Sonic Pi tutorial](https://sonic-pi.net/tutorial)
2. Search the [Sonic Pi forum](https://in-thread.sonic-pi.net/)
3. Simplify until it works, then add complexity back

The bug is almost always simpler than you think.
