# TRACK 6: VOID WALKER | 95 BPM | B Minor | ~3:30
# Slow but POWERFUL - dark strength, muscles growing
use_bpm 95

define :kick do |v=1|
  sample :bd_tek, amp: 2.4*v, rate: 0.78
  sample :bd_zum, amp: 1.3*v, rate: 0.55, cutoff: 55
end
define :snare do |v=1|
  sample :sn_dub, amp: 1.1*v, rate: 0.72
  sample :drum_snare_hard, amp: 0.5*v, rate: 0.8
end
define :hat do |v=1|
  sample :drum_cymbal_closed, amp: 0.22*v, rate: 1.9, release: 0.05
end

# MASSIVE bass
define :bass do |n, v=1, c=72|
  use_synth :tb303
  play n, amp: 0.85*v, attack: 0.02, decay: 0.25, sustain: 0.15, release: 0.2, cutoff: c, res: 0.35, wave: 0
  use_synth :dsaw
  play n, amp: 0.35*v, attack: 0.01, decay: 0.2, release: 0.15, cutoff: c-10, detune: 0.2
  use_synth :sine
  play n-12, amp: 1.2*v, attack: 0.01, sustain: 0.3, release: 0.2
end

# Power stab - fixed to use chord
define :stab do |notes, v=1|
  use_synth :dsaw
  play notes, amp: 0.55*v, attack: 0, decay: 0.12, sustain: 0.05, release: 0.1, cutoff: 100, detune: 0.25
end

# Dark power lead
define :lead do |n, dur=0.5, v=1|
  use_synth :prophet
  play n, amp: 0.38*v, attack: 0.05, decay: dur*0.3, sustain: dur*0.45, release: dur*0.5, cutoff: 88
end

# Menacing pulse
define :pulse do |n, v=1|
  use_synth :dpulse
  play n, amp: 0.32*v, attack: 0.02, decay: 0.2, sustain: 0.08, release: 0.15, cutoff: 80, dpulse_width: 0.25
end

define :hit do |v=1|
  sample :bd_boom, amp: 2*v, rate: 0.38
  sample :drum_splash_hard, amp: 0.7*v, rate: 0.6
end

# POWERFUL drums
define :drums do |k=1, s=1, h=1|
  in_thread do
    kick k; sleep 1; kick k*0.7; sleep 1; kick k*0.9; sleep 1; kick k*0.6; sleep 1
  end
  in_thread do
    sleep 2; snare s; sleep 2
  end
  in_thread do
    8.times { hat h; sleep 0.5 }
  end
  sleep 4
end

# Double snare power pattern
define :drums_power do |k=1, s=1, h=1|
  in_thread do
    kick k; sleep 0.75; kick k*0.6; sleep 0.25
    kick k*0.8; sleep 1
    kick k; sleep 0.75; kick k*0.7; sleep 0.25
    kick k*0.9; sleep 1
  end
  in_thread do
    sleep 1.5; snare s*0.7; sleep 0.5; snare s; sleep 2
  end
  in_thread do
    8.times { hat h; sleep 0.5 }
  end
  sleep 4
end

# Basslines - heavy, powerful
define :bass1 do |v=1, c=72|
  bass :b1,v,c; sleep 0.5; bass :b1,v*0.6,c-5; sleep 0.5
  bass :b1,v*0.8,c; sleep 0.5; bass :d2,v*0.9,c; sleep 0.5
  bass :b1,v,c+5; sleep 0.5; bass :a1,v*0.7,c; sleep 0.5
  bass :b1,v,c; sleep 1
end
define :bass2 do |v=1, c=72|
  bass :fs1,v,c; sleep 0.75; bass :g1,v*0.8,c; sleep 0.25
  bass :a1,v*0.9,c; sleep 0.5; bass :b1,v,c+5; sleep 0.5
  bass :d2,v*0.85,c; sleep 0.5; bass :b1,v,c; sleep 0.5
  bass :a1,v*0.7,c; sleep 0.5; bass :b1,v,c; sleep 0.5
end

# Pulse sequence - driving
define :pulse_seq do |v=1|
  [:b2,:d3,:fs3,:b3,:fs3,:d3,:b2,:d3].each{|n| pulse n,v; sleep 0.5}
