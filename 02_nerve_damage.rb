# TRACK 2: NERVE DAMAGE | 105 BPM | E Minor | ~3:30
# Crushing industrial metal aggression
use_bpm 105

# Sounds
define :kick do |v=1|
  sample :bd_tek, amp: 2.2*v, rate: 0.85
  sample :bd_zum, amp: 1.1*v, rate: 0.7, cutoff: 60
end

define :snare do |v=1|
  sample :sn_dub, amp: 0.9*v, rate: 0.8
  sample :drum_snare_hard, amp: 0.5*v, rate: 0.9
end

define :hat do |v=1|
  sample :drum_cymbal_closed, amp: 0.25*v, rate: 2.4, release: 0.04
end

define :grind do |n, v=1, c=75|
  use_synth :tb303
  play n, amp: 0.8*v, attack: 0.01, decay: 0.2, sustain: 0.1, release: 0.15, cutoff: c, res: 0.3, wave: 0
  use_synth :sine
  play n-12, amp: 1.1*v, attack: 0.01, sustain: 0.25, release: 0.15
end

define :lead do |n, dur=0.25, v=1|
  use_synth :prophet
  play n, amp: 0.35*v, attack: 0.02, decay: dur*0.4, sustain: dur*0.3, release: dur*0.4, cutoff: 90
end

define :hit do |v=1|
  sample :bd_boom, amp: 1.8*v, rate: 0.45
  sample :drum_splash_hard, amp: 0.6*v, rate: 0.6
end

# Patterns
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

define :drums_x do |k=1, s=1, h=1|
  in_thread do
    kick k; sleep 0.75; kick k*0.7; sleep 0.25
    kick k; sleep 0.5; kick k*0.8; sleep 0.5
    kick k; sleep 0.75; kick k*0.7; sleep 0.25
    kick k; sleep 1
  end
  in_thread do
    sleep 1; snare s; sleep 1; snare s; sleep 2
  end
  in_thread do
    8.times { hat h; sleep 0.5 }
  end
  sleep 4
end

define :bass do |v=1, c=75|
  grind :e2, v, c; sleep 0.5
  grind :e2, v*0.8, c-5; sleep 0.25
  grind :e2, v*0.7, c-10; sleep 0.25
  grind :g2, v*0.9, c; sleep 0.5
  grind :e2, v, c; sleep 0.5
  grind :d2, v*0.85, c; sleep 0.5
  grind :e2, v, c+5; sleep 0.5
  grind :b1, v, c; sleep 1
end

define :hook do |v=1|
  lead :e4, 0.25, v; sleep 0.25
  lead :g4, 0.25, v*0.9; sleep 0.25
  lead :b4, 0.5, v; sleep 0.5
  lead :a4, 0.5, v*0.85; sleep 0.5
  lead :g4, 0.25, v*0.8; sleep 0.25
  lead :e4, 0.75, v; sleep 1.25
end

define :hook2 do |v=1|
  lead :b4, 0.5, v; sleep 0.5
  lead :a4, 0.25, v*0.9; sleep 0.25
  lead :g4, 0.25, v*0.8; sleep 0.25
  lead :e4, 0.5, v; sleep 0.5
  lead :d4, 0.25, v*0.7; sleep 0.25
  lead :e4, 0.75, v*0.9; sleep 1.25
end

# === ARRANGEMENT ===

# INTRO: 8 bars - menacing
in_thread do
  4.times { bass 0.5, 55 }
end
in_thread do
  sleep 16; 4.times { drums 0.7, 0, 0.4 }
end
sleep 32

# BUILD: 8 bars
in_thread do
  8.times { drums 0.85, 0.7, 0.6 }
end
in_thread do
  8.times { bass 0.75, 65 }
end
sleep 32
hit 1

# MAIN A: 16 bars - full assault
in_thread do
  16.times { drums_x 1, 0.95, 0.75 }
end
in_thread do
  16.times { bass 1, 80 }
end
in_thread do
  sleep 16
  6.times { hook 0.7; sleep 1; hook2 0.65; sleep 1 }
end
sleep 64

# BREAK: 6 bars
with_fx :reverb, room: 0.85 do
  with_fx :hpf, cutoff: 80 do
    in_thread do
      24.times { hat 0.35; sleep 0.5 }
    end
    in_thread do
      3.times { hook 0.5; sleep 4 }
    end
  end
end
sleep 24
hit 1.3

# MAIN B: 14 bars - maximum destruction
in_thread do
  14.times { drums_x 1.15, 1, 0.85 }
end
in_thread do
  14.times { bass 1.1, 85 }
end
in_thread do
  7.times { hook 0.85; sleep 1; hook2 0.75; sleep 1 }
end
sleep 56

# OUTRO: 6 bars - fade
in_thread do
  6.times do |i|
    drums (1-i*0.12), (0.8-i*0.1), (0.6-i*0.08)
  end
end
in_thread do
  3.times do |i|
    bass (0.8-i*0.2), (70-i*8)
  end
end
sleep 24