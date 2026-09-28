#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
generate_branching_skills.py
Generates 3 canonical skills per star level (1, 2, 3) for all 152 Pokemon (1,368 total skills)
and assigns authentic basic_attack (physical / special) definitions.
Preserves existing Choice 0 skills for 100% backward compatibility with test suites!
"""

import csv
import json
import os
import re
import sys

CACHE_DIR = "scripts/cache"
DB_PATH = "scripts/autoload/pokemon_database.gd"

sys.path.append("scripts")
from gen1_data import ALL_GEN1_POKEMON

def main():
    print("=== Loading Pokemon & Moves Official Data ===")
    
    # 1. Load moves.csv
    moves = {}
    with open(os.path.join(CACHE_DIR, "moves.csv"), "r", encoding="utf-8") as f:
        for row in csv.DictReader(f):
            moves[row["id"]] = {
                "id": row["id"],
                "slug": row["identifier"],
                "type_id": int(row["type_id"]),
                "power": int(row["power"]) if row["power"] else 0,
                "damage_class_id": int(row["damage_class_id"]) # 1: status, 2: physical, 3: special
            }
    slug_to_id = {m["slug"]: m["id"] for m in moves.values()}

    # 2. Load move_names.csv (zh-Hans = 12)
    names_zh = {}
    with open(os.path.join(CACHE_DIR, "move_names.csv"), "r", encoding="utf-8") as f:
        for row in csv.DictReader(f):
            if row["local_language_id"] == "12":
                names_zh[row["move_id"]] = row["name"]

    # 3. Load move_flavor_text.csv (zh-Hans = 12)
    flavors_zh = {}
    with open(os.path.join(CACHE_DIR, "move_flavor_text.csv"), "r", encoding="utf-8") as f:
        for row in csv.DictReader(f):
            if row["language_id"] == "12":
                mid = row["move_id"]
                vgid = int(row["version_group_id"])
                text = row["flavor_text"].replace("\n", "").replace("\r", "").strip()
                if "无法使用这个招式" in text or "忘记之后" in text:
                    continue
                if mid not in flavors_zh or vgid > flavors_zh[mid][0]:
                    flavors_zh[mid] = (vgid, text)

    # 4. Available authentic VFX in assets/vfx
    available_vfx = set(os.listdir("assets/vfx"))
    print(f"Loaded {len(moves)} moves, {len(names_zh)} names, {len(flavors_zh)} descriptions, {len(available_vfx)} VFX folders.")

    # 5. Type ID to Type Name mapping
    type_id_map = {
        1: "Normal", 2: "Fighting", 3: "Flying", 4: "Poison", 5: "Ground",
        6: "Rock", 7: "Bug", 8: "Ghost", 9: "Steel", 10: "Fire",
        11: "Water", 12: "Grass", 13: "Electric", 14: "Psychic",
        15: "Ice", 16: "Dragon", 17: "Dark", 18: "Fairy"
    }

    # 6. Load level-up moves for each Pokemon from pokemon_moves.csv
    print("Loading Pokemon learnsets from pokemon_moves.csv...")
    pokemon_learnsets = {} # pokedex_num -> list of (level, move_slug)
    with open(os.path.join(CACHE_DIR, "pokemon_moves.csv"), "r", encoding="utf-8") as f:
        for row in csv.DictReader(f):
            pnum = int(row["pokemon_id"])
            if pnum > 151 and pnum != 448:
                continue
            if row["pokemon_move_method_id"] == "1": # level up
                mid = row["move_id"]
                if mid in moves:
                    lvl = int(row["level"])
                    m_slug = moves[mid]["slug"]
                    if pnum not in pokemon_learnsets:
                        pokemon_learnsets[pnum] = []
                    pokemon_learnsets[pnum].append((lvl, m_slug))

    # Sort each learnset by level
    for pnum in pokemon_learnsets:
        # unique while preserving level order
        seen = set()
        deduped = []
        for lvl, m_slug in sorted(pokemon_learnsets[pnum], key=lambda x: x[0]):
            if m_slug not in seen:
                seen.add(m_slug)
                deduped.append((lvl, m_slug))
        pokemon_learnsets[pnum] = deduped

    # Helper: VFX mapping
    def get_vfx_for_move(slug, m_type, damage_class):
        direct_slug_map = {
            "thunder-shock": "thundershock", "thunderbolt": "thunderbolt", "thunder": "thunder",
            "discharge": "discharge", "thunder-punch": "thunder_punch", "10-000-000-volt-thunderbolt": "volt_catastrophe",
            "spark": "thundershock", "electro-ball": "discharge", "volt-switch": "discharge", "wild-charge": "thundershock",
            "ember": "ember", "flamethrower": "flamethrower", "fire-blast": "fire_blast",
            "flame-wheel": "flame_wheel", "blast-burn": "blast_burn", "fire-punch": "fire_punch",
            "fire-fang": "fire_fang", "flare-blitz": "flare_blitz", "inferno": "inferno", "heat-wave": "flame_wheel",
            "water-gun": "water_gun", "hydro-pump": "hydro_pump", "hydro-cannon": "hydro_cannon",
            "crabhammer": "crabhammer", "water-pulse": "hydro_pump", "surf": "hydro_tempest", "bubble-beam": "water_gun", "aqua-jet": "water_gun",
            "leech-seed": "leech_seed", "razor-leaf": "razor_leaf", "frenzy-plant": "frenzy_plant",
            "vine-whip": "leech_seed", "power-whip": "frenzy_plant", "solar-beam": "hyper_beam", "seed-bomb": "razor_leaf", "giga-drain": "leech_seed",
            "ice-shard": "ice_shard", "ice-beam": "ice_beam", "blizzard": "blizzard", "aurora-beam": "aurora_beam", "sheer-cold": "sheer_cold", "ice-punch": "ice_shard",
            "confusion": "confusion", "psybeam": "psybeam", "psychic": "psychic", "psystrike": "psystrike", "future-sight": "future_sight",
            "shadow-ball": "shadow_ball", "shadow-punch": "shadow_punch", "lick": "lick", "hex": "hex_nightmare",
            "sludge-bomb": "sludge_bomb", "poison-sting": "poison_sting", "gunk-shot": "gunk_shot", "poison-jab": "poison_sting", "acid": "sludge_bomb",
            "air-slash": "air_slash", "drill-peck": "drill_peck", "brave-bird": "brave_bird", "gust": "twister", "hurricane": "twister", "wing-attack": "air_slash", "aerial-ace": "air_slash",
            "rock-slide": "rock_slide", "stone-edge": "stone_edge", "earthquake": "earthquake", "ancient-power": "ancient_power", "rollout": "rock_slide",
            "quick-attack": "quick_attack", "slash": "slash", "body-slam": "body_slam", "swift": "swift", "tackle": "quick_attack", "headbutt": "body_slam",
            "hyper-beam": "hyper_beam", "giga-impact": "giga_impact", "tri-attack": "tri_attack", "double-edge": "body_slam", "mega-punch": "dynamic_punch", "mega-kick": "dynamic_punch",
            "aura-sphere": "aura_sphere", "close-combat": "close_combat", "cross-chop": "cross_chop",
            "dynamic-punch": "dynamic_punch", "force-palm": "force_palm", "low-kick": "low_kick", "karate-chop": "cross_chop", "seismic-toss": "dynamic_punch",
            "bone-rush": "bone_rush", "bonemerang": "bonemerang", "dragon-claw": "dragon_claw",
            "dragon-pulse": "dragon_pulse", "dragon-breath": "dragon_breath", "draco-meteor": "draco_meteor", "outrage": "dragon_apocalypse"
        }
        if slug in direct_slug_map and direct_slug_map[slug] in available_vfx:
            return direct_slug_map[slug]

        type_vfx_fallbacks = {
            "Electric": ["thundershock", "thunderbolt", "discharge", "thunder"],
            "Fire": ["ember", "flamethrower", "fire_blast", "inferno"],
            "Water": ["water_gun", "hydro_pump", "hydro_cannon", "hydro_tempest"],
            "Grass": ["leech_seed", "razor_leaf", "frenzy_plant"],
            "Ice": ["ice_shard", "aurora_beam", "ice_beam", "blizzard"],
            "Psychic": ["confusion", "psybeam", "psychic", "psystrike"],
            "Ghost": ["lick", "shadow_punch", "shadow_ball", "hex_nightmare"],
            "Poison": ["poison_sting", "sludge_bomb", "gunk_shot"],
            "Flying": ["air_slash", "drill_peck", "brave_bird", "twister"],
            "Rock": ["rock_slide", "stone_edge", "ancient_power"],
            "Ground": ["earthquake", "rock_slide", "bone_rush"],
            "Fighting": ["low_kick", "dynamic_punch", "cross_chop", "close_combat"],
            "Dragon": ["dragon_claw", "dragon_breath", "dragon_pulse", "draco_meteor"],
            "Normal": ["quick_attack", "slash", "body_slam", "hyper_beam"]
        }
        fallbacks = type_vfx_fallbacks.get(m_type, ["body_slam", "slash", "swift"])
        return fallbacks[0]

    def get_sfx_for_vfx(vfx_name, m_type):
        if "fire" in vfx_name or "ember" in vfx_name or "blast" in vfx_name:
            return "fire"
        if "water" in vfx_name or "hydro" in vfx_name or "ice" in vfx_name or "blizzard" in vfx_name:
            return "water"
        if "thunder" in vfx_name or "spark" in vfx_name or "volt" in vfx_name or "discharge" in vfx_name:
            return "thunder"
        if "slash" in vfx_name or "claw" in vfx_name or "cut" in vfx_name:
            return "slash"
        if "punch" in vfx_name or "kick" in vfx_name or "chop" in vfx_name:
            return "punch"
        if "bite" in vfx_name or "fang" in vfx_name:
            return "bite"
        return "skill"

    # Helper: Build single skill dictionary
    def make_skill_dict(slug, star_level, vfx_override=None, power_override=None, desc_override=None, fallback_name=None):
        mid = slug_to_id.get(slug)
        m = moves.get(mid, {}) if mid else {}
        name = names_zh.get(mid, fallback_name or slug.replace("-", " ").title())
        desc = desc_override or (flavors_zh.get(mid, (0, f"使出【{name}】全力攻击敌人。"))[1] if mid else f"使出【{name}】全力攻击敌人。")
        m_type = type_id_map.get(m.get("type_id", 1), "Normal")
        damage_class = m.get("damage_class_id", 2)
        vfx = vfx_override or get_vfx_for_move(slug, m_type, damage_class)
        sfx = get_sfx_for_vfx(vfx, m_type)

        if star_level == 1:
            base_p = m.get("power", 0)
            power = power_override or (base_p * 2 + 100 if base_p > 0 else 180)
            target_count = 1 if damage_class == 2 else 2
            stun_dur = 0.0
            scale = 0.82
            detail = f"消耗100能量，使出【{name}】。{desc} 对目标造成{power}点伤害。"
        elif star_level == 2:
            base_p = m.get("power", 0)
            power = power_override or (base_p * 3 + 120 if base_p > 0 else 320)
            target_count = 2 if damage_class == 2 else 3
            stun_dur = 0.4
            scale = 1.10
            detail = f"消耗100能量，爆发【{name}】！{desc} 对范围内最多{target_count}名敌人造成{power}点伤害，并施加战术压制。"
        else: # 3
            base_p = m.get("power", 0)
            power = power_override or (base_p * 5 + 180 if base_p > 0 else 680)
            target_count = 4 if damage_class == 2 else 6
            stun_dur = 0.8
            scale = 1.55
            detail = f"消耗100能量，释放终极奥义【{name}】！{desc} 席卷战场对最多{target_count}名敌人造成{power}点巨额伤害与强力击破！"

        return {
            "name": name,
            "desc": desc,
            "detail": detail,
            "power": power,
            "target_count": target_count,
            "stun_duration": stun_dur,
            "vfx": vfx,
            "sfx": sfx,
            "scale": scale
        }

    # Archetype pool for fallback
    THEME_FALLBACKS = {
        "Fire": {
            1: [("ember", "ember"), ("flame-wheel", "flame_wheel"), ("fire-spin", "flame_wheel")],
            2: [("flamethrower", "flamethrower"), ("fire-punch", "fire_punch"), ("heat-wave", "flame_wheel")],
            3: [("fire-blast", "fire_blast"), ("inferno", "inferno"), ("blast-burn", "blast_burn")]
        },
        "Water": {
            1: [("water-gun", "water_gun"), ("water-pulse", "hydro_pump"), ("aqua-jet", "water_gun")],
            2: [("hydro-pump", "hydro_pump"), ("surf", "hydro_tempest"), ("crabhammer", "crabhammer")],
            3: [("hydro-cannon", "hydro_cannon"), ("hydro-tempest", "hydro_tempest"), ("origin-pulse", "hydro_cannon")]
        },
        "Grass": {
            1: [("leech-seed", "leech_seed"), ("vine-whip", "leech_seed"), ("mega-drain", "leech_seed")],
            2: [("razor-leaf", "razor_leaf"), ("seed-bomb", "razor_leaf"), ("giga-drain", "leech_seed")],
            3: [("frenzy-plant", "frenzy_plant"), ("solar-beam", "hyper_beam"), ("leaf-storm", "frenzy_plant")]
        },
        "Electric": {
            1: [("thunder-shock", "thundershock"), ("spark", "thundershock"), ("charge-beam", "thundershock")],
            2: [("thunderbolt", "thunderbolt"), ("discharge", "discharge"), ("thunder-punch", "thunder_punch")],
            3: [("thunder", "thunder"), ("10-000-000-volt-thunderbolt", "volt_catastrophe"), ("thunder-tempest", "thunder_tempest")]
        },
        "Psychic": {
            1: [("confusion", "confusion"), ("psybeam", "psybeam"), ("psywave", "confusion")],
            2: [("psychic", "psychic"), ("psycho-cut", "psycho_cut"), ("zen-headbutt", "zen_headbutt")],
            3: [("psystrike", "psystrike"), ("future-sight", "future_sight"), ("psychokinesis", "psychokinesis")]
        },
        "Fighting": {
            1: [("low-kick", "low_kick"), ("mach-punch", "dynamic_punch"), ("rock-smash", "punch")],
            2: [("force-palm", "force_palm"), ("cross-chop", "cross_chop"), ("dynamic-punch", "dynamic_punch")],
            3: [("close-combat", "close_combat"), ("superpower", "dynamic_punch"), ("aura-storm", "aura_storm")]
        },
        "Normal": {
            1: [("quick-attack", "quick_attack"), ("tackle", "quick_attack"), ("headbutt", "body_slam")],
            2: [("slash", "slash"), ("body-slam", "body_slam"), ("swift", "swift")],
            3: [("hyper-beam", "hyper_beam"), ("giga-impact", "giga_impact"), ("double-edge", "giga_impact")]
        },
        "Poison": {
            1: [("poison-sting", "poison_sting"), ("acid", "sludge_bomb"), ("smog", "sludge_bomb")],
            2: [("sludge-bomb", "sludge_bomb"), ("poison-jab", "poison_sting"), ("cross-poison", "poison_sting")],
            3: [("gunk-shot", "gunk_shot"), ("acid-armor", "acid_armor"), ("toxic", "sludge_bomb")]
        },
        "Ground": {
            1: [("mud-slap", "rock_slide"), ("bone-club", "bone_rush"), ("bulldoze", "earthquake")],
            2: [("bone-rush", "bone_rush"), ("dig", "earthquake"), ("drill-run", "drill_peck")],
            3: [("earthquake", "earthquake"), ("bonemerang", "bonemerang"), ("stone-edge", "stone_edge")]
        },
        "Rock": {
            1: [("rock-throw", "rock_slide"), ("rollout", "rock_slide"), ("rock-tomb", "rock_slide")],
            2: [("rock-slide", "rock_slide"), ("ancient-power", "ancient_power"), ("power-gem", "ancient_power")],
            3: [("stone-edge", "stone_edge"), ("head-smash", "giga_impact"), ("draco-meteor", "draco_meteor")]
        },
        "Flying": {
            1: [("gust", "twister"), ("peck", "air_slash"), ("wing-attack", "air_slash")],
            2: [("aerial-ace", "air_slash"), ("air-cutter", "air_slash"), ("drill-peck", "drill_peck")],
            3: [("brave-bird", "brave_bird"), ("hurricane", "twister"), ("air-slash", "air_slash")]
        },
        "Bug": {
            1: [("bug-bite", "slash"), ("string-shot", "pin_missile"), ("struggle-bug", "pin_missile")],
            2: [("x-scissor", "slash"), ("pin-missile", "pin_missile"), ("signal-beam", "psybeam")],
            3: [("bug-buzz", "pin_missile"), ("megahorn", "giga_impact"), ("quiver-dance", "swift")]
        },
        "Ghost": {
            1: [("lick", "lick"), ("astonish", "lick"), ("night-shade", "shadow_ball")],
            2: [("shadow-punch", "shadow_punch"), ("hex", "hex_nightmare"), ("ominous-wind", "twister")],
            3: [("shadow-ball", "shadow_ball"), ("hex-nightmare", "hex_nightmare"), ("destiny-bond", "hex_nightmare")]
        },
        "Dragon": {
            1: [("twister", "twister"), ("dragon-breath", "dragon_breath"), ("dragon-rage", "dragon_breath")],
            2: [("dragon-claw", "dragon_claw"), ("dragon-pulse", "dragon_pulse"), ("dragon-tail", "dragon_claw")],
            3: [("draco-meteor", "draco_meteor"), ("outrage", "dragon_apocalypse"), ("dragon-apocalypse", "dragon_apocalypse")]
        },
        "Ice": {
            1: [("powder-snow", "ice_shard"), ("ice-shard", "ice_shard"), ("icy-wind", "blizzard")],
            2: [("aurora-beam", "aurora_beam"), ("ice-beam", "ice_beam"), ("icicle-crash", "ice_shard")],
            3: [("blizzard", "blizzard"), ("sheer-cold", "sheer_cold"), ("glacial-lance", "ice_beam")]
        }
    }

    # Basic attack classification
    def classify_basic_attack(pid, p_data):
        types = p_data.get("types", ["Normal"])
        primary_type = types[0] if types else "Normal"
        p_range = p_data.get("range", 1)

        if pid in ["pikachu", "charmander", "squirtle", "gengar", "alakazam", "mewtwo", "psyduck", "lapras", "vulpix", "ninetales", "magnemite", "magneton", "voltorb", "electrode", "koffing", "weezing", "horsea", "seadra", "staryu", "starmie", "jynx", "magmar", "porygon", "omanyte", "omastar", "articuno", "zapdos", "moltres", "dragonair", "mew", "butterfree", "venomoth", "clefairy", "clefable", "gastly", "haunter"]:
            atk_type = "special"
        elif pid in ["lucario", "machop", "machoke", "machamp", "snorlax", "hitmonlee", "hitmonchan", "scyther", "pinsir", "sandshrew", "sandslash", "beedrill", "rattata", "raticate", "ekans", "arbok", "mankey", "primeape", "geodude", "graveler", "golem", "onix", "cubone", "marowak", "rhyhorn", "rhydon", "tauros", "gyarados", "aerodactyl", "kabutops", "dragonite"]:
            atk_type = "physical"
        else:
            atk_type = "special" if p_range >= 2 else "physical"

        if atk_type == "physical":
            if pid in ["gyarados", "growlithe", "arcanine", "arbok", "ekans", "zubat", "golbat"]:
                name = "咬住"
                style = "bite"
                sfx = "bite"
            elif pid in ["scyther", "kabutops", "charizard", "sandslash", "persian", "meowth", "zangoose", "gengar", "paras", "parasect", "farfetchd"]:
                name = "抓击"
                style = "slash"
                sfx = "slash"
            elif pid in ["machop", "machoke", "machamp", "hitmonchan", "electabuzz", "snorlax", "lucario", "polywrath", "primeape", "mankey", "kangaskhan"]:
                name = "连续拳"
                style = "punch"
                sfx = "punch"
            else:
                name = "撞击"
                style = "tackle"
                sfx = "attack"
        else: # special
            if primary_type == "Fire":
                name = "火花"
                style = "fire_ember"
                sfx = "fire"
            elif primary_type == "Water":
                name = "水滴弹"
                style = "water_bullet"
                sfx = "water"
            elif primary_type == "Electric":
                name = "电火花"
                style = "spark"
                sfx = "spark"
            elif primary_type == "Grass":
                name = "飞叶"
                style = "leaf"
                sfx = "swift"
            elif primary_type in ["Psychic", "Ghost"]:
                name = "念力波" if primary_type == "Psychic" else "暗影弹"
                style = "psywave" if primary_type == "Psychic" else "shadow_orb"
                sfx = "swift"
            elif primary_type == "Ice":
                name = "细雪"
                style = "spark"
                sfx = "water"
            elif primary_type == "Poison":
                name = "毒液飞弹"
                style = "water_bullet"
                sfx = "swift"
            else:
                name = "魔法弹"
                style = "spark"
                sfx = "swift"

        return {
            "type": atk_type,
            "name": name,
            "style": style,
            "sfx": sfx
        }

    # Read clean DB backup
    with open("scripts/autoload/pokemon_database.gd.phase1_bak", "r", encoding="utf-8") as f:
        db_content = f.read()

    parts = db_content.split("var synergies: Dictionary = {")
    pokemons_part = parts[0]
    synergies_part = parts[1]

    matches = list(re.finditer(r"^\t\"([a-z0-9_-]+)\": \{$", pokemons_part, re.MULTILINE))
    print(f"Parsed {len(matches)} Pokemon blocks from DB pokemons_part.")

    pokemon_blocks = {}
    for i, m in enumerate(matches):
        pid = m.group(1)
        start = m.start()
        end = matches[i+1].start() if i+1 < len(matches) else pokemons_part.rfind("}")
        raw_block = pokemons_part[start:end].strip()
        if raw_block.endswith(","):
            raw_block = raw_block[:-1].strip()
        # body is without the enclosing \t"pid": {\n ... \n\t}
        first_brace = raw_block.find("{\n")
        last_brace = raw_block.rfind("\n\t}")
        body = raw_block[first_brace+2:last_brace]
        pokemon_blocks[pid] = (raw_block, body)

    # Process each Pokemon
    modified_blocks = {}
    for pid, (full_block, body) in pokemon_blocks.items():
        # Get pokemon number
        if pid == "lucario":
            pnum = 448
        elif pid in ALL_GEN1_POKEMON:
            pnum = ALL_GEN1_POKEMON[pid]["num"]
        else:
            pnum = 1

        # Extract basic fields: types, cost, range
        types_m = re.search(r'"types":\s*\[([^\]]+)\]', body)
        types = [t.strip().strip('"').strip("'") for t in types_m.group(1).split(",")] if types_m else ["Normal"]
        primary_type = types[0] if types else "Normal"
        
        range_m = re.search(r'"range":\s*(\d+)', body)
        p_range = int(range_m.group(1)) if range_m else 1

        p_info = {"types": types, "range": p_range}

        # 1. Generate basic_attack
        b_atk = classify_basic_attack(pid, p_info)

        # 2. Extract existing skills 1, 2, 3 as choice 0
        # Check existing skills
        # We can extract existing star 1, 2, 3 dictionaries
        choice_0_skills = {}
        for star in [1, 2, 3]:
            star_m = re.search(r'\t\t\t%d:\s*\{([\s\S]*?)\n\t\t\t\}' % star, body)
            if star_m:
                s_body = star_m.group(1)
                def get_val(key, default=""):
                    km = re.search(r'"%s":\s*([^\n,]+)' % key, s_body)
                    if km:
                        val = km.group(1).strip()
                        if val.startswith('"') and val.endswith('"'):
                            return val[1:-1]
                        try:
                            if "." in val:
                                return float(val)
                            return int(val)
                        except:
                            return val
                    return default
                choice_0_skills[star] = {
                    "name": get_val("name"),
                    "desc": get_val("desc"),
                    "detail": get_val("detail"),
                    "power": get_val("power", 200),
                    "target_count": get_val("target_count", 2),
                    "stun_duration": get_val("stun_duration", 0.0),
                    "vfx": get_val("vfx", "thunderbolt"),
                    "sfx": get_val("sfx", "skill"),
                    "scale": get_val("scale", 0.4)
                }
            else:
                # Fallback if not found
                theme_c = THEME_FALLBACKS.get(primary_type, THEME_FALLBACKS["Normal"])[star][0]
                choice_0_skills[star] = make_skill_dict(theme_c[0], star, vfx_override=theme_c[1])

        # 3. Generate choice 1 and choice 2 for each star tier
        # From learnsets and THEME_FALLBACKS
        learnset = pokemon_learnsets.get(pnum, [])
        combat_learnset = []
        for lvl, m_slug in learnset:
            mid = slug_to_id.get(m_slug)
            if mid and (moves[mid]["power"] > 0 or moves[mid]["damage_class_id"] in [2, 3]):
                combat_learnset.append((lvl, m_slug))
        effective_learnset = combat_learnset if len(combat_learnset) >= 4 else learnset

        tier1_cands = [m[1] for m in effective_learnset if m[0] <= 22]
        tier2_cands = [m[1] for m in effective_learnset if 18 <= m[0] <= 40]
        tier3_cands = [m[1] for m in effective_learnset if m[0] >= 32]

        star_branch_skills = {}
        for star in [1, 2, 3]:
            c0 = choice_0_skills[star]
            c0_name = c0["name"]
            existing_names = {c0_name}
            existing_vfx = {c0["vfx"]}

            # Candidate pool for this star
            pool = tier1_cands if star == 1 else (tier2_cands if star == 2 else tier3_cands)
            theme_pool = THEME_FALLBACKS.get(primary_type, THEME_FALLBACKS["Normal"])[star]

            choices = [c0]

            # Find choice 1
            choice_1 = None
            for cand_slug in pool:
                mid = slug_to_id.get(cand_slug)
                mname = names_zh.get(mid)
                if mname and mname not in existing_names:
                    s_dict = make_skill_dict(cand_slug, star)
                    if s_dict["name"] not in existing_names:
                        choice_1 = s_dict
                        existing_names.add(s_dict["name"])
                        break
            if not choice_1:
                for theme_slug, theme_vfx in theme_pool:
                    mid = slug_to_id.get(theme_slug)
                    mname = names_zh.get(mid)
                    if mname and mname not in existing_names:
                        s_dict = make_skill_dict(theme_slug, star, vfx_override=theme_vfx)
                        if s_dict["name"] not in existing_names:
                            choice_1 = s_dict
                            existing_names.add(s_dict["name"])
                            break
            if not choice_1:
                choice_1 = make_skill_dict("quick-attack" if star == 1 else ("slash" if star == 2 else "hyper-beam"), star)
                existing_names.add(choice_1["name"])
            choices.append(choice_1)

            # Find choice 2
            choice_2 = None
            for cand_slug in reversed(pool):
                mid = slug_to_id.get(cand_slug)
                mname = names_zh.get(mid)
                if mname and mname not in existing_names:
                    s_dict = make_skill_dict(cand_slug, star)
                    if s_dict["name"] not in existing_names:
                        choice_2 = s_dict
                        existing_names.add(s_dict["name"])
                        break
            if not choice_2:
                for theme_slug, theme_vfx in reversed(theme_pool):
                    mid = slug_to_id.get(theme_slug)
                    mname = names_zh.get(mid)
                    if mname and mname not in existing_names:
                        s_dict = make_skill_dict(theme_slug, star, vfx_override=theme_vfx)
                        if s_dict["name"] not in existing_names:
                            choice_2 = s_dict
                            existing_names.add(s_dict["name"])
                            break
            if not choice_2:
                choice_2 = make_skill_dict("swift" if star <= 2 else "giga-impact", star)
            choices.append(choice_2)

            star_branch_skills[star] = choices

        # 4. Construct updated GDScript block for this Pokemon
        # Preserve header lines up to "skills": {
        lines = body.split("\n")
        header_lines = []
        for line in lines:
            if line.strip().startswith('"skills":'):
                break
            header_lines.append(line)

        # Build GDScript code for basic_attack
        basic_atk_gd = (
            '\t\t"basic_attack": {\n'
            '\t\t\t"type": "%s",\n'
            '\t\t\t"name": "%s",\n'
            '\t\t\t"style": "%s",\n'
            '\t\t\t"sfx": "%s"\n'
            '\t\t},' % (b_atk["type"], b_atk["name"], b_atk["style"], b_atk["sfx"])
        )

        # Build GDScript code for skills: { 1: [...], 2: [...], 3: [...] }
        skills_gd_parts = ['\t\t"skills": {']
        for star in [1, 2, 3]:
            skills_gd_parts.append('\t\t\t%d: [' % star)
            for s_idx, s in enumerate(star_branch_skills[star]):
                desc_escaped = s["desc"].replace('"', '\\"')
                detail_escaped = s["detail"].replace('"', '\\"')
                s_part = (
                    '\t\t\t\t{\n'
                    '\t\t\t\t\t"name": "%s",\n'
                    '\t\t\t\t\t"desc": "%s",\n'
                    '\t\t\t\t\t"detail": "%s",\n'
                    '\t\t\t\t\t"power": %d,\n'
                    '\t\t\t\t\t"target_count": %d,\n'
                    '\t\t\t\t\t"stun_duration": %.1f,\n'
                    '\t\t\t\t\t"vfx": "%s",\n'
                    '\t\t\t\t\t"sfx": "%s",\n'
                    '\t\t\t\t\t"scale": %.2f\n'
                    '\t\t\t\t}%s' % (
                        s["name"], desc_escaped, detail_escaped,
                        int(s["power"]), int(s["target_count"]), float(s["stun_duration"]),
                        s["vfx"], s["sfx"], float(s["scale"]),
                        "," if s_idx < 2 else ""
                    )
                )
                skills_gd_parts.append(s_part)
            skills_gd_parts.append('\t\t\t]%s' % ("," if star < 3 else ""))
        skills_gd_parts.append('\t\t},')

        # Combine into complete new body
        # Insert basic_attack before skills
        new_body = "\n".join(header_lines) + "\n" + basic_atk_gd + "\n" + "\n".join(skills_gd_parts) + '\n\t\t"icon": "res://assets/units/%s.png"' % pid
        new_block = '\t"%s": {\n%s\n\t}' % (pid, new_body)
        modified_blocks[pid] = new_block

    print("Rebuilding full pokemon_database.gd...")

    new_blocks_list = [modified_blocks[m.group(1)] for m in matches]
    new_pokemons_code = (
        "extends Node\n\n"
        "# PokemonDatabase: Central repository of all Pokemon stats, skills, and synergy definitions\n\n"
        "var pokemons: Dictionary = {\n"
        + ",\n".join(new_blocks_list)
        + "\n}\n\n# Synergy definitions\n\n"
    )

    new_after = "var synergies: Dictionary = {" + synergies_part

    # Now update get_skill_data, and add get_skill_choices, get_basic_attack, and get_sprite_frames
    helpers_code = '''func get_skill_data(pokemon_id: String, star_level: int = 1, choice_idx: int = 0) -> Dictionary:
	var data = get_pokemon(pokemon_id)
	if data.is_empty():
		return {}
	if data.has("skills") and data["skills"].has(star_level):
		var star_skills = data["skills"][star_level]
		if star_skills is Array:
			if choice_idx >= 0 and choice_idx < star_skills.size():
				return star_skills[choice_idx].duplicate(true)
			elif star_skills.size() > 0:
				return star_skills[0].duplicate(true)
		elif star_skills is Dictionary:
			return star_skills.duplicate(true)
	return {
		"name": data.get("skill_name", ""),
		"desc": data.get("skill_desc", ""),
		"detail": data.get("skill_detail", ""),
		"power": data.get("skill_power", 200),
		"vfx": "thunderbolt",
		"sfx": "skill",
		"scale": 0.4
	}

func get_skill_choices(pokemon_id: String, star_level: int = 1) -> Array:
	var data = get_pokemon(pokemon_id)
	if data.is_empty() or not data.has("skills"):
		return []
	if data["skills"].has(star_level):
		var s = data["skills"][star_level]
		if s is Array:
			return s.duplicate(true)
		elif s is Dictionary:
			return [s.duplicate(true)]
	return []

func get_basic_attack(pokemon_id: String) -> Dictionary:
	var data = get_pokemon(pokemon_id)
	if data.has("basic_attack"):
		return data["basic_attack"].duplicate(true)
	var is_ranged = data.get("range", 1) >= 2
	return {
		"type": "special" if is_ranged else "physical",
		"name": "普通攻击",
		"style": "spark" if is_ranged else "punch",
		"sfx": "swift" if is_ranged else "attack"
	}
'''

    # Replace old get_skill_data with helpers_code in new_after
    old_get_skill_pattern = re.compile(r'func get_skill_data\(pokemon_id: String, star_level: int = 1\) -> Dictionary:[\s\S]*?return \{\n\t\t"name": data\.get\("skill_name", ""\),[\s\S]*?\}\n')
    if old_get_skill_pattern.search(new_after):
        new_after = old_get_skill_pattern.sub(helpers_code, new_after, count=1)
        print("Updated get_skill_data & added get_skill_choices, get_basic_attack.")
    else:
        print("Warning: old get_skill_data pattern did not match directly, checking...")

    # Update get_sprite_frames to load attack_physical, attack_special, cast_skill
    new_sprite_frames_func = '''func get_sprite_frames(pokemon_id: String) -> SpriteFrames:
	if cached_sprite_frames.has(pokemon_id):
		return cached_sprite_frames[pokemon_id]
		
	var sf = SpriteFrames.new()
	var base_dir = "res://assets/units/anim/%s" % pokemon_id
	
	# 1. Idle animation
	sf.add_animation("idle")
	sf.set_animation_loop("idle", true)
	sf.set_animation_speed("idle", 3.0)
	var idle_path = "%s/idle.png" % base_dir
	if ResourceLoader.exists(idle_path):
		sf.add_frame("idle", load(idle_path))
	elif ResourceLoader.exists("%s/walk_0.png" % base_dir):
		sf.add_frame("idle", load("%s/walk_0.png" % base_dir))
		
	var expected_size = Vector2.ZERO
	if sf.get_frame_count("idle") > 0:
		var idle_tex = sf.get_frame_texture("idle", 0)
		if idle_tex:
			expected_size = idle_tex.get_size()
		
	# 2. Walk animation (up to 6 uniform frames)
	sf.add_animation("walk")
	sf.set_animation_loop("walk", true)
	sf.set_animation_speed("walk", 8.0)
	for w_idx in range(6):
		var w_path = "%s/walk_%d.png" % [base_dir, w_idx]
		if ResourceLoader.exists(w_path):
			var tex = load(w_path) as Texture2D
			if tex and (expected_size == Vector2.ZERO or tex.get_size() == expected_size):
				sf.add_frame("walk", tex)
	if sf.get_frame_count("walk") == 0 and sf.get_frame_count("idle") > 0:
		sf.add_frame("walk", sf.get_frame_texture("idle", 0))
		
	# 3. Attack animation (up to 6 uniform frames)
	sf.add_animation("attack")
	sf.set_animation_loop("attack", false)
	sf.set_animation_speed("attack", 14.0)
	for a_idx in range(6):
		var a_path = "%s/attack_%d.png" % [base_dir, a_idx]
		if ResourceLoader.exists(a_path):
			var tex = load(a_path) as Texture2D
			if tex and (expected_size == Vector2.ZERO or tex.get_size() == expected_size):
				sf.add_frame("attack", tex)
	if sf.get_frame_count("attack") == 0 and sf.get_frame_count("idle") > 0:
		sf.add_frame("attack", sf.get_frame_texture("idle", 0))

	# 3.1 Physical Attack animation (up to 6 uniform frames)
	sf.add_animation("attack_physical")
	sf.set_animation_loop("attack_physical", false)
	sf.set_animation_speed("attack_physical", 14.0)
	for p_idx in range(6):
		var p_path = "%s/attack_physical_%d.png" % [base_dir, p_idx]
		if ResourceLoader.exists(p_path):
			var tex = load(p_path) as Texture2D
			if tex and (expected_size == Vector2.ZERO or tex.get_size() == expected_size):
				sf.add_frame("attack_physical", tex)
	if sf.get_frame_count("attack_physical") == 0:
		for i in range(sf.get_frame_count("attack")):
			sf.add_frame("attack_physical", sf.get_frame_texture("attack", i))

	# 3.2 Special Attack animation (up to 6 uniform frames)
	sf.add_animation("attack_special")
	sf.set_animation_loop("attack_special", false)
	sf.set_animation_speed("attack_special", 14.0)
	for s_idx in range(6):
		var s_path = "%s/attack_special_%d.png" % [base_dir, s_idx]
		if ResourceLoader.exists(s_path):
			var tex = load(s_path) as Texture2D
			if tex and (expected_size == Vector2.ZERO or tex.get_size() == expected_size):
				sf.add_frame("attack_special", tex)
	if sf.get_frame_count("attack_special") == 0:
		for i in range(sf.get_frame_count("attack")):
			sf.add_frame("attack_special", sf.get_frame_texture("attack", i))

	# 3.3 Skill Cast animation (up to 6 uniform frames)
	sf.add_animation("cast_skill")
	sf.set_animation_loop("cast_skill", false)
	sf.set_animation_speed("cast_skill", 12.0)
	for c_idx in range(6):
		var c_path = "%s/cast_skill_%d.png" % [base_dir, c_idx]
		if ResourceLoader.exists(c_path):
			var tex = load(c_path) as Texture2D
			if tex and (expected_size == Vector2.ZERO or tex.get_size() == expected_size):
				sf.add_frame("cast_skill", tex)
	if sf.get_frame_count("cast_skill") == 0:
		for i in range(sf.get_frame_count("attack")):
			sf.add_frame("cast_skill", sf.get_frame_texture("attack", i))
		
	# 4. Hurt animation (up to 2 uniform frames)
	sf.add_animation("hurt")
	sf.set_animation_loop("hurt", false)
	sf.set_animation_speed("hurt", 6.0)
	for h_idx in range(2):
		var h_path = "%s/hurt_%d.png" % [base_dir, h_idx]
		if ResourceLoader.exists(h_path):
			var tex = load(h_path) as Texture2D
			if tex and (expected_size == Vector2.ZERO or tex.get_size() == expected_size):
				sf.add_frame("hurt", tex)
	if sf.get_frame_count("hurt") == 0 and sf.get_frame_count("idle") > 0:
		sf.add_frame("hurt", sf.get_frame_texture("idle", 0))
		
	cached_sprite_frames[pokemon_id] = sf
	return sf
'''
    old_sf_pattern = re.compile(r'func get_sprite_frames\(pokemon_id: String\) -> SpriteFrames:[\s\S]*?return sf\n')
    if old_sf_pattern.search(new_after):
        new_after = old_sf_pattern.sub(new_sprite_frames_func, new_after, count=1)
        print("Updated get_sprite_frames with attack_physical, attack_special, cast_skill.")

    new_db_content = new_pokemons_code + new_after

    with open(DB_PATH, "w", encoding="utf-8") as f:
        f.write(new_db_content)

    print(f"Successfully updated {DB_PATH}! All 152 Pokemon now have 3 choices per star level (1,368 total skills) and basic_attack!")

if __name__ == "__main__":
    main()
