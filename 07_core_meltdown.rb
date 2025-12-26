# TRACK 7: CORE MELTDOWN | 106 BPM | G Minor | ~3:30
# Album climax - dark synth bass, lush ethereal melodies
use_bpm 106

define :kick do |v=1|
  sample :bd_tek, amp: 2.5*v, rate: 0.84
  sample :bd_zum, amp: 1.3*v, rate: 0.6, cutoff: 55
end
define :snare do |v=1|
  sample :sn_dub, amp: 1.1*v, rate: 0.8
  sample :drum_snare_hard, amp: 0.55*v, rate: 0.88
end
define :hat do |v=1|
  sample :drum_cymbal_closed, amp: 0.24*v, rate: 2.2, release: 0.04
end

# Dark synth bass
define :bass do |n, v=1, c=75|
  use_synth :prophet
  play n, amp: 0.65*v, attack: 0.02, decay: 0.25, sustain: 0.15, release: 0.2, cutoff: c, res: 0.25
  use_synth :dsaw
  play n, amp: 0.4*v, attack: 0.01, decay: 0.2, release: 0.15, cutoff: c-10, detune: 0.18
  use_synth :sine
  play n-12, amp: 1.15*v, attack: 0.01, sustain: 0.28, release: 0.2
end

# Beautiful dark lead
define :lead do |n, dur=0.5, v=1|
  use_synth :prophet
  play n, amp: 0.4*v, attack: 0.08, decay: dur*0.25, sustain: dur*0.5, release: dur*0.7, cutoff: 85, res: 0.15
  use_synth :saw
  play n+12, amp: 0.1*v, attack: 0.1, decay: dur*0.2, sustain: dur*0.3, release: dur*0.5, cutoff: 72
end

# Dark pad stab
define :dark_stab do |notes, v=1|
  use_synth :dark_ambience
  play notes, amp: 0.35*v, attack: 0.05, decay: 0.3, sustain: 0.1, release: 0.4
end

define :hit do |v=1|
  sample :bd_boom, amp: 2.2*v, rate: 0.35
  sample :drum_splash_hard, amp: 0.75*v, rate: 0.55
end

define :riser do |dur, v=1|
  use_synth :noise
  play :g2, amp: 0.4*v, attack: dur*0.9, release: dur*0.1, cutoff: 55, cutoff_slide: dur
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

define :drums_intense do |k=1, s=1, h=1|
  in_thread do
    kick k; sleep 0.75; kick k*0.55; sleep 0.25
    kick k*0.9; sleep 0.75; kick k*0.6; sleep 0.25
    kick k; sleep 0.75; kick k*0.5; sleep 0.25
    kick k*0.85; sleep 0.75; kick k*0.65; sleep 0.25
  end
  in_thread do
    sleep 1; snare s; sleep 1; snare s; sleep 2
  end
  in_thread do
    16.times { hat h; sleep 0.25 }
  end
  sleep 4
end

define :bass1 do |v=1, c=75|
  bass :g1,v,c; sleep 0.5
  bass :g1,v*0.5,c-5; sleep 0.5
  bass :bb1,v*0.8,c; sleep 0.5
  bass :g1,v*0.9,c; sleep 0.5
  bass :f1,v*0.7,c; sleep 0.5
  bass :g1,v,c+5; sleep 0.5
  bass :d2,v*0.8,c; sleep 0.5
  bass :g1,v,c; sleep 0.5
end

define :bass2 do |v=1, c=75|
  bass :g1,v,c; sleep 0.75
  bass :bb1,v*0.85,c; sleep 0.25
  bass :c2,v*0.9,c; sleep 0.5
  bass :d2,v,c+8; sleep 0.5
  bass :eb2,v*0.95,c+5; sleep 0.5
  bass :d2,v*0.8,c; sleep 0.5
  bass :bb1,v*0.7,c; sleep 0.5
  bass :g1,v,c; sleep 0.5
end

define :stab_pat do |v=1|
  dark_stab [:g2,:d3,:g3],v; sleep 1.5
  dark_stab [:g2,:d3,:g3],v*0.5; sleep 0.5
  dark_stab [:bb2,:f3,:bb3],v*0.8; sleep 1
  dark_stab [:g2,:d3,:g3],v; sleep 1
end

# Melodies
define :mel1 do |v=1|
  lead :g4, 1, v; sleep 1
  lead :bb4, 0.75, v*0.95; sleep 0.75
  lead :c5, 0.75, v; sleep 0.75
  lead :d5, 1.5, v; sleep 1.5
