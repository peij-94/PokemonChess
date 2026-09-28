#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
fix_skill_vfx_duplicates.py

Eliminates duplicate skill animations across Pokemon skill trees.
Ensures that:
1. Every move maps to an authentic, visually accurate VFX effect.
2. Within any Pokemon's 3 star level choices, all 3 choices have 100% UNIQUE, distinct visual animations.
3. Bug, Dark, Grass, Water, Electric, Ice, Flying, Fighting, Rock, Ground, Psychic moves
   have specialized, authentic visual effects instead of generic fallbacks.
"""

import os
import re
import csv
import json

CACHE_DIR = "scripts/cache"
DB_PATH = "scripts/autoload/pokemon_database.gd"

# Comprehensive canonical move-to-vfx mapping
MOVE_NAME_TO_VFX = {
    # --- WATER ---
    "水枪": "water_gun",
    "水之波动": "water_pulse",
    "水流裂破": "aqua_tail",
    "水流尾": "aqua_tail",
    "攀瀑": "aqua_tail",
    "潜水": "aqua_tail",
    "泡沫光线": "bubble_beam",
    "泡沫": "bubble_beam",
    "水炮": "hydro_pump",
    "加农水炮": "hydro_cannon",
    "冲浪": "surf",
    "浊流": "surf",
    "根源波动": "hydro_cannon",
    "波动冲": "water_pulse",
    "盐水": "water_pulse",
    "蟹钳锤": "crabhammer",
    "夹住": "crabhammer",

    # --- FIRE ---
    "火花": "ember",
    "火焰旋涡": "fire_spin",
    "火焰轮": "flame_wheel",
    "喷射火焰": "flamethrower",
    "大字爆炎": "fire_blast",
    "热风": "heat_wave",
    "过热": "fire_blast",
    "闪焰冲锋": "flare_blitz",
    "炼狱": "inferno",
    "爆炸烈焰": "blast_burn",
    "火焰拳": "fire_punch",
    "火焰牙": "fire_fang",
    "烈焰溅射": "ember",
    "火之誓约": "fire_spin",

    # --- GRASS ---
    "飞叶快刀": "razor_leaf",
    "种子炸弹": "seed_bomb",
    "种子机关枪": "seed_bomb",
    "能量球": "seed_bomb",
    "花瓣舞": "petal_dance",
    "飞叶风暴": "petal_dance",
    "强力鞭打": "power_whip",
    "藤鞭": "vine_whip",
    "木槌": "power_whip",
    "日光束": "solar_beam",
    "疯狂植物": "frenzy_plant",
    "寄生种子": "leech_seed",
    "终极吸取": "leech_seed",
    "超级吸取": "leech_seed",
    "吸取": "leech_seed",
    "叶刃": "leaf_blade",
    "魔法叶": "razor_leaf",
    "蘑菇孢子": "leech_seed",

    # --- ELECTRIC ---
    "电击": "thundershock",
    "电火花": "spark",
    "疯狂伏特": "spark",
    "电光": "spark",
    "伏特攻击": "spark",
    "伏特替换": "spark",
    "电球": "electro_ball",
    "电网": "electroweb",
    "十万伏特": "thunderbolt",
    "放电": "discharge",
    "打雷": "thunder",
    "雷电拳": "thunder_punch",
    "雷电牙": "thunder_fang",
    "电磁炮": "electro_ball",
    "雷暴": "thunder_tempest",
    "千万伏特": "volt_catastrophe",

    # --- ICE ---
    "冰砾": "ice_shard",
    "细雪": "ice_shard",
    "冰锥": "icicle_spear",
    "冰柱坠击": "icicle_spear",
    "冰冻拳": "ice_punch",
    "冰冻牙": "ice_fang",
    "冰冻光束": "ice_beam",
    "极光束": "aurora_beam",
    "暴风雪": "blizzard",
    "雪崩": "avalanche",
    "绝对零度": "sheer_cold",
    "冷冻干燥": "ice_shard",
    "冻结之风": "blizzard",
    "雪矛": "icicle_spear",

    # --- PSYCHIC ---
    "念力": "confusion",
    "催眠术": "hypnosis",
    "幻象光线": "psybeam",
    "精神利刃": "psycho_cut",
    "精神强念": "psychic",
    "精神冲击": "psystrike",
    "精神击破": "psystrike",
    "意念头锤": "zen_headbutt",
    "预知未来": "future_sight",
    "光子喷涌": "psychokinesis",
    "食梦": "dream_eater",
    "反射壁": "reflect",
    "光墙": "light_screen",
    "睡觉": "rest",
    "治愈波动": "heal_pulse",
    "瞬间失忆": "rest",
    "月亮之力": "cosmic_singularity",

    # --- DARK / GHOST ---
    "舌舔": "lick",
    "暗影拳": "shadow_punch",
    "暗影球": "shadow_ball",
    "暗影爪": "shadow_punch",
    "影子偷袭": "shadow_punch",
    "黑夜魔影": "night_shade",
    "恶之波动": "dark_pulse",
    "祸不单行": "hex_nightmare",
    "同命": "hex_nightmare",
    "怨恨": "hex_nightmare",
    "咬住": "bite",
    "咬碎": "crunch",
    "突袭": "mach_punch",
    "追打": "tackle",
    "暗袭要害": "slash",
    "灭亡之歌": "perish_song",
    "惊吓": "night_shade",

    # --- BUG ---
    "吸血": "leech_life",
    "虫咬": "leech_life",
    "飞弹针": "pin_missile",
    "虫鸣": "bug_buzz",
    "虫之抵抗": "bug_buzz",
    "银色旋风": "silver_wind",
    "十字剪": "x_scissor",
    "吐丝": "string_shot",
    "连斩": "slash",
    "蝶舞": "extreme_evoboost",

    # --- FLYING ---
    "啄": "drill_peck",
    "啄钻": "drill_peck",
    "起风": "gust",
    "龙卷风": "twister",
    "暴风": "twister",
    "空气斩": "air_slash",
    "空气利刃": "air_slash",
    "翅膀攻击": "wing_attack",
    "燕返": "air_slash",
    "勇鸟猛攻": "brave_bird",
    "飞翔": "brave_bird",
    "羽栖": "heal_pulse",
    "旋风刀": "air_slash",

    # --- FIGHTING ---
    "踢倒": "low_kick",
    "音速拳": "mach_punch",
    "真空波": "mach_punch",
    "子弹拳": "mach_punch",
    "空手劈": "cross_chop",
    "十字劈": "cross_chop",
    "爆裂拳": "dynamic_punch",
    "百万吨重拳": "mega_punch",
    "百万吨重踢": "mega_kick",
    "飞膝踢": "mega_kick",
    "近身战": "close_combat",
    "发劲": "force_palm",
    "波导弹": "aura_sphere",
    "真气弹": "aura_sphere",
    "蛮力": "mega_punch",
    "借力摔": "mega_punch",
    "劈瓦": "cross_chop",
    "吸取拳": "mach_punch",

    # --- ROCK / GROUND ---
    "落石": "rock_throw",
    "掷泥": "mud_slap",
    "泥巴射击": "mud_slap",
    "泥炸弹": "mud_slap",
    "岩崩": "rock_slide",
    "原始之力": "ancient_power",
    "尖石攻击": "stone_edge",
    "地震": "earthquake",
    "重踏": "earthquake",
    "地裂": "earthquake",
    "挖洞": "earthquake",
    "直冲钻": "drill_peck",
    "骨棒": "bone_rush",
    "骨棒乱打": "bone_rush",
    "骨头回力镖": "bonemerang",
    "滚动": "rock_slide",
    "隐形岩": "stone_edge",

    # --- POISON ---
    "毒针": "poison_sting",
    "浊雾": "sludge_bomb",
    "酸液": "sludge_bomb",
    "污泥炸弹": "sludge_bomb",
    "污泥波": "sludge_bomb",
    "垃圾射击": "gunk_shot",
    "毒击": "poison_jab",
    "十字毒刃": "poison_jab",
    "剧毒": "toxic",
    "溶化": "acid_armor",

    # --- DRAGON ---
    "龙之怒": "dragon_breath",
    "龙息": "dragon_breath",
    "龙之波动": "dragon_pulse",
    "龙爪": "dragon_claw",
    "龙尾": "dragon_claw",
    "二连劈": "dragon_claw",
    "龙之俯冲": "dragon_claw",
    "流星群": "draco_meteor",
    "逆鳞": "dragon_apocalypse",

    # --- NORMAL ---
    "撞击": "tackle",
    "抓": "slash",
    "拍击": "tackle",
    "电光一闪": "quick_attack",
    "神速": "quick_attack",
    "头锤": "headbutt",
    "猛撞": "take_down",
    "泰山压顶": "body_slam",
    "舍身冲撞": "double_edge",
    "劈开": "slash",
    "乱抓": "slash",
    "居合斩": "slash",
    "高速星星": "swift",
    "三重攻击": "tri_attack",
    "破坏光线": "hyper_beam",
    "终极冲击": "giga_impact",
    "重磅冲撞": "giga_impact",
    "大爆炸": "fire_blast",
    "自爆": "fire_blast",
    "替身": "transform",
    "变身": "transform",
    "挥指": "swift",
    "迷昏拳": "dynamic_punch",
    "珍藏": "giga_impact",
    "王牌": "swift",
    "打鼾": "headbutt",
    "必杀门牙": "headbutt",
    "愤怒门牙": "headbutt",
    "变硬": "reflect",
    "生蛋": "softboiled",
    "变小": "transform",
    "刺耳声": "perish_song",
    "超音波": "perish_song",
    "唱歌": "perish_song",
    "尖刺加农炮": "pin_missile",
    "绑紧": "stone_edge",
    "信号光束": "psybeam",
    "九彩升华齐聚顶": "extreme_evoboost",
}

# Type-based diverse fallback VFX lists to guarantee distinct animations per star
TYPE_DISTINCT_VFX = {
    "Fire": ["ember", "fire_spin", "flame_wheel", "flamethrower", "fire_blast", "heat_wave", "fire_punch", "flare_blitz", "inferno", "blast_burn"],
    "Water": ["water_gun", "water_pulse", "bubble_beam", "aqua_tail", "hydro_pump", "surf", "crabhammer", "hydro_cannon"],
    "Grass": ["seed_bomb", "razor_leaf", "petal_dance", "power_whip", "vine_whip", "solar_beam", "frenzy_plant", "leech_seed"],
    "Electric": ["thundershock", "spark", "electro_ball", "electroweb", "thunderbolt", "discharge", "thunder_punch", "thunder"],
    "Ice": ["ice_shard", "icicle_spear", "ice_punch", "ice_beam", "aurora_beam", "blizzard", "avalanche", "sheer_cold"],
    "Psychic": ["confusion", "hypnosis", "psybeam", "psycho_cut", "psychic", "psystrike", "future_sight", "zen_headbutt"],
    "Ghost": ["lick", "shadow_punch", "shadow_ball", "night_shade", "dark_pulse", "hex_nightmare"],
    "Dark": ["bite", "crunch", "dark_pulse", "night_shade", "shadow_ball", "hex_nightmare"],
    "Bug": ["leech_life", "pin_missile", "bug_buzz", "silver_wind", "x_scissor", "string_shot"],
    "Flying": ["gust", "drill_peck", "wing_attack", "air_slash", "twister", "brave_bird"],
    "Fighting": ["low_kick", "mach_punch", "cross_chop", "dynamic_punch", "mega_kick", "close_combat", "aura_sphere", "mega_punch"],
    "Rock": ["rock_throw", "rock_slide", "ancient_power", "stone_edge"],
    "Ground": ["mud_slap", "bone_rush", "bonemerang", "earthquake"],
    "Poison": ["poison_sting", "sludge_bomb", "poison_jab", "gunk_shot", "toxic", "acid_armor"],
    "Dragon": ["dragon_breath", "dragon_claw", "dragon_pulse", "draco_meteor", "dragon_apocalypse"],
    "Normal": ["tackle", "quick_attack", "headbutt", "take_down", "slash", "body_slam", "double_edge", "swift", "hyper_beam", "giga_impact"]
}

def main():
    print("=== Fixing Duplicate Skill VFX in pokemon_database.gd ===")
    
    with open(DB_PATH, "r", encoding="utf-8") as f:
        content = f.read()

    # Parse each Pokemon block
    lines = content.splitlines(keepends=True)
    
    out_lines = []
    current_poke = None
    current_star = None
    current_skill = None
    star_skills = {1: [], 2: [], 3: []}
    in_skills_block = False
    
    # We will parse pokemons and reconstruct their "skills": { ... } cleanly
    # Pattern to match:
    # \t"id": {
    #     ...
    #     "skills": {
    #         1: [ ... ],
    #         2: [ ... ],
    #         3: [ ... ]
    #     },
    
    fixed_count = 0
    total_skills = 0
    
    # Helper to determine best VFX for a skill name
    def resolve_skill_vfx(skill_name, primary_type, used_vfx_in_star):
        # 1. Exact match from dictionary
        vfx = MOVE_NAME_TO_VFX.get(skill_name)
        if vfx and vfx not in used_vfx_in_star:
            return vfx
            
        # 2. If vfx is already in used_vfx_in_star, find a distinct alternative of the same type
        type_pool = TYPE_DISTINCT_VFX.get(primary_type, TYPE_DISTINCT_VFX["Normal"])
        for alt_vfx in type_pool:
            if alt_vfx not in used_vfx_in_star:
                return alt_vfx
                
        # 3. Fallback to Normal diverse
        for alt_vfx in TYPE_DISTINCT_VFX["Normal"]:
            if alt_vfx not in used_vfx_in_star:
                return alt_vfx
                
        return vfx or "quick_attack"

    # We do a state-machine rewrite
    i = 0
    while i < len(lines):
        line = lines[i]
        
        # Check start of pokemon block
        if line.startswith('\t"') and line.endswith('{\n') and not line.startswith('\t\t'):
            current_poke = line.strip().split('"')[1]
            out_lines.append(line)
            i += 1
            continue
            
        # Check start of skills block
        if line.strip() == '"skills": {':
            # Collect full skills block until matching end
            skills_lines = [line]
            i += 1
            brace_depth = 1
            while i < len(lines) and brace_depth > 0:
                s_line = lines[i]
                skills_lines.append(s_line)
                if "{" in s_line:
                    brace_depth += s_line.count("{")
                if "}" in s_line:
                    brace_depth -= s_line.count("}")
                i += 1
            
            # Now parse and fix the skills block
            skills_text = "".join(skills_lines)
            
            # Find primary type of current_poke by looking back in out_lines
            poke_type = "Normal"
            for prev_l in reversed(out_lines[-40:]):
                if '"types":' in prev_l:
                    m = re.search(r'\["([^"]+)"', prev_l)
                    if m:
                        poke_type = m.group(1)
                    break
            
            # Parse star 1, 2, 3
            # Regex to find each skill dictionary in star arrays
            # 1: [ ... ], 2: [ ... ], 3: [ ... ]
            def fix_star_array(star_num, text_chunk):
                # find all skill blocks within [ ... ]
                blocks = re.findall(r'\{\s*"name":\s*"([^"]+)"[\s\S]*?\}', text_chunk)
                
                # Split skills by matching braces
                skill_dicts = []
                # Use regex to find individual skill JSON-like blocks
                pattern = re.compile(r'(\{\s*"name":\s*"([^"]+)"[\s\S]*?\n\t\t\t\t\})')
                matches = list(pattern.finditer(text_chunk))
                
                used_vfx = set()
                new_chunk = text_chunk
                
                for m in matches:
                    raw_block = m.group(1)
                    s_name = m.group(2)
                    
                    # Extract current vfx
                    vfx_m = re.search(r'"vfx":\s*"([^"]+)"', raw_block)
                    old_vfx = vfx_m.group(1) if vfx_m else "quick_attack"
                    
                    # Pick unique, distinct VFX
                    target_vfx = MOVE_NAME_TO_VFX.get(s_name, old_vfx)
                    if target_vfx in used_vfx:
                        # Find alternative
                        target_vfx = resolve_skill_vfx(s_name, poke_type, used_vfx)
                        
                    used_vfx.add(target_vfx)
                    
                    if old_vfx != target_vfx:
                        nonlocal fixed_count
                        fixed_count += 1
                        # Replace in raw_block
                        new_block = re.sub(r'"vfx":\s*"[^"]+"', f'"vfx": "{target_vfx}"', raw_block, count=1)
                        new_chunk = new_chunk.replace(raw_block, new_block, 1)
                        
                return new_chunk

            # Process star 1, 2, 3 in skills_text
            for star in [1, 2, 3]:
                star_pattern = re.compile(r'(%d:\s*\[[\s\S]*?\n\t\t\t\])' % star)
                m = star_pattern.search(skills_text)
                if m:
                    old_star_text = m.group(1)
                    new_star_text = fix_star_array(star, old_star_text)
                    skills_text = skills_text.replace(old_star_text, new_star_text, 1)
                    
            out_lines.append(skills_text)
            continue
            
        out_lines.append(line)
        i += 1
        
    with open(DB_PATH, "w", encoding="utf-8") as f:
        f.writelines(out_lines)
        
    print(f"Successfully processed database! Fixed/refined {fixed_count} skill VFX entries.")

if __name__ == "__main__":
    main()
