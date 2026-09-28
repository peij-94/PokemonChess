#!/usr/bin/env python3
import os
import glob
import shutil
from PIL import Image

FRAME_DIR = "showcase_frames"
ARTIFACT_DIR = "/Users/peij94/.gemini/antigravity/brain/637df6f0-a3ed-48a7-978f-991a27f006c6"

def main():
    print("Searching for captured frames in:", FRAME_DIR)
    frame_files = sorted(glob.glob(os.path.join(FRAME_DIR, "frame*.png")))
    total_frames = len(frame_files)
    print(f"Found {total_frames} frames.")
    
    if total_frames == 0:
        print("Error: No frames found!")
        return 1
        
    print(f"Loading and processing {total_frames} frames...")
    
    # 1. Prepare frames for Animated WebP (960x540 - crisp high resolution)
    webp_frames = []
    # 2. Prepare frames for Animated GIF (640x360 - lightweight universal)
    gif_frames = []
    
    # Target 10 FPS -> 100ms per frame
    fps = 10
    duration_ms = int(1000 / fps)
    
    for idx, fpath in enumerate(frame_files):
        if idx % 30 == 0 or idx == total_frames - 1:
            print(f"  Processing frame {idx+1}/{total_frames} ({((idx+1)/total_frames)*100:.1f}%)...")
            
        with Image.open(fpath) as im:
            # WebP frame (960x540)
            im_rgb = im.convert("RGB")
            webp_img = im_rgb.resize((960, 540), Image.Resampling.BILINEAR)
            webp_frames.append(webp_img)
            
            # GIF frame (640x360 quantized)
            gif_img = im_rgb.resize((640, 360), Image.Resampling.BILINEAR)
            # Quantize with fast octree or adaptive palette
            gif_frames.append(gif_img.convert("P", palette=Image.Palette.ADAPTIVE, colors=128))
            
    # Ensure exports dir with .gdignore exists so Godot never imports media files
    os.makedirs("exports", exist_ok=True)
    open("exports/.gdignore", "w").close()

    # Save Animated WebP
    webp_out = os.path.join("exports", "gameplay_showcase.webp")
    print(f"\nEncoding Animated WebP video: {webp_out}...")
    webp_frames[0].save(
        webp_out,
        format="WEBP",
        save_all=True,
        append_images=webp_frames[1:],
        duration=duration_ms,
        loop=0,
        quality=80,
        method=4
    )
    webp_size = os.path.getsize(webp_out) / (1024 * 1024)
    print(f"  [SUCCESS] {webp_out} created! Size: {webp_size:.2f} MB")
    
    # Save Animated GIF
    gif_out = os.path.join("exports", "gameplay_showcase.gif")
    print(f"\nEncoding Animated GIF: {gif_out}...")
    gif_frames[0].save(
        gif_out,
        format="GIF",
        save_all=True,
        append_images=gif_frames[1:],
        duration=duration_ms,
        loop=0,
        optimize=True
    )
    gif_size = os.path.getsize(gif_out) / (1024 * 1024)
    print(f"  [SUCCESS] {gif_out} created! Size: {gif_size:.2f} MB")
    
    # Copy to artifact directory
    if os.path.exists(ARTIFACT_DIR):
        print(f"\nCopying showcase artifacts to {ARTIFACT_DIR}...")
        shutil.copy(webp_out, os.path.join(ARTIFACT_DIR, "gameplay_showcase.webp"))
        shutil.copy(gif_out, os.path.join(ARTIFACT_DIR, "gameplay_showcase.gif"))
        print("  [SUCCESS] Copied showcase artifacts to brain folder.")
        
    print("\n========================================================")
    print(">>> SHOWCASE VIDEO PRODUCTION COMPLETED SUCCESSFULLY! <<<")
    print("========================================================")
    return 0

if __name__ == "__main__":
    exit(main())
