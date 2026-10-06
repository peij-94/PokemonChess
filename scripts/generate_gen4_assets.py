#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
generate_gen4_assets.py
Generates 2D authentic assets for Generation 4 (#387 Turtwig ~ #493 Arceus) Pokemon:
- 256x256 Dream World transparent avatars in assets/units/{pid}.png
- 128x128 Gen V animated pixel sprite sets in assets/units/anim/{pid}/
"""

import os
import re
import csv
import math
import time
import tarfile
import subprocess
from concurrent.futures import ProcessPoolExecutor, as_completed
from PIL import Image, ImageSequence, ImageDraw, ImageEnhance

UNITS_DIR = "assets/units"
ANIM_DIR = "assets/units/anim"
CACHE_TAR = "scripts/cache/pokeapi-sprites.tgz"
TEMP_DIR = "/tmp/poke_gen4"

os.makedirs(TEMP_DIR, exist_ok=True)
os.makedirs(UNITS_DIR, exist_ok=True)
os.makedirs(ANIM_DIR, exist_ok=True)

TYPE_ID_MAP = {
    1: 'Normal', 2: 'Fighting', 3: 'Flying', 4: 'Poison', 5: 'Ground',
    6: 'Rock', 7: 'Bug', 8: 'Ghost', 9: 'Steel', 10: 'Fire',
    11: 'Water', 12: 'Grass', 13: 'Electric', 14: 'Psychic',
    15: 'Ice', 16: 'Dragon', 17: 'Dark', 18: 'Fairy'
}

SPECIAL_SLUGS = {
    413: "wormadam",
    439: "mime_jr",
    474: "porygon_z",
    487: "giratina",
    492: "shaymin",
}

def load_pokemon_metadata():
    pokemon_types = {}
    with open("scripts/cache/pokemon_types.csv", "r", encoding="utf-8") as f:
        for row in csv.DictReader(f):
            pid = int(row["pokemon_id"])
            if 387 <= pid <= 493:
                if pid not in pokemon_types:
                    pokemon_types[pid] = []
                pokemon_types[pid].append(TYPE_ID_MAP[int(row["type_id"])])

    pokemon_list = []
    with open("scripts/cache/pokemon.csv", "r", encoding="utf-8") as f:
        for row in csv.DictReader(f):
            num = int(row["id"])
            if 387 <= num <= 493:
                if num == 448:
                    continue  # Lucario already has complete assets
                slug = SPECIAL_SLUGS.get(num, row["identifier"]).replace("-", "_")
                pokemon_list.append({
                    "num": num,
                    "id": slug,
                    "types": pokemon_types.get(num, ["Normal"])
                })
    return pokemon_list

def get_type_colors(primary_type):
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
        "Dark": ((80, 70, 90, 230), (45, 35, 55, 160), (180, 165, 200, 255)),
        "Steel": ((180, 195, 205, 230), (120, 135, 145, 160), (235, 245, 255, 255)),
        "Fairy": ((245, 140, 185, 230), (185, 60, 125, 160), (255, 220, 240, 255)),
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

def make_mask_svg(svg_content):
    res = re.sub(r'fill="[^"]+"', 'fill="#000000"', svg_content)
    res = re.sub(r'stroke="[^"]+"', 'stroke="#000000"', res)
    res = re.sub(r'fill:[^;"]+', 'fill:#000000', res)
    res = re.sub(r'stroke:[^;"]+', 'stroke:#000000', res)
    res = re.sub(r'opacity="[^"]+"', 'opacity="1"', res)
    return res

def batch_render_avatars(pokemon_list):
    needed_list = [p for p in pokemon_list if not os.path.exists(os.path.join(UNITS_DIR, f"{p['id']}.png"))]
    print(f"Total avatars to generate: {len(needed_list)}")
    if not needed_list:
        return

    tar = tarfile.open(CACHE_TAR, "r:gz")

    batch_size = 35
    for b_start in range(0, len(needed_list), batch_size):
        chunk = needed_list[b_start:b_start + batch_size]
        files_to_render = []
        info_map = {}

        for p in chunk:
            num = p["num"]
            pid = p["id"]
            svg_member = f"package/sprites/pokemon/other/dream-world/{num}.svg"
            try:
                f_in = tar.extractfile(svg_member)
                raw_svg = f_in.read().decode("utf-8")
            except Exception as e:
                print(f"Warning: SVG for #{num} not found in tar: {e}")
                continue

            svg_file = os.path.join(TEMP_DIR, f"{num}.svg")
            mask_file = os.path.join(TEMP_DIR, f"{num}_mask.svg")

            with open(svg_file, "w", encoding="utf-8") as f:
                f.write(raw_svg)

            mask_svg = make_mask_svg(raw_svg)
            with open(mask_file, "w", encoding="utf-8") as f:
                f.write(mask_svg)

            files_to_render.extend([svg_file, mask_file])
            info_map[num] = pid

        if files_to_render:
            subprocess.run(["qlmanage", "-t", "-s", "256", "-o", TEMP_DIR] + files_to_render,
                           stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

        for num, pid in info_map.items():
            svg_file = os.path.join(TEMP_DIR, f"{num}.svg")
            mask_file = os.path.join(TEMP_DIR, f"{num}_mask.svg")
            col_png = f"{svg_file}.png"
            mask_png = f"{mask_file}.png"

            if not os.path.exists(col_png) or not os.path.exists(mask_png):
                continue

            try:
                col_img = Image.open(col_png).convert("RGB")
                mask_img = Image.open(mask_png).convert("L")
                alpha = mask_img.point(lambda p: 255 - p)

                raw_art = Image.new("RGBA", col_img.size, (0, 0, 0, 0))
                raw_art.paste(col_img, (0, 0), alpha)

                bbox = raw_art.getbbox()
                if bbox:
                    cropped = raw_art.crop(bbox)
                    max_dim = 216
                    scale_factor = min(max_dim / cropped.width, max_dim / cropped.height)
                    new_w = max(1, int(cropped.width * scale_factor))
                    new_h = max(1, int(cropped.height * scale_factor))
                    resized = cropped.resize((new_w, new_h), Image.LANCZOS)

                    avatar = Image.new("RGBA", (256, 256), (0, 0, 0, 0))
                    paste_x = (256 - new_w) // 2
                    paste_y = (256 - new_h) // 2
                    avatar.paste(resized, (paste_x, paste_y), resized)

                    avatar_path = os.path.join(UNITS_DIR, f"{pid}.png")
                    avatar.save(avatar_path, "PNG")
            except Exception as e:
                print(f"Error processing avatar #{num} {pid}: {e}")
            finally:
                for tf in [svg_file, mask_file, col_png, mask_png]:
                    try:
                        os.remove(tf)
                    except:
                        pass
        print(f"  Processed {min(b_start + batch_size, len(needed_list))}/{len(needed_list)} avatars...")
    tar.close()

def worker_render_sprites(p):
    num = p["num"]
    pid = p["id"]
    types = p["types"]
    primary_type = types[0] if types else "Normal"
    core_col, glow_col, high_col = get_type_colors(primary_type)

    p_anim_dir = os.path.join(ANIM_DIR, pid)
    # Check if already complete
    if os.path.exists(os.path.join(p_anim_dir, "cast_skill_5.png")) and os.path.exists(os.path.join(p_anim_dir, "attack_physical_5.png")):
        return (pid, True)

    os.makedirs(p_anim_dir, exist_ok=True)

    with tarfile.open(CACHE_TAR, "r:gz") as tar:
        gif_member = f"package/sprites/pokemon/versions/generation-v/black-white/animated/{num}.gif"
        try:
            gif_file = tar.extractfile(gif_member)
            im = Image.open(gif_file)
            gif_frames = [f.copy().convert("RGBA") for f in ImageSequence.Iterator(im)]
        except Exception:
            return (pid, False)

    if not gif_frames:
        return (pid, False)

    f0_bbox = gif_frames[0].getbbox()
    if not f0_bbox:
        f0_bbox = (0, 0, gif_frames[0].width, gif_frames[0].height)

    content_w = f0_bbox[2] - f0_bbox[0]
    content_h = f0_bbox[3] - f0_bbox[1]
    if content_h <= 0 or content_w <= 0:
        content_w, content_h = gif_frames[0].width, gif_frames[0].height
        f0_bbox = (0, 0, content_w, content_h)

    if content_w > content_h * 1.3:
        target_w = 90
        scale = target_w / max(1, content_w)
        target_h = int(content_h * scale)
    else:
        target_h = 88
        scale = target_h / max(1, content_h)
        target_w = int(content_w * scale)

    target_w = max(10, min(112, target_w))
    target_h = max(10, min(104, target_h))

    def make_canvas():
        return Image.new("RGBA", (128, 128), (0, 0, 0, 0))

    def scale_crop_frame(frame):
        cropped = frame.crop(f0_bbox)
        return cropped.resize((target_w, target_h), Image.NEAREST)

    base_x = (128 - target_w) // 2
    base_bottom = 120
    base_y = base_bottom - target_h

    # 1. IDLE
    f_idle = scale_crop_frame(gif_frames[0])
    img_idle = make_canvas()
    img_idle.paste(f_idle, (base_x, base_y), f_idle)
    img_idle.save(os.path.join(p_anim_dir, "idle.png"), "PNG")

    # 2. WALK 0..5
    walk_y_offsets = [0, -3, -5, -4, -1, 0]
    walk_x_tilts = [0, 1, 0, -1, 0, 0]
    for i in range(6):
        src_f = gif_frames[i % len(gif_frames)]
        sc_f = scale_crop_frame(src_f)
        img = make_canvas()
        img.paste(sc_f, (base_x + walk_x_tilts[i], base_y + walk_y_offsets[i]), sc_f)
        img.save(os.path.join(p_anim_dir, f"walk_0.png" if False else f"walk_{i}.png"), "PNG")

    # 3. ATTACK 0..5
    atk_offsets = [(0, 0), (-3, 1), (12, -4), (16, -2), (6, 0), (0, 0)]
    for i in range(6):
        src_f = gif_frames[min(i, len(gif_frames) - 1)]
        sc_f = scale_crop_frame(src_f)
        dx, dy = atk_offsets[i]
        img = make_canvas()
        img.paste(sc_f, (base_x + dx, base_y + dy), sc_f)
        img.save(os.path.join(p_anim_dir, f"attack_{i}.png"), "PNG")

    # 4. HURT 0..1
    hurt_offsets = [(-8, 3), (-4, 1)]
    for i in range(2):
        src_f = gif_frames[0]
        sc_f = scale_crop_frame(src_f)
        r, g, b, a = sc_f.split()
        r = r.point(lambda p: min(255, int(p * 1.5 + 60)))
        g = g.point(lambda p: int(p * 0.4))
        b = b.point(lambda p: int(p * 0.4))
        tinted = Image.merge("RGBA", (r, g, b, a))
        dx, dy = hurt_offsets[i]
        img = make_canvas()
        img.paste(tinted, (base_x + dx, base_y + dy), tinted)
        img.save(os.path.join(p_anim_dir, f"hurt_{i}.png"), "PNG")

    # 5. ATTACK_PHYSICAL 0..5 (Slash FX)
    phys_offsets = [(-4, 0), (-8, 2), (18, -6), (24, -2), (10, 0), (0, 0)]
    for i in range(6):
        src_f = gif_frames[min(i, len(gif_frames) - 1)]
        sc_f = scale_crop_frame(src_f)
        dx, dy = phys_offsets[i]
        img = make_canvas()
        img.paste(sc_f, (base_x + dx, base_y + dy), sc_f)
        draw = ImageDraw.Draw(img)

        front_x = base_x + dx + target_w - 4
        front_y = base_y + dy + target_h // 2

        if i == 2:
            draw.line([(front_x - 12, front_y - 20), (front_x + 16, front_y + 12)], fill=glow_col, width=5)
            draw.line([(front_x - 10, front_y - 18), (front_x + 14, front_y + 10)], fill=high_col, width=2)
        elif i == 3:
            draw.line([(front_x - 16, front_y - 26), (front_x + 24, front_y + 18)], fill=core_col, width=6)
            draw.line([(front_x - 14, front_y - 24), (front_x + 22, front_y + 16)], fill=(255, 255, 255, 255), width=3)
            draw_star(draw, front_x + 24, front_y + 18, 3, 9, 4, high_col)
        elif i == 4:
            draw.line([(front_x - 6, front_y - 12), (front_x + 18, front_y + 8)], fill=glow_col, width=4)

        img.save(os.path.join(p_anim_dir, f"attack_physical_{i}.png"), "PNG")

    # 6. ATTACK_SPECIAL 0..5 (Orb FX)
    spec_offsets = [(0, 0), (-2, -1), (-4, -2), (6, -2), (2, -1), (0, 0)]
    for i in range(6):
        src_f = gif_frames[min(i, len(gif_frames) - 1)]
        sc_f = scale_crop_frame(src_f)
        dx, dy = spec_offsets[i]
        img = make_canvas()
        img.paste(sc_f, (base_x + dx, base_y + dy), sc_f)
        draw = ImageDraw.Draw(img)

        cx = base_x + dx + target_w + 2
        cy = base_y + dy + target_h // 2 - 4

        if i == 1:
            draw.ellipse([cx - 5, cy - 5, cx + 5, cy + 5], fill=glow_col)
            draw.ellipse([cx - 2, cy - 2, cx + 2, cy + 2], fill=high_col)
        elif i == 2:
            draw.ellipse([cx - 10, cy - 10, cx + 10, cy + 10], fill=glow_col)
            draw.ellipse([cx - 6, cy - 6, cx + 6, cy + 6], fill=core_col)
            draw.ellipse([cx - 3, cy - 3, cx + 3, cy + 3], fill=(255, 255, 255, 255))
        elif i == 3:
            proj_x = cx + 14
            draw.ellipse([proj_x - 14, cy - 12, proj_x + 14, cy + 12], fill=glow_col)
            draw.ellipse([proj_x - 9, cy - 8, proj_x + 9, cy + 8], fill=core_col)
            draw.ellipse([proj_x - 4, cy - 4, proj_x + 4, cy + 4], fill=(255, 255, 255, 255))
            draw.line([(cx, cy), (proj_x - 8, cy)], fill=high_col, width=4)
        elif i == 4:
            proj_x = cx + 28
            draw.ellipse([proj_x - 8, cy - 7, proj_x + 8, cy + 7], fill=core_col)
            draw_star(draw, proj_x, cy, 3, 10, 4, high_col)
        elif i == 5:
            proj_x = cx + 32
            draw.ellipse([proj_x - 4, cy - 4, proj_x + 4, cy + 4], fill=glow_col)

        img.save(os.path.join(p_anim_dir, f"attack_special_{i}.png"), "PNG")

    # 7. CAST_SKILL 0..5 (Aura Burst FX)
    cast_offsets = [(0, 0), (0, 3), (0, -4), (0, -8), (0, -4), (0, 0)]
    for i in range(6):
        src_f = gif_frames[min(i, len(gif_frames) - 1)]
        sc_f = scale_crop_frame(src_f)
        dx, dy = cast_offsets[i]
        img = make_canvas()
        draw = ImageDraw.Draw(img)

        unit_cx = base_x + target_w // 2
        ground_cy = base_bottom - 2

        if i == 1:
            draw.ellipse([unit_cx - 24, ground_cy - 6, unit_cx + 24, ground_cy + 6], fill=glow_col)
        elif i == 2:
            draw.ellipse([unit_cx - 34, ground_cy - 9, unit_cx + 34, ground_cy + 9], fill=glow_col)
            draw.ellipse([unit_cx - 20, ground_cy - 5, unit_cx + 20, ground_cy + 5], fill=core_col)
        elif i == 3:
            draw.ellipse([unit_cx - 42, ground_cy - 11, unit_cx + 42, ground_cy + 11], fill=glow_col)
            draw.ellipse([unit_cx - 28, ground_cy - 7, unit_cx + 28, ground_cy + 7], fill=core_col)
            draw.ellipse([unit_cx - 14, ground_cy - 4, unit_cx + 14, ground_cy + 4], fill=high_col)
            for star_off in [(-22, -26), (22, -28), (-16, 12), (18, 14)]:
                draw_star(draw, unit_cx + star_off[0], base_y + dy + target_h // 2 + star_off[1], 2, 7, 4, high_col)
        elif i == 4:
            draw.ellipse([unit_cx - 36, ground_cy - 9, unit_cx + 36, ground_cy + 9], fill=glow_col)
            draw.ellipse([unit_cx - 20, ground_cy - 5, unit_cx + 20, ground_cy + 5], fill=core_col)
            for star_off in [(-28, -12), (28, -14)]:
                draw_star(draw, unit_cx + star_off[0], base_y + dy + target_h // 2 + star_off[1], 2, 6, 4, high_col)
        elif i == 5:
            draw.ellipse([unit_cx - 22, ground_cy - 5, unit_cx + 22, ground_cy + 5], fill=glow_col)

        img.paste(sc_f, (base_x + dx, base_y + dy), sc_f)
        img.save(os.path.join(p_anim_dir, f"cast_skill_{i}.png"), "PNG")

    return (pid, True)

def main():
    print("=== STARTING GEN 4 ASSET GENERATION ===")
    t0 = time.time()
    pokemon_list = load_pokemon_metadata()
    print(f"Loaded {len(pokemon_list)} Gen 4 Pokémon.")

    # 1. Batch render Dream World 256x256 avatars
    print("\n--- 1. Rendering 256x256 Dream World Avatars ---")
    batch_render_avatars(pokemon_list)

    # 2. Parallel render 128x128 animated sprites
    print("\n--- 2. Rendering 128x128 Animated Pixel Sprites ---")
    with ProcessPoolExecutor(max_workers=8) as executor:
        futures = {executor.submit(worker_render_sprites, p): p for p in pokemon_list}
        done = 0
        total = len(pokemon_list)
        for fut in as_completed(futures):
            pid, ok = fut.result()
            done += 1
            if done % 20 == 0 or done == total:
                print(f"  Sprites rendered: {done}/{total} ({done*100//total}%)")

    t1 = time.time()
    print(f"\n[SUCCESS] Gen 4 asset generation completed in {t1 - t0:.1f}s!")

if __name__ == '__main__':
    main()
