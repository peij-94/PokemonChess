#!/usr/bin/env python3
import os
import math
from PIL import Image, ImageDraw, ImageFilter
from gen1_data import ALL_GEN1_POKEMON

EXISTING_IDS = {
    'charmander', 'squirtle', 'bulbasaur', 'machop', 'pikachu', 
    'gengar', 'snorlax', 'alakazam', 'charizard', 'gyarados', 
    'dragonite', 'mewtwo', 'eevee', 'growlithe', 'psyduck', 
    'electabuzz', 'lapras', 'lucario'
}

UNITS_DIR = "assets/units"
ANIM_DIR = "assets/units/anim"

def clamp(val, low=0, high=255):
    return max(low, min(high, int(val)))

def blend_color(c1, c2, factor):
    return tuple(clamp(c1[i] + (c2[i] - c1[i]) * factor) for i in range(len(c1)))

def adjust_color(col, mult):
    return (clamp(col[0] * mult), clamp(col[1] * mult), clamp(col[2] * mult))

def draw_shaded_circle(draw, bbox, base_color, highlight_color=None, shadow_color=None):
    x0, y0, x1, y1 = bbox
    w = x1 - x0
    h = y1 - y0
    if highlight_color is None:
        highlight_color = adjust_color(base_color, 1.3)
    if shadow_color is None:
        shadow_color = adjust_color(base_color, 0.7)
    
    # Draw shadow base
    draw.ellipse([x0, y0, x1, y1], fill=shadow_color)
    # Draw midtone
    inset_y = h * 0.08
    draw.ellipse([x0 + w * 0.04, y0, x1 - w * 0.04, y1 - inset_y], fill=base_color)
    # Draw highlight
    hl_w = w * 0.45
    hl_h = h * 0.35
    draw.ellipse([x0 + w * 0.15, y0 + h * 0.1, x0 + w * 0.15 + hl_w, y0 + h * 0.1 + hl_h], fill=highlight_color)

def draw_shaded_polygon(draw, points, base_color, shadow_color=None):
    if shadow_color is None:
        shadow_color = adjust_color(base_color, 0.75)
    draw.polygon(points, fill=base_color, outline=shadow_color)

