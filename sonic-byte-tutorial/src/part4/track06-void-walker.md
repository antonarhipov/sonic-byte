# 06: Void Walker

**BPM:** 95 | **Key:** B Minor | **Duration:** ~3:30

Dark power at slow tempo. Void Walker proves that slow doesn't mean weak — each hit lands with devastating weight.

## The Vision

Track 6 builds tension before the album's climax:

1. **Slowest BPM** — 95 creates hypnotic menace
2. **Maximum weight** — Each element hits harder
3. **Space = power** — Less notes, more impact
4. **Building dread** — Preparing for Core Meltdown

## What Makes It Unique

### The Slowest Tempo

At 95 BPM, Void Walker is 13 BPM slower than Skull Fracture:

| Track | BPM | Feel |
|-------|-----|------|
| Skull Fracture | 108 | Frantic aggression |
| Midnight Protocol | 102 | Driving groove |
| **Void Walker** | **95** | **Menacing weight** |

Slow tempo = more time between hits = each hit feels heavier.

### Triple-Layer Dark Bass

The deepest, heaviest bass in the album:

```ruby
define :bass do |n, v=1, c=72|
  use_synth :prophet
  play n, amp: 0.6*v, attack: 0.02, decay: 0.28,
       sustain: 0.18, release: 0.22, cutoff: c, res: 0.22
  use_synth :dsaw
  play n, amp: 0.4*v, attack: 0.01, decay: 0.22,
       release: 0.18, cutoff: c-12, detune: 0.2
  use_synth :sine
  play n-12, amp: 1.2*v, attack: 0.02, sustain: 0.32, release: 0.25
end
```

**Key choices:**
- Prophet for warmth + dsaw for grit
- Lower cutoff (72) — darker than other tracks
- Louder sine sub (1.2) — physical weight
- Longer decay/release — notes bloom and sustain

### Dark Ambience Stabs

Power chord stabs using `dark_ambience`:

```ruby
define :stab do |notes, v=1|
  use_synth :dark_ambience
  play notes, amp: 0.4*v, attack: 0.04, decay: 0.35,
       sustain: 0.12, release: 0.45
end

define :stab_pattern do |v=1|
  stab [:b2, :fs3, :b3], v; sleep 2
  stab [:b2, :fs3, :b3], v*0.5; sleep 0.5
  stab [:d3, :a3, :d4], v*0.75; sleep 1.5
end
```

**B minor power chords** — dark and powerful.

### Pulse Arpeggios

Hypnotic, minimal arps:

```ruby
define :arp do |v=1|
  use_synth :pulse
  notes = [:b3, :d4, :fs4, :b4, :fs4, :d4, :b3, :fs3]
  notes.each do |n|
    play n, amp: 0.22*v, attack: 0.01, decay: 0.15,
         release: 0.12, cutoff: 95, pulse_width: 0.35
    sleep 0.5
  end
end
```

B minor arpeggio — simple but hypnotic at slow tempo.

### Whisper Textures

High, ethereal layer:

```ruby
define :whisper do |n, v=1|
  use_synth :hollow
  play n, amp: 0.18*v, attack: 0.4, decay: 0.3,
       sustain: 0.5, release: 1.2, cutoff: 82
end
```

Adds ghostly presence without taking focus.

## Sound Design

### Heavy Kick

```ruby
define :kick do |v=1|
  sample :bd_tek, amp: 2.4*v, rate: 0.85
  sample :bd_zum, amp: 0.6*v, rate: 1.0, cutoff: 65
end
```

**Lowest rate** (0.85) for the deepest pitch. The slow tempo lets each kick breathe.

### Snare (Impactful)

```ruby
define :snare do |v=1|
  sample :sn_dub, amp: v*1.05, rate: 0.78
end
```

Lower rate = deeper, more impactful.

### Drums Pattern (Half-Time Feel)

```ruby
define :drums do |k=1, s=1, h=1|
  in_thread do
    kick k; sleep 2
    kick k*0.65; sleep 0.5
    kick k*0.8; sleep 1.5
  end
  in_thread do
    sleep 2; snare s; sleep 2
  end
  in_thread do
    8.times { hat h; sleep 0.5 }
  end
  sleep 4
end
```

**Key difference:** Kick on beat 1 and 3.5, snare on beat 3 only.

This creates a **half-time feel** — even slower than the tempo suggests.

## Patterns

### Bassline (Sparse)

```ruby
define :bassline do |v=1, c=72|
  bass :b1, v, c; sleep 2
  bass :b1, v*0.55, c-10; sleep 0.5
  bass :d2, v*0.8, c; sleep 1
  bass :b1, v*0.7, c; sleep 0.5
end
```

