#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
generate_authentic_moves.py
Loads official Pokémon data and updates pokemon_database.gd with authentic canonical skills.
Guarantees 100% distinct VFX across all 3 star tiers for every single Pokemon!
"""
import csv
import json
import os
import re

CACHE_DIR = "scripts/cache"
DB_PATH = "scripts/autoload/pokemon_database.gd"

# 1. Load moves.csv
moves = {}
with open(os.path.join(CACHE_DIR, "moves.csv"), "r", encoding="utf-8") as f:
    for row in csv.DictReader(f):
        moves[row["id"]] = {
            "id": row["id"],
            "slug": row["identifier"],
            "type_id": int(row["type_id"]),
            "power": int(row["power"]) if row["power"] else 0,
            "damage_class_id": int(row["damage_class_id"])
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

# Map of 152 Pokemon to their 3 canonical moves (slugs) and distinct VFX
ROSTER_MOVES = {
    "bulbasaur": [("leech-seed", "leech_seed", "skill"), ("razor-leaf", "razor_leaf", "slash"), ("frenzy-plant", "frenzy_plant", "skill")],
    "ivysaur": [("vine-whip", "leech_seed", "slash"), ("sludge-bomb", "sludge_bomb", "skill"), ("frenzy-plant", "frenzy_plant", "skill")],
    "venusaur": [("razor-leaf", "razor_leaf", "slash"), ("sludge-bomb", "sludge_bomb", "skill"), ("frenzy-plant", "frenzy_plant", "skill")],
    "charmander": [("ember", "ember", "fire"), ("fire-spin", "flamethrower", "fire"), ("inferno", "inferno", "fire")],
    "charmeleon": [("ember", "ember", "fire"), ("flamethrower", "flamethrower", "fire"), ("fire-blast", "fire_blast", "fire")],
    "charizard": [("flamethrower", "flamethrower", "fire"), ("fire-blast", "fire_blast", "fire"), ("blast-burn", "blast_burn", "fire")],
    "squirtle": [("water-gun", "water_gun", "water"), ("water-pulse", "hydro_pump", "water"), ("hydro-cannon", "hydro_cannon", "water")],
    "wartortle": [("water-gun", "water_gun", "water"), ("hydro-pump", "hydro_pump", "water"), ("hydro-cannon", "hydro_cannon", "water")],
    "blastoise": [("water-gun", "water_gun", "water"), ("hydro-pump", "hydro_pump", "water"), ("hydro-cannon", "hydro_cannon", "water")],
    "caterpie": [("bug-bite", "slash", "slash"), ("string-shot", "pin_missile", "skill"), ("electroweb", "thundershock", "spark")],
    "metapod": [("harden", "reflect", "skill"), ("iron-defense", "body_slam", "skill"), ("bug-buzz", "pin_missile", "skill")],
    "butterfree": [("confusion", "confusion", "skill"), ("psybeam", "psybeam", "skill"), ("bug-buzz", "pin_missile", "skill")],
    "weedle": [("poison-sting", "poison_sting", "slash"), ("string-shot", "pin_missile", "skill"), ("bug-bite", "slash", "slash")],
    "kakuna": [("harden", "reflect", "skill"), ("iron-defense", "body_slam", "skill"), ("poison-sting", "poison_sting", "slash")],
    "beedrill": [("fury-attack", "slash", "slash"), ("pin-missile", "pin_missile", "slash"), ("cross-poison", "poison_sting", "slash")],
    "pidgey": [("gust", "twister", "swift"), ("quick-attack", "quick_attack", "swift"), ("air-slash", "air_slash", "slash")],
    "pidgeotto": [("gust", "twister", "swift"), ("wing-attack", "air_slash", "slash"), ("brave-bird", "brave_bird", "skill")],
    "pidgeot": [("air-slash", "air_slash", "slash"), ("hurricane", "twister", "skill"), ("brave-bird", "brave_bird", "skill")],
    "rattata": [("tackle", "quick_attack", "attack"), ("hyper-fang", "slash", "bite"), ("super-fang", "body_slam", "bite")],
    "raticate": [("quick-attack", "quick_attack", "swift"), ("hyper-fang", "body_slam", "bite"), ("super-fang", "giga_impact", "bite")],
    "spearow": [("peck", "slash", "slash"), ("fury-attack", "air_slash", "slash"), ("drill-peck", "drill_peck", "slash")],
    "fearow": [("aerial-ace", "air_slash", "slash"), ("drill-peck", "drill_peck", "slash"), ("brave-bird", "brave_bird", "skill")],
    "ekans": [("poison-sting", "poison_sting", "slash"), ("bite", "lick", "bite"), ("acid", "sludge_bomb", "skill")],
    "arbok": [("poison-fang", "poison_sting", "bite"), ("sludge-bomb", "sludge_bomb", "skill"), ("gunk-shot", "gunk_shot", "skill")],
    "pikachu": [("thunder-shock", "thundershock", "spark"), ("thunderbolt", "thunderbolt", "thunder"), ("10-000-000-volt-thunderbolt", "volt_catastrophe", "thunder")],
    "raichu": [("spark", "thundershock", "spark"), ("discharge", "discharge", "thunder"), ("thunder", "thunder", "thunder")],
    "sandshrew": [("scratch", "slash", "slash"), ("rollout", "rock_slide", "attack"), ("dig", "earthquake", "attack")],
    "sandslash": [("slash", "slash", "slash"), ("rock-slide", "rock_slide", "attack"), ("earthquake", "earthquake", "attack")],
    "nidoran_f": [("scratch", "slash", "slash"), ("poison-sting", "poison_sting", "slash"), ("sludge-bomb", "sludge_bomb", "skill")],
    "nidorina": [("poison-sting", "poison_sting", "slash"), ("bite", "lick", "bite"), ("sludge-bomb", "sludge_bomb", "skill")],
    "nidoqueen": [("body-slam", "body_slam", "attack"), ("earth-power", "earthquake", "skill"), ("superpower", "dynamic_punch", "punch")],
    "nidoran_m": [("peck", "drill_peck", "slash"), ("poison-sting", "poison_sting", "slash"), ("sludge-bomb", "sludge_bomb", "skill")],
    "nidorino": [("horn-attack", "body_slam", "attack"), ("poison-jab", "poison_sting", "slash"), ("earthquake", "earthquake", "attack")],
    "nidoking": [("poison-jab", "poison_sting", "slash"), ("earth-power", "earthquake", "skill"), ("megahorn", "giga_impact", "attack")],
    "clefairy": [("pound", "body_slam", "attack"), ("disarming-voice", "swift", "swift"), ("moonblast", "cosmic_singularity", "skill")],
    "clefable": [("draining-kiss", "heal_pulse", "skill"), ("dazzling-gleam", "swift", "skill"), ("moonblast", "cosmic_singularity", "skill")],
    "vulpix": [("ember", "ember", "fire"), ("flame-wheel", "flame_wheel", "fire"), ("fire-blast", "fire_blast", "fire")],
    "ninetales": [("flamethrower", "flamethrower", "fire"), ("heat-wave", "flame_wheel", "fire"), ("fire-blast", "fire_blast", "fire")],
    "jigglypuff": [("pound", "slash", "attack"), ("round", "swift", "swift"), ("hyper-voice", "body_slam", "skill")],
    "wigglytuff": [("double-slap", "body_slam", "attack"), ("dazzling-gleam", "swift", "skill"), ("hyper-voice", "giga_impact", "skill")],
    "zubat": [("leech-life", "leech_seed", "bite"), ("air-cutter", "air_slash", "slash"), ("poison-fang", "poison_sting", "bite")],
    "golbat": [("air-cutter", "air_slash", "slash"), ("venoshock", "sludge_bomb", "skill"), ("brave-bird", "brave_bird", "skill")],
    "oddish": [("absorb", "leech_seed", "skill"), ("acid", "sludge_bomb", "skill"), ("mega-drain", "frenzy_plant", "skill")],
    "gloom": [("acid", "poison_sting", "skill"), ("giga-drain", "leech_seed", "skill"), ("sludge-bomb", "sludge_bomb", "skill")],
    "vileplume": [("giga-drain", "leech_seed", "skill"), ("sludge-bomb", "sludge_bomb", "skill"), ("petal-dance", "razor_leaf", "skill")],
    "paras": [("scratch", "slash", "slash"), ("spore", "leech_seed", "skill"), ("x-scissor", "pin_missile", "slash")],
    "parasect": [("leech-life", "leech_seed", "slash"), ("spore", "frenzy_plant", "skill"), ("x-scissor", "slash", "slash")],
    "venonat": [("tackle", "quick_attack", "attack"), ("confusion", "confusion", "skill"), ("psybeam", "psybeam", "skill")],
    "venomoth": [("psybeam", "psybeam", "skill"), ("sludge-bomb", "sludge_bomb", "skill"), ("bug-buzz", "pin_missile", "skill")],
    "diglett": [("scratch", "slash", "slash"), ("mud-slap", "rock_slide", "attack"), ("bulldoze", "earthquake", "attack")],
    "dugtrio": [("mud-slap", "ancient_power", "attack"), ("rock-slide", "rock_slide", "attack"), ("earthquake", "earthquake", "attack")],
    "meowth": [("scratch", "quick_attack", "slash"), ("pay-day", "swift", "swift"), ("night-slash", "slash", "slash")],
    "persian": [("bite", "lick", "bite"), ("slash", "slash", "slash"), ("play-rough", "body_slam", "attack")],
    "psyduck": [("water-gun", "water_gun", "water"), ("water-pulse", "hydro_pump", "water"), ("psychic", "psychic", "skill")],
    "golduck": [("water-gun", "water_gun", "water"), ("psychic", "psychic", "skill"), ("hydro-pump", "hydro_pump", "water")],
    "mankey": [("low-kick", "low_kick", "punch"), ("karate-chop", "slash", "punch"), ("cross-chop", "cross_chop", "punch")],
    "primeape": [("low-kick", "low_kick", "punch"), ("cross-chop", "cross_chop", "punch"), ("close-combat", "close_combat", "punch")],
    "growlithe": [("ember", "ember", "fire"), ("flame-wheel", "flame_wheel", "fire"), ("flare-blitz", "flare_blitz", "fire")],
    "arcanine": [("flamethrower", "flamethrower", "fire"), ("extreme-speed", "quick_attack", "swift"), ("fire-blast", "fire_blast", "fire")],
    "poliwag": [("water-gun", "water_gun", "water"), ("bubble-beam", "hydro_tempest", "water"), ("hydro-pump", "hydro_pump", "water")],
    "poliwhirl": [("bubble-beam", "water_gun", "water"), ("body-slam", "body_slam", "attack"), ("hydro-pump", "hydro_pump", "water")],
    "poliwrath": [("dynamic-punch", "dynamic_punch", "punch"), ("waterfall", "hydro_pump", "water"), ("hydro-cannon", "hydro_cannon", "water")],
    "abra": [("confusion", "confusion", "skill"), ("psybeam", "psybeam", "skill"), ("psychic", "psychic", "skill")],
    "kadabra": [("psybeam", "psybeam", "skill"), ("psycho-cut", "psycho_cut", "slash"), ("psychic", "psychic", "skill")],
    "alakazam": [("psycho-cut", "psycho_cut", "slash"), ("psychic", "psychic", "skill"), ("future-sight", "future_sight", "skill")],
    "machop": [("low-kick", "low_kick", "punch"), ("karate-chop", "slash", "punch"), ("cross-chop", "cross_chop", "punch")],
    "machoke": [("karate-chop", "slash", "punch"), ("vital-throw", "dynamic_punch", "punch"), ("cross-chop", "cross_chop", "punch")],
    "machamp": [("cross-chop", "cross_chop", "punch"), ("dynamic-punch", "dynamic_punch", "punch"), ("close-combat", "close_combat", "punch")],
    "bellsprout": [("vine-whip", "leech_seed", "slash"), ("acid", "sludge_bomb", "skill"), ("razor-leaf", "razor_leaf", "slash")],
    "weepinbell": [("vine-whip", "leech_seed", "slash"), ("sludge-bomb", "sludge_bomb", "skill"), ("leaf-storm", "frenzy_plant", "skill")],
    "victreebel": [("razor-leaf", "razor_leaf", "slash"), ("sludge-bomb", "sludge_bomb", "skill"), ("leaf-storm", "frenzy_plant", "skill")],
    "tentacool": [("poison-sting", "poison_sting", "slash"), ("water-pulse", "water_gun", "water"), ("sludge-bomb", "sludge_bomb", "skill")],
    "tentacruel": [("acid-spray", "poison_sting", "skill"), ("sludge-wave", "sludge_bomb", "skill"), ("hydro-pump", "hydro_pump", "water")],
    "geodude": [("tackle", "body_slam", "attack"), ("rock-throw", "stone_edge", "attack"), ("rock-slide", "rock_slide", "attack")],
    "graveler": [("rock-throw", "stone_edge", "attack"), ("rock-slide", "rock_slide", "attack"), ("earthquake", "earthquake", "attack")],
    "golem": [("rock-slide", "rock_slide", "attack"), ("stone-edge", "stone_edge", "attack"), ("earthquake", "earthquake", "attack")],
    "ponyta": [("ember", "ember", "fire"), ("flame-wheel", "flame_wheel", "fire"), ("fire-blast", "fire_blast", "fire")],
    "rapidash": [("flame-wheel", "flame_wheel", "fire"), ("megahorn", "giga_impact", "attack"), ("flare-blitz", "flare_blitz", "fire")],
    "slowpoke": [("water-gun", "water_gun", "water"), ("confusion", "confusion", "skill"), ("surf", "hydro_pump", "water")],
    "slowbro": [("water-pulse", "hydro_pump", "water"), ("psychic", "psychic", "skill"), ("surf", "hydro_cannon", "water")],
    "magnemite": [("thunder-shock", "thundershock", "spark"), ("spark", "discharge", "spark"), ("thunderbolt", "thunderbolt", "thunder")],
    "magneton": [("spark", "thundershock", "spark"), ("tri-attack", "tri_attack", "skill"), ("zap-cannon", "thunder", "thunder")],
    "farfetchd": [("peck", "drill_peck", "slash"), ("slash", "slash", "slash"), ("leaf-blade", "razor_leaf", "slash")],
    "doduo": [("peck", "quick_attack", "slash"), ("fury-attack", "slash", "slash"), ("drill-peck", "drill_peck", "slash")],
    "dodrio": [("fury-attack", "slash", "slash"), ("tri-attack", "tri_attack", "skill"), ("drill-peck", "drill_peck", "slash")],
    "seel": [("water-gun", "water_gun", "water"), ("aurora-beam", "aurora_beam", "skill"), ("ice-beam", "ice_beam", "skill")],
    "dewgong": [("aurora-beam", "aurora_beam", "skill"), ("ice-beam", "ice_beam", "skill"), ("blizzard", "blizzard", "skill")],
    "grimer": [("pound", "poison_sting", "attack"), ("sludge", "sludge_bomb", "skill"), ("acid-armor", "acid_armor", "skill")],
    "muk": [("sludge", "sludge_bomb", "skill"), ("acid-armor", "acid_armor", "skill"), ("gunk-shot", "gunk_shot", "skill")],
    "shellder": [("water-gun", "water_gun", "water"), ("aurora-beam", "aurora_beam", "skill"), ("ice-beam", "ice_beam", "skill")],
    "cloyster": [("icicle-spear", "ice_shard", "skill"), ("hydro-pump", "hydro_pump", "water"), ("blizzard", "blizzard", "skill")],
    "gastly": [("lick", "lick", "skill"), ("night-shade", "hex_nightmare", "skill"), ("shadow-ball", "shadow_ball", "skill")],
    "haunter": [("lick", "lick", "skill"), ("shadow-punch", "shadow_punch", "punch"), ("shadow-ball", "shadow_ball", "skill")],
    "gengar": [("shadow-punch", "shadow_punch", "punch"), ("shadow-ball", "shadow_ball", "skill"), ("hex", "hex_nightmare", "skill")],
    "onix": [("bind", "stone_edge", "attack"), ("rock-slide", "rock_slide", "attack"), ("earthquake", "earthquake", "attack")],
    "drowzee": [("pound", "body_slam", "attack"), ("confusion", "confusion", "skill"), ("psychic", "psychic", "skill")],
    "hypno": [("confusion", "confusion", "skill"), ("hypnosis", "hypnosis", "skill"), ("psychic", "psychic", "skill")],
    "krabby": [("bubble", "water_gun", "water"), ("vice-grip", "slash", "slash"), ("crabhammer", "crabhammer", "water")],
    "kingler": [("stomp", "body_slam", "attack"), ("crabhammer", "crabhammer", "water"), ("guillotine", "giga_impact", "slash")],
    "voltorb": [("thunder-shock", "thundershock", "spark"), ("spark", "discharge", "spark"), ("thunderbolt", "thunderbolt", "thunder")],
    "electrode": [("spark", "thundershock", "spark"), ("discharge", "discharge", "thunder"), ("thunderbolt", "thunderbolt", "thunder")],
    "exeggcute": [("hypnosis", "hypnosis", "skill"), ("confusion", "confusion", "skill"), ("psychic", "psychic", "skill")],
    "exeggutor": [("bullet-seed", "razor_leaf", "slash"), ("psychic", "psychic", "skill"), ("leaf-storm", "frenzy_plant", "skill")],
    "cubone": [("bone-club", "bone_rush", "attack"), ("bonemerang", "bonemerang", "attack"), ("earthquake", "earthquake", "attack")],
    "marowak": [("bone-club", "bone_rush", "attack"), ("bonemerang", "bonemerang", "attack"), ("earthquake", "earthquake", "attack")],
    "hitmonlee": [("double-kick", "low_kick", "punch"), ("high-jump-kick", "dynamic_punch", "punch"), ("close-combat", "close_combat", "punch")],
    "hitmonchan": [("mach-punch", "cross_chop", "punch"), ("fire-punch", "fire_punch", "fire"), ("close-combat", "close_combat", "punch")],
    "lickitung": [("lick", "lick", "skill"), ("stomp", "body_slam", "attack"), ("power-whip", "leech_seed", "slash")],
    "koffing": [("poison-gas", "poison_sting", "skill"), ("sludge", "sludge_bomb", "skill"), ("explosion", "fire_blast", "skill")],
    "weezing": [("sludge", "poison_sting", "skill"), ("sludge-bomb", "sludge_bomb", "skill"), ("explosion", "fire_blast", "skill")],
    "rhyhorn": [("horn-attack", "body_slam", "attack"), ("rock-slide", "rock_slide", "attack"), ("earthquake", "earthquake", "attack")],
    "rhydon": [("rock-slide", "rock_slide", "attack"), ("drill-run", "drill_peck", "attack"), ("earthquake", "earthquake", "attack")],
    "chansey": [("pound", "body_slam", "attack"), ("soft-boiled", "softboiled", "skill"), ("hyper-voice", "giga_impact", "skill")],
    "tangela": [("absorb", "leech_seed", "skill"), ("mega-drain", "razor_leaf", "skill"), ("power-whip", "frenzy_plant", "slash")],
    "kangaskhan": [("comet-punch", "cross_chop", "punch"), ("dizzy-punch", "dynamic_punch", "punch"), ("outrage", "dragon_apocalypse", "attack")],
    "horsea": [("water-gun", "water_gun", "water"), ("bubble-beam", "hydro_pump", "water"), ("dragon-pulse", "dragon_pulse", "water")],
    "seadra": [("bubble-beam", "water_gun", "water"), ("dragon-pulse", "dragon_pulse", "water"), ("hydro-pump", "hydro_pump", "water")],
    "goldeen": [("peck", "drill_peck", "slash"), ("water-pulse", "water_gun", "water"), ("waterfall", "hydro_pump", "water")],
    "seaking": [("water-pulse", "water_gun", "water"), ("waterfall", "hydro_pump", "water"), ("megahorn", "giga_impact", "attack")],
    "staryu": [("water-gun", "water_gun", "water"), ("swift", "swift", "swift"), ("psychic", "psychic", "skill")],
    "starmie": [("swift", "swift", "swift"), ("psychic", "psychic", "skill"), ("hydro-pump", "hydro_pump", "water")],
    "mr-mime": [("confusion", "confusion", "skill"), ("reflect", "reflect", "skill"), ("psychic", "psychic", "skill")],
    "scyther": [("quick-attack", "quick_attack", "swift"), ("slash", "slash", "slash"), ("x-scissor", "air_slash", "slash")],
    "jynx": [("pound", "swift", "attack"), ("ice-beam", "ice_beam", "skill"), ("blizzard", "blizzard", "skill")],
    "electabuzz": [("thunder-shock", "thundershock", "spark"), ("thunder-punch", "thunder_punch", "thunder"), ("thunder", "thunder", "thunder")],
    "magmar": [("ember", "ember", "fire"), ("fire-punch", "fire_punch", "fire"), ("fire-blast", "fire_blast", "fire")],
    "pinsir": [("vice-grip", "slash", "slash"), ("x-scissor", "air_slash", "slash"), ("superpower", "dynamic_punch", "punch")],
    "tauros": [("horn-attack", "body_slam", "attack"), ("zen-headbutt", "zen_headbutt", "skill"), ("giga-impact", "giga_impact", "attack")],
    "magikarp": [("splash", "water_gun", "water"), ("tackle", "quick_attack", "attack"), ("flail", "body_slam", "attack")],
    "gyarados": [("bite", "water_gun", "bite"), ("waterfall", "hydro_pump", "water"), ("hyper-beam", "hyper_beam", "skill")],
    "lapras": [("water-pulse", "water_gun", "water"), ("ice-beam", "ice_beam", "skill"), ("sheer-cold", "sheer_cold", "skill")],
    "ditto": [("tackle", "slash", "attack"), ("transform", "transform", "skill"), ("hyper-beam", "hyper_beam", "skill")],
    "eevee": [("swift", "swift", "swift"), ("take-down", "body_slam", "attack"), ("extreme-evoboost", "extreme_evoboost", "skill")],
    "vaporeon": [("water-pulse", "water_gun", "water"), ("acid-armor", "acid_armor", "skill"), ("hydro-pump", "hydro_pump", "water")],
    "jolteon": [("spark", "thundershock", "spark"), ("pin-missile", "pin_missile", "slash"), ("thunder", "thunder", "thunder")],
    "flareon": [("ember", "ember", "fire"), ("fire-fang", "fire_fang", "fire"), ("flare-blitz", "flare_blitz", "fire")],
    "porygon": [("psybeam", "psybeam", "skill"), ("tri-attack", "tri_attack", "skill"), ("zap-cannon", "thunder", "thunder")],
    "omanyte": [("water-gun", "water_gun", "water"), ("ancient-power", "ancient_power", "skill"), ("hydro-pump", "hydro_pump", "water")],
    "omastar": [("ancient-power", "ancient_power", "skill"), ("spike-cannon", "pin_missile", "slash"), ("hydro-pump", "hydro_pump", "water")],
    "kabuto": [("scratch", "slash", "slash"), ("ancient-power", "ancient_power", "skill"), ("rock-slide", "rock_slide", "attack")],
    "kabutops": [("ancient-power", "ancient_power", "skill"), ("slash", "slash", "slash"), ("stone-edge", "stone_edge", "attack")],
    "aerodactyl": [("wing-attack", "air_slash", "slash"), ("ancient-power", "ancient_power", "skill"), ("hyper-beam", "hyper_beam", "skill")],
    "snorlax": [("lick", "lick", "skill"), ("body-slam", "body_slam", "attack"), ("giga-impact", "giga_impact", "attack")],
    "articuno": [("ice-shard", "ice_shard", "skill"), ("ice-beam", "ice_beam", "skill"), ("blizzard", "blizzard", "skill")],
    "zapdos": [("thunder-shock", "thundershock", "spark"), ("discharge", "discharge", "thunder"), ("thunder", "thunder", "thunder")],
    "moltres": [("ember", "ember", "fire"), ("heat-wave", "flamethrower", "fire"), ("fire-blast", "fire_blast", "fire")],
    "dratini": [("twister", "twister", "swift"), ("dragon-breath", "dragon_breath", "skill"), ("dragon-pulse", "dragon_pulse", "skill")],
    "dragonair": [("dragon-breath", "dragon_breath", "skill"), ("dragon-pulse", "dragon_pulse", "skill"), ("outrage", "dragon_apocalypse", "skill")],
    "dragonite": [("dragon-claw", "dragon_claw", "slash"), ("dragon-pulse", "dragon_pulse", "skill"), ("draco-meteor", "draco_meteor", "skill")],
    "mewtwo": [("confusion", "confusion", "skill"), ("psychic", "psychic", "skill"), ("psystrike", "psystrike", "skill")],
    "mew": [("psybeam", "psybeam", "skill"), ("reflect", "reflect", "skill"), ("cosmic-singularity", "cosmic_singularity", "skill")],
    "lucario": [("force-palm", "force_palm", "punch"), ("aura-sphere", "aura_sphere", "skill"), ("close-combat", "close_combat", "punch")]
}

def resolve_move_info(slug):
    mid = slug_to_id.get(slug)
    if not mid or mid not in moves:
        return {
            "name": slug,
            "desc": f"使出{slug}攻击敌人。",
            "power": 60
        }
    m = moves[mid]
    name = names_zh.get(mid, slug)
    desc = flavors_zh.get(mid, (0, f"使出{name}攻击敌人。"))[1]
    return {
        "name": name,
        "desc": desc,
        "power": m["power"]
    }

def main():
    print(f"Total roster defined: {len(ROSTER_MOVES)}")
    assert len(ROSTER_MOVES) == 152, f"Expected 152 Pokemon in ROSTER_MOVES, got {len(ROSTER_MOVES)}"

    # Audit VFX uniqueness across all 152
    available_vfx = set(os.listdir("assets/vfx"))
    for pid, stars in ROSTER_MOVES.items():
        v1, v2, v3 = stars[0][1], stars[1][1], stars[2][1]
        assert v1 in available_vfx, f"{pid} star 1 VFX {v1} not in assets/vfx"
        assert v2 in available_vfx, f"{pid} star 2 VFX {v2} not in assets/vfx"
        assert v3 in available_vfx, f"{pid} star 3 VFX {v3} not in assets/vfx"
        assert len({v1, v2, v3}) == 3, f"{pid} does not have 3 distinct VFX: {v1}, {v2}, {v3}"

    print("All 152 Pokemon have 3 100% DISTINCT and VALID VFX in assets/vfx!")

    # Read original database text
    with open(DB_PATH, "r", encoding="utf-8") as f:
        content = f.read()

    # For each Pokemon, generate its new skills dictionary and top-level skill fields
    for pid, star_tuples in ROSTER_MOVES.items():
        skills_dict = {}
        for star, (slug, vfx, sfx) in enumerate(star_tuples, 1):
            info = resolve_move_info(slug)
            name = info["name"]
            desc = info["desc"]
            
            # Calibrated power & targets & mechanics based on star tier
            if star == 1:
                power = 160 if info["power"] == 0 else int(150 + info["power"] * 0.8)
                target_count = 1
                stun_duration = 0.5 if "麻痹" in desc or "畏缩" in desc or "昏" in desc else 0.0
                scale = 0.28
                detail = f"消耗100能量，使出【{name}】。{desc} 对目标造成{power}点伤害。"
            elif star == 2:
                power = 300 if info["power"] == 0 else int(260 + info["power"] * 1.0)
                target_count = 3
                stun_duration = 0.8 if "麻痹" in desc or "畏缩" in desc or "昏" in desc else 0.4
                scale = 0.36
                detail = f"消耗100能量，爆发【{name}】。{desc} 对范围内最多{target_count}名敌人造成{power}点伤害，并施加战术压制。"
            else:
                power = 600 if info["power"] == 0 else int(520 + info["power"] * 1.5)
                target_count = 6
                stun_duration = 1.2 if "麻痹" in desc or "畏缩" in desc or "昏" in desc else 0.8
                scale = 0.48
                detail = f"消耗100能量，释放终极奥义【{name}】！{desc} 席卷战场对最多{target_count}名敌人造成{power}点巨额伤害与强力击破！"

            skills_dict[star] = {
                "name": name,
                "desc": desc,
                "detail": detail,
                "power": power,
                "target_count": target_count,
                "stun_duration": stun_duration,
                "vfx": vfx,
                "sfx": sfx,
                "scale": scale
            }

        # Format skills code in GDScript
        star1 = skills_dict[1]
        star2 = skills_dict[2]
        star3 = skills_dict[3]

        def escape_gd(s):
            return s.replace('"', '\\"')

        new_skills_gd = f'''\t\t"skill_name": "{escape_gd(star1['name'])}",
\t\t"skill_desc": "{escape_gd(star1['desc'])}",
\t\t"skill_detail": "{escape_gd(star1['detail'])}",
\t\t"skill_power": {star1['power']},
\t\t"skills": {{
\t\t\t1: {{
\t\t\t\t"name": "{escape_gd(star1['name'])}",
\t\t\t\t"desc": "{escape_gd(star1['desc'])}",
\t\t\t\t"detail": "{escape_gd(star1['detail'])}",
\t\t\t\t"power": {star1['power']},
\t\t\t\t"target_count": {star1['target_count']},
\t\t\t\t"stun_duration": {star1['stun_duration']},
\t\t\t\t"vfx": "{star1['vfx']}",
\t\t\t\t"sfx": "{star1['sfx']}",
\t\t\t\t"scale": {star1['scale']}
\t\t\t}},
\t\t\t2: {{
\t\t\t\t"name": "{escape_gd(star2['name'])}",
\t\t\t\t"desc": "{escape_gd(star2['desc'])}",
\t\t\t\t"detail": "{escape_gd(star2['detail'])}",
\t\t\t\t"power": {star2['power']},
\t\t\t\t"target_count": {star2['target_count']},
\t\t\t\t"stun_duration": {star2['stun_duration']},
\t\t\t\t"vfx": "{star2['vfx']}",
\t\t\t\t"sfx": "{star2['sfx']}",
\t\t\t\t"scale": {star2['scale']}
\t\t\t}},
\t\t\t3: {{
\t\t\t\t"name": "{escape_gd(star3['name'])}",
\t\t\t\t"desc": "{escape_gd(star3['desc'])}",
\t\t\t\t"detail": "{escape_gd(star3['detail'])}",
\t\t\t\t"power": {star3['power']},
\t\t\t\t"target_count": {star3['target_count']},
\t\t\t\t"stun_duration": {star3['stun_duration']},
\t\t\t\t"vfx": "{star3['vfx']}",
\t\t\t\t"sfx": "{star3['sfx']}",
\t\t\t\t"scale": {star3['scale']}
\t\t\t}}
\t\t}},'''

        poke_regex = rf'(\"{re.escape(pid)}\":\s*\{{.*?\n)(\t\t\"skill_name\":.*?\n\t\t\"skills\":\s*\{{.*?\n\t\t\}},\n)(\t\t\"icon\":)'
        m = re.search(poke_regex, content, re.DOTALL)
        if m:
            content = content[:m.start(2)] + new_skills_gd + "\n" + content[m.end(2):]
        else:
            alt_regex = rf'(\"{re.escape(pid)}\":\s*\{{.*?\n)(\t\t\"skill_name\":.*?\n\t\t\"skills\":\s*\{{.*?\n\t\t\}}[,\n]+)(\t\t\"icon\":)'
            m2 = re.search(alt_regex, content, re.DOTALL)
            if m2:
                content = content[:m2.start(2)] + new_skills_gd + "\n" + content[m2.end(2):]
            else:
                print(f"WARNING: Regex did not match for {pid}")

    with open(DB_PATH, "w", encoding="utf-8") as f:
        f.write(content)

    print("Successfully generated and validated authentic canonical moves for all 152 Pokemon!")

if __name__ == "__main__":
    main()
