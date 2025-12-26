# Using Effects for Energy

Effects aren't just polish — they're compositional tools that shape energy and emotion.

## Effects and Energy Relationship

| More Effect | Energy Change |
|-------------|---------------|
| More reverb | Lower energy (floating, distant) |
| Less reverb | Higher energy (present, punchy) |
| More delay | Lower energy (spacious, hypnotic) |
| Less delay | Higher energy (tight, direct) |
| Lower cutoff | Lower energy (dark, muffled) |
| Higher cutoff | Higher energy (bright, aggressive) |

## Section-Based Effects

### Intro (Atmospheric)
```ruby
with_fx :reverb, room: 0.8, mix: 0.5 do
  with_fx :echo, phase: 1, decay: 5, mix: 0.45 do
    arp 0.5
  end
end
```
High reverb + long delay = distant, building.

### Build (Opening)
```ruby
with_fx :reverb, room: 0.65, mix: 0.4 do
  with_fx :echo, phase: 0.75, decay: 4, mix: 0.35 do
    melody 0.7
  end
end
```
Moderate effects = presence increasing.

### Main (Present)
```ruby
with_fx :reverb, room: 0.6, mix: 0.35 do
  with_fx :echo, phase: 0.5, decay: 3, mix: 0.3 do
    melody 0.8
  end
end
```
Tighter effects = full energy, present.

### Break (Floating)
```ruby
with_fx :reverb, room: 0.95, mix: 0.65 do
  with_fx :echo, phase: 1.5, decay: 8, mix: 0.55 do
    melody 0.5
  end
end
```
Maximum effects = tension, floating, yearning.

### Peak (Punchy)
```ruby
with_fx :reverb, room: 0.5, mix: 0.25 do
  with_fx :echo, phase: 0.5, decay: 2.5, mix: 0.25 do
    melody 0.95
  end
end
```
Minimal effects = maximum impact, energy.

### Outro (Fading)
```ruby
with_fx :reverb, room: 0.9, mix: 0.6 do
  with_fx :echo, phase: 1.25, decay: 10, mix: 0.55 do
    melody 0.4
  end
end
```
Long decay = notes fade into infinity.

## Effect Parameter Ranges

### Reverb Room Size
| Value | Character | Use |
|-------|-----------|-----|
| 0.4-0.5 | Tight | Peak, drops |
| 0.6-0.7 | Medium | Main sections |
| 0.8-0.9 | Large | Builds, intros |
| 0.95-1.0 | Huge | Breaks, outros |

### Echo Decay
| Value | Character | Use |
|-------|-----------|-----|
| 2-3 | Short | Tight, punchy |
| 4-5 | Medium | Standard |
| 6-8 | Long | Atmospheric |
| 10+ | Very long | Outros, fades |

### Mix (Wet/Dry)
| Value | Character | Use |
|-------|-----------|-----|
| 0.2-0.3 | Subtle | Peak energy |
| 0.35-0.45 | Balanced | Main |
| 0.5-0.6 | Prominent | Atmospheric |
| 0.65+ | Drenched | Breaks, ethereal |

## Effect Automation

### Reverb Building
```ruby
# Increasing reverb over a section
[:0.5, :0.6, :0.7, :0.8].each do |room|
  with_fx :reverb, room: room, mix: 0.4 do
    melody 0.7
  end
end
```

### Delay Increasing
```ruby
# Longer delays as section progresses
[3, 4, 5, 6].each do |decay|
  with_fx :echo, phase: 0.75, decay: decay, mix: 0.4 do
    arp 0.6
  end
end
```

## Contrast for Impact

The break's heavy effects make the drop feel more powerful:

```ruby
# BREAK: Maximum effects
with_fx :reverb, room: 0.95, mix: 0.6 do
  with_fx :echo, phase: 1.5, decay: 8, mix: 0.5 do
    melody 0.5  # Floating, distant
  end
end

hit 1.5

# DROP: Minimal effects
with_fx :reverb, room: 0.5, mix: 0.25 do
  with_fx :echo, phase: 0.5, decay: 2, mix: 0.2 do
    drums 1.15, 1.05, 0.85  # Punchy, immediate
    melody 0.95
  end
end
```

## Element-Specific Effects

### Drums (Usually Dry)
```ruby
# Little to no reverb on kicks
with_fx :reverb, room: 0.4, mix: 0.15 do
  drums 1, 0.9, 0.7
end
```

### Bass (Dry)
```ruby
# No reverb on bass (keeps it tight)
bassline 1, 80  # No effects wrapper
```

### Leads (Wet)
```ruby
# Reverb + delay on leads
with_fx :reverb, room: 0.6, mix: 0.4 do
  with_fx :echo, phase: 0.5, decay: 3, mix: 0.3 do
    melody 0.8
  end
end
```

### Arps (Very Wet)
```ruby
# Heavy effects on arps
with_fx :reverb, room: 0.75, mix: 0.5 do
  with_fx :echo, phase: 0.75, decay: 4, mix: 0.4 do
    arp 0.6
  end
end
```

## Quick Reference

```ruby
# Low energy (atmospheric)
with_fx :reverb, room: 0.9, mix: 0.6 do
  with_fx :echo, phase: 1, decay: 6, mix: 0.5 do
    # Floating, distant
  end
end

# Full energy (present)
with_fx :reverb, room: 0.6, mix: 0.35 do
  with_fx :echo, phase: 0.5, decay: 3, mix: 0.3 do
    # Present, driving
  end
end

# Maximum energy (punchy)
with_fx :reverb, room: 0.5, mix: 0.25 do
  with_fx :echo, phase: 0.5, decay: 2, mix: 0.2 do
    # Tight, impactful
  end
end

# Effects by section:
# Intro:  room 0.8, decay 5
# Build:  room 0.65, decay 4
# Main:   room 0.6, decay 3
# Break:  room 0.95, decay 8
# Peak:   room 0.5, decay 2.5
# Outro:  room 0.9, decay 10
```
