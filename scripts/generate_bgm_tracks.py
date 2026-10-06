import math
import struct
import wave
import random

SAMPLE_RATE = 44100

def note_freq(name, octave=4):
    notes = {'C': 0, 'C#': 1, 'Db': 1, 'D': 2, 'D#': 3, 'Eb': 3, 'E': 4, 'F': 5,
             'F#': 6, 'Gb': 6, 'G': 7, 'G#': 8, 'Ab': 8, 'A': 9, 'A#': 10, 'Bb': 10, 'B': 11}
    semitones = notes[name] + (octave - 4) * 12
    # A4 is 440 Hz, semitones relative to A4 (which is C4 + 9)
    semitones_from_a4 = semitones - 9
    return 440.0 * (2.0 ** (semitones_from_a4 / 12.0))

def pulse_wave(phase, duty=0.5):
    # Normalized phase in [0, 1)
    p = phase - math.floor(phase)
    return 1.0 if p < duty else -1.0

def triangle_wave(phase):
    p = phase - math.floor(phase)
    return 4.0 * abs(p - 0.5) - 1.0

def render_track(duration, channels_notes, bpm=120):
    total_samples = int(SAMPLE_RATE * duration)
    buffer = [0.0] * total_samples
    
    beat_sec = 60.0 / bpm
    step_sec = beat_sec / 4.0  # 16th notes
    
    for ch_type, notes, vol in channels_notes:
        for start_step, step_len, pitch, duty in notes:
            start_sample = int(start_step * step_sec * SAMPLE_RATE)
            num_samples = int(step_len * step_sec * SAMPLE_RATE)
            if start_sample >= total_samples:
                continue
            actual_len = min(num_samples, total_samples - start_sample)
            
            freq = pitch if isinstance(pitch, (int, float)) else note_freq(*pitch)
            
            phase = 0.0
            phase_inc = freq / SAMPLE_RATE if freq > 0 else 0.0
            
            # ADSR envelope
            attack_len = int(SAMPLE_RATE * 0.015)
            release_len = int(SAMPLE_RATE * 0.03)
            
            for i in range(actual_len):
                # Envelope
                if i < attack_len:
                    env = i / float(attack_len)
                elif i > actual_len - release_len:
                    env = max(0.0, (actual_len - i) / float(release_len))
                else:
                    env = 0.9
                
                # Vibrato for leads
                cur_inc = phase_inc
                if ch_type == 'lead' and i > attack_len:
                    vib = 0.008 * math.sin(2.0 * math.pi * 6.0 * (i / SAMPLE_RATE))
                    cur_inc *= (1.0 + vib)
                
                if ch_type in ('lead', 'harmony'):
                    w = pulse_wave(phase, duty)
                elif ch_type == 'bass':
                    w = triangle_wave(phase)
                elif ch_type == 'kick':
                    k_freq = max(35.0, 160.0 * (1.0 - (i / max(1, actual_len))))
                    cur_inc = k_freq / SAMPLE_RATE
                    w = math.sin(2.0 * math.pi * phase)
                elif ch_type == 'snare':
                    noise = (random.random() * 2.0 - 1.0)
                    tone = math.sin(2.0 * math.pi * phase)
                    w = noise * 0.7 + tone * 0.3
                elif ch_type == 'hihat':
                    w = (random.random() * 2.0 - 1.0)
                else:
                    w = math.sin(2.0 * math.pi * phase)
                
                phase += cur_inc
                buffer[start_sample + i] += w * env * vol

    # Normalize to prevent clipping, master soft limiter
    peak = max(abs(s) for s in buffer) if buffer else 1.0
    gain = 0.82 / max(peak, 0.82)
    
    pcm_bytes = bytearray()
    for s in buffer:
        sample_val = int(max(-32767, min(32767, s * gain * 32767.0)))
        pcm_bytes.extend(struct.pack("<h", sample_val))
        
    return pcm_bytes

def write_wav(filename, pcm_bytes):
    with wave.open(filename, "w") as f:
        f.setnchannels(1)
        f.setsampwidth(2)
        f.setframerate(SAMPLE_RATE)
        f.writeframes(pcm_bytes)
    print(f"Generated {filename} ({len(pcm_bytes)} bytes)")

