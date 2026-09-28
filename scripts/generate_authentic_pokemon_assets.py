#!/usr/bin/env python3
import os
import re
import math
import tarfile
import subprocess
from PIL import Image, ImageSequence, ImageDraw
from gen1_data import ALL_GEN1_POKEMON

EXISTING_IDS = {
    "charmander", "squirtle", "bulbasaur", "machop", "pikachu", 
    "gengar", "snorlax", "alakazam", "charizard", "gyarados", 
    "dragonite", "mewtwo", "eevee", "growlithe", "psyduck", 
    "electabuzz", "lapras", "lucario"
}

UNITS_DIR = "assets/units"
ANIM_DIR = "assets/units/anim"
CACHE_TAR = "scripts/cache/pokeapi-sprites.tgz"
TEMP_DIR = "/tmp/poke_gen"

os.makedirs(TEMP_DIR, exist_ok=True)
os.makedirs(UNITS_DIR, exist_ok=True)
os.makedirs(ANIM_DIR, exist_ok=True)

def render_svg_avatar(tar, num, pid):
    svg_member = f"package/sprites/pokemon/other/dream-world/{num}.svg"
    try:
        svg_data = tar.extractfile(svg_member).read().decode("utf-8")
    except Exception as e:
        print(f"Error reading SVG for #{num} {pid}: {e}")
        return False

    svg_file = os.path.join(TEMP_DIR, f"{num}.svg")
    mask_file = os.path.join(TEMP_DIR, f"{num}_mask.svg")

    with open(svg_file, "w", encoding="utf-8") as f:
        f.write(svg_data)

    mask_svg = re.sub(r'fill="[^"]+"', 'fill="#000000"', svg_data)
    mask_svg = re.sub(r'stroke="[^"]+"', 'stroke="#000000"', mask_svg)
    with open(mask_file, "w", encoding="utf-8") as f:
        f.write(mask_svg)

    subprocess.run(["qlmanage", "-t", "-s", "256", "-o", TEMP_DIR, svg_file], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    subprocess.run(["qlmanage", "-t", "-s", "256", "-o", TEMP_DIR, mask_file], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

    col_png = f"{svg_file}.png"
    mask_png = f"{mask_file}.png"

    if not os.path.exists(col_png) or not os.path.exists(mask_png):
        print(f"Failed to generate PNG thumbnail for #{num} {pid}")
        return False

    col_img = Image.open(col_png).convert("RGB")
    mask_img = Image.open(mask_png).convert("L")
    alpha = mask_img.point(lambda p: 255 - p)

    raw_art = Image.new("RGBA", col_img.size, (0, 0, 0, 0))
    raw_art.paste(col_img, (0, 0), alpha)

    # Clean up temp files
    try:
        os.remove(svg_file)
        os.remove(mask_file)
        os.remove(col_png)
        os.remove(mask_png)
    except:
        pass

    bbox = raw_art.getbbox()
    if not bbox:
        print(f"Empty bbox for #{num} {pid}")
        return False

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
    return True

def render_gif_animations(tar, num, pid):
    gif_member = f"package/sprites/pokemon/versions/generation-v/black-white/animated/{num}.gif"
    try:
        gif_file = tar.extractfile(gif_member)
        im = Image.open(gif_file)
        gif_frames = [f.copy().convert("RGBA") for f in ImageSequence.Iterator(im)]
    except Exception as e:
        print(f"Error reading GIF for #{num} {pid}: {e}")
        return False

    if not gif_frames:
        print(f"No frames in GIF for #{num} {pid}")
        return False

    # Get non-empty bounding box across frames or from frame 0
    f0_bbox = gif_frames[0].getbbox()
    if not f0_bbox:
        f0_bbox = (0, 0, gif_frames[0].width, gif_frames[0].height)

    # Target height around 72px (between 62 and 82 depending on aspect ratio)
    content_w = f0_bbox[2] - f0_bbox[0]
    content_h = f0_bbox[3] - f0_bbox[1]

    if content_h <= 0 or content_w <= 0:
        content_w, content_h = gif_frames[0].width, gif_frames[0].height
        f0_bbox = (0, 0, content_w, content_h)

    # Determine scaling factor
    target_h = 72
    if content_w > content_h * 1.3:
        # Wide sprite (like Onix or Gyarados)
        target_w = 90
        scale = min(target_w / content_w, 75 / content_h)
    else:
        scale = min(74 / content_h, 80 / content_w)

    w = max(1, int(content_w * scale))
    h = max(1, int(content_h * scale))

    base_x = (128 - w) // 2
    base_y = (128 - h) // 2 + 6

    p_anim_dir = os.path.join(ANIM_DIR, pid)
    os.makedirs(p_anim_dir, exist_ok=True)

    # 1. idle.png
    idle_canvas = Image.new("RGBA", (128, 128), (0, 0, 0, 0))
    f0_crop = gif_frames[0].crop(f0_bbox)
    f0_scaled = f0_crop.resize((w, h), Image.NEAREST)
    idle_canvas.paste(f0_scaled, (base_x, base_y), f0_scaled)
    idle_canvas.save(os.path.join(p_anim_dir, "idle.png"), "PNG")

    # 2. walk_0..5.png
    n_frames = len(gif_frames)
    for i in range(6):
        f_idx = int(i * n_frames / 6.0) % n_frames
        fc = gif_frames[f_idx].crop(f0_bbox).resize((w, h), Image.NEAREST)
        c = Image.new("RGBA", (128, 128), (0, 0, 0, 0))
        bob = int(math.sin(i / 6.0 * 2 * math.pi) * 2)
        c.paste(fc, (base_x, base_y + bob), fc)
        c.save(os.path.join(p_anim_dir, f"walk_{i}.png"), "PNG")

    # 3. attack_0..5.png
    offsets = [(-2, 0), (4, 0), (10, -1), (8, 0), (4, 1), (0, 0)]
    for i, (dx, dy) in enumerate(offsets):
        f_idx = int(i * n_frames / 6.0) % n_frames
        fc = gif_frames[f_idx].crop(f0_bbox).resize((w, h), Image.NEAREST)
        c = Image.new("RGBA", (128, 128), (0, 0, 0, 0))
        c.paste(fc, (base_x + dx, base_y + dy), fc)
        if i in [2, 3]:
            # Slash strike visual
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

    return True

def main():
    print(f"Opening {CACHE_TAR}...")
    tar = tarfile.open(CACHE_TAR, "r:gz")

    total_new = 0
    success_count = 0

    for pid, pdata in ALL_GEN1_POKEMON.items():
        if pid in EXISTING_IDS:
            continue
        total_new += 1
        num = pdata["num"]

        # 1. Avatar
        av_ok = render_svg_avatar(tar, num, pid)
        # 2. Animations
        anim_ok = render_gif_animations(tar, num, pid)

        if av_ok and anim_ok:
            success_count += 1
        else:
            print(f"WARNING: Issue generating assets for #{num} {pid}")

        if total_new % 20 == 0 or total_new == 134:
            print(f"Processed {total_new}/134 Pokemon ({success_count} success)...")

    print(f"Done! Successfully generated {success_count}/{total_new} authentic Pokemon assets.")

if __name__ == "__main__":
    main()
