#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
build_gen4_data.py
Constructs canonical data for all 106 Gen 4 Pokemon (#387 ~ #493, except #448 Lucario):
- Stats (HP, Atk, Armor, MR, Range, AtkSpeed, Cost, Types)
- Chinese localized names & titles (genus)
- Basic attacks (physical / special, styles, sfx)
- 3-star branching skills (3 choices per star level = 9 skills per Pokemon)
- Guarantees 100% distinct Choice 0 VFX across star tiers, AND 9 mutually distinct VFX and names per Pokemon
- Saves to scripts/cache/gen4_pokemons.json
"""

import os
import re
import csv
import json
import sys
from collections import defaultdict

CACHE_DIR = "scripts/cache"
VFX_DIR = "assets/vfx"

sys.path.append("scripts")
from build_gen2_gen3_data import (
    TYPE_ID_MAP, TYPE_FALLBACK_TIERS, MOVE_NAME_TO_VFX,
    moves, slug_to_id, id_to_slug, names_zh, slug_to_zh, zh_to_slug,
    flavors_zh,
    build_skill_entry, get_sfx_for_vfx,
    get_basic_attack_style
)
from apply_gen2_gen3_to_database import TYPE_ARCHETYPE_MOVES

SPECIAL_SLUGS = {
    413: "wormadam",
    439: "mime_jr",
    474: "porygon_z",
    487: "giratina",
    492: "shaymin",
}

available_vfx = sorted(list({d for d in os.listdir(VFX_DIR) if os.path.exists(os.path.join(VFX_DIR, d, "frame_0.png"))}))

# 6. Load learnsets for Gen 4
pokemon_learnsets = defaultdict(list)
with open(os.path.join(CACHE_DIR, "pokemon_moves.csv"), "r", encoding="utf-8") as f:
    for row in csv.DictReader(f):
        pid = int(row["pokemon_id"])
        if 387 <= pid <= 493:
            mid = row["move_id"]
            if mid in id_to_slug:
                pokemon_learnsets[pid].append((
                    int(row["pokemon_move_method_id"]),
                    int(row["level"]),
                    id_to_slug[mid]
                ))

# 7. Species metadata
species_meta = {}
with open(os.path.join(CACHE_DIR, "pokemon_species.csv"), "r", encoding="utf-8") as f:
    for row in csv.DictReader(f):
        sid = int(row["id"])
        if 387 <= sid <= 493:
            species_meta[sid] = row

# 8. Chinese species names & titles
species_names = {}
species_genus = {}
with open(os.path.join(CACHE_DIR, "pokemon_species_names.csv"), "r", encoding="utf-8") as f:
    for row in csv.DictReader(f):
        sid = int(row["pokemon_species_id"])
        if 387 <= sid <= 493 and row["local_language_id"] == "12":
            species_names[sid] = row["name"]
            genus = row["genus"].replace("宝可梦", "").strip()
            species_genus[sid] = genus if genus else "宝可梦"

# 9. Pokemon types
pokemon_types = defaultdict(list)
with open(os.path.join(CACHE_DIR, "pokemon_types.csv"), "r", encoding="utf-8") as f:
    for row in csv.DictReader(f):
        pid = int(row["pokemon_id"])
        if 387 <= pid <= 493:
            tid = int(row["type_id"])
            pokemon_types[pid].append(TYPE_ID_MAP.get(tid, "Normal"))

# 10. Pokemon stats
pokemon_stats = defaultdict(dict)
with open(os.path.join(CACHE_DIR, "pokemon_stats.csv"), "r", encoding="utf-8") as f:
    for row in csv.DictReader(f):
        pid = int(row["pokemon_id"])
        if 387 <= pid <= 493:
            pokemon_stats[pid][int(row["stat_id"])] = int(row["base_stat"])

# 11. Pokemon slugs
pokemon_slugs = {}
with open(os.path.join(CACHE_DIR, "pokemon.csv"), "r", encoding="utf-8") as f:
    for row in csv.DictReader(f):
        pid = int(row["id"])
        if 387 <= pid <= 493:
            slug = SPECIAL_SLUGS.get(pid, row["identifier"]).replace("-", "_")
            pokemon_slugs[pid] = slug

def gen4_compute_cost_and_range(pid, s_meta, stats, types):
    bst = sum(stats.values())
    is_legendary = int(s_meta.get("is_legendary", 0)) == 1 or int(s_meta.get("is_mythical", 0)) == 1
    evolves_from = s_meta.get("evolves_from_species_id", "")
    has_evolves_from = bool(evolves_from)
    
    # Cost
    if is_legendary or bst >= 580:
        cost = 5
    elif bst >= 500:
        cost = 4
    elif bst >= 420:
        cost = 3
    elif bst >= 330 or has_evolves_from:
        cost = 2
    else:
        cost = 1
        
    # Range
    pri_type = types[0]
    is_ranged = pri_type in ["Water", "Grass", "Electric", "Psychic", "Ice", "Dragon", "Flying"]
    range_val = 3 if is_ranged else 1
    if pid in [462, 467, 468, 474]: # Magnezone, Magmortar, Togekiss, Porygon-Z
        range_val = 3
    return cost, range_val

def gen4_deduplicate_9_skills(pid, types):
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

    def pick_skill(candidates, star_lvl):
        for name in candidates:
            vfx = MOVE_NAME_TO_VFX.get(name)
            if vfx in available_vfx and name not in used_names and vfx not in used_vfx:
                used_names.add(name)
                used_vfx.add(vfx)
                slug = zh_to_slug.get(name, "tackle")
                return build_skill_entry(slug, star_lvl, vfx_override=vfx)
        
        # Fallback to unused VFX from archetype
        for pool in [TYPE_ARCHETYPE_MOVES.get(pri_type, []), TYPE_ARCHETYPE_MOVES.get(sec_type, []), TYPE_ARCHETYPE_MOVES["Normal"]]:
            for name in pool:
                vfx = MOVE_NAME_TO_VFX.get(name)
                if vfx in available_vfx and name not in used_names and vfx not in used_vfx:
                    used_names.add(name)
                    used_vfx.add(vfx)
                    slug = zh_to_slug.get(name, "tackle")
                    return build_skill_entry(slug, star_lvl, vfx_override=vfx)

        # Final fallback
        for vfx in available_vfx:
            if vfx not in used_vfx:
                dummy_name = f"{vfx}_{star_lvl}"
                used_names.add(dummy_name)
                used_vfx.add(vfx)
                return build_skill_entry("tackle", star_lvl, vfx_override=vfx)
        raise RuntimeError(f"Ran out of VFX for {pid}")

    all_cands = [n for n in known_names if n in MOVE_NAME_TO_VFX]
    pool_pri = TYPE_ARCHETYPE_MOVES.get(pri_type, [])
    pool_sec = TYPE_ARCHETYPE_MOVES.get(sec_type, [])
    pool_norm = TYPE_ARCHETYPE_MOVES["Normal"]

    skills = {1: [], 2: [], 3: []}
    for star in [1, 2, 3]:
        for c in range(3):
            entry = pick_skill(all_cands + pool_pri + pool_sec + pool_norm, star)
            skills[star].append(entry)

    assert len(used_names) == 9
    assert len(used_vfx) == 9
    return skills

def build_pokemon_dict(pid):
    ident = pokemon_slugs[pid]
    s_meta = species_meta[pid]
    name = species_names.get(pid, ident)
    title = species_genus.get(pid, "宝可梦")
    types = pokemon_types[pid]
    stats = pokemon_stats[pid]

    cost, range_val = gen4_compute_cost_and_range(pid, s_meta, stats, types)

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

    skills_dict = gen4_deduplicate_9_skills(pid, types)
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
        "skills": skills_dict,
        "icon": f"res://assets/units/{ident}.png"
    }

def main():
    print("Building Gen 4 Pokemon Database Entries (#387 ~ #493, except #448)...")
    all_gen4 = {}
    for pid in range(387, 494):
        if pid == 448:
            continue
        p_dict = build_pokemon_dict(pid)
        all_gen4[p_dict["id"]] = p_dict

    print(f"Built {len(all_gen4)} complete Gen 4 Pokemon definitions!")

    # Verify VFX differentiation test assertion on all 106
    for pid, pdata in all_gen4.items():
        vfx_list = [c["vfx"] for star in [1, 2, 3] for c in pdata["skills"][star]]
        name_list = [c["name"] for star in [1, 2, 3] for c in pdata["skills"][star]]
        assert len(set(vfx_list)) == 9, f"VFX not unique for {pid}: {vfx_list}"
        assert len(set(name_list)) == 9, f"Names not unique for {pid}: {name_list}"
        for v in vfx_list:
            assert v in available_vfx, f"VFX {v} not in available_vfx for {pid}"

    print("[SUCCESS] All 106 Gen 4 Pokemon passed 9-unique VFX & name tests!")

    out_file = os.path.join(CACHE_DIR, "gen4_pokemons.json")
    with open(out_file, "w", encoding="utf-8") as f:
        json.dump(all_gen4, f, ensure_ascii=False, indent=2)
    print(f"Saved to {out_file}")

if __name__ == '__main__':
    main()
