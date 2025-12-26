# TRACK 5: MIDNIGHT PROTOCOL | 102 BPM | C Minor | ~3:30
# Synthwave - inspiring, energizing, triumphant
use_bpm 102

# Sounds
define :kick do |v=1|
  sample :bd_tek, amp: 1.9*v, rate: 0.92
  sample :bd_haus, amp: 0.7*v, rate: 0.82
end

define :snare do |v=1|
  sample :sn_dub, amp: 0.95*v, rate: 0.9
end

define :hat do |v=1|
  sample :drum_cymbal_closed, amp: 0.22*v, rate: 2.1, release: 0.05
end

define :bass do |n, v=1|
  use_synth :saw
  play n, amp: 0.55*v, attack: 0.02, decay: 0.2, sustain: 0.15, release: 0.2, cutoff: 78
  use_synth :sine
  play n-12, amp: 0.85*v, attack: 0.01, sustain: 0.25, release: 0.2
end

define :lead do |n, dur=0.5, v=1|
  use_synth :prophet
  play n, amp: 0.38*v, attack: 0.05, decay: dur*0.25, sustain: dur*0.5, release: dur*0.6, cutoff: 92
end

define :arp do |n, v=1|
  use_synth :pulse
  play n, amp: 0.28*v, attack: 0.01, decay: 0.12, sustain: 0.03, release: 0.12, cutoff: 105, pulse_width: 0.35
end

define :stab do |n, v=1|
  use_synth :dsaw
  play n, amp: 0.3*v, attack: 0.01, decay: 0.15, sustain: 0.05, release: 0.15, cutoff: 95, detune: 0.12
end

define :hit do |v=1|
  sample :bd_boom, amp: 1.5*v, rate: 0.5
  sample :drum_splash_soft, amp: 0.5*v, rate: 0.75
end

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

# Arps - brighter voicings
define :arp1 do |v=1|
  [:c4,:g4,:c5,:eb5,:c5,:g4,:eb4,:g4].each{|n| arp n,v; sleep 0.5}
end
define :arp2 do |v=1|
  [:ab3,:eb4,:ab4,:c5,:ab4,:eb4,:c4,:eb4].each{|n| arp n,v; sleep 0.5}
end
define :arp3 do |v=1|
  [:bb3,:f4,:bb4,:d5,:bb4,:f4,:d4,:f4].each{|n| arp n,v; sleep 0.5}
end

define :bassline do |v=1|
  bass :c2,v; sleep 1.5; bass :c2,v*0.6; sleep 0.5; bass :eb2,v*0.8; sleep 1; bass :g1,v; sleep 1
end
define :bassline2 do |v=1|
  bass :ab1,v; sleep 1; bass :bb1,v*0.8; sleep 1; bass :c2,v; sleep 1; bass :g1,v*0.9; sleep 1
end

# Inspiring melodies - more major intervals, upward motion
define :mel1 do |v=1|
  lead :g4,0.75,v; sleep 0.75; lead :c5,1,v; sleep 1; lead :d5,0.75,v*0.95; sleep 0.75; lead :eb5,1.5,v; sleep 1.5
end
define :mel2 do |v=1|
  lead :eb5,0.5,v; sleep 0.5; lead :d5,0.5,v*0.9; sleep 0.5; lead :c5,1,v; sleep 1; lead :g4,0.5,v*0.8; sleep 0.5; lead :c5,1,v; sleep 1.5
end
define :mel3 do |v=1|
  lead :c5,0.75,v; sleep 0.75; lead :eb5,0.75,v; sleep 0.75; lead :f5,1,v*0.95; sleep 1; lead :g5,1.5,v; sleep 1.5
end

# Stab pattern - energizing
define :stabs do |v=1|
  stab [:c4,:eb4,:g4],v; sleep 1
  stab [:c4,:eb4,:g4],v*0.6; sleep 0.5
  sleep 0.5
  stab [:ab3,:c4,:eb4],v*0.8; sleep 1
  stab [:bb3,:d4,:f4],v*0.9; sleep 1
end

# === ARRANGEMENT ===

# INTRO: 8 bars - arps with delay
in_thread do
  with_fx :reverb, room: 0.8, mix: 0.5 do
    with_fx :echo, phase: 0.75, decay: 3, mix: 0.35 do
      4.times { arp1 0.5; arp2 0.45 }
    end
  end
end
sleep 32

# BUILD: 8 bars - drums enter, filter opens
in_thread do
  8.times { drums 0.8, 0.65, 0.5 }
end
in_thread do
  with_fx :lpf, cutoff: 70, cutoff_slide: 32 do |f|
    control f, cutoff: 110
    8.times { bassline 0.7 }
  end
end
in_thread do
  with_fx :reverb, room: 0.6, mix: 0.4 do
    4.times { arp1 0.65; arp3 0.6 }
  end
end
sleep 32
hit 0.9

# MAIN A: 12 bars - full energy, melodies soar
in_thread do
  12.times { drums 1, 0.9, 0.7 }
end
in_thread do
  6.times { bassline 0.95; bassline2 0.95 }
end
in_thread do
  with_fx :reverb, room: 0.55, mix: 0.35 do
    with_fx :echo, phase: 0.5, decay: 2, mix: 0.25 do
      6.times { arp1 0.75; arp2 0.7 }
    end
  end
end
in_thread do
  with_fx :reverb, room: 0.7, mix: 0.5 do
    with_fx :echo, phase: 0.75, decay: 4, mix: 0.3 do
      sleep 8; 3.times { mel1 0.8; mel2 0.75 }
    end
  end
end
sleep 48

# LIFT: 4 bars - stabs + anticipation
in_thread do
  4.times { drums 1.05, 0.95, 0.75 }
end
in_thread do
  with_fx :reverb, room: 0.65, mix: 0.4 do
    4.times { stabs 0.75 }
  end
end
in_thread do
  with_fx :echo, phase: 0.5, decay: 3, mix: 0.4 do
    mel3 0.7
  end
end
sleep 16
hit 1.2

# PEAK: 12 bars - triumphant, all elements
in_thread do
  12.times { drums 1.1, 1, 0.8 }
end
in_thread do
  6.times { bassline 1.05; bassline2 1.05 }
end
in_thread do
  with_fx :reverb, room: 0.5, mix: 0.3 do
    with_fx :echo, phase: 0.375, decay: 2, mix: 0.2 do
      4.times { arp1 0.85; arp3 0.8; arp2 0.85 }
    end
  end
end
in_thread do
  with_fx :reverb, room: 0.75, mix: 0.5 do
    with_fx :echo, phase: 0.75, decay: 5, mix: 0.35 do
      3.times { mel3 0.9; mel1 0.85; mel2 0.85 }
    end
  end
end
in_thread do
  sleep 16
  with_fx :reverb, room: 0.6, mix: 0.35 do
    4.times { stabs 0.7 }
  end
end
sleep 48

# OUTRO: 8 bars - echoes fade heroically
in_thread do
  4.times { |i| drums (1-i*0.18), (0.85-i*0.15), (0.7-i*0.12) }
end
in_thread do
  with_fx :reverb, room: 0.9, mix: 0.65 do
    with_fx :echo, phase: 0.75, decay: 6, mix: 0.5 do
      mel3 0.6; sleep 4; mel1 0.45
    end
  end
end
in_thread do
  with_fx :reverb, room: 0.85, mix: 0.55 do
    arp1 0.4; arp3 0.3
  end
end
sleep 32