Only 4 notes per bar — space is power.

### Lead (Sparse, Emotional)

```ruby
define :lead do |n, dur=1, v=1|
  use_synth :prophet
  play n, amp: 0.4*v, attack: 0.1, decay: dur*0.25,
       sustain: dur*0.5, release: dur*0.6, cutoff: 85, res: 0.15
end

define :melody do |v=1|
  lead :b4, 1.5, v; sleep 1.5
  lead :d5, 1, v*0.9; sleep 1
  lead :cs5, 1.5, v; sleep 1.5  # C# = major 2nd, tension
end
```

**Long notes** — at 95 BPM, a 1.5-beat note lasts nearly a full second.

## Arrangement

```
INTRO (32) → BUILD (32) → MAIN A (48) → DARK (24) → MAIN B (48) → OUTRO (28)
```

### The "Dark" Section

Instead of a break, a descent into darkness:

```ruby
# DARK: 6 bars - descent
in_thread do
  12.times { hat 0.3; sleep 0.5 }
  sleep 12
end

in_thread do
  with_fx :reverb, room: 0.95, mix: 0.65 do
    with_fx :echo, phase: 1.5, decay: 8, mix: 0.55 do
      whisper :b5, 0.35; sleep 6
      whisper :fs5, 0.3; sleep 5
      whisper :d5, 0.35; sleep 5
    end
  end
end

in_thread do
  with_fx :reverb, room: 0.9, mix: 0.6 do
    sleep 8
    stab [:b1, :fs2, :b2], 0.4  # Deep stab
    sleep 8
    stab [:d2, :a2, :d3], 0.35
  end
end

sleep 24
hit 1.3
```

**No bass, no kick** — just whispers and distant stabs floating in reverb.

### Building Weight

Energy through volume, not speed:

| Section | Kick amp | Bass amp | Stab amp |
|---------|----------|----------|----------|
| Intro | 0.7 | 0.5 | — |
| Build | 0.85 | 0.7 | 0.4 |
| Main A | 1.0 | 0.9 | 0.6 |
| Dark | — | — | 0.35 |
| Main B | 1.1 | 1.0 | 0.75 |
| Outro | fade | fade | fade |

### Long Outro

```ruby
# OUTRO: 7 bars - slow fade
in_thread do
  7.times do |i|
    drums (0.9-i*0.1), 0, (0.55-i*0.06)
  end
end

in_thread do
  with_fx :reverb, room: 0.95, mix: 0.65 do
    with_fx :echo, phase: 1.25, decay: 10, mix: 0.55 do
      2.times { arp 0.35 }
      arp 0.25
    end
  end
end

sleep 28
```

**10-second echo decay** — notes ring out long after playing stops.

## Key Techniques

### 1. Half-Time Feel

Even at 95 BPM, half-time makes it feel like 47.5:

```ruby
# Normal feel (kick every beat)
kick; sleep 1; kick; sleep 1; kick; sleep 1; kick; sleep 1

# Half-time (kick beats 1 and 3.5)
kick; sleep 2; kick; sleep 0.5; sleep 1.5
```

The sparse kick pattern creates massive weight.

### 2. Space = Power

Compare note density:

| Track | Bass notes/bar |
|-------|----------------|
| Nerve Damage | 8 |
| Skull Fracture | 8 |
| **Void Walker** | **4** |

Fewer notes = more impact per note.

### 3. Lower Everything

Void Walker uses lower rates/pitches than other tracks:

| Element | Other tracks | Void Walker |
|---------|--------------|-------------|
| Kick rate | 0.9 | 0.85 |
| Snare rate | 0.85 | 0.78 |
| Bass cutoff | 78-82 | 72 |

Everything is deeper, darker.

### 4. B Minor Character

B Minor has a unique darkness:

```ruby
# B natural minor: B C# D E F# G A
# The F# (5th) is strong and stable
# The G (b6) adds darkness

bass :b1; sleep 2    # Root - grounded
bass :fs2; sleep 1   # Fifth - powerful
bass :g2; sleep 1    # b6 - dark tension
```

### 5. Dynamic Range

Void Walker has the album's widest dynamic range:

- Quietest moments: whispers at 0.18 amp
- Loudest moments: kicks at 2.4 amp

**Contrast creates drama.**

## The Void Walker Concept

The title evokes:
- **Void** — Emptiness, space, darkness
- **Walker** — Slow, deliberate movement
- **Together** — Something moving through darkness, each step deliberate

The slow tempo and sparse arrangement embody walking through the void.

## Full Code

The complete track code is available in `06_void_walker.rb`.

---

Next: [Track 07: Core Meltdown](./track07-core-meltdown.md) — the album climax.
