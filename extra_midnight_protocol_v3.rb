# ═══════════════════════════════════════════════════════════════════════════════
# MIDNIGHT PROTOCOL II | 102 BPM | C Minor
# Progressive House / Melodic Techno - Stronger melodies, syncopation, energy
# ═══════════════════════════════════════════════════════════════════════════════

use_bpm 102

# ═══════════════════════════════════════════════════════════════════════════════
# SOUND DESIGN
# ═══════════════════════════════════════════════════════════════════════════════

# --- DRUMS ---

define :kick do |v=1|
  sample :bd_tek, amp: 2.0 * v, rate: 0.9
  sample :bd_haus, amp: 0.85 * v, rate: 0.78
end

define :snare do |v=1|
  sample :sn_dub, amp: 0.9 * v, rate: 0.88
end

define :hat do |v=1|
  sample :drum_cymbal_closed, amp: 0.2 * v, rate: 2.1, release: 0.04
end

define :hat_open do |v=1|
  sample :drum_cymbal_open, amp: 0.12 * v, rate: 1.7, release: 0.12
end

define :clap do |v=1|
  sample :drum_snare_soft, amp: 0.25 * v, rate: 1.15
end

# --- BASS (saw mid + sine sub) ---

define :bass do |n, v=1, c=75|
  use_synth :saw
  play n,
       amp: 0.55 * v,
       attack: 0.01,
       decay: 0.18,
       sustain: 0.12,
       release: 0.15,
       cutoff: c

  use_synth :sine
  play n - 12,
       amp: 0.95 * v,
       attack: 0.01,
       sustain: 0.22,
       release: 0.18
end

# --- LEAD (muted for now - focusing on arps and bass) ---

define :lead do |n, dur=0.5, v=1|
  # Silent - uncomment to experiment
  # use_synth :prophet
  # play n, amp: 0.3 * v, attack: 0.05, decay: dur * 0.3, sustain: dur * 0.4, release: dur * 0.5, cutoff: 85
end

# --- ARP (plucky pulse) ---

define :arp do |n, v=1|
  use_synth :pulse
  play n,
       amp: 0.28 * v,
       attack: 0.008,
       decay: 0.12,
       sustain: 0.02,
       release: 0.1,
       cutoff: 100,
       pulse_width: 0.35
end

# --- STAB (detuned, short) ---

define :stab do |n, v=1|
  use_synth :dsaw
  play n,
       amp: 0.38 * v,
       attack: 0.005,
       decay: 0.12,
       sustain: 0.02,
       release: 0.08,
       cutoff: 95,
       detune: 0.12
end

# --- PAD ---

define :pad do |notes, v=1|
  use_synth :hollow
  play notes,
       amp: 0.22 * v,
       attack: 1.5,
       sustain: 2.5,
       release: 3,
       cutoff: 82
end

# --- IMPACT ---

define :hit do |v=1|
  sample :bd_boom, amp: 1.8 * v, rate: 0.45
  sample :drum_splash_soft, amp: 0.5 * v, rate: 0.7
end

# --- ATMOSPHERIC TRANSITIONS ---

define :fx_woosh do |v=1|
  with_fx :reverb, room: 0.9, mix: 0.6 do
    sample :ambi_dark_woosh, amp: 0.5 * v, rate: 0.7
  end
end

define :fx_swoosh do |v=1|
  with_fx :reverb, room: 0.85, mix: 0.55 do
    sample :ambi_swoosh, amp: 0.45 * v, rate: 0.8
  end
end

define :fx_drone do |v=1|
  with_fx :reverb, room: 0.95, mix: 0.65 do
    with_fx :lpf, cutoff: 85 do
      sample :ambi_drone, amp: 0.4 * v, rate: 0.6
    end
  end
end

define :fx_haunted do |v=1|
  with_fx :reverb, room: 0.92, mix: 0.6 do
    with_fx :echo, phase: 1, decay: 6, mix: 0.4 do
      sample :ambi_haunted_hum, amp: 0.35 * v, rate: 0.7
    end
  end
