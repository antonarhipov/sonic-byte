# 03: Chrome Cathedral

**BPM:** 98 | **Key:** A Minor | **Duration:** ~3:15

Atmospheric cyberpunk. After two aggressive tracks, Chrome Cathedral provides breathing room with spacious reverbs and hypnotic arpeggios.

## The Vision

Track 3 is the album's first "breath." It needs to:

1. **Provide contrast** — Slower, more spacious than Tracks 1-2
2. **Maintain darkness** — Atmospheric, not soft
3. **Showcase effects** — Reverb and delay take center stage
4. **Be hypnotic** — Repetition with subtle evolution

## What Makes It Unique

### Slow, Spacious BPM

At 98 BPM, Chrome Cathedral is noticeably slower:

| Track | BPM | Feel |
|-------|-----|------|
| System Override | 100 | Driving |
| Nerve Damage | 105 | Urgent |
| **Chrome Cathedral** | **98** | **Hypnotic** |

The slower tempo creates space for reverb tails and atmospheric textures.

### Arpeggio-Driven

Instead of aggressive leads, Chrome Cathedral uses hypnotic arpeggios:

```ruby
define :arp1 do |v=1|
  use_synth :pulse
  notes = [:a3, :c4, :e4, :a4, :e4, :c4, :a3, :e3]
  notes.each do |n|
    play n, amp: 0.22*v, attack: 0.01, decay: 0.12,
         release: 0.12, cutoff: 98, pulse_width: 0.35
    sleep 0.5
  end
end
```

**The pattern:** A minor arpeggio up and down — simple, hypnotic.

### Heavy Reverb Processing

Everything is drenched in space:

```ruby
with_fx :reverb, room: 0.85, mix: 0.55 do
  with_fx :echo, phase: 0.75, decay: 5, mix: 0.45 do
    4.times { arp1 0.7 }
  end
end
```

Compare to Track 1's tighter processing:
- Track 1: `room: 0.6, mix: 0.4`
- Track 3: `room: 0.85, mix: 0.55`

### Warm Prophet Bass

Softer than the TB303 aggression:

```ruby
define :bass do |n, v=1, c=72|
  use_synth :prophet
  play n, amp: 0.55*v, attack: 0.03, decay: 0.25,
       sustain: 0.2, release: 0.25, cutoff: c, res: 0.18
  use_synth :sine
  play n-12, amp: 1.0*v, attack: 0.02, sustain: 0.3, release: 0.25
end
```

**Key differences from Track 1:**
- Prophet instead of TB303/dsaw — warmer tone
- Lower cutoff (72 vs 80) — darker
- Longer attack (0.03 vs 0.01) — softer entry

## Sound Design

### Pad Layer

Atmospheric background texture:

```ruby
define :pad do |notes, v=1|
  use_synth :dark_ambience
  play notes, amp: 0.3*v, attack: 2, decay: 1,
       sustain: 3, release: 4, cutoff: 70
end
```

Long ADSR values create evolving, washy textures.

### Drums (Stripped Back)

```ruby
define :drums do |k=1, s=1, h=1|
  in_thread do
    kick k; sleep 1.5
    kick k*0.6; sleep 0.5
    kick k*0.8; sleep 1
    kick k; sleep 1
  end
  in_thread do
    sleep 1.5; snare s*0.7; sleep 2.5
  end
  in_thread do
    8.times { hat h; sleep 0.5 }
  end
  sleep 4
end
```

**Key differences:**
- Syncopated kicks (not straight four-on-floor)
- Only one snare per bar (beat 2.5)
- Same hi-hat pattern, but lower volume

### Whisper Texture

High, ethereal layer:

```ruby
define :whisper do |n, v=1|
  use_synth :hollow
  play n, amp: 0.15*v, attack: 0.5, decay: 0.3,
       sustain: 0.4, release: 1.5, cutoff: 85
end
```

The `hollow` synth adds ghostly presence.

## Patterns

### Bassline (Minimal)

```ruby
define :bassline do |v=1, c=72|
  bass :a1, v, c; sleep 2
  bass :a1, v*0.5, c-8; sleep 1
  bass :e2, v*0.8, c; sleep 1
end
```

Only 3 notes per bar — space is the point.

### Second Arpeggio (Variation)

```ruby
define :arp2 do |v=1|
  use_synth :pulse
  notes = [:a4, :g4, :e4, :c4, :e4, :g4, :a4, :c5]
  notes.each do |n|
    play n, amp: 0.2*v, attack: 0.01, decay: 0.1,
         release: 0.15, cutoff: 95, pulse_width: 0.4
    sleep 0.5
  end
end
```

