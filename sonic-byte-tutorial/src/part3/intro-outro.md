# Intro and Outro

The intro and outro frame your track. They're also essential for DJ mixing — clean intros and outros let tracks blend smoothly.

## The Intro

### Purpose
1. **Set the mood** — Establish atmosphere before full energy
2. **Introduce elements** — Bring in sounds gradually  
3. **DJ-friendly** — Provide bars for mixing in

### Standard Intro (6-8 bars)

```ruby
# INTRO: 8 bars
in_thread do
  8.times { drums 0.7, 0, 0.4 }  # Kicks + hats, no snare
end

in_thread do
  with_fx :lpf, cutoff: 50, cutoff_slide: 32 do |fx|
    control fx, cutoff: 80
    8.times { bassline 0.5, 50 }  # Filtered bass
  end
end

sleep 32
```

### Intro Elements

**What to include:**
- Kicks (usually)
- Hi-hats (often)
- Filtered bass (sometimes)
- Atmospheric textures

**What to exclude:**
- Snares (save for build/main)
- Full bass (filtered only)
- Melodies (save the hook)

### Intro Variations

**Minimal (Tracks 1, 4):**
```ruby
8.times { drums 0.7, 0, 0.4 }  # Just kicks and hats
```

**Atmospheric (Track 3):**
```ruby
in_thread do
  6.times { drums 0.6, 0, 0.5 }
end
in_thread do
  with_fx :reverb, room: 0.85, mix: 0.55 do
    2.times { arp 0.4 }
  end
end
```

**Building (Track 7):**
```ruby
in_thread do
  4.times { drums 0.5, 0, 0.3 }
  4.times { drums 0.7, 0, 0.45 }
end
in_thread do
  with_fx :lpf, cutoff: 45, cutoff_slide: 32 do |fx|
    control fx, cutoff: 75
    8.times { bassline 0.4, 45 }
  end
end
```

## The Outro

### Purpose
1. **Wind down** — Release energy gradually
2. **Provide closure** — Signal the track is ending
3. **DJ-friendly** — Provide bars for mixing out

### Standard Outro (4-8 bars)

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
      melody 0.4
    end
  end
end

sleep 24
```

### Outro Techniques

**Fade drums:**
```ruby
6.times do |i|
  drums (1-i*0.12), (0.85-i*0.1), (0.7-i*0.08)
end
```
Volume decreases each bar.

**Filter closing:**
```ruby
with_fx :lpf, cutoff: 80, cutoff_slide: 24 do |fx|
  control fx, cutoff: 45
  6.times { bassline 0.7 }
end
```

**Increase reverb:**
```ruby
with_fx :reverb, room: 0.95, mix: 0.65 do
  with_fx :echo, phase: 1.25, decay: 10, mix: 0.55 do
    arp 0.3
  end
end
```
Long decay (10) means notes ring out after playing stops.

### Outro Variations

**Quick fade (aggressive tracks):**
```ruby
4.times do |i|
  drums (0.9-i*0.2), 0, (0.6-i*0.12)
end
```

**Long fade (atmospheric tracks):**
```ruby
8.times do |i|
  drums (0.8-i*0.08), (0.7-i*0.07), (0.6-i*0.06)
end
```

**Definitive ending (Track 8):**
```ruby
# Final note, held long, fading
with_fx :reverb, room: 0.95, mix: 0.65 do
  lead :d4, 4, 0.3  # Root note, 4 beats, quiet
end
```

## Intro/Outro Duration

| Track Type | Intro | Outro |
|------------|-------|-------|
| Aggressive | 6 bars | 4 bars |
| Standard | 8 bars | 6 bars |
| Atmospheric | 8-10 bars | 8 bars |
| Finale | 8 bars | 8+ bars |

## Quick Reference

```ruby
# Standard intro (8 bars)
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

# Standard outro (6 bars)
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
