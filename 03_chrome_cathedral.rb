# TRACK 3: CHROME CATHEDRAL | 98 BPM | A Minor | ~3:30
# Atmospheric cyberpunk, cathedral reverbs, industrial machinery
use_bpm 98

# Sounds
define :kick do |v=1|
  sample :bd_tek, amp: 1.8*v, rate: 0.95
  sample :bd_haus, amp: 0.7*v, rate: 0.85
end

define :snare do |v=1|
  sample :sn_dub, amp: 0.8*v, rate: 0.9
end

define :hat do |v=1|
  sample :drum_cymbal_closed, amp: 0.2*v, rate: 2.0, release: 0.06
end

define :bass do |n, v=1, c=70|
  use_synth :prophet
  play n, amp: 0.65*v, attack: 0.05, decay: 0.3, sustain: 0.2, release: 0.3, cutoff: c
  use_synth :sine
  play n-12, amp: 0.95*v, attack: 0.02, sustain: 0.4, release: 0.25
end

define :pad do |n, v=1|
  use_synth :dark_ambience
  play n, amp: 0.4*v, attack: 1, sustain: 2, release: 2
end

define :lead do |n, dur=0.25, v=1|
  use_synth :prophet
  play n, amp: 0.3*v, attack: 0.03, decay: dur*0.5, sustain: dur*0.3, release: dur*0.5, cutoff: 85
end

define :hit do |v=1|
  sample :bd_boom, amp: 1.4*v, rate: 0.5
  sample :drum_splash_soft, amp: 0.5*v, rate: 0.8
end

# Patterns
define :drums do |k=1, s=1, h=1|
  in_thread do
    kick k; sleep 1.5; kick k*0.6; sleep 0.5
    kick k; sleep 1; kick k*0.7; sleep 1
  end
  in_thread do
    sleep 1; snare s; sleep 1; snare s; sleep 2
  end
  in_thread do
    8.times { hat h; sleep 0.5 }
  end
  sleep 4
end

define :bassline do |v=1, c=70|
  bass :a1, v, c; sleep 1.5
  bass :a1, v*0.6, c-5; sleep 0.5
  bass :e2, v*0.8, c; sleep 1
  bass :g1, v*0.7, c; sleep 1
  bass :a1, v, c; sleep 1
  bass :c2, v*0.75, c; sleep 1
  bass :e2, v*0.7, c; sleep 0.5
  bass :a1, v, c+5; sleep 1.5
end

define :hook do |v=1|
  lead :a4, 0.5, v; sleep 0.5
  lead :c5, 0.5, v*0.9; sleep 0.5
  lead :e5, 0.75, v; sleep 0.75
  lead :d5, 0.25, v*0.7; sleep 0.25
  lead :c5, 0.5, v*0.8; sleep 0.5
  lead :a4, 1, v; sleep 1.5
end

define :hook2 do |v=1|
  lead :e5, 0.5, v; sleep 0.5
  lead :d5, 0.25, v*0.8; sleep 0.25
  lead :c5, 0.25, v*0.7; sleep 0.25
  lead :b4, 0.5, v*0.9; sleep 0.5
  lead :a4, 0.75, v; sleep 2.5
end

# === ARRANGEMENT ===

# INTRO: 8 bars - cathedral ambience
with_fx :reverb, room: 0.95, mix: 0.7 do
  in_thread do
    pad [:a2, :e3, :a3], 0.5; sleep 16
    pad [:a2, :c3, :e3], 0.45
  end
end
in_thread do
  sleep 16; 4.times { drums 0.5, 0, 0.3 }
end
sleep 32

# BUILD: 8 bars
in_thread do
  8.times { drums 0.7, 0.6, 0.5 }
end
in_thread do
  4.times { bassline 0.6, 60 }
end
sleep 32
hit 0.9

# MAIN A: 14 bars
in_thread do
  14.times { drums 1, 0.9, 0.65 }
end
in_thread do
  7.times { bassline 0.9, 72 }
end
in_thread do
  with_fx :reverb, room: 0.8, mix: 0.5 do
    sleep 8
    5.times { hook 0.65; sleep 2; hook2 0.6; sleep 2 }
  end
end
sleep 56

# BREAK: 6 bars - huge space
with_fx :reverb, room: 1, mix: 0.75 do
  in_thread do
    pad [:a2, :c3, :e3, :a3], 0.5
  end
  in_thread do
    12.times { hat 0.25; sleep 0.5 }
  end
  in_thread do
    sleep 4; hook 0.5; sleep 8; hook2 0.45
  end
end
sleep 24
hit 1.2

# MAIN B: 12 bars - peak
in_thread do
  12.times { drums 1.1, 1, 0.75 }
end
in_thread do
  6.times { bassline 1, 78 }
end
in_thread do
  with_fx :reverb, room: 0.75, mix: 0.4 do
    6.times { hook 0.8; sleep 2; hook2 0.7; sleep 2 }
  end
end
sleep 48

# OUTRO: 6 bars - fade
in_thread do
  6.times do |i|
    drums (0.8-i*0.12), (0.6-i*0.1), (0.5-i*0.08)
  end
end
in_thread do
  with_fx :reverb, room: 1, mix: 0.8 do
    pad [:a2, :e3, :a3], 0.35
  end
end
sleep 24