# Filters and Cutoff

Filters shape the frequency content of sounds. In dark electronic music, they're essential for creating movement, building energy, and separating elements.

## What Filters Do

Filters remove frequencies from a sound:

- **Low-pass filter (LPF)**: Removes high frequencies (makes sound darker/muffled)
- **High-pass filter (HPF)**: Removes low frequencies (makes sound thinner)
- **Band-pass filter (BPF)**: Keeps only a range of frequencies

## The Cutoff Parameter

Most Sonic Pi synths have a `cutoff` parameter — this controls the low-pass filter:

```ruby
use_synth :tb303

play :d2, cutoff: 60   # Dark, muffled
sleep 1
play :d2, cutoff: 80   # Balanced
sleep 1
play :d2, cutoff: 100  # Bright
sleep 1
play :d2, cutoff: 120  # Very bright, almost harsh
```

### Cutoff Values Guide

| Cutoff | Sound | Use Case |
|--------|-------|----------|
| 40-60 | Very dark, subby | Filtered builds, intros |
| 60-75 | Dark, warm | Verses, atmospheric sections |
| 75-90 | Balanced | Main sections |
| 90-110 | Bright, present | Drops, peaks |
| 110+ | Very bright | Leads, aggressive moments |

## Filter as Effect

You can also apply filters as effects to any sound:

### Low-Pass Filter (LPF)

```ruby
with_fx :lpf, cutoff: 70 do
  sample :loop_amen
end
```

### High-Pass Filter (HPF)

```ruby
with_fx :hpf, cutoff: 80 do
  sample :loop_amen  # Bass removed
end
```

### Combining Both (Band-Pass)

```ruby
with_fx :hpf, cutoff: 60 do
  with_fx :lpf, cutoff: 100 do
    sample :loop_amen  # Only mid frequencies
  end
end
```

## Filter Movement

Static filters are useful, but moving filters create energy.

### Cutoff Slide (On Synths)

```ruby
use_synth :tb303
play :d2, cutoff: 60, cutoff_slide: 4
sleep 0.1
control cutoff: 100  # Slides from 60 to 100 over 4 beats
```

### Filter Automation (On Effects)

```ruby
with_fx :lpf, cutoff: 50, cutoff_slide: 16 do |fx|
  control fx, cutoff: 110  # Opens over 16 beats
  
  16.times do
    bass :d2
    sleep 1
  end
end
```

This is the classic "filter opening" build.

## Resonance

The `res` parameter adds emphasis at the cutoff frequency:

```ruby
use_synth :tb303
play :d2, cutoff: 75, res: 0.1  # Subtle
sleep 1
play :d2, cutoff: 75, res: 0.4  # Classic acid
sleep 1
play :d2, cutoff: 75, res: 0.7  # Screaming (careful!)
```

### Resonance Values

| Res | Sound | Character |
|-----|-------|-----------|
| 0.1-0.2 | Subtle color | Clean, professional |
| 0.3-0.4 | Pronounced | Classic analog |
| 0.5-0.6 | Strong | Acid, aggressive |
| 0.7+ | Extreme | Screaming, use sparingly |

## Filter Patterns in the Album

### Intro Pattern

Start filtered, gradually open:

```ruby
# INTRO
with_fx :lpf, cutoff: 50, cutoff_slide: 32 do |fx|
  control fx, cutoff: 80  # Slow open
  8.times { bassline 0.6 }
end
```

### Build Pattern

Open filter as energy builds:

```ruby
# BUILD
with_fx :lpf, cutoff: 60, cutoff_slide: 24 do |fx|
  control fx, cutoff: 100  # Opens during build
  6.times { |i| bassline (0.7 + i*0.05) }
end
```

### Main Section

Filter at "home" position:

```ruby
# MAIN
bass :d2, v, 80  # Cutoff 80 = balanced default
```

### Peak Section

Filter fully open for brightness:

```ruby
# PEAK
bass :d2, v, 90  # Brighter!
bassline 1.1, 92  # Even brighter at maximum energy
```

### Break Pattern

High-pass to remove bass, create tension:

```ruby
# BREAK
with_fx :hpf, cutoff: 90 do
  with_fx :reverb, room: 0.9 do
    melody 0.5  # No bass frequencies, floating
  end
end
```

### Outro Pattern

Filter closing as energy fades:

```ruby
# OUTRO
with_fx :lpf, cutoff: 80, cutoff_slide: 24 do |fx|
  control fx, cutoff: 50  # Closing
  6.times { |i| bassline (0.8 - i*0.1) }
end
```

## Cutoff Variation in Patterns

Don't use static cutoff — vary it within patterns:

```ruby
define :bassline do |v=1, c=80|
  bass :d2, v, c        # Root cutoff
  sleep 0.5
  bass :d2, v*0.7, c-10 # Darker ghost note
  sleep 0.5
  bass :f2, v*0.9, c    # Back to root cutoff
  sleep 0.5
  bass :d2, v*0.8, c-5  # Slightly darker
  sleep 0.5
  bass :a2, v, c+5      # Brighter for emphasis
  sleep 0.5
  bass :d2, v, c        # Return to root
  sleep 1.5
end
```

The cutoff variations (`c-10`, `c-5`, `c+5`) add subtle movement.

## Filter Per Section

Typical cutoff progression through a track:

| Section | Bass Cutoff | Character |
|---------|-------------|-----------|
| Intro | 50→70 | Dark, opening |
| Build | 70→90 | Building energy |
| Main A | 80 | Balanced |
| Break | HPF instead | Tension, no bass |
| Main B/Peak | 85-92 | Bright, energetic |
| Outro | 80→55 | Fading, closing |

## Quick Reference

```ruby
# Synth cutoff
use_synth :tb303
play :d2, cutoff: 80, res: 0.3

# LPF effect (removes highs)
with_fx :lpf, cutoff: 70 do
  # dark sound
end

# HPF effect (removes lows)
with_fx :hpf, cutoff: 80 do
  # thin sound
end

# Filter automation
with_fx :lpf, cutoff: 50, cutoff_slide: 16 do |fx|
  control fx, cutoff: 110  # Opens over 16 beats
end

# Cutoff in patterns
bass :d2, v, c      # Main note
bass :d2, v, c-10   # Ghost note (darker)
bass :a2, v, c+5    # Accent (brighter)
```

## Tips

1. **Start dark, open up** — Classic build technique
2. **Close for outros** — Signals ending
3. **Vary within patterns** — Static cutoff is boring
4. **Higher cutoff = more energy** — Use for peaks
5. **HPF for tension** — Remove bass before drops
6. **Resonance with caution** — A little goes a long way
