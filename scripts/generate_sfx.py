#!/usr/bin/env python3
"""
Procedural 16-bit 44.1kHz Sound Effects Generator for Pokemon Auto-Chess.
Synthesizes clean, retro/arcade style WAV sound effects without external dependencies.
"""

import os
import wave
import math
import struct
import random

SAMPLE_RATE = 44100

def write_wav(filename, samples):
    os.makedirs(os.path.dirname(filename), exist_ok=True)
    with wave.open(filename, 'w') as wav:
        wav.setnchannels(1)  # Mono
        wav.setsampwidth(2)  # 16-bit
        wav.setframerate(SAMPLE_RATE)
        # Normalize and clamp samples
        max_val = max(abs(s) for s in samples) if samples else 1.0
        if max_val < 1e-6:
            max_val = 1.0
        scale = 32000.0 / max(max_val, 1.0)
        raw_bytes = bytearray()
        for s in samples:
            val = int(max(-32767, min(32767, s * scale)))
            raw_bytes.extend(struct.pack('<h', val))
        wav.writeframes(raw_bytes)
    print(f"Generated: {filename} ({len(samples)} samples, {len(samples)/SAMPLE_RATE:.2f}s)")

def generate_click():
    duration = 0.05
    n_samples = int(SAMPLE_RATE * duration)
    samples = []
    for i in range(n_samples):
        t = i / SAMPLE_RATE
        freq = 1200 - (t / duration) * 800
        env = math.exp(-t * 80)
        s = math.sin(2 * math.pi * freq * t) * env
        samples.append(s)
    return samples

