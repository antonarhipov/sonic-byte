# Dynamics and Energy

Dynamics are the volume relationships in your music. Good dynamics create excitement; poor dynamics create fatigue.

## The Dynamic Range

Dynamic range is the difference between quietest and loudest moments:

| Track Type | Quietest | Loudest | Range |
|------------|----------|---------|-------|
| Pop (compressed) | 0.7 | 1.0 | Small |
| *Sonic Byte* | 0.3 | 1.2 | Medium-Large |
| Classical | 0.1 | 1.0 | Very Large |

More range = more emotional impact.

## Section Dynamics

Each section has a baseline energy level:

| Section | Drum Level | Bass Level | Overall |
|---------|------------|------------|---------|
| Intro | 0.6-0.7 | 0.5 | Low |
| Build | 0.7→0.95 | 0.6→0.9 | Rising |
| Main | 1.0 | 1.0 | Full |
| Break | 0.3-0.5 | 0 | Very Low |
| Peak | 1.1-1.2 | 1.1 | Maximum |
| Outro | 1.0→0.3 | 0.8→0 | Falling |

## Building Energy

### Progressive Volume

```ruby
8.times do |i|
  drums (0.6 + i*0.05), (0.5 + i*0.05), (0.4 + i*0.04)
end
# Volume: 0.6, 0.65, 0.7, 0.75, 0.8, 0.85, 0.9, 0.95
```

### Adding Elements

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
  sleep 1; snare 0.6; sleep 1; snare 0.6; sleep 2
  sleep 1; snare 0.7; sleep 1; snare 0.7; sleep 2
end

# Bar 7-8: Add bass
in_thread do
  sleep 24
  2.times { bassline 0.8 }
end

sleep 32
```

### Filter Opening (Perceived Loudness)

```ruby
with_fx :lpf, cutoff: 50, cutoff_slide: 32 do |fx|
  control fx, cutoff: 110
  # Sound gets brighter = perceived louder
  8.times { bassline 0.8 }
end
```

## Releasing Energy

### Progressive Fade

```ruby
6.times do |i|
  drums (1-i*0.12), (0.9-i*0.1), (0.7-i*0.08)
end
# Volume: 1.0, 0.88, 0.76, 0.64, 0.52, 0.4
```

### Removing Elements

```ruby
# Bar 1-2: Full mix
in_thread do
  2.times { drums 1, 0.9, 0.7; bassline 1; melody 0.8 }
end

# Bar 3-4: Remove melody
in_thread do
  sleep 8
  2.times { drums 0.9, 0.8, 0.65; bassline 0.9 }
end

# Bar 5-6: Remove bass
in_thread do
  sleep 16
  2.times { drums 0.75, 0.6, 0.5 }
end

# Bar 7-8: Drums fading
in_thread do
  sleep 24
  drums 0.5, 0.4, 0.35
  drums 0.3, 0, 0.2
end
```

### Filter Closing

```ruby
with_fx :lpf, cutoff: 85, cutoff_slide: 24 do |fx|
  control fx, cutoff: 50
  # Sound gets darker = perceived quieter
  6.times { bassline 0.8 }
end
```

## The Loudest Moment

Every track should have a clear peak — the loudest moment:

```ruby
# PEAK section
in_thread do
  drums 1.15, 1.05, 0.85  # 15% louder than Main
end
in_thread do
  bassline 1.1, 90        # Brighter cutoff
end
in_thread do
  melody 0.95             # Strong melody
end
```

### Peak Timing

The peak usually happens:
- Around 2/3 through the track
- After a tension/break section
- Before the outro begins

## Contrast Creates Impact

The peak feels loudest because of **contrast** with quiet moments:

```ruby
# BREAK: Very quiet (16 beats)
in_thread do
  16.times { hat 0.35; sleep 0.5 }
end
sleep 16

# PEAK: Full volume
hit 1.5
in_thread do
  drums 1.2, 1.1, 0.85  # Feels MASSIVE after quiet break
end
```

Without the quiet break, the peak would feel ordinary.

## Dynamic Curve Visualization

```
Energy
  │
  │           ┌─────┐
  │      ┌────┘     └──┐
  │   ┌──┘             └───┐
  │ ┌─┘                    └──┐
  │─┘                          └──
  └─────────────────────────────────►
   INTRO BUILD MAIN BREAK PEAK OUTRO
```

## Quick Reference

```ruby
# Building energy
8.times { |i| drums (0.6+i*0.05), (0.5+i*0.05), (0.4+i*0.04) }

# Releasing energy
6.times { |i| drums (1-i*0.12), (0.9-i*0.1), (0.7-i*0.08) }

# Section levels
# Intro:  drums 0.7, 0, 0.4
# Build:  drums 0.85, 0.7, 0.55
# Main:   drums 1, 0.9, 0.7
# Break:  drums 0, 0, 0.35 (or just hats)
# Peak:   drums 1.15, 1.05, 0.85
# Outro:  drums fade from 1 to 0.3
```
