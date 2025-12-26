# TRACK 8: TERMINAL VELOCITY | 100 BPM | D Minor | ~3:30
# Cinematic dark finale - Noisecream-style intense but moody
use_bpm 100

define :kick do |v=1|
  sample :bd_tek, amp: 2.3*v, rate: 0.86
  sample :bd_zum, amp: 1.1*v, rate: 0.6, cutoff: 55
end
define :snare do |v=1|
  sample :sn_dub, amp: 1.05*v, rate: 0.8
  sample :drum_snare_hard, amp: 0.5*v, rate: 0.85
end
define :hat do |v=1|
  sample :drum_cymbal_closed, amp: 0.24*v, rate: 2.2, release: 0.05
end

define :bass do |n, v=1, c=75|
  use_synth :tb303
  play n, amp: 0.75*v, attack: 0.02, decay: 0.22, sustain: 0.12, release: 0.18, cutoff: c, res: 0.3, wave: 0
  use_synth :sine
  play n-12, amp: 1.15*v, attack: 0.01, sustain: 0.28, release: 0.2
end

# Dark intense lead - aggressive but melodic
define :lead do |n, dur=0.5, v=1|
  use_synth :prophet
  play n, amp: 0.45*v, attack: 0.03, decay: dur*0.25, sustain: dur*0.45, release: dur*0.5, cutoff: 92
end

# Power stab for accents
define :stab do |notes, v=1|
  use_synth :dsaw
  play notes, amp: 0.5*v, attack: 0, decay: 0.12, sustain: 0.04, release: 0.1, cutoff: 98, detune: 0.2
end

define :arp do |n, v=1|
  use_synth :pulse
  play n, amp: 0.23*v, attack: 0.01, decay: 0.1, sustain: 0.04, release: 0.1, cutoff: 100, pulse_width: 0.3
end

define :hit do |v=1|
  sample :bd_boom, amp: 2*v, rate: 0.4
  sample :drum_splash_hard, amp: 0.65*v, rate: 0.6
end

define :drums do |k=1, s=1, h=1|
  in_thread do
    kick k; sleep 0.75; kick k*0.5; sleep 0.25
    kick k*0.85; sleep 1; kick k; sleep 0.75; kick k*0.6; sleep 0.25
    kick k*0.9; sleep 1
  end
  in_thread do
    sleep 1; snare s; sleep 1; snare s; sleep 2
  end
  in_thread do
    8.times { hat h; sleep 0.5 }
  end
  sleep 4
end

define :bass1 do |v=1, c=75|
  bass :d2,v,c; sleep 0.5; bass :d2,v*0.6,c-5; sleep 0.5
  bass :f2,v*0.85,c; sleep 0.5; bass :d2,v*0.9,c; sleep 0.5
  bass :a1,v*0.75,c; sleep 0.5; bass :bb1,v*0.8,c; sleep 0.5
  bass :d2,v,c+5; sleep 1
end
define :bass2 do |v=1, c=75|
  bass :d2,v,c; sleep 0.5; bass :e2,v*0.8,c; sleep 0.5
  bass :f2,v*0.9,c; sleep 0.5; bass :g2,v,c+5; sleep 0.5
  bass :a2,v*0.85,c; sleep 0.5; bass :g2,v*0.7,c; sleep 0.5
  bass :f2,v*0.8,c; sleep 0.5; bass :d2,v,c; sleep 0.5
end

define :arp1 do |v=1|
  [:d4,:f4,:a4,:d5,:a4,:f4,:d4,:a3].each{|n| arp n,v; sleep 0.5}
end
define :arp2 do |v=1|
  [:bb3,:d4,:f4,:bb4,:f4,:d4,:bb3,:f3].each{|n| arp n,v; sleep 0.5}
end

# DARK INTENSE melodies - driving, powerful, minor key
define :mel1 do |v=1|
  lead :d4,0.5,v; sleep 0.5
  lead :f4,0.5,v*0.95; sleep 0.5
  lead :a4,0.5,v; sleep 0.5
  lead :g4,0.5,v*0.9; sleep 0.5
  lead :f4,0.5,v*0.85; sleep 0.5
  lead :d4,0.5,v; sleep 0.5
  sleep 0.5
  lead :e4,0.5,v*0.9; sleep 0.5
end

