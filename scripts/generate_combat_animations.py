#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
generate_combat_animations.py
Generates distinct combat action sprites for all 152 Pokemon:
- attack_physical_0..5.png: explosive lunge, forward compression, slash arc & impact sparks
- attack_special_0..5.png: energy charge, muzzle glow, projectile release recoil
- cast_skill_0..5.png: deep crouch, apex levitation, glowing radiant aura, massive blast shockwave
"""

import os
import re
import math
import time
from PIL import Image, ImageDraw, ImageEnhance

ANIM_DIR = "assets/units/anim"
DB_PATH = "scripts/autoload/pokemon_database.gd"

def get_pokemon_types():
    with open(DB_PATH, "r", encoding="utf-8") as f:
        content = f.read()
    
    types_map = {}
    pattern = re.compile(r'^\t"([a-z0-9_-]+)": \{[\s\S]*?"types":\s*\[([^\]]+)\]', re.MULTILINE)
    for m in pattern.finditer(content):
        pid = m.group(1)
        raw_types = [t.strip().strip('"').strip("'") for t in m.group(2).split(",")]
        types_map[pid] = raw_types
    return types_map

def get_type_colors(primary_type):
    # Returns (core_rgba, glow_rgba, highlight_rgba)
    color_schemes = {
        "Fire": ((255, 120, 20, 230), (255, 60, 10, 160), (255, 230, 120, 255)),
        "Water": ((40, 170, 255, 230), (20, 100, 240, 160), (180, 235, 255, 255)),
        "Electric": ((255, 235, 40, 240), (255, 180, 20, 170), (255, 255, 200, 255)),
        "Grass": ((70, 220, 80, 230), (30, 150, 40, 160), (200, 255, 180, 255)),
        "Ice": ((150, 230, 255, 230), (80, 170, 255, 160), (235, 250, 255, 255)),
        "Psychic": ((245, 65, 190, 230), (180, 30, 200, 160), (255, 210, 245, 255)),
        "Ghost": ((175, 75, 245, 230), (110, 30, 210, 160), (230, 190, 255, 255)),
        "Dragon": ((110, 95, 255, 230), (60, 40, 220, 160), (210, 200, 255, 255)),
        "Poison": ((190, 60, 225, 230), (120, 25, 170, 160), (240, 180, 255, 255)),
        "Ground": ((225, 160, 50, 230), (160, 100, 25, 160), (255, 225, 160, 255)),
        "Rock": ((195, 170, 100, 230), (140, 115, 60, 160), (245, 235, 190, 255)),
        "Fighting": ((235, 95, 45, 230), (170, 50, 20, 160), (255, 210, 150, 255)),
        "Bug": ((155, 205, 45, 230), (100, 150, 20, 160), (225, 250, 150, 255)),
        "Flying": ((145, 185, 245, 230), (95, 130, 220, 160), (225, 240, 255, 255)),
        "Normal": ((220, 200, 160, 230), (160, 140, 100, 150), (255, 245, 220, 255))
    }
    return color_schemes.get(primary_type, color_schemes["Normal"])

def draw_star(draw, cx, cy, r_inner, r_outer, points, color):
    pts = []
    angle_step = math.pi / points
    for i in range(2 * points):
        r = r_outer if i % 2 == 0 else r_inner
        angle = i * angle_step - math.pi / 2
        pts.append((cx + r * math.cos(angle), cy + r * math.sin(angle)))
    draw.polygon(pts, fill=color)

def generate_animations_for_pokemon(pid, types):
    p_dir = os.path.join(ANIM_DIR, pid)
    if not os.path.exists(p_dir):
        return False

    primary_type = types[0] if types else "Normal"
    core_col, glow_col, high_col = get_type_colors(primary_type)

    # 1. Load base frames (walk_0..5 or idle)
    base_frames = []
    for i in range(6):
        wp = os.path.join(p_dir, f"walk_{i}.png")
        if os.path.exists(wp):
            base_frames.append(Image.open(wp).convert("RGBA"))
        elif os.path.exists(os.path.join(p_dir, "idle.png")):
            base_frames.append(Image.open(os.path.join(p_dir, "idle.png")).convert("RGBA"))
        else:
            return False

    # Get bounding box of content in frame 0
    bbox = base_frames[0].getbbox() or (16, 16, 112, 112)
    center_x = (bbox[0] + bbox[2]) // 2
    center_y = (bbox[1] + bbox[3]) // 2
    front_x = bbox[2]
    bottom_y = bbox[3]

    # =========================================================
    # 2. GENERATE attack_physical_0..5.png
    # =========================================================
    # Frame 0: Anticipation - lean back (-4px, +2px)
    # Frame 1: Explosive Dash (+8px, -2px)
    # Frame 2: Max Impact Lunge (+18px, -1px) + Slash Arc
    # Frame 3: Strike Follow-through (+14px, 0px) + Fading Arc
    # Frame 4: Recoil Bounce (+6px, +1px)
    # Frame 5: Return to Stance (0px, 0px)
    phys_offsets = [(-4, 2), (8, -2), (18, -1), (14, 0), (6, 1), (0, 0)]
    for i, (dx, dy) in enumerate(phys_offsets):
        canvas = Image.new("RGBA", (128, 128), (0, 0, 0, 0))
        src = base_frames[i]

        # Slight squash/stretch for physical momentum
        if i == 0: # squash
            w, h = src.width, int(src.height * 0.96)
            scaled = src.resize((w, h), Image.BILINEAR)
            canvas.paste(scaled, (dx, dy + (src.height - h)), scaled)
        elif i == 1 or i == 2: # stretch forward
            w, h = int(src.width * 1.05), int(src.height * 0.97)
            scaled = src.resize((w, h), Image.BILINEAR)
            canvas.paste(scaled, (dx - (w - src.width) // 2, dy), scaled)
        else:
            canvas.paste(src, (dx, dy), src)

        draw = ImageDraw.Draw(canvas)

        # Effects
        if i == 1:
            # Wind / speed streak behind body
            draw.line([center_x - 30 + dx, center_y + dy, center_x - 12 + dx, center_y + dy], fill=(255, 255, 255, 120), width=2)
            draw.line([center_x - 24 + dx, center_y + 12 + dy, center_x - 8 + dx, center_y + 12 + dy], fill=(255, 255, 255, 90), width=1)
        elif i == 2:
            # Brilliant Curved Slash Blade Arc
            arc_cx = front_x + dx + 4
            arc_cy = center_y + dy
            # Outer glow arc
            draw.arc([arc_cx - 16, arc_cy - 24, arc_cx + 18, arc_cy + 24], -75, 75, fill=core_col, width=4)
            # Inner sharp highlight arc
            draw.arc([arc_cx - 14, arc_cy - 22, arc_cx + 16, arc_cy + 22], -70, 70, fill=high_col, width=2)
            # Impact sparks
            for sp_dx, sp_dy in [(12, -14), (16, -4), (18, 6), (14, 16), (22, 0)]:
                draw.rectangle([arc_cx + sp_dx, arc_cy + sp_dy, arc_cx + sp_dx + 2, arc_cy + sp_dy + 2], fill=high_col)
        elif i == 3:
            # Fading slash arc & dissolving sparks
            arc_cx = front_x + dx + 6
            arc_cy = center_y + dy
            fade_col = (core_col[0], core_col[1], core_col[2], 120)
            draw.arc([arc_cx - 18, arc_cy - 26, arc_cx + 20, arc_cy + 26], -65, 65, fill=fade_col, width=2)
            # Dissolving spark points
            for sp_dx, sp_dy in [(16, -18), (22, -6), (24, 8), (18, 20)]:
                draw.point((arc_cx + sp_dx, arc_cy + sp_dy), fill=high_col)

        canvas.save(os.path.join(p_dir, f"attack_physical_{i}.png"), "PNG")

    # =========================================================
    # 3. GENERATE attack_special_0..5.png
    # =========================================================
    # Frame 0: Focus stance (0, 1)
    # Frame 1: Gathering energy (-4, -1) + small gathering glow
    # Frame 2: Max charge (-6, -2) + glowing charged energy orb & spark cross
    # Frame 3: Blast release recoil (-8, 0) + muzzle blast burst (+20px)
    # Frame 4: Dissipation recovery (-3, 1) + projectile dissipation trail
    # Frame 5: Reset (0, 0)
    spec_offsets = [(0, 1), (-4, -1), (-6, -2), (-8, 0), (-3, 1), (0, 0)]
    for i, (dx, dy) in enumerate(spec_offsets):
        canvas = Image.new("RGBA", (128, 128), (0, 0, 0, 0))
        src = base_frames[i]
        canvas.paste(src, (dx, dy), src)
        draw = ImageDraw.Draw(canvas)

        muzzle_x = front_x + dx + 2
        muzzle_y = center_y + dy - 2

        if i == 1:
            # Energy gathering particles & small glowing center
            draw.ellipse([muzzle_x - 4, muzzle_y - 4, muzzle_x + 4, muzzle_y + 4], fill=glow_col)
            draw.ellipse([muzzle_x - 2, muzzle_y - 2, muzzle_x + 2, muzzle_y + 2], fill=high_col)
            # Inward gathering sparks
            for gx, gy in [(-8, -6), (-6, 7), (10, -5), (8, 6)]:
                draw.point((muzzle_x + gx, muzzle_y + gy), fill=high_col)
        elif i == 2:
            # Large pulsing charged energy sphere
            draw.ellipse([muzzle_x - 9, muzzle_y - 9, muzzle_x + 9, muzzle_y + 9], fill=glow_col)
            draw.ellipse([muzzle_x - 6, muzzle_y - 6, muzzle_x + 6, muzzle_y + 6], fill=core_col)
            draw.ellipse([muzzle_x - 3, muzzle_y - 3, muzzle_x + 3, muzzle_y + 3], fill=high_col)
            # Radiant flare cross
            draw.line([muzzle_x - 14, muzzle_y, muzzle_x + 14, muzzle_y], fill=high_col, width=2)
            draw.line([muzzle_x, muzzle_y - 14, muzzle_x, muzzle_y + 14], fill=high_col, width=2)
        elif i == 3:
            # Muzzle flash burst & outward projectile blast
            draw.ellipse([muzzle_x - 4, muzzle_y - 7, muzzle_x + 6, muzzle_y + 7], fill=core_col)
            draw.ellipse([muzzle_x - 2, muzzle_y - 4, muzzle_x + 4, muzzle_y + 4], fill=high_col)
            # Forward conical shockwave rays
            draw.line([muzzle_x + 4, muzzle_y, muzzle_x + 24, muzzle_y], fill=high_col, width=3)
            draw.line([muzzle_x + 4, muzzle_y - 2, muzzle_x + 20, muzzle_y - 10], fill=core_col, width=2)
            draw.line([muzzle_x + 4, muzzle_y + 2, muzzle_x + 20, muzzle_y + 10], fill=core_col, width=2)
            # Sparks
            for sx, sy in [(22, -6), (26, 0), (22, 6), (16, -12), (16, 12)]:
                draw.rectangle([muzzle_x + sx, muzzle_y + sy, muzzle_x + sx + 2, muzzle_y + sy + 2], fill=high_col)
        elif i == 4:
            # Dissipating energy smoke and flying spark bullet
            fade_col = (core_col[0], core_col[1], core_col[2], 100)
            draw.ellipse([muzzle_x + 8, muzzle_y - 4, muzzle_x + 16, muzzle_y + 4], fill=fade_col)
            draw.rectangle([muzzle_x + 22, muzzle_y - 1, muzzle_x + 28, muzzle_y + 1], fill=high_col)

        canvas.save(os.path.join(p_dir, f"attack_special_{i}.png"), "PNG")

    # =========================================================
    # 4. GENERATE cast_skill_0..5.png
    # =========================================================
    # Frame 0: Deep crouch (+4px y) + ground summoning circle
    # Frame 1: Rising surge (-6px y) + rising waist aura ring
    # Frame 2: Supreme levitation apex (-16px y, 1.05x) + brilliant radiant aura halo
    # Frame 3: Detonation explosion (-14px y) + massive shockwave burst & starburst rays
    # Frame 4: Floating descent (-6px y) + cascading sparkles
    # Frame 5: Landing (+1px y -> 0)
    cast_offsets = [(0, 4), (0, -6), (0, -16), (0, -14), (0, -6), (0, 1)]
    for i, (dx, dy) in enumerate(cast_offsets):
        canvas = Image.new("RGBA", (128, 128), (0, 0, 0, 0))
        src = base_frames[i]

        if i == 0: # Deep crouch
            w, h = int(src.width * 1.06), int(src.height * 0.92)
            scaled = src.resize((w, h), Image.BILINEAR)
            canvas.paste(scaled, (dx - (w - src.width) // 2, dy + (src.height - h)), scaled)
        elif i == 2 or i == 3: # Floating at apex slightly empowered
            w, h = int(src.width * 1.06), int(src.height * 1.06)
            scaled = src.resize((w, h), Image.BILINEAR)
            canvas.paste(scaled, (dx - (w - src.width) // 2, dy - (h - src.height) // 2), scaled)
        else:
            canvas.paste(src, (dx, dy), src)

        draw = ImageDraw.Draw(canvas)

        cur_cx = center_x + dx
        cur_cy = center_y + dy

        if i == 0:
            # Ground charging ellipse
            draw.ellipse([cur_cx - 24, bottom_y - 2, cur_cx + 24, bottom_y + 8], outline=core_col, width=2)
            draw.ellipse([cur_cx - 16, bottom_y, cur_cx + 16, bottom_y + 6], fill=glow_col)
        elif i == 1:
            # Rising energy aura ring around body
            draw.ellipse([cur_cx - 28, cur_cy + 8, cur_cx + 28, cur_cy + 22], outline=glow_col, width=3)
            draw.ellipse([cur_cx - 22, cur_cy + 10, cur_cx + 22, cur_cy + 20], outline=high_col, width=2)
            # Vertical energy ribbons shooting up
            for vx, vy in [(-18, 0), (-8, -10), (8, -10), (18, 0)]:
                draw.line([cur_cx + vx, cur_cy + 18 + vy, cur_cx + vx, cur_cy - 12 + vy], fill=high_col, width=2)
        elif i == 2:
            # Full radiant halo / aura ring around character apex
            draw.ellipse([cur_cx - 36, cur_cy - 36, cur_cx + 36, cur_cy + 36], outline=glow_col, width=3)
            draw.ellipse([cur_cx - 30, cur_cy - 30, cur_cx + 30, cur_cy + 30], outline=core_col, width=2)
            # Radiant sparkle stars in 4 cardinal directions
            for ang in [0, math.pi/2, math.pi, 3*math.pi/2]:
                sx = cur_cx + 38 * math.cos(ang)
                sy = cur_cy + 38 * math.sin(ang)
                draw_star(draw, sx, sy, 2, 6, 4, high_col)
        elif i == 3:
            # Massive explosive shockwave ring & 8-point starburst
            draw.ellipse([cur_cx - 44, cur_cy - 44, cur_cx + 44, cur_cy + 44], outline=glow_col, width=4)
            draw.ellipse([cur_cx - 38, cur_cy - 38, cur_cx + 38, cur_cy + 38], outline=high_col, width=2)
            # 8-point radial flare beams
            for b_idx in range(8):
                ang = b_idx * (math.pi / 4.0)
                bx1 = cur_cx + 26 * math.cos(ang)
                by1 = cur_cy + 26 * math.sin(ang)
                bx2 = cur_cx + 48 * math.cos(ang)
                by2 = cur_cy + 48 * math.sin(ang)
                draw.line([bx1, by1, bx2, by2], fill=high_col, width=2)
            # Core burst center
            draw_star(draw, cur_cx, cur_cy, 4, 12, 4, high_col)
        elif i == 4:
            # Floating descent with cascading magical sparkles
            for sp_dx, sp_dy in [(-24, -20), (-16, 14), (20, -16), (18, 18), (0, -28), (-26, 4), (26, 4)]:
                draw_star(draw, cur_cx + sp_dx, cur_cy + sp_dy, 1, 4, 4, high_col)
        elif i == 5:
            # Landing dust & settling ground ripples
            draw.ellipse([cur_cx - 20, bottom_y + 1, cur_cx + 20, bottom_y + 7], outline=glow_col, width=1)
            for d_dx in [-18, -12, 12, 18]:
                draw.circle = draw.ellipse([cur_cx + d_dx - 2, bottom_y + 2, cur_cx + d_dx + 2, bottom_y + 6], fill=(220, 220, 220, 160))

        canvas.save(os.path.join(p_dir, f"cast_skill_{i}.png"), "PNG")

    return True

def main():
    t_start = time.time()
    types_map = get_pokemon_types()
    print(f"Loaded types for {len(types_map)} Pokemon.")

    all_pids = sorted([d for d in os.listdir(ANIM_DIR) if os.path.isdir(os.path.join(ANIM_DIR, d))])
    print(f"Found {len(all_pids)} Pokemon animation directories.")

    success_count = 0
    for pid in all_pids:
        types = types_map.get(pid, ["Normal"])
        if generate_animations_for_pokemon(pid, types):
            success_count += 1

    print(f"Successfully generated attack_physical, attack_special, and cast_skill for {success_count}/{len(all_pids)} Pokemon!")
    print(f"Total time elapsed: {time.time() - t_start:.2f}s")

if __name__ == "__main__":
    main()
