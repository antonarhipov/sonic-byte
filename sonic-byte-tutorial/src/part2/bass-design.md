# Bass Design

Bass is weight. Bass is darkness. Bass is the thing that makes people move without thinking about it.

In a club, you don't just hear bass — you feel it in your ribs, in your teeth, in your bones. That physical impact is what we're building here.

## The Layering Philosophy

A powerful bass isn't one sound — it's several sounds working together:

1. **Sub layer** — Pure low frequency (sine wave), felt more than heard
2. **Mid layer** — Character and grit (saw, square, TB303)
3. **Top layer** (optional) — Attack and presence

```ruby
define :bass do |n, v=1, c=80|
  # Mid layer - character
  use_synth :tb303
  play n, amp: 0.8*v, attack: 0.01, decay: 0.2, 
       sustain: 0.1, release: 0.15, cutoff: c, res: 0.3
  
  # Sub layer - weight
  use_synth :sine
  play n-12, amp: 1.1*v, attack: 0.01, sustain: 0.25, release: 0.2
end
```

The sub plays one octave lower (`n-12`) and uses a pure sine wave. The TB303 provides the gritty character.

## The TB303 Sound

The Roland TB-303 bass synthesizer defined acid house and remains central to electronic music. Sonic Pi's `:tb303` synth emulates it:

```ruby
use_synth :tb303
play :e2,
  amp: 0.8,
  attack: 0.01,
  decay: 0.2,
  sustain: 0.1,
  release: 0.15,
  cutoff: 80,      # Filter frequency - higher = brighter
  res: 0.3,        # Resonance - higher = more "squelchy"
  wave: 0          # 0 = saw, 1 = square
```

### Key Parameters

**cutoff** (30-130): Controls brightness
- 60-70: Dark, subby
- 75-85: Balanced, present
- 90+: Aggressive, cutting

**res** (0-1): Resonance adds character
- 0.2-0.3: Subtle color
- 0.4-0.5: Classic acid sound
- 0.6+: Screaming, use carefully

**wave**: Waveform shape
- 0 (saw): Brighter, more harmonics
- 1 (square): Hollow, more fundamental

## Alternative Bass Synths

### Prophet — Warm and Musical

```ruby
use_synth :prophet
play :d2,
  amp: 0.6,
  attack: 0.03,
  decay: 0.25,
  sustain: 0.15,
  release: 0.2,
  cutoff: 75,
  res: 0.2
```

Used in: Chrome Cathedral, Terminal Velocity

### Dsaw — Aggressive and Wide

```ruby
use_synth :dsaw
play :d2,
  amp: 0.5,
  attack: 0.01,
  decay: 0.2,
  release: 0.15,
  cutoff: 80,
  detune: 0.2    # Spread between oscillators
```

The `detune` parameter creates width. Higher values = wider, more aggressive.

## Bass Layering Examples

### Track 1: System Override

```ruby
define :bass do |n, v=1, c=80|
  use_synth :dsaw
  play n, amp: 0.6*v, attack: 0.01, decay: 0.15, 
       sustain: 0.1, release: 0.15, cutoff: c, detune: 0.15
  
  use_synth :tb303
  play n, amp: 0.5*v, attack: 0, decay: 0.2, 
       sustain: 0, release: 0.1, cutoff: c-10, res: 0.4, wave: 1
  
  use_synth :sine
  play n-12, amp: 1.2*v, attack: 0.02, sustain: 0.3, release: 0.2
end
```

Three layers:
1. **Dsaw** — Width and aggression
2. **TB303** (square wave) — Grit and character
3. **Sine** — Sub foundation

### Track 2: Nerve Damage

```ruby
define :grind do |n, v=1, c=75|
  use_synth :tb303
  play n, amp: 0.8*v, attack: 0.01, decay: 0.2, 
       sustain: 0.1, release: 0.15, cutoff: c, res: 0.3, wave: 0
  
  use_synth :sine
  play n-12, amp: 1.1*v, attack: 0.01, sustain: 0.25, release: 0.15
end
```

Simpler layering, but with higher resonance for that "grinding" character.

## Writing Bass Patterns

### The One-Bar Pattern

Most tracks use 4-beat bass patterns:

```ruby
define :bassline do |v=1, c=80|
  bass :d2, v, c; sleep 0.75
  bass :d2, v*0.7, c-10; sleep 0.25
  bass :f2, v*0.9, c; sleep 0.5
  bass :d2, v*0.8, c; sleep 0.5
  bass :a2, v, c+5; sleep 0.5
  bass :d2, v, c; sleep 1.5
end
```

Notice:
- **Velocity variation** (`v*0.7`, `v*0.8`) — Creates groove
- **Cutoff variation** (`c-10`, `c+5`) — Adds movement
- **Rhythmic variety** — Mix of 0.5, 0.75, 1.5 beat notes

### Creating Movement

Use multiple bassline variations:

```ruby
define :bass1 do |v=1, c=75|
  bass :g1,v,c; sleep 0.5
  bass :g1,v*0.5,c-5; sleep 0.5
  bass :bb1,v*0.8,c; sleep 0.5
  bass :g1,v*0.9,c; sleep 0.5
  bass :f1,v*0.7,c; sleep 0.5
  bass :g1,v,c+5; sleep 0.5
  bass :d2,v*0.8,c; sleep 0.5
  bass :g1,v,c; sleep 0.5
end

define :bass2 do |v=1, c=75|
  bass :g1,v,c; sleep 0.75
  bass :bb1,v*0.85,c; sleep 0.25
  bass :c2,v*0.9,c; sleep 0.5
  bass :d2,v,c+8; sleep 0.5
  bass :eb2,v*0.95,c+5; sleep 0.5
  bass :d2,v*0.8,c; sleep 0.5
  bass :bb1,v*0.7,c; sleep 0.5
  bass :g1,v,c; sleep 0.5
end
```

Then alternate them:

```ruby
4.times do
  bass1 1, 80
  bass2 1, 80
end
```

### Bass Notes by Key

Each track uses a specific key. Here are the root notes:

| Key | Root | Common Notes |
|-----|------|--------------|
| D Minor | D | D, E, F, G, A, Bb, C |
| E Minor | E | E, F#, G, A, B, C, D |
| A Minor | A | A, B, C, D, E, F, G |
| F Minor | F | F, G, Ab, Bb, C, Db, Eb |
| C Minor | C | C, D, Eb, F, G, Ab, Bb |
| B Minor | B | B, C#, D, E, F#, G, A |
| G Minor | G | G, A, Bb, C, D, Eb, F |

## Filter Automation

Make bass evolve over time:

```ruby
in_thread do
  with_fx :lpf, cutoff: 60, cutoff_slide: 32 do |fx|
    control fx, cutoff: 90  # Slide from 60 to 90 over 32 beats
    8.times do
      bassline 1, 70
    end
  end
end
```

This creates a "filter opening" effect — the bass gets brighter over time, building energy.

## Tips for Heavy Bass

1. **Don't overcomplicate** — Two layers often beat four
2. **Keep sub clean** — No effects on the sine layer
3. **Use cutoff variation** — Even ±5 adds life
4. **Leave space** — Not every beat needs bass
5. **Match the kick** — Bass and kick should complement, not fight

---

Next: Leads and Melodies — how to write the hooks that define each track.