# 1. Shop / Prep BGM (Joyful, relaxing, Town/Shop theme)
# 4/4 time, 16 bars, BPM 116
def gen_shop_bgm():
    bpm = 116
    bars = 8
    beats_per_bar = 4
    total_steps = bars * beats_per_bar * 4  # 128 steps (16th notes)
    sec = (60.0 / bpm) * (bars * 4)
    
    lead_notes = []
    # Melody: C - G - Am - Em - F - C - Dm - G progression
    melody_chunks = [
        # Bar 1 (C)
        [(0, 2, ('G', 4)), (2, 2, ('E', 5)), (4, 4, ('C', 5)), (8, 2, ('D', 5)), (10, 2, ('E', 5)), (12, 4, ('G', 5))],
        # Bar 2 (G)
        [(16, 2, ('F', 5)), (18, 2, ('D', 5)), (20, 4, ('B', 4)), (24, 4, ('G', 4)), (28, 4, ('D', 5))],
        # Bar 3 (Am)
        [(32, 2, ('E', 5)), (34, 2, ('C', 5)), (36, 4, ('A', 4)), (40, 2, ('B', 4)), (42, 2, ('C', 5)), (44, 4, ('E', 5))],
        # Bar 4 (Em)
        [(48, 4, ('G', 5)), (52, 4, ('E', 5)), (56, 4, ('B', 4)), (60, 4, ('E', 4))],
        # Bar 5 (F)
        [(64, 2, ('A', 4)), (66, 2, ('C', 5)), (68, 4, ('F', 5)), (72, 2, ('G', 5)), (74, 2, ('A', 5)), (76, 4, ('F', 5))],
        # Bar 6 (C)
        [(80, 2, ('G', 5)), (82, 2, ('E', 5)), (84, 4, ('C', 5)), (88, 4, ('E', 5)), (92, 4, ('G', 4))],
        # Bar 7 (Dm)
        [(96, 2, ('F', 4)), (98, 2, ('A', 4)), (100, 4, ('D', 5)), (104, 2, ('F', 5)), (106, 2, ('E', 5)), (108, 4, ('D', 5))],
        # Bar 8 (G)
        [(112, 4, ('B', 4)), (116, 4, ('D', 5)), (120, 4, ('G', 5)), (124, 4, ('B', 4))]
    ]
    for chunk in melody_chunks:
        for st, l, p in chunk:
            lead_notes.append((st, l, p, 0.5))
            
    # Bass: walking bass line
    bass_notes = []
    roots = [
        ('C', 3), ('G', 2), ('A', 2), ('E', 2),
        ('F', 2), ('C', 3), ('D', 3), ('G', 2)
    ]
    for b_idx, (r_note, r_oct) in enumerate(roots):
        base_step = b_idx * 16
        bass_notes.append((base_step + 0, 3, (r_note, r_oct), 0.5))
        bass_notes.append((base_step + 4, 3, (r_note, r_oct + 1), 0.5))
        bass_notes.append((base_step + 8, 3, (r_note, r_oct), 0.5))
        bass_notes.append((base_step + 12, 3, (r_note, r_oct + 1), 0.5))
        
    # Drum track (kick, snare, hi-hat)
    drum_notes = []
    for step in range(0, total_steps, 4):
        # Kick on 1 and 3 beats (0, 8)
        if step % 16 in (0, 8):
            drum_notes.append(('kick', [(step, 2, 80, 0.5)], 0.45))
        # Snare on 2 and 4 beats (4, 12)
        if step % 16 in (4, 12):
            drum_notes.append(('snare', [(step, 2, 220, 0.5)], 0.35))
        # Hi-hat on every 8th note
        drum_notes.append(('hihat', [(step, 1, 8000, 0.5)], 0.15))
        drum_notes.append(('hihat', [(step + 2, 1, 8000, 0.5)], 0.12))
        
    channels = [
        ('lead', lead_notes, 0.45),
        ('bass', bass_notes, 0.40)
    ] + drum_notes
    return render_track(sec, channels, bpm)