def generate_buy():
    duration = 0.22
    n_samples = int(SAMPLE_RATE * duration)
    samples = []
    notes = [523.25, 659.25, 783.99] # C5, E5, G5
    step = n_samples // len(notes)
    for i in range(n_samples):
        note_idx = min(i // step, len(notes) - 1)
        freq = notes[note_idx]
        t = i / SAMPLE_RATE
        local_t = (i % step) / SAMPLE_RATE
        env = math.exp(-local_t * 20)
        s = (math.sin(2 * math.pi * freq * t) + 0.3 * math.sin(4 * math.pi * freq * t)) * env
        samples.append(s)
    return samples

def generate_sell():
    duration = 0.28
    n_samples = int(SAMPLE_RATE * duration)
    samples = []
    # Coin jingle: high B5 then E6
    for i in range(n_samples):
        t = i / SAMPLE_RATE
        if t < 0.12:
            freq = 987.77 # B5
            env = math.exp(-t * 25)
        else:
            t2 = t - 0.12
            freq = 1318.51 # E6
            env = math.exp(-t2 * 18)
        s = (math.sin(2 * math.pi * freq * t) + 0.5 * math.sin(2 * math.pi * freq * 2 * t)) * env
        samples.append(s)
    return samples

def generate_evolve():
    duration = 0.85
    n_samples = int(SAMPLE_RATE * duration)
    samples = []
    # Ascending magical arpeggio: C5, E5, G5, B5, C6, E6, G6
    notes = [523.25, 659.25, 783.99, 987.77, 1046.50, 1318.51, 1567.98]
    step = n_samples // len(notes)
    for i in range(n_samples):
        idx = min(i // step, len(notes) - 1)
        freq = notes[idx]
        t = i / SAMPLE_RATE
        local_t = (i % step) / SAMPLE_RATE
        env = math.exp(-local_t * 12)
        vibrato = 1.0 + 0.02 * math.sin(2 * math.pi * 12 * t)
        s = math.sin(2 * math.pi * freq * vibrato * t) * env
        # Add sparkle shimmer
        s += 0.2 * math.sin(2 * math.pi * freq * 3 * t) * env
        samples.append(s)
    return samples

def generate_attack():
    duration = 0.16
    n_samples = int(SAMPLE_RATE * duration)
    samples = []
    for i in range(n_samples):
        t = i / SAMPLE_RATE
        # Fast descending punch
        freq = 320 - (t / duration) * 260
        env = math.exp(-t * 30)
        # Mix punch tone and burst of filtered noise
        noise = (random.random() * 2 - 1) * math.exp(-t * 45)
        s = (math.sin(2 * math.pi * freq * t) + 0.6 * noise) * env
        samples.append(s)
    return samples

def generate_slash():
    duration = 0.12
    n_samples = int(SAMPLE_RATE * duration)
    samples = []
    for i in range(n_samples):
        t = i / SAMPLE_RATE
        freq = 2200 - (t / duration) * 1600
        env = math.exp(-t * 32)
        noise = (random.random() * 2 - 1) * math.exp(-t * 28)
        s = (0.5 * math.sin(2 * math.pi * freq * t) + 0.8 * noise) * env
        samples.append(s)
    return samples

def generate_punch():
    duration = 0.14
    n_samples = int(SAMPLE_RATE * duration)
    samples = []
    for i in range(n_samples):
        t = i / SAMPLE_RATE
        freq = 180 - (t / duration) * 120
        env = math.exp(-t * 26)
        noise = (random.random() * 2 - 1) * math.exp(-t * 50)
        # Heavy sub-bass thud
        s = (math.sin(2 * math.pi * freq * t) + 0.5 * math.sin(math.pi * freq * t) + 0.5 * noise) * env
        samples.append(s)
    return samples

def generate_spark():
    duration = 0.10
    n_samples = int(SAMPLE_RATE * duration)
    samples = []
    for i in range(n_samples):
        t = i / SAMPLE_RATE
        freq = 1500 - (t / duration) * 600
        env = math.exp(-t * 35)
        sparkle = math.sin(2 * math.pi * freq * 2.5 * t) * 0.3
        s = (math.sin(2 * math.pi * freq * t) + sparkle) * env
        samples.append(s)
    return samples

def generate_thunder():
    duration = 0.45
    n_samples = int(SAMPLE_RATE * duration)
    samples = []
    for i in range(n_samples):
        t = i / SAMPLE_RATE
        # High pitched crackle then rumbling discharge
        freq = 800 - (t / duration) * 650
        env = math.exp(-t * 8)
        saw = 2.0 * ((freq * t) % 1.0) - 1.0
        noise = (random.random() * 2 - 1) * 0.8
        s = (saw * 0.5 + noise * 0.7) * env
        samples.append(s)
    return samples

def generate_fire():
    duration = 0.4
    n_samples = int(SAMPLE_RATE * duration)
    samples = []
    for i in range(n_samples):
        t = i / SAMPLE_RATE
        # Whoosh and crackle
        env = (t / 0.05) if t < 0.05 else math.exp(-(t - 0.05) * 8)
        noise = (random.random() * 2 - 1)
        rumble = math.sin(2 * math.pi * 110 * t) * 0.4
        s = (noise * 0.8 + rumble) * env
        samples.append(s)
    return samples

def generate_water():
    duration = 0.35
    n_samples = int(SAMPLE_RATE * duration)
    samples = []
    for i in range(n_samples):
        t = i / SAMPLE_RATE
        env = math.exp(-t * 10)
        # Frequency modulation for bubbly water drop
        mod = 120 * math.sin(2 * math.pi * 35 * t)
        freq = 400 + mod + (t / duration) * 200
        s = math.sin(2 * math.pi * freq * t) * env
        # Splash noise
        if t < 0.1:
            s += (random.random() * 2 - 1) * 0.3 * (1 - t / 0.1)
        samples.append(s)
    return samples

def generate_skill():
    duration = 0.55
    n_samples = int(SAMPLE_RATE * duration)
    samples = []
    for i in range(n_samples):
        t = i / SAMPLE_RATE
        # Power charge sweep up then release
        if t < 0.25:
            freq = 200 + (t / 0.25) * 600
            env = t / 0.25
        else:
            freq = 800 - ((t - 0.25) / 0.3) * 400
            env = math.exp(-(t - 0.25) * 12)
        s = (math.sin(2 * math.pi * freq * t) + 0.4 * math.sin(4 * math.pi * freq * t)) * env
        samples.append(s)
    return samples

def generate_swift():
    duration = 0.45
    n_samples = int(SAMPLE_RATE * duration)
    samples = []
    # Twinkling star arpeggio: E6 (1318Hz), G6 (1567Hz), B6 (1975Hz), E7 (2637Hz)
    chimes = [1318.51, 1567.98, 1975.53, 2637.02]
    step = n_samples // len(chimes)
    for i in range(n_samples):
        t = i / SAMPLE_RATE
        s = 0.0
        for idx, freq in enumerate(chimes):
            t_start = idx * (duration / len(chimes))
            if t >= t_start:
                dt = t - t_start
                env = math.exp(-dt * 18)
                s += (math.sin(2 * math.pi * freq * dt) + 0.3 * math.sin(4 * math.pi * freq * dt)) * env * 0.4
        # Add slight sparkle noise
        s += (random.random() * 2 - 1) * 0.05 * math.exp(-t * 8)
        samples.append(s)
    return samples

def generate_blizzard():
    duration = 0.6
    n_samples = int(SAMPLE_RATE * duration)
    samples = []
    for i in range(n_samples):
        t = i / SAMPLE_RATE
        # Howling wind envelope + high icy shatter
        wind_env = math.sin(math.pi * (t / duration)) ** 1.5
        noise = (random.random() * 2 - 1)
        # Resonant ice crystals ringing
        ice1 = math.sin(2 * math.pi * 2400 * t) * 0.25 * math.exp(-t * 6)
        ice2 = math.sin(2 * math.pi * 3200 * t) * 0.2 * math.exp(-t * 8)
        s = (noise * 0.5 * wind_env) + ice1 + ice2
        samples.append(s)
    return samples

def generate_discharge():
    duration = 0.5
    n_samples = int(SAMPLE_RATE * duration)
    samples = []
    for i in range(n_samples):
        t = i / SAMPLE_RATE
        env = (t / 0.04) if t < 0.04 else math.exp(-(t - 0.04) * 9)
        # Sizzling square-like electricity + white noise zap
        freq = 320 + 80 * math.sin(2 * math.pi * 90 * t)
        buzz = 1.0 if math.sin(2 * math.pi * freq * t) > 0 else -1.0
        noise = (random.random() * 2 - 1)
        s = (buzz * 0.45 + noise * 0.55) * env
        samples.append(s)
    return samples

def generate_aura_sphere():
    duration = 0.55
    n_samples = int(SAMPLE_RATE * duration)
    samples = []
    for i in range(n_samples):
        t = i / SAMPLE_RATE
        if t < 0.2:
            # Concentrating surge pitch sweep up
            freq = 150 + (t / 0.2) * 550
            env = (t / 0.2) * 0.8
            s = math.sin(2 * math.pi * freq * t) * env
        else:
            # Concussive shockwave boom + sub-bass
            dt = t - 0.2
            freq = 140 * math.exp(-dt * 6)
            env = math.exp(-dt * 9)
            s = (math.sin(2 * math.pi * freq * dt) + 0.5 * (random.random() * 2 - 1)) * env
        samples.append(s)
    return samples

def generate_victory():
    duration = 1.2
    n_samples = int(SAMPLE_RATE * duration)
    samples = []
    # Triumphant fanfare: G4, C5, E5, G5
    notes = [392.00, 523.25, 659.25, 783.99]
    timings = [0.0, 0.22, 0.44, 0.66]
    for i in range(n_samples):
        t = i / SAMPLE_RATE
        s = 0.0
        for n_idx, (note_freq, start_t) in enumerate(zip(notes, timings)):
            if t >= start_t:
                dt = t - start_t
                note_dur = 0.54 if n_idx == len(notes) - 1 else 0.2
                if dt < note_dur:
                    env = math.exp(-dt * 3.5)
                    s += (math.sin(2 * math.pi * note_freq * dt) + 0.3 * math.sin(4 * math.pi * note_freq * dt)) * env
        samples.append(s)
    return samples

def generate_defeat():
    duration = 0.9
    n_samples = int(SAMPLE_RATE * duration)
    samples = []
    # Somber descending notes: G4, Eb4, C4
    notes = [392.00, 311.13, 261.63]
    step = n_samples // len(notes)
    for i in range(n_samples):
        idx = min(i // step, len(notes) - 1)
        freq = notes[idx]
        local_t = (i % step) / SAMPLE_RATE
        env = math.exp(-local_t * 6)
        s = math.sin(2 * math.pi * freq * (i / SAMPLE_RATE)) * env
        samples.append(s)
    return samples

def generate_round_start():
    duration = 0.5
    n_samples = int(SAMPLE_RATE * duration)
    samples = []
    for i in range(n_samples):
        t = i / SAMPLE_RATE
        # Brass-like duel start fanfare
        freq = 440.0
        env = math.exp(-t * 5)
        s = (math.sin(2 * math.pi * freq * t) + 0.5 * math.sin(4 * math.pi * freq * t) + 0.25 * math.sin(6 * math.pi * freq * t)) * env
        samples.append(s)
    return samples

def main():
    target_dir = os.path.join(os.path.dirname(__file__), "..", "assets", "audio")
    target_dir = os.path.abspath(target_dir)
    os.makedirs(target_dir, exist_ok=True)
    
    generators = {
        "sfx_click.wav": generate_click,
        "sfx_buy.wav": generate_buy,
        "sfx_sell.wav": generate_sell,
        "sfx_evolve.wav": generate_evolve,
        "sfx_attack.wav": generate_attack,
        "sfx_slash.wav": generate_slash,
        "sfx_punch.wav": generate_punch,
        "sfx_spark.wav": generate_spark,
        "sfx_thunder.wav": generate_thunder,
        "sfx_fire.wav": generate_fire,
        "sfx_water.wav": generate_water,
        "sfx_skill.wav": generate_skill,
        "sfx_swift.wav": generate_swift,
        "sfx_blizzard.wav": generate_blizzard,
        "sfx_discharge.wav": generate_discharge,
        "sfx_aura_sphere.wav": generate_aura_sphere,
        "sfx_victory.wav": generate_victory,
        "sfx_defeat.wav": generate_defeat,
        "sfx_round_start.wav": generate_round_start,
    }
    
    for fname, gen in generators.items():
        out_path = os.path.join(target_dir, fname)
        samples = gen()
        write_wav(out_path, samples)
    print("\nAll SFX successfully generated!")

if __name__ == "__main__":
    main()
