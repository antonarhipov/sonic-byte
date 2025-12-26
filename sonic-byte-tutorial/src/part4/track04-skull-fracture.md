# 04: Skull Fracture

**BPM:** 108 | **Key:** F Minor | **Duration:** ~2:45

Maximum aggression. Skull Fracture is the album's fastest, hardest track — pure adrenaline and violence.

## The Vision

After the atmospheric break of Chrome Cathedral, Skull Fracture slams the door:

1. **Maximum energy** — Fastest BPM, hardest hits
2. **Signature hook sound** — The "skull" alarm
3. **Short and brutal** — No fat, all impact
4. **First peak** — This is the album's first climax

## What Makes It Unique

### Fastest BPM

108 BPM is the album's maximum:

| Track | BPM | Delta from previous |
|-------|-----|---------------------|
| Chrome Cathedral | 98 | — |
| **Skull Fracture** | **108** | **+10** |

The 10 BPM jump is jarring — intentionally.

### The "Skull" Hook

A distorted alarm sound that defines the track:

```ruby
define :skull do |v=1|
  use_synth :mod_saw
  play :f4, amp: 0.4*v, attack: 0, decay: 0.06,
       sustain: 0.02, release: 0.04, mod_phase: 0.08,
       mod_range: 8, cutoff: 115
  sleep 0.125
  play :f4, amp: 0.35*v, attack: 0, decay: 0.05,
       sustain: 0.02, release: 0.04, mod_phase: 0.1,
       mod_range: 7, cutoff: 112
  sleep 0.125
  play :ab4, amp: 0.38*v, attack: 0, decay: 0.06,
       sustain: 0.02, release: 0.05, mod_phase: 0.08,
       mod_range: 8, cutoff: 118
  sleep 0.25
end
```

**Key characteristics:**
- Very fast notes (0.125 beat = 32nd notes)
- High `mod_range` (8) — extreme modulation
- Fast `mod_phase` (0.08) — rapid wobble
- High `cutoff` (115+) — bright, cutting

**The effect:** An alarm-like sound that cuts through everything.

### Triple-Layer Bass

Maximum weight:

```ruby
define :bass do |n, v=1, c=82|
  use_synth :dsaw
  play n, amp: 0.6*v, attack: 0, decay: 0.15,
       sustain: 0.08, release: 0.12, cutoff: c, detune: 0.22
  use_synth :tb303
  play n, amp: 0.45*v, attack: 0, decay: 0.18,
       sustain: 0.05, release: 0.1, cutoff: c-8, res: 0.35, wave: 1
  use_synth :sine
  play n-12, amp: 1.25*v, attack: 0.01, sustain: 0.22, release: 0.18
end
```

**Three layers:**
1. `dsaw` — Width and aggression (high detune: 0.22)
2. `tb303` (square wave) — Grit and punch
3. `sine` — Sub weight (louder than other tracks: 1.25)

### Punishing Drums

```ruby
define :drums_brutal do |k=1, s=1, h=1|
  in_thread do
    kick k; sleep 0.5
    kick k*0.7; sleep 0.5
    kick k*0.9; sleep 0.5
    kick k*0.6; sleep 0.5
    kick k; sleep 0.5
    kick k*0.75; sleep 0.5
    kick k*0.85; sleep 0.5
    kick k; sleep 0.5
  end
  in_thread do
    sleep 1; snare s*1.1; sleep 1; snare s; sleep 2
  end
  in_thread do
    16.times { hat h; sleep 0.25 }
  end
  sleep 4
end
```

**8 kicks per bar** with heavy velocity variation — relentless but groovy.

## Sound Design

### Kick (Heavier)

```ruby
define :kick do |v=1|
  sample :bd_tek, amp: 2.5*v, rate: 0.85
  sample :bd_zum, amp: 0.7*v, rate: 1.1
end
```

**Differences from earlier tracks:**
- Lower `rate` (0.85 vs 0.9) — deeper pitch
- `bd_zum` instead of `bd_boom` — more attack
- Higher amp (2.5 vs 2.2) — louder

### Snare (Cracking)

```ruby
define :snare do |v=1|
  sample :sn_dub, amp: v*1.1, rate: 0.75
  sample :drum_snare_hard, amp: 0.5*v, rate: 0.85
end
```

