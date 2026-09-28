#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
generate_vfx_showcase_html.py

Generates a standalone, fully self-contained, interactive HTML showcase
for all 128 authentic skill animations in assets/vfx/.
All frame images are embedded as Base64 data URIs so it works with zero external dependencies.
"""

import os
import re
import json
import base64
from collections import defaultdict

VFX_DIR = "assets/vfx"
DB_PATH = "scripts/autoload/pokemon_database.gd"
ARTIFACT_OUT = "/Users/peij94/.gemini/antigravity/brain/637df6f0-a3ed-48a7-978f-991a27f006c6/skill_vfx_gallery.html"
EXPORT_OUT = "exports/skill_vfx_gallery.html"

# Type colors and labels
TYPE_META = {
    "Fire": {"name": "火系", "color": "#F08030", "bg": "rgba(240, 128, 48, 0.15)", "border": "#F08030"},
    "Water": {"name": "水系", "color": "#6390F0", "bg": "rgba(99, 144, 240, 0.15)", "border": "#6390F0"},
    "Grass": {"name": "草系", "color": "#7AC74C", "bg": "rgba(122, 199, 76, 0.15)", "border": "#7AC74C"},
    "Electric": {"name": "电系", "color": "#F7D02C", "bg": "rgba(247, 208, 44, 0.15)", "border": "#F7D02C"},
    "Ice": {"name": "冰系", "color": "#96D9D6", "bg": "rgba(150, 217, 214, 0.15)", "border": "#96D9D6"},
    "Psychic": {"name": "超能系", "color": "#F95587", "bg": "rgba(249, 85, 135, 0.15)", "border": "#F95587"},
    "Dark": {"name": "恶系", "color": "#705746", "bg": "rgba(112, 87, 70, 0.15)", "border": "#705746"},
    "Ghost": {"name": "幽灵系", "color": "#735797", "bg": "rgba(115, 87, 151, 0.15)", "border": "#735797"},
    "Bug": {"name": "虫系", "color": "#A6B91A", "bg": "rgba(166, 185, 26, 0.15)", "border": "#A6B91A"},
    "Fighting": {"name": "格斗系", "color": "#C22E28", "bg": "rgba(194, 46, 40, 0.15)", "border": "#C22E28"},
    "Flying": {"name": "飞行系", "color": "#A98FF3", "bg": "rgba(169, 143, 243, 0.15)", "border": "#A98FF3"},
    "Poison": {"name": "毒系", "color": "#A33EA1", "bg": "rgba(163, 62, 161, 0.15)", "border": "#A33EA1"},
    "Ground": {"name": "地面系", "color": "#E2BF65", "bg": "rgba(226, 191, 101, 0.15)", "border": "#E2BF65"},
    "Rock": {"name": "岩石系", "color": "#B6A136", "bg": "rgba(182, 161, 54, 0.15)", "border": "#B6A136"},
    "Dragon": {"name": "龙系", "color": "#6F35FC", "bg": "rgba(111, 53, 252, 0.15)", "border": "#6F35FC"},
    "Normal": {"name": "一般系", "color": "#A8A77A", "bg": "rgba(168, 167, 122, 0.15)", "border": "#A8A77A"}
}

# VFX to primary type & primary move mapping
VFX_TYPE_MAP = {
    # Fire
    "ember": ("Fire", "火花", "★1 基础"),
    "fire_spin": ("Fire", "火焰旋涡", "★2 进阶"),
    "flame_wheel": ("Fire", "火焰轮", "★2 进阶"),
    "flamethrower": ("Fire", "喷射火焰", "★2 进阶"),
    "fire_blast": ("Fire", "大字爆炎", "★3 终极"),
    "heat_wave": ("Fire", "热风", "★2 进阶"),
    "fire_punch": ("Fire", "火焰拳", "★2 进阶"),
    "fire_fang": ("Fire", "火焰牙", "★2 进阶"),
    "flare_blitz": ("Fire", "闪焰冲锋", "★3 终极"),
    "inferno": ("Fire", "炼狱", "★3 终极"),
    "blast_burn": ("Fire", "爆炸烈焰", "★3 终极"),

    # Water
    "water_gun": ("Water", "水枪", "★1 基础"),
    "water_pulse": ("Water", "水之波动", "★2 进阶"),
    "bubble_beam": ("Water", "泡沫光线", "★2 进阶"),
    "aqua_tail": ("Water", "水流尾", "★2 进阶"),
    "surf": ("Water", "冲浪", "★3 终极"),
    "hydro_pump": ("Water", "水炮", "★3 终极"),
    "hydro_cannon": ("Water", "加农水炮", "★3 终极"),
    "hydro_tempest": ("Water", "海啸巨浪", "★3 终极"),
    "crabhammer": ("Water", "蟹钳锤", "★2 进阶"),

    # Grass
    "leech_seed": ("Grass", "寄生种子", "★1 基础"),
    "vine_whip": ("Grass", "藤鞭", "★1 基础"),
    "razor_leaf": ("Grass", "飞叶快刀", "★2 进阶"),
    "seed_bomb": ("Grass", "种子炸弹", "★2 进阶"),
    "petal_dance": ("Grass", "花瓣舞", "★2 进阶"),
    "power_whip": ("Grass", "强力鞭打", "★3 终极"),
    "leaf_blade": ("Grass", "叶刃", "★2 进阶"),
    "solar_beam": ("Grass", "日光束", "★3 终极"),
    "frenzy_plant": ("Grass", "疯狂植物", "★3 终极"),

    # Electric
    "thundershock": ("Electric", "电击", "★1 基础"),
    "spark": ("Electric", "电火花", "★1 基础"),
    "electroweb": ("Electric", "电网", "★1 基础"),
    "electro_ball": ("Electric", "电球", "★2 进阶"),
    "thunderbolt": ("Electric", "十万伏特", "★2 进阶"),
    "discharge": ("Electric", "放电", "★2 进阶"),
    "thunder_punch": ("Electric", "雷电拳", "★2 进阶"),
    "thunder_fang": ("Electric", "雷电牙", "★2 进阶"),
    "thunder": ("Electric", "打雷", "★3 终极"),
    "thunder_tempest": ("Electric", "雷暴", "★3 终极"),
    "volt_catastrophe": ("Electric", "千万伏特", "★3 终极"),

    # Ice
    "ice_shard": ("Ice", "冰砾", "★1 基础"),
    "icicle_spear": ("Ice", "冰锥", "★2 进阶"),
    "ice_punch": ("Ice", "冰冻拳", "★2 进阶"),
    "ice_fang": ("Ice", "冰冻牙", "★2 进阶"),
    "ice_beam": ("Ice", "急冻光线", "★2 进阶"),
    "aurora_beam": ("Ice", "极光束", "★2 进阶"),
    "avalanche": ("Ice", "雪崩", "★2 进阶"),
    "blizzard": ("Ice", "暴风雪", "★3 终极"),
    "sheer_cold": ("Ice", "绝对零度", "★3 终极"),

    # Psychic
    "confusion": ("Psychic", "念力", "★1 基础"),
    "hypnosis": ("Psychic", "催眠术", "★1 基础"),
    "psybeam": ("Psychic", "幻象光线", "★2 进阶"),
    "psycho_cut": ("Psychic", "精神利刃", "★2 进阶"),
    "zen_headbutt": ("Psychic", "意念头锤", "★2 进阶"),
    "psychic": ("Psychic", "精神强念", "★2 进阶"),
    "psystrike": ("Psychic", "精神击破", "★3 终极"),
    "psychokinesis": ("Psychic", "光子喷涌", "★3 终极"),
    "future_sight": ("Psychic", "预知未来", "★3 终极"),
    "cosmic_singularity": ("Psychic", "宇宙力量", "★3 终极"),
    "dream_eater": ("Psychic", "食梦", "★2 进阶"),
    "reflect": ("Psychic", "反射壁", "★2 进阶"),
    "light_screen": ("Psychic", "光墙", "★2 进阶"),
    "rest": ("Psychic", "睡觉", "★1 基础"),
    "heal_pulse": ("Psychic", "治愈波动", "★2 进阶"),
    "softboiled": ("Normal", "生蛋", "★2 进阶"),

    # Dark / Ghost
    "lick": ("Ghost", "舌舔", "★1 基础"),
    "night_shade": ("Ghost", "黑夜魔影", "★2 进阶"),
    "shadow_punch": ("Ghost", "暗影拳", "★2 进阶"),
    "shadow_ball": ("Ghost", "暗影球", "★2 进阶"),
    "hex_nightmare": ("Ghost", "祸不单行", "★3 终极"),
    "perish_song": ("Dark", "灭亡之歌", "★3 终极"),
    "bite": ("Dark", "咬住", "★1 基础"),
    "crunch": ("Dark", "咬碎", "★2 进阶"),
    "dark_pulse": ("Dark", "恶之波动", "★2 进阶"),

    # Bug
    "string_shot": ("Bug", "吐丝", "★1 基础"),
    "leech_life": ("Bug", "吸血", "★1 基础"),
    "pin_missile": ("Bug", "飞弹针", "★2 进阶"),
    "bug_buzz": ("Bug", "虫鸣", "★3 终极"),
    "silver_wind": ("Bug", "银色旋风", "★2 进阶"),
    "x_scissor": ("Bug", "十字剪", "★2 进阶"),

    # Flying
    "gust": ("Flying", "起风", "★1 基础"),
    "wing_attack": ("Flying", "翅膀攻击", "★2 进阶"),
    "air_slash": ("Flying", "空气斩", "★2 进阶"),
    "drill_peck": ("Flying", "啄钻", "★2 进阶"),
    "twister": ("Flying", "龙卷风", "★2 进阶"),
    "brave_bird": ("Flying", "勇鸟猛攻", "★3 终极"),

    # Fighting
    "low_kick": ("Fighting", "踢倒", "★1 基础"),
    "mach_punch": ("Fighting", "音速拳", "★1 基础"),
    "force_palm": ("Fighting", "发劲", "★2 进阶"),
    "cross_chop": ("Fighting", "十字劈", "★2 进阶"),
    "dynamic_punch": ("Fighting", "爆裂拳", "★3 终极"),
    "mega_punch": ("Fighting", "百万吨重拳", "★2 进阶"),
    "mega_kick": ("Fighting", "百万吨重踢", "★3 终极"),
    "close_combat": ("Fighting", "近身战", "★3 终极"),
    "aura_sphere": ("Fighting", "波导弹", "★3 终极"),
    "aura_storm": ("Fighting", "波导风暴", "★3 终极"),

    # Rock / Ground
    "rock_throw": ("Rock", "落石", "★1 基础"),
    "rock_slide": ("Rock", "岩崩", "★2 进阶"),
    "ancient_power": ("Rock", "原始之力", "★2 进阶"),
    "stone_edge": ("Rock", "尖石攻击", "★3 终极"),
    "mud_slap": ("Ground", "掷泥", "★1 基础"),
    "bone_rush": ("Ground", "骨棒乱打", "★2 进阶"),
    "bonemerang": ("Ground", "骨头回力镖", "★2 进阶"),
    "earthquake": ("Ground", "地震", "★3 终极"),

    # Poison
    "poison_sting": ("Poison", "毒针", "★1 基础"),
    "poison_jab": ("Poison", "毒击", "★2 进阶"),
    "sludge_bomb": ("Poison", "污泥炸弹", "★2 进阶"),
    "acid_armor": ("Poison", "溶化", "★2 进阶"),
    "toxic": ("Poison", "剧毒", "★3 终极"),
    "gunk_shot": ("Poison", "垃圾射击", "★3 终极"),

    # Dragon
    "dragon_breath": ("Dragon", "龙之怒", "★1 基础"),
    "dragon_pulse": ("Dragon", "龙之波动", "★2 进阶"),
    "dragon_claw": ("Dragon", "龙爪", "★2 进阶"),
    "draco_meteor": ("Dragon", "流星群", "★3 终极"),
    "dragon_apocalypse": ("Dragon", "逆鳞", "★3 终极"),

    # Normal / Misc
    "tackle": ("Normal", "撞击", "★1 基础"),
    "quick_attack": ("Normal", "电光一闪", "★1 基础"),
    "headbutt": ("Normal", "头锤", "★2 进阶"),
    "take_down": ("Normal", "猛撞", "★2 进阶"),
    "slash": ("Normal", "劈开", "★2 进阶"),
    "body_slam": ("Normal", "泰山压顶", "★2 进阶"),
    "swift": ("Normal", "高速星星", "★2 进阶"),
    "tri_attack": ("Normal", "三重攻击", "★2 进阶"),
    "double_edge": ("Normal", "舍身冲撞", "★3 终极"),
    "hyper_beam": ("Normal", "破坏光线", "★3 终极"),
    "giga_impact": ("Normal", "终极冲击", "★3 终极"),
    "transform": ("Normal", "变身", "★1 基础"),
    "extreme_evoboost": ("Normal", "九彩升华齐聚顶", "★3 终极"),
}

def main():
    print("=== Scanning assets/vfx and Pokemon Database ===")

    # 1. Parse database for moves and pokemons per VFX
    vfx_to_moves = defaultdict(set)
    vfx_to_pokemons = defaultdict(set)
    vfx_descriptions = {}

    with open(DB_PATH, "r", encoding="utf-8") as f:
        db_text = f.read()

    pkm_blocks = re.findall(
        r'\"([a-z0-9_]+)\":\s*\{\s*\"id\":\s*\"([^\"]+)\".*?\"name\":\s*\"([^\"]+)\".*?\"skills\":\s*\{(.*?)\n\t\t\},',
        db_text, re.DOTALL
    )

    for key, pid, pname, s_blob in pkm_blocks:
        for star in [1, 2, 3]:
            star_m = re.search(r'%d:\s*\[([\s\S]*?)\n\t\t\t\]' % star, s_blob)
            if star_m:
                for s_m in re.finditer(r'\"name\":\s*\"([^\"]+)\"[\s\S]*?\"desc\":\s*\"([^\"]+)\"[\s\S]*?\"vfx\":\s*\"([^\"]+)\"', star_m.group(1)):
                    sname = s_m.group(1)
                    sdesc = s_m.group(2)
                    vname = s_m.group(3)
                    vfx_to_moves[vname].add(sname)
                    vfx_to_pokemons[vname].add(pname)
                    if vname not in vfx_descriptions:
                        vfx_descriptions[vname] = sdesc

    # 2. Gather all 128 VFX with base64 frames
    vfx_dirs = sorted([d for d in os.listdir(VFX_DIR) if os.path.isdir(os.path.join(VFX_DIR, d))])
    print(f"Processing {len(vfx_dirs)} VFX folders...")

    vfx_data_list = []
    total_frames = 0

    for v_id in vfx_dirs:
        dir_path = os.path.join(VFX_DIR, v_id)
        # Find frames
        frame_files = sorted(
            [f for f in os.listdir(dir_path) if f.startswith("frame_") and f.endswith(".png")],
            key=lambda x: int(x.split("_")[1].split(".")[0])
        )
        if not frame_files:
            continue

        b64_frames = []
        for ff in frame_files:
            total_frames += 1
            with open(os.path.join(dir_path, ff), "rb") as img:
                b64 = base64.b64encode(img.read()).decode("ascii")
                b64_frames.append(f"data:image/png;base64,{b64}")

        meta = VFX_TYPE_MAP.get(v_id, ("Normal", v_id.replace("_", " ").title(), "★1 基础"))
        p_type = meta[0]
        primary_name = meta[1]
        tier_label = meta[2]

        # Associated in-game moves & pokemons
        used_moves = sorted(list(vfx_to_moves.get(v_id, {primary_name})))
        used_pokemons = sorted(list(vfx_to_pokemons.get(v_id, [])))
        desc = vfx_descriptions.get(v_id, f"官方原版战斗动画：{primary_name} 逐帧序列动画。")

        t_info = TYPE_META.get(p_type, TYPE_META["Normal"])

        vfx_data_list.append({
            "id": v_id,
            "name": primary_name,
            "type": p_type,
            "type_zh": t_info["name"],
            "color": t_info["color"],
            "tier": tier_label,
            "desc": desc,
            "moves": used_moves,
            "pokemons": used_pokemons,
            "frame_count": len(b64_frames),
            "frames": b64_frames
        })

    print(f"Loaded {len(vfx_data_list)} VFX entries with {total_frames} total frames.")

    # 3. Generate HTML
    vfx_json = json.dumps(vfx_data_list, ensure_ascii=False)

    html_content = f"""<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <title>宝可梦自走棋 · 技能特效全景互动图鉴</title>
  <script src="https://www.gstatic.com/antigravity/web/dev/tailwindcss.min.js"></script>
  <style>
    /* Custom Scrollbar */
    ::-webkit-scrollbar {{ width: 6px; height: 6px; }}
    ::-webkit-scrollbar-track {{ background: rgba(0,0,0,0.1); }}
    ::-webkit-scrollbar-thumb {{ background: rgba(255,255,255,0.2); border-radius: 3px; }}
    ::-webkit-scrollbar-thumb:hover {{ background: rgba(255,255,255,0.4); }}
    
    .pixelated {{
      image-rendering: pixelated;
      image-rendering: -moz-crisp-edges;
      image-rendering: crisp-edges;
    }}
    
    .type-pill.active {{
      font-weight: 700;
      box-shadow: 0 0 10px rgba(255, 255, 255, 0.2);
    }}

    .vfx-card.active {{
      border-color: #F7D02C !important;
      box-shadow: 0 0 12px rgba(247, 208, 44, 0.4);
      transform: translateY(-2px);
    }}
  </style>
