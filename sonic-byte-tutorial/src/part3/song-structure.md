# Song Structure

A track isn't just sounds — it's a journey. Structure transforms loops into music that holds attention for 3+ minutes.

## The Standard Sections

Most tracks in *Sonic Byte* follow this structure:

```text
INTRO → BUILD → MAIN A → BREAK → MAIN B/PEAK → OUTRO
```

Each section serves a purpose:

| Section | Bars | Purpose |
|---------|------|---------|
| Intro | 6-8 | Establish mood, DJ-friendly start |
| Build | 8 | Add elements, create anticipation |
| Main A | 12-16 | Full groove, introduce hooks |
| Break | 4-6 | Strip down, create tension |
| Main B/Peak | 12-16 | Maximum energy, everything combined |
| Outro | 4-8 | Wind down, DJ-friendly ending |

## Section-by-Section

### Intro (24-32 beats)

**Goal:** Set the mood without giving everything away.

**Typical elements:**
- Drums (often just kick, or kick + hats)
- Maybe filtered bass
- Atmospheric sounds

```ruby
# INTRO: 8 bars
in_thread do
  8.times { drums 0.7, 0, 0.4 }  # Kicks + hats, no snare
end

in_thread do
  with_fx :lpf, cutoff: 50, cutoff_slide: 32 do |fx|
    control fx, cutoff: 75
    8.times { bassline 0.5, 50 }  # Filtered bass
  end
end

sleep 32
```

### Build (32 beats)

**Goal:** Add elements progressively, create anticipation.

```ruby
# BUILD: 8 bars
in_thread do
  8.times { drums 0.85, 0.7, 0.55 }  # Add snares
end

in_thread do
  8.times { bassline 0.7, 65 }  # Bass more present
end

in_thread do
  with_fx :reverb, room: 0.7, mix: 0.5 do
    sleep 16
    4.times { arp 0.5 }  # Arp enters halfway
  end
end

sleep 32
hit 1  # Impact transitioning to main
```

### Main A (48-64 beats)

**Goal:** Full groove, introduce melodic hooks.

```ruby
# MAIN A: 12 bars
in_thread do
  12.times { drums 1, 0.9, 0.7 }
end

in_thread do
  12.times { bassline 1, 80 }  # Full bass
end

in_thread do
  6.times { arp 0.7 }
end

in_thread do
  with_fx :reverb, room: 0.6, mix: 0.4 do
    with_fx :echo, phase: 0.5, decay: 3, mix: 0.3 do
      sleep 16  # Melody enters after 4 bars
      4.times { melody 0.8 }
    end
  end
end

sleep 48
```

### Break (16-24 beats)

**Goal:** Create tension through subtraction. The silence makes the return more powerful.

```ruby
# BREAK: 4-6 bars
in_thread do
  # Just hats, maybe some atmosphere
  12.times { hat 0.35; sleep 0.5 }
  sleep 12
end

in_thread do
  with_fx :reverb, room: 0.9, mix: 0.6 do
    with_fx :echo, phase: 1, decay: 6, mix: 0.5 do
      melody 0.5  # Distant, atmospheric melody
    end
  end
end

in_thread do
  sleep 12
  # Riser before drop
  use_synth :noise
  play :c2, amp: 0.4, attack: 12, release: 0.1, cutoff: 60
end

sleep 24
hit 1.5  # Big impact before peak
```

### Main B / Peak (48-64 beats)

**Goal:** Maximum energy. Everything at full power.

```ruby
# PEAK: 12-14 bars
in_thread do
  14.times { drums 1.15, 1.05, 0.8 }  # Louder than Main A
end

in_thread do
  7.times { bassline 1.1, 85; bassline 1.1, 88 }  # Brighter
end

in_thread do
  7.times { arp 0.85 }
end

in_thread do
  with_fx :reverb, room: 0.5, mix: 0.3 do
    with_fx :echo, phase: 0.5, decay: 2.5, mix: 0.25 do
      7.times { melody 0.95 }  # Strong melody
    end
  end
end

sleep 56
```

### Outro (16-32 beats)

**Goal:** Wind down gracefully. Leave space for DJ mixing.

```ruby
# OUTRO: 6 bars
in_thread do
  6.times do |i|
    drums (1-i*0.12), (0.85-i*0.1), (0.7-i*0.08)
  end
end

in_thread do
  with_fx :reverb, room: 0.9, mix: 0.6 do
    with_fx :echo, phase: 1, decay: 8, mix: 0.5 do
      melody 0.4; sleep 8
      arp 0.3
    end
  end
end

sleep 24
```

