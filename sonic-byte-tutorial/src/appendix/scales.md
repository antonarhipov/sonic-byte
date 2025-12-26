# Scale Reference

All tracks in *Sonic Byte* use minor keys for their dark character.

## Natural Minor Scales

### D Minor (Tracks 1 & 8)
```
D  E  F  G  A  Bb C  D
1  2  b3 4  5  b6 b7 1
```
**Common bass notes:** D2, F2, G2, A2, Bb1  
**Common melody notes:** D4, F4, G4, A4, C5, D5

### E Minor (Track 2)
```
E  F# G  A  B  C  D  E
1  2  b3 4  5  b6 b7 1
```
**Common bass notes:** E2, G2, A2, B2  
**Common melody notes:** E4, G4, A4, B4, D5

### A Minor (Track 3)
```
A  B  C  D  E  F  G  A
1  2  b3 4  5  b6 b7 1
```
**Common bass notes:** A1, C2, D2, E2, G2  
**Common melody notes:** A4, C5, D5, E5, G5

### F Minor (Track 4)
```
F  G  Ab Bb C  Db Eb F
1  2  b3 4  5  b6 b7 1
```
**Common bass notes:** F2, Ab2, Bb2, C2  
**Common melody notes:** F4, Ab4, Bb4, C5, Eb5

### C Minor (Track 5)
```
C  D  Eb F  G  Ab Bb C
1  2  b3 4  5  b6 b7 1
```
**Common bass notes:** C2, Eb2, F2, G2, Bb2  
**Common melody notes:** C4, Eb4, F4, G4, Bb4, C5

### B Minor (Track 6)
```
B  C# D  E  F# G  A  B
1  2  b3 4  5  b6 b7 1
```
**Common bass notes:** B1, D2, E2, F#2  
**Common melody notes:** B4, D5, E5, F#5

### G Minor (Track 7)
```
G  A  Bb C  D  Eb F  G
1  2  b3 4  5  b6 b7 1
```
**Common bass notes:** G2, Bb2, C2, D2, F2  
**Common melody notes:** G4, Bb4, C5, D5, F5

## Sonic Pi Note Names

```ruby
# Octave notation
:c2   # C in octave 2 (bass range)
:d3   # D in octave 3 (low mid)
:a4   # A in octave 4 (middle)
:e5   # E in octave 5 (high)

# Sharps and flats
:fs4  # F sharp
:bf3  # B flat (also :bb3)
:cs2  # C sharp
:ef4  # E flat (also :eb4)
```

## Common Intervals

| Interval | Semitones | Character | Example from D |
|----------|-----------|-----------|----------------|
| Minor 2nd | 1 | Tense, dissonant | D → Eb |
| Major 2nd | 2 | Neutral | D → E |
| Minor 3rd | 3 | Dark, sad | D → F |
| Major 3rd | 4 | Bright, happy | D → F# |
| Perfect 4th | 5 | Strong, open | D → G |
| Tritone | 6 | Very tense | D → Ab |
| Perfect 5th | 7 | Powerful, stable | D → A |
| Minor 6th | 8 | Dark | D → Bb |
| Major 6th | 9 | Warm | D → B |
| Minor 7th | 10 | Bluesy, dark | D → C |
| Major 7th | 11 | Bright tension | D → C# |
| Octave | 12 | Same note, higher | D → D |

## Dark vs Bright Intervals

**Darkest (use for tension):**
- Minor 2nd (1 semitone)
- Tritone (6 semitones)
- Minor 6th (8 semitones)

**Dark but stable (main vocabulary):**
- Minor 3rd (3 semitones)
- Perfect 4th (5 semitones)
- Perfect 5th (7 semitones)
- Minor 7th (10 semitones)

**Avoid in dark music:**
- Major 3rd (sounds happy)
- Major 6th (sounds warm)
- Major 7th (sounds jazzy)

## Chord Construction

### Minor Triad
```ruby
# D minor chord: D F A
play [:d4, :f4, :a4]
# or
play chord(:d4, :minor)
```

### Minor 7th
```ruby
# D minor 7: D F A C
play chord(:d4, :m7)
```

### Power Chord (5th)
```ruby
# D5: D A (no third - neither major nor minor)
play [:d3, :a3]
```

## Bass Note Relationships

When writing bass:

**Safe jumps:**
- Root to 5th: Strong, powerful
- Root to 4th: Moving, transitional
- Root to minor 3rd: Dark color

**Avoid:**
- Root to major 3rd: Sounds too happy
- Large jumps without purpose

```ruby
# Good bass movement in D minor
bass :d2; sleep 1
bass :a2; sleep 0.5   # Fifth - strong
bass :g2; sleep 0.5   # Fourth - movement
bass :f2; sleep 1     # Minor third - dark
bass :d2; sleep 1     # Return to root
```

## Melody Tips by Key

### D Minor
- Emphasize: D, F, A (minor triad)
- Use Bb for darkness
- Resolve to D

### G Minor  
- Emphasize: G, Bb, D
- Use Eb for extra darkness
- The Bb-A-G resolution is powerful

### E Minor
- Emphasize: E, G, B
- The F#-G movement is classic
- Resolve descending to E
