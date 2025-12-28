# ═══════════════════════════════════════════════════════════════════════════
# Modem Handshake
# ═══════════════════════════════════════════════════════════════════════════
# 5:00 | 128 BPM | D minor | Synthwave/Dark Electronic
#
# Structure:
#   0:00-0:45   INTRO (Digital atmosphere, modem sounds)
#   0:45-1:30   BUILD 1 (Tension rising)
#   1:30-2:15   DROP 1 (First peak)
#   2:15-3:00   BREAKDOWN (Melodic variation)
#   3:00-3:30   BUILD 2 (Maximum tension)
#   3:30-4:15   DROP 2 (Main peak - full power)
#   4:15-5:00   OUTRO (Deconstruction)
# ═══════════════════════════════════════════════════════════════════════════

use_bpm 128

# Section boundaries (in beats)
INTRO_END = 96        # 0:45
BUILD1_END = 192      # 1:30
DROP1_END = 288       # 2:15
BREAKDOWN_END = 384   # 3:00
BUILD2_END = 448      # 3:30
DROP2_END = 544       # 4:15
TRACK_END = 640       # 5:00

# Helper function to get current section based on beat count
define :get_section do |beat|
  if beat >= DROP2_END
    :outro
  elsif beat >= BUILD2_END
    :drop2
  elsif beat >= BREAKDOWN_END
    :build2
  elsif beat >= DROP1_END
    :breakdown
  elsif beat >= BUILD1_END
    :drop1
  elsif beat >= INTRO_END
    :build1
  else
    :intro
  end
end

# Helper for intensity (0.0 to 1.0)
define :get_intensity do |beat|
  section = get_section(beat)
  case section
  when :intro
    beat.to_f / INTRO_END * 0.1
  when :build1
    0.1 + ((beat - INTRO_END).to_f / (BUILD1_END - INTRO_END) * 0.6)
  when :drop1
    0.85
  when :breakdown
    0.8 - ((beat - DROP1_END).to_f / (BREAKDOWN_END - DROP1_END) * 0.5)
  when :build2
    0.3 + ((beat - BREAKDOWN_END).to_f / (BUILD2_END - BREAKDOWN_END) * 0.65)
  when :drop2
    1.0
  when :outro
    1.0 - ((beat - DROP2_END).to_f / (TRACK_END - DROP2_END))
  else
    0.5
  end
end

# ═══════════════════════════════════════════════════════════════════════════
# MASTER CLOCK - Everything syncs to this
# ═══════════════════════════════════════════════════════════════════════════
live_loop :master do
  cue :tick
  sleep 0.25
end

# Section announcer
live_loop :announcer do
  sync :tick
  beat = tick(:announce)

  case beat
  when 0
    puts "═══════════════════════════════════════════"
    puts ">>> MIDNIGHT PROTOCOL II — STARTING"
    puts ">>> 0:00 — INTRO: System infiltration..."
  when INTRO_END
    puts ">>> 0:45 — BUILD 1: Access granted..."
  when BUILD1_END
    puts ">>> 1:30 — DROP 1: First contact!"
  when DROP1_END
    puts ">>> 2:15 — BREAKDOWN: Deeper into the system..."
  when BREAKDOWN_END
    puts ">>> 3:00 — BUILD 2: Final approach..."
  when BUILD2_END
    puts ">>> 3:30 — DROP 2: FULL SYSTEM OVERRIDE!"
  when DROP2_END
    puts ">>> 4:15 — OUTRO: Disconnection..."
  when TRACK_END
    puts ">>> 5:00 — END TRANSMISSION"
    puts "═══════════════════════════════════════════"
    stop
  end
  sleep 0.75  # Complete the beat
end

# ═══════════════════════════════════════════════════════════════════════════
# MODEM/DIGITAL ARTIFACTS
# ═══════════════════════════════════════════════════════════════════════════
live_loop :modem_sounds do
  sync :tick
  beat = tick(:modem)
  section = get_section(beat)

  if section == :intro || section == :outro
    if one_in(3)
      with_fx :bitcrusher, bits: rrand_i(4, 8), sample_rate: rrand(3000, 8000) do
        with_fx :echo, phase: 0.125, decay: 2, mix: 0.4 do
          use_synth :cnoise
          play :c4, release: rrand(0.05, 0.15), amp: rrand(0.08, 0.15), cutoff: rrand(80, 110)
        end
      end
    end
  end

  sleep 0.75
  stop if beat >= TRACK_END
end

