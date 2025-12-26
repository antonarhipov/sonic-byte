# Kick Drums That Hit Hard

The kick drum is the foundation of dark electronic music. It provides the pulse that drives everything forward.

## The Basic Kick

Every track in *Sonic Byte* uses a layered kick:

```ruby
define :kick do |v=1|
  sample :bd_tek, amp: 2.2*v, rate: 0.9
  sample :bd_boom, amp: 0.5*v, rate: 1.2, cutoff: 70
end
```

### Why Two Layers?

- **:bd_tek** — Provides the punchy attack (the "click")
- **:bd_boom** — Adds low-end weight (the "boom")

Together, they create a kick that has both presence and physical impact.

## Key Parameters

### amp (Amplitude)

Controls volume. For kicks, we use higher values:

```ruby
sample :bd_tek, amp: 2.2   # Loud, punchy
sample :bd_boom, amp: 0.5  # Supporting, not dominant
```

### rate (Playback Speed/Pitch)

Lower rate = lower pitch = more weight:

```ruby
sample :bd_tek, rate: 1.0  # Original pitch
sample :bd_tek, rate: 0.9  # Lower, heavier
sample :bd_tek, rate: 0.85 # Even lower (Void Walker)
```

### cutoff (Filter)

Removes high frequencies for a cleaner low end:

```ruby
sample :bd_boom, cutoff: 70  # Keeps only the sub
```

## Kick Variations by Track

### Standard (Tracks 1, 5, 8)
```ruby
define :kick do |v=1|
  sample :bd_tek, amp: 2.2*v, rate: 0.9
  sample :bd_boom, amp: 0.5*v, rate: 1.2, cutoff: 70
end
```

### Heavy (Tracks 2, 4)
```ruby
define :kick do |v=1|
  sample :bd_tek, amp: 2.5*v, rate: 0.85
  sample :bd_zum, amp: 0.7*v, rate: 1.1
end
```
Uses `:bd_zum` for more attack, lower rate for more weight.

### Deep (Track 6 - Void Walker)
```ruby
define :kick do |v=1|
  sample :bd_tek, amp: 2.4*v, rate: 0.85
  sample :bd_zum, amp: 0.6*v, rate: 1.0, cutoff: 65
end
```
Lowest rate (0.85) for the slowest, heaviest track.

## Sample Selection

Sonic Pi includes many kick samples. For dark electronic:

### Punchy/Attack Samples
- `:bd_tek` — Tight, techno-style (our main choice)
- `:bd_haus` — Punchy house kick
- `:bd_klub` — Club-ready punch

### Weight/Body Samples
- `:bd_boom` — Deep, boomy (good for layering)
- `:bd_zum` — Punchy with sub weight
- `:bd_fat` — Wide, heavy

### Testing Combinations
```ruby
# Try different combinations
sample :bd_tek, amp: 2; sample :bd_boom, amp: 0.5
sleep 1
sample :bd_tek, amp: 2; sample :bd_zum, amp: 0.5
sleep 1
sample :bd_haus, amp: 2; sample :bd_fat, amp: 0.5
```

## The Volume Parameter

Using a volume parameter allows dynamic control:

```ruby
define :kick do |v=1|
  sample :bd_tek, amp: 2.2*v
  sample :bd_boom, amp: 0.5*v
end

kick 1      # Full volume
kick 0.7    # 70% volume (intro)
kick 1.2    # 120% volume (peak)
```

## Kick Timing Patterns

### Four-on-the-Floor
```ruby
4.times { kick; sleep 1 }
```
Kick on every beat. Classic, driving.

### Syncopated
```ruby
kick; sleep 0.75
kick; sleep 0.25
kick; sleep 1
kick; sleep 1
kick; sleep 1
```
Ghost kick at 0.75 creates groove.

### Double-Time
```ruby
8.times { kick; sleep 0.5 }
```
Kick every half beat. Aggressive, relentless.

### Half-Time
```ruby
kick; sleep 2
kick; sleep 0.5
kick; sleep 1.5
```
Sparse, heavy. Each kick has more impact.

## Velocity Variation

Static velocity sounds robotic. Add variation:

```ruby
in_thread do
  kick 1; sleep 1        # Beat 1: Full
  kick 0.8; sleep 1      # Beat 2: Slightly softer
  kick 0.9; sleep 1      # Beat 3: Almost full
  kick 0.85; sleep 1     # Beat 4: Medium
end
```

## Quick Reference

```ruby
# Basic layered kick
define :kick do |v=1|
  sample :bd_tek, amp: 2.2*v, rate: 0.9
  sample :bd_boom, amp: 0.5*v, rate: 1.2, cutoff: 70
end

# Heavier kick
define :kick do |v=1|
  sample :bd_tek, amp: 2.5*v, rate: 0.85
  sample :bd_zum, amp: 0.7*v, rate: 1.1
end

# Rate guide:
# 1.0 = original pitch
# 0.9 = slightly lower (standard)
# 0.85 = noticeably lower (heavy)
```
