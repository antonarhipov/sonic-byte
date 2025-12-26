# Going Live

The tracks in this album are arranged linearly — intro to outro, scripted from start to finish. But Sonic Pi was built for **live coding**: changing music while it plays.

This chapter bridges the gap between composition and performance.

## Static vs Live

### Static (Album Style)
```ruby
define :drums do |k=1, s=1, h=1|
  in_thread do
    4.times { kick k; sleep 1 }
  end
  # ...
  sleep 4
end

# Plays once and stops
8.times { drums 1, 0.9, 0.7 }
```

### Live (Performance Style)
```ruby
live_loop :drums do
  kick 1
  sleep 1
end
```

The `live_loop` runs forever until you stop it. Change the code and press Run — it updates on the next loop.

## Converting to Live Loops

### Basic Conversion

**From:**
```ruby
define :drums do |k=1|
  4.times { kick k; sleep 1 }
end

8.times { drums 1 }
```

**To:**
```ruby
live_loop :drums do
  kick 1
  sleep 1
end
```

### With Control Variables

```ruby
# Global controls — change these while playing
set :kick_vol, 1
set :bpm, 100

live_loop :drums do
  use_bpm get(:bpm)
  kick get(:kick_vol)
  sleep 1
end
```

Now you can change the kick volume by running just this line:
```ruby
set :kick_vol, 0.5
```

The loop picks up the change immediately.

## Multiple Synchronized Loops

```ruby
use_bpm 100

live_loop :kick do
  sample :bd_tek, amp: 2
  sleep 1
end

live_loop :snare do
  sleep 1
  sample :sn_dub, amp: 0.9
  sleep 1
end

live_loop :hats do
  sample :drum_cymbal_closed, amp: 0.25, rate: 2.2
  sleep 0.5
end
```

Each loop runs independently but they stay synchronized.

## Building Arrangement Live

Use `set` and `get` to control song state:

```ruby
set :section, :intro

live_loop :drums do
  case get(:section)
  when :intro
    kick 0.7
  when :main
    kick 1
    sleep 0.5
    kick 0.6
    sleep 0.5
    # Skip the final sleep
    next
  when :break
    # Silence
  end
  sleep 1
end

live_loop :bass do
  case get(:section)
  when :intro
    # Filtered
    bass :d2, 0.5, 60
  when :main
    bass :d2, 1, 80
  when :break
    # Silence
  end
  sleep 1
end
```

Change the section during performance:
```ruby
set :section, :main   # Run this to switch
```

## The `sync` Command

Wait for another loop before playing:

```ruby
live_loop :drums do
  kick 1
  sleep 1
end

live_loop :bass, sync: :drums do
  # Waits for :drums to complete one cycle before starting
  bass :d2, 1, 80
  sleep 1
end
```

## Performance Tips

### Start Simple
Begin with just kicks. Add elements one at a time.

```ruby
# Start here
live_loop :kick do
  sample :bd_tek, amp: 2
  sleep 1
end

# Then add this (press Run again)
live_loop :hats do
  sample :drum_cymbal_closed, amp: 0.2, rate: 2.2
  sleep 0.5
end
```

### Use Comments to Mute
```ruby
live_loop :bass do
  # bass :d2, 1, 80  # Commented out = muted
  sleep 1
end
```

### Keep a "Kill" Buffer
```ruby
# Run this to stop everything
stop
```

### Volume Faders
```ruby
set :master, 1.0

live_loop :drums do
  kick get(:master)
  sleep 1
end

# Fade down
set :master, 0.7
set :master, 0.5
set :master, 0
```

## Example: Track 01 as Live Loops

```ruby
use_bpm 100

set :energy, 0.5  # Start low

# === SOUNDS ===
define :kick do |v=1|
  sample :bd_tek, amp: 2*v, rate: 0.9
end

define :snare do |v=1|
  sample :sn_dub, amp: v, rate: 0.85
end

define :hat do |v=1|
  sample :drum_cymbal_closed, amp: 0.25*v, rate: 2.2
end

define :bass do |n, v=1, c=80|
  use_synth :dsaw
  play n, amp: 0.6*v, cutoff: c, detune: 0.15, release: 0.3
  use_synth :sine
  play n-12, amp: v, release: 0.3
end

# === LOOPS ===
live_loop :kicks do
  kick get(:energy)
  sleep 1
end

live_loop :snares do
  sleep 1
  snare get(:energy) * 0.9
  sleep 1
end

live_loop :hats do
  hat get(:energy) * 0.7
  sleep 0.5
end

live_loop :bassline do
  e = get(:energy)
  c = 60 + (e * 30)  # Cutoff follows energy
  
  bass :d2, e, c
  sleep 0.5
  bass :d2, e*0.6, c-15
  sleep 0.5
  bass :f2, e*0.85, c
  sleep 1
  bass :d2, e, c
  sleep 1
  bass :a2, e*0.9, c+5
  sleep 1
end

# === PERFORMANCE ===
# Run these lines one at a time during performance:

# set :energy, 0.7   # Building
# set :energy, 1.0   # Full
# set :energy, 0.3   # Break
# set :energy, 1.2   # Peak
# set :energy, 0     # Stop
```

## Further Reading

Live coding is deep. This chapter just scratches the surface.

The [Sonic Pi tutorial](https://sonic-pi.net/tutorial) has excellent sections on:
- `live_loop` in detail
- `sync` and `cue` for coordination
- `tick` and `ring` for patterns
- Time state with `set` and `get`

For live performance inspiration, search YouTube for "Sonic Pi live coding" or check out [Algorave](https://algorave.com/).
