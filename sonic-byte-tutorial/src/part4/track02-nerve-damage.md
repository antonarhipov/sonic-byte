# 02: Nerve Damage

**BPM:** 105 | **Key:** E Minor | **Duration:** ~3:00

Industrial crusher. Nerve Damage pushes the aggression established in Track 1, introducing double-time kicks and grinding textures.

## The Vision

Track 2's role is to say "Track 1 wasn't a fluke — this album means business." It needs to:

1. **Escalate intensity** — Faster, harder than System Override
2. **Introduce industrial textures** — Grinding, mechanical sounds
3. **Maintain groove** — Aggressive but still danceable

## What Makes It Unique

### Double-Time Kicks

While Track 1 used standard four-on-the-floor, Nerve Damage doubles the kick rate:

```ruby
define :drums_x do |k=1, s=1, h=1|
  in_thread do
    8.times do
      kick k
      sleep 0.5  # Kick every half beat = 8 per bar
    end
  end
  in_thread do
    sleep 1; snare s; sleep 1; snare s; sleep 2
  end
  in_thread do
    16.times { hat h; sleep 0.25 }  # Sixteenth note hats
  end
  sleep 4
end
```

**The effect:** Relentless, driving energy. The 8 kicks per bar create a steamroller feel.

### The "Grind" Bass

Named for its grinding, industrial character:

```ruby
define :grind do |n, v=1, c=75|
  use_synth :tb303
  play n, amp: 0.8*v, attack: 0.01, decay: 0.2,
       sustain: 0.1, release: 0.15, cutoff: c, res: 0.3, wave: 0
  use_synth :sine
  play n-12, amp: 1.1*v, attack: 0.01, sustain: 0.25, release: 0.15
end
```

**Key choices:**
- `res: 0.3` — Higher resonance than Track 1 for more "squelch"
- `wave: 0` — Saw wave for brightness and grit
- Named `grind` not `bass` — reflects its character

### Industrial Snare

Layered for mechanical punch:

```ruby
define :snare do |v=1|
  sample :sn_dub, amp: v, rate: 0.8
  sample :drum_snare_hard, amp: 0.4*v, rate: 0.9
end
```

The second layer adds metallic crack.

## Sound Design

### Kick (same as Track 1)
```ruby
define :kick do |v=1|
  sample :bd_tek, amp: 2.2*v, rate: 0.9
  sample :bd_boom, amp: 0.5*v, rate: 1.2, cutoff: 70
end
```

Consistency across album — the kick is our anchor.

### Hi-Hat (tighter)
```ruby
define :hat do |v=1|
  sample :drum_cymbal_closed, amp: 0.22*v, rate: 2.4, release: 0.04
end
```

Higher `rate` (2.4 vs 2.2) and shorter `release` — tighter, more mechanical.

### Signature Riff

A grinding melodic hook:

```ruby
define :riff do |v=1|
  use_synth :mod_saw
  play :e3, amp: 0.35*v, attack: 0, decay: 0.08,
       sustain: 0.04, release: 0.06, mod_phase: 0.12, mod_range: 5, cutoff: 105
  sleep 0.25
  play :e3, amp: 0.25*v, attack: 0, decay: 0.06,
       sustain: 0.03, release: 0.05, mod_phase: 0.15, mod_range: 6, cutoff: 100
  sleep 0.25
  play :g3, amp: 0.3*v, attack: 0, decay: 0.07,
       sustain: 0.04, release: 0.06, mod_phase: 0.12, mod_range: 5, cutoff: 108
  sleep 0.5
end
```

The `mod_saw` with modulation creates an alarm-like, industrial texture.

## Patterns

### Bassline

```ruby
define :bassline do |v=1, c=75|
  grind :e2, v, c; sleep 0.5
  grind :e2, v*0.6, c-8; sleep 0.5
  grind :g2, v*0.85, c; sleep 0.5
  grind :e2, v*0.75, c-5; sleep 0.5
  grind :d2, v*0.9, c; sleep 0.5
  grind :e2, v, c+5; sleep 0.5
  grind :b2, v*0.8, c; sleep 0.5
  grind :e2, v, c; sleep 0.5
end
```

