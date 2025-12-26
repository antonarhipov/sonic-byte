# TRACK 1: SYSTEM OVERRIDE | 100 BPM | D Minor | ~2:30
# Album: Sonic Byte
use_bpm 100

# Core sounds
define :kick do |v=1|
  sample :bd_tek, amp: 2*v, rate: 0.9
  sample :bd_boom, amp: 0.5*v, rate: 1.2, cutoff: 70
end

define :snare do |v=1|
  sample :sn_dub, amp: v, rate: 0.85
end

define :hat do |v=1|
  sample :drum_cymbal_closed, amp: 0.3*v, rate: 2.2, release: 0.05
end

define :bass do |n, v=1, c=80|
  use_synth :dsaw
  play n, amp: 0.6*v, attack: 0.01, decay: 0.15, sustain: 0.1, release: 0.15, cutoff: c
  use_synth :sine
  play n-12, amp: v, attack: 0.02, sustain: 0.3, release: 0.2
end

define :lead do |n, dur=0.25, v=1|
  use_synth :prophet
  play n, amp: 0.4*v, attack: 0.02, decay: dur*0.5, sustain: dur*0.3, release: dur*0.4, cutoff: 95
  use_synth :dark_ambience
  play n, amp: 0.15*v, attack: 0.05, release: dur*0.8
end

define :hit do |v=1|
  sample :bd_boom, amp: 1.5*v, rate: 0.5
  sample :drum_splash_soft, amp: 0.6*v, rate: 0.7
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

define :bassline do |v=1, c=80|
  bass :d2, v, c; sleep 0.75
  bass :d2, v*0.7, c-10; sleep 0.75
  bass :f2, v*0.9, c; sleep 0.5
  bass :d2, v*0.8, c; sleep 0.5
  bass :a2, v, c+5; sleep 0.5
  bass :d2, v, c; sleep 1
end

# More melodic hook - D minor arpeggios + expressive phrase
define :hook do |v=1|
  # Rising phrase
  lead :d4, 0.25, v; sleep 0.25
  lead :f4, 0.25, v*0.9; sleep 0.25
  lead :a4, 0.5, v; sleep 0.5
  # Held note with fall
  lead :g4, 0.75, v*0.85; sleep 0.75
  lead :f4, 0.25, v*0.7; sleep 0.25
  # Resolution phrase
  lead :e4, 0.5, v*0.9; sleep 0.5
  lead :d4, 0.75, v; sleep 0.5
end

# Counter melody for variation
define :hook2 do |v=1|
  lead :a4, 0.5, v; sleep 0.5
  lead :g4, 0.25, v*0.8; sleep 0.25
  lead :f4, 0.25, v*0.7; sleep 0.25
  lead :e4, 0.5, v*0.9; sleep 0.5
  lead :d4, 0.25, v; sleep 0.25
  lead :c4, 0.25, v*0.6; sleep 0.25
  lead :d4, 1, v; sleep 1
end

# === ARRANGEMENT ===

# INTRO: 8 bars - drums build
in_thread do
  8.times { drums 0.8, 0, 0 }
end
in_thread do
  sleep 16
  4.times { drums 0, 0, 0.5 }
end
sleep 32

# BUILD: 8 bars - add snares, bass enters
in_thread do
  8.times { drums 0.9, 0.7, 0.6 }
end
in_thread do
  8.times { bassline 0.7, 65 }
end
sleep 32
hit 1

# MAIN A: 12 bars - full groove + hook
in_thread do
  12.times { drums 1, 0.9, 0.75 }
end
in_thread do
  12.times { bassline 1, 85 }
end
in_thread do
  sleep 8
  4.times { hook 0.7; sleep 1; hook2 0.6; sleep 1 }
end
sleep 48

# BREAK: 4 bars - tension
with_fx :reverb, room: 0.85 do
  with_fx :hpf, cutoff: 80 do
    in_thread do
      16.times { hat 0.4; sleep 0.5 }
    end
    in_thread do
      hook 0.6; sleep 1
      hook2 0.5; sleep 1
    end
  end
end
sleep 16
hit 1.2

# MAIN B: 12 bars - peak energy
in_thread do
  12.times { drums 1.1, 1, 0.85 }
end
in_thread do
  12.times { bassline 1.1, 90 }
end
in_thread do
  6.times { hook 0.85; sleep 1; hook2 0.75; sleep 1 }
end
sleep 48

# OUTRO: 4 bars - fade
in_thread do
  4.times do |i|
    drums (0.9-i*0.2), (0.7-i*0.15), (0.6-i*0.12)
  end
end
sleep 16