end

define :fx_choir do |v=1|
  with_fx :reverb, room: 0.95, mix: 0.7 do
    with_fx :lpf, cutoff: 90 do
      sample :ambi_choir, amp: 0.4 * v, rate: 0.8
    end
  end
end

define :fx_lunar do |v=1|
  with_fx :reverb, room: 1, mix: 0.75 do
    with_fx :echo, phase: 1.5, decay: 8, mix: 0.5 do
      sample :ambi_lunar_land, amp: 0.45 * v, rate: 0.6
    end
  end
end

define :fx_glass do |v=1|
  with_fx :reverb, room: 0.88, mix: 0.55 do
    sample :ambi_glass_hum, amp: 0.35 * v, rate: 0.9
  end
end

# Riser for builds
define :fx_riser do |dur, v=1|
  use_synth :noise
  play :c4, amp: 0.38 * v, attack: dur * 0.95, release: dur * 0.05, cutoff: 55, cutoff_slide: dur * 0.9
  sleep 0.1
  control cutoff: 105
end

# Downlifter for drops
define :fx_down do |dur, v=1|
  use_synth :noise
  play :c4, amp: 0.32 * v, attack: 0.01, release: dur, cutoff: 105, cutoff_slide: dur * 0.85
  sleep 0.1
  control cutoff: 40
end

# ═══════════════════════════════════════════════════════════════════════════════
# PATTERNS
# ═══════════════════════════════════════════════════════════════════════════════

# --- DRUM PATTERNS ---

define :drums_basic do |k=1, s=1, h=1|
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

define :drums_groove do |k=1, s=1, h=1|
  in_thread do
    4.times { kick k; sleep 1 }
  end
  in_thread do
    sleep 1; snare s; sleep 1; snare s; clap s * 0.3; sleep 2
  end
  in_thread do
    hat h; sleep 0.5
    hat h * 0.55; sleep 0.5
    hat h * 0.75; sleep 0.5
    hat_open h * 0.5; sleep 0.5
    hat h; sleep 0.5
    hat h * 0.6; sleep 0.5
    hat h * 0.8; sleep 0.5
    hat h * 0.5; sleep 0.5
  end
  sleep 4
end

define :drums_variation do |k=1, s=1, h=1|
  in_thread do
    kick k; sleep 1
    kick k; sleep 1
    kick k; sleep 0.75
    kick k * 0.6; sleep 0.25
    kick k; sleep 1
  end
  in_thread do
    sleep 1; snare s; sleep 1; snare s; sleep 2
  end
  in_thread do
    8.times do |i|
      hat h * [1, 0.5, 0.7, 0.55, 0.9, 0.5, 0.75, 0.6][i]
      sleep 0.5
    end
  end
  sleep 4
end

# NEW: Stripped back - kick and snare only
define :drums_stripped do |k=1, s=1|
  in_thread do
    4.times { kick k; sleep 1 }
  end
  in_thread do
    sleep 1; snare s; sleep 1; snare s; sleep 2
  end
  sleep 4
end

# NEW: Buildup with snare rolls
define :drums_buildup do |k=1, s=1, h=1|
  in_thread do
    kick k; sleep 1
    kick k; sleep 1
    kick k; sleep 0.5
    kick k * 0.7; sleep 0.5
    kick k; sleep 0.5
    kick k * 0.8; sleep 0.5
  end
  in_thread do
    sleep 1; snare s * 0.7; sleep 0.5
    snare s * 0.5; sleep 0.5
    snare s * 0.8; sleep 0.5
    snare s * 0.6; sleep 0.5
    snare s * 0.9; sleep 0.25
    snare s * 0.7; sleep 0.25
    snare s; sleep 0.5
  end
  in_thread do
    8.times do |i|
      hat h * (0.4 + i * 0.08)
      sleep 0.5
    end
  end
  sleep 4
end

