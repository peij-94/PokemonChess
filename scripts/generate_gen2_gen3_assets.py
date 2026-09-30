#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
generate_gen2_gen3_assets.py
Generates 2D authentic assets for Generation 2 (#152 Chikorita ~ #251 Celebi)
and Generation 3 (#252 Treecko ~ #386 Deoxys) Pokemon:
- 256x256 Dream World transparent avatars in assets/units/{pid}.png
- 128x128 Gen V animated pixel sprite sets in assets/units/anim/{pid}/:
    - idle.png
    - walk_0..5.png
    - attack_0..5.png
    - hurt_0..1.png
    - attack_physical_0..5.png
    - attack_special_0..5.png
    - cast_skill_0..5.png
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
TEMP_DIR = "/tmp/poke_gen23"

os.makedirs(TEMP_DIR, exist_ok=True)
os.makedirs(UNITS_DIR, exist_ok=True)
os.makedirs(ANIM_DIR, exist_ok=True)

TYPE_ID_MAP = {
    1: 'Normal', 2: 'Fighting', 3: 'Flying', 4: 'Poison', 5: 'Ground',
    6: 'Rock', 7: 'Bug', 8: 'Ghost', 9: 'Steel', 10: 'Fire',
    11: 'Water', 12: 'Grass', 13: 'Electric', 14: 'Psychic',
    15: 'Ice', 16: 'Dragon', 17: 'Dark', 18: 'Fairy'
}

def load_pokemon_metadata():
    pokemon_types = {}
    with open("scripts/cache/pokemon_types.csv", "r", encoding="utf-8") as f:
        for row in csv.DictReader(f):
            pid = int(row["pokemon_id"])
            if 152 <= pid <= 386:
                if pid not in pokemon_types:
                    pokemon_types[pid] = []
                pokemon_types[pid].append(TYPE_ID_MAP[int(row["type_id"])])

    pokemon_list = []
    with open("scripts/cache/pokemon.csv", "r", encoding="utf-8") as f:
        for row in csv.DictReader(f):
            num = int(row["id"])
            if 152 <= num <= 386:
                slug = row["identifier"]
                if slug == "deoxys-normal":
                    slug = "deoxys"
                slug = slug.replace("-", "_")
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

def batch_render_svg_avatars(tar, pokemon_list, batch_size=40):
    needed_list = [p for p in pokemon_list if not os.path.exists(os.path.join(UNITS_DIR, f"{p['id']}.png"))]
    if not needed_list:
        print(f"All {len(pokemon_list)} avatars already generated.")
        return

    print(f"Batch rendering {len(needed_list)} Dream World SVG avatars...")
    for b_start in range(0, len(needed_list), batch_size):
        chunk = needed_list[b_start:b_start + batch_size]
        files_to_render = []
        info_map = {}

        for p in chunk:
            num = p["num"]
            pid = p["id"]
            svg_member = f"package/sprites/pokemon/other/dream-world/{num}.svg"
            try:
                svg_data = tar.extractfile(svg_member).read().decode("utf-8")
            except Exception as e:
                print(f"Failed to read SVG for #{num} {pid}: {e}")
                continue

            svg_file = os.path.join(TEMP_DIR, f"{num}.svg")
            mask_file = os.path.join(TEMP_DIR, f"{num}_mask.svg")
            with open(svg_file, "w", encoding="utf-8") as f:
                f.write(svg_data)

            mask_svg = re.sub(r'fill="[^"]+"', 'fill="#000000"', svg_data)
            mask_svg = re.sub(r'stroke="[^"]+"', 'stroke="#000000"', mask_svg)
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
        except Exception as e:
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
        scale = min(target_w / content_w, 75 / content_h)
    else:
        scale = min(74 / content_h, 80 / content_w)

    w = max(1, int(content_w * scale))
    h = max(1, int(content_h * scale))

    base_x = (128 - w) // 2
    base_y = (128 - h) // 2 + 6

    # 1. idle.png
    idle_canvas = Image.new("RGBA", (128, 128), (0, 0, 0, 0))
    f0_crop = gif_frames[0].crop(f0_bbox)
    f0_scaled = f0_crop.resize((w, h), Image.NEAREST)
    idle_canvas.paste(f0_scaled, (base_x, base_y), f0_scaled)
    idle_canvas.save(os.path.join(p_anim_dir, "idle.png"), "PNG")

    # 2. walk_0..5.png
    n_frames = len(gif_frames)
    base_frames = []
    for i in range(6):
        f_idx = int(i * n_frames / 6.0) % n_frames
        fc = gif_frames[f_idx].crop(f0_bbox).resize((w, h), Image.NEAREST)
        c = Image.new("RGBA", (128, 128), (0, 0, 0, 0))
        bob = int(math.sin(i / 6.0 * 2 * math.pi) * 2)
        c.paste(fc, (base_x, base_y + bob), fc)
        c.save(os.path.join(p_anim_dir, f"walk_{i}.png"), "PNG")
        base_frames.append(c)

    # 3. attack_0..5.png
    offsets = [(-2, 0), (4, 0), (10, -1), (8, 0), (4, 1), (0, 0)]
    for i, (dx, dy) in enumerate(offsets):
        f_idx = int(i * n_frames / 6.0) % n_frames
        fc = gif_frames[f_idx].crop(f0_bbox).resize((w, h), Image.NEAREST)
        c = Image.new("RGBA", (128, 128), (0, 0, 0, 0))
        c.paste(fc, (base_x + dx, base_y + dy), fc)
        if i in [2, 3]:
            draw = ImageDraw.Draw(c)
            draw.arc([base_x + w + dx - 10, base_y + dy - 6, base_x + w + dx + 16, base_y + dy + 24], -70, 70, fill=(255, 235, 140, 220), width=3)
        c.save(os.path.join(p_anim_dir, f"attack_{i}.png"), "PNG")

    # 4. hurt_0..1.png
    for i, dx in enumerate([-6, -3]):
        fc = gif_frames[0].crop(f0_bbox).resize((w, h), Image.NEAREST)
        c = Image.new("RGBA", (128, 128), (0, 0, 0, 0))
        c.paste(fc, (base_x + dx, base_y), fc)
        if i == 0:
            flash = Image.new("RGBA", (128, 128), (255, 70, 70, 45))
            c = Image.alpha_composite(c, flash)
        c.save(os.path.join(p_anim_dir, f"hurt_{i}.png"), "PNG")

    # 5. attack_physical_0..5.png
    bbox = (base_x, base_y, base_x + w, base_y + h)
    center_x = (bbox[0] + bbox[2]) // 2
    center_y = (bbox[1] + bbox[3]) // 2
    front_x = bbox[2]
    bottom_y = bbox[3]

    phys_offsets = [(-4, 2), (8, -2), (18, -1), (14, 0), (6, 1), (0, 0)]
    for i, (dx, dy) in enumerate(phys_offsets):
        canvas = Image.new("RGBA", (128, 128), (0, 0, 0, 0))
        src = base_frames[i]

        if i == 0:
            bw, bh = src.width, int(src.height * 0.96)
            scaled = src.resize((bw, bh), Image.BILINEAR)
            canvas.paste(scaled, (dx, dy + (src.height - bh)), scaled)
        elif i == 1 or i == 2:
            bw, bh = int(src.width * 1.05), int(src.height * 0.97)
            scaled = src.resize((bw, bh), Image.BILINEAR)
            canvas.paste(scaled, (dx - (bw - src.width) // 2, dy), scaled)
        else:
            canvas.paste(src, (dx, dy), src)

        draw = ImageDraw.Draw(canvas)
        if i == 1:
            draw.line([center_x - 30 + dx, center_y + dy, center_x - 12 + dx, center_y + dy], fill=(255, 255, 255, 120), width=2)
        elif i == 2:
            arc_cx = front_x + dx + 4
            arc_cy = center_y + dy
            draw.arc([arc_cx - 16, arc_cy - 24, arc_cx + 18, arc_cy + 24], -75, 75, fill=core_col, width=4)
            draw.arc([arc_cx - 14, arc_cy - 22, arc_cx + 16, arc_cy + 22], -70, 70, fill=high_col, width=2)
            for sp_dx, sp_dy in [(12, -14), (16, -4), (18, 6), (14, 16), (22, 0)]:
                draw.rectangle([arc_cx + sp_dx, arc_cy + sp_dy, arc_cx + sp_dx + 2, arc_cy + sp_dy + 2], fill=high_col)
        elif i == 3:
            arc_cx = front_x + dx + 6
            arc_cy = center_y + dy
            fade_col = (core_col[0], core_col[1], core_col[2], 120)
            draw.arc([arc_cx - 18, arc_cy - 26, arc_cx + 20, arc_cy + 26], -65, 65, fill=fade_col, width=2)
            for sp_dx, sp_dy in [(16, -18), (22, -6), (24, 8), (18, 20)]:
                draw.point((arc_cx + sp_dx, arc_cy + sp_dy), fill=high_col)

        canvas.save(os.path.join(p_anim_dir, f"attack_physical_{i}.png"), "PNG")

    # 6. attack_special_0..5.png
    spec_offsets = [(0, 1), (-4, -1), (-6, -2), (-8, 0), (-3, 1), (0, 0)]
    for i, (dx, dy) in enumerate(spec_offsets):
        canvas = Image.new("RGBA", (128, 128), (0, 0, 0, 0))
        src = base_frames[i]
        canvas.paste(src, (dx, dy), src)
        draw = ImageDraw.Draw(canvas)

        muzzle_x = front_x + dx + 2
        muzzle_y = center_y + dy - 2

        if i == 1:
            draw.ellipse([muzzle_x - 4, muzzle_y - 4, muzzle_x + 4, muzzle_y + 4], fill=glow_col)
            draw.ellipse([muzzle_x - 2, muzzle_y - 2, muzzle_x + 2, muzzle_y + 2], fill=high_col)
        elif i == 2:
            draw.ellipse([muzzle_x - 9, muzzle_y - 9, muzzle_x + 9, muzzle_y + 9], fill=glow_col)
            draw.ellipse([muzzle_x - 6, muzzle_y - 6, muzzle_x + 6, muzzle_y + 6], fill=core_col)
            draw.ellipse([muzzle_x - 3, muzzle_y - 3, muzzle_x + 3, muzzle_y + 3], fill=high_col)
            draw.line([muzzle_x - 14, muzzle_y, muzzle_x + 14, muzzle_y], fill=high_col, width=2)
            draw.line([muzzle_x, muzzle_y - 14, muzzle_x, muzzle_y + 14], fill=high_col, width=2)
        elif i == 3:
            draw.ellipse([muzzle_x - 4, muzzle_y - 7, muzzle_x + 6, muzzle_y + 7], fill=core_col)
            draw.ellipse([muzzle_x - 2, muzzle_y - 4, muzzle_x + 4, muzzle_y + 4], fill=high_col)
            draw.line([muzzle_x + 4, muzzle_y, muzzle_x + 24, muzzle_y], fill=high_col, width=3)
            draw.line([muzzle_x + 4, muzzle_y - 2, muzzle_x + 20, muzzle_y - 10], fill=core_col, width=2)
            draw.line([muzzle_x + 4, muzzle_y + 2, muzzle_x + 20, muzzle_y + 10], fill=core_col, width=2)
        elif i == 4:
            fade_col = (core_col[0], core_col[1], core_col[2], 100)
            draw.ellipse([muzzle_x + 8, muzzle_y - 4, muzzle_x + 16, muzzle_y + 4], fill=fade_col)
            draw.rectangle([muzzle_x + 22, muzzle_y - 1, muzzle_x + 28, muzzle_y + 1], fill=high_col)

        canvas.save(os.path.join(p_anim_dir, f"attack_special_{i}.png"), "PNG")

    # 7. cast_skill_0..5.png
    cast_offsets = [(0, 4), (0, -6), (0, -16), (0, -14), (0, -6), (0, 1)]
    for i, (dx, dy) in enumerate(cast_offsets):
        canvas = Image.new("RGBA", (128, 128), (0, 0, 0, 0))
        src = base_frames[i]

        if i == 0:
            bw, bh = int(src.width * 1.06), int(src.height * 0.92)
            scaled = src.resize((bw, bh), Image.BILINEAR)
            canvas.paste(scaled, (dx - (bw - src.width) // 2, dy + (src.height - bh)), scaled)
        elif i == 2 or i == 3:
            bw, bh = int(src.width * 1.06), int(src.height * 1.06)
            scaled = src.resize((bw, bh), Image.BILINEAR)
            canvas.paste(scaled, (dx - (bw - src.width) // 2, dy - (bh - src.height) // 2), scaled)
        else:
            canvas.paste(src, (dx, dy), src)

        draw = ImageDraw.Draw(canvas)
        cur_cx = center_x + dx
        cur_cy = center_y + dy

        if i == 0:
            draw.ellipse([cur_cx - 24, bottom_y - 2, cur_cx + 24, bottom_y + 8], outline=core_col, width=2)
            draw.ellipse([cur_cx - 16, bottom_y, cur_cx + 16, bottom_y + 6], fill=glow_col)
        elif i == 1:
            draw.ellipse([cur_cx - 28, cur_cy + 8, cur_cx + 28, cur_cy + 22], outline=glow_col, width=3)
            draw.ellipse([cur_cx - 22, cur_cy + 10, cur_cx + 22, cur_cy + 20], outline=high_col, width=2)
        elif i == 2:
            draw.ellipse([cur_cx - 36, cur_cy - 36, cur_cx + 36, cur_cy + 36], outline=glow_col, width=3)
            draw.ellipse([cur_cx - 30, cur_cy - 30, cur_cx + 30, cur_cy + 30], outline=core_col, width=2)
            for ang in [0, math.pi/2, math.pi, 3*math.pi/2]:
                sx = cur_cx + 38 * math.cos(ang)
                sy = cur_cy + 38 * math.sin(ang)
                draw_star(draw, sx, sy, 2, 6, 4, high_col)
        elif i == 3:
            draw.ellipse([cur_cx - 44, cur_cy - 44, cur_cx + 44, cur_cy + 44], outline=glow_col, width=4)
            draw.ellipse([cur_cx - 38, cur_cy - 38, cur_cx + 38, cur_cy + 38], outline=high_col, width=2)
            for b_idx in range(8):
                ang = b_idx * (math.pi / 4.0)
                bx1 = cur_cx + 26 * math.cos(ang)
                by1 = cur_cy + 26 * math.sin(ang)
                bx2 = cur_cx + 48 * math.cos(ang)
                by2 = cur_cy + 48 * math.sin(ang)
                draw.line([bx1, by1, bx2, by2], fill=high_col, width=2)
            draw_star(draw, cur_cx, cur_cy, 4, 12, 4, high_col)
        elif i == 4:
            for sp_dx, sp_dy in [(-24, -20), (-16, 14), (20, -16), (18, 18), (0, -28), (-26, 4), (26, 4)]:
                draw_star(draw, cur_cx + sp_dx, cur_cy + sp_dy, 1, 4, 4, high_col)
        elif i == 5:
            draw.ellipse([cur_cx - 20, bottom_y + 1, cur_cx + 20, bottom_y + 7], outline=glow_col, width=1)

        canvas.save(os.path.join(p_anim_dir, f"cast_skill_{i}.png"), "PNG")

    return (pid, True)

def main():
    t0 = time.time()
    pokemon_list = load_pokemon_metadata()
    print(f"Loaded {len(pokemon_list)} Gen 2 & Gen 3 Pokemon (#152 ~ #386)")

    # 1. Batch render avatars
    with tarfile.open(CACHE_TAR, "r:gz") as tar:
        batch_render_svg_avatars(tar, pokemon_list)

    # 2. Render all animations with 8 parallel worker processes
    print(f"Rendering animated sprite sets for {len(pokemon_list)} Pokemon with multiprocessing...")
    anim_success = 0
    with ProcessPoolExecutor(max_workers=8) as executor:
        futures = {executor.submit(worker_render_sprites, p): p for p in pokemon_list}
        done_count = 0
        for f in as_completed(futures):
            pid, ok = f.result()
            if ok:
                anim_success += 1
            done_count += 1
            if done_count % 30 == 0 or done_count == len(pokemon_list):
                print(f"  Sprites rendered: {done_count}/{len(pokemon_list)} ({anim_success} success)...")

    print(f"\nAll Done! {anim_success}/{len(pokemon_list)} Pokemon generated in {time.time() - t0:.2f}s")

if __name__ == "__main__":
    main()
