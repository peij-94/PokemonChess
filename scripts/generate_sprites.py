#!/usr/bin/env python3
"""
Pixel-art sprite and UI texture generator for Pokemon Auto-Chess.
Uses Python's standard library (zlib, struct) to output 32-bit RGBA PNG files.
"""

import os
import zlib
import struct
import math

def save_png(filename, width, height, pixels):
    """
    Saves a 2D list of (R, G, B, A) tuples (0-255) as a PNG file.
    pixels[y][x] = (r, g, b, a)
    """
    os.makedirs(os.path.dirname(os.path.abspath(filename)), exist_ok=True)
    raw_data = bytearray()
    for y in range(height):
        raw_data.append(0)  # Filter type 0 (None)
        for x in range(width):
            r, g, b, a = pixels[y][x]
            raw_data.extend((r, g, b, a))
            
    compressed = zlib.compress(bytes(raw_data))
    
    def chunk(tag, data):
        length = len(data)
        crc = zlib.crc32(tag + data) & 0xffffffff
        return struct.pack('>I', length) + tag + data + struct.pack('>I', crc)
        
    png_bytes = bytearray(b'\x89PNG\r\n\x1a\n')
    ihdr = struct.pack('>IIBBBBB', width, height, 8, 6, 0, 0, 0)
    png_bytes.extend(chunk(b'IHDR', ihdr))
    png_bytes.extend(chunk(b'IDAT', compressed))
    png_bytes.extend(chunk(b'IEND', b''))
    
    with open(filename, 'wb') as f:
        f.write(png_bytes)
    print(f"Created PNG: {filename} ({width}x{height})")

def create_blank(w, h, color=(0, 0, 0, 0)):
    return [[color for _ in range(w)] for _ in range(h)]

def draw_circle(pixels, cx, cy, r, color):
    w = len(pixels[0])
    h = len(pixels)
    for y in range(max(0, int(cy - r)), min(h, int(cy + r + 1))):
        for x in range(max(0, int(cx - r)), min(w, int(cx + r + 1))):
            dist = math.hypot(x - cx, y - cy)
            if dist <= r:
                pixels[y][x] = color

def draw_rect(pixels, x1, y1, x2, y2, color):
    w = len(pixels[0])
    h = len(pixels)
    for y in range(max(0, y1), min(h, y2)):
        for x in range(max(0, x1), min(w, x2)):
            pixels[y][x] = color

def generate_type_icons(out_dir):
    types = {
        "fire": (245, 110, 48, 255),
        "water": (59, 130, 246, 255),
        "grass": (34, 197, 94, 255),
        "electric": (234, 179, 8, 255),
        "psychic": (168, 85, 247, 255),
        "fighting": (194, 65, 12, 255),
        "dragon": (99, 102, 241, 255),
        "normal": (148, 163, 184, 255),
        "ghost": (109, 40, 217, 255)
    }
    size = 48
    for tname, bg_col in types.items():
        p = create_blank(size, size)
        # Background badge circle
        draw_circle(p, size/2, size/2, size/2 - 2, (30, 35, 45, 255))
        draw_circle(p, size/2, size/2, size/2 - 4, bg_col)
        # Inner highlight
        draw_circle(p, size/2 - 4, size/2 - 4, size/4, (min(255, bg_col[0] + 40), min(255, bg_col[1] + 40), min(255, bg_col[2] + 40), 180))
        # Center symbol dot
        draw_circle(p, size/2, size/2, 6, (255, 255, 255, 230))
        save_png(os.path.join(out_dir, f"type_{tname}.png"), size, size, p)