# NEW: Double time hats - energy boost
define :drums_double do |k=1, s=1, h=1|
  in_thread do
    4.times { kick k; sleep 1 }
  end
  in_thread do
    sleep 1; snare s; clap s * 0.25; sleep 1; snare s; sleep 2
  end
  in_thread do
    16.times do |i|
      hat h * [0.9, 0.4, 0.6, 0.35, 0.85, 0.4, 0.55, 0.35,
               0.9, 0.4, 0.65, 0.38, 0.88, 0.42, 0.6, 0.4][i]
      sleep 0.25
    end
  end
  sleep 4
end

# NEW: Breakdown - hats only, soft
define :drums_minimal do |h=1|
  in_thread do
    8.times do |i|
      hat h * [0.4, 0.25, 0.35, 0.2, 0.38, 0.22, 0.32, 0.18][i]
      sleep 0.5
    end
  end
  sleep 4
end

# NEW: Drop hit - big impact moment
define :drums_drop_hit do |k=1, s=1|
  kick k * 1.3
  snare s * 0.8
  clap s * 0.5
  sample :drum_splash_hard, amp: 0.6, rate: 0.7
end

# --- ARPS (C minor: C Eb G, chords: Ab, Bb) ---

# i chord - C minor
define :arp1 do |v=1|
  [:c4, :eb4, :g4, :c5, :g4, :eb4, :c4, :g3].each do |n|
    arp n, v
    sleep 0.5
  end
end

# VI chord - Ab major
define :arp2 do |v=1|
  [:ab3, :c4, :eb4, :ab4, :eb4, :c4, :ab3, :eb3].each do |n|
    arp n, v
    sleep 0.5
  end
end

# VII chord - Bb major with rhythm variation
define :arp3 do |v=1|
  arp :bb3, v; sleep 0.5
  arp :d4, v * 0.8; sleep 0.25
  arp :f4, v; sleep 0.25
  arp :bb4, v; sleep 0.5
  arp :f4, v * 0.9; sleep 0.5
  sleep 0.25
  arp :d4, v * 0.75; sleep 0.25
  arp :bb3, v; sleep 0.5
  arp :f3, v * 0.85; sleep 0.5
end

# High shimmer
define :arp_high do |v=1|
  [:c5, :eb5, :g5, :c6, :g5, :eb5, :c5, :g4].each do |n|
    arp n, v * 0.65
    sleep 0.5
  end
end

# NEW: Syncopated arp - offbeat accents
define :arp_sync do |v=1|
  sleep 0.25
  arp :c4, v; sleep 0.25
  arp :eb4, v * 0.7; sleep 0.5
  arp :g4, v; sleep 0.25
  arp :c5, v * 0.9; sleep 0.25
  sleep 0.25
  arp :g4, v * 0.8; sleep 0.25
  arp :eb4, v; sleep 0.5
  arp :c4, v * 0.75; sleep 0.5
  arp :g3, v * 0.85; sleep 0.5
end

# NEW: Fast 16th arp - energy builder
define :arp_16th do |v=1|
  [:c4, :eb4, :g4, :c5, :eb4, :g4, :c5, :g4,
   :eb4, :c4, :g3, :c4, :eb4, :g4, :eb4, :c4].each do |n|
    arp n, v * 0.8
    sleep 0.25
  end
end

# NEW: Sparse arp - breathing room
define :arp_sparse do |v=1|
  arp :c4, v; sleep 1
  arp :g4, v * 0.85; sleep 0.5
  sleep 0.5
  arp :eb4, v * 0.9; sleep 1
  arp :c4, v * 0.75; sleep 1
end

# NEW: Minor 2nd tension arp (Db for color)
define :arp_tension do |v=1|
  arp :c4, v; sleep 0.5
  arp :db4, v * 0.7; sleep 0.25  # tension!
  arp :c4, v * 0.8; sleep 0.25
  arp :eb4, v; sleep 0.5
  arp :g4, v * 0.9; sleep 0.5
  arp :ab4, v * 0.75; sleep 0.5  # borrowed from Ab
  arp :g4, v; sleep 0.5
  arp :eb4, v * 0.8; sleep 0.5