# 2. Battle BGM (Driving, intense, 16th-note arpeggios, Pokemon battle feel)
def gen_battle_bgm():
    bpm = 142
    bars = 8
    total_steps = bars * 16
    sec = (60.0 / bpm) * (bars * 4)
    
    lead_notes = []
    # Fast driving battle melody in D minor
    b_chunks = [
        # Bar 1 (Dm)
        [(0, 2, ('D', 5)), (2, 2, ('F', 5)), (4, 2, ('A', 5)), (6, 2, ('D', 6)), (8, 4, ('A', 5)), (12, 4, ('F', 5))],
        # Bar 2 (Bb)
        [(16, 2, ('Bb', 5)), (18, 2, ('A', 5)), (20, 2, ('G', 5)), (22, 2, ('F', 5)), (24, 4, ('G', 5)), (28, 4, ('A', 5))],
        # Bar 3 (C)
        [(32, 2, ('E', 5)), (34, 2, ('G', 5)), (36, 2, ('C', 6)), (38, 2, ('E', 6)), (40, 4, ('D', 6)), (44, 4, ('C', 6))],
        # Bar 4 (A)
        [(48, 4, ('A', 5)), (52, 4, ('C#', 6)), (56, 4, ('E', 6)), (60, 4, ('A', 5))],
        # Bar 5 (Dm)
        [(64, 2, ('F', 5)), (66, 2, ('E', 5)), (68, 2, ('D', 5)), (70, 2, ('E', 5)), (72, 4, ('F', 5)), (76, 4, ('A', 5))],
        # Bar 6 (Gm)
        [(80, 2, ('G', 5)), (82, 2, ('Bb', 5)), (84, 2, ('D', 6)), (86, 2, ('F', 6)), (88, 4, ('E', 6)), (92, 4, ('D', 6))],
        # Bar 7 (A7)
        [(96, 2, ('C#', 6)), (98, 2, ('E', 6)), (100, 4, ('G', 6)), (104, 2, ('F', 6)), (106, 2, ('E', 6)), (108, 4, ('C#', 6))],
        # Bar 8 (Dm)
        [(112, 4, ('D', 6)), (116, 4, ('A', 5)), (120, 4, ('F', 5)), (124, 4, ('D', 5))]
    ]
    for chunk in b_chunks:
        for st, l, p in chunk:
            lead_notes.append((st, l, p, 0.25))
            
    # Driving bass: rolling 8th notes
    bass_notes = []
    chords = ['D', 'Bb', 'C', 'A', 'D', 'G', 'A', 'D']
    for idx, c in enumerate(chords):
        base_st = idx * 16
        for s in range(0, 16, 2):
            octave = 2 if s % 4 == 0 else 3
            bass_notes.append((base_st + s, 2, (c, octave), 0.5))
            
    # Drums
    drum_notes = []
    for step in range(0, total_steps, 2):
        if step % 16 in (0, 8):
            drum_notes.append(('kick', [(step, 2, 100, 0.5)], 0.50))
        if step % 16 in (4, 12):
            drum_notes.append(('snare', [(step, 2, 280, 0.5)], 0.40))
        drum_notes.append(('hihat', [(step, 1, 9000, 0.5)], 0.18))
        
    channels = [
        ('lead', lead_notes, 0.45),
        ('bass', bass_notes, 0.42)
    ] + drum_notes
    return render_track(sec, channels, bpm)