def generate_unit_sprites(out_dir):
    # Generates stylized pixel units (64x64)
    size = 64
    
    # Bulbasaur: Cyan-green body, dark green spots, big green bulb on back, red eyes
    p = create_blank(size, size)
    draw_circle(p, 32, 26, 16, (40, 160, 90, 255)) # bulb
    draw_circle(p, 32, 38, 20, (50, 180, 150, 255)) # body
    draw_circle(p, 32, 32, 16, (60, 200, 170, 255)) # head
    draw_circle(p, 26, 30, 4, (220, 38, 38, 255)) # left eye
    draw_circle(p, 38, 30, 4, (220, 38, 38, 255)) # right eye
    draw_rect(p, 20, 48, 28, 58, (45, 170, 140, 255)) # foot L
    draw_rect(p, 36, 48, 44, 58, (45, 170, 140, 255)) # foot R
    save_png(os.path.join(out_dir, "bulbasaur.png"), size, size, p)
    
    # Gengar: Dark purple spherical body, sinister red eyes, jagged grin, pointed ears
    p = create_blank(size, size)
    draw_circle(p, 20, 18, 8, (110, 40, 160, 255)) # ear L
    draw_circle(p, 44, 18, 8, (110, 40, 160, 255)) # ear R
    draw_circle(p, 32, 36, 22, (120, 50, 175, 255)) # body
    draw_circle(p, 24, 32, 5, (239, 68, 68, 255)) # red eye L
    draw_circle(p, 40, 32, 5, (239, 68, 68, 255)) # red eye R
    draw_circle(p, 24, 32, 2, (255, 255, 255, 255)) # pupil
    draw_circle(p, 40, 32, 2, (255, 255, 255, 255)) # pupil
    draw_rect(p, 24, 42, 40, 46, (240, 240, 240, 255)) # teeth
    save_png(os.path.join(out_dir, "gengar.png"), size, size, p)

    # Snorlax: Big navy blue body, cream belly and face, closed sleepy eyes
    p = create_blank(size, size)
    draw_circle(p, 22, 18, 6, (30, 58, 100, 255)) # ear L
    draw_circle(p, 42, 18, 6, (30, 58, 100, 255)) # ear R
    draw_circle(p, 32, 40, 24, (35, 65, 110, 255)) # body
    draw_circle(p, 32, 42, 18, (245, 235, 195, 255)) # cream belly
    draw_circle(p, 32, 26, 14, (35, 65, 110, 255)) # head
    draw_circle(p, 32, 27, 10, (245, 235, 195, 255)) # cream face
    draw_rect(p, 25, 26, 29, 28, (30, 30, 30, 255)) # sleepy eye L
    draw_rect(p, 35, 26, 39, 28, (30, 30, 30, 255)) # sleepy eye R
    save_png(os.path.join(out_dir, "snorlax.png"), size, size, p)

    # Machop: Grayish blue body, three head crests, determined eyes
    p = create_blank(size, size)
    draw_circle(p, 32, 16, 5, (160, 160, 150, 255)) # center crest
    draw_circle(p, 26, 18, 4, (160, 160, 150, 255)) # left crest
    draw_circle(p, 38, 18, 4, (160, 160, 150, 255)) # right crest
    draw_circle(p, 32, 28, 14, (140, 175, 205, 255)) # head
    draw_circle(p, 32, 42, 16, (140, 175, 205, 255)) # muscular body
    draw_circle(p, 27, 26, 3, (220, 50, 50, 255)) # red eye L
    draw_circle(p, 37, 26, 3, (220, 50, 50, 255)) # red eye R
    save_png(os.path.join(out_dir, "machop.png"), size, size, p)

    # Alakazam: Golden yellow body, brown shoulder pads, long white mustache, psychic spoons
    p = create_blank(size, size)
    draw_circle(p, 18, 16, 7, (220, 170, 30, 255)) # ear L
    draw_circle(p, 46, 16, 7, (220, 170, 30, 255)) # ear R
    draw_circle(p, 32, 28, 13, (230, 185, 40, 255)) # head
    draw_circle(p, 32, 44, 15, (130, 75, 30, 255)) # chest armor
    draw_rect(p, 20, 33, 44, 37, (245, 245, 240, 255)) # white mustache
    draw_circle(p, 14, 38, 6, (200, 200, 220, 255)) # spoon L
    draw_circle(p, 50, 38, 6, (200, 200, 220, 255)) # spoon R
    save_png(os.path.join(out_dir, "alakazam.png"), size, size, p)

    # Charizard: Fiery orange dragon, blue wings, tail flame, horns
    p = create_blank(size, size)
    draw_circle(p, 16, 28, 12, (50, 130, 140, 255)) # wing L
    draw_circle(p, 48, 28, 12, (50, 130, 140, 255)) # wing R
    draw_circle(p, 32, 40, 18, (240, 110, 30, 255)) # body
    draw_circle(p, 32, 44, 13, (245, 225, 140, 255)) # cream belly
    draw_circle(p, 32, 24, 12, (240, 110, 30, 255)) # head
    draw_circle(p, 26, 14, 5, (230, 95, 20, 255)) # horn L
    draw_circle(p, 38, 14, 5, (230, 95, 20, 255)) # horn R
    draw_circle(p, 52, 48, 8, (245, 180, 0, 255)) # tail fire
    draw_circle(p, 52, 48, 5, (239, 68, 68, 255)) # inner fire
    save_png(os.path.join(out_dir, "charizard.png"), size, size, p)

    # Gyarados: Deep blue serpentine sea dragon, fierce jagged fin, gaping jaw
    p = create_blank(size, size)
    draw_circle(p, 32, 16, 8, (60, 160, 220, 255)) # crest
    draw_circle(p, 32, 32, 20, (30, 100, 190, 255)) # dragon body
    draw_circle(p, 32, 42, 14, (245, 235, 175, 255)) # cream belly underbelly
    draw_circle(p, 24, 28, 4, (220, 38, 38, 255)) # red eye L
    draw_circle(p, 40, 28, 4, (220, 38, 38, 255)) # red eye R
    draw_rect(p, 26, 36, 38, 44, (30, 25, 35, 255)) # open roaring mouth
    save_png(os.path.join(out_dir, "gyarados.png"), size, size, p)

    # Dragonite: Gentle orange dragon, teal small wings, antennea, cream belly
    p = create_blank(size, size)
    draw_circle(p, 16, 26, 9, (80, 180, 160, 255)) # wing L
    draw_circle(p, 48, 26, 9, (80, 180, 160, 255)) # wing R
    draw_circle(p, 32, 40, 21, (240, 160, 45, 255)) # body
    draw_circle(p, 32, 43, 15, (245, 235, 180, 255)) # belly
    draw_circle(p, 32, 24, 14, (240, 160, 45, 255)) # head
    draw_circle(p, 26, 12, 3, (245, 240, 200, 255)) # horn L
    draw_circle(p, 38, 12, 3, (245, 240, 200, 255)) # horn R
    draw_circle(p, 26, 23, 4, (30, 110, 100, 255)) # kind teal eye L
    draw_circle(p, 38, 23, 4, (30, 110, 100, 255)) # kind teal eye R
    save_png(os.path.join(out_dir, "dragonite.png"), size, size, p)

    # Mewtwo: Sleek pale lilac body, purple tail tube, glowing psychic violet eyes
    p = create_blank(size, size)
    draw_circle(p, 46, 44, 14, (130, 60, 180, 255)) # purple tail
    draw_circle(p, 32, 38, 17, (225, 220, 240, 255)) # silver body
    draw_circle(p, 32, 44, 12, (170, 110, 220, 255)) # violet underbody
    draw_circle(p, 32, 22, 13, (225, 220, 240, 255)) # head
    draw_circle(p, 25, 13, 5, (210, 200, 230, 255)) # horn L
    draw_circle(p, 39, 13, 5, (210, 200, 230, 255)) # horn R
    draw_circle(p, 27, 21, 4, (168, 85, 247, 255)) # psychic eye L
    draw_circle(p, 37, 21, 4, (168, 85, 247, 255)) # psychic eye R
    save_png(os.path.join(out_dir, "mewtwo.png"), size, size, p)