end

define :mel2 do |v=1|
  lead :d5, 0.75, v; sleep 0.75
  lead :c5, 0.5, v*0.9; sleep 0.5
  lead :bb4, 0.75, v*0.95; sleep 0.75
  lead :a4, 0.5, v*0.85; sleep 0.5
  lead :g4, 1.5, v; sleep 1.5
end

define :mel3 do |v=1|
  lead :bb4, 0.75, v; sleep 0.75
  lead :c5, 0.75, v*0.95; sleep 0.75
  lead :d5, 1, v; sleep 1
  lead :eb5, 1.5, v; sleep 1.5
end

define :mel4 do |v=1|
  lead :d5, 1, v; sleep 1
  lead :bb4, 0.75, v*0.9; sleep 0.75
  lead :g4, 0.75, v*0.95; sleep 0.75
  lead :a4, 0.5, v*0.85; sleep 0.5
  lead :g4, 1, v; sleep 1
end

# === ARRANGEMENT ===

# INTRO: 8 bars - deep reverb melody
in_thread do
  8.times { drums 0.75, 0, 0.4 }
end
in_thread do
  with_fx :lpf, cutoff: 50, cutoff_slide: 32 do |f|
    control f, cutoff: 85
    8.times { bass1 0.55, 55 }
  end
end
in_thread do
  with_fx :reverb, room: 0.95, mix: 0.65 do
    with_fx :echo, phase: 1, decay: 6, mix: 0.45 do
      sleep 16; mel1 0.5; mel2 0.45
    end
  end
end
sleep 32

# BUILD: 8 bars - melody grows
in_thread do
  8.times { drums 0.9, 0.75, 0.55 }
end
in_thread do
  4.times { bass1 0.75, 68; bass2 0.75, 70 }
end
in_thread do
  4.times { stab_pat 0.55 }
end
in_thread do
  with_fx :reverb, room: 0.85, mix: 0.55 do
    with_fx :echo, phase: 0.75, decay: 5, mix: 0.4 do
      2.times { mel1 0.6; mel3 0.55; mel2 0.6; mel4 0.55 }
    end
  end
end
in_thread do
  sleep 24; riser 8, 0.75
end
sleep 32
hit 1.2

# MAIN A: 12 bars - full but still ethereal
in_thread do
  12.times { drums_intense 1.05, 0.95, 0.7 }
end
in_thread do
  6.times { bass1 1, 78; bass2 1, 80 }
end
in_thread do
  6.times { stab_pat 0.7 }
end
in_thread do
  with_fx :reverb, room: 0.75, mix: 0.45 do
    with_fx :echo, phase: 0.5, decay: 4, mix: 0.35 do
      3.times { mel1 0.75; mel3 0.7; mel2 0.75; mel4 0.7 }
    end
  end
end
sleep 48

# TENSION: 6 bars - massive space
in_thread do
  12.times { hat 0.35; sleep 0.5 }; sleep 12
end
in_thread do
  with_fx :reverb, room: 1, mix: 0.75 do
    with_fx :echo, phase: 1.5, decay: 8, mix: 0.6 do
      mel3 0.55; mel4 0.5; mel1 0.45
    end
  end
end
in_thread do
  sleep 12; riser 12, 0.9
end
sleep 24
hit 1.7

# MASSIVE DROP: 14 bars - power with space
in_thread do
  14.times { drums_intense 1.25, 1.1, 0.85 }
end
in_thread do
  7.times { bass2 1.2, 85; bass1 1.2, 88 }
end
in_thread do
  7.times { stab_pat 0.9 }
end
in_thread do
  with_fx :reverb, room: 0.7, mix: 0.4 do
    with_fx :echo, phase: 0.75, decay: 4, mix: 0.3 do
      3.times { mel1 0.9; mel3 0.85; mel2 0.9; mel4 0.85 }
      mel1 0.85; mel2 0.8
    end
  end
end
sleep 56

# OUTRO: 6 bars - fading into space
in_thread do
  6.times { |i| drums_intense (1.15-i*0.12), (0.95-i*0.1), (0.75-i*0.08) }
end
in_thread do
  3.times { bass1 0.8, 75; bass2 0.6, 70 }
end
in_thread do
  with_fx :reverb, room: 1, mix: 0.7 do
    with_fx :echo, phase: 1.25, decay: 10, mix: 0.55 do
      mel1 0.5; mel2 0.4
    end
  end
end
sleep 24