end

# --- BASSLINES (C minor groove) ---

define :bassline do |v=1, c=75|
  bass :c2, v, c; sleep 0.75
  bass :c2, v * 0.5, c - 8; sleep 0.25
  bass :c2, v * 0.8, c; sleep 0.5
  bass :eb2, v * 0.7, c; sleep 0.5
  bass :g1, v * 0.9, c + 3; sleep 0.5
  bass :g1, v * 0.5, c - 5; sleep 0.5
  bass :c2, v, c; sleep 1
end

define :bassline2 do |v=1, c=75|
  bass :c2, v, c; sleep 0.5
  bass :eb2, v * 0.7, c; sleep 0.5
  bass :f2, v * 0.8, c + 3; sleep 0.5
  sleep 0.25
  bass :g2, v * 0.65, c; sleep 0.25
  bass :f2, v * 0.75, c; sleep 0.5
  bass :eb2, v * 0.7, c - 3; sleep 0.5
  bass :c2, v * 0.9, c; sleep 1
end

# NEW: Octave jump bass - more movement
define :bassline3 do |v=1, c=75|
  bass :c2, v, c; sleep 0.5
  bass :c3, v * 0.6, c + 5; sleep 0.25  # octave up!
  bass :c2, v * 0.7, c; sleep 0.25
  bass :eb2, v * 0.85, c; sleep 0.5
  bass :g1, v, c + 3; sleep 0.5
  bass :g2, v * 0.55, c; sleep 0.25     # octave up!
  bass :g1, v * 0.75, c; sleep 0.25
  bass :c2, v * 0.9, c; sleep 1
end

# NEW: Driving 16th bass - energy
define :bassline_drive do |v=1, c=78|
  bass :c2, v, c; sleep 0.25
  bass :c2, v * 0.5, c - 10; sleep 0.25
  bass :c2, v * 0.7, c - 5; sleep 0.25
  bass :c2, v * 0.55, c - 8; sleep 0.25
  bass :eb2, v * 0.85, c; sleep 0.5
  bass :g1, v, c + 3; sleep 0.5
  bass :ab1, v * 0.8, c; sleep 0.5      # Ab for color
  bass :g1, v * 0.7, c - 3; sleep 0.5
  bass :c2, v * 0.9, c; sleep 0.5
end

# NEW: Sparse bass - breakdown feel
define :bassline_sparse do |v=1, c=70|
  bass :c2, v, c; sleep 1.5
  sleep 0.5
  bass :g1, v * 0.8, c; sleep 1
  sleep 1
end

# NEW: Walking bass - melodic movement
define :bassline_walk do |v=1, c=75|
  bass :c2, v, c; sleep 0.5
  bass :d2, v * 0.7, c; sleep 0.5
  bass :eb2, v * 0.8, c; sleep 0.5
  bass :f2, v * 0.75, c + 3; sleep 0.5
  bass :g2, v * 0.9, c + 5; sleep 0.5
  bass :f2, v * 0.7, c; sleep 0.5
  bass :eb2, v * 0.75, c; sleep 0.5
  bass :c2, v * 0.85, c; sleep 0.5
end

# ═══════════════════════════════════════════════════════════════════════════════
# MELODIC PHRASES - Syncopated, strong chord tones, octave jumps, call/response
# Harmony: Cm / Ab / Bb
# Strong tones: G, Eb over Cm | C, Eb over Ab | D, F over Bb | B natural for tension
# ═══════════════════════════════════════════════════════════════════════════════

