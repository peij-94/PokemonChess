import os
from PIL import Image, ImageDraw

OUTPUT_DIR = "assets/ui/trainers"
os.makedirs(OUTPUT_DIR, exist_ok=True)

def create_circular_avatar(draw_func, filename, rim_color, bg_color):
    size = 128
    img = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    d = ImageDraw.Draw(img)
    
    # Outer circle rim
    d.ellipse([2, 2, size - 3, size - 3], fill=bg_color, outline=rim_color, width=4)
    # Inner border
    d.ellipse([6, 6, size - 7, size - 7], outline=(255, 255, 255, 120), width=1)
    
    # Custom character drawing inside clipping circle
    char_img = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    cd = ImageDraw.Draw(char_img)
    draw_func(cd, size)
    
    # Create mask for circular avatar
    mask = Image.new("L", (size, size), 0)
    md = ImageDraw.Draw(mask)
    md.ellipse([6, 6, size - 7, size - 7], fill=255)
    
    # Composite
    img.paste(char_img, (0, 0), mask)
    
    # Re-draw clean border on top
    d.ellipse([2, 2, size - 3, size - 3], outline=rim_color, width=4)
    d.ellipse([5, 5, size - 6, size - 6], outline=(255, 255, 255, 80), width=1)
    
    filepath = os.path.join(OUTPUT_DIR, filename)
    img.save(filepath)
    print(f"Generated {filepath}")

# 1. RED (赤红): Red cap, dark spiky hair, red jacket, white collar, confident eyes
def draw_red(d: ImageDraw.ImageDraw, s: int):
    # Background subtle rays
    d.ellipse([10, 10, s-11, s-11], fill=(220, 45, 45, 255))
    
    # Body / Jacket
    d.polygon([(25, s), (40, 78), (88, 78), (103, s)], fill=(200, 30, 30, 255)) # Red jacket
    d.polygon([(46, 78), (64, 95), (82, 78)], fill=(240, 240, 245, 255)) # White t-shirt collar
    d.polygon([(36, 76), (50, 76), (46, s)], fill=(250, 250, 255, 255)) # White vest collar left
    d.polygon([(92, 76), (78, 76), (82, s)], fill=(250, 250, 255, 255)) # White vest collar right
    
    # Neck
    d.rectangle([54, 68, 74, 82], fill=(255, 213, 180, 255))
    
    # Face
    d.ellipse([42, 38, 86, 78], fill=(255, 218, 185, 255))
    
    # Spiky hair sides & back
    d.polygon([(32, 50), (42, 42), (38, 62)], fill=(45, 30, 30, 255))
    d.polygon([(96, 50), (86, 42), (90, 62)], fill=(45, 30, 30, 255))
    d.polygon([(44, 48), (52, 56), (48, 60)], fill=(45, 30, 30, 255))
    d.polygon([(84, 48), (76, 56), (80, 60)], fill=(45, 30, 30, 255))
    
    # Eyes
    d.ellipse([50, 52, 58, 59], fill=(40, 30, 30, 255))
    d.ellipse([70, 52, 78, 59], fill=(40, 30, 30, 255))
    d.ellipse([54, 53, 57, 56], fill=(255, 255, 255, 255))
    d.ellipse([74, 53, 77, 56], fill=(255, 255, 255, 255))
    
    # Confident mouth & nose
    d.line([(63, 56), (64, 60)], fill=(220, 160, 130, 255), width=2)
    d.line([(58, 67), (70, 67)], fill=(180, 80, 80, 255), width=2)
    
    # Cap (Red baseball cap with white semi-circle front and visor)
    # Cap main dome
    d.chord([36, 18, 92, 58], start=180, end=360, fill=(225, 25, 25, 255))
    # Cap front white semi-circle
    d.ellipse([46, 24, 82, 48], fill=(250, 250, 250, 255))
    # Pokeball badge on cap
    d.ellipse([59, 29, 69, 39], fill=(220, 40, 40, 255), outline=(40, 40, 40, 255), width=1)
    d.chord([59, 34, 69, 39], start=0, end=180, fill=(255, 255, 255, 255))
    d.ellipse([62, 32, 66, 36], fill=(255, 255, 255, 255), outline=(40, 40, 40, 255), width=1)
    # Visor
    d.polygon([(30, 44), (98, 44), (92, 49), (36, 49)], fill=(180, 20, 20, 255), outline=(130, 10, 10, 255))

