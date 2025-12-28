# MIDNIGHT PROTOCOL II | 102 BPM | C Minor | ~5:00
use_bpm 102

# Sounds
define :k do |v=1|
  sample :bd_tek, amp: 1.8*v, rate: 0.92
  sample :bd_haus, amp: 0.7*v, rate: 0.82
end
define :s do |v=1|
  sample :sn_dub, amp: 0.9*v, rate: 0.9
end
define :h do |v=1|
  sample :drum_cymbal_closed, amp: 0.2*v, rate: 2.1
end
define :b do |n,v=1,c=75|
  use_synth :saw
  play n, amp: 0.6*v, attack: 0.02, decay: 0.2, sustain: 0.15, release: 0.2, cutoff: c
  use_synth :sine
  play n-12, amp: 0.9*v, sustain: 0.25, release: 0.2
end
define :l do |n,d=0.5,v=1|
  use_synth :prophet
  play n, amp: 0.35*v, attack: 0.08, decay: d*0.3, sustain: d*0.5, release: d*0.7, cutoff: 88
  use_synth :saw
  play n+12, amp: 0.08*v, attack: 0.1, sustain: d*0.3, release: d*0.5, cutoff: 70
end
define :a do |n,v=1|
  use_synth :pulse
  play n, amp: 0.25*v, attack: 0.01, decay: 0.12, release: 0.1, cutoff: 100, pulse_width: 0.35
end
define :p do |n,v=1|
  use_synth :hollow
  play n, amp: 0.25*v, attack: 1.2, sustain: 2, release: 2, cutoff: 85
end
define :hit do |v=1|
  sample :bd_boom, amp: 1.8*v, rate: 0.45
  sample :drum_splash_hard, amp: 0.6*v, rate: 0.65
end

# Patterns
define :dr do |kv=1,sv=1,hv=1|
  in_thread { 4.times { k kv; sleep 1 } }
  in_thread { sleep 1; s sv; sleep 1; s sv; sleep 2 }
  in_thread { 8.times { h hv; sleep 0.5 } }
  sleep 4
end
define :a1 do |v=1|
  [:c4,:eb4,:g4,:c5,:g4,:eb4,:c4,:g3].each { |n| a n,v; sleep 0.5 }
end
define :a2 do |v=1|
  [:ab3,:c4,:eb4,:ab4,:eb4,:c4,:ab3,:eb3].each { |n| a n,v; sleep 0.5 }
end
define :a3 do |v=1|
  [:f3,:ab3,:c4,:f4,:c4,:ab3,:f3,:c3].each { |n| a n,v; sleep 0.5 }
end
define :ah do |v=1|
  [:c5,:eb5,:g5,:c6,:g5,:eb5,:c5,:g4].each { |n| a n,v*0.7; sleep 0.5 }
end
define :b1 do |v=1,c=75|
  b :c2,v,c; sleep 1.5; b :c2,v*0.6,c-5; sleep 0.5
  b :eb2,v*0.8,c; sleep 1; b :g1,v,c; sleep 1
end
define :b2 do |v=1,c=75|
  b :ab1,v,c; sleep 1; b :eb2,v*0.7,c; sleep 0.5
  b :f2,v*0.8,c; sleep 0.5; b :g2,v*0.9,c+5; sleep 1; b :c2,v,c; sleep 1
end
define :m1 do |v=1|
  l :g4,1,v; sleep 1; l :ab4,0.75,v*0.9; sleep 0.75
  l :g4,0.5,v*0.85; sleep 0.5; l :eb4,1.25,v; sleep 1.75
end
define :m2 do |v=1|
  l :c5,0.75,v; sleep 0.75; l :bb4,0.5,v*0.9; sleep 0.5
  l :ab4,0.5,v*0.85; sleep 0.5; l :g4,1.5,v; sleep 2.25
end
define :m3 do |v=1|
  l :eb5,1,v; sleep 1; l :d5,0.5,v*0.9; sleep 0.5
  l :c5,0.75,v; sleep 0.75; l :bb4,0.5,v*0.8; sleep 0.5; l :ab4,1.25,v*0.9; sleep 1.25
end
define :m4 do |v=1|
  l :c5,0.5,v; sleep 0.5; l :eb5,0.5,v; sleep 0.5
  l :g5,1.5,v*1.1; sleep 1.5; l :f5,0.5,v*0.9; sleep 0.5; l :eb5,1,v; sleep 1
end
define :m5 do |v=1|
  l :g5,0.75,v; sleep 0.75; l :f5,0.5,v*0.95; sleep 0.5
  l :eb5,0.5,v*0.9; sleep 0.5; l :d5,0.5,v*0.85; sleep 0.5; l :c5,1.75,v; sleep 1.75
end

# INTRO: 16 bars (64 beats)
in_thread do
  with_fx :reverb, room: 0.9, mix: 0.6 do
    sample :ambi_lunar_land, amp: 0.5, rate: 0.7
    sleep 16; sample :ambi_dark_woosh, amp: 0.4, rate: 0.6
  end