# Digital glitches
live_loop :glitches do
  sync :tick
  beat = tick(:glitch)
  section = get_section(beat)

  if [:intro, :outro, :breakdown].include?(section) && one_in(8)
    with_fx :bitcrusher, bits: 6, sample_rate: 6000 do
      with_fx :pan, pan: rrand(-0.8, 0.8) do
        sample :elec_blip, rate: rrand(0.5, 2), amp: 0.12
      end
    end
  end

  sleep 0.75
  stop if beat >= TRACK_END
end

# ═══════════════════════════════════════════════════════════════════════════
# MS-20 STYLE DRONE
# ═══════════════════════════════════════════════════════════════════════════
live_loop :ms20_drone do
  beat = tick(:drone) * 8
  section = get_section(beat)
  intensity = get_intensity(beat)

  stop if beat >= TRACK_END

  use_synth :dark_ambience
  cutoff_val = 40 + (intensity * 60)
  root = (section == :breakdown) ? :f1 : :d1

  with_fx :lpf, cutoff: cutoff_val do
    with_fx :distortion, distort: 0.15 + (intensity * 0.15), mix: 0.25 do
      with_fx :reverb, room: 0.8, mix: 0.5 do
        play root, amp: 0.35 + (intensity * 0.25), attack: 2, sustain: 4, release: 2
      end
    end
  end
  sleep 8
end

# ═══════════════════════════════════════════════════════════════════════════
# ACID BASS (TB-303 / Nubass style)
# ═══════════════════════════════════════════════════════════════════════════
live_loop :acid_bass do
  sync :tick
  beat = tick(:bass)
  section = get_section(beat)
  intensity = get_intensity(beat)

  stop if beat >= TRACK_END

  if [:build1, :drop1, :build2, :drop2].include?(section)
    use_synth :tb303

    patterns = {
      build1: (ring :d2, :r, :d2, :r, :d2, :d2, :r, :a1),
      drop1: (ring :d2, :d2, :a1, :d2, :g1, :d2, :a1, :c2),
      build2: (ring :d2, :d2, :d2, :a1, :g1, :g1, :a1, :d2),
      drop2: (ring :d2, :d3, :a1, :d2, :g1, :a1, :d2, :f2)
    }

    pattern = patterns[section] || patterns[:drop1]
    note = pattern.tick(:bass_note)

    if note != :r
      with_fx :distortion, distort: intensity * 0.25, mix: 0.3 do
        play note,
             release: 0.2,
             cutoff: 60 + (intensity * 45) + rrand(-8, 8),
             res: 0.7 + (intensity * 0.2),
             wave: 0,
             amp: 0.45 + (intensity * 0.25)
      end
    end
  end

  sleep 0.75
end

# ═══════════════════════════════════════════════════════════════════════════
# SYNTH PAD (Minilogue XD style)
# ═══════════════════════════════════════════════════════════════════════════
live_loop :synth_pad do
  beat = tick(:pad) * 4
  section = get_section(beat)
  intensity = get_intensity(beat)

  stop if beat >= TRACK_END

  use_synth :hollow

  # Note: Sonic Pi doesn't have :minor9, so we build it manually: minor7 + 9th
  dm9 = (ring :d3, :f3, :a3, :c4, :e4)  # D minor 9
  gm7 = (chord :g3, :minor7)
  cmaj7 = (chord :c3, :major7)
  am7 = (chord :a2, :minor7)

  chord_map = {
    intro: (chord :d3, :minor7),
    build1: (chord :d3, :minor7),
    drop1: [(chord :d3, :minor7), (chord :g3, :minor), (chord :a2, :sus4), (chord :d3, :minor)].ring.tick(:d1),
    breakdown: [(chord :f3, :minor7), (chord :c3, :major7), (chord :bb2, :major), (chord :f3, :minor)].ring.tick(:bd),
    build2: dm9,
    drop2: [dm9, gm7, cmaj7, am7].ring.tick(:d2),
    outro: (chord :d3, :minor7)
  }

  chord_to_play = chord_map[section] || (chord :d3, :minor7)

  with_fx :lpf, cutoff: 50 + (intensity * 50) do
    with_fx :reverb, room: 0.85, mix: 0.55 do
      play chord_to_play,
           amp: 0.2 + (intensity * 0.12),
           attack: 1,
           sustain: 2,
           release: 1
    end
  end
  sleep 4
end

# ═══════════════════════════════════════════════════════════════════════════
# LEAD MELODY (Synthwave Prophet style)
# ═══════════════════════════════════════════════════════════════════════════
main_melody = (ring :d5, :f5, :a5, :g5, :f5, :e5, :d5, :c5,
                    :d5, :e5, :f5, :a5, :g5, :f5, :e5, :d5)

