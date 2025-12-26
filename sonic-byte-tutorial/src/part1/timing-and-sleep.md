# Timing and Sleep

Music exists in time. In Sonic Pi, we control time with `sleep` and `use_bpm`.

## Setting the Tempo

Every track starts with:

```ruby
use_bpm 100
```

BPM = Beats Per Minute. At 100 BPM:
- 1 beat = 0.6 seconds
- 4 beats (1 bar) = 2.4 seconds

Our album ranges from 95-108 BPM:

| BPM | Feel | Used In |
|-----|------|---------|
| 95 | Slow, hypnotic | Void Walker |
| 98 | Atmospheric | Chrome Cathedral |
| 100 | Balanced | System Override, Terminal Velocity |
| 102 | Driving | Midnight Protocol |
| 105 | Energetic | Nerve Damage |
| 106 | Intense | Core Meltdown |
| 108 | Aggressive | Skull Fracture |

## The Sleep Command

`sleep` pauses execution for a number of beats:

```ruby
use_bpm 100

play :c4
sleep 1        # Wait 1 beat (0.6 seconds at 100 BPM)
play :e4
sleep 1
play :g4
```

### Common Sleep Values

```ruby
sleep 4       # Whole note (1 bar in 4/4)
sleep 2       # Half note
sleep 1       # Quarter note
sleep 0.5     # Eighth note
sleep 0.25    # Sixteenth note
```

### Rhythmic Patterns

Different sleep values create different feels:

```ruby
# Straight eighths
4.times do
  sample :drum_cymbal_closed
  sleep 0.5
end

# Syncopated
sample :bd_tek; sleep 0.75
sample :bd_tek; sleep 0.25
sample :bd_tek; sleep 1
sample :bd_tek; sleep 1
```

## Loops and Repetition

### Simple Loops

```ruby
4.times do
  sample :bd_tek
  sleep 1
end
```

This plays 4 kick drums, one per beat.

### Infinite Loops

```ruby
live_loop :drums do
  sample :bd_tek
  sleep 1
end
```

`live_loop` runs forever until you stop it. Great for live coding, but we avoid it in composed tracks.

### Nested Loops

```ruby
4.times do                    # 4 bars
  4.times do                  # 4 beats per bar
    sample :drum_cymbal_closed
    sleep 0.5                 # Eighth notes
  end
end
```

## Pattern Timing

A typical 4-beat drum pattern:

```ruby
define :drums do
  # Beat 1
  sample :bd_tek
  sleep 0.5
  sample :drum_cymbal_closed
  sleep 0.5
  
  # Beat 2
  sample :bd_tek
  sample :sn_dub
  sleep 0.5
  sample :drum_cymbal_closed
  sleep 0.5
  
  # Beat 3
  sample :bd_tek
  sleep 0.5
  sample :drum_cymbal_closed
  sleep 0.5
  
  # Beat 4
  sample :bd_tek
  sample :sn_dub
  sleep 0.5
  sample :drum_cymbal_closed
  sleep 0.5
end
```

Total sleep: 4 beats = 1 bar.

## Timing Math

Always ensure your patterns add up to complete bars:

```ruby
# Good: adds to 4 beats
define :pattern do
  bass :d2; sleep 0.75
  bass :d2; sleep 0.25
  bass :f2; sleep 1
  bass :d2; sleep 2
  # Total: 0.75 + 0.25 + 1 + 2 = 4 ✓
end

# Bad: adds to 3.5 beats (will drift!)
define :broken_pattern do
  bass :d2; sleep 0.5
  bass :d2; sleep 1
  bass :f2; sleep 1
  bass :d2; sleep 1
  # Total: 3.5 ✗
end
```

## Synchronization

When combining multiple patterns, ensure they align:

```ruby
# 8 repetitions of 4-beat drums = 32 beats
8.times do
  drums
end

# Must match: 32 beats of bass
8.times do
  bassline  # Also 4 beats each
end
```

If patterns have different lengths, use least common multiples:

```ruby
# 3-beat pattern + 4-beat pattern
# LCM(3,4) = 12 beats to sync
4.times { three_beat_pattern }  # 12 beats
3.times { four_beat_pattern }   # 12 beats
```

## Quick Reference

```ruby
use_bpm 100              # Set tempo

sleep 1                  # Wait 1 beat
sleep 0.5                # Wait half beat
sleep 4                  # Wait 1 bar

4.times do               # Repeat 4 times
  sample :bd_tek
  sleep 1
end

# Beat values at any BPM:
# 4 = whole note (1 bar)
# 2 = half note
# 1 = quarter note
# 0.5 = eighth note
# 0.25 = sixteenth note
```

---

Next: Variables and Functions — how to organize and reuse code.