def draw_pokemon_sprite(size, visual, anim_state="idle", frame_idx=0, is_avatar=False):
    """
    Renders a Pokemon sprite at specified size (256 for avatar, 128 for anim).
    """
    scale = size / 128.0
    img = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)

    primary = visual.get("primary", (120, 160, 200))
    secondary = visual.get("secondary", (230, 230, 230))
    accent = visual.get("accent", (200, 80, 80))
    eye_col = visual.get("eye", (30, 30, 30))
    archetype = visual.get("archetype", "biped").lower()
    if archetype == "bird": archetype = "avian"
    if archetype == "serpent": archetype = "serpentine"
    features = visual.get("features", [])

    # Calculate animation offsets
    dx, dy = 0.0, 0.0
    rot = 0.0
    limb_phase = 0.0
    atk_thrust = 0.0
    hurt_flash = False

    if anim_state == "walk":
        phase = (frame_idx % 6) / 6.0
        dy = math.sin(phase * 2 * math.pi) * 3.5
        limb_phase = math.cos(phase * 2 * math.pi)
    elif anim_state == "attack":
        # 0: windup, 1: dash, 2: strike, 3: impact, 4: recoil, 5: recover
        if frame_idx == 0:
            dx, dy = -2.0, 1.0
        elif frame_idx == 1:
            dx, dy = 4.0, 0.0
            atk_thrust = 0.4
        elif frame_idx == 2:
            dx, dy = 10.0, -2.0
            atk_thrust = 1.0
        elif frame_idx == 3:
            dx, dy = 8.0, 0.0
            atk_thrust = 0.7
        elif frame_idx == 4:
            dx, dy = 3.0, 1.0
        else:
            dx, dy = 0.0, 0.0
    elif anim_state == "hurt":
        dx = -5.0 if frame_idx == 0 else -2.5
        dy = -1.0
        hurt_flash = (frame_idx == 0)

    # Center coords at 128-base
    cx = (64.0 + dx) * scale
    cy = (68.0 + dy) * scale
    
    if is_avatar:
        # Subtle glowing background ring for avatar
        ring_r = 56 * scale
        for r in range(int(ring_r) + 8, int(ring_r) - 2, -2):
            alpha = clamp(18 - (r - ring_r) * 2, 0, 30)
            draw.ellipse([cx - r, cy - r, cx + r, cy + r], fill=(primary[0], primary[1], primary[2], alpha))
        draw.ellipse([cx - ring_r, cy - ring_r, cx + ring_r, cy + ring_r], outline=adjust_color(primary, 1.2), width=int(2*scale))

    # Shadow under unit
    shadow_w = 26 * scale
    shadow_h = 7 * scale
    shadow_y = cy + (28 * scale)
    draw.ellipse([cx - shadow_w, shadow_y - shadow_h, cx + shadow_w, shadow_y + shadow_h], fill=(15, 20, 30, 70))

    # Render body components based on archetype
    if archetype in ["quadruped", "plant"]:
        # Back legs / tail first
        if "tail" in features or "tail_fire" in features:
            tail_pts = [
                (cx - 24*scale, cy + 4*scale),
                (cx - 36*scale, cy - 10*scale + math.sin(limb_phase)*3*scale),
                (cx - 28*scale, cy - 20*scale + math.sin(limb_phase)*3*scale),
                (cx - 18*scale, cy - 6*scale)
            ]
            draw.polygon(tail_pts, fill=primary, outline=adjust_color(primary, 0.7))
            if "tail_fire" in features:
                f_cx = cx - 32*scale
                f_cy = cy - 18*scale
                draw.ellipse([f_cx - 8*scale, f_cy - 8*scale, f_cx + 8*scale, f_cy + 8*scale], fill=(255, 140, 20, 230))
                draw.ellipse([f_cx - 4*scale, f_cy - 4*scale, f_cx + 4*scale, f_cy + 4*scale], fill=(255, 230, 80, 240))
        
        # Legs
        leg_offset = limb_phase * 4 * scale
        draw.rounded_rectangle([cx - 20*scale + leg_offset, cy + 8*scale, cx - 10*scale + leg_offset, cy + 28*scale], radius=3*scale, fill=adjust_color(primary, 0.85))
        draw.rounded_rectangle([cx + 10*scale - leg_offset, cy + 8*scale, cx + 20*scale - leg_offset, cy + 28*scale], radius=3*scale, fill=adjust_color(primary, 0.85))
        draw.rounded_rectangle([cx - 14*scale - leg_offset, cy + 10*scale, cx - 4*scale - leg_offset, cy + 30*scale], radius=3*scale, fill=primary)
        draw.rounded_rectangle([cx + 4*scale + leg_offset, cy + 10*scale, cx + 14*scale + leg_offset, cy + 30*scale], radius=3*scale, fill=primary)

        # Back shell/bulb/flower
        if "bulb" in features:
            draw_shaded_circle(draw, [cx - 16*scale, cy - 24*scale, cx + 16*scale, cy + 4*scale], secondary)
        elif "flower" in features:
            draw.ellipse([cx - 26*scale, cy - 24*scale, cx + 26*scale, cy - 8*scale], fill=secondary)
            draw.ellipse([cx - 8*scale, cy - 20*scale, cx + 8*scale, cy - 4*scale], fill=accent)
        elif "shell" in features:
            draw_shaded_circle(draw, [cx - 20*scale, cy - 14*scale, cx + 18*scale, cy + 16*scale], secondary)

        # Torso
        draw_shaded_circle(draw, [cx - 22*scale, cy - 8*scale, cx + 22*scale, cy + 20*scale], primary)
        # Belly
        draw.ellipse([cx - 14*scale, cy + 2*scale, cx + 14*scale, cy + 18*scale], fill=secondary)

        # Head
        head_cx = cx + 14*scale
        head_cy = cy - 8*scale
        head_r = 16*scale
        draw_shaded_circle(draw, [head_cx - head_r, head_cy - head_r, head_cx + head_r, head_cy + head_r], primary)

        # Ears/horns on head
        if "ears" in features:
            draw.polygon([(head_cx - 8*scale, head_cy - 12*scale), (head_cx - 14*scale, head_cy - 24*scale), (head_cx - 2*scale, head_cy - 14*scale)], fill=primary)
            draw.polygon([(head_cx + 4*scale, head_cy - 14*scale), (head_cx + 10*scale, head_cy - 26*scale), (head_cx + 12*scale, head_cy - 12*scale)], fill=primary)
        elif "horns" in features:
            draw.polygon([(head_cx - 4*scale, head_cy - 12*scale), (head_cx + 4*scale, head_cy - 26*scale), (head_cx + 10*scale, head_cy - 12*scale)], fill=accent)

        # Eyes & Muzzle
        draw.ellipse([head_cx + 6*scale, head_cy - 4*scale, head_cx + 13*scale, head_cy + 4*scale], fill=(255, 255, 255))
        draw.ellipse([head_cx + 8*scale, head_cy - 2*scale, head_cx + 13*scale, head_cy + 3*scale], fill=eye_col)
        draw.ellipse([head_cx + 10*scale, head_cy - 2*scale, head_cx + 12*scale, head_cy], fill=(255, 255, 255))

    elif archetype in ["biped"]:
        # Tail
        if "tail" in features or "tail_fire" in features:
            tail_pts = [
                (cx - 12*scale, cy + 12*scale),
                (cx - 30*scale, cy + 4*scale + math.sin(limb_phase)*2*scale),
                (cx - 22*scale, cy - 8*scale + math.sin(limb_phase)*2*scale),
                (cx - 8*scale, cy + 2*scale)
            ]
            draw.polygon(tail_pts, fill=primary, outline=adjust_color(primary, 0.7))
            if "tail_fire" in features:
                f_cx = cx - 26*scale
                f_cy = cy - 6*scale
                draw.ellipse([f_cx - 9*scale, f_cy - 9*scale, f_cx + 9*scale, f_cy + 9*scale], fill=(255, 130, 20, 230))
                draw.ellipse([f_cx - 5*scale, f_cy - 5*scale, f_cx + 5*scale, f_cy + 5*scale], fill=(255, 230, 80, 240))

        # Wings
        if "wings" in features:
            wing_pts = [(cx - 6*scale, cy - 8*scale), (cx - 36*scale, cy - 36*scale + limb_phase*4*scale), (cx - 18*scale, cy - 4*scale)]
            draw.polygon(wing_pts, fill=secondary, outline=adjust_color(secondary, 0.7))

        # Legs
        leg_offset = limb_phase * 4 * scale
        draw.rounded_rectangle([cx - 14*scale + leg_offset, cy + 14*scale, cx - 4*scale + leg_offset, cy + 30*scale], radius=3*scale, fill=adjust_color(primary, 0.85))
        draw.rounded_rectangle([cx + 2*scale - leg_offset, cy + 14*scale, cx + 12*scale - leg_offset, cy + 30*scale], radius=3*scale, fill=primary)

        # Torso
        draw_shaded_circle(draw, [cx - 16*scale, cy - 10*scale, cx + 16*scale, cy + 18*scale], primary)
        # Belly
        draw.ellipse([cx - 10*scale, cy - 2*scale, cx + 10*scale, cy + 15*scale], fill=secondary)

        # Arms / Weapons
        arm_reach = atk_thrust * 18 * scale
        draw.rounded_rectangle([cx - 18*scale, cy - 4*scale, cx - 8*scale, cy + 12*scale], radius=3*scale, fill=adjust_color(primary, 0.85))
        draw.rounded_rectangle([cx + 8*scale + arm_reach*0.5, cy - 4*scale, cx + 18*scale + arm_reach, cy + 10*scale], radius=3*scale, fill=primary)
        
        if "scythes" in features:
            # Scythe blades
            scythe_pts = [(cx + 16*scale + arm_reach, cy + 2*scale), (cx + 34*scale + arm_reach, cy - 12*scale), (cx + 24*scale + arm_reach, cy + 14*scale)]
            draw.polygon(scythe_pts, fill=(240, 245, 250), outline=(150, 180, 160))
        elif "claws" in features:
            draw.polygon([(cx + 18*scale + arm_reach, cy + 2*scale), (cx + 28*scale + arm_reach, cy + 4*scale), (cx + 18*scale + arm_reach, cy + 8*scale)], fill=accent)

        # Head
        head_cx = cx
        head_cy = cy - 22*scale
        head_r = 15*scale
        draw_shaded_circle(draw, [head_cx - head_r, head_cy - head_r, head_cx + head_r, head_cy + head_r], primary)

        # Head features
        if "ears" in features:
            draw.polygon([(head_cx - 12*scale, head_cy - 8*scale), (head_cx - 18*scale, head_cy - 24*scale), (head_cx - 4*scale, head_cy - 12*scale)], fill=primary)
            draw.polygon([(head_cx + 4*scale, head_cy - 12*scale), (head_cx + 18*scale, head_cy - 24*scale), (head_cx + 12*scale, head_cy - 8*scale)], fill=primary)
        elif "horns" in features:
            draw.polygon([(head_cx - 4*scale, head_cy - 12*scale), (head_cx - 2*scale, head_cy - 26*scale), (head_cx + 4*scale, head_cy - 12*scale)], fill=accent)

        # Eyes
        draw.ellipse([head_cx + 1*scale, head_cy - 4*scale, head_cx + 9*scale, head_cy + 4*scale], fill=(255, 255, 255))
        draw.ellipse([head_cx + 3*scale, head_cy - 2*scale, head_cx + 9*scale, head_cy + 3*scale], fill=eye_col)
        draw.ellipse([head_cx + 5*scale, head_cy - 2*scale, head_cx + 8*scale, head_cy], fill=(255, 255, 255))

    elif archetype in ["avian"]:
        # Avian/Bird
        wing_flap = math.sin(limb_phase * 2 * math.pi) * 8 * scale
        # Back wing
        draw.polygon([(cx - 8*scale, cy - 10*scale), (cx - 36*scale, cy - 28*scale - wing_flap), (cx - 24*scale, cy + 6*scale)], fill=adjust_color(secondary, 0.85))

        # Tail feathers
        draw.polygon([(cx - 18*scale, cy + 8*scale), (cx - 38*scale, cy + 18*scale), (cx - 16*scale, cy + 16*scale)], fill=accent)

        # Legs/talons
        draw.line([cx - 4*scale, cy + 16*scale, cx - 6*scale, cy + 28*scale], fill=accent, width=int(2*scale))
        draw.line([cx + 6*scale, cy + 16*scale, cx + 8*scale, cy + 28*scale], fill=accent, width=int(2*scale))

        # Body
        draw_shaded_circle(draw, [cx - 18*scale, cy - 12*scale, cx + 18*scale, cy + 18*scale], primary)
        # Chest patch
        draw.ellipse([cx - 6*scale, cy - 4*scale, cx + 14*scale, cy + 14*scale], fill=secondary)

        # Front wing
        draw.polygon([(cx + 4*scale, cy - 6*scale), (cx - 20*scale, cy - 26*scale + wing_flap), (cx - 10*scale, cy + 12*scale)], fill=secondary)

        # Head & Crest
        head_cx = cx + 14*scale
        head_cy = cy - 20*scale
        head_r = 13*scale
        draw_shaded_circle(draw, [head_cx - head_r, head_cy - head_r, head_cx + head_r, head_cy + head_r], primary)

        if "crest" in features or "crown" in features:
            draw.polygon([(head_cx - 6*scale, head_cy - 10*scale), (head_cx - 14*scale, head_cy - 24*scale), (head_cx + 2*scale, head_cy - 12*scale)], fill=accent)
            draw.polygon([(head_cx + 2*scale, head_cy - 12*scale), (head_cx + 8*scale, head_cy - 26*scale), (head_cx + 8*scale, head_cy - 10*scale)], fill=secondary)

        # Beak
        draw.polygon([(head_cx + 8*scale, head_cy - 3*scale), (head_cx + 22*scale, head_cy + 2*scale), (head_cx + 8*scale, head_cy + 6*scale)], fill=accent)

        # Eye
        draw.ellipse([head_cx + 3*scale, head_cy - 5*scale, head_cx + 10*scale, head_cy + 2*scale], fill=(255, 255, 255))
        draw.ellipse([head_cx + 5*scale, head_cy - 3*scale, head_cx + 10*scale, head_cy + 1*scale], fill=eye_col)

    elif archetype in ["serpentine"]:
        # Serpentine coils
        for i, (ox, oy, r) in enumerate([(-20, 18, 14), (-4, 14, 16), (12, 10, 15), (14, -6, 14), (8, -22, 13)]):
            wave = math.sin(limb_phase + i * 0.8) * 3 * scale
            col = primary if i % 2 == 0 else secondary
            draw_shaded_circle(draw, [cx + (ox-r)*scale + wave, cy + (oy-r)*scale, cx + (ox+r)*scale + wave, cy + (oy+r)*scale], col)
        
        # Head
        head_cx = cx + 10*scale
        head_cy = cy - 24*scale
        draw_shaded_circle(draw, [head_cx - 14*scale, head_cy - 14*scale, head_cx + 14*scale, head_cy + 14*scale], primary)
        if "horns" in features:
            draw.polygon([(head_cx - 4*scale, head_cy - 10*scale), (head_cx - 2*scale, head_cy - 24*scale), (head_cx + 4*scale, head_cy - 10*scale)], fill=accent)
        elif "wings_ears" in features:
            draw.polygon([(head_cx - 10*scale, head_cy - 8*scale), (head_cx - 20*scale, head_cy - 20*scale), (head_cx - 6*scale, head_cy - 14*scale)], fill=(245, 245, 250))
            draw.polygon([(head_cx + 10*scale, head_cy - 8*scale), (head_cx + 20*scale, head_cy - 20*scale), (head_cx + 6*scale, head_cy - 14*scale)], fill=(245, 245, 250))

        # Eye
        draw.ellipse([head_cx + 2*scale, head_cy - 4*scale, head_cx + 10*scale, head_cy + 4*scale], fill=(255, 255, 255))
        draw.ellipse([head_cx + 4*scale, head_cy - 2*scale, head_cx + 10*scale, head_cy + 3*scale], fill=eye_col)

    elif archetype in ["orb", "blob"]:
        # Spherical / amorphous creature
        r = 24 * scale
        if archetype == "blob":
            # Wavy shape
            pts = []
            for a in range(16):
                ang = a * (2 * math.pi / 16)
                rad = r + math.sin(ang * 4 + limb_phase) * 3 * scale
                pts.append((cx + math.cos(ang) * rad, cy + math.sin(ang) * rad))
            draw.polygon(pts, fill=primary, outline=adjust_color(primary, 0.8))
        else:
            draw_shaded_circle(draw, [cx - r, cy - r, cx + r, cy + r], primary)
            if "ball" in features:
                # Poke-ball style split
                draw.chord([cx - r, cy - r, cx + r, cy + r], 0, 180, fill=secondary)
                draw.line([cx - r, cy, cx + r, cy], fill=(30, 30, 30), width=int(3*scale))
                draw.ellipse([cx - 6*scale, cy - 6*scale, cx + 6*scale, cy + 6*scale], fill=(255, 255, 255), outline=(30, 30, 30), width=int(2*scale))

        if "ears" in features:
            draw.polygon([(cx - 18*scale, cy - 18*scale), (cx - 26*scale, cy - 34*scale), (cx - 8*scale, cy - 22*scale)], fill=primary)
            draw.polygon([(cx + 8*scale, cy - 22*scale), (cx + 26*scale, cy - 34*scale), (cx + 18*scale, cy - 18*scale)], fill=primary)

        # Expressive eyes
        draw.ellipse([cx - 12*scale, cy - 8*scale, cx - 2*scale, cy + 4*scale], fill=(255, 255, 255))
        draw.ellipse([cx - 10*scale, cy - 6*scale, cx - 3*scale, cy + 3*scale], fill=eye_col)
        draw.ellipse([cx + 2*scale, cy - 8*scale, cx + 12*scale, cy + 4*scale], fill=(255, 255, 255))
        draw.ellipse([cx + 4*scale, cy - 6*scale, cx + 11*scale, cy + 3*scale], fill=eye_col)

    elif archetype in ["star"]:
        # 5-point star
        pts = []
        for i in range(10):
            ang = -math.pi/2 + i * (math.pi / 5)
            rad = (26 if i % 2 == 0 else 13) * scale
            pts.append((cx + math.cos(ang) * rad, cy + math.sin(ang) * rad))
        draw.polygon(pts, fill=primary, outline=adjust_color(primary, 0.75))
        if "gem" in features:
            draw.ellipse([cx - 8*scale, cy - 8*scale, cx + 8*scale, cy + 8*scale], fill=secondary)
            draw.ellipse([cx - 5*scale, cy - 5*scale, cx + 5*scale, cy + 5*scale], fill=accent)
            draw.ellipse([cx - 3*scale, cy - 3*scale, cx, cy], fill=(255, 255, 255))

    elif archetype in ["shell"]:
        # Armored shell creature
        draw_shaded_circle(draw, [cx - 22*scale, cy - 16*scale, cx + 22*scale, cy + 20*scale], primary)
        # Inner soft body or spikes
        if "horns" in features:
            draw.polygon([(cx - 14*scale, cy - 16*scale), (cx - 24*scale, cy - 32*scale), (cx - 4*scale, cy - 18*scale)], fill=accent)
            draw.polygon([(cx + 4*scale, cy - 18*scale), (cx + 24*scale, cy - 32*scale), (cx + 14*scale, cy - 16*scale)], fill=accent)
        draw.ellipse([cx - 10*scale, cy - 2*scale, cx + 10*scale, cy + 12*scale], fill=secondary)
        if "tongue" in features:
            draw.ellipse([cx - 6*scale, cy + 4*scale, cx + 8*scale, cy + 22*scale], fill=accent)
        # Eyes
        draw.ellipse([cx - 8*scale, cy - 2*scale, cx - 2*scale, cy + 4*scale], fill=eye_col)
        draw.ellipse([cx + 2*scale, cy - 2*scale, cx + 8*scale, cy + 4*scale], fill=eye_col)

    elif archetype in ["fish"]:
        # Torpedo fish body
        tail_wave = math.sin(limb_phase) * 6 * scale
        # Tail fin
        draw.polygon([(cx - 16*scale, cy), (cx - 36*scale, cy - 14*scale + tail_wave), (cx - 36*scale, cy + 14*scale + tail_wave)], fill=accent)
        # Dorsal fin
        draw.polygon([(cx - 8*scale, cy - 12*scale), (cx, cy - 28*scale), (cx + 10*scale, cy - 10*scale)], fill=secondary)
        # Main body
        draw_shaded_circle(draw, [cx - 20*scale, cy - 14*scale, cx + 22*scale, cy + 14*scale], primary)
        # Belly
        draw.ellipse([cx - 12*scale, cy, cx + 14*scale, cy + 13*scale], fill=secondary)
        # Horns
        if "horns" in features:
            draw.polygon([(cx + 12*scale, cy - 8*scale), (cx + 32*scale, cy - 20*scale), (cx + 18*scale, cy - 2*scale)], fill=accent)
        # Eye
        draw.ellipse([cx + 8*scale, cy - 6*scale, cx + 16*scale, cy + 2*scale], fill=(255, 255, 255))
        draw.ellipse([cx + 11*scale, cy - 4*scale, cx + 16*scale, cy + 1*scale], fill=eye_col)

    elif archetype in ["bug"]:
        # Bug segments
        draw_shaded_circle(draw, [cx - 12*scale, cy + 2*scale, cx + 12*scale, cy + 22*scale], secondary) # abdomen
        draw_shaded_circle(draw, [cx - 10*scale, cy - 10*scale, cx + 10*scale, cy + 6*scale], primary)   # thorax
        draw_shaded_circle(draw, [cx - 8*scale, cy - 24*scale, cx + 8*scale, cy - 10*scale], primary)  # head
        # Antennae / horns
        draw.line([cx - 4*scale, cy - 22*scale, cx - 14*scale, cy - 36*scale], fill=accent, width=int(2*scale))
        draw.line([cx + 4*scale, cy - 22*scale, cx + 14*scale, cy - 36*scale], fill=accent, width=int(2*scale))
        if "wings" in features:
            draw.ellipse([cx - 28*scale, cy - 20*scale, cx + 28*scale, cy - 4*scale], fill=(240, 245, 255, 170), outline=(180, 200, 220))
        # Large compound eyes
        draw.ellipse([cx - 9*scale, cy - 20*scale, cx - 2*scale, cy - 11*scale], fill=eye_col)
        draw.ellipse([cx + 2*scale, cy - 20*scale, cx + 9*scale, cy - 11*scale], fill=eye_col)

    elif archetype in ["floating"]:
        # Floating entity (jellyfish, magnet, spore)
        draw_shaded_circle(draw, [cx - 18*scale, cy - 18*scale, cx + 18*scale, cy + 12*scale], primary)
        if "tentacles" in features:
            for tx in [-10, -4, 2, 8]:
                t_wave = math.sin(limb_phase + tx) * 4 * scale
                draw.line([cx + tx*scale, cy + 10*scale, cx + (tx + t_wave)*scale, cy + 28*scale], fill=accent, width=int(2*scale))
        # Eye / gems
        draw.ellipse([cx - 8*scale, cy - 8*scale, cx - 2*scale, cy - 2*scale], fill=accent)
        draw.ellipse([cx + 2*scale, cy - 8*scale, cx + 8*scale, cy - 2*scale], fill=accent)

    # Attack slash / impact VFX overlay
    if anim_state == "attack" and atk_thrust > 0.4:
        slash_x = cx + (18 + atk_thrust * 14) * scale
        slash_y = cy - (4 * scale)
        slash_r = (14 + atk_thrust * 10) * scale
        draw.arc([slash_x - slash_r, slash_y - slash_r, slash_x + slash_r, slash_y + slash_r], -70, 70, fill=(255, 240, 160, 220), width=int(3*scale))
        draw.ellipse([slash_x + slash_r*0.8 - 4*scale, slash_y - 4*scale, slash_x + slash_r*0.8 + 4*scale, slash_y + 4*scale], fill=(255, 255, 255, 240))

    # Hurt flash
    if hurt_flash:
        flash_overlay = Image.new("RGBA", (size, size), (255, 80, 80, 75))
        img = Image.alpha_composite(img, flash_overlay)

    return img