end

# Stab pattern - powerful accents
define :stab_pat do |v=1|
  stab [:b2,:fs3,:b3],v; sleep 1.5
  stab [:b2,:fs3,:b3],v*0.6; sleep 0.5
  stab [:a2,:e3,:a3],v*0.8; sleep 1
  stab [:b2,:fs3,:b3],v; sleep 1
end

# Power melodies
define :mel1 do |v=1|
  lead :fs4,0.75,v; sleep 0.75; lead :b4,1,v; sleep 1
  lead :a4,0.5,v*0.9; sleep 0.5; lead :fs4,0.75,v*0.85; sleep 0.75
  lead :b4,1,v; sleep 1
end
define :mel2 do |v=1|
  lead :b4,0.75,v; sleep 0.75; lead :d5,0.75,v*0.95; sleep 0.75
  lead :cs5,0.5,v*0.9; sleep 0.5; lead :b4,0.5,v*0.85; sleep 0.5
  lead :a4,0.75,v; sleep 0.75; lead :b4,0.75,v; sleep 0.75
end

# === ARRANGEMENT ===

# INTRO: 6 bars - power emerges
in_thread do
  6.times { drums 0.7, 0, 0.35 }
end
in_thread do
  with_fx :lpf, cutoff: 50, cutoff_slide: 24 do |f|
    control f, cutoff: 85
    6.times { bass1 0.6, 55 }
  end
end
sleep 24

# BUILD: 8 bars - stabs enter
in_thread do
  8.times { drums 0.85, 0.7, 0.5 }
end
in_thread do
  8.times { bass1 0.75, 68 }
end
in_thread do
  with_fx :reverb, room: 0.5, mix: 0.3 do
    4.times { pulse_seq 0.55 }
  end
end
in_thread do
  sleep 16; 2.times { stab_pat 0.6 }
end
sleep 32
hit 1

# MAIN A: 12 bars - POWER groove
in_thread do
  12.times { drums_power 1.05, 1, 0.65 }
end
in_thread do
  6.times { bass1 1, 78; bass2 1, 78 }
end
in_thread do
  with_fx :reverb, room: 0.45, mix: 0.25 do
    6.times { pulse_seq 0.7 }
  end
end
in_thread do
  6.times { stab_pat 0.75 }
end
in_thread do
  with_fx :reverb, room: 0.6, mix: 0.4 do
    with_fx :echo, phase: 0.75, decay: 2.5, mix: 0.25 do
      sleep 16; 3.times { mel1 0.7; mel2 0.65 }
    end
  end
end
sleep 48

# BREAK: 4 bars - tension
in_thread do
  8.times { hat 0.4; sleep 0.5 }
  sleep 8; hit 0.9
end
in_thread do
  with_fx :reverb, room: 0.75, mix: 0.5 do
    with_fx :echo, phase: 1, decay: 4, mix: 0.4 do
      mel1 0.55; mel2 0.5
    end
  end
end
sleep 16
hit 1.3

# MAIN B: 14 bars - MAXIMUM POWER
in_thread do
  14.times { drums_power 1.2, 1.1, 0.75 }
end
in_thread do
  7.times { bass2 1.1, 82; bass1 1.1, 85 }
end
in_thread do
  with_fx :reverb, room: 0.4, mix: 0.2 do
    7.times { pulse_seq 0.8 }
  end
end
in_thread do
  7.times { stab_pat 0.9 }
end
in_thread do
  with_fx :reverb, room: 0.55, mix: 0.35 do
    with_fx :echo, phase: 0.5, decay: 2, mix: 0.2 do
      7.times { mel1 0.85; mel2 0.8 }
    end
  end
end
sleep 56

# OUTRO: 6 bars - power fades
in_thread do
  6.times { |i| drums_power (1.1-i*0.12), (0.95-i*0.1), (0.65-i*0.08) }
end
in_thread do
  3.times { bass1 0.9, 75; bass2 0.7, 70 }
end
in_thread do
  with_fx :reverb, room: 0.7, mix: 0.5 do
    stab_pat 0.6; sleep 4; stab_pat 0.4
  end
end
sleep 24