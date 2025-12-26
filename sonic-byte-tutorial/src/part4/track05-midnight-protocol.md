# 05: Midnight Protocol

**BPM:** 102 | **Key:** C Minor | **Duration:** ~3:20

Synthwave triumph. After Skull Fracture's violence, Midnight Protocol provides melodic relief with uplifting arpeggios and triumphant leads.

## The Vision

Track 5 is the album's emotional pivot:

1. **Melodic focus** — Strong, memorable melodies
2. **Synthwave influence** — 80s-inspired arpeggios
3. **Triumphant feel** — Dark but not depressing
4. **Groove over brutality** — Still dark, but you can breathe

## What Makes It Unique

### Synthwave Arpeggios

Carpenter Brut-inspired patterns:

```ruby
define :arp1 do |v=1|
  use_synth :pulse
  notes = [:c4, :eb4, :g4, :c5, :g4, :eb4, :c4, :g3]
  notes.each do |n|
    play n, amp: 0.25*v, attack: 0.01, decay: 0.12,
         release: 0.12, cutoff: 102, pulse_width: 0.3
    sleep 0.5
  end
end
```

**C minor arpeggio** — dark but with upward motion that feels hopeful.

### Triumphant Lead Melody

The lead is more melodic than any other track:

```ruby
define :lead do |n, dur=0.5, v=1|
  use_synth :prophet
  play n, amp: 0.45*v, attack: 0.06, decay: dur*0.3,
       sustain: dur*0.45, release: dur*0.55, cutoff: 92, res: 0.12
  use_synth :saw
  play n+12, amp: 0.12*v, attack: 0.08,
       sustain: dur*0.3, release: dur*0.4, cutoff: 78
end
```

**Key choices:**
- Longer attack (0.06) — more singing quality
- Octave shimmer layer — adds brightness/hope
- Higher cutoff (92) — brighter than darker tracks

### The Melodies

Four phrases that tell a story:

```ruby
define :mel1 do |v=1|  # Rising hope
  lead :c4, 0.5, v; sleep 0.5
  lead :eb4, 0.5, v*0.95; sleep 0.5
  lead :g4, 1, v; sleep 1
  lead :c5, 1.5, v; sleep 2
end

define :mel2 do |v=1|  # Gentle descent
  lead :c5, 0.75, v; sleep 0.75
  lead :bb4, 0.5, v*0.9; sleep 0.5
  lead :g4, 0.75, v*0.95; sleep 0.75
  lead :eb4, 0.5, v*0.85; sleep 0.5
  lead :c4, 1.5, v; sleep 1.5
end

define :mel3 do |v=1|  # Emotional peak
  lead :g4, 0.5, v; sleep 0.5
  lead :ab4, 0.75, v; sleep 0.75  # Ab = emotional tension
  lead :g4, 0.5, v*0.9; sleep 0.5
  lead :f4, 0.75, v*0.95; sleep 0.75
  lead :eb4, 1.5, v; sleep 1.5
end

define :mel4 do |v=1|  # Resolution
  lead :eb4, 0.5, v; sleep 0.5
  lead :f4, 0.5, v*0.9; sleep 0.5
  lead :g4, 1, v; sleep 1
  lead :c4, 2, v; sleep 2
end
```

**The arc:** Rise → Descent → Tension (Ab) → Resolution to root (C)

### Groovy, Not Brutal Drums

Back to four-on-the-floor, but with swing:

```ruby
define :drums do |k=1, s=1, h=1|
  in_thread do
    kick k; sleep 1
    kick k*0.75; sleep 0.75
    kick k*0.85; sleep 0.25
    kick k; sleep 1
    kick k*0.8; sleep 1
  end
  in_thread do
    sleep 1; snare s; sleep 1; snare s*0.9; sleep 2
  end
  in_thread do
    8.times { hat h; sleep 0.5 }
  end
  sleep 4
end
```

**Ghost kick** at beat 2.75 creates groove without aggression.

## Sound Design

### Warm Bass

Prophet-based for warmth:

```ruby
define :bass do |n, v=1, c=78|
  use_synth :prophet
  play n, amp: 0.6*v, attack: 0.02, decay: 0.22,
       sustain: 0.15, release: 0.2, cutoff: c, res: 0.2
  use_synth :sine
  play n-12, amp: 1.05*v, attack: 0.01, sustain: 0.28, release: 0.2
end
```

No TB303 or dsaw — pure analog warmth.

### Pad Layer

Sustained chords for fullness:

```ruby
define :pad do |notes, v=1|
  use_synth :prophet
  play notes, amp: 0.25*v, attack: 1.5, decay: 0.5,
       sustain: 2, release: 2.5, cutoff: 72
end
```

Plays full chords: `pad [:c3, :eb3, :g3]`

### Bright Hi-Hats

```ruby
define :hat do |v=1|
  sample :drum_cymbal_closed, amp: 0.28*v, rate: 2.0, release: 0.06
end
```

Slightly lower rate (2.0 vs 2.2+) — less metallic, more musical.

## Patterns

### Bassline (Melodic)

