# Variables and Functions

Clean code makes complex music manageable. Functions are the building blocks of every track in this album.

## Why Functions?

Without functions, a drum pattern looks like this:

```ruby
sample :bd_tek, amp: 2, rate: 0.9
sample :bd_boom, amp: 0.5, rate: 1.2
sleep 1
sample :bd_tek, amp: 2, rate: 0.9
sample :bd_boom, amp: 0.5, rate: 1.2
sleep 1
# ... repeated dozens of times
```

With functions:

```ruby
define :kick do
  sample :bd_tek, amp: 2, rate: 0.9
  sample :bd_boom, amp: 0.5, rate: 1.2
end

kick; sleep 1
kick; sleep 1
# Much cleaner!
```

## Defining Functions

Basic syntax:

```ruby
define :function_name do
  # Code here
end
```

Then call it:

```ruby
function_name
```

### Example: Kick Drum

```ruby
define :kick do
  sample :bd_tek, amp: 2, rate: 0.9
end

# Use it
4.times do
  kick
  sleep 1
end
```

## Functions with Parameters

Parameters make functions flexible:

```ruby
define :kick do |volume|
  sample :bd_tek, amp: volume, rate: 0.9
end

kick 2      # Loud kick
kick 0.5    # Quiet kick
kick 1      # Normal kick
```

### Multiple Parameters

```ruby
define :kick do |volume, pitch|
  sample :bd_tek, amp: volume, rate: pitch
end

kick 2, 0.9    # Loud, slightly lower
kick 1, 1.2    # Normal volume, higher pitch
```

### Default Parameters

This is the pattern used throughout the album:

```ruby
define :kick do |v=1|
  sample :bd_tek, amp: 2*v, rate: 0.9
end

kick        # Uses default v=1, so amp = 2*1 = 2
kick 0.5    # v=0.5, so amp = 2*0.5 = 1
kick 1.2    # v=1.2, so amp = 2*1.2 = 2.4
```

The `v=1` means "if no value provided, use 1".

### Multiple Defaults

```ruby
define :bass do |n, v=1, c=80|
  use_synth :tb303
  play n, amp: v, cutoff: c
end

bass :d2           # note=D2, v=1, cutoff=80
bass :d2, 0.5      # note=D2, v=0.5, cutoff=80
bass :d2, 0.5, 60  # note=D2, v=0.5, cutoff=60
```

## The Sound Functions Pattern

Every track defines sound functions first:

```ruby
# SOUND DEFINITIONS
define :kick do |v=1|
  sample :bd_tek, amp: 2*v, rate: 0.9
  sample :bd_boom, amp: 0.5*v, rate: 1.2
end

define :snare do |v=1|
  sample :sn_dub, amp: v, rate: 0.85
end

define :hat do |v=1|
  sample :drum_cymbal_closed, amp: 0.3*v, rate: 2.2
end

define :bass do |n, v=1, c=80|
  use_synth :tb303
  play n, amp: 0.8*v, cutoff: c, res: 0.3
  use_synth :sine
  play n-12, amp: v
end
```

Then pattern functions:

```ruby
# PATTERN DEFINITIONS
define :drums do |k=1, s=1, h=1|
  # Uses the sound functions defined above
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
  bass :d2, v, c; sleep 1
  bass :d2, v*0.7, c-10; sleep 1
  bass :f2, v*0.9, c; sleep 1
  bass :d2, v, c; sleep 1
end
```

## Variables

Variables store values for reuse:

```ruby
my_note = :c4
my_volume = 0.8

play my_note, amp: my_volume
```

### Variables in Patterns

```ruby
define :melody do |v=1|
  notes = [:d4, :f4, :a4, :g4, :f4, :d4]
  
  notes.each do |n|
    play n, amp: v
    sleep 0.5
  end
end
```

### Arrays for Patterns

```ruby
define :arp do |v=1|
  pattern = [:d4, :f4, :a4, :d5, :a4, :f4, :d4, :a3]
  
  pattern.each do |n|
    use_synth :pulse
    play n, amp: 0.25*v, release: 0.1
    sleep 0.5
  end
end
```

## Local vs Global

Variables inside `define` are local:

```ruby
define :example do
  x = 10  # Only exists inside this function
end

# x doesn't exist here
```

Variables outside are global:

```ruby
$global_volume = 0.8  # Available everywhere

define :example do
  play :c4, amp: $global_volume
end
```

We rarely use global variables — parameters are cleaner.

## The Complete Pattern

Here's the structure used in every album track:

```ruby
use_bpm 100

# 1. SOUND DEFINITIONS
define :kick do |v=1|
  # ...
end

define :snare do |v=1|
  # ...
end

define :bass do |n, v=1, c=80|
  # ...
end

# 2. PATTERN DEFINITIONS
define :drums do |k=1, s=1, h=1|
  # Uses sound functions
end

define :bassline do |v=1, c=80|
  # Uses bass function
end

# 3. ARRANGEMENT
# Intro
8.times { drums 0.7, 0, 0.5 }

# Main
16.times { drums 1, 0.9, 0.8 }
```

This separation makes code:
- **Readable** — Clear what each section does
- **Reusable** — Same sounds, different patterns
- **Tweakable** — Change one function, affect everywhere

---

Next: Threads — how to play multiple parts simultaneously.