## Energy Mapping

Visualize energy levels:

```text
Section:  INTRO   BUILD   MAIN A   BREAK   PEAK    OUTRO
Energy:   ▂▂▂▃    ▃▄▅▅    ▆▆▆▆▆    ▂▂▃▅    ▇▇▇▇▇   ▅▄▃▂▁
Bars:     8       8       12       4-6     12-14   6
```

## Transitions

### The Hit

Impact sounds signal section changes:

```ruby
define :hit do |v=1|
  sample :bd_boom, amp: 2*v, rate: 0.4
  sample :drum_splash_hard, amp: 0.7*v, rate: 0.6
end

# Usage
8.times { drums 0.9, 0.7, 0.6 }
hit 1.2  # IMPACT
8.times { drums 1, 0.9, 0.8 }
```

### The Riser

Build tension before drops:

```ruby
in_thread do
  sleep 24  # Wait until 6 beats before drop
  use_synth :noise
  play :g2, amp: 0.4, attack: 8, release: 0.1, cutoff: 55
end
```

### Filter Sweeps

Opening filters = building energy:

```ruby
in_thread do
  with_fx :lpf, cutoff: 50, cutoff_slide: 32 do |fx|
    control fx, cutoff: 110
    8.times { bassline 1 }
  end
end
```

### Subtraction Before Addition

Remove elements before a drop — silence creates impact:

```ruby
# Bar before drop: just hats
8.times { hat 0.4; sleep 0.5 }

# Impact
hit 1.5

# Drop: everything
drums 1.2, 1.1, 0.85
```

## Variations by Track Type

### Aggressive Track (Skull Fracture)

```text
INTRO(6) → BUILD(8) → MAIN(12) → FAKE DROP(2) → PEAK(14) → OUTRO(6)
```

The "fake drop" is a brief silence before the real peak.

### Atmospheric Track (Chrome Cathedral)

```text
INTRO(8) → BUILD(10) → MAIN A(12) → BREAK(8) → MAIN B(12) → LONG OUTRO(8)
```

Longer transitions, more breathing room.

### Climax Track (Core Meltdown)

```text
INTRO(8) → BUILD(8) → MAIN A(12) → TENSION(6) → MASSIVE DROP(14) → OUTRO(6)
```

Longer tension section, bigger payoff.

## The Complete Pattern

Here's the full arrangement skeleton:

```ruby
use_bpm 100

# [Sound definitions...]
# [Pattern definitions...]

# === ARRANGEMENT ===

# INTRO: 8 bars
in_thread do
  8.times { drums 0.7, 0, 0.4 }
end
in_thread do
  with_fx :lpf, cutoff: 50, cutoff_slide: 32 do |fx|
    control fx, cutoff: 80
    8.times { bassline 0.5, 50 }
  end
end
sleep 32

# BUILD: 8 bars  
in_thread do
  8.times { drums 0.85, 0.7, 0.55 }
end
in_thread do
  8.times { bassline 0.75, 68 }
end
in_thread do
  sleep 16; 4.times { arp 0.5 }
end
sleep 32
hit 1

# MAIN A: 12 bars
in_thread do
  12.times { drums 1, 0.9, 0.7 }
end
in_thread do
  12.times { bassline 1, 80 }
end
in_thread do
  with_fx :reverb, room: 0.6, mix: 0.4 do
    sleep 16; 4.times { melody 0.8 }
  end
end
sleep 48

# BREAK: 6 bars
in_thread do
  12.times { hat 0.35; sleep 0.5 }
end
in_thread do
  with_fx :reverb, room: 0.9, mix: 0.6 do
    melody 0.5
  end
end
sleep 24
hit 1.5

# PEAK: 14 bars
in_thread do
  14.times { drums 1.15, 1.05, 0.8 }
end
in_thread do
  14.times { bassline 1.1, 85 }
end
in_thread do
  with_fx :reverb, room: 0.5, mix: 0.3 do
    7.times { melody 0.95 }
  end
end
sleep 56

# OUTRO: 6 bars
in_thread do
  6.times { |i| drums (1-i*0.12), (0.85-i*0.1), (0.7-i*0.08) }
end
in_thread do
  with_fx :reverb, room: 0.9, mix: 0.6 do
    melody 0.4
  end
end
sleep 24
```

---

Structure is what separates a loop from a track. Master these patterns, then break them intentionally.
