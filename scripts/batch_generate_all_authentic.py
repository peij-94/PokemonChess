#!/usr/bin/env python3
import os
import re
import math
import subprocess
import time
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
EXTRACTED_DIR = "/tmp/poke_extracted/package/sprites/pokemon"
RENDER_DIR = "/tmp/poke_render"

os.makedirs(RENDER_DIR, exist_ok=True)
os.makedirs(UNITS_DIR, exist_ok=True)
os.makedirs(ANIM_DIR, exist_ok=True)

def main():
    t_start = time.time()
    pokemon_to_process = []
    for pid, pdata in ALL_GEN1_POKEMON.items():
        if pid in EXISTING_IDS:
            continue
        pokemon_to_process.append((pid, pdata["num"]))

    print(f"Total new Pokemon to process: {len(pokemon_to_process)}")

    # -------------------------------------------------------------
    # 1. BATCH RENDER AVATARS (256x256 SVGs)
    # -------------------------------------------------------------
    print("Preparing SVG files and masks for batch rendering...")
    svg_file_list = []
    valid_pokes = []
    
    for pid, num in pokemon_to_process:
        src_svg = f"{EXTRACTED_DIR}/other/dream-world/{num}.svg"
        if not os.path.exists(src_svg):
            print(f"Warning: Missing SVG for #{num} {pid}")
            continue
            
        with open(src_svg, "r", encoding="utf-8") as f:
            content = f.read()
            
        dst_svg = f"{RENDER_DIR}/{num}.svg"
        dst_mask = f"{RENDER_DIR}/{num}_mask.svg"
        
        with open(dst_svg, "w", encoding="utf-8") as f:
            f.write(content)
            
        mask = re.sub(r'fill="[^"]+"', 'fill="#000000"', content)
        mask = re.sub(r'stroke="[^"]+"', 'stroke="#000000"', mask)
        with open(dst_mask, "w", encoding="utf-8") as f:
            f.write(mask)
            
        svg_file_list.append(dst_svg)
        svg_file_list.append(dst_mask)
        valid_pokes.append((pid, num))

    print(f"Executing batch qlmanage on {len(svg_file_list)} files...")
    # Execute in chunks of 40 to avoid command line length limits
    chunk_size = 40
    for i in range(0, len(svg_file_list), chunk_size):
        chunk = svg_file_list[i:i + chunk_size]
        subprocess.run(["qlmanage", "-t", "-s", "256", "-o", RENDER_DIR] + chunk, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        print(f"  Rendered batch {min(i + chunk_size, len(svg_file_list))}/{len(svg_file_list)} SVGs...")

    # Composite avatars
    print("Compositing transparent 256x256 avatars...")
    avatar_success = 0
    for pid, num in valid_pokes:
        col_png = f"{RENDER_DIR}/{num}.svg.png"
        mask_png = f"{RENDER_DIR}/{num}_mask.svg.png"
        
        if not os.path.exists(col_png) or not os.path.exists(mask_png):
            print(f"Warning: Missing rendered PNG for #{num} {pid}")
            continue
            
        col_img = Image.open(col_png).convert("RGB")
        mask_img = Image.open(mask_png).convert("L")
        alpha = mask_img.point(lambda p: 255 - p)
        
        raw_art = Image.new("RGBA", col_img.size, (0, 0, 0, 0))
        raw_art.paste(col_img, (0, 0), alpha)
        
        bbox = raw_art.getbbox()
        if not bbox:
            print(f"Warning: Empty bbox for #{num} {pid}")
            continue
            
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
        avatar_success += 1

    print(f"Completed {avatar_success}/{len(valid_pokes)} avatars!")

    # -------------------------------------------------------------
    # 2. BATCH PROCESS ANIMATIONS (128x128 Gen 5 Sprites)
    # -------------------------------------------------------------
    print("Processing 128x128 authentic battle animations from Gen 5 animated GIFs...")
    anim_success = 0
    
    for pid, num in pokemon_to_process:
        gif_path = f"{EXTRACTED_DIR}/versions/generation-v/black-white/animated/{num}.gif"
        if not os.path.exists(gif_path):
            print(f"Warning: Missing animated GIF for #{num} {pid}")
            continue
            
        im = Image.open(gif_path)
        gif_frames = [f.copy().convert("RGBA") for f in ImageSequence.Iterator(im)]
        if not gif_frames:
            continue
            
        f0_bbox = gif_frames[0].getbbox() or (0, 0, gif_frames[0].width, gif_frames[0].height)
        content_w = f0_bbox[2] - f0_bbox[0]
        content_h = f0_bbox[3] - f0_bbox[1]
        if content_h <= 0 or content_w <= 0:
            content_w, content_h = gif_frames[0].width, gif_frames[0].height
            f0_bbox = (0, 0, content_w, content_h)

        if content_w > content_h * 1.3:
            scale = min(90 / content_w, 75 / content_h)
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

        anim_success += 1

    print(f"Completed {anim_success}/{len(pokemon_to_process)} animation frame sets!")
    print(f"Total time elapsed: {time.time() - t_start:.2f} seconds!")

if __name__ == "__main__":
    main()
