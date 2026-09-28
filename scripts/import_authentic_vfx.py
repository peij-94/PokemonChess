#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
import_authentic_vfx.py

Imports authentic Pokémon battle move animation spritesheets from the open-source
PokéRogue / Pokémon Essentials repository (CC-BY-NC-SA 4.0 / CC0)
and slices them into high-fidelity transparent PNG frame sequences in assets/vfx/<skill_name>/
"""

import os
import json
import subprocess
import urllib.parse
from PIL import Image
import io

CACHE_DIR = os.path.join(os.path.dirname(__file__), 'cache', 'battle_anims')
VFX_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', 'assets', 'vfx'))
RAW_ASSETS_BASE = "https://raw.githubusercontent.com/pagefaultgames/pokerogue-assets/beta/images/battle_anims"

os.makedirs(CACHE_DIR, exist_ok=True)

# Curated high-fidelity mapping of all 86 auto-chess VFX to authentic Pokémon sheets & cells
VFX_SPECS = {
    # ------------------ ELECTRIC ------------------
    "thundershock": {"sheet": "PRAS- Electric.png", "cells": [20, 52, 34, 36, 38, 20]},
    "thunderbolt": {"sheet": "PRAS- Electric.png", "cells": [48, 49, 50, 51, 52, 50]},
    "thunder": {"sheet": "PRAS- Electric.png", "cells": [0, 50, 48, 51, 52, 49, 50, 52]},
    "discharge": {"sheet": "PRAS- Discharge.png", "cells": [0, 1, 2, 3, 4, 5]},
    "electro_ball": {"sheet": "PRAS- Electric.png", "cells": [8, 9, 10, 11, 12]},
    "spark": {"sheet": "PRAS- Electric.png", "cells": [20, 21, 22, 23, 24]},
    "electroweb": {"sheet": "PRAS- Electric.png", "cells": [30, 31, 32, 33, 34]},
    "thunder_punch": {"sheet": "PRAS- Elemental Punch.png", "cells": [10, 11, 12, 13, 14]},
    "thunder_fang": {"sheet": "PRAS- Elemental Fangs.png", "cells": [10, 11, 12, 13, 14]},
    "thunder_tempest": {"sheet": "PRAS- Electric.png", "cells": [48, 50, 51, 52, 49, 50, 51, 52]},
    "volt_catastrophe": {"sheet": "PRAS- Catastropika.png", "cells": [0, 1, 2, 3, 4, 5]},

    # ------------------ FIRE ------------------
    "ember": {"sheet": "PRAS- Fire.png", "cells": [36, 37, 38, 39, 41, 42]},
    "flamethrower": {"sheet": "PRAS- Fire.png", "cells": [0, 1, 2, 3, 4, 5]},
    "fire_blast": {"sheet": "PRAS- Fire.png", "cells": [60, 61, 62, 63, 64, 65]},
    "flame_wheel": {"sheet": "PRAS- Fire.png", "cells": [30, 31, 32, 33, 34, 35]},
    "fire_spin": {"sheet": "PRAS- Fire Spin.png", "cells": [0, 1, 2, 3, 4, 5]},
    "heat_wave": {"sheet": "PRAS- Fire.png", "cells": [44, 45, 46, 47, 48, 49]},
    "fire_punch": {"sheet": "PRAS- Elemental Punch.png", "cells": [0, 1, 2, 3, 4]},
    "fire_fang": {"sheet": "PRAS- Elemental Fangs.png", "cells": [0, 1, 2, 3, 4]},
    "flare_blitz": {"sheet": "PRAS- Fire.png", "cells": [7, 8, 9, 10, 11, 12]},
    "inferno": {"sheet": "PRAS- Fire.png", "cells": [7, 8, 9, 10, 11, 12, 60, 61]},
    "blast_burn": {"sheet": "PRAS- Fire.png", "cells": [14, 15, 16, 17, 18, 19, 20, 21]},

    # ------------------ WATER ------------------
    "water_gun": {"sheet": "PRAS- Water.png", "cells": [19, 20, 21, 22, 23]},
    "water_pulse": {"sheet": "PRAS- Water.png", "cells": [16, 17, 18, 19, 20, 21]},
    "bubble_beam": {"sheet": "PRAS- Water.png", "cells": [0, 1, 2, 3, 4, 5]},
    "aqua_tail": {"sheet": "PRAS- Water.png", "cells": [24, 25, 26, 27, 28, 29]},
    "surf": {"sheet": "PRAS- Water.png", "cells": [41, 42, 43, 44, 45, 46]},
    "hydro_pump": {"sheet": "PRAS- Hydro Pump.png", "cells": [0, 1, 2, 3, 4]},
    "hydro_cannon": {"sheet": "PRAS- Hydro cannon.png", "cells": [0, 1, 2, 3, 4, 5, 6, 7]},
    "hydro_tempest": {"sheet": "PRAS- Water.png", "cells": [8, 9, 10, 11, 41, 42, 43, 44, 45, 46]},
    "crabhammer": {"sheet": "PRAS- Crabhammer.png", "cells": [0, 1, 2, 3]},

    # ------------------ GRASS ------------------
    "leech_seed": {"sheet": "PRAS- Leech Seed.png", "cells": [0, 1, 2, 3]},
    "razor_leaf": {"sheet": "PRAS- Grass.png", "cells": [8, 9, 10, 11, 12, 13, 14, 15]},
    "seed_bomb": {"sheet": "PRAS- Grass.png", "cells": [0, 1, 2, 3, 4, 5]},
    "petal_dance": {"sheet": "PRAS- Grass.png", "cells": [16, 17, 18, 19, 20, 21, 22]},
    "power_whip": {"sheet": "PRAS- Grass.png", "cells": [30, 31, 32, 33, 34]},
    "vine_whip": {"sheet": "PRAS- Grass.png", "cells": [25, 26, 27, 28, 29]},
    "leaf_blade": {"sheet": "PRAS- Leaf Tornado.png", "cells": [0, 1, 2, 3, 4, 5]},
    "solar_beam": {"sheet": "GEN8- Solar Blade.png", "cells": [0, 1, 2, 3, 4]},
    "frenzy_plant": {"sheet": "PRAS- Frenzy Plant.png", "cells": [11, 12, 13, 14, 15, 18, 19, 20, 21]},

    # ------------------ ICE ------------------
    "ice_shard": {"sheet": "PRAS- Ice.png", "cells": [8, 9, 10, 11, 12]},
    "ice_beam": {"sheet": "PRAS- Ice.png", "cells": [0, 1, 2, 3, 4, 5, 12]},
    "aurora_beam": {"sheet": "PRAS- Ice.png", "cells": [23, 24, 25, 26, 27, 28]},
    "blizzard": {"sheet": "PRAS- Frost Breath.png", "cells": [0, 1, 2, 3, 4, 5, 6]},
    "sheer_cold": {"sheet": "PRAS- Sheer Cold.png", "cells": [1, 2, 3, 4, 5, 6, 7, 8, 9]},
    "ice_punch": {"sheet": "PRAS- Ice Hammer.png", "cells": [0, 1, 2, 3, 4, 5]},
    "ice_fang": {"sheet": "PRAS- Elemental Fangs.png", "cells": [5, 6, 7, 8, 9]},
    "icicle_spear": {"sheet": "PRAS- Ice.png", "cells": [15, 16, 17, 18, 19]},
    "avalanche": {"sheet": "PRAS- Glaciate.png", "cells": [10, 11, 12, 13, 20, 21]},

    # ------------------ PSYCHIC ------------------
    "confusion": {"sheet": "PRAS- Confuse Ray.png", "rotate": True},
    "hypnosis": {"sheet": "PRAS- Supersonic.png", "cells": [5, 4, 3, 2, 1, 0]},
    "psybeam": {"sheet": "PRAS- Psybeam.png", "cells": [0, 1, 2, 3]},
    "psycho_cut": {"sheet": "PRAS- Psycho Cut.png", "pulse": True},
    "psychic": {"sheet": "PRAS- Psystrike.png", "cells": [0, 1, 2, 3, 4, 5]},
    "psychokinesis": {"sheet": "PRAS- Psystrike.png", "cells": [2, 3, 4, 5, 6, 7]},
    "psystrike": {"sheet": "PRAS- Psystrike.png", "cells": [0, 1, 2, 3, 4, 5, 6, 7]},
    "future_sight": {"sheet": "PRAS- Miracle Eye.png", "cells": [0, 1, 2, 3, 4, 5, 6]},
    "cosmic_singularity": {"sheet": "PRAS- Spacial Rend.png", "cells": [10, 11, 12, 13, 14, 15]},
    "dream_eater": {"sheet": "PRAS- Dream Eater.png", "cells": [0, 1, 2, 3, 4, 5]},
    "zen_headbutt": {"sheet": "PRAS- Psycho Boost.png", "cells": [4, 5, 6, 7, 8, 9]},

    # ------------------ GHOST / DARK ------------------
    "lick": {"sheet": "PRAS- Sketch + Lick.png", "cells": [0, 1, 2]},
    "shadow_punch": {"sheet": "PRAS- Shadow Punch.png", "cells": [0, 1, 2, 3, 4]},
    "shadow_ball": {"sheet": "PRAS- Shadow Ball.png", "cells": [0, 1, 2, 3, 4]},
    "hex_nightmare": {"sheet": "PRAS- NeverEndingNightmare.png", "cells": [0, 1, 2, 3, 4, 5]},
    "dark_pulse": {"sheet": "PRAS- Dark Pulse.png", "cells": [0, 1, 2, 3]},
    "night_shade": {"sheet": "PRAS- Night Daze.png", "cells": [0, 1, 2, 3]},
    "bite": {"sheet": "PRAS- Elemental Fangs.png", "cells": [15, 16, 17, 18, 19]},
    "crunch": {"sheet": "PRAS- Elemental Fangs.png", "cells": [20, 21, 22, 23, 24]},

    # ------------------ BUG ------------------
    "leech_life": {"sheet": "PRAS- Leech Life.png", "cells": [0, 1, 2, 3, 4]},
    "bug_buzz": {"sheet": "PRAS- Leech Life.png", "cells": [5, 6, 7, 8, 9]},
    "string_shot": {"sheet": "PRAS- Sticky Web.png", "cells": [0, 1, 2, 3, 4]},
    "silver_wind": {"sheet": "PRAS- Twister.png", "cells": [5, 6, 7, 8, 9]},
    "x_scissor": {"sheet": "PRAS- Slash.png", "cells": [20, 21, 22, 23, 24]},
    "pin_missile": {"sheet": "PRAS- Needle Arm.png", "cells": [0, 1, 2, 3, 4]},

    # ------------------ DRAGON ------------------
    "dragon_breath": {"sheet": "PRAS- Dragonbreath.png", "cells": [0, 1, 2]},
    "dragon_pulse": {"sheet": "PRAS- Dragon Pulse.png", "cells": [0, 1, 2, 3, 4, 5]},
    "dragon_claw": {"sheet": "PRAS- Dragon Claw.png", "cells": [1, 2, 3, 4, 3, 2]},
    "draco_meteor": {"sheet": "GEN8- Meteor Beam.png", "cells": [0, 1, 2, 3, 5, 6, 7, 8]},
    "dragon_apocalypse": {"sheet": "PRAS- Dragon Claw.png", "cells": [0, 1, 2, 3, 4]},

    # ------------------ FIGHTING / NORMAL ------------------
    "low_kick": {"sheet": "PRAS- Strike.png", "cells": [1, 2, 3, 4]},
    "force_palm": {"sheet": "PRAS- Force Palm.png", "cells": [0, 1, 2, 3]},
    "cross_chop": {"sheet": "PRAS- Slash.png", "cells": [10, 11, 12, 13, 14]},
    "dynamic_punch": {"sheet": "punches.png", "cells": [0, 1, 2, 3, 4]},
    "mach_punch": {"sheet": "PRAS- Strike.png", "cells": [5, 6, 7, 8, 9]},
    "mega_punch": {"sheet": "PRAS- Strike.png", "cells": [10, 11, 12, 13, 14]},
    "mega_kick": {"sheet": "PRAS- Strike.png", "cells": [0, 1, 2, 3, 4]},
    "close_combat": {"sheet": "PRAS- Strike.png", "cells": [3, 4, 10, 11, 14, 18, 19, 26]},
    "headbutt": {"sheet": "PRAS- Strike.png", "cells": [25, 26, 27, 28, 29]},
    "tackle": {"sheet": "PRAS- Strike.png", "cells": [20, 21, 22, 23]},
    "take_down": {"sheet": "PRAS- Strike.png", "cells": [15, 16, 17, 18, 19]},
    "body_slam": {"sheet": "PRAS- Strike.png", "cells": [0, 3, 4, 18, 19, 26]},
    "double_edge": {"sheet": "PRAS- Strike.png", "cells": [0, 3, 10, 18, 26]},
    "quick_attack": {"sheet": "PRAS- Strike.png", "cells": [20, 21, 22, 23, 24]},
    "giga_impact": {"sheet": "PRAS- Me First.png", "cells": [1, 2, 3, 4, 5, 6, 7, 8, 9]},
    "hyper_beam": {"sheet": "PRAS- Hyper Beam.png", "cells": [1, 2, 3, 4, 5, 6, 7]},
    "slash": {"sheet": "PRAS- Slash.png", "cells": [6, 7, 8, 49, 50, 64]},
    "swift": {"sheet": "PRAS- Swift.png", "rotate": True},
    "tri_attack": {"sheet": "PRAS- Tri Attack.png", "cells": [0, 1, 2, 3, 4, 5]},
    "bone_rush": {"sheet": "PRAS- BoneMerang.png", "cells": [0, 1, 2, 3, 4, 5]},
    "bonemerang": {"sheet": "PRAS- BoneMerang.png", "cells": [0, 1, 2, 3, 4, 5, 6]},
    "aura_sphere": {"sheet": "PRAS- Aura Sphere.png", "cells": [0, 1, 2, 3]},
    "aura_storm": {"sheet": "PRAS- Aura Sphere.png", "cells": [0, 1, 2, 3, 2, 1, 0]},

    # ------------------ ROCK / GROUND ------------------
    "ancient_power": {"sheet": "PRAS- Rock.png", "cells": [15, 16, 17, 18, 6, 7, 8]},
    "rock_slide": {"sheet": "PRAS- Rock.png", "cells": [6, 7, 8, 15, 16, 17]},
    "rock_throw": {"sheet": "PRAS- Rock.png", "cells": [0, 1, 2, 3, 4]},
    "stone_edge": {"sheet": "PRAS- Stealth Rock.png", "cells": [0, 1, 2, 3, 4]},
    "earthquake": {"sheet": "PRAS- Rock.png", "cells": [0, 1, 6, 7, 8, 15, 16]},
    "mud_slap": {"sheet": "PRAS- Rock.png", "cells": [10, 11, 12, 13]},

    # ------------------ FLYING ------------------
    "air_slash": {"sheet": "PRAS- Air Slash.png", "cells": [0, 1, 2, 3, 4]},
    "wing_attack": {"sheet": "PRAS- Air Slash.png", "cells": [4, 5, 6, 7]},
    "twister": {"sheet": "PRAS- Twister.png", "cells": [0, 1, 2, 3, 4, 5]},
    "gust": {"sheet": "PRAS- Twister.png", "cells": [0, 1, 2, 3]},
    "drill_peck": {"sheet": "PRAS- Strike.png", "cells": [12, 13, 14, 15, 16]},
    "brave_bird": {"sheet": "PRAS- Brave Bird.png", "cells": [0]},

    # ------------------ POISON ------------------
    "poison_sting": {"sheet": "PRAS- Poison Sting.png", "cells": [0, 1, 0, 1]},
    "sludge_bomb": {"sheet": "PRAS- Sludge Bomb.png", "cells": [0, 1, 2, 3, 4]},
    "gunk_shot": {"sheet": "PRAS- Gunk Shot.png", "cells": [0, 1, 2, 3]},
    "acid_armor": {"sheet": "PRAS- Poison.png", "cells": [0, 1, 2, 3, 4, 5]},
    "poison_jab": {"sheet": "PRAS- Poison.png", "cells": [5, 6, 7, 8, 9]},
    "toxic": {"sheet": "PRAS- Poison.png", "cells": [10, 11, 12, 13, 14]},

    # ------------------ STATUS / UTILITY ------------------
    "rest": {"sheet": "PRAS- Soft Boil.png", "cells": [0, 1, 2, 3, 4]},
    "softboiled": {"sheet": "PRAS- Soft Boil.png", "cells": [0, 1, 2, 3, 4, 5]},
    "heal_pulse": {"sheet": "PRAS- Healing Wish.png", "cells": [0, 1, 2, 3, 4]},
    "reflect": {"sheet": "PRAS- Reflect.png", "cells": [0, 1, 2, 3, 4]},
    "light_screen": {"sheet": "PRAS- Light Screen.png", "cells": [0, 1, 2, 3, 4, 5, 6]},
    "transform": {"sheet": "PRAS- Substitute.png", "cells": [0, 1]},
    "perish_song": {"sheet": "PRAS- Sound.png", "cells": [0, 1, 2, 3, 4, 5]},
    "extreme_evoboost": {"sheet": "PRAS- Extreme Evoboost.png", "cells": [0, 1, 2, 3, 4, 5]},
}


def download_sheet(sheet_name: str) -> str:
    local_path = os.path.join(CACHE_DIR, sheet_name)
    if os.path.exists(local_path) and os.path.getsize(local_path) > 0:
        return local_path

    encoded = urllib.parse.quote(sheet_name)
    url = f"{RAW_ASSETS_BASE}/{encoded}"
    cmd = ["curl", "-sSL", "--retry", "3", url, "-o", local_path]
    res = subprocess.run(cmd)
    if res.returncode != 0 or not os.path.exists(local_path) or os.path.getsize(local_path) == 0:
        raise RuntimeError(f"Failed to download {sheet_name} from {url}")
    return local_path


def crop_cell(sheet: Image.Image, cell_idx: int) -> Image.Image:
    w, h = sheet.size
    cell_w = 96
    cell_h = 96
    cols = max(1, w // cell_w)
    cx = (cell_idx % cols) * cell_w
    cy = (cell_idx // cols) * cell_h

    # Boundary check
    if cx + cell_w > w or cy + cell_h > h:
        return Image.new("RGBA", (96, 96), (0, 0, 0, 0))

    cell = sheet.crop((cx, cy, cx + cell_w, cy + cell_h))
    return cell


def process_vfx(vfx_name: str, spec: dict):
    sheet_name = spec["sheet"]
    local_path = download_sheet(sheet_name)

    target_dir = os.path.join(VFX_DIR, vfx_name)
    os.makedirs(target_dir, exist_ok=True)

    with Image.open(local_path) as im:
        sheet = im.convert("RGBA")

    frames = []
    if spec.get("rotate"):
        # 96x96 single icon rotated across 6 frames (e.g. Swift star, Confuse ray)
        base_icon = sheet.crop((0, 0, 96, 96))
        for deg in [0, 60, 120, 180, 240, 300]:
            rot = base_icon.rotate(-deg, resample=Image.Resampling.NEAREST)
            frames.append(rot)
    elif spec.get("pulse"):
        # 96x96 single icon pulsing/slashing across 6 frames
        base_icon = sheet.crop((0, 0, 96, 96))
        for scale in [0.7, 0.9, 1.1, 1.25, 1.1, 0.9]:
            nw = max(1, int(96 * scale))
            nh = max(1, int(96 * scale))
            res = base_icon.resize((nw, nh), Image.Resampling.NEAREST)
            canvas = Image.new("RGBA", (96, 96), (0, 0, 0, 0))
            canvas.paste(res, ((96 - nw) // 2, (96 - nh) // 2))
            frames.append(canvas)
    else:
        cells = spec.get("cells", [])
        if not cells:
            cols = max(1, sheet.width // 96)
            rows = max(1, sheet.height // 96)
            cells = list(range(min(6, cols * rows)))

        for c in cells:
            cell = crop_cell(sheet, c)
            frames.append(cell)

    # Upscale 2x using nearest-neighbor to 192x192 (authentic retro pixel look, matching 200px engine coordinate space)
    saved_count = 0
    for idx, f in enumerate(frames):
        # 2x nearest-neighbor scaling
        upscaled = f.resize((192, 192), Image.Resampling.NEAREST)
        out_file = os.path.join(target_dir, f"frame_{idx}.png")
        upscaled.save(out_file, "PNG")
        saved_count += 1

    # Remove any leftover frames from old sets
    idx = saved_count
    while True:
        old_file = os.path.join(target_dir, f"frame_{idx}.png")
        if os.path.exists(old_file):
            os.remove(old_file)
            idx += 1
        else:
            break

    print(f"[{vfx_name}] Processed {saved_count} frames from {sheet_name}")


def main():
    print(f"Starting authentic Pokémon battle animation import for {len(VFX_SPECS)} VFX...")
    success = 0
    failed = []

    for vfx_name, spec in VFX_SPECS.items():
        try:
            process_vfx(vfx_name, spec)
            success += 1
        except Exception as e:
            print(f"FAILED [{vfx_name}]: {e}")
            failed.append((vfx_name, str(e)))

    print("\n==========================================")
    print(f"Successfully updated: {success} / {len(VFX_SPECS)} VFX")
    if failed:
        print(f"Failed count: {len(failed)}")
        for name, err in failed:
            print(f"  - {name}: {err}")
    print("==========================================")


if __name__ == "__main__":
    main()