def main():
    print(f"Starting Gen 1 asset generation for {len(ALL_GEN1_POKEMON)} Pokemon...")
    generated_count = 0
    skipped_count = 0

    for pid, pdata in ALL_GEN1_POKEMON.items():
        if pid in EXISTING_IDS:
            skipped_count += 1
            continue

        visual = pdata.get("visual", {})
        
        # 1. Generate 256x256 Avatar
        avatar_path = os.path.join(UNITS_DIR, f"{pid}.png")
        avatar_img = draw_pokemon_sprite(256, visual, anim_state="idle", frame_idx=0, is_avatar=True)
        avatar_img.save(avatar_path, "PNG")

        # 2. Generate 128x128 uniform animation frames
        p_anim_dir = os.path.join(ANIM_DIR, pid)
        os.makedirs(p_anim_dir, exist_ok=True)

        # idle.png
        idle_img = draw_pokemon_sprite(128, visual, anim_state="idle", frame_idx=0)
        idle_img.save(os.path.join(p_anim_dir, "idle.png"), "PNG")

        # walk_0..5.png
        for i in range(6):
            w_img = draw_pokemon_sprite(128, visual, anim_state="walk", frame_idx=i)
            w_img.save(os.path.join(p_anim_dir, f"walk_{i}.png"), "PNG")

        # attack_0..5.png
        for i in range(6):
            a_img = draw_pokemon_sprite(128, visual, anim_state="attack", frame_idx=i)
            a_img.save(os.path.join(p_anim_dir, f"attack_{i}.png"), "PNG")

        # hurt_0..1.png
        for i in range(2):
            h_img = draw_pokemon_sprite(128, visual, anim_state="hurt", frame_idx=i)
            h_img.save(os.path.join(p_anim_dir, f"hurt_{i}.png"), "PNG")

        generated_count += 1
        if generated_count % 25 == 0 or generated_count == 134:
            print(f"Generated {generated_count}/134 Pokemon assets...")

    print(f"Finished! Generated {generated_count} new Pokemon asset sets, skipped {skipped_count} existing.")

if __name__ == "__main__":
    main()
