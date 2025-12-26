# TRACK 4: SKULL FRACTURE | 108 BPM | F Minor | ~3:30
# Maximum aggression - built for destruction
use_bpm 108

# Sounds
define :kick do |v=1|
  sample :bd_tek, amp: 2.5*v, rate: 0.88
  sample :bd_zum, amp: 1.2*v, rate: 0.65, cutoff: 55
end

define :snare do |v=1|
  sample :sn_dub, amp: 1.1*v, rate: 0.75
  sample :drum_snare_hard, amp: 0.6*v, rate: 0.85
end

define :hat do |v=1|
  sample :drum_cymbal_closed, amp: 0.28*v, rate: 2.5, release: 0.03
end

define :bass do |n, v=1, c=80|
  use_synth :tb303
  play n, amp: 0.9*v, attack: 0, decay: 0.15, sustain: 0.1, release: 0.1, cutoff: c, res: 0.35, wave: 0
  use_synth :sine
  play n-12, amp: 1.2*v, attack: 0.01, sustain: 0.2, release: 0.15
end

# THE HOOK SOUND - distorted alarm/siren stab
define :skull do |v=1|
  use_synth :dsaw
  play :f4, amp: 0.5*v, attack: 0, decay: 0.1, sustain: 0.05, release: 0.1, cutoff: 115, detune: 0.4
  play :c5, amp: 0.35*v, attack: 0, decay: 0.08, sustain: 0.03, release: 0.08, cutoff: 120, detune: 0.3
  sample :elec_blip, amp: 0.4*v, rate: 0.7, finish: 0.3
end

define :lead do |n, dur=0.5, v=1|
  use_synth :prophet
  play n, amp: 0.3*v, attack: 0.08, decay: dur*0.3, sustain: dur*0.5, release: dur*0.6, cutoff: 82
end

define :hit do |v=1|
  sample :bd_boom, amp: 2*v, rate: 0.4
  sample :drum_splash_hard, amp: 0.7*v, rate: 0.55
end

define :riser do |v=1|
  use_synth :noise
  play :f2, amp: 0.3*v, attack: 3.5, release: 0.5, cutoff: 60, cutoff_slide: 4
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
    kick k; sleep 0.5; kick k*0.6; sleep 0.5
    kick k; sleep 0.5; kick k*0.7; sleep 0.5
    kick k; sleep 0.5; kick k*0.6; sleep 0.5
    kick k; sleep 0.75; kick k*0.8; sleep 0.25
  end
  in_thread do
    sleep 1; snare s; sleep 1; snare s; sleep 2
  end
  in_thread do
    16.times { hat h; sleep 0.25 }
  end
  sleep 4
end

# Basslines
define :bass1 do |v=1, c=80|
  bass :f2, v, c; sleep 0.25
  bass :f2, v*0.7, c-5; sleep 0.25
  bass :f2, v*0.8, c; sleep 0.5
  bass :ab2, v*0.9, c; sleep 0.5
  bass :f2, v, c; sleep 0.5
  bass :c2, v, c; sleep 0.5
  bass :f2, v, c; sleep 1.5
end

define :bass2 do |v=1, c=80|
  bass :f2, v, c; sleep 0.5
  bass :eb2, v*0.85, c; sleep 0.5
  bass :f2, v*0.9, c; sleep 0.25
  bass :ab2, v, c+5; sleep 0.75
  bass :bb2, v*0.8, c; sleep 0.5
  bass :ab2, v*0.7, c; sleep 0.25
  bass :f2, v, c; sleep 1.25
end

define :bass3 do |v=1, c=80|
  bass :f2, v, c; sleep 0.25
  bass :f2, v*0.6, c-5; sleep 0.25
  bass :ab2, v*0.9, c; sleep 0.5
  bass :c3, v, c+5; sleep 0.5
  bass :bb2, v*0.8, c; sleep 0.5
  bass :ab2, v*0.7, c; sleep 0.5
  bass :f2, v, c; sleep 1.5
end

# Skull stab pattern - THE HOOK
define :skull_riff do |v=1|
  skull v; sleep 0.5
  sleep 0.5
  skull v*0.7; sleep 0.25
  skull v*0.8; sleep 0.75
  sleep 0.5
  skull v; sleep 0.5
  sleep 1
end

define :melody do |v=1|
  lead :f4, 0.75, v; sleep 0.75
  lead :ab4, 0.75, v*0.9; sleep 0.75
  lead :c5, 1.5, v; sleep 2.5
end

# === DYNAMIC ARRANGEMENT ===

# INTRO: 6 bars - bass + skull teaser
in_thread do
  3.times { bass1 0.5, 55 }
end
in_thread do
  sleep 8; skull 0.4; sleep 3.5; skull 0.5
end
sleep 24

# Drums enter: 4 bars
in_thread do
  4.times { drums 0.8, 0.5, 0.5 }
end
in_thread do
  2.times { bass2 0.6, 60 }
end
sleep 16
hit 1

# MAIN A: 12 bars - full energy + skull hook
in_thread do
  12.times { drums_x 1.1, 1, 0.8 }
end
in_thread do
  3.times { bass1 1, 82; bass2 1, 82; bass3 1, 85; bass1 1, 85 }
end
in_thread do
  6.times { skull_riff 0.85 }
end
sleep 48

# FAKE DROP: 2 bars silence + skull only
skull 0.9
sleep 1
skull 0.7
sleep 1
skull 0.8
sleep 0.5
skull 0.6
sleep 0.5
4.times { skull 1; sleep 0.25 }
sleep 3
hit 1.5

# MAIN B: 10 bars - SLAM back harder
in_thread do
  10.times { drums_x 1.25, 1.1, 0.9 }
end
in_thread do
  2.times { bass1 1.15, 88; bass3 1.15, 90; bass2 1.15, 88; bass3 1.15, 92; bass1 1.15, 90 }
end
in_thread do
  5.times { skull_riff 1 }
end
in_thread do
  sleep 16
  with_fx :reverb, room: 0.5, mix: 0.35 do
    2.times { melody 0.7; sleep 1 }
  end
end
sleep 40

# BREAKDOWN: 4 bars - half-time feel
in_thread do
  4.times do
    kick 0.9; sleep 2
    snare 0.8; sleep 2
  end
end
in_thread do
  with_fx :reverb, room: 0.8, mix: 0.5 do
    melody 0.6; sleep 4; melody 0.55
  end
end
sleep 16
riser 0.8
sleep 4
hit 1.8

# FINAL DROP: 8 bars - maximum carnage
in_thread do
  8.times { drums_x 1.3, 1.15, 0.95 }
end
in_thread do
  4.times { bass1 1.2, 92; bass3 1.2, 95 }
end
in_thread do
  4.times { skull_riff 1.1 }
end
sleep 32

# OUTRO: 4 bars
in_thread do
  4.times { |i| drums (1.1-i*0.2), (0.9-i*0.18), (0.7-i*0.15) }
end
in_thread do
  skull 0.7; sleep 2; skull 0.5; sleep 2; skull 0.3
end
sleep 16