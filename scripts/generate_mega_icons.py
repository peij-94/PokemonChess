import os
from PIL import Image, ImageDraw

OUTPUT_DIR = "assets/items"
os.makedirs(OUTPUT_DIR, exist_ok=True)

def create_mega_bracelet():
    img = Image.new("RGBA", (32, 32), (0, 0, 0, 0))
    d = ImageDraw.Draw(img)
    # Silver metallic bracelet ring
    d.ellipse([4, 6, 27, 25], outline=(180, 190, 205, 255), width=3)
    d.ellipse([6, 8, 25, 23], outline=(230, 240, 255, 255), width=1)
    # Center Key Stone setting (Gold mount)
    d.rectangle([11, 10, 20, 21], fill=(215, 175, 55, 255), outline=(130, 95, 20, 255))
    # Rainbow swirl Key Stone
    d.ellipse([12, 11, 19, 20], fill=(255, 255, 255, 255))
    d.arc([13, 12, 18, 19], start=0, end=180, fill=(255, 60, 60, 255), width=2)
    d.arc([13, 12, 18, 19], start=180, end=360, fill=(60, 160, 255, 255), width=2)
    d.point([(15, 14), (16, 17)], fill=(255, 220, 40, 255))
    img.save(os.path.join(OUTPUT_DIR, "mega_bracelet.png"))

def create_dynamax_band():
    img = Image.new("RGBA", (32, 32), (0, 0, 0, 0))
    d = ImageDraw.Draw(img)
    # Dark crimson and white Galar wristband
    d.rounded_rectangle([3, 7, 28, 24], radius=4, fill=(40, 45, 55, 255), outline=(220, 40, 70, 255), width=2)
    # White ring band
    d.rectangle([9, 7, 22, 24], fill=(240, 245, 255, 255), outline=(180, 40, 60, 255))
    # Glowing Wishing Star / Dynamax symbol (Glowing red cross/diamond)
    d.polygon([(15, 9), (18, 14), (21, 9), (18, 22)], fill=(255, 30, 70, 255))
    d.polygon([(11, 13), (16, 16), (11, 19), (23, 16)], fill=(255, 60, 100, 255))
    d.ellipse([14, 13, 17, 18], fill=(255, 240, 245, 255))
    img.save(os.path.join(OUTPUT_DIR, "dynamax_band.png"))

def create_mega_stone(filename, rim_col, inner_a, inner_b, core_col):
    img = Image.new("RGBA", (32, 32), (0, 0, 0, 0))
    d = ImageDraw.Draw(img)
    # Glass sphere outer gradient
    d.ellipse([4, 4, 27, 27], fill=rim_col, outline=(240, 245, 255, 200), width=2)
    d.ellipse([6, 6, 25, 25], fill=inner_a)
    # DNA spiral / helix inside
    d.arc([8, 8, 23, 23], start=30, end=210, fill=inner_b, width=3)
    d.arc([8, 8, 23, 23], start=210, end=390, fill=core_col, width=3)
    # Highlight gleam
    d.ellipse([8, 7, 12, 11], fill=(255, 255, 255, 220))
    img.save(os.path.join(OUTPUT_DIR, filename))

create_mega_bracelet()
create_dynamax_band()
create_mega_stone("charizardite.png", (180, 50, 20, 255), (240, 100, 30, 255), (40, 130, 240, 255), (255, 220, 50, 255))
create_mega_stone("blastoisinite.png", (20, 70, 180, 255), (40, 140, 250, 255), (100, 220, 255, 255), (220, 240, 255, 255))
create_mega_stone("venusaurite.png", (30, 140, 60, 255), (60, 190, 80, 255), (230, 80, 140, 255), (255, 240, 120, 255))
create_mega_stone("gengarite.png", (80, 30, 140, 255), (140, 50, 220, 255), (240, 60, 100, 255), (255, 255, 255, 255))
create_mega_stone("mewtwonite.png", (140, 30, 100, 255), (210, 60, 170, 255), (120, 240, 255, 255), (255, 240, 255, 255))
print("All Mega and Dynamax icons successfully generated!")
