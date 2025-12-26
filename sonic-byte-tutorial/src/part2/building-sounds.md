# Building Sounds

Part II focuses on crafting the individual elements of dark electronic music. We'll cover drums, bass, leads, and how they work together.

## The Sound Palette

Every track in *Synthetic Apocalypse* uses a consistent palette:

### Drums
- **Kick**: Layered samples (`bd_tek` + `bd_boom` or `bd_zum`)
- **Snare**: `sn_dub` with optional layering
- **Hi-hat**: `drum_cymbal_closed`, high rate for metallic sound

### Bass
- **Character layer**: `tb303`, `prophet`, or `dsaw`
- **Sub layer**: `sine` wave, one octave below

### Leads
- **Primary**: `prophet` for warm, musical tones
- **Texture**: `dark_ambience` or `hollow` for atmosphere
- **Arps**: `pulse` for rhythmic patterns

### Effects
- **Reverb**: Space and atmosphere
- **Echo**: Rhythmic interest
- **Filters**: Movement and energy

## The Layering Principle

Single sounds are rarely enough. Layering creates:

1. **Frequency coverage** — Different sounds fill different ranges
2. **Character** — Combine punchy attack with sustained body
3. **Width** — Some layers can be wider than others

Example — A layered kick:

```ruby
define :kick do |v=1|
  # Layer 1: Attack and punch
  sample :bd_tek, amp: 2*v, rate: 0.9
  
  # Layer 2: Sub weight
  sample :bd_boom, amp: 0.5*v, rate: 1.2, cutoff: 70
end
```

## The Definition Pattern

Every track follows this structure:

```ruby
use_bpm 100

# === SOUND DEFINITIONS ===
# Individual sounds with volume control

define :kick do |v=1|
  # ...
end

define :snare do |v=1|
  # ...
end

define :bass do |n, v=1, c=80|
  # ...
end

define :lead do |n, dur=0.5, v=1|
  # ...
end

# === PATTERN DEFINITIONS ===
# Combinations of sounds into musical phrases

define :drums do |k=1, s=1, h=1|
  # Uses kick, snare, hat
end

define :bassline do |v=1, c=80|
  # Uses bass
end

define :melody do |v=1|
  # Uses lead
end

# === ARRANGEMENT ===
# Structure using patterns

# Intro
# Build
# Main
# Break
# Peak
# Outro
```

This separation is key to maintainable music code.

## Sound Quality Principles

### 1. Leave Headroom

Don't max out volumes:

```ruby
# BAD
sample :bd_tek, amp: 5  # Likely to distort

# GOOD  
sample :bd_tek, amp: 2  # Loud but clean
```

### 2. Cut Before Boost

Use filters to remove unwanted frequencies rather than boosting what you want:

```ruby
# Remove rumble from hi-hats
sample :drum_cymbal_closed, cutoff: 130, hpf: 70

# Remove harshness from bass
use_synth :tb303
play :d2, cutoff: 75  # Not too bright
```

### 3. Contrast Creates Impact

Quiet moments make loud moments louder:

```ruby
# Quiet verse
8.times { drums 0.6, 0.5, 0.4 }

# LOUD chorus (feels even louder after quiet)
8.times { drums 1.1, 1.0, 0.8 }
```

### 4. Frequency Separation

Each element should have its own space:

| Element | Frequency Range | Role |
|---------|-----------------|------|
| Sub bass | 20-60 Hz | Physical weight |
| Bass body | 60-200 Hz | Warmth, power |
| Kick punch | 60-100 Hz | Attack, drive |
| Snare body | 200-400 Hz | Body |
| Snare crack | 2-5 kHz | Presence |
| Hi-hats | 5-15 kHz | Air, rhythm |
| Leads | 200 Hz - 5 kHz | Melody, hooks |

When elements compete, use filters:

```ruby
# Bass with sub emphasis
define :bass do |n, v=1|
  use_synth :tb303
  play n, cutoff: 70  # Roll off highs
  
  use_synth :sine
  play n-12  # Pure sub
end

# Lead with bass rolled off
define :lead do |n, v=1|
  use_synth :prophet
  play n, cutoff: 90  # Brighter than bass
end
```

## Sound Design Workflow

When creating sounds:

1. **Start simple** — One layer, basic parameters
2. **Add layers** — One at a time, listen to each
3. **Adjust balance** — Volume relationships between layers
4. **Shape with filters** — Remove unwanted frequencies
5. **Add effects** — Reverb, delay as needed
6. **Test in context** — Does it work with other elements?

---

The following chapters dive deep into each element: drums, bass, and leads.