**E Minor movement:** E (root) → G (minor 3rd) → D (7th) → B (5th)

### Riff Pattern

```ruby
define :riff_pattern do |v=1|
  2.times { riff v }
  sleep 1.5
  riff v*0.8
  sleep 0.5
end
```

The riff plays twice, pauses, then once more — creating rhythmic interest.

## Arrangement

```text
INTRO (32) → BUILD (32) → MAIN A (48) → BREAK (16) → MAIN B (48) → OUTRO (24)
```

### The Intensity Curve

| Section | Kicks | Snare | Hats | Bass | Riff |
|---------|-------|-------|------|------|------|
| Intro | 8/bar | — | light | filtered | — |
| Build | 8/bar | enters | building | opening | teases |
| Main A | 8/bar | full | full | full | full |
| Break | — | — | only | — | reverbed |
| Main B | 8/bar | full | full | brighter | full |
| Outro | fading | fading | fading | — | echoing |

### Key Moment: The Build

```ruby
# BUILD: 8 bars
in_thread do
  8.times { drums_x 0.85, 0.7, 0.55 }
end

in_thread do
  with_fx :lpf, cutoff: 55, cutoff_slide: 32 do |fx|
    control fx, cutoff: 95
    8.times { bassline 0.75, 60 }
  end
end

in_thread do
  sleep 16
  with_fx :reverb, room: 0.7, mix: 0.5 do
    4.times { riff_pattern 0.5 }
  end
end

sleep 32
hit 1.1
```

The bass filter opens from 55→95 while the riff enters with reverb — building anticipation.

## Key Techniques

### 1. Double-Time for Intensity

Doubling the kick rate is the simplest way to increase energy:

```ruby
# Normal: 4 kicks per bar
4.times { kick; sleep 1 }

# Double: 8 kicks per bar  
8.times { kick; sleep 0.5 }
```

### 2. Velocity Variation on Fast Patterns

With 8 kicks per bar, static velocity sounds like a machine gun. Add variation:

```ruby
in_thread do
  8.times do |i|
    v = [1, 0.7, 0.85, 0.75, 0.95, 0.7, 0.8, 0.9][i]
    kick v
    sleep 0.5
  end
end
```

### 3. Industrial Texture with mod_saw

The `mod_saw` synth creates mechanical, alarm-like sounds:

```ruby
use_synth :mod_saw
play :e3,
  mod_phase: 0.12,  # Speed of modulation
  mod_range: 5,     # Depth (semitones)
  cutoff: 105
```

Lower `mod_phase` = faster wobble = more aggressive.

### 4. BPM Escalation

Track 1: 100 BPM → Track 2: 105 BPM

The 5 BPM increase is subtle but felt. It maintains groove while adding urgency.

## Mixing Considerations

With double-time kicks, mix carefully:

- **Kick volume:** Slightly lower than Track 1 (2.2 vs 2.5) to prevent overwhelming
- **Hat volume:** Lower (0.22 vs 0.25) — there are twice as many
- **Bass:** Same level, but filter more aggressively in intros

## Hacker Challenges

1. **Quad-Time Madness**: Push the kicks even further — 16 per bar instead of 8. At what point does it stop being music and become noise? Where's the line?

2. **Swing the Hats**: Instead of perfect 16th notes, try:
   ```ruby
   16.times do |i|
     hat h
     sleep i.even? ? 0.27 : 0.23  # Slight shuffle
   end
   ```
   Does it feel more human or just sloppy?

3. **Filter the Riff**: The `mod_saw` riff is bright and cutting. Wrap it in a low-pass filter that opens during the build. Does it create more anticipation?

4. **Remove the Sub Layer**: Delete the `:sine` sub from the bass. What's lost? Is the track still powerful or does it feel hollow?

5. **Create a Counter-Riff**: Write a second riff pattern that plays against the first. Can you create call-and-response between two `mod_saw` lines?

## Full Code

The complete track code is available in `02_nerve_damage.rb`.

---

Next: [Track 03: Chrome Cathedral](./track03-chrome-cathedral.md) — atmospheric contrast.
