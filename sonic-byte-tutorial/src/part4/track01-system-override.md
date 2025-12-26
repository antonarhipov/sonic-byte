# 01: System Override

**BPM:** 100 | **Key:** D Minor | **Duration:** ~2:30

The album opener. System Override establishes the sound with aggressive industrial textures and relentless 4-on-the-floor beats.

## The Vision

As the first track, System Override needs to:

1. **Establish the aesthetic** — Dark, aggressive, industrial
2. **Set energy expectations** — This album will hit hard
3. **Introduce key sounds** — Bass, drums, leads we'll develop
4. **Be relatively simple** — Save complexity for later tracks

## Sound Design

### Kick Drum

```ruby
define :kick do |v=1|
  sample :bd_tek, amp: 2*v, rate: 0.9
  sample :bd_boom, amp: 0.5*v, rate: 1.2, cutoff: 70
end
```

Two layers:
- **bd_tek** — The main punch, pitched down slightly (`rate: 0.9`)
- **bd_boom** — Adds low-end weight

### Snare

```ruby
define :snare do |v=1|
  sample :sn_dub, amp: v, rate: 0.85
end
```

Simple but effective. The `rate: 0.85` gives it a slightly deeper, more industrial character.

### Hi-Hat

```ruby
define :hat do |v=1|
  sample :drum_cymbal_closed, amp: 0.3*v, rate: 2.2, release: 0.05
end
```

High `rate` makes it tight and metallic. Short `release` keeps it crisp.

### Bass

```ruby
define :bass do |n, v=1, c=80|
  use_synth :dsaw
  play n, amp: 0.6*v, attack: 0.01, decay: 0.15, 
       sustain: 0.1, release: 0.15, cutoff: c, detune: 0.15
  
  use_synth :sine
  play n-12, amp: v, attack: 0.02, sustain: 0.3, release: 0.2
end
```

Two layers: aggressive dsaw on top, pure sine sub underneath.

### Lead

```ruby
define :lead do |n, dur=0.25, v=1|
  use_synth :prophet
  play n, amp: 0.4*v, attack: 0.02, decay: dur*0.5, 
       sustain: dur*0.3, release: dur*0.4, cutoff: 95
  
  use_synth :dark_ambience
  play n, amp: 0.15*v, attack: 0.05, release: dur*0.8
end
```

The `dark_ambience` layer adds atmosphere without overwhelming the melody.

## Patterns

### Drum Pattern

```ruby
define :drums do |k=1, s=1, h=1|
  in_thread do
    4.times { kick k; sleep 1 }
  end
  in_thread do
    sleep 1; snare s; sleep 1; snare s; sleep 2
  end
  in_thread do
    8.times { hat h; sleep 0.5 }
  end
  sleep 4
end
```

Classic 4-on-the-floor: kick on every beat, snare on 2 and 4, hats on eighth notes.

### Bassline

```ruby
define :bassline do |v=1, c=80|
  bass :d2, v, c; sleep 0.75
  bass :d2, v*0.7, c-10; sleep 0.75
  bass :f2, v*0.9, c; sleep 0.5
  bass :d2, v*0.8, c; sleep 0.5
  bass :a2, v, c+5; sleep 0.5
  bass :d2, v, c; sleep 1
end
```

The pattern:
- Starts on root (D)
- Ghost note with lower velocity and cutoff
- Moves to F (minor third)
- Returns to D
- Jumps to A (fifth)
- Resolves to D

### Melodic Hook

```ruby
define :hook do |v=1|
  lead :d4, 0.25, v; sleep 0.25
  lead :f4, 0.25, v*0.8; sleep 0.25
  lead :e4, 0.25, v*0.6; sleep 0.25
  lead :d4, 0.25, v*0.9; sleep 0.5
  lead :a4, 0.5, v; sleep 0.5
  lead :g4, 0.25, v*0.7; sleep 0.5
  lead :d4, 0.75, v; sleep 1
end

define :hook2 do |v=1|
  lead :a4, 0.5, v; sleep 0.5
  lead :g4, 0.25, v*0.8; sleep 0.25
  lead :f4, 0.25, v*0.7; sleep 0.25
  lead :e4, 0.5, v*0.9; sleep 0.5
  lead :d4, 0.25, v; sleep 0.25
  lead :c4, 0.25, v*0.6; sleep 0.25
  lead :d4, 1, v; sleep 1.25
end
```

Two complementary phrases that play call-and-response.

## Arrangement

```
INTRO    | 8 bars  | Kicks only, then hats
BUILD    | 8 bars  | Add snares, bass enters low-passed
MAIN A   | 12 bars | Full groove, hooks enter
BREAK    | 4 bars  | Strip kick, tension with reverb
MAIN B   | 12 bars | Return harder, full energy
OUTRO    | 4 bars  | Drums only, fading for mix
```

### Intro (32 beats)

```ruby
in_thread do
  8.times { drums 0.8, 0, 0 }  # Kicks only
end
in_thread do
  sleep 16
  4.times { drums 0, 0, 0.5 }  # Add hats
end
sleep 32
```

Notice: `drums 0.8, 0, 0` — kick at 80%, no snare (0), no hats (0).

### Build (32 beats)

```ruby
in_thread do
  8.times { drums 0.9, 0.7, 0.6 }
end
in_thread do
  8.times { bassline 0.7, 65 }  # Low cutoff = filtered
end
sleep 32
hit 1
```

The bass enters with cutoff at 65 (darker). The `hit` function provides impact at the end.

### Main A (48 beats)

```ruby
in_thread do
  12.times { drums 1, 0.9, 0.75 }
end
in_thread do
  12.times { bassline 1, 85 }  # Full cutoff now
end
in_thread do
  sleep 8
  4.times { hook 0.7; sleep 1; hook2 0.6; sleep 1 }
end
sleep 48
```

Full energy. The hook enters after 8 beats, letting the groove establish first.

### Break (16 beats)

```ruby
with_fx :reverb, room: 0.8 do
  with_fx :hpf, cutoff: 85 do
    in_thread do
      16.times { hat 0.4; sleep 0.5 }
    end
    in_thread do
      hook 0.6; sleep 4; hook2 0.5
    end
  end
end
sleep 16
hit 1.2
```

The high-pass filter (`hpf`) removes bass frequencies, creating tension. Big hit at the end signals the return.

### Main B (48 beats)

```ruby
in_thread do
  12.times { drums 1.1, 1, 0.85 }  # Louder than Main A
end
in_thread do
  12.times { bassline 1.1, 90 }    # Brighter cutoff
end
in_thread do
  6.times { hook 0.85; sleep 1; hook2 0.75; sleep 1 }
end
sleep 48
```

Everything is slightly louder and brighter than Main A — this is the peak.

### Outro (16 beats)

```ruby
in_thread do
  4.times do |i|
    drums (0.9-i*0.2), (0.7-i*0.15), (0.6-i*0.12)
  end
end
sleep 16
```

The `|i|` creates a counter (0, 1, 2, 3). Each iteration gets quieter, creating a fade.

## Key Takeaways

1. **Layer sounds** — Two samples for kick, two synths for bass
2. **Use velocity variation** — `v*0.7`, `v*0.8` creates groove
3. **Filter automation** — Cutoff changes add movement
4. **Structural contrast** — Break strips energy before peak
5. **Clean outro** — Drums only for DJ mixing

## Full Code

The complete track code is available in `01_system_override.rb`.

---

Next: [Track 02: Nerve Damage](track02-nerve-damage.md) — Pushing aggression with industrial textures.
