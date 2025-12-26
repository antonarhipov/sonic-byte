# Filter Sweeps

Filter sweeps are one of the most powerful tools in electronic music. They create movement, build energy, and signal transitions.

## The Basic Sweep

```ruby
with_fx :lpf, cutoff: 50, cutoff_slide: 32 do |fx|
  control fx, cutoff: 110  # Sweeps from 50 to 110 over 32 beats
  
  8.times { bassline 1 }
end
```

### How It Works

1. `cutoff: 50` — Start position (dark, muffled)
2. `cutoff_slide: 32` — Transition time (32 beats = 8 bars)
3. `control fx, cutoff: 110` — Target position (bright)

## Opening Filter (Building Energy)

The classic build technique:

```ruby
# BUILD section
with_fx :lpf, cutoff: 50, cutoff_slide: 32 do |fx|
  control fx, cutoff: 110
  
  in_thread do
    8.times { drums 0.85, 0.7, 0.55 }
  end
  
  in_thread do
    8.times { bassline 0.75, 60 }
  end
  
  sleep 32
end
```

Sound gets brighter = energy builds.

## Closing Filter (Releasing Energy)

For outros or transitions down:

```ruby
# OUTRO section
with_fx :lpf, cutoff: 85, cutoff_slide: 24 do |fx|
  control fx, cutoff: 45
  
  6.times { |i| 
    drums (1-i*0.1), (0.85-i*0.08), (0.7-i*0.06)
  }
end
```

Sound gets darker = energy releases.

## Sweep Speed

| Beats | Bars | Feel |
|-------|------|------|
| 8 | 2 | Fast, urgent |
| 16 | 4 | Medium |
| 32 | 8 | Slow, building |
| 64 | 16 | Very gradual |

```ruby
# Fast sweep (2 bars)
with_fx :lpf, cutoff: 60, cutoff_slide: 8 do |fx|
  control fx, cutoff: 100
  2.times { bassline 1 }
end

# Slow sweep (8 bars)
with_fx :lpf, cutoff: 50, cutoff_slide: 32 do |fx|
  control fx, cutoff: 110
  8.times { bassline 1 }
end
```

## High-Pass Sweeps

Remove bass frequencies for tension:

```ruby
# BREAK: High-pass removes bass
with_fx :hpf, cutoff: 40, cutoff_slide: 16 do |fx|
  control fx, cutoff: 100  # Bass disappears
  
  4.times { drums 0.7, 0.5, 0.6 }
end

# Then release
with_fx :hpf, cutoff: 100, cutoff_slide: 4 do |fx|
  control fx, cutoff: 20  # Bass returns quickly
  
  drums 1.1, 1, 0.8  # DROP
end
```

## Combined Sweeps

Use both LPF and HPF:

```ruby
# Narrowing to mid frequencies only
with_fx :lpf, cutoff: 120, cutoff_slide: 16 do |lpf|
  with_fx :hpf, cutoff: 30, cutoff_slide: 16 do |hpf|
    control lpf, cutoff: 80   # Remove highs
    control hpf, cutoff: 90   # Remove lows
    
    # Only mid frequencies remain
    4.times { melody 0.6 }
  end
end
```

## On Synths vs Effects

### On Effects (Affects Everything)
```ruby
with_fx :lpf, cutoff: 50, cutoff_slide: 32 do |fx|
  control fx, cutoff: 110
  # ALL sounds inside are filtered
  drums 1; bassline 1; melody 0.8
end
```

### On Synths (Affects One Sound)
```ruby
use_synth :tb303
play :d2, cutoff: 60, cutoff_slide: 4
sleep 0.1
control cutoff: 100  # Only this note sweeps
```

## Sweep Patterns

### Intro Pattern
```ruby
with_fx :lpf, cutoff: 45, cutoff_slide: 32 do |fx|
  control fx, cutoff: 80
  # Start very dark, open partially
end
```

### Build Pattern
```ruby
with_fx :lpf, cutoff: 60, cutoff_slide: 32 do |fx|
  control fx, cutoff: 100
  # Open up for the drop
end
```

### Break Pattern
```ruby
with_fx :hpf, cutoff: 30, cutoff_slide: 16 do |fx|
  control fx, cutoff: 95
  # Remove bass for tension
end
```

### Drop Pattern
```ruby
# Instant open (no sweep)
with_fx :lpf, cutoff: 110 do
  # Full brightness immediately
end
```

### Outro Pattern
```ruby
with_fx :lpf, cutoff: 85, cutoff_slide: 24 do |fx|
  control fx, cutoff: 50
  # Close down as track ends
end
```

## Quick Reference

```ruby
# Opening filter (building)
with_fx :lpf, cutoff: 50, cutoff_slide: 32 do |fx|
  control fx, cutoff: 110
  8.times { bassline 1 }
end

# Closing filter (releasing)
with_fx :lpf, cutoff: 85, cutoff_slide: 24 do |fx|
  control fx, cutoff: 50
  6.times { bassline 1 }
end

# High-pass for tension
with_fx :hpf, cutoff: 40, cutoff_slide: 16 do |fx|
  control fx, cutoff: 100
  4.times { drums 0.7, 0.5, 0.6 }
end

# Cutoff values:
# 40-60: Very dark, muffled
# 60-80: Dark, warm
# 80-100: Balanced, present
# 100-120: Bright, aggressive
```