# 2. MISTY (小霞): Bright orange hair side ponytail, yellow sleeveless shirt, water theme
def draw_misty(d: ImageDraw.ImageDraw, s: int):
    # Blue water background
    d.ellipse([10, 10, s-11, s-11], fill=(40, 140, 225, 255))
    
    # Side Ponytail (left side)
    d.ellipse([14, 26, 46, 58], fill=(245, 120, 30, 255))
    d.polygon([(26, 34), (40, 42), (32, 56), (16, 48)], fill=(255, 135, 45, 255))
    # Blue hair tie
    d.ellipse([34, 40, 44, 50], fill=(50, 200, 240, 255))
    
    # Body / Yellow top with red suspenders
    d.polygon([(25, s), (42, 80), (86, 80), (103, s)], fill=(255, 225, 60, 255))
    # Red suspenders
    d.rectangle([44, 80, 52, s], fill=(230, 50, 50, 255))
    d.rectangle([76, 80, 84, s], fill=(230, 50, 50, 255))
    
    # Neck & collarbone
    d.rectangle([56, 70, 72, 82], fill=(255, 218, 185, 255))
    
    # Face
    d.ellipse([44, 38, 84, 78], fill=(255, 222, 195, 255))
    
    # Short spiky hair
    d.ellipse([38, 22, 90, 54], fill=(245, 120, 30, 255))
    d.polygon([(42, 38), (56, 46), (50, 30)], fill=(255, 140, 50, 255))
    d.polygon([(54, 36), (68, 48), (64, 28)], fill=(255, 140, 50, 255))
    d.polygon([(68, 38), (82, 46), (78, 28)], fill=(255, 140, 50, 255))
    d.polygon([(78, 40), (88, 54), (88, 36)], fill=(240, 110, 25, 255))
    
    # Bright cheerful blue eyes
    d.ellipse([49, 50, 57, 60], fill=(30, 150, 220, 255))
    d.ellipse([71, 50, 79, 60], fill=(30, 150, 220, 255))
    d.ellipse([53, 51, 56, 55], fill=(255, 255, 255, 255))
    d.ellipse([75, 51, 78, 55], fill=(255, 255, 255, 255))
    
    # Cheerful smile & blush
    d.ellipse([44, 58, 49, 63], fill=(255, 160, 160, 180))
    d.ellipse([79, 58, 84, 63], fill=(255, 160, 160, 180))
    d.arc([58, 62, 70, 70], start=0, end=180, fill=(210, 70, 80, 255), width=2)

# 3. STEVEN STONE (大吾): Silver-blue layered hair, black/crimson suit, steel brooch, cool calm aura
def draw_steven(d: ImageDraw.ImageDraw, s: int):
    # Steel / Slate grey background
    d.ellipse([10, 10, s-11, s-11], fill=(70, 90, 110, 255))
    
    # Suit
    d.polygon([(22, s), (38, 76), (90, 76), (106, s)], fill=(35, 38, 48, 255)) # Dark navy/black coat
    d.polygon([(46, 76), (64, 96), (82, 76)], fill=(120, 25, 50, 255)) # Deep crimson cravat/vest
    d.polygon([(56, 76), (64, 88), (72, 76)], fill=(240, 245, 255, 255)) # White collar
    
    # Silver brooch / Keystone ring
    d.ellipse([60, 84, 68, 92], fill=(200, 215, 230, 255), outline=(255, 60, 90, 255), width=2)
    d.point([(64, 88)], fill=(255, 255, 255, 255))
    
    # Neck
    d.rectangle([56, 66, 72, 78], fill=(250, 222, 205, 255))
    
    # Face (Chiseled)
    d.polygon([(46, 40), (82, 40), (76, 74), (64, 78), (52, 74)], fill=(250, 225, 210, 255))
    
    # Elegant Silver-Cyan Layered Hair
    # Back wings of hair
    d.polygon([(26, 26), (48, 38), (34, 56)], fill=(160, 200, 215, 255))
    d.polygon([(102, 26), (80, 38), (94, 56)], fill=(160, 200, 215, 255))
    d.polygon([(22, 46), (42, 50), (32, 70)], fill=(140, 180, 195, 255))
    d.polygon([(106, 46), (86, 50), (96, 70)], fill=(140, 180, 195, 255))
    
    # Top hair crown
    d.polygon([(40, 16), (64, 28), (88, 16), (78, 38), (50, 38)], fill=(185, 220, 235, 255))
    # Bangs over forehead
    d.polygon([(44, 34), (54, 52), (58, 36)], fill=(200, 230, 245, 255))
    d.polygon([(56, 34), (66, 50), (70, 36)], fill=(215, 240, 255, 255))
    d.polygon([(68, 34), (78, 48), (82, 36)], fill=(185, 220, 235, 255))
    
    # Calm sharp cyan eyes
    d.line([(48, 51), (58, 51)], fill=(40, 60, 80, 255), width=2)
    d.line([(70, 51), (80, 51)], fill=(40, 60, 80, 255), width=2)
    d.ellipse([(50, 53), (56, 58)], fill=(60, 150, 180, 255))
    d.ellipse([(72, 53), (78, 58)], fill=(60, 150, 180, 255))
    
    # Subtle composed smile
    d.line([(60, 68), (68, 68)], fill=(180, 130, 120, 255), width=2)

