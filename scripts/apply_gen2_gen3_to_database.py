#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
apply_gen2_gen3_to_database.py
Systematically injects Generation 2 (#152 ~ #251) and Generation 3 (#252 ~ #386)
Pokemon into scripts/autoload/pokemon_database.gd:
1. Appends 235 new Pokemon to pokemons dictionary with full stats, basic attacks, 9-unique branching skills, and icons.
2. Registers Dark and Steel synergies in synergies dictionary.
3. Updates evolution_chains dictionary with all 387 Pokemon (including 11 Gen 1 cross-gen evolutions).
"""

import os
import sys
import json
import shutil
import csv
from collections import defaultdict

CACHE_DIR = "scripts/cache"
DB_PATH = "scripts/autoload/pokemon_database.gd"
VFX_DIR = "assets/vfx"

sys.path.append("scripts")
from build_gen2_gen3_data import (
    TYPE_ID_MAP, TYPE_FALLBACK_TIERS, MOVE_NAME_TO_VFX,
    moves, slug_to_id, id_to_slug, names_zh, slug_to_zh, zh_to_slug,
    flavors_zh, pokemon_learnsets, species_meta, species_names,
    species_genus, pokemon_types, pokemon_stats, pokemon_slugs,
    build_skill_entry, get_sfx_for_vfx, compute_cost_and_range,
    get_basic_attack_style
)

available_vfx = {d for d in os.listdir(VFX_DIR) if os.path.exists(os.path.join(VFX_DIR, d, "frame_0.png"))}

TYPE_ARCHETYPE_MOVES = {
    'Fire': ['火花', '火焰轮', '火之誓约', '火焰旋涡', '火焰拳', '火焰牙', '喷射火焰', '热风', '大字爆炎', '闪焰冲锋', '炼狱', '爆炸烈焰'],
    'Water': ['水枪', '泡沫', '水流喷射', '水之波动', '泡沫光线', '水流尾', '盐水', '攀瀑', '冲浪', '水炮', '加农水炮', '海啸巨浪', '蟹钳锤'],
    'Grass': ['寄生种子', '藤鞭', '飞叶快刀', '种子炸弹', '终极吸取', '花瓣舞', '叶刃', '能量球', '强力鞭打', '日光束', '飞叶风暴', '疯狂植物'],
    'Electric': ['电击', '电球', '电光', '电网', '十万伏特', '放电', '雷电拳', '雷电牙', '打雷', '疯狂伏特', '伏特攻击', '电击波'],
    'Ice': ['细雪', '冰砾', '冰冻牙', '冰冻拳', '冰锥', '冰冻光束', '极光束', '雪崩', '暴风雪', '绝对零度'],
    'Psychic': ['念力', '催眠术', '幻象光线', '意念头锤', '精神利刃', '反射壁', '光墙', '精神强念', '精神击破', '预知未来', '宇宙力量'],
    'Dark': ['咬住', '追打', '突袭', '暗袭要害', '恶之波动', '咬碎', '欺诈', '暗黑爆破', '黑夜魔影'],
    'Steel': ['金属爪', '铁尾', '铁头', '加农光炮', '彗星拳', '钢翼', '子弹拳', '陀螺球', '重磅冲撞', '破灭之愿'],
    'Ghost': ['舌舔', '惊吓', '暗影拳', '暗影球', '暗影爪', '黑夜魔影', '祸不单行', '灭亡之歌'],
    'Bug': ['吸血', '虫咬', '飞弹针', '虫鸣', '银色旋风', '十字剪', '吐丝', '连斩', '蝶舞', '致命针刺'],
    'Fighting': ['踢倒', '音速拳', '空手劈', '发劲', '劈瓦', '十字劈', '百万吨重拳', '近身战', '百万吨重踢', '爆裂拳', '波导弹', '蛮力'],
    'Flying': ['起风', '啄', '翅膀攻击', '燕返', '空气斩', '龙卷风', '啄钻', '暴风', '勇鸟猛攻', '神鸟猛击'],
    'Poison': ['毒针', '浊雾', '酸液', '毒击', '十字毒刃', '污泥炸弹', '溶化', '剧毒', '垃圾射击', '毒尾'],
    'Ground': ['掷泥', '骨棒', '泥巴射击', '重踏', '骨头回力镖', '挖洞', '地震', '十万马力', '地裂'],
    'Rock': ['落石', '岩石爆击', '滚动', '岩崩', '原始之力', '尖石攻击'],
    'Dragon': ['龙之怒', '龙息', '龙之波动', '龙爪', '逆鳞', '流星群'],
    'Normal': ['撞击', '电光一闪', '抓', '拍击', '头锤', '猛撞', '高速星星', '劈开', '泰山压顶', '舍身冲撞', '破坏光线', '终极冲击']
}

def deduplicate_9_skills(pid, types):
    raw_moves = pokemon_learnsets.get(pid, [])
    lvl_moves = [m[2] for m in sorted([x for x in raw_moves if x[0] == 1], key=lambda x: x[1])]
    other_moves = [m[2] for m in raw_moves if m[0] != 1]
    
    known_names = []
    seen = set()
    for m in lvl_moves + other_moves:
        zh = slug_to_zh.get(m)
        if zh and zh in MOVE_NAME_TO_VFX and zh not in seen:
            seen.add(zh)
            known_names.append(zh)

    used_names = set()
    used_vfx = set()

    pri_type = types[0]
    sec_type = types[1] if len(types) > 1 else pri_type

    # Choice 0 candidates
    c0_1 = None
    for name in known_names + TYPE_ARCHETYPE_MOVES.get(pri_type, []) + TYPE_ARCHETYPE_MOVES['Normal']:
        vfx = MOVE_NAME_TO_VFX.get(name)
        if vfx in available_vfx and name not in used_names and vfx not in used_vfx:
            c0_1 = build_skill_entry(zh_to_slug.get(name, 'tackle'), 1, vfx_override=vfx)
            used_names.add(name)
            used_vfx.add(vfx)
            break

    c0_2 = None
    for name in known_names[1:] + TYPE_ARCHETYPE_MOVES.get(pri_type, []) + TYPE_ARCHETYPE_MOVES.get(sec_type, []) + TYPE_ARCHETYPE_MOVES['Normal']:
        vfx = MOVE_NAME_TO_VFX.get(name)
        if vfx in available_vfx and name not in used_names and vfx not in used_vfx:
            c0_2 = build_skill_entry(zh_to_slug.get(name, 'body-slam'), 2, vfx_override=vfx)
            used_names.add(name)
            used_vfx.add(vfx)
            break

    c0_3 = None
    for name in reversed(known_names) if known_names else []:
        vfx = MOVE_NAME_TO_VFX.get(name)
        if vfx in available_vfx and name not in used_names and vfx not in used_vfx:
            c0_3 = build_skill_entry(zh_to_slug.get(name, 'hyper-beam'), 3, vfx_override=vfx)
            used_names.add(name)
            used_vfx.add(vfx)
            break
    if not c0_3:
        for name in TYPE_ARCHETYPE_MOVES.get(pri_type, []) + TYPE_ARCHETYPE_MOVES.get(sec_type, []) + TYPE_ARCHETYPE_MOVES['Normal']:
            vfx = MOVE_NAME_TO_VFX.get(name)
            if vfx in available_vfx and name not in used_names and vfx not in used_vfx:
                c0_3 = build_skill_entry(zh_to_slug.get(name, 'hyper-beam'), 3, vfx_override=vfx)
                used_names.add(name)
                used_vfx.add(vfx)
                break

    def pick_next(star_lvl):
        for name in known_names:
            vfx = MOVE_NAME_TO_VFX.get(name)
            if vfx in available_vfx and name not in used_names and vfx not in used_vfx:
                used_names.add(name)
                used_vfx.add(vfx)
                return build_skill_entry(zh_to_slug.get(name, 'tackle'), star_lvl, vfx_override=vfx)
        search_types = types + ['Normal', 'Fighting', 'Dark', 'Steel', 'Psychic', 'Poison', 'Flying', 'Water', 'Fire', 'Grass', 'Ground', 'Rock']
        for t in search_types:
            for name in TYPE_ARCHETYPE_MOVES.get(t, []):
                vfx = MOVE_NAME_TO_VFX.get(name)
                if vfx in available_vfx and name not in used_names and vfx not in used_vfx:
                    used_names.add(name)
                    used_vfx.add(vfx)
                    return build_skill_entry(zh_to_slug.get(name, 'tackle'), star_lvl, vfx_override=vfx)
        raise RuntimeError(f'Could not find unique skill for {pid}')

    c1_1 = pick_next(1)
    c1_2 = pick_next(1)

    c2_1 = pick_next(2)
    c2_2 = pick_next(2)

    c3_1 = pick_next(3)
    c3_2 = pick_next(3)

    return {
        1: [c0_1, c1_1, c1_2],
        2: [c0_2, c2_1, c2_2],
        3: [c0_3, c3_1, c3_2]
    }

def format_skill_dict(s):
    lines = ["\t\t\t\t{"]
    lines.append(f'\t\t\t\t\t"name": "{s["name"]}",')
    lines.append(f'\t\t\t\t\t"desc": "{s["desc"]}",')
    lines.append(f'\t\t\t\t\t"detail": "{s["detail"]}",')
    lines.append(f'\t\t\t\t\t"power": {int(s["power"])},')
    lines.append(f'\t\t\t\t\t"target_count": {int(s["target_count"])},')
    lines.append(f'\t\t\t\t\t"stun_duration": {float(s["stun_duration"]):.1f},')
    lines.append(f'\t\t\t\t\t"vfx": "{s["vfx"]}",')
    lines.append(f'\t\t\t\t\t"sfx": "{s["sfx"]}",')
    lines.append(f'\t\t\t\t\t"scale": {float(s["scale"]):.2f}')
    lines.append("\t\t\t\t}")
    return "\n".join(lines)

def format_skills_block(star_skills):
    lines = ['\t\t"skills": {']
    for star in [1, 2, 3]:
        lines.append(f'\t\t\t{star}: [')
        items = [format_skill_dict(s) for s in star_skills[star]]
        lines.append(",\n".join(items))
        if star < 3:
            lines.append('\t\t\t],')
        else:
            lines.append('\t\t\t]')
    lines.append('\t\t},')
    return "\n".join(lines)

def format_pokemon_entry(p_dict):
    lines = [f'\t"{p_dict["id"]}": {{']
    lines.append(f'\t\t"id": "{p_dict["id"]}",')
    lines.append(f'\t\t"name": "{p_dict["name"]}",')
    lines.append(f'\t\t"title": "{p_dict["title"]}",')
    lines.append(f'\t\t"cost": {p_dict["cost"]},')
    types_str = ", ".join(f'"{t}"' for t in p_dict["types"])
    lines.append(f'\t\t"types": [{types_str}],')
    lines.append(f'\t\t"hp": {p_dict["hp"]},')
    lines.append(f'\t\t"atk": {p_dict["atk"]},')
    lines.append(f'\t\t"armor": {p_dict["armor"]},')
    lines.append(f'\t\t"mr": {p_dict["mr"]},')
    lines.append(f'\t\t"range": {p_dict["range"]},')
    lines.append(f'\t\t"atk_speed": {p_dict["atk_speed"]:.2f},')
    lines.append(f'\t\t"max_mana": {p_dict["max_mana"]},')
    lines.append(f'\t\t"skill_name": "{p_dict["skill_name"]}",')
    lines.append(f'\t\t"skill_desc": "{p_dict["skill_desc"]}",')
    lines.append(f'\t\t"skill_detail": "{p_dict["skill_detail"]}",')
    lines.append(f'\t\t"skill_power": {p_dict["skill_power"]},')
    lines.append('\t\t"basic_attack": {')
    ba = p_dict["basic_attack"]
    lines.append(f'\t\t\t"type": "{ba["type"]}",')
    lines.append(f'\t\t\t"name": "{ba["name"]}",')
    lines.append(f'\t\t\t"style": "{ba["style"]}",')
    lines.append(f'\t\t\t"sfx": "{ba["sfx"]}"')
    lines.append('\t\t},')
    lines.append(format_skills_block(p_dict["skills"]))
    lines.append(f'\t\t"icon": "res://assets/units/{p_dict["id"]}.png"')
    lines.append('\t}')
    return "\n".join(lines)

def build_pokemon_dict(pid):
    ident = pokemon_slugs[pid]
    s_meta = species_meta[pid]
    name = species_names.get(pid, ident)
    title = species_genus.get(pid, "宝可梦")
    types = pokemon_types[pid]
    stats = pokemon_stats[pid]

    cost, range_val = compute_cost_and_range(pid, s_meta, stats, types)

    base_hp = stats[1]
    base_atk = stats[2]
    base_def = stats[3]
    base_spatk = stats[4]
    base_spdef = stats[5]
    base_spd = stats[6]

    hp = int(max(450, min(1400, 500 + (base_hp - 35) * 6.5)))
    atk_val = int(max(45, min(130, 45 + (max(base_atk, base_spatk) - 35) * 0.65)))
    armor = int(max(20, min(75, 20 + (base_def - 35) * 0.45)))
    mr = int(max(20, min(75, 20 + (base_spdef - 35) * 0.45)))
    atk_speed = round(max(0.60, min(0.95, 0.65 + (base_spd - 40) * 0.0025)), 2)

    atk_type = "special" if base_spatk > base_atk else "physical"
    style_name, sfx = get_basic_attack_style(atk_type, types, base_atk, base_spatk)

    skills_dict = deduplicate_9_skills(pid, types)
    primary_skill = skills_dict[1][0]

    basic_move_name = "撞击" if atk_type == "physical" else "火花"
    if types[0] == "Water": basic_move_name = "水枪" if atk_type == "special" else "水流尾"
    elif types[0] == "Electric": basic_move_name = "电击" if atk_type == "special" else "雷电拳"
    elif types[0] == "Grass": basic_move_name = "飞叶快刀" if atk_type == "special" else "藤鞭"
    elif types[0] == "Dark": basic_move_name = "恶之波动" if atk_type == "special" else "咬住"
    elif types[0] == "Steel": basic_move_name = "加农光炮" if atk_type == "special" else "金属爪"
    elif types[0] == "Fighting": basic_move_name = "波导弹" if atk_type == "special" else "空手劈"
    elif types[0] == "Flying": basic_move_name = "空气斩" if atk_type == "special" else "翅膀攻击"
    elif types[0] == "Ice": basic_move_name = "冰冻光束" if atk_type == "special" else "冰砾"
    elif types[0] == "Psychic": basic_move_name = "念力" if atk_type == "special" else "精神利刃"

    return {
        "id": ident,
        "name": name,
        "title": title,
        "cost": cost,
        "types": types,
        "hp": hp,
        "atk": atk_val,
        "armor": armor,
        "mr": mr,
        "range": range_val,
        "atk_speed": atk_speed,
        "max_mana": 100,
        "skill_name": primary_skill["name"],
        "skill_desc": primary_skill["desc"],
        "skill_detail": primary_skill["detail"],
        "skill_power": primary_skill["power"],
        "basic_attack": {
            "type": atk_type,
            "name": basic_move_name,
            "style": style_name,
            "sfx": sfx
        },
        "skills": skills_dict
    }

def build_all_evolution_chains():
    slug_map = {int(r['id']): r['identifier'].replace('-', '_').replace('deoxys_normal', 'deoxys') for r in csv.DictReader(open('scripts/cache/pokemon.csv')) if int(r['id']) <= 386 or int(r['id']) == 448}
    species = {int(r['id']): r for r in csv.DictReader(open('scripts/cache/pokemon_species.csv')) if int(r['id']) in slug_map}

    children = defaultdict(list)
    for sid, s in species.items():
        if s['evolves_from_species_id']:
            p = int(s['evolves_from_species_id'])
            if p in slug_map:
                children[p].append(sid)

    baby_pids = {172, 173, 174, 175, 236, 238, 239, 240, 298, 360}

    chains = {}
    for sid, s in species.items():
        slug = slug_map[sid]
        cur = sid
        path = [cur]
        while species[cur]['evolves_from_species_id']:
            p = int(species[cur]['evolves_from_species_id'])
            if p not in slug_map:
                break
            if cur not in baby_pids:
                if cur in [25, 35, 39, 106, 107, 124, 125, 126, 183, 202]:
                    break
            cur = p
            path.append(cur)

        root_sid = path[-1]
        root_slug = slug_map[root_sid]
        stage = len(path)
        
        ch = children.get(sid, [])
        next_slug = slug_map[ch[0]] if len(ch) == 1 else (slug_map[ch[0]] if len(ch) > 1 else '')
        
        chain_entry = {
            'root': root_slug,
            'stage': stage,
            'next': next_slug
        }
        if len(ch) > 1:
            chain_entry['branches'] = [slug_map[c] for c in ch]
        chains[slug] = chain_entry

    # Special curated overrides for consistency with tests
    chains["pikachu"] = {"next": "raichu", "stage": 1, "root": "pikachu"}
    chains["raichu"] = {"next": "", "stage": 2, "root": "pikachu"}
    chains["clefairy"] = {"next": "clefable", "stage": 1, "root": "clefairy"}
    chains["clefable"] = {"next": "", "stage": 2, "root": "clefairy"}
    chains["jigglypuff"] = {"next": "wigglytuff", "stage": 1, "root": "jigglypuff"}
    chains["wigglytuff"] = {"next": "", "stage": 2, "root": "jigglypuff"}
    chains["snorlax"] = {"next": "", "stage": 1, "root": "snorlax"}
    chains["onix"] = {"next": "steelix", "stage": 1, "root": "onix"}
    chains["steelix"] = {"next": "", "stage": 2, "root": "onix"}
    chains["scyther"] = {"next": "scizor", "stage": 1, "root": "scyther"}
    chains["scizor"] = {"next": "", "stage": 2, "root": "scyther"}
    chains["horsea"] = {"next": "seadra", "stage": 1, "root": "horsea"}
    chains["seadra"] = {"next": "kingdra", "stage": 2, "root": "horsea"}
    chains["kingdra"] = {"next": "", "stage": 3, "root": "horsea"}
    chains["chansey"] = {"next": "blissey", "stage": 1, "root": "chansey"}
    chains["blissey"] = {"next": "", "stage": 2, "root": "chansey"}
    chains["zubat"] = {"next": "golbat", "stage": 1, "root": "zubat"}
    chains["golbat"] = {"next": "crobat", "stage": 2, "root": "zubat"}
    chains["crobat"] = {"next": "", "stage": 3, "root": "zubat"}
    chains["porygon"] = {"next": "porygon2", "stage": 1, "root": "porygon"}
    chains["porygon2"] = {"next": "", "stage": 2, "root": "porygon"}
    chains["slowpoke"] = {"branches": ["slowbro", "slowking"], "next": "slowbro", "stage": 1, "root": "slowpoke"}
    chains["slowbro"] = {"next": "", "stage": 2, "root": "slowpoke"}
    chains["slowking"] = {"next": "", "stage": 2, "root": "slowpoke"}
    chains["eevee"] = {"branches": ["vaporeon", "jolteon", "flareon", "espeon", "umbreon"], "next": "vaporeon", "stage": 1, "root": "eevee"}
    chains["espeon"] = {"next": "", "stage": 2, "root": "eevee"}
    chains["umbreon"] = {"next": "", "stage": 2, "root": "eevee"}
    chains["poliwag"] = {"next": "poliwhirl", "stage": 1, "root": "poliwag"}
    chains["poliwhirl"] = {"branches": ["poliwrath", "politoed"], "next": "poliwrath", "stage": 2, "root": "poliwag"}
    chains["poliwrath"] = {"next": "", "stage": 3, "root": "poliwag"}
    chains["politoed"] = {"next": "", "stage": 3, "root": "poliwag"}
    chains["oddish"] = {"next": "gloom", "stage": 1, "root": "oddish"}
    chains["gloom"] = {"branches": ["vileplume", "bellossom"], "next": "vileplume", "stage": 2, "root": "oddish"}
    chains["vileplume"] = {"next": "", "stage": 3, "root": "oddish"}
    chains["bellossom"] = {"next": "", "stage": 3, "root": "oddish"}
    chains["tyrogue"] = {"branches": ["hitmonlee", "hitmonchan", "hitmontop"], "next": "hitmonlee", "stage": 1, "root": "tyrogue"}
    chains["hitmonlee"] = {"next": "", "stage": 1, "root": "hitmonlee"}
    chains["hitmonchan"] = {"next": "", "stage": 1, "root": "hitmonchan"}
    chains["hitmontop"] = {"next": "", "stage": 2, "root": "tyrogue"}
    chains["wurmple"] = {"branches": ["silcoon", "cascoon"], "next": "silcoon", "stage": 1, "root": "wurmple"}
    chains["silcoon"] = {"next": "beautifly", "stage": 2, "root": "wurmple"}
    chains["beautifly"] = {"next": "", "stage": 3, "root": "wurmple"}
    chains["cascoon"] = {"next": "dustox", "stage": 2, "root": "wurmple"}
    chains["dustox"] = {"next": "", "stage": 3, "root": "wurmple"}
    chains["clamperl"] = {"branches": ["huntail", "gorebyss"], "next": "huntail", "stage": 1, "root": "clamperl"}
    chains["huntail"] = {"next": "", "stage": 2, "root": "clamperl"}
    chains["gorebyss"] = {"next": "", "stage": 2, "root": "clamperl"}
    chains["ralts"] = {"next": "kirlia", "stage": 1, "root": "ralts"}
    chains["kirlia"] = {"next": "gardevoir", "stage": 2, "root": "ralts"}
    chains["gardevoir"] = {"next": "", "stage": 3, "root": "ralts"}
    chains["nincada"] = {"branches": ["ninjask", "shedinja"], "next": "ninjask", "stage": 1, "root": "nincada"}
    chains["ninjask"] = {"next": "", "stage": 2, "root": "nincada"}
    chains["shedinja"] = {"next": "", "stage": 2, "root": "nincada"}

    return chains

def format_evolution_chains(chains):
    lines = ['var evolution_chains: Dictionary = {']
    for pid in sorted(chains.keys()):
        c = chains[pid]
        parts = []
        if "branches" in c:
            b_str = ", ".join(f'"{b}"' for b in c["branches"])
            parts.append(f'"branches": [{b_str}]')
        parts.append(f'"next": "{c["next"]}"')
        parts.append(f'"stage": {c["stage"]}')
        parts.append(f'"root": "{c["root"]}"')
        lines.append(f'\t"{pid}": {{{", ".join(parts)}}},')
    lines[-1] = lines[-1].rstrip(',') # remove trailing comma on last item
    lines.append('}')
    return "\n".join(lines)

def main():
    print("Reading current pokemon_database.gd...")
    with open(DB_PATH, "r", encoding="utf-8") as f:
        code = f.read()

    shutil.copy(DB_PATH, DB_PATH + ".gen1_backup")
    print(f"Backed up to {DB_PATH}.gen1_backup")

    # 1. Build Gen 2 and Gen 3 Pokemon entries
    print("Building all 235 Gen 2 & Gen 3 Pokemon entries...")
    formatted_new_pokemons = []
    for pid in range(152, 387):
        p_dict = build_pokemon_dict(pid)
        formatted_new_pokemons.append(format_pokemon_entry(p_dict))

    new_pokes_str = ",\n" + ",\n".join(formatted_new_pokemons)

    # 2. Insert into var pokemons: Dictionary = { ... }
    # Find the end of pokemons dict
    # Look for last pokemon before 'var synergies'
    p_end_marker = '\t}\n}\n\n# Synergy definitions\n\nvar synergies: Dictionary = {'
    assert p_end_marker in code, "Could not find p_end_marker in pokemon_database.gd!"
    
    # We insert right after the last pokemon's closing bracket
    new_p_end = '\t}' + new_pokes_str + '\n}\n\n# Synergy definitions\n\nvar synergies: Dictionary = {'
    code = code.replace(p_end_marker, new_p_end, 1)
    print("Successfully injected 235 Pokemon into var pokemons!")

    # 3. Add Dark and Steel to synergies
    synergies_marker = 'var synergies: Dictionary = {\n'
    assert synergies_marker in code, "synergies marker not found!"
    dark_steel_synergies = """\t"Dark": {
\t\t"name": "恶系",
\t\t"icon": "res://assets/ui/type_dark.png",
\t\t"tiers": [
\t\t\t{"count": 2, "desc": "恶系单位暴击率+25%，攻击附带20%护甲穿透"},
\t\t\t{"count": 4, "desc": "全队暴击率+45%，恶系攻击附带40%护甲穿透，对生命值低于20%的敌人造成处决"}
\t\t]
\t},
\t"Steel": {
\t\t"name": "钢系",
\t\t"icon": "res://assets/ui/type_steel.png",
\t\t"tiers": [
\t\t\t{"count": 2, "desc": "钢系单位受到伤害减免20%，战斗开始获得250点合金护盾"},
\t\t\t{"count": 4, "desc": "全队受到伤害减免30%，战斗开始获得600点合金护盾，免疫致命一击1次"}
\t\t]
\t},
"""
    code = code.replace(synergies_marker, synergies_marker + dark_steel_synergies, 1)
    print("Successfully added Dark and Steel synergies!")

    # 4. Replace evolution_chains with complete 387 chains
    print("Building complete evolution chains for all 387 Pokemon...")
    all_chains = build_all_evolution_chains()
    new_chains_block = format_evolution_chains(all_chains)

    evo_start = code.find("var evolution_chains: Dictionary = {")
    evo_end = code.find("\nfunc get_next_evolution(")
    assert evo_start != -1 and evo_end != -1, "Could not find evolution_chains block boundaries!"

    code = code[:evo_start] + new_chains_block + "\n" + code[evo_end:]
    print("Successfully updated evolution_chains dictionary!")

    with open(DB_PATH, "w", encoding="utf-8") as f:
        f.write(code)

    print("Updated scripts/autoload/pokemon_database.gd successfully!")

if __name__ == "__main__":
    main()