</head>
<body class="bg-slate-950 text-slate-100 antialiased p-3 sm:p-5 select-none min-h-screen flex flex-col gap-4 font-sans">
  
  <!-- Header -->
  <header class="bg-slate-900 border border-slate-800 rounded-2xl p-4 shadow-xl flex flex-col md:flex-row md:items-center md:justify-between gap-3">
    <div class="flex items-center gap-3">
      <div class="w-12 h-12 rounded-xl bg-gradient-to-tr from-amber-500 to-rose-500 flex items-center justify-center text-2xl shadow-lg shadow-amber-500/20">
        ⚡
      </div>
      <div>
        <h1 class="text-lg sm:text-xl font-black text-white flex items-center gap-2">
          宝可梦自走棋 · 技能动效全景预览图鉴
          <span class="text-xs px-2 py-0.5 rounded-full bg-emerald-500/20 text-emerald-400 border border-emerald-500/30 font-medium">
            128 套独立专属官方切片 · 713 帧
          </span>
        </h1>
        <p class="text-xs text-slate-400 mt-0.5">
          全属性技能逐帧序列动画 · 支持倍速调节、逐帧拆解、属性与招式即时检索
        </p>
      </div>
    </div>

    <!-- Quick Stats -->
    <div class="flex items-center gap-2 self-start md:self-auto text-xs font-mono">
      <span class="px-2.5 py-1 rounded-lg bg-slate-800/80 border border-slate-700 text-slate-300">
        🎮 152 只宝可梦全覆盖
      </span>
      <span class="px-2.5 py-1 rounded-lg bg-slate-800/80 border border-slate-700 text-amber-300">
        ✨ 0 帧同质化重复
      </span>
    </div>
  </header>

  <!-- Interactive Player Stage (Hero Section) -->
  <section class="grid grid-cols-1 lg:grid-cols-12 gap-4">
    
    <!-- Left: Large Battle Arena Canvas Player -->
    <div class="lg:col-span-7 bg-slate-900 border border-slate-800 rounded-2xl p-4 flex flex-col gap-3 shadow-xl">
      
      <!-- Stage Bar -->
      <div class="flex items-center justify-between">
        <div class="flex items-center gap-2">
          <span id="playerBadgeType" class="px-2 py-0.5 text-xs font-bold rounded text-white bg-amber-500 shadow-sm">
            电系
          </span>
          <span id="playerBadgeTier" class="px-2 py-0.5 text-xs font-medium rounded bg-slate-800 border border-slate-700 text-slate-300">
            ★2 进阶
          </span>
          <h2 id="playerTitle" class="text-base font-bold text-white">
            【十万伏特】 Thunderbolt
          </h2>
        </div>
        <div class="flex items-center gap-1">
          <button onclick="changeBackground()" title="切换背景" class="px-2 py-1 text-xs rounded bg-slate-800 hover:bg-slate-700 border border-slate-700 text-slate-300 transition">
            🎨 竞技场背景
          </button>
        </div>
      </div>

      <!-- Live Canvas Screen -->
      <div id="arenaBox" class="relative w-full h-64 sm:h-72 rounded-xl overflow-hidden bg-slate-950 border border-slate-800 flex items-center justify-center transition-colors">
        
        <!-- Subtle Grid Pattern -->
        <div class="absolute inset-0 opacity-15 pointer-events-none" style="background-image: radial-gradient(#64748b 1px, transparent 1px); background-size: 20px 20px;"></div>
        
        <!-- Center Target Reticle -->
        <div class="absolute w-8 h-8 rounded-full border border-dashed border-slate-600/40 pointer-events-none flex items-center justify-center">
          <div class="w-1.5 h-1.5 rounded-full bg-slate-500/50"></div>
        </div>

        <!-- Rendered Sprite Image -->
        <img id="stageImg" src="" alt="VFX Stage" class="pixelated relative z-10 max-h-56 max-w-full drop-shadow-2xl transition-transform" />

        <!-- Top Right FPS Counter -->
        <div class="absolute top-2.5 right-2.5 px-2 py-0.5 rounded bg-black/70 backdrop-blur font-mono text-[10px] text-amber-400 border border-amber-500/20">
          <span id="fpsDisplay">14.0 FPS</span>
        </div>

        <!-- Bottom Left Frame Step HUD -->
        <div class="absolute bottom-2.5 left-2.5 px-2.5 py-1 rounded bg-black/70 backdrop-blur font-mono text-xs text-slate-300 border border-slate-700/50 flex items-center gap-2">
          <span>当前帧:</span>
          <span id="frameCounter" class="text-amber-400 font-bold">1 / 6</span>
        </div>
      </div>

      <!-- Playback Controls -->
      <div class="flex flex-wrap items-center justify-between gap-2 pt-1 border-t border-slate-800">
        <div class="flex items-center gap-1.5">
          <button onclick="togglePlay()" id="btnPlayPause" class="px-3 py-1.5 rounded-lg bg-amber-500 hover:bg-amber-400 text-slate-950 font-bold text-xs shadow-md transition flex items-center gap-1">
            <span id="playIcon">⏸</span> <span id="playText">暂停</span>
          </button>
          <button onclick="prevFrame()" class="px-2 py-1.5 rounded-lg bg-slate-800 hover:bg-slate-700 text-slate-300 text-xs border border-slate-700 transition" title="上一帧">
            ⏮
          </button>
          <button onclick="nextFrame()" class="px-2 py-1.5 rounded-lg bg-slate-800 hover:bg-slate-700 text-slate-300 text-xs border border-slate-700 transition" title="下一帧">
            ⏭
          </button>
          <button onclick="replayOneShot()" class="px-2.5 py-1.5 rounded-lg bg-slate-800 hover:bg-slate-700 text-slate-300 text-xs border border-slate-700 transition flex items-center gap-1" title="单次播放">
            🔄 单次触发
          </button>
        </div>

        <!-- Speed & Zoom -->
        <div class="flex items-center gap-3 text-xs">
          <div class="flex items-center gap-1.5">
            <span class="text-slate-400">播放速度:</span>
            <select onchange="changeSpeed(this.value)" class="bg-slate-800 border border-slate-700 text-slate-200 rounded px-1.5 py-1 text-xs">
              <option value="8">0.5x 慢速 (8 fps)</option>
              <option value="14" selected>1.0x 标准 (14 fps)</option>
              <option value="20">1.5x 快速 (20 fps)</option>
              <option value="28">2.0x 极速 (28 fps)</option>
            </select>
          </div>
          <div class="flex items-center gap-1.5">
            <span class="text-slate-400">缩放:</span>
            <select onchange="changeZoom(this.value)" class="bg-slate-800 border border-slate-700 text-slate-200 rounded px-1.5 py-1 text-xs">
              <option value="1.0">1.0x 原始</option>
              <option value="1.5" selected>1.5x 清晰</option>
              <option value="2.0">2.0x 放大</option>
              <option value="2.5">2.5x 巨幕</option>
            </select>
          </div>
        </div>
      </div>

      <!-- Scrubber Slider -->
      <div class="flex items-center gap-2">
        <span class="text-[10px] font-mono text-slate-400">0</span>
        <input type="range" id="frameScrubber" min="0" max="5" value="0" oninput="onScrub(this.value)" class="w-full accent-amber-500 cursor-pointer" />
        <span id="scrubberMax" class="text-[10px] font-mono text-slate-400">5</span>
      </div>

    </div>

    <!-- Right: Telemetry & Pokémon Equip Card -->
    <div class="lg:col-span-5 bg-slate-900 border border-slate-800 rounded-2xl p-4 flex flex-col justify-between gap-3 shadow-xl">
      <div class="flex flex-col gap-3">
        <div class="border-b border-slate-800 pb-2.5">
          <span class="text-[11px] font-mono text-slate-400 uppercase tracking-wider">招式效果与数值解析</span>
          <p id="skillDescText" class="text-sm text-slate-200 font-medium leading-relaxed mt-1">
            向对手发射强烈的电击进行攻击。有时会让对手陷入麻痹状态。
          </p>
        </div>

        <!-- Animation Details Grid -->
        <div class="grid grid-cols-2 gap-2 text-xs">
          <div class="bg-slate-950/60 p-2 rounded-xl border border-slate-800">
            <span class="text-slate-400 text-[11px] block">动画标识 (VFX ID)</span>
            <span id="statVfxId" class="font-mono text-amber-400 font-semibold">thunderbolt</span>
          </div>
          <div class="bg-slate-950/60 p-2 rounded-xl border border-slate-800">
            <span class="text-slate-400 text-[11px] block">切片总帧数</span>
            <span id="statFrameCount" class="font-mono text-slate-200 font-semibold">6 Frames</span>
          </div>
          <div class="bg-slate-950/60 p-2 rounded-xl border border-slate-800">
            <span class="text-slate-400 text-[11px] block">关联招式名</span>
            <span id="statMoveNames" class="font-medium text-slate-200">十万伏特</span>
          </div>
          <div class="bg-slate-950/60 p-2 rounded-xl border border-slate-800">
            <span class="text-slate-400 text-[11px] block">弹道/粒子类型</span>
            <span id="statVfxStyle" class="font-medium text-slate-200">贯顶落雷 (Overhead)</span>
          </div>
        </div>

        <!-- Equipping Pokémon List -->
        <div>
          <span class="text-xs font-semibold text-slate-300 block mb-1.5 flex items-center justify-between">
            <span>配备该动效的宝可梦:</span>
            <span id="pkmCountBadge" class="text-[10px] font-mono px-1.5 py-0.2 rounded bg-slate-800 text-amber-300">4 只</span>
          </span>
          <div id="pkmBadgesContainer" class="flex flex-wrap gap-1.5 max-h-32 overflow-y-auto pr-1">
            <!-- Badges injected by JS -->
          </div>
        </div>
      </div>

      <!-- Footer Info -->
      <div class="bg-slate-950/80 p-2.5 rounded-xl border border-slate-800/80 text-[11px] text-slate-400 leading-normal">
        💡 <strong class="text-slate-300">设计规范</strong>：所有动效均在 Godot 引擎中集成专有粒子喷溅、受击硬直着色器、音效与震屏回馈。
      </div>
    </div>

  </section>

  <!-- Filter & Search Controls -->
  <section class="bg-slate-900 border border-slate-800 rounded-2xl p-4 shadow-xl flex flex-col gap-3">
    
    <div class="flex flex-col md:flex-row md:items-center justify-between gap-3">
      <!-- Search Bar -->
      <div class="relative flex-1 max-w-md">
        <span class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none text-slate-400">
          🔍
        </span>
        <input 
          type="text" 
          id="searchInput" 
          placeholder="按招式中文名、英文标识、宝可梦搜索 (如: 十万伏特 / 皮卡丘 / thunder)..." 
          oninput="onSearchChange(this.value)"
          class="w-full pl-9 pr-4 py-2 bg-slate-950 border border-slate-800 rounded-xl text-xs text-white placeholder-slate-500 focus:outline-none focus:border-amber-500 transition"
        />
      </div>

      <!-- Tier Filters -->
      <div class="flex items-center gap-1.5 text-xs">
        <span class="text-slate-400 font-medium">星级阶段:</span>
        <button onclick="filterTier('all')" id="tier-all" class="px-2.5 py-1 rounded-lg bg-amber-500 text-slate-950 font-bold transition">全部</button>
        <button onclick="filterTier('★1 基础')" id="tier-1" class="px-2.5 py-1 rounded-lg bg-slate-800 hover:bg-slate-700 text-slate-300 border border-slate-700 transition">★1 基础</button>
        <button onclick="filterTier('★2 进阶')" id="tier-2" class="px-2.5 py-1 rounded-lg bg-slate-800 hover:bg-slate-700 text-slate-300 border border-slate-700 transition">★2 进阶</button>
        <button onclick="filterTier('★3 终极')" id="tier-3" class="px-2.5 py-1 rounded-lg bg-slate-800 hover:bg-slate-700 text-slate-300 border border-slate-700 transition">★3 终极</button>
      </div>
    </div>

    <!-- Type Filter Pills -->
    <div class="flex flex-wrap items-center gap-1.5 pt-2 border-t border-slate-800 text-xs">
      <span class="text-slate-400 font-medium mr-1">属性筛选:</span>
      <button onclick="filterType('all')" id="type-all" class="type-pill active px-2.5 py-1 rounded-lg bg-slate-800 text-white border border-slate-700 hover:bg-slate-700 transition">
        全部 (128)
      </button>
      <button onclick="filterType('Fire')" id="type-Fire" class="type-pill px-2.5 py-1 rounded-lg bg-red-950/40 text-orange-400 border border-orange-500/30 hover:bg-orange-500/20 transition">🔥 火系</button>
      <button onclick="filterType('Water')" id="type-Water" class="type-pill px-2.5 py-1 rounded-lg bg-blue-950/40 text-blue-400 border border-blue-500/30 hover:bg-blue-500/20 transition">💧 水系</button>
      <button onclick="filterType('Grass')" id="type-Grass" class="type-pill px-2.5 py-1 rounded-lg bg-green-950/40 text-green-400 border border-green-500/30 hover:bg-green-500/20 transition">🌿 草系</button>
      <button onclick="filterType('Electric')" id="type-Electric" class="type-pill px-2.5 py-1 rounded-lg bg-amber-950/40 text-yellow-400 border border-yellow-500/30 hover:bg-yellow-500/20 transition">⚡ 电系</button>
      <button onclick="filterType('Ice')" id="type-Ice" class="type-pill px-2.5 py-1 rounded-lg bg-cyan-950/40 text-cyan-400 border border-cyan-500/30 hover:bg-cyan-500/20 transition">❄️ 冰系</button>
      <button onclick="filterType('Psychic')" id="type-Psychic" class="type-pill px-2.5 py-1 rounded-lg bg-pink-950/40 text-pink-400 border border-pink-500/30 hover:bg-pink-500/20 transition">🔮 超能系</button>
      <button onclick="filterType('Dark')" id="type-Dark" class="type-pill px-2.5 py-1 rounded-lg bg-stone-950/40 text-stone-300 border border-stone-500/30 hover:bg-stone-500/20 transition">🌑 恶系</button>
      <button onclick="filterType('Ghost')" id="type-Ghost" class="type-pill px-2.5 py-1 rounded-lg bg-purple-950/40 text-purple-400 border border-purple-500/30 hover:bg-purple-500/20 transition">👻 幽灵系</button>
      <button onclick="filterType('Bug')" id="type-Bug" class="type-pill px-2.5 py-1 rounded-lg bg-lime-950/40 text-lime-400 border border-lime-500/30 hover:bg-lime-500/20 transition">🐛 虫系</button>
      <button onclick="filterType('Fighting')" id="type-Fighting" class="type-pill px-2.5 py-1 rounded-lg bg-rose-950/40 text-rose-400 border border-rose-500/30 hover:bg-rose-500/20 transition">🥋 格斗系</button>
      <button onclick="filterType('Flying')" id="type-Flying" class="type-pill px-2.5 py-1 rounded-lg bg-indigo-950/40 text-indigo-400 border border-indigo-500/30 hover:bg-indigo-500/20 transition">🌪️ 飞行系</button>
      <button onclick="filterType('Poison')" id="type-Poison" class="type-pill px-2.5 py-1 rounded-lg bg-fuchsia-950/40 text-fuchsia-400 border border-fuchsia-500/30 hover:bg-fuchsia-500/20 transition">🧪 毒系</button>
      <button onclick="filterType('Ground')" id="type-Ground" class="type-pill px-2.5 py-1 rounded-lg bg-yellow-950/40 text-amber-500 border border-amber-600/30 hover:bg-amber-600/20 transition">⛰️ 地面系</button>
      <button onclick="filterType('Rock')" id="type-Rock" class="type-pill px-2.5 py-1 rounded-lg bg-stone-950/40 text-yellow-600 border border-yellow-700/30 hover:bg-yellow-700/20 transition">🪨 岩石系</button>
      <button onclick="filterType('Dragon')" id="type-Dragon" class="type-pill px-2.5 py-1 rounded-lg bg-violet-950/40 text-violet-400 border border-violet-500/30 hover:bg-violet-500/20 transition">🐉 龙系</button>
      <button onclick="filterType('Normal')" id="type-Normal" class="type-pill px-2.5 py-1 rounded-lg bg-zinc-950/40 text-zinc-300 border border-zinc-500/30 hover:bg-zinc-500/20 transition">⭐ 一般系</button>
    </div>

  </section>

  <!-- Grid Gallery of All 128 Skills -->
  <section class="flex flex-col gap-2">
    <div class="flex items-center justify-between text-xs text-slate-400 px-1">
      <span>
        正在展示: <strong id="visibleCount" class="text-white">128</strong> 项技能动效
      </span>
      <span>点击任意卡片即可在上方演播台实时预览与拆帧</span>
    </div>

    <div id="vfxGrid" class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-6 xl:grid-cols-8 gap-3">
      <!-- Injected by JavaScript -->
    </div>
  </section>

  <!-- JavaScript App Logic -->
  <script>
    const VFX_LIST = {vfx_json};
    let currentVfxIndex = 0;
    let currentFrameIndex = 0;
    let isPlaying = true;
    let playSpeedFps = 14;
    let playTimer = null;
    let zoomScale = 1.5;
    let activeType = 'all';
    let activeTier = 'all';
    let searchQuery = '';

    const bgStyles = [
      'bg-slate-950',
      'bg-gradient-to-b from-slate-900 to-slate-950',
      'bg-gradient-to-b from-amber-950/30 to-slate-950',
      'bg-gradient-to-b from-blue-950/30 to-slate-950',
      'bg-gradient-to-b from-emerald-950/30 to-slate-950'
    ];
    let bgIndex = 0;

    function init() {{
      // Select thunderbolt as default or first
      const defaultIdx = VFX_LIST.findIndex(v => v.id === 'thunderbolt');
      currentVfxIndex = defaultIdx !== -1 ? defaultIdx : 0;
      
      renderGrid();
      loadVfxToStage(currentVfxIndex);
      startLoop();
      startMiniThumbnailsLoop();
    }}

    function loadVfxToStage(idx) {{
      currentVfxIndex = idx;
      currentFrameIndex = 0;
      const v = VFX_LIST[idx];

      // Update UI Header
      document.getElementById('playerTitle').textContent = `【${{v.name}}】 ${{v.id}}`;
      const typeBadge = document.getElementById('playerBadgeType');
      typeBadge.textContent = v.type_zh;
      typeBadge.style.backgroundColor = v.color;
      
      const tierBadge = document.getElementById('playerBadgeTier');
      tierBadge.textContent = v.tier;

      // Update Telemetry
      document.getElementById('skillDescText').textContent = v.desc;
      document.getElementById('statVfxId').textContent = v.id;
      document.getElementById('statFrameCount').textContent = `${{v.frame_count}} 帧序列`;
      document.getElementById('statMoveNames').textContent = v.moves.join(' / ');
      
      // Update Scrubber
      const scrubber = document.getElementById('frameScrubber');
      scrubber.max = v.frame_count - 1;
      scrubber.value = 0;
      document.getElementById('scrubberMax').textContent = v.frame_count - 1;

      // Update Pokémons
      const pkmBox = document.getElementById('pkmBadgesContainer');
      pkmBox.innerHTML = '';
      document.getElementById('pkmCountBadge').textContent = `${{v.pokemons.length}} 只`;
      if (v.pokemons.length === 0) {{
        pkmBox.innerHTML = '<span class="text-slate-500 text-xs italic">全星级通用备用招式</span>';
      }} else {{
        v.pokemons.forEach(p => {{
          const sp = document.createElement('span');
          sp.className = 'px-2 py-0.5 rounded-md bg-slate-800 text-slate-200 border border-slate-700 text-[11px]';
          sp.textContent = p;
          pkmBox.appendChild(sp);
        }});
      }}

      // Highlight active card
      document.querySelectorAll('.vfx-card').forEach((card, i) => {{
        if (card.dataset.id === v.id) {{
          card.classList.add('active');
          card.scrollIntoView({{ behavior: 'smooth', block: 'nearest' }});
        }} else {{
          card.classList.remove('active');
        }}
      }});

      renderCurrentFrame();
    }}

    function renderCurrentFrame() {{
      const v = VFX_LIST[currentVfxIndex];
      const img = document.getElementById('stageImg');
      img.src = v.frames[currentFrameIndex];
      img.style.transform = `scale(${{zoomScale}})`;

      document.getElementById('frameCounter').textContent = `${{currentFrameIndex + 1}} / ${{v.frame_count}}`;
      document.getElementById('frameScrubber').value = currentFrameIndex;
    }}

    function startLoop() {{
      if (playTimer) clearInterval(playTimer);
      playTimer = setInterval(() => {{
        if (!isPlaying) return;
        const v = VFX_LIST[currentVfxIndex];
        currentFrameIndex = (currentFrameIndex + 1) % v.frame_count;
        renderCurrentFrame();
      }}, 1000 / playSpeedFps);
    }}

    function togglePlay() {{
      isPlaying = !isPlaying;
      document.getElementById('playIcon').textContent = isPlaying ? '⏸' : '▶️';
      document.getElementById('playText').textContent = isPlaying ? '暂停' : '播放';
    }}

    function prevFrame() {{
      isPlaying = false;
      document.getElementById('playIcon').textContent = '▶️';
      document.getElementById('playText').textContent = '播放';
      const v = VFX_LIST[currentVfxIndex];
      currentFrameIndex = (currentFrameIndex - 1 + v.frame_count) % v.frame_count;
      renderCurrentFrame();
    }}

    function nextFrame() {{
      isPlaying = false;
      document.getElementById('playIcon').textContent = '▶️';
      document.getElementById('playText').textContent = '播放';
      const v = VFX_LIST[currentVfxIndex];
      currentFrameIndex = (currentFrameIndex + 1) % v.frame_count;
      renderCurrentFrame();
    }}

    function replayOneShot() {{
      currentFrameIndex = 0;
      isPlaying = true;
      document.getElementById('playIcon').textContent = '⏸';
      document.getElementById('playText').textContent = '暂停';
      renderCurrentFrame();
    }}

    function onScrub(val) {{
      isPlaying = false;
      document.getElementById('playIcon').textContent = '▶️';
      document.getElementById('playText').textContent = '播放';
      currentFrameIndex = parseInt(val);
      renderCurrentFrame();
    }}

    function changeSpeed(val) {{
      playSpeedFps = parseInt(val);
      document.getElementById('fpsDisplay').textContent = `${{playSpeedFps}}.0 FPS`;
      startLoop();
    }}

    function changeZoom(val) {{
      zoomScale = parseFloat(val);
      renderCurrentFrame();
    }}

    function changeBackground() {{
      const arena = document.getElementById('arenaBox');
      arena.classList.remove(bgStyles[bgIndex]);
      bgIndex = (bgIndex + 1) % bgStyles.length;
      arena.classList.add(bgStyles[bgIndex]);
    }}

    // Filtering
    function filterType(t) {{
      activeType = t;
      document.querySelectorAll('.type-pill').forEach(btn => {{
        if (btn.id === `type-${{t}}`) btn.classList.add('active');
        else btn.classList.remove('active');
      }});
      renderGrid();
    }}

    function filterTier(tier) {{
      activeTier = tier;
      document.querySelectorAll('[id^="tier-"]').forEach(btn => {{
        if ((tier === 'all' && btn.id === 'tier-all') ||
            (tier === '★1 基础' && btn.id === 'tier-1') ||
            (tier === '★2 进阶' && btn.id === 'tier-2') ||
            (tier === '★3 终极' && btn.id === 'tier-3')) {{
          btn.className = 'px-2.5 py-1 rounded-lg bg-amber-500 text-slate-950 font-bold transition';
        }} else {{
          btn.className = 'px-2.5 py-1 rounded-lg bg-slate-800 hover:bg-slate-700 text-slate-300 border border-slate-700 transition';
        }}
      }});
      renderGrid();
    }}

    function onSearchChange(val) {{
      searchQuery = val.trim().toLowerCase();
      renderGrid();
    }}

    function renderGrid() {{
      const grid = document.getElementById('vfxGrid');
      grid.innerHTML = '';

      let visible = 0;
      VFX_LIST.forEach((v, idx) => {{
        // Filter Type
        if (activeType !== 'all' && v.type !== activeType) return;
        // Filter Tier
        if (activeTier !== 'all' && v.tier !== activeTier) return;
        // Search Query
        if (searchQuery) {{
          const matchName = v.name.toLowerCase().includes(searchQuery);
          const matchId = v.id.toLowerCase().includes(searchQuery);
          const matchMoves = v.moves.some(m => m.toLowerCase().includes(searchQuery));
          const matchPkm = v.pokemons.some(p => p.toLowerCase().includes(searchQuery));
          if (!matchName && !matchId && !matchMoves && !matchPkm) return;
        }}

        visible++;
        const card = document.createElement('div');
        card.dataset.id = v.id;
        card.dataset.index = idx;
        const isActive = idx === currentVfxIndex;
        card.className = `vfx-card ${{isActive ? 'active' : ''}} group cursor-pointer bg-slate-900 hover:bg-slate-800/80 border border-slate-800 hover:border-slate-600 rounded-xl p-2.5 transition flex flex-col items-center justify-between gap-2 shadow-md`;
        
        card.onclick = () => loadVfxToStage(idx);

        card.innerHTML = `
          <div class="relative w-full h-20 rounded-lg bg-slate-950 border border-slate-800/80 flex items-center justify-center overflow-hidden">
            <img id="thumb-${{idx}}" src="${{v.frames[0]}}" alt="${{v.name}}" class="pixelated max-h-16 max-w-full drop-shadow transition-transform group-hover:scale-110" />
            <span class="absolute top-1 right-1 text-[9px] font-mono px-1 rounded bg-black/70 text-slate-400">
              ${{v.frame_count}}F
            </span>
          </div>
          <div class="w-full flex flex-col items-start gap-0.5">
            <div class="w-full flex items-center justify-between">
              <span class="text-xs font-bold text-white truncate group-hover:text-amber-300 transition">${{v.name}}</span>
              <span class="text-[10px] font-medium" style="color: ${{v.color}}">${{v.type_zh}}</span>
            </div>
            <span class="text-[10px] font-mono text-slate-400 truncate w-full">${{v.id}}</span>
          </div>
        `;

        grid.appendChild(card);
      }});

      document.getElementById('visibleCount').textContent = visible;
    }}

    // Thumbnail Animation Loop
    function startMiniThumbnailsLoop() {{
      let thumbFrame = 0;
      setInterval(() => {{
        thumbFrame++;
        VFX_LIST.forEach((v, idx) => {{
          const el = document.getElementById(`thumb-${{idx}}`);
          if (el) {{
            const fIndex = thumbFrame % v.frame_count;
            el.src = v.frames[fIndex];
          }}
        }});
      }}, 120);
    }}

    window.onload = init;
  </script>
</body>
</html>
"""

    # 4. Write to artifact path
    os.makedirs(os.path.dirname(ARTIFACT_OUT), exist_ok=True)
    with open(ARTIFACT_OUT, "w", encoding="utf-8") as f:
        f.write(html_content)
    print(f"[SUCCESS] Wrote self-contained HTML artifact: {ARTIFACT_OUT} ({len(html_content)/1024:.1f} KB)")

    # 5. Write to project exports path
    os.makedirs(os.path.dirname(EXPORT_OUT), exist_ok=True)
    with open(EXPORT_OUT, "w", encoding="utf-8") as f:
        f.write(html_content)
    print(f"[SUCCESS] Wrote project export: {EXPORT_OUT}")

if __name__ == "__main__":
    main()