# --- CALL/RESPONSE PAIR 1 (over Cm) ---
# Call: syncopated, hits G and Eb, has a "tag" (G-Eb motif)
define :mel_call1 do |v=1|
  sleep 0.25                        # start on "&"
  lead :g4, 0.25, v; sleep 0.25     # 5th - confident
  lead :eb4, 0.25, v * 0.9; sleep 0.25  # tag start
  lead :g4, 0.5, v; sleep 0.5       # tag repeat
  sleep 0.25
  lead :eb5, 0.5, v * 1.1; sleep 0.5  # octave jump up!
  lead :d5, 0.25, v * 0.85; sleep 0.25
  lead :c5, 0.5, v; sleep 0.75
end

# Response: answers, resolves higher, uses B natural leading tone
define :mel_resp1 do |v=1|
  sleep 0.5
  lead :g5, 0.5, v * 1.1; sleep 0.5   # high 5th - strong
  lead :eb5, 0.25, v * 0.9; sleep 0.25
  lead :d5, 0.25, v * 0.85; sleep 0.25
  lead :b4, 0.25, v * 0.95; sleep 0.25  # B natural! leading tone tension
  lead :c5, 0.75, v; sleep 1          # resolves to C
  sleep 0.5
end

# --- CALL/RESPONSE PAIR 2 (over Ab / Bb) ---
# Call: targets C and Eb over Ab, syncopated
define :mel_call2 do |v=1|
  lead :c5, 0.25, v; sleep 0.25     # offbeat start
  lead :c5, 0.25, v * 0.7; sleep 0.5  # rhythmic repeat
  lead :eb5, 0.5, v; sleep 0.5
  sleep 0.25
  lead :c5, 0.25, v * 0.8; sleep 0.25  # tag
  lead :eb5, 0.25, v * 0.9; sleep 0.25
  lead :c6, 0.5, v * 1.1; sleep 0.75   # octave jump!
end

# Response: targets D and F over Bb, resolves
define :mel_resp2 do |v=1|
  sleep 0.25
  lead :f5, 0.5, v; sleep 0.5       # F over Bb - strong
  lead :d5, 0.25, v * 0.9; sleep 0.25
  lead :f5, 0.25, v * 0.85; sleep 0.25  # tag (F-D)
  lead :d5, 0.25, v * 0.8; sleep 0.5
  lead :bb4, 0.5, v; sleep 0.5
  lead :g4, 0.75, v * 0.9; sleep 1    # resolve to G (5th of Cm)
end

# --- HOOK - the memorable 2-bar motif ---
# Rhythmic, uses octave jump, repeating tag
define :mel_hook do |v=1|
  # Bar 1: the hook
  sleep 0.25
  lead :g4, 0.25, v; sleep 0.25       # "&" of 1
  lead :g4, 0.25, v * 0.7; sleep 0.25
  lead :eb4, 0.25, v * 0.9; sleep 0.25
  lead :g4, 0.5, v; sleep 0.5
  lead :g5, 0.5, v * 1.15; sleep 0.5  # octave jump!
  lead :eb5, 0.25, v * 0.9; sleep 0.25
  lead :d5, 0.25, v * 0.85; sleep 0.25

  # Bar 2: resolution with tension
  lead :c5, 0.5, v; sleep 0.5
  lead :b4, 0.25, v * 0.9; sleep 0.25   # B natural - tension!
  lead :c5, 0.25, v; sleep 0.5
  sleep 0.25
  lead :g4, 0.5, v * 0.85; sleep 0.5
  lead :eb4, 0.25, v * 0.8; sleep 0.25
  lead :g4, 0.75, v; sleep 0.75
end

# --- BREAKDOWN melody - spacey but still strong ---
define :mel_break do |v=1|
  lead :g4, 1, v; sleep 1
  sleep 0.5
  lead :eb5, 0.75, v * 0.9; sleep 0.75
  lead :d5, 0.5, v * 0.85; sleep 0.5
  lead :c5, 1.25, v; sleep 1.25
end

# --- STAB PATTERNS ---

define :stabs1 do |v=1|
  stab [:c4, :g4], v; sleep 0.75
  sleep 0.25
  stab [:c4, :g4], v * 0.6; sleep 0.5
  stab [:eb4, :bb4], v * 0.85; sleep 1
  stab [:f4, :c5], v * 0.9; sleep 0.75
  stab [:eb4, :bb4], v * 0.7; sleep 0.75
