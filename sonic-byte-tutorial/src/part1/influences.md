# Our Influences

Every piece of music builds on what came before. Here are the artists who shaped the sound of *Synthetic Apocalypse*, and what we learned from each.

## Irving Force

**Style**: Darksynth, cyberpunk, film score-influenced

**Key Tracks**: "The Violence Suppressor", "Send Me Your Dreams", "Night Hunter"

**What We Learned**:

- **Narrative structure** — Irving Force's tracks feel like movie scenes. There's a beginning, middle, and end, not just a loop.
- **Metal influences** — Despite being electronic, his music has the intensity of metal. Don't be afraid to push aggression.
- **Layered leads** — Multiple synth layers create rich, evolving melodies without complex chord progressions.

**Applied In**: Track 1 (System Override), Track 4 (Skull Fracture)

```ruby
# Irving Force-inspired aggressive lead
define :lead do |n, v=1|
  use_synth :prophet
  play n, amp: 0.4*v, attack: 0.02, decay: 0.2, 
       sustain: 0.1, release: 0.3, cutoff: 95
  use_synth :dark_ambience
  play n, amp: 0.15*v, attack: 0.05, release: 0.5
end
```

## Noisecream

**Style**: Aggressive electronic, game soundtracks, industrial

**Key Tracks**: "Dominance", "The Dooms Party", "Power Up"

**What We Learned**:

- **Intensity without chaos** — Noisecream tracks are brutal but controlled. Every element has purpose.
- **Hook sounds** — The hook isn't always a melody; often it's a distinctive bass sound or rhythmic pattern.
- **Dynamic range** — Quiet moments make loud moments louder. Don't be afraid of space.

**Applied In**: Track 2 (Nerve Damage), Track 7 (Core Meltdown), Track 8 (Terminal Velocity)

```ruby
# Noisecream-inspired grinding bass
define :grind do |n, v=1, c=80|
  use_synth :tb303
  play n, amp: 0.8*v, attack: 0.01, decay: 0.2,
       cutoff: c, res: 0.35, wave: 0
  use_synth :sine
  play n-12, amp: 1.1*v, sustain: 0.25, release: 0.15
end
```

## Gesaffelstein

**Style**: Dark clubbing, industrial techno, minimal

**Key Tracks**: "Pursuit", "Hate or Glory", "Viol"

**What We Learned**:

- **Less is more** — Gesaffelstein tracks often use very few elements, but each one is perfectly crafted.
- **The power of silence** — Strategic silence creates impact when sound returns.
- **Bass as foundation** — The bass isn't just low end; it's the primary melodic element.

**Applied In**: Track 3 (Chrome Cathedral), Track 6 (Void Walker)

```ruby
# Gesaffelstein-inspired minimal pattern
# Notice the space — not every beat has a sound
define :minimal_bass do |v=1|
  bass :d2, v; sleep 1.5
  sleep 0.5
  bass :d2, v*0.6; sleep 0.5
  sleep 1.5
end
```

## 1788-L

**Style**: Midtempo bass, cyberpunk, heavy

**Key Tracks**: "Pulsar", "S Y N T H E T I K", "Replica"

**What We Learned**:

- **Sound design over songwriting** — The sounds themselves are the composition.
- **Slow builds** — Tension can build over 32+ bars before release.
- **Sub bass presence** — The physical weight of sub frequencies is essential.

**Applied In**: Track 4 (Skull Fracture), Track 6 (Void Walker)

## REZZ

**Style**: Hypnotic bass, dark electronic, minimal

**Key Tracks**: "Edge", "Relax", "Witching Hour"

**What We Learned**:

- **Hypnotic repetition** — The same phrase repeated with subtle variations creates trance-like states.
- **Tension without release** — Not every build needs a massive drop.
- **Signature sounds** — Develop sounds that are instantly recognizable as "yours".

**Applied In**: Track 3 (Chrome Cathedral), Track 5 (Midnight Protocol)

## Carpenter Brut

**Style**: Synthwave, darksynth, metal-influenced

**Key Tracks**: "Turbo Killer", "Roller Mobster", "Le Perv"

**What We Learned**:

- **Triumphant melodies** — Even dark music can have uplifting moments.
- **Genre fusion** — Blend influences freely. Rules are guidelines.
- **Energy arcs** — Albums should take listeners on a journey.

**Applied In**: Track 5 (Midnight Protocol), Track 8 (Terminal Velocity)

```ruby
# Carpenter Brut-inspired triumphant arp
define :arp1 do |v=1|
  use_synth :pulse
  [:d4,:f4,:a4,:d5,:a4,:f4,:d4,:a3].each do |n|
    play n, amp: 0.25*v, attack: 0.01, decay: 0.1,
         release: 0.1, cutoff: 105
    sleep 0.5
  end
end
```

## Synthesis: Our Sound

By studying these artists, we developed principles for *Synthetic Apocalypse*:

| Principle | Source |
|-----------|--------|
| Narrative structure | Irving Force |
| Controlled aggression | Noisecream |
| Strategic silence | Gesaffelstein |
| Sound design focus | 1788-L |
| Hypnotic repetition | REZZ |
| Triumphant moments | Carpenter Brut |

The goal isn't to copy any single artist, but to synthesize their lessons into something new.

---

Next, let's see how these influences shaped the album's overall concept.