breakdown_melody = (ring :f5, :ab5, :c6, :bb5, :ab5, :g5, :f5, :eb5,
                         :f5, :g5, :ab5, :c6, :bb5, :ab5, :g5, :f5)

melody_high = (ring :d6, :f6, :a6, :g6, :f6, :e6, :d6, :c6,
                    :d6, :e6, :f6, :a6, :g6, :f6, :e6, :d6)

live_loop :lead_synth do
  sync :tick
  beat = tick(:lead)
  section = get_section(beat)
  intensity = get_intensity(beat)

  stop if beat >= TRACK_END

  if [:drop1, :breakdown, :drop2].include?(section) && (beat % 2 == 0)
    use_synth :prophet

    melody = case section
             when :drop1 then main_melody
             when :breakdown then breakdown_melody
             when :drop2 then (tick(:alt) % 16 < 8) ? main_melody : melody_high
             else main_melody
             end

    note = melody.tick(:lead_note)

    with_fx :reverb, room: 0.5, mix: 0.3 do
      with_fx :flanger, mix: 0.15, depth: 3, delay: 5 do
        play note,
             release: 0.3,
             cutoff: 75 + (intensity * 25),
             amp: 0.3 + (intensity * 0.15)
      end
    end
  end

  sleep 0.75
end

# ═══════════════════════════════════════════════════════════════════════════
# ARPEGGIO
# ═══════════════════════════════════════════════════════════════════════════
live_loop :arpeggio do
  sync :tick
  beat = tick(:arp)
  section = get_section(beat)
  intensity = get_intensity(beat)

  stop if beat >= TRACK_END

  if [:build1, :drop1, :build2, :drop2].include?(section)
    use_synth :blade

    arp_notes = (section == :drop2) ?
                  (ring :d4, :f4, :a4, :d5, :a4, :f4, :d4, :a3) :
                  (ring :d4, :f4, :a4, :d5)

    note = arp_notes.tick(:arp_note)

    with_fx :echo, phase: 0.375, decay: 3, mix: 0.25 do
      play note,
           release: 0.12,
           amp: 0.12 + (intensity * 0.1),
           cutoff: 65 + (intensity * 20)
    end
  end

  sleep 0.75
end

# ═══════════════════════════════════════════════════════════════════════════
# KICK DRUM
# ═══════════════════════════════════════════════════════════════════════════
live_loop :kick do
  sync :tick
  beat = tick(:kick)
  section = get_section(beat)
  intensity = get_intensity(beat)

  stop if beat >= TRACK_END

  case section
  when :intro
    # Every 4 beats
    if beat % 16 == 0
      sample :bd_tek, amp: 0.6, cutoff: 80
    end
  when :build1, :build2
    # Four on the floor
    if beat % 4 == 0
      sample :bd_tek, amp: 0.9 + (intensity * 0.2), cutoff: 95 + (intensity * 15)
    end
  when :drop1, :drop2
    # Full power with occasional offbeat
    if beat % 4 == 0
      sample :bd_tek, amp: 1.1, cutoff: 110
    elsif beat % 4 == 2 && one_in(6)
      sample :bd_tek, amp: 0.5, cutoff: 75
    end
  when :breakdown
    # Half-time
    if beat % 8 == 0
      sample :bd_tek, amp: 0.65, cutoff: 70
    end
  when :outro
    if beat % 8 == 0
      sample :bd_tek, amp: 0.4 * intensity, cutoff: 65
    end
  end

  sleep 0.75
end

# ═══════════════════════════════════════════════════════════════════════════
# SNARE / CLAP
# ═══════════════════════════════════════════════════════════════════════════
live_loop :snare do
  sync :tick
  beat = tick(:snare)
  section = get_section(beat)
  intensity = get_intensity(beat)

  stop if beat >= TRACK_END

  # Snare on beats 2 and 4 (beats 4 and 12 in 16th note grid)
  if [:drop1, :drop2, :build2].include?(section)
    if beat % 16 == 4 || beat % 16 == 12
      with_fx :reverb, room: 0.4, mix: 0.3 do
        sample :sn_dolf, amp: 0.6 + (intensity * 0.25), cutoff: 100
      end
    end
  elsif section == :build1 && intensity > 0.4
    if beat % 16 == 4 || beat % 16 == 12
      sample :sn_dolf, amp: 0.4, cutoff: 85
    end
  end

  # Snare roll before drop 2
  if section == :build2 && beat >= (BUILD2_END - 16) && beat % 2 == 0
    sample :sn_dolf, amp: 0.25 + ((beat - (BUILD2_END - 16)) * 0.02), cutoff: 90, rate: 1.05
  end

  sleep 0.75
end