```ruby
define :bassline do |v=1, c=78|
  bass :c2, v, c; sleep 1.5
  bass :c2, v*0.6, c-8; sleep 0.5
  bass :eb2, v*0.85, c; sleep 1
  bass :f2, v*0.9, c; sleep 0.5
  bass :g2, v*0.8, c+5; sleep 0.5
end
```

**The movement:** C → Eb → F → G — ascending bassline = building energy.

### Second Arpeggio

```ruby
define :arp2 do |v=1|
  use_synth :pulse
  notes = [:g4, :c5, :eb5, :g5, :eb5, :c5, :g4, :c4]
  notes.each do |n|
    play n, amp: 0.22*v, attack: 0.01, decay: 0.1,
         release: 0.1, cutoff: 98, pulse_width: 0.35
    sleep 0.5
  end
end
```

Higher register — plays call-and-response with arp1.

## Arrangement

```text
INTRO (32) → BUILD (32) → MAIN A (48) → BREAK (16) → MAIN B (48) → OUTRO (32)
```

### The Build: Arp Entry

```ruby
# BUILD: 8 bars
in_thread do
  8.times { drums 0.85, 0.7, 0.6 }
end

in_thread do
  8.times { bassline 0.75, 70 }
end

in_thread do
  with_fx :reverb, room: 0.6, mix: 0.4 do
    sleep 16
    2.times { arp1 0.5; arp2 0.45 }
  end
end

in_thread do
  with_fx :reverb, room: 0.7, mix: 0.5 do
    sleep 24
    pad [:c3, :eb3, :g3], 0.4
  end
end

sleep 32
hit 1
```

Elements enter in layers: drums → bass → arps → pad.

### The Break: Melody Focus

```ruby
# BREAK: 4 bars - spotlight on melody
in_thread do
  8.times { hat 0.35; sleep 0.5 }; sleep 8
end

in_thread do
  with_fx :reverb, room: 0.85, mix: 0.55 do
    with_fx :echo, phase: 0.75, decay: 5, mix: 0.45 do
      mel3 0.6; mel4 0.55
    end
  end
end

in_thread do
  with_fx :reverb, room: 0.9, mix: 0.6 do
    pad [:ab2, :c3, :eb3], 0.35  # Ab for tension
  end
end

sleep 16
hit 1.1
```

**Ab chord** under the melody creates tension before resolution in Main B.

## Key Techniques

### 1. Synthwave Arp Formula

Classic synthwave arpeggios follow this pattern:

```ruby
# Root position up and down
[:c4, :eb4, :g4, :c5, :g4, :eb4, :c4, :g3]
#  1    b3   5    8    5    b3   1    5(low)
```

Variations:
```ruby
# Extended range
[:c4, :eb4, :g4, :c5, :eb5, :c5, :g4, :eb4]

# With passing tones
[:c4, :d4, :eb4, :g4, :c5, :g4, :eb4, :d4]
```

### 2. Triumphant ≠ Happy

Midnight Protocol is triumphant but still dark:

**Dark elements:**
- Minor key (C minor)
- Dark pad tones
- Sub-bass weight

**Triumphant elements:**
- Ascending melodies
- Bright arp tones
- Longer, singing lead notes

The balance is key.

### 3. Ab in C Minor

The Ab note (b6) adds emotional weight:

```ruby
# Standard C minor: C D Eb F G Ab Bb
lead :ab4  # Creates yearning, emotional tension
```

Use it sparingly for maximum impact (mel3 uses it at the peak).

### 4. Groove Through Ghost Notes

The ghost kick at beat 2.75 creates swing:

```ruby
kick k; sleep 1
kick k*0.75; sleep 0.75   # Ghost: softer, slightly early
kick k*0.85; sleep 0.25   # Lands on beat 3
```

This makes the track "breathe" instead of hammer.

## The Midnight Aesthetic

"Midnight Protocol" evokes:
- **Midnight** — The darkest hour, but also possibility
- **Protocol** — Digital, systematic, precise (the arpeggios)
- **Synthwave** — Neon-lit nights, driving through darkness

A moment of beauty in a brutal album.

## Hacker Challenges

1. **Major Key Experiment**: Change the arpeggio from C minor to C major (`:c4, :e4, :g4, :c5...`). How dramatically does the mood shift? Can dark clubbing work in major keys?

2. **Double-Time Arp**: Run the arpeggio at 16th notes (`sleep 0.25`) instead of 8th notes. Does it add energy or become too busy?

3. **Strip the Shimmer**: Remove the octave-up `:saw` layer from the lead. What's lost? Is the shimmer essential or decorative?

4. **Write a Counter-Melody**: Create `mel5` that plays *against* the main melodies — different rhythm, complementary notes. Can two melodies coexist without fighting?

5. **Synthwave the Drums**: Replace the industrial kick layers with a cleaner, punchier 80s-style kick:
   ```ruby
   sample :bd_haus, amp: 2, rate: 1.0
   ```
   Does the track become more or less "Midnight Protocol"?

## Full Code

The complete track code is available in `05_midnight_protocol.rb`.

---

Next: [Track 06: Void Walker](./track06-void-walker.md) — dark power at slow tempo.