define :mel2 do |v=1|
  lead :a4,0.5,v; sleep 0.5
  lead :bb4,0.5,v; sleep 0.5
  lead :a4,0.5,v*0.95; sleep 0.5
  lead :g4,0.5,v*0.9; sleep 0.5
  lead :f4,0.5,v*0.85; sleep 0.5
  lead :e4,0.5,v*0.9; sleep 0.5
  lead :d4,1,v; sleep 1
end

define :mel3 do |v=1|
  lead :d5,0.5,v; sleep 0.5
  lead :c5,0.5,v*0.95; sleep 0.5
  lead :bb4,0.5,v; sleep 0.5
  lead :a4,0.5,v*0.9; sleep 0.5
  lead :g4,0.5,v*0.85; sleep 0.5
  lead :a4,0.5,v*0.9; sleep 0.5
  lead :d4,1,v; sleep 1
end

define :stab_pat do |v=1|
  stab [:d3,:a3,:d4],v; sleep 1.5
  stab [:d3,:a3,:d4],v*0.5; sleep 0.5
  stab [:bb2,:f3,:bb3],v*0.8; sleep 1
  stab [:d3,:a3,:d4],v; sleep 1
end

# === ARRANGEMENT ===

# INTRO: 8 bars - dark atmosphere
in_thread do
  8.times { drums 0.65, 0, 0.4 }
end
in_thread do
  with_fx :lpf, cutoff: 50, cutoff_slide: 32 do |f|
    control f, cutoff: 82
    8.times { bass1 0.55, 55 }
  end
end
in_thread do
  with_fx :reverb, room: 0.8, mix: 0.5 do
    with_fx :echo, phase: 0.75, decay: 5, mix: 0.4 do
      sleep 16; 2.times { arp1 0.4; arp2 0.35 }
    end
  end
end
sleep 32

# BUILD: 8 bars
in_thread do
  8.times { drums 0.85, 0.7, 0.55 }
end
in_thread do
  4.times { bass1 0.75, 68; bass2 0.75, 70 }
end
in_thread do
  with_fx :reverb, room: 0.65, mix: 0.4 do
    4.times { arp1 0.55; arp2 0.5 }
  end
end
in_thread do
  with_fx :reverb, room: 0.7, mix: 0.45 do
    with_fx :echo, phase: 0.5, decay: 3.5, mix: 0.35 do
      sleep 16; 2.times { mel1 0.6; mel2 0.55 }
    end
  end
end
sleep 32
hit 1

# MAIN: 12 bars - full dark drive
in_thread do
  12.times { drums 1.05, 0.95, 0.7 }
end
in_thread do
  6.times { bass1 1, 78; bass2 1, 80 }
end
in_thread do
  6.times { stab_pat 0.65 }
end
in_thread do
  with_fx :reverb, room: 0.55, mix: 0.35 do
    6.times { arp1 0.7; arp2 0.65 }
  end
end
in_thread do
  with_fx :reverb, room: 0.6, mix: 0.4 do
    with_fx :echo, phase: 0.5, decay: 3, mix: 0.3 do
      3.times { mel1 0.8; mel3 0.75; mel2 0.8; mel3 0.75 }
    end
  end
end
sleep 48

# PEAK: 12 bars - maximum intensity
in_thread do
  12.times { drums 1.2, 1.1, 0.8 }
end
in_thread do
  6.times { bass2 1.15, 85; bass1 1.15, 88 }
end
in_thread do
  6.times { stab_pat 0.85 }
end
in_thread do
  with_fx :reverb, room: 0.5, mix: 0.3 do
    6.times { arp1 0.8; arp2 0.75 }
  end
end
in_thread do
  with_fx :reverb, room: 0.55, mix: 0.35 do
    with_fx :echo, phase: 0.5, decay: 2.5, mix: 0.25 do
      3.times { mel3 0.95; mel1 0.9; mel2 0.95; mel3 0.9 }
    end
  end
end
sleep 48

# DESCENT: 6 bars
in_thread do
  6.times { |i| drums (1-i*0.1), (0.85-i*0.09), (0.65-i*0.07) }
end
in_thread do
  with_fx :reverb, room: 0.75, mix: 0.5 do
    with_fx :echo, phase: 0.75, decay: 5, mix: 0.45 do
      mel3 0.6; mel2 0.5; mel1 0.4
    end
  end
end
sleep 24

# OUTRO: 6 bars - into darkness
in_thread do
  with_fx :reverb, room: 0.95, mix: 0.65 do
    with_fx :echo, phase: 1, decay: 8, mix: 0.55 do
      arp1 0.35; arp2 0.3; sleep 8; mel1 0.25
    end
  end
end
sleep 24