# 3. Boss BGM (Epic Mewtwo / Legend encounter theme)
def gen_boss_bgm():
    bpm = 150
    bars = 8
    total_steps = bars * 16
    sec = (60.0 / bpm) * (bars * 4)
    
    lead_notes = []
    # Dramatic G minor chromatic motif
    boss_chunks = [
        [(0, 2, ('G', 5)), (2, 2, ('Ab', 5)), (4, 2, ('G', 5)), (6, 2, ('F#', 5)), (8, 4, ('G', 5)), (12, 4, ('D', 6))],
        [(16, 2, ('Eb', 6)), (18, 2, ('D', 6)), (20, 2, ('C', 6)), (22, 2, ('Bb', 5)), (24, 4, ('A', 5)), (28, 4, ('F#', 5))],
        [(32, 2, ('G', 5)), (34, 2, ('Bb', 5)), (36, 2, ('D', 6)), (38, 2, ('G', 6)), (40, 4, ('F#', 6)), (44, 4, ('D', 6))],
        [(48, 4, ('Eb', 6)), (52, 4, ('C', 6)), (56, 4, ('A', 5)), (60, 4, ('D', 5))],
        [(64, 2, ('G', 6)), (66, 2, ('F', 6)), (68, 2, ('Eb', 6)), (70, 2, ('D', 6)), (72, 4, ('C', 6)), (76, 4, ('Bb', 5))],
        [(80, 2, ('Ab', 5)), (82, 2, ('G', 5)), (84, 2, ('F', 5)), (86, 2, ('Eb', 5)), (88, 4, ('D', 5)), (92, 4, ('C', 5))],
        [(96, 2, ('D', 5)), (98, 2, ('F#', 5)), (100, 2, ('A', 5)), (102, 2, ('C', 6)), (104, 4, ('D', 6)), (108, 4, ('F#', 6))],
        [(112, 4, ('G', 6)), (116, 4, ('D', 6)), (120, 4, ('Bb', 5)), (124, 4, ('G', 5))]
    ]
    for chunk in boss_chunks:
        for st, l, p in chunk:
            lead_notes.append((st, l, p, 0.125))
            
    bass_notes = []
    b_chords = ['G', 'Eb', 'Bb', 'D', 'G', 'C', 'D', 'G']
    for idx, c in enumerate(b_chords):
        base_st = idx * 16
        for s in range(0, 16, 2):
            bass_notes.append((base_st + s, 2, (c, 2), 0.5))
            
    drum_notes = []
    for step in range(0, total_steps, 2):
        if step % 8 == 0:
            drum_notes.append(('kick', [(step, 2, 120, 0.5)], 0.55))
        if step % 8 == 4:
            drum_notes.append(('snare', [(step, 2, 320, 0.5)], 0.45))
        drum_notes.append(('hihat', [(step, 1, 9500, 0.5)], 0.22))
        
    channels = [
        ('lead', lead_notes, 0.48),
        ('bass', bass_notes, 0.45)
    ] + drum_notes
    return render_track(sec, channels, bpm)

# 4. Victory Fanfare (Short celebration jingle)
def gen_victory_bgm():
    bpm = 130
    sec = 4.5
    lead_notes = [
        (0, 2, ('G', 4), 0.5), (2, 2, ('C', 5), 0.5), (4, 2, ('E', 5), 0.5), (6, 4, ('G', 5), 0.5),
        (10, 2, ('E', 5), 0.5), (12, 6, ('G', 5), 0.5),
        (18, 2, ('A', 5), 0.5), (20, 2, ('B', 5), 0.5), (22, 12, ('C', 6), 0.5)
    ]
    bass_notes = [
        (0, 8, ('C', 3), 0.5), (8, 8, ('E', 3), 0.5), (16, 4, ('F', 3), 0.5), (20, 4, ('G', 3), 0.5), (24, 12, ('C', 3), 0.5)
    ]
    drum_notes = [
        ('snare', [(0, 1, 200, 0.5), (2, 1, 200, 0.5), (4, 1, 200, 0.5), (6, 2, 250, 0.5),
                   (12, 1, 220, 0.5), (14, 1, 220, 0.5), (16, 1, 220, 0.5), (18, 1, 220, 0.5),
                   (22, 4, 300, 0.5)], 0.4)
    ]
    channels = [('lead', lead_notes, 0.55), ('bass', bass_notes, 0.45)] + drum_notes
    return render_track(sec, channels, bpm)

# 5. Defeat Jingle (Short descending sad fanfare)
def gen_defeat_bgm():
    bpm = 110
    sec = 3.8
    lead_notes = [
        (0, 3, ('G', 5), 0.5), (3, 3, ('F', 5), 0.5), (6, 3, ('Eb', 5), 0.5), (9, 3, ('D', 5), 0.5),
        (12, 4, ('C', 5), 0.5), (16, 8, ('B', 4), 0.5)
    ]
    bass_notes = [
        (0, 6, ('C', 3), 0.5), (6, 6, ('G', 2), 0.5), (12, 12, ('C', 2), 0.5)
    ]
    channels = [('lead', lead_notes, 0.45), ('bass', bass_notes, 0.35)]
    return render_track(sec, channels, bpm)

if __name__ == '__main__':
    write_wav("assets/audio/bgm_shop.wav", gen_shop_bgm())
    write_wav("assets/audio/bgm_battle.wav", gen_battle_bgm())
    write_wav("assets/audio/bgm_boss.wav", gen_boss_bgm())
    write_wav("assets/audio/bgm_victory.wav", gen_victory_bgm())
    write_wav("assets/audio/bgm_defeat.wav", gen_defeat_bgm())
    print("All BGM tracks generated successfully!")