# 4. CYNTHIA (竹兰): Flowing blonde hair, black coat with black fur neck, golden teardrop hairpins
def draw_cynthia(d: ImageDraw.ImageDraw, s: int):
    # Noble midnight purple background
    d.ellipse([10, 10, s-11, s-11], fill=(50, 35, 65, 255))
    
    # Voluminous Blonde Hair (Back)
    d.ellipse([20, 18, 108, 90], fill=(245, 215, 110, 255))
    
    # Black Fur Collar & Long Coat
    d.ellipse([34, 72, 94, 106], fill=(25, 25, 30, 255)) # Fur collar
    d.polygon([(20, s), (40, 86), (88, 86), (108, s)], fill=(35, 35, 42, 255)) # Coat
    
    # Neck & Jaw
    d.rectangle([58, 66, 70, 78], fill=(255, 226, 208, 255))
    d.polygon([(46, 42), (82, 42), (76, 74), (64, 78), (52, 74)], fill=(255, 226, 208, 255))
    
    # Front long bangs covering left side of face
    d.polygon([(36, 22), (64, 20), (52, 58), (34, 46)], fill=(255, 225, 125, 255))
    d.polygon([(48, 26), (62, 58), (56, 68), (44, 48)], fill=(255, 230, 140, 255))
    d.polygon([(64, 22), (88, 26), (86, 60), (74, 46)], fill=(245, 215, 110, 255))
    
    # Black teardrop hair ornament with gold stripes
    d.ellipse([24, 42, 34, 62], fill=(25, 25, 30, 255), outline=(230, 190, 40, 255), width=2)
    d.ellipse([94, 42, 104, 62], fill=(25, 25, 30, 255), outline=(230, 190, 40, 255), width=2)
    
    # Right eye visible (Graceful, confident grey-blue)
    d.line([(68, 50), (80, 49)], fill=(40, 40, 50, 255), width=2)
    d.ellipse([(70, 52), (78, 58)], fill=(100, 135, 160, 255))
    d.point([(74, 54)], fill=(255, 255, 255, 255))
    
    # Gentle enigmatic smile
    d.line([(60, 68), (68, 68)], fill=(200, 130, 120, 255), width=2)

# 5. GIOVANNI (坂木): Slicked-back black hair, charcoal mafia suit, bold Team Rocket 'R' emblem
def draw_giovanni(d: ImageDraw.ImageDraw, s: int):
    # Dark shadow mafia background
    d.ellipse([10, 10, s-11, s-11], fill=(30, 32, 40, 255))
    
    # Dark Charcoal / Pinstripe suit
    d.polygon([(20, s), (38, 76), (90, 76), (108, s)], fill=(45, 48, 56, 255))
    # Red turtleneck / tie area
    d.polygon([(52, 74), (64, 88), (76, 74)], fill=(180, 25, 35, 255))
    
    # Iconic Red Team Rocket "R" on right chest
    d.polygon([(36, 88), (42, 88), (42, 108), (36, 108)], fill=(225, 25, 35, 255))
    d.polygon([(42, 88), (50, 88), (50, 98), (42, 98)], fill=(225, 25, 35, 255))
    d.polygon([(42, 98), (50, 108), (44, 108)], fill=(225, 25, 35, 255))
    
    # Neck & Strong chin
    d.rectangle([54, 66, 74, 76], fill=(240, 205, 185, 255))
    d.polygon([(46, 38), (82, 38), (80, 68), (64, 74), (48, 68)], fill=(240, 205, 185, 255))
    
    # Slicked back black hair with subtle grey temples
    d.ellipse([42, 18, 86, 42], fill=(25, 25, 30, 255))
    d.polygon([(42, 30), (48, 48), (44, 56)], fill=(45, 45, 52, 255))
    d.polygon([(86, 30), (80, 48), (84, 56)], fill=(45, 45, 52, 255))
    
    # Menacing furrowed brow & sharp eyes
    d.line([(48, 48), (58, 52)], fill=(30, 30, 30, 255), width=2)
    d.line([(70, 52), (80, 48)], fill=(30, 30, 30, 255), width=2)
    d.ellipse([(50, 53), (56, 57)], fill=(20, 20, 25, 255))
    d.ellipse([(72, 53), (78, 57)], fill=(20, 20, 25, 255))
    
    # Cold stoic mouth
    d.line([(58, 66), (70, 66)], fill=(160, 100, 90, 255), width=2)

create_circular_avatar(draw_red, "red.png", (220, 35, 35, 255), (180, 25, 25, 255))
create_circular_avatar(draw_misty, "misty.png", (30, 160, 240, 255), (20, 110, 190, 255))
create_circular_avatar(draw_steven, "steven.png", (160, 195, 215, 255), (60, 80, 100, 255))
create_circular_avatar(draw_cynthia, "cynthia.png", (245, 200, 40, 255), (60, 40, 80, 255))
create_circular_avatar(draw_giovanni, "giovanni.png", (200, 30, 40, 255), (35, 35, 45, 255))
print("All 5 Trainer Avatars successfully generated!")
