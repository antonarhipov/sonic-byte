# Sonic Pi Essentials

This chapter covers the core Sonic Pi concepts used throughout the album. If you're familiar with Sonic Pi, skim for the patterns we use. If you're new, this is your foundation.

> **Want to go deeper?** The [Sonic Pi built-in tutorial](https://sonic-pi.net/tutorial) is excellent and comprehensive. We'll cover what you need here, but the official docs go further.

## The Basics

Sonic Pi is a live coding synthesizer. You write code, press Run, and hear music immediately.

```ruby
play 60  # Play middle C
sleep 1  # Wait 1 beat
play 64  # Play E
sleep 1
play 67  # Play G
```

That's a C major arpeggio. Simple, but it demonstrates the core loop: **play something, wait, repeat**.

## BPM: Setting the Tempo

Every track in our album starts with:

```ruby
use_bpm 100
```

This sets beats per minute. When you `sleep 1`, you wait one beat — at 100 BPM, that's 0.6 seconds.

Our album ranges from 95-108 BPM:

| Track | BPM |
|-------|-----|
| Void Walker | 95 |
| Chrome Cathedral | 98 |
| System Override | 100 |
| Terminal Velocity | 100 |
| Midnight Protocol | 102 |
| Nerve Damage | 105 |
| Core Meltdown | 106 |
| Skull Fracture | 108 |

## Playing Samples

Samples are pre-recorded sounds. Sonic Pi includes many:

```ruby
sample :bd_tek    # Techno kick drum
sample :sn_dub    # Dub snare
sample :drum_cymbal_closed  # Hi-hat
```

You can modify samples with parameters:

```ruby
sample :bd_tek, amp: 2.5, rate: 0.9
```

- `amp` — Volume (1 is default, 2 is twice as loud)
- `rate` — Playback speed (0.5 is half speed/lower pitch, 2 is double speed/higher pitch)

### Key Sample Parameters

```ruby
sample :bd_tek,
  amp: 2,           # Volume
  rate: 0.9,        # Speed/pitch
  attack: 0,        # Fade in time
  release: 0.3,     # Fade out time
  cutoff: 100       # Low-pass filter frequency
```

## Playing Synths

Synths generate sound mathematically. First, select a synth:

```ruby
use_synth :tb303
play :c2
```

Or specify inline:

```ruby
synth :prophet, note: :c4
```

### Key Synth Parameters

```ruby
use_synth :prophet
play :c4,
  amp: 0.5,
  attack: 0.1,      # Time to reach full volume
  decay: 0.2,       # Time to drop to sustain level
  sustain: 0.3,     # How long to hold
  release: 0.4,     # Fade out time
  cutoff: 80        # Filter brightness (higher = brighter)
```

We'll explore synths deeply in Part II.

## Defining Functions

Functions let us reuse code. This is **essential** for our album:

```ruby
define :kick do
  sample :bd_tek, amp: 2, rate: 0.9
end

# Now we can call it
kick
sleep 1
kick
```

### Functions with Parameters

```ruby
define :kick do |volume|
  sample :bd_tek, amp: volume, rate: 0.9
end

kick 2      # Loud
sleep 1
kick 0.5    # Quiet
```

### Default Parameters

```ruby
define :kick do |v=1|
  sample :bd_tek, amp: 2*v, rate: 0.9
end

kick        # Uses default v=1
kick 0.5    # Override with 0.5
```

This pattern appears in every track:

```ruby
define :kick do |v=1|
  sample :bd_tek, amp: 2.2*v, rate: 0.9
  sample :bd_boom, amp: 0.5*v, rate: 1.2, cutoff: 70
end
```

## Threads: Playing Simultaneously

Music has multiple parts playing at once. Threads make this possible:

```ruby
in_thread do
  4.times do
    kick
    sleep 1
  end
end

in_thread do
  4.times do
    sleep 0.5
    sample :drum_cymbal_closed
    sleep 0.5
  end
end
```

Both loops run **at the same time** — kicks on the beat, hi-hats on off-beats.

### Thread Pattern for Drums

This pattern appears in every track:

```ruby
define :drums do |k=1, s=1, h=1|
  in_thread do
    4.times do
      kick k
      sleep 1
    end
  end
  
  in_thread do
    sleep 1
    snare s
    sleep 1
    snare s
    sleep 2
  end
  
  in_thread do
    8.times do
      hat h
      sleep 0.5
    end
  end
  
  sleep 4  # Wait for the pattern to complete
end
```

The `sleep 4` at the end is crucial — it makes the function take 4 beats total, so you can call it repeatedly:

```ruby
8.times do
  drums 1, 0.9, 0.7
end
```

## Effects (FX)

Effects process sound. Wrap code in `with_fx`:

```ruby
with_fx :reverb, room: 0.8, mix: 0.5 do
  play :c4
  sleep 0.5
  play :e4
end
```

### Key Effects We Use

**Reverb** — Adds space
```ruby
with_fx :reverb, room: 0.8, mix: 0.5 do
  # room: size (0-1), mix: wet/dry balance
end
```

**Echo/Delay** — Repeating echoes
```ruby
with_fx :echo, phase: 0.75, decay: 4, mix: 0.4 do
  # phase: time between echoes, decay: how long echoes last
end
```

**Low-pass Filter** — Removes high frequencies
```ruby
with_fx :lpf, cutoff: 80 do
  # cutoff: frequency limit (higher = brighter)
end
```

**High-pass Filter** — Removes low frequencies
```ruby
with_fx :hpf, cutoff: 80 do
  # cutoff: frequency limit (higher = more bass removed)
end
```

### Automating Effects

You can change effect parameters over time:

```ruby
with_fx :lpf, cutoff: 60, cutoff_slide: 16 do |fx|
  control fx, cutoff: 120  # Slide to 120 over 16 beats
  16.times do
    kick
    sleep 1
  end
end
```

This creates filter sweeps — the sound "opens up" over time.

## Putting It Together

Here's a minimal example combining everything:

```ruby
use_bpm 100

define :kick do |v=1|
  sample :bd_tek, amp: 2*v, rate: 0.9
end

define :snare do |v=1|
  sample :sn_dub, amp: v
end

define :drums do |k=1, s=1|
  in_thread do
    4.times { kick k; sleep 1 }
  end
  in_thread do
    sleep 1; snare s; sleep 1; snare s; sleep 2
  end
  sleep 4
end

with_fx :reverb, room: 0.5 do
  4.times do
    drums 1, 0.8
  end
end
```

This is the skeleton of every track in the album. The rest is sound design, pattern creation, and arrangement.

---

Next, we'll dive deeper into each element, starting with the sounds themselves.