# ═══════════════════════════════════════════════════════════════════════════
# HI-HATS
# ═══════════════════════════════════════════════════════════════════════════
live_loop :hihats do
  sync :tick
  beat = tick(:hat)
  section = get_section(beat)
  intensity = get_intensity(beat)

  stop if beat >= TRACK_END

  case section
  when :intro
    if beat % 4 == 0 && one_in(2)
      sample :drum_cymbal_closed, amp: 0.12, rate: 1.2
    end
  when :build1
    if beat % 2 == 0
      sample :drum_cymbal_closed, amp: 0.18 + (intensity * 0.08), rate: 1.1
    end
  when :drop1, :drop2
    # 16th note pattern with accents
    amp_val = (beat % 4 == 0) ? 0.32 : 0.14
    sample :drum_cymbal_closed, amp: amp_val, rate: 1.15
    # Open hat occasionally
    if beat % 32 == 30
      sample :drum_cymbal_open, amp: 0.2, rate: 0.9, finish: 0.25
    end
  when :breakdown
    if beat % 4 == 0 && one_in(2)
      sample :drum_cymbal_pedal, amp: 0.12, rate: 1.4
    end
  when :build2
    if intensity > 0.6
      sample :drum_cymbal_closed, amp: 0.25, rate: 1.15
    elsif beat % 2 == 0
      sample :drum_cymbal_closed, amp: 0.2, rate: 1.1
    end
  when :outro
    if beat % 2 == 0
      sample :drum_cymbal_closed, amp: 0.12 * intensity, rate: 1.2
    end
  end

  sleep 0.75
end

# ═══════════════════════════════════════════════════════════════════════════
# PERCUSSION / FILLS
# ═══════════════════════════════════════════════════════════════════════════
live_loop :percussion do
  sync :tick
  beat = tick(:perc)
  section = get_section(beat)

  stop if beat >= TRACK_END

  if [:drop1, :drop2].include?(section)
    # Tom fill every 8 bars
    bar_position = beat % 128
    if bar_position >= 112 && bar_position < 128
      fill_pos = bar_position - 112
      if fill_pos % 4 == 0
        tom_sample = [:drum_tom_lo_hard, :drum_tom_mid_hard, :drum_tom_hi_hard, :drum_tom_hi_hard][fill_pos / 4]
        with_fx :reverb, room: 0.35, mix: 0.25 do
          sample tom_sample, amp: 0.35, rate: 0.95 + (fill_pos * 0.02)
        end
      end
    end
  end

  sleep 0.75
end

# ═══════════════════════════════════════════════════════════════════════════
# RISERS & IMPACTS
# ═══════════════════════════════════════════════════════════════════════════
live_loop :fx_riser do
  beat = tick(:riser) * 32
  section = get_section(beat)

  stop if beat >= TRACK_END

  # Riser before drops
  if beat == BUILD1_END - 32 || beat == BUILD2_END - 32
    with_fx :lpf, cutoff: 50, cutoff_slide: 8 do |fx|
      control fx, cutoff: 120
      with_fx :reverb, room: 0.85, mix: 0.5 do
        sample :ambi_swoosh, amp: 0.35, rate: 0.3
      end
    end
  end

  # Impact on drops
  if beat == BUILD1_END || beat == BUILD2_END
    with_fx :reverb, room: 0.6, mix: 0.35 do
      sample :bd_boom, amp: 0.5, rate: 0.5
      sample :drum_cymbal_hard, amp: 0.35, rate: 0.7
    end
  end

  sleep 32
end

# ═══════════════════════════════════════════════════════════════════════════
# ATMOSPHERE
# ═══════════════════════════════════════════════════════════════════════════
live_loop :atmosphere do
  beat = tick(:atmos) * 16
  intensity = get_intensity(beat)

  stop if beat >= TRACK_END

  with_fx :lpf, cutoff: 55 + (intensity * 35) do
    with_fx :reverb, room: 0.95, mix: 0.65 do
      sample :ambi_dark_woosh, amp: 0.08 + (intensity * 0.04), rate: 0.25
    end
  end

  sleep 16
end

# ═══════════════════════════════════════════════════════════════════════════
# RESONANT SWEEPS (MS-20 style)
# ═══════════════════════════════════════════════════════════════════════════
live_loop :resonance do
  beat = tick(:res) * 8
  section = get_section(beat)

  stop if beat >= TRACK_END

  if [:drop1, :drop2].include?(section) && one_in(3)
    use_synth :tb303
    with_fx :reverb, room: 0.5, mix: 0.35 do
      play :d2, amp: 0.15, release: 1.5, res: 0.8, wave: 1, cutoff: rrand(70, 100)
    end
  end

  sleep 8
end