end

define :stabs2 do |v=1|
  stab [:ab3, :eb4], v; sleep 0.5
  sleep 0.5
  stab [:bb3, :f4], v * 0.85; sleep 0.75
  stab [:bb3, :f4], v * 0.55; sleep 0.25
  stab [:c4, :g4], v; sleep 1
  sleep 1
end

# ═══════════════════════════════════════════════════════════════════════════════
# ARRANGEMENT (~5 minutes)
# ═══════════════════════════════════════════════════════════════════════════════

# ─────────────────────────────────────────────────────────────────────────────
# INTRO: 32 beats - Arps only, big space + atmospheric samples
# ─────────────────────────────────────────────────────────────────────────────

# Atmospheric bed
in_thread do
  fx_lunar 0.6
  sleep 16
  fx_drone 0.5
end

in_thread do
  with_fx :reverb, room: 0.92, mix: 0.65 do
    with_fx :echo, phase: 0.75, decay: 8, mix: 0.55 do
      pad [:c3, :g3, :c4], 0.4
      sleep 16
      pad [:ab2, :eb3, :ab3], 0.35
    end
  end
end

in_thread do
  with_fx :reverb, room: 0.85, mix: 0.6 do
    with_fx :echo, phase: 0.5, decay: 6, mix: 0.5 do
      4.times do
        arp1 0.45
        arp2 0.4
      end
    end
  end
end

# Transition swoosh before drop
in_thread do
  sleep 28
  fx_swoosh 0.7
end

sleep 32

# ─────────────────────────────────────────────────────────────────────────────
# FIRST DROP: 32 beats - Drums + bass with LPF sweep, dramatic entry
# ─────────────────────────────────────────────────────────────────────────────

hit 1.2
drums_drop_hit 1.1, 0.9
fx_woosh 0.8

in_thread do
  with_fx :lpf, cutoff: 70, cutoff_slide: 28 do |lpf|
    control lpf, cutoff: 115
    # Start stripped, build to full
    4.times { drums_stripped 0.8, 0.7 }
    4.times { drums_basic 0.9, 0.8, 0.65 }
  end
end

in_thread do
  with_fx :lpf, cutoff: 60, cutoff_slide: 28 do |lpf|
    control lpf, cutoff: 88
    8.times { bassline 0.8, 70 }
  end
end

in_thread do
  with_fx :reverb, room: 0.7, mix: 0.45 do
    with_fx :echo, phase: 0.5, decay: 5, mix: 0.4 do
      4.times { arp1 0.55; arp2 0.5 }
    end
  end
end

sleep 32

# ─────────────────────────────────────────────────────────────────────────────
# MAIN SECTION A: 48 beats - Full groove with arp variations
# ─────────────────────────────────────────────────────────────────────────────

hit 1.2
fx_swoosh 0.6

in_thread do
  8.times { drums_groove 1, 0.9, 0.7 }
  4.times { drums_double 1.05, 0.95, 0.75 }  # energy boost at end
end

in_thread do
  4.times { bassline 0.95, 78; bassline2 0.9, 76 }
  4.times { bassline3 0.95, 78 }
end

in_thread do
  with_fx :reverb, room: 0.6, mix: 0.38 do
    with_fx :echo, phase: 0.5, decay: 4, mix: 0.35 do
      4.times { arp1 0.62; arp3 0.58 }
      2.times { arp_sync 0.6; arp2 0.55 }
    end
  end
end

# High arps enter later
in_thread do
  with_fx :reverb, room: 0.7, mix: 0.45 do
    with_fx :echo, phase: 0.75, decay: 5, mix: 0.42 do
      sleep 16
      4.times { arp_high 0.5 }
    end
  end
end