def generate_board_tiles(out_dir):
    # Combat board tiles (64x64)
    size = 64
    
    # Player tile: Calm slate with subtle teal border
    p = create_blank(size, size, (35, 45, 60, 200))
    for i in range(size):
        p[0][i] = (70, 100, 140, 255)
        p[size-1][i] = (25, 30, 45, 255)
        p[i][0] = (70, 100, 140, 255)
        p[i][size-1] = (25, 30, 45, 255)
    save_png(os.path.join(out_dir, "tile_player.png"), size, size, p)
    
    # Enemy tile: Menacing dark crimson with subtle red border
    p = create_blank(size, size, (55, 30, 35, 200))
    for i in range(size):
        p[0][i] = (120, 50, 60, 255)
        p[size-1][i] = (35, 18, 22, 255)
        p[i][0] = (120, 50, 60, 255)
        p[i][size-1] = (35, 18, 22, 255)
    save_png(os.path.join(out_dir, "tile_enemy.png"), size, size, p)

    # Highlight tile (when hovering / placing): luminous gold / green
    p = create_blank(size, size, (50, 200, 120, 120))
    for i in range(size):
        p[0][i] = (100, 255, 160, 255)
        p[size-1][i] = (100, 255, 160, 255)
        p[i][0] = (100, 255, 160, 255)
        p[i][size-1] = (100, 255, 160, 255)
    save_png(os.path.join(out_dir, "tile_highlight.png"), size, size, p)

    # Star icons (24x24) for unit star ratings
    s_size = 24
    p = create_blank(s_size, s_size)
    draw_circle(p, 12, 12, 10, (245, 180, 0, 255))
    draw_circle(p, 12, 12, 6, (255, 240, 100, 255))
    save_png(os.path.join(out_dir, "star_badge.png"), s_size, s_size, p)

    # Gold coin icon (28x28)
    c_size = 28
    p = create_blank(c_size, c_size)
    draw_circle(p, 14, 14, 12, (217, 119, 6, 255))
    draw_circle(p, 14, 14, 10, (245, 158, 11, 255))
    draw_circle(p, 14, 14, 7, (252, 211, 77, 255))
    draw_rect(p, 13, 9, 15, 19, (180, 83, 9, 255))
    save_png(os.path.join(out_dir, "coin.png"), c_size, c_size, p)

def main():
    root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    units_dir = os.path.join(root, "assets", "units")
    ui_dir = os.path.join(root, "assets", "ui")
    arena_dir = os.path.join(root, "assets", "arena")

    print("Generating unit sprites...")
    generate_unit_sprites(units_dir)
    print("Generating type badges...")
    generate_type_icons(ui_dir)
    print("Generating board tiles & UI elements...")
    generate_board_tiles(arena_dir)
    # Also link UI coin to ui dir
    generate_board_tiles(ui_dir)
    print("All sprites generated successfully!")

if __name__ == "__main__":
    main()