Lower rates = deeper, more impactful.

### Power Stab

Chord stabs for emphasis:

```ruby
define :stab do |v=1|
  use_synth :dsaw
  play [:f2, :c3, :f3], amp: 0.5*v, attack: 0,
       decay: 0.15, release: 0.1, cutoff: 90, detune: 0.2
end
```

F minor power chord — dark and heavy.

## Patterns

### Bassline (Aggressive)

```ruby
define :bassline do |v=1, c=82|
  bass :f2, v, c; sleep 0.5
  bass :f2, v*0.6, c-10; sleep 0.25
  bass :f2, v*0.7, c-5; sleep 0.25
  bass :ab2, v*0.9, c; sleep 0.5
  bass :f2, v*0.8, c; sleep 0.5
  bass :c2, v, c+5; sleep 0.5
  bass :db2, v*0.85, c; sleep 0.5
  bass :f2, v, c; sleep 1
end
```

**F Minor movement:** F (root) → Ab (minor 3rd) → C (5th) → Db (b6 — dark!)

### Skull Pattern

```ruby
define :skull_pattern do |v=1|
  skull v; sleep 0.5
  skull v*0.8; sleep 0.5
  sleep 0.5
  skull v*0.9; sleep 0.5
  sleep 1
  skull v; sleep 1
end
```

The hook appears, disappears, reappears — creating anticipation.

## Arrangement

```
INTRO (24) → BUILDUP (24) → MAIN (40) → FAKE DROP (8) → PEAK (40) → OUTRO (16)
```

### Short and Brutal

At ~2:45, Skull Fracture is the album's shortest track. No fat:

- Intro: 6 bars (not 8)
- No ambient section
- Short outro

### The Fake Drop

A technique for extra impact:

```ruby
# FAKE DROP: 2 bars - silence before real peak
in_thread do
  4.times { hat 0.3; sleep 0.5 }
  sleep 4
  hit 1.5
end

sleep 8
```

After the main section, everything stops except quiet hi-hats. Listeners expect the outro — instead, they get the biggest hit of the track.

### The Peak

```ruby
# PEAK: 10 bars - MAXIMUM
in_thread do
  10.times { drums_brutal 1.2, 1.15, 0.85 }
end

in_thread do
  5.times { bassline 1.15, 88; bassline 1.15, 92 }
end

in_thread do
  with_fx :reverb, room: 0.5, mix: 0.25 do
    10.times { skull_pattern 1 }
  end
end

in_thread do
  sleep 8
  5.times { stab 0.9; sleep 4; stab 0.85; sleep 4 }
end

sleep 40
```

Everything at maximum:
- Drums at 1.2 (20% louder than normal)
- Bass cutoff at 88-92 (brightest in album)
- All elements playing

## Key Techniques

### 1. The Hook Sound

Every great track has a signature. Skull Fracture's is the alarm:

```ruby
use_synth :mod_saw
play :f4, mod_phase: 0.08, mod_range: 8, cutoff: 115
```

Design sounds that are:
- Instantly recognizable
- Different from other tracks
- Tied to the track's concept ("skull" = sharp, alarming)

### 2. Fake Drops

Subvert expectations:

```
Expected: MAIN → OUTRO
Actual:   MAIN → SILENCE → BIGGEST HIT → PEAK → OUTRO
```

The silence makes the peak feel even bigger.

### 3. Note Density = Energy

| Section | Notes per bar |
|---------|---------------|
| Intro | ~15 |
| Main | ~30 |
| Peak | ~40 |

More notes = more energy (but don't sacrifice clarity).

### 4. F Minor Darkness

F Minor is one of the darkest keys. The Db (b6) note is particularly unsettling:

```ruby
# Very dark
bass :db2  # b6 in F minor

# Less dark
bass :c2   # 5th in F minor
```

Use b6 for maximum darkness.

## The Skull Concept

The title guides everything:
- **Sound:** Alarm-like (warning of danger)
- **Rhythm:** Brutal, skull-cracking impacts
- **Feel:** Relentless assault

Name → Sound → Success.

## Full Code

The complete track code is available in `04_skull_fracture.rb`.

---

Next: [Track 05: Midnight Protocol](./track05-midnight-protocol.md) — melodic relief.