in_thread do
  with_fx :reverb, room: 0.75, mix: 0.4 do
    pad [:c3, :g3, :c4], 0.28
    sleep 24
    pad [:ab2, :eb3, :c4], 0.25
  end
end

# Transition sample before next section
in_thread do
  sleep 44
  fx_glass 0.5
end

sleep 48

# ─────────────────────────────────────────────────────────────────────────────
# ENERGY SECTION: 32 beats - 16th arps and driving bass
# ─────────────────────────────────────────────────────────────────────────────

in_thread do
  4.times { drums_groove 1.05, 0.95, 0.72 }
  4.times { drums_double 1.1, 1, 0.8 }  # double time energy
end

in_thread do
  4.times { bassline_drive 1, 80; bassline3 0.95, 78 }
end

in_thread do
  with_fx :reverb, room: 0.55, mix: 0.35 do
    with_fx :echo, phase: 0.5, decay: 3.5, mix: 0.32 do
      4.times { arp_16th 0.65 }
    end
  end
end

in_thread do
  with_fx :reverb, room: 0.6, mix: 0.4 do
    with_fx :echo, phase: 0.75, decay: 4, mix: 0.38 do
      sleep 16
      2.times { arp_high 0.55; arp_tension 0.5 }
    end
  end
end

sleep 32

# ─────────────────────────────────────────────────────────────────────────────
# STAB SECTION: 24 beats - Stabs + syncopated arps
# ─────────────────────────────────────────────────────────────────────────────

fx_swoosh 0.5

in_thread do
  6.times { drums_variation 0.95, 0.85, 0.7 }
end

in_thread do
  3.times { bassline2 0.9, 80; bassline_walk 0.85, 78 }
end

in_thread do
  with_fx :reverb, room: 0.55, mix: 0.35 do
    with_fx :echo, phase: 0.5, decay: 3.5, mix: 0.38 do
      6.times { stabs1 0.75; stabs2 0.7 }
    end
  end
end

in_thread do
  with_fx :reverb, room: 0.6, mix: 0.4 do
    3.times { arp_sync 0.55; arp_tension 0.5 }
  end
end

sleep 24

# ─────────────────────────────────────────────────────────────────────────────
# BREAKDOWN: 24 beats - Space with sparse patterns + atmosphere
# ─────────────────────────────────────────────────────────────────────────────

# Atmospheric bed
in_thread do
  fx_haunted 0.5
  sleep 12
  fx_choir 0.4
end

with_fx :reverb, room: 0.9, mix: 0.6 do
  with_fx :echo, phase: 1, decay: 8, mix: 0.55 do

    in_thread do
      pad [:c3, :g3, :c4, :eb4], 0.38
      sleep 12
      pad [:bb2, :f3, :bb3, :d4], 0.35
    end

    in_thread do
      3.times { arp_sparse 0.45; arp_sparse 0.4 }
    end

    in_thread do
      6.times { bassline_sparse 0.5, 68 }
    end

    in_thread do
      6.times { drums_minimal 0.35 }
    end

  end
end

sleep 24

# ─────────────────────────────────────────────────────────────────────────────
# BUILD: 16 beats - Energy rises with riser + buildup drums
# ─────────────────────────────────────────────────────────────────────────────

in_thread do
  2.times { drums_basic 0.75, 0.65, 0.55 }
  2.times { drums_buildup 0.9, 0.8, 0.7 }
end

in_thread do
  with_fx :lpf, cutoff: 65, cutoff_slide: 14 do |lpf|
    control lpf, cutoff: 95
    4.times { bassline 0.75, 68 }
  end
end

in_thread do
  with_fx :reverb, room: 0.6, mix: 0.4 do
    2.times { arp_tension 0.58; arp_high 0.52 }
  end
end

# Riser
in_thread do
  fx_riser 15, 0.9
end

# Woosh before drop
in_thread do
  sleep 14
  fx_woosh 0.7
end

sleep 16

# BIG DROP
hit 1.8
drums_drop_hit 1.3, 1.1
fx_down 2, 0.6