Descending then ascending — complements arp1.

## Arrangement

```text
INTRO (32) → BUILD (32) → MAIN A (48) → AMBIENT (24) → MAIN B (40) → OUTRO (32)
```

### The "Ambient" Section

Instead of a traditional break, Chrome Cathedral has an ambient interlude:

```ruby
# AMBIENT: 6 bars - pure atmosphere
in_thread do
  with_fx :reverb, room: 0.95, mix: 0.7 do
    pad [:a2, :e3, :a3], 0.6
    sleep 8
    pad [:a2, :c3, :e3], 0.5
    sleep 8
    pad [:a2, :e3, :g3], 0.55
  end
end

in_thread do
  with_fx :reverb, room: 0.9, mix: 0.6 do
    with_fx :echo, phase: 1.5, decay: 8, mix: 0.5 do
      sleep 4
      whisper :a5, 0.4
      sleep 6
      whisper :e5, 0.35
      sleep 6
      whisper :c5, 0.4
    end
  end
end

sleep 24
```

**No drums, no bass** — just pads and whispers floating in reverb.

### Long Outro

```ruby
# OUTRO: 8 bars - fading into space
in_thread do
  4.times do |i|
    drums (0.7-i*0.12), (0.5-i*0.1), (0.55-i*0.1)
  end
  4.times { |i| hat (0.35-i*0.08); sleep 0.5 }
end

in_thread do
  with_fx :reverb, room: 0.95, mix: 0.65 do
    with_fx :echo, phase: 1, decay: 10, mix: 0.55 do
      2.times { arp1 0.4 }
      arp2 0.3
    end
  end
end

sleep 32
```

The decay: 10 on the echo means notes ring out long after the track ends.

## Key Techniques

### 1. Space Through Subtraction

Less is more. Compare note density:

| Track | Notes per bar (approx) |
|-------|------------------------|
| Nerve Damage | 25+ |
| Chrome Cathedral | 12-15 |

### 2. Reverb as Instrument

Reverb isn't just polish — it's compositional:

```ruby
# DRY: Sounds thin, mechanical
play :a4

# WET: Sounds like a cathedral
with_fx :reverb, room: 0.9, mix: 0.6 do
  play :a4
end
```

### 3. Syncopated Drums for Float

Straight four-on-floor is driving. Syncopation floats:

```ruby
# Driving (Tracks 1-2)
4.times { kick; sleep 1 }

# Floating (Track 3)
kick; sleep 1.5
kick; sleep 0.5
kick; sleep 1
kick; sleep 1
```

### 4. Pulse Width for Character

The `pulse` synth's `pulse_width` parameter changes its tone:

```ruby
pulse_width: 0.5   # Square wave, hollow
pulse_width: 0.35  # Thinner, more nasal
pulse_width: 0.2   # Very thin, reedy
```

Chrome Cathedral uses 0.35-0.4 for a slightly hollow, retro sound.

## The Cyberpunk Aesthetic

"Chrome Cathedral" evokes:
- Chrome — metallic, reflective (the pulse arpeggios)
- Cathedral — vast, reverberant (the heavy effects)
- Cyberpunk — neon-lit darkness, melancholy technology

The title guides the sound design. Name your tracks evocatively.

## Hacker Challenges

1. **Drown It in Reverb**: Set reverb `room: 1.0` and `mix: 0.8`. At what point does atmosphere become mud? Find the threshold.

2. **Generative Arpeggio**: Replace the fixed note array with:
   ```ruby
   8.times do
     play scale(:a3, :minor_pentatonic).choose, amp: 0.22, release: 0.12
     sleep 0.5
   end
   ```
   Let the arpeggio write itself. Does it still feel intentional?

3. **Add a Pad Chord Progression**: The track uses single pad chords. Try a simple progression:
   ```ruby
   [[:a2,:e3,:a3], [:f2,:c3,:f3], [:g2,:d3,:g3], [:a2,:e3,:a3]].each do |chord|
     pad chord, 0.5
     sleep 8
   end
   ```
   Does movement help or hurt the hypnotic quality?

4. **Speed It Up**: Change to 110 BPM. Does Chrome Cathedral still feel atmospheric, or does it become a different track entirely?

5. **Kill the Reverb in the Drop**: After the ambient section, cut reverb to `room: 0.3`. Does the contrast make the return feel more powerful?

## Full Code

The complete track code is available in `03_chrome_cathedral.rb`.

---

Next: [Track 04: Skull Fracture](./track04-skull-fracture.md) — maximum aggression.
