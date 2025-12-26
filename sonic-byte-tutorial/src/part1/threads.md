# Threads and Concurrency

Music has multiple parts playing simultaneously — drums, bass, melody, effects. Threads make this possible.

## The Problem

Without threads, code runs sequentially:

```ruby
# This plays ONE thing at a time
4.times do
  sample :bd_tek
  sleep 1
end

4.times do
  sample :sn_dub
  sleep 1
end
```

The snare only starts AFTER all kicks finish. That's not music — that's a sequence.

## The Solution: in_thread

`in_thread` runs code in the background:

```ruby
in_thread do
  4.times do
    sample :bd_tek
    sleep 1
  end
end

in_thread do
  4.times do
    sleep 0.5
    sample :sn_dub
    sleep 0.5
  end
end
```

Now both run simultaneously! Kicks on the beat, snares on the off-beat.

## Thread Timing

Threads start at the same moment:

```ruby
in_thread do
  puts "Thread 1 starts"
  sleep 2
  puts "Thread 1 ends"
end

in_thread do
  puts "Thread 2 starts"
  sleep 1
  puts "Thread 2 ends"
end

puts "Main continues immediately"
```

Output:
```
Main continues immediately
Thread 1 starts
Thread 2 starts
Thread 2 ends     # After 1 beat
Thread 1 ends     # After 2 beats
```

## The Drum Pattern

Here's how we build drums with threads:

```ruby
define :drums do |k=1, s=1, h=1|
  # Kick thread
  in_thread do
    4.times do
      kick k
      sleep 1
    end
  end
  
  # Snare thread
  in_thread do
    sleep 1          # Wait for beat 2
    snare s
    sleep 1          # Wait for beat 4
    snare s
    sleep 2          # Fill remaining time
  end
  
  # Hi-hat thread
  in_thread do
    8.times do
      hat h
      sleep 0.5
    end
  end
  
  # IMPORTANT: Wait for pattern to complete
  sleep 4
end
```

### The Final Sleep

The `sleep 4` at the end is crucial:

```ruby
# WITHOUT final sleep
8.times { drums }  # All 8 start immediately!

# WITH final sleep
8.times { drums }  # Each waits 4 beats before next
```

The main function must "take time" equal to the pattern length.

## Visualizing Threads

```
Time:  1       2       3       4       
       |       |       |       |
Kick:  X       X       X       X
Snare:         X               X
Hat:   x   x   x   x   x   x   x   x
```

All three threads run in parallel, each following its own timing.

## Complex Drum Patterns

The album uses more complex patterns:

```ruby
define :drums_power do |k=1, s=1, h=1|
  in_thread do
    kick k; sleep 0.75
    kick k*0.6; sleep 0.25
    kick k*0.8; sleep 1
    kick k; sleep 0.75
    kick k*0.7; sleep 0.25
    kick k*0.9; sleep 1
  end
  
  in_thread do
    sleep 1.5
    snare s*0.7
    sleep 0.5
    snare s
    sleep 2
  end
  
  in_thread do
    8.times { hat h; sleep 0.5 }
  end
  
  sleep 4
end
```

This creates syncopated kicks with ghost notes.

## Layering with Threads

Use threads to layer different elements:

```ruby
# ARRANGEMENT SECTION
in_thread do
  12.times { drums 1, 0.9, 0.7 }
end

in_thread do
  12.times { bassline 1, 80 }
end

in_thread do
  sleep 16  # Wait 4 bars before melody enters
  8.times { melody 0.8 }
end

sleep 48  # Total section length: 12 bars
```

## Thread Naming

For debugging, name your threads:

```ruby
in_thread name: :drums do
  # ...
end

in_thread name: :bass do
  # ...
end
```

## Common Mistakes

### 1. Forgetting the Final Sleep

```ruby
# BAD - drums function returns immediately
define :drums do
  in_thread { 4.times { kick; sleep 1 } }
  in_thread { 4.times { snare; sleep 1 } }
  # No sleep 4!
end

8.times { drums }  # All start at once!
```

### 2. Mismatched Timing

```ruby
# BAD - threads have different lengths
in_thread do
  4.times { kick; sleep 1 }  # 4 beats
end

in_thread do
  3.times { snare; sleep 1 }  # 3 beats - will drift!
end
```

### 3. Too Many Nested Threads

```ruby
# AVOID - hard to track timing
in_thread do
  in_thread do
    in_thread do
      # ???
    end
  end
end
```

Keep thread structure flat when possible.

## The Arrangement Pattern

Full tracks use threads for sections:

```ruby
# INTRO
in_thread do
  8.times { drums 0.7, 0, 0.5 }
end
in_thread do
  with_fx :lpf, cutoff: 60 do
    8.times { bassline 0.6 }
  end
end
sleep 32

# MAIN
in_thread do
  16.times { drums 1, 0.9, 0.8 }
end
in_thread do
  16.times { bassline 1, 85 }
end
in_thread do
  sleep 16
  8.times { melody 0.8 }
end
sleep 64
```

## Quick Reference

```ruby
# Basic thread
in_thread do
  # Code runs in background
end

# Named thread
in_thread name: :my_thread do
  # ...
end

# Pattern with threads
define :drums do |k=1, s=1, h=1|
  in_thread do
    4.times { kick k; sleep 1 }
  end
  in_thread do
    sleep 1; snare s; sleep 1; snare s; sleep 2
  end
  sleep 4  # IMPORTANT!
end
```

---

Next: Effects — adding space, texture, and movement to sounds.
