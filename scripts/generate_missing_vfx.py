#!/usr/bin/env python3
import os
import math
from PIL import Image, ImageDraw, ImageFilter

VFX_DIR = "assets/vfx"

MISSING_VFX = [
    'acid_armor', 'air_slash', 'ancient_power', 'aurora_beam', 'bone_rush', 
    'bonemerang', 'brave_bird', 'confusion', 'crabhammer', 'cross_chop', 
    'dragon_breath', 'dragon_claw', 'dream_eater', 'drill_peck', 'dynamic_punch', 
    'earthquake', 'fire_punch', 'gunk_shot', 'heal_pulse', 'hypnosis', 
    'ice_beam', 'light_screen', 'perish_song', 'pin_missile', 'poison_sting', 
    'psychic', 'reflect', 'rock_slide', 'shadow_punch', 'slash', 
    'sludge_bomb', 'softboiled', 'stone_edge', 'thunder', 'transform', 
    'tri_attack', 'twister'
]

def render_vfx_frame(vfx_name, frame_idx, size=200):
    img = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    t = frame_idx / 5.0  # 0.0 to 1.0
    cx, cy = size / 2.0, size / 2.0

    if vfx_name == 'slash':
        # Sharp silver sword slash
        arc_r = 40 + t * 45
        alpha = int(255 * (1.0 - t * 0.5))
        draw.arc([cx - arc_r, cy - arc_r, cx + arc_r, cy + arc_r], -120 + t*30, 40 + t*30, fill=(250, 250, 255, alpha), width=6)
        draw.arc([cx - arc_r*0.9, cy - arc_r*0.9, cx + arc_r*0.9, cy + arc_r*0.9], -110 + t*30, 30 + t*30, fill=(180, 210, 245, alpha), width=3)

    elif vfx_name == 'air_slash':
        # Flying crescent air blade
        blade_x = cx - 40 + t * 80
        alpha = int(255 * (1.0 - t * 0.4))
        draw.arc([blade_x - 30, cy - 45, blade_x + 30, cy + 45], -60, 60, fill=(180, 245, 230, alpha), width=7)
        draw.arc([blade_x - 34, cy - 48, blade_x + 26, cy + 48], -50, 50, fill=(255, 255, 255, alpha), width=3)

    elif vfx_name == 'dragon_claw':
        # Triple dragon energy claw slash
        alpha = int(255 * (1.0 - t * 0.5))
        for offset in [-16, 0, 16]:
            draw.arc([cx - 40 + offset, cy - 45 + offset*0.4, cx + 40 + offset, cy + 45 + offset*0.4], -110, 20, fill=(60, 230, 180, alpha), width=5)
            draw.arc([cx - 38 + offset, cy - 43 + offset*0.4, cx + 38 + offset, cy + 43 + offset*0.4], -100, 10, fill=(230, 255, 240, alpha), width=2)

    elif vfx_name == 'cross_chop':
        # X-shaped dual slash
        r = 30 + t * 40
        alpha = int(255 * (1.0 - t * 0.4))
        draw.line([cx - r, cy - r, cx + r, cy + r], fill=(255, 180, 40, alpha), width=6)
        draw.line([cx + r, cy - r, cx - r, cy + r], fill=(255, 180, 40, alpha), width=6)
        draw.line([cx - r*0.8, cy - r*0.8, cx + r*0.8, cy + r*0.8], fill=(255, 255, 255, alpha), width=2)
        draw.line([cx + r*0.8, cy - r*0.8, cx - r*0.8, cy + r*0.8], fill=(255, 255, 255, alpha), width=2)

    elif vfx_name == 'ice_beam':
        # Cyan frost laser with crystal sparks
        beam_w = 8 + math.sin(t * math.pi) * 8
        draw.line([20, cy, size - 20, cy], fill=(120, 220, 255, int(220 * (1.0 - t*0.3))), width=int(beam_w))
        draw.line([20, cy, size - 20, cy], fill=(255, 255, 255, 240), width=int(beam_w * 0.4))
        # Ice shards
        for i in range(5):
            sx = 40 + i * 28 + t * 15
            sy = cy + math.sin(i * 1.7) * 18
            draw.polygon([(sx, sy - 6), (sx + 5, sy), (sx, sy + 6), (sx - 5, sy)], fill=(200, 245, 255, 220))

    elif vfx_name == 'aurora_beam':
        # Northern lights prismatic wave
        for i in range(25):
            x = 20 + i * 6
            y = cy + math.sin(i * 0.4 + t * 4) * 22
            col = (int(140 + 100 * math.sin(i * 0.3)), int(200 + 55 * math.cos(i * 0.2)), 255, int(200 * (1.0 - t*0.3)))
            draw.ellipse([x - 6, y - 6, x + 6, y + 6], fill=col)

    elif vfx_name in ['thunder']:
        # Mega lightning bolt crashing down
        alpha = int(255 * (1.0 - t * 0.4))
        pts = [(cx - 10, 10), (cx + 15, 60), (cx - 8, 110), (cx + 20, 150), (cx, size - 15)]
        draw.line(pts, fill=(255, 240, 60, alpha), width=8)
        draw.line(pts, fill=(255, 255, 255, alpha), width=3)
        # Ground shockwave
        sw = 20 + t * 65
        draw.ellipse([cx - sw, size - 25 - sw*0.3, cx + sw, size - 25 + sw*0.3], outline=(255, 220, 40, alpha), width=4)

    elif vfx_name in ['earthquake', 'stone_edge', 'rock_slide']:
        # Seismic rocks and fissures
        shk = math.sin(t * 8) * 4
        # Cracks
        draw.line([cx - 60 - t*20, cy + 30, cx, cy + 10], fill=(140, 100, 60, 220), width=4)
        draw.line([cx, cy + 10, cx + 60 + t*20, cy + 35], fill=(140, 100, 60, 220), width=4)
        # Rising stone spikes
        h = (math.sin(t * math.pi) if t < 0.7 else 1.0 - (t - 0.7)/0.3) * 55
        draw.polygon([(cx - 30, cy + 25), (cx - 15, cy + 25 - h), (cx, cy + 25)], fill=(160, 145, 130), outline=(100, 90, 80))
        draw.polygon([(cx - 5, cy + 25), (cx + 10, cy + 25 - h*1.2), (cx + 25, cy + 25)], fill=(180, 165, 150), outline=(100, 90, 80))
        draw.polygon([(cx + 15, cy + 25), (cx + 35, cy + 25 - h*0.8), (cx + 50, cy + 25)], fill=(150, 135, 120), outline=(100, 90, 80))

    elif vfx_name in ['psychic', 'confusion']:
        # Hypnotic psychedelic expanding rings
        r = 15 + t * 65
        alpha = int(220 * (1.0 - t * 0.4))
        draw.ellipse([cx - r, cy - r, cx + r, cy + r], outline=(245, 90, 200, alpha), width=5)
        draw.ellipse([cx - r*0.6, cy - r*0.6, cx + r*0.6, cy + r*0.6], outline=(180, 70, 240, alpha), width=4)
        draw.ellipse([cx - r*0.3, cy - r*0.3, cx + r*0.3, cy + r*0.3], outline=(255, 255, 255, alpha), width=3)

    elif vfx_name in ['sludge_bomb', 'gunk_shot', 'poison_sting', 'acid_armor']:
        # Poisonous purple sludge blob & splash
        r = 16 + math.sin(t * math.pi) * 18
        alpha = int(240 * (1.0 - t * 0.3))
        draw.ellipse([cx - r, cy - r, cx + r, cy + r], fill=(140, 50, 175, alpha), outline=(80, 25, 110))
        # Droplets
        for a in range(8):
            ang = a * (math.pi / 4.0)
            dist = r + t * 35
            dx = cx + math.cos(ang) * dist
            dy = cy + math.sin(ang) * dist
            draw.ellipse([dx - 5, dy - 5, dx + 5, dy + 5], fill=(175, 75, 215, alpha))

    elif vfx_name in ['fire_punch', 'dynamic_punch', 'crabhammer', 'shadow_punch']:
        # Explosive elemental punch impact
        f_r = 18 + t * 45
        alpha = int(255 * (1.0 - t * 0.5))
        col = (255, 100, 30) if 'fire' in vfx_name else ((50, 160, 240) if 'crab' in vfx_name else ((130, 50, 180) if 'shadow' in vfx_name else (255, 210, 40)))
        draw.ellipse([cx - f_r, cy - f_r, cx + f_r, cy + f_r], fill=(col[0], col[1], col[2], int(alpha*0.4)), outline=(col[0], col[1], col[2], alpha), width=5)
        # Center core
        draw.ellipse([cx - 14, cy - 14, cx + 14, cy + 14], fill=(255, 255, 255, alpha))

    elif vfx_name in ['brave_bird', 'drill_peck', 'pin_missile']:
        # High speed thrust / bird flight
        alpha = int(255 * (1.0 - t * 0.4))
        p_x = cx - 30 + t * 60
        draw.polygon([(p_x + 35, cy), (p_x - 20, cy - 22), (p_x - 10, cy), (p_x - 20, cy + 22)], fill=(245, 210, 60, alpha), outline=(210, 90, 20))
        draw.ellipse([p_x - 30, cy - 12, p_x + 10, cy + 12], fill=(255, 255, 255, int(alpha*0.8)))

    elif vfx_name in ['twister', 'dragon_breath']:
        # Vortex spiral cone
        alpha = int(240 * (1.0 - t * 0.3))
        for layer in range(6):
            ly = cy + 50 - layer * 18
            lw = 12 + layer * 10
            draw.ellipse([cx - lw, ly - 8, cx + lw, ly + 8], outline=(100, 220, 240, alpha), width=4)

    elif vfx_name in ['bone_rush', 'bonemerang']:
        # Rotating bone
        angle = t * math.pi * 3
        bx0 = cx + math.cos(angle) * 30
        by0 = cy + math.sin(angle) * 30
        bx1 = cx - math.cos(angle) * 30
        by1 = cy - math.sin(angle) * 30
        draw.line([bx0, by0, bx1, by1], fill=(245, 240, 230), width=8)
        draw.ellipse([bx0 - 7, by0 - 7, bx0 + 7, by0 + 7], fill=(245, 240, 230))
        draw.ellipse([bx1 - 7, by1 - 7, bx1 + 7, by1 + 7], fill=(245, 240, 230))

    elif vfx_name in ['reflect', 'light_screen']:
        # Hexagonal protective barrier
        r = 35 + math.sin(t * math.pi) * 10
        alpha = int(230 * (1.0 - t * 0.4))
        pts = []
        for i in range(6):
            ang = i * (math.pi / 3.0)
            pts.append((cx + math.cos(ang) * r, cy + math.sin(ang) * r))
        draw.polygon(pts, fill=(240, 220, 100, int(alpha*0.35)), outline=(255, 240, 140, alpha))

    elif vfx_name in ['heal_pulse', 'softboiled']:
        # Expanding warm healing rings with sparkles
        r = 15 + t * 50
        alpha = int(220 * (1.0 - t * 0.4))
        draw.ellipse([cx - r, cy - r, cx + r, cy + r], outline=(100, 240, 180, alpha), width=5)
        draw.ellipse([cx - 10, cy - 10, cx + 10, cy + 10], fill=(255, 255, 240, alpha))
        for i in range(4):
            sx = cx + math.cos(t*3 + i*1.5) * (r * 0.8)
            sy = cy + math.sin(t*3 + i*1.5) * (r * 0.8)
            draw.ellipse([sx - 4, sy - 4, sx + 4, sy + 4], fill=(255, 255, 255, alpha))

    elif vfx_name in ['tri_attack']:
        # Fire, Ice, Lightning triad
        r = 30 + t * 15
        alpha = int(240 * (1.0 - t * 0.3))
        cols = [(255, 80, 40), (80, 180, 255), (255, 220, 50)]
        for i, col in enumerate(cols):
            ang = t * 4 + i * (2 * math.pi / 3.0)
            tx = cx + math.cos(ang) * r
            ty = cy + math.sin(ang) * r
            draw.ellipse([tx - 12, ty - 12, tx + 12, ty + 12], fill=(col[0], col[1], col[2], alpha))
            draw.ellipse([tx - 6, ty - 6, tx + 6, ty + 6], fill=(255, 255, 255, alpha))

    else:
        # Generic magical particle burst
        r = 15 + t * 50
        alpha = int(240 * (1.0 - t * 0.4))
        draw.ellipse([cx - r, cy - r, cx + r, cy + r], outline=(180, 150, 240, alpha), width=4)
        for i in range(6):
            ang = i * (math.pi / 3.0) + t * 2
            px = cx + math.cos(ang) * (r * 0.9)
            py = cy + math.sin(ang) * (r * 0.9)
            draw.ellipse([px - 5, py - 5, px + 5, py + 5], fill=(240, 220, 255, alpha))

    return img

def main():
    print(f"Generating 6 frames each for {len(MISSING_VFX)} missing VFX...")
    for vfx_name in MISSING_VFX:
        v_dir = os.path.join(VFX_DIR, vfx_name)
        os.makedirs(v_dir, exist_ok=True)
        for idx in range(6):
            frame = render_vfx_frame(vfx_name, idx)
            frame.save(os.path.join(v_dir, f"frame_{idx}.png"), "PNG")
    print("All missing VFX frames successfully generated!")

if __name__ == "__main__":
    main()