# ─────────────────────────────────────────────────────────────────────────────
# MAIN SECTION B: 48 beats - Peak energy with all variations
# ─────────────────────────────────────────────────────────────────────────────

in_thread do
  4.times { drums_groove 1.1, 1, 0.78 }
  4.times { drums_double 1.15, 1.05, 0.82 }
  4.times { drums_variation 1.1, 1, 0.8 }
end

in_thread do
  4.times { bassline_drive 1.05, 82; bassline3 1, 80 }
  4.times { bassline 1, 80 }
end

in_thread do
  with_fx :reverb, room: 0.55, mix: 0.35 do
    with_fx :echo, phase: 0.5, decay: 3.5, mix: 0.32 do
      3.times { arp_16th 0.7 }
      3.times { arp1 0.65; arp3 0.62 }
    end
  end
end

in_thread do
  with_fx :reverb, room: 0.5, mix: 0.32 do
    with_fx :echo, phase: 0.5, decay: 3, mix: 0.3 do
      sleep 16
      4.times { arp_high 0.58 }
    end
  end
end

in_thread do
  with_fx :reverb, room: 0.6, mix: 0.35 do
    sleep 24
    3.times { stabs1 0.65 }
  end
end

in_thread do
  with_fx :reverb, room: 0.7, mix: 0.38 do
    pad [:c3, :g3, :c4], 0.3
    sleep 24
    pad [:ab2, :eb3, :ab3], 0.28
  end
end

# Transition
in_thread do
  sleep 44
  fx_glass 0.45
end

sleep 48

# ─────────────────────────────────────────────────────────────────────────────
# STAB CLIMAX: 16 beats - Maximum stab + 16th arp energy
# ─────────────────────────────────────────────────────────────────────────────

hit 1.0
fx_swoosh 0.5

in_thread do
  2.times { drums_double 1.15, 1.05, 0.85 }
  2.times { drums_variation 1.1, 1, 0.8 }
end

in_thread do
  2.times { bassline_drive 1.05, 85; bassline3 1, 82 }
end

in_thread do
  with_fx :reverb, room: 0.5, mix: 0.32 do
    with_fx :echo, phase: 0.5, decay: 3, mix: 0.35 do
      4.times { stabs1 0.85; stabs2 0.8 }
    end
  end
end

in_thread do
  with_fx :reverb, room: 0.55, mix: 0.35 do
    2.times { arp_16th 0.7 }
  end
end

sleep 16

# ─────────────────────────────────────────────────────────────────────────────
# OUTRO: 32 beats - Gradual fade with atmosphere
# ─────────────────────────────────────────────────────────────────────────────

hit 1.0
fx_down 4, 0.5

# Atmospheric return
in_thread do
  sleep 8
  fx_drone 0.4
  sleep 12
  fx_lunar 0.35
end

in_thread do
  4.times { drums_groove (1 - 0.1), (0.9 - 0.08), (0.75 - 0.06) }
  4.times { drums_minimal (0.4 - 0.05) }
end

in_thread do
  with_fx :lpf, cutoff: 85, cutoff_slide: 28 do |lpf|
    control lpf, cutoff: 55
    4.times do |i|
      bassline_sparse (0.7 - i * 0.12), (75 - i * 5)
    end
  end
end

in_thread do
  with_fx :reverb, room: 0.88, mix: 0.6 do
    with_fx :echo, phase: 0.75, decay: 8, mix: 0.55 do
      4.times do |i|
        arp_sparse (0.5 - i * 0.08)
        arp2 (0.45 - i * 0.08)
      end
    end
  end
end

in_thread do
  sleep 16
  with_fx :reverb, room: 0.95, mix: 0.7 do
    with_fx :echo, phase: 1.5, decay: 10, mix: 0.55 do
      pad [:c3, :g3, :c4], 0.35
    end
  end
end

sleep 32

# ═══════════════════════════════════════════════════════════════════════════════
# END
# ═══════════════════════════════════════════════════════════════════════════════