end
in_thread do
  with_fx :reverb, room: 0.85, mix: 0.55 do
    p [:c3,:eb3,:g3],0.4; sleep 16; p [:ab2,:c3,:eb3],0.35; sleep 16; p [:f2,:ab2,:c3],0.38
  end
end
in_thread do
  sleep 16
  with_fx :reverb, room: 0.7, mix: 0.45 do
    6.times { a1 0.4; a2 0.35 }
  end
end
sleep 64

# BUILD 1: 8 bars
in_thread do
  with_fx :lpf, cutoff: 80, cutoff_slide: 32 do |fx|
    control fx, cutoff: 110
    8.times { dr 0.7,0.5,0.5 }
  end
end
in_thread { 8.times { b1 0.6,65 } }
in_thread { 4.times { a1 0.55; a3 0.5 } }
sleep 32
hit 1.2

# DROP 1: 16 bars
in_thread { 16.times { dr 1,0.9,0.7 } }
in_thread { 8.times { b1 0.95,80; b2 0.95,80 } }
in_thread do
  with_fx :reverb, room: 0.5, mix: 0.3 do
    8.times { a1 0.7; a2 0.65 }
  end
end
in_thread do
  with_fx :reverb, room: 0.6, mix: 0.4 do
    sleep 8; 4.times { m1 0.8; m2 0.75 }
  end
end
sleep 64

# BREAKDOWN 1: 12 bars
with_fx :reverb, room: 0.9, mix: 0.6 do
  in_thread { p [:c3,:eb3,:g3,:c4],0.4; sleep 24; p [:ab2,:c3,:eb3,:ab3],0.38 }
  in_thread { 3.times { a2 0.35; a3 0.3; a1 0.32; a2 0.3 } }
  in_thread { sleep 8; m3 0.55; sleep 2; m1 0.5; sleep 4; m2 0.45 }
  in_thread { 24.times { h 0.25; sleep 0.5 } }
end
sleep 48

# BUILD 2: 8 bars
in_thread { 8.times { dr 0.85,0.7,0.6 } }
in_thread do
  with_fx :lpf, cutoff: 65, cutoff_slide: 28 do |fx|
    control fx, cutoff: 95
    8.times { b1 0.7,65 }
  end
end
in_thread { 2.times { a1 0.6; ah 0.5; a3 0.55; a2 0.55 } }
in_thread do
  with_fx :reverb, room: 0.7, mix: 0.5 do
    m1 0.6; m3 0.55; m4 0.65
  end
end
sleep 32
hit 1.4

# DROP 2: 20 bars - Peak
in_thread { 20.times { dr 1.1,1,0.8 } }
in_thread { 10.times { b1 1.05,85; b2 1.05,88 } }
in_thread do
  with_fx :reverb, room: 0.45, mix: 0.28 do
    5.times { a1 0.8; a3 0.75; ah 0.6; a2 0.75 }
  end
end
in_thread do
  with_fx :reverb, room: 0.55, mix: 0.38 do
    sleep 8; 3.times { m4 0.9; m5 0.85; m1 0.85; m3 0.8 }
  end
end
sleep 80

# BREAKDOWN 2: 8 bars
with_fx :reverb, room: 0.95, mix: 0.7 do
  in_thread { p [:c3,:eb3,:g3,:bb3],0.35; sleep 16; p [:f2,:ab2,:c3,:f3],0.32 }
  in_thread { 4.times { a2 0.3; a3 0.28 } }
  in_thread { sleep 8; m2 0.45; sleep 2; m5 0.4 }
end
sleep 32

# FINAL BUILD: 4 bars
in_thread { 4.times { dr 0.9,0.75,0.65 } }
in_thread { 4.times { b2 0.8,75 } }
in_thread { a1 0.6; ah 0.55; a3 0.55; ah 0.6 }
sleep 16
hit 1.5

# FINAL DROP: 8 bars
in_thread { 8.times { dr 1.15,1.05,0.85 } }
in_thread { 4.times { b1 1.1,90; b2 1.1,92 } }
in_thread do
  with_fx :reverb, room: 0.4, mix: 0.25 do
    2.times { a1 0.85; ah 0.7; a3 0.8; a2 0.8 }
  end
end
in_thread do
  with_fx :reverb, room: 0.5, mix: 0.35 do
    2.times { m4 0.95; m5 0.9 }
  end
end
sleep 32

# OUTRO: 8 bars
in_thread { 8.times { |i| dr (1-i*0.1),(0.85-i*0.08),(0.7-i*0.07) } }
in_thread do
  with_fx :reverb, room: 0.85, mix: 0.6 do
    2.times { a1 0.5; a2 0.4 }
  end
end
in_thread do
  with_fx :reverb, room: 0.9, mix: 0.65 do
    sleep 8; m1 0.4; sleep 4; l :c4,4,0.3
  end
end
sleep 32