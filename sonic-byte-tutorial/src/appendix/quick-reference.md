# Quick Reference

Copy-paste templates for common patterns.

## Track Skeleton

```ruby
use_bpm 100

# === SOUNDS ===
define :kick do |v=1|
  sample :bd_tek, amp: 2.2*v, rate: 0.9
  sample :bd_boom, amp: 0.5*v, rate: 1.2
end

define :snare do |v=1|
  sample :sn_dub, amp: v, rate: 0.85
end

define :hat do |v=1|
  sample :drum_cymbal_closed, amp: 0.25*v, rate: 2.2, release: 0.05
end

define :bass do |n, v=1, c=80|
  use_synth :tb303
  play n, amp: 0.8*v, attack: 0.01, decay: 0.2, 
       sustain: 0.1, release: 0.15, cutoff: c, res: 0.3
  use_synth :sine
  play n-12, amp: v, attack: 0.01, sustain: 0.25, release: 0.2
end

define :lead do |n, dur=0.5, v=1|
  use_synth :prophet
  play n, amp: 0.4*v, attack: 0.05, decay: dur*0.25,
       sustain: dur*0.45, release: dur*0.5, cutoff: 90
end

define :hit do |v=1|
  sample :bd_boom, amp: 2*v, rate: 0.4
end

# === PATTERNS ===
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

define :bassline do |v=1, c=80|
  bass :d2, v, c; sleep 1
  bass :d2, v*0.7, c-10; sleep 1
  bass :f2, v*0.9, c; sleep 1
  bass :d2, v, c; sleep 1
end

define :melody do |v=1|
  lead :d4, 0.5, v; sleep 0.5
  lead :f4, 0.5, v*0.9; sleep 0.5
  lead :a4, 1, v; sleep 1
  lead :g4, 0.5, v*0.85; sleep 0.5
  lead :d4, 1, v; sleep 1.5
end

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
sleep 32
hit 1

# MAIN: 12 bars
in_thread do
  12.times { drums 1, 0.9, 0.7 }
end
in_thread do
  12.times { bassline 1, 80 }
end
in_thread do
  with_fx :reverb, room: 0.6, mix: 0.4 do
    sleep 16
    4.times { melody 0.8 }
  end
end
sleep 48

# OUTRO: 6 bars
in_thread do
  6.times { |i| drums (1-i*0.12), (0.85-i*0.1), (0.7-i*0.08) }
end
sleep 24
```

## Common Effects Chains

### Standard Lead
```ruby
with_fx :reverb, room: 0.6, mix: 0.4 do
  with_fx :echo, phase: 0.5, decay: 3, mix: 0.3 do
    # lead code
  end
end
```

### Ethereal/Break
```ruby
with_fx :reverb, room: 0.95, mix: 0.6 do
  with_fx :echo, phase: 1, decay: 6, mix: 0.5 do
    # lead code
  end
end
```

### Tight/Peak
```ruby
with_fx :reverb, room: 0.5, mix: 0.25 do
  with_fx :echo, phase: 0.5, decay: 2, mix: 0.2 do
    # lead code
  end
end
```

### Filter Build
```ruby
with_fx :lpf, cutoff: 50, cutoff_slide: 32 do |fx|
  control fx, cutoff: 110
  # bass code for 32 beats
end
```

## Timing Values

| Value | Name | Per Bar |
|-------|------|---------|
| 4 | Whole note | 1 |
| 2 | Half note | 2 |
| 1 | Quarter note | 4 |
| 0.5 | Eighth note | 8 |
| 0.25 | Sixteenth note | 16 |
| 0.75 | Dotted eighth | ~5.3 |

## Volume Guidelines

| Element | Typical Range |
|---------|---------------|
| Kick sample | 2.0 - 2.5 |
| Snare | 0.8 - 1.1 |
| Hi-hat | 0.2 - 0.3 |
| Bass synth | 0.6 - 0.9 |
| Sub sine | 1.0 - 1.2 |
| Lead | 0.35 - 0.45 |
| Arp | 0.2 - 0.3 |
| Pad | 0.25 - 0.4 |

## Section Energy Levels

| Section | Drums | Bass | Lead |
|---------|-------|------|------|
| Intro | 0.7, 0, 0.4 | 0.5 | - |
| Build | 0.85, 0.7, 0.55 | 0.75 | 0.5 |
| Main | 1, 0.9, 0.7 | 1 | 0.8 |
| Break | 0, 0, 0.35 | - | 0.5 |
| Peak | 1.15, 1.05, 0.8 | 1.1 | 0.95 |
| Outro | fade | fade | 0.4 |

## Minor Scale Notes

| Key | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
|-----|---|---|---|---|---|---|---|
| D min | D | E | F | G | A | Bb | C |
| E min | E | F# | G | A | B | C | D |
| A min | A | B | C | D | E | F | G |
| G min | G | A | Bb | C | D | Eb | F |
| C min | C | D | Eb | F | G | Ab | Bb |
| B min | B | C# | D | E | F# | G | A |
| F min | F | G | Ab | Bb | C | Db | Eb |
