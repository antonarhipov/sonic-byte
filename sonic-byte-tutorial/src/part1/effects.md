# Effects (FX)

Effects transform sounds. They add space, texture, movement, and character. In dark electronic music, effects are essential — they create atmosphere and energy.

## Basic Syntax

Wrap code in `with_fx`:

```ruby
with_fx :reverb do
  play :c4
  sleep 1
  play :e4
end
```

Everything inside the block is processed through the effect.

## Key Effects for Dark Electronic

### Reverb

Reverb simulates acoustic spaces — from small rooms to vast halls.

```ruby
with_fx :reverb, room: 0.8, mix: 0.5 do
  play :c4
end
```

**Parameters:**
- `room` (0-1): Size of space. Higher = larger, longer tail.
- `mix` (0-1): Wet/dry balance. 0 = dry only, 1 = wet only.

**Usage by section:**

| Section | Room | Mix | Purpose |
|---------|------|-----|---------|
| Intro | 0.9-1.0 | 0.5-0.7 | Atmospheric, spacious |
| Main | 0.5-0.7 | 0.3-0.4 | Present but not washy |
| Break | 0.85-1.0 | 0.5-0.6 | Tension, space |
| Outro | 0.95-1.0 | 0.6-0.7 | Fade into space |

```ruby
# Ethereal melody
with_fx :reverb, room: 0.9, mix: 0.55 do
  4.times { melody 0.7 }
end

# Tight drums (less reverb)
with_fx :reverb, room: 0.4, mix: 0.2 do
  4.times { drums 1 }
end
```

### Echo / Delay

Echo creates rhythmic repeats.

```ruby
with_fx :echo, phase: 0.75, decay: 4, mix: 0.4 do
  play :c4
end
```

**Parameters:**
- `phase`: Time between echoes (in beats)
- `decay`: How long echoes continue (seconds)
- `mix`: Wet/dry balance

**Common phase values:**
- `0.25` — Sixteenth note delays (fast, rhythmic)
- `0.5` — Eighth note delays (driving)
- `0.75` — Dotted eighth (classic dub feel)
- `1.0` — Quarter note (spacious)

```ruby
# Driving delay
with_fx :echo, phase: 0.5, decay: 3, mix: 0.3 do
  4.times { melody 0.8 }
end

# Ethereal long delay
with_fx :echo, phase: 1.0, decay: 8, mix: 0.5 do
  play :c5
end
```

### Low-Pass Filter (LPF)

Removes high frequencies. Essential for bass and filtered builds.

```ruby
with_fx :lpf, cutoff: 80 do
  play :c4
end
```

**Parameters:**
- `cutoff` (0-130): Frequency limit. Lower = darker, more muffled.

```ruby
# Dark, filtered bass
with_fx :lpf, cutoff: 60 do
  8.times { bassline 0.7 }
end

# Opening filter over time
with_fx :lpf, cutoff: 50, cutoff_slide: 32 do |fx|
  control fx, cutoff: 110  # Slides from 50 to 110 over 32 beats
  8.times { bassline 1 }
end
```

### High-Pass Filter (HPF)

Removes low frequencies. Creates tension by removing bass.

```ruby
with_fx :hpf, cutoff: 80 do
  play :c2  # Bass frequencies removed!
end
```

**Common use:** Breakdowns

```ruby
# Tension before drop
with_fx :hpf, cutoff: 100 do
  with_fx :reverb, room: 0.9 do
    4.times { melody 0.6 }
  end
end
```

## Combining Effects

Effects can be nested:

```ruby
with_fx :reverb, room: 0.8, mix: 0.5 do
  with_fx :echo, phase: 0.75, decay: 4, mix: 0.35 do
    4.times { melody 0.7 }
  end
end
```

The sound passes through echo first, then reverb.

**Order matters:**

```ruby
# Echo -> Reverb (echo tails get reverb)
with_fx :reverb do
  with_fx :echo do
    play :c4
  end
end

# Reverb -> Echo (reverb gets echoed)
with_fx :echo do
  with_fx :reverb do
    play :c4
  end
end
```

Generally: inner effects process first, outer effects last.

## Effect Automation

Change effect parameters over time using `control`:

```ruby
with_fx :lpf, cutoff: 60, cutoff_slide: 16 do |fx|
  control fx, cutoff: 120  # Slides over 16 beats
  
  16.times do
    bass :d2
    sleep 1
  end
end
```

The `|fx|` captures the effect reference, `cutoff_slide` sets transition time.

### Riser Effect

```ruby
# Build tension with rising filter
with_fx :lpf, cutoff: 40, cutoff_slide: 32 do |fx|
  control fx, cutoff: 130
  
  in_thread do
    32.times do
      sample :drum_cymbal_closed, amp: 0.3
      sleep 0.5
    end
  end
  
  sleep 32
end
```

## Effect Patterns in the Album

### Intro Pattern

```ruby
# Spacious, atmospheric
with_fx :reverb, room: 0.95, mix: 0.6 do
  with_fx :echo, phase: 1, decay: 6, mix: 0.45 do
    4.times { arp 0.4 }
  end
end
```

### Main Section Pattern

```ruby
# Tighter, more present
with_fx :reverb, room: 0.6, mix: 0.35 do
  with_fx :echo, phase: 0.5, decay: 3, mix: 0.25 do
    8.times { melody 0.8 }
  end
end
```

### Break Pattern

```ruby
# Maximum space before drop
with_fx :reverb, room: 1.0, mix: 0.7 do
  with_fx :echo, phase: 1.5, decay: 8, mix: 0.55 do
    melody 0.5
  end
end
```

### Outro Pattern

```ruby
# Fading into infinity
with_fx :reverb, room: 1.0, mix: 0.7 do
  with_fx :echo, phase: 1.25, decay: 10, mix: 0.6 do
    arp 0.3
    sleep 8
    melody 0.2
  end
end
```

## Other Useful Effects

### Distortion

```ruby
with_fx :distortion, distort: 0.7 do
  play :c2
end
```

### Bitcrusher

Lo-fi digital degradation:

```ruby
with_fx :bitcrusher, bits: 8, sample_rate: 8000 do
  play :c4
end
```

### Wobble

Automatic filter modulation:

```ruby
with_fx :wobble, phase: 0.5, mix: 0.7 do
  play :c2, sustain: 4
end
```

## Quick Reference

```ruby
# Reverb
with_fx :reverb, room: 0.8, mix: 0.5 do ... end

# Echo
with_fx :echo, phase: 0.75, decay: 4, mix: 0.4 do ... end

# Low-pass filter
with_fx :lpf, cutoff: 80 do ... end

# High-pass filter
with_fx :hpf, cutoff: 80 do ... end

# Filter automation
with_fx :lpf, cutoff: 60, cutoff_slide: 16 do |fx|
  control fx, cutoff: 120
  # ...
end

# Combined effects
with_fx :reverb, room: 0.8 do
  with_fx :echo, phase: 0.5, decay: 3 do
    # Sound is echoed, then reverbed
  end
end
```

---

This completes Part I: Foundations. You now understand:
- The vision and aesthetic
- Sonic Pi basics: samples, synths, timing
- Functions and code organization
- Threads for simultaneous playback
- Effects for space and movement

In Part II, we dive deep into **Sound Design** — building the drums, bass, and leads that define dark electronic music.
