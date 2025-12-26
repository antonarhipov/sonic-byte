# Playing Sounds

Sonic Pi has two fundamental ways to make sound: **samples** (pre-recorded audio) and **synths** (mathematically generated sound). Understanding both is essential.

## Samples

Samples are recordings. Sonic Pi includes hundreds built-in.

```ruby
sample :bd_tek       # Techno kick drum
sample :sn_dub       # Dub snare
sample :drum_cymbal_closed  # Hi-hat
sample :bd_boom      # Boomy kick
```

### Sample Parameters

Every sample can be modified:

```ruby
sample :bd_tek,
  amp: 2,           # Volume (1 = default, 2 = twice as loud)
  rate: 0.9,        # Playback speed (0.5 = half speed, 2 = double)
  attack: 0,        # Fade in time
  release: 0.5,     # Fade out time
  cutoff: 100       # Low-pass filter frequency
```

#### amp (amplitude)
Controls volume. Values above 1 boost, below 1 reduce.

```ruby
sample :bd_tek, amp: 0.5   # Quiet
sample :bd_tek, amp: 1     # Normal
sample :bd_tek, amp: 2.5   # Loud (used in our kicks)
```

#### rate
Changes playback speed AND pitch:

```ruby
sample :bd_tek, rate: 0.5  # Half speed, octave lower
sample :bd_tek, rate: 1    # Normal
sample :bd_tek, rate: 2    # Double speed, octave higher
sample :bd_tek, rate: -1   # Reversed!
```

We often use `rate: 0.9` on kicks to lower the pitch slightly for more weight.

#### cutoff
Low-pass filter — removes frequencies above this value:

```ruby
sample :bd_tek, cutoff: 60   # Dark, muffled
sample :bd_tek, cutoff: 100  # Balanced
sample :bd_tek, cutoff: 130  # Bright, all frequencies
```

### Finding Samples

Sonic Pi groups samples by type:

```ruby
# Drums
sample :bd_tek, :bd_haus, :bd_boom, :bd_zum   # Kicks
sample :sn_dub, :sn_dolf, :sn_zome            # Snares
sample :drum_cymbal_closed, :drum_cymbal_open # Hi-hats

# Electronic
sample :elec_twang, :elec_blip, :elec_ping

# Ambient
sample :ambi_choir, :ambi_dark_woosh
```

In Sonic Pi, type `sample :` and press Ctrl+Space to see all options.

## Synths

Synths generate sound mathematically. They're more flexible than samples.

```ruby
use_synth :prophet
play 60           # Play MIDI note 60 (middle C)
```

Or use note names:

```ruby
play :c4          # Middle C
play :d2          # D, two octaves below middle C
play :fs4         # F sharp, fourth octave
```

### Choosing a Synth

```ruby
use_synth :prophet    # Warm, fat analog sound
play :c3

use_synth :tb303      # Acid bass, squelchy
play :c2

use_synth :dsaw       # Aggressive, wide
play :c3

use_synth :sine       # Pure tone, no harmonics
play :c2
```

We'll explore synths deeply in Part II.

### Synth Parameters

```ruby
use_synth :prophet
play :c4,
  amp: 0.5,         # Volume
  attack: 0.1,      # Time to reach full volume
  decay: 0.2,       # Time to drop to sustain level
  sustain: 0.3,     # Hold time
  release: 0.4,     # Fade out time
  cutoff: 80        # Filter brightness
```

The `attack`, `decay`, `sustain`, `release` parameters form the **ADSR envelope** — more on this in Part II.

### Playing Chords

Play multiple notes simultaneously:

```ruby
play [:c4, :e4, :g4]           # C major chord
play chord(:c4, :minor)        # C minor chord
play chord(:d3, :m7)           # D minor 7th
```

Or play separately in quick succession:

```ruby
play :c4
play :e4
play :g4
```

Without `sleep`, all three play at once.

## Samples vs Synths: When to Use Which

**Use samples for:**
- Drums and percussion (more realistic)
- Sound effects
- When you need a specific "real" sound

**Use synths for:**
- Bass (precise pitch control)
- Leads and melodies (expressiveness)
- Pads and atmospheres (sustain control)

**Layer both:**
```ruby
# Our kick: sample for punch, synth for sub
define :kick do |v=1|
  sample :bd_tek, amp: 2*v, rate: 0.9
  sample :bd_boom, amp: 0.5*v, rate: 1.2
end
```

## Quick Reference

```ruby
# Samples
sample :bd_tek, amp: 2, rate: 0.9, cutoff: 100

# Synths
use_synth :prophet
play :c4, amp: 0.5, attack: 0.1, release: 0.5, cutoff: 80

# Chords
play [:c4, :e4, :g4]
play chord(:c4, :minor)
```

---

Next: Timing and Sleep — how to control when sounds happen.
