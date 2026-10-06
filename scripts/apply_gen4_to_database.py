#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
apply_gen4_to_database.py
Systematically injects Generation 4 (#387 ~ #493, except #448 Lucario)
Pokemon into scripts/autoload/pokemon_database.gd:
1. Appends 106 new Pokemon to pokemons dictionary with full stats, basic attacks, 9-unique branching skills, and icons.
2. Updates evolution_chains dictionary with all 493 Pokemon (including Gen 4 cross-gen evolutions).
"""

import os
import sys
import json
import shutil
import csv
from collections import defaultdict

CACHE_DIR = "scripts/cache"
DB_PATH = "scripts/autoload/pokemon_database.gd"

GEN4_SPECIAL_SLUGS = {
    413: "wormadam",
    439: "mime_jr",
    474: "porygon_z",
    487: "giratina",
    492: "shaymin",
}

def format_skills_block(skills):
    lines = ['\t\t"skills": {']
    for star in [1, 2, 3]:
        lines.append(f'\t\t\t{star}: [')
        choices = skills[str(star)] if str(star) in skills else skills[star]
        for c_idx, c in enumerate(choices):
            lines.append('\t\t\t\t{')
            lines.append(f'\t\t\t\t\t"name": "{c["name"]}",')
            lines.append(f'\t\t\t\t\t"desc": "{c["desc"]}",')
            lines.append(f'\t\t\t\t\t"detail": "{c["detail"]}",')
            lines.append(f'\t\t\t\t\t"power": {c["power"]},')
            lines.append(f'\t\t\t\t\t"target_count": {c.get("target_count", 1)},')
            lines.append(f'\t\t\t\t\t"stun_duration": {c.get("stun_duration", 0.0):.1f},')
            lines.append(f'\t\t\t\t\t"vfx": "{c["vfx"]}",')
            lines.append(f'\t\t\t\t\t"sfx": "{c["sfx"]}",')
            lines.append(f'\t\t\t\t\t"scale": {c.get("scale", 1.0):.2f}')
            if c_idx < len(choices) - 1:
                lines.append('\t\t\t\t},')
            else:
                lines.append('\t\t\t\t}')
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

def build_all_evolution_chains_493():
    sys.path.append("scripts")
    from apply_gen2_gen3_to_database import build_all_evolution_chains

    # Start with all 387 chains
    chains = build_all_evolution_chains()

    # Load species metadata for Gen 4
    species = {}
    with open(os.path.join(CACHE_DIR, "pokemon_species.csv"), "r", encoding="utf-8") as f:
        for row in csv.DictReader(f):
            sid = int(row["id"])
            if sid <= 493:
                species[sid] = row

    slug_map = {}
    with open(os.path.join(CACHE_DIR, "pokemon.csv"), "r", encoding="utf-8") as f:
        for row in csv.DictReader(f):
            sid = int(row["id"])
            if sid <= 493:
                slug = GEN4_SPECIAL_SLUGS.get(sid, row["identifier"]).replace("-", "_")
                slug_map[sid] = slug

    children = defaultdict(list)
    for sid, s in species.items():
        if s['evolves_from_species_id']:
            p = int(s['evolves_from_species_id'])
            if p in slug_map and sid in slug_map:
                children[p].append(sid)

    # Add Gen 4 default chain paths
    baby_pids = {172, 173, 174, 175, 236, 238, 239, 240, 298, 360, 406, 433, 438, 439, 440, 446, 458}

    for sid in range(387, 494):
        slug = slug_map[sid]
        cur = sid
        path = [cur]
        while species[cur]['evolves_from_species_id']:
            p = int(species[cur]['evolves_from_species_id'])
            if p not in slug_map:
                break
            if cur not in baby_pids:
                if cur in [25, 35, 39, 106, 107, 122, 124, 125, 126, 143, 183, 185, 202, 226, 315, 358]:
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

    # Curated Gen 4 Cross-Gen & Special Evolutions
    chains["electabuzz"]["next"] = "electivire"
    chains["electivire"] = {"next": "", "stage": 3, "root": chains["electabuzz"]["root"]}
    chains["magmar"]["next"] = "magmortar"
    chains["magmortar"] = {"next": "", "stage": 3, "root": chains["magmar"]["root"]}
    chains["tangela"] = {"next": "tangrowth", "stage": 1, "root": "tangela"}
    chains["tangrowth"] = {"next": "", "stage": 2, "root": "tangela"}
    chains["rhydon"]["next"] = "rhyperior"
    chains["rhyperior"] = {"next": "", "stage": 3, "root": chains["rhydon"]["root"]}
    chains["lickitung"] = {"next": "lickilicky", "stage": 1, "root": "lickitung"}
    chains["lickilicky"] = {"next": "", "stage": 2, "root": "lickitung"}
    chains["aipom"] = {"next": "ambipom", "stage": 1, "root": "aipom"}
    chains["ambipom"] = {"next": "", "stage": 2, "root": "aipom"}
    chains["yanma"] = {"next": "yanmega", "stage": 1, "root": "yanma"}
    chains["yanmega"] = {"next": "", "stage": 2, "root": "yanma"}
    chains["murkrow"] = {"next": "honchkrow", "stage": 1, "root": "murkrow"}
    chains["honchkrow"] = {"next": "", "stage": 2, "root": "murkrow"}
    chains["misdreavus"] = {"next": "mismagius", "stage": 1, "root": "misdreavus"}
    chains["mismagius"] = {"next": "", "stage": 2, "root": "misdreavus"}
    chains["gligar"] = {"next": "gliscor", "stage": 1, "root": "gligar"}
    chains["gliscor"] = {"next": "", "stage": 2, "root": "gligar"}
    chains["sneasel"] = {"next": "weavile", "stage": 1, "root": "sneasel"}
    chains["weavile"] = {"next": "", "stage": 2, "root": "sneasel"}
    chains["piloswine"]["next"] = "mamoswine"
    chains["mamoswine"] = {"next": "", "stage": 3, "root": "swinub"}
    chains["porygon2"]["next"] = "porygon_z"
    chains["porygon_z"] = {"next": "", "stage": 3, "root": "porygon"}
    chains["togetic"]["next"] = "togekiss"
    chains["togekiss"] = {"next": "", "stage": 3, "root": "togepi"}
    chains["kirlia"] = {"branches": ["gardevoir", "gallade"], "next": "gardevoir", "stage": 2, "root": "ralts"}
    chains["gallade"] = {"next": "", "stage": 3, "root": "ralts"}
    chains["snorunt"] = {"branches": ["glalie", "froslass"], "next": "glalie", "stage": 1, "root": "snorunt"}
    chains["froslass"] = {"next": "", "stage": 2, "root": "snorunt"}
    chains["magneton"]["next"] = "magnezone"
    chains["magnezone"] = {"next": "", "stage": 3, "root": "magnemite"}
    chains["nosepass"] = {"next": "probopass", "stage": 1, "root": "nosepass"}
    chains["probopass"] = {"next": "", "stage": 2, "root": "nosepass"}
    chains["dusclops"]["next"] = "dusknoir"
    chains["dusknoir"] = {"next": "", "stage": 3, "root": "duskull"}
    chains["roselia"] = {"next": "roserade", "stage": 1, "root": "roselia"}
    chains["roserade"] = {"next": "", "stage": 2, "root": "roselia"}
    chains["riolu"] = {"next": "lucario", "stage": 1, "root": "riolu"}
    chains["lucario"] = {"next": "", "stage": 2, "root": "riolu"}
    chains["eevee"]["branches"] = ["vaporeon", "jolteon", "flareon", "espeon", "umbreon", "leafeon", "glaceon"]
    chains["leafeon"] = {"next": "", "stage": 2, "root": "eevee"}
    chains["glaceon"] = {"next": "", "stage": 2, "root": "eevee"}

    # Gen 4 babies keeping parents base-form for shop
    chains["budew"] = {"next": "roselia", "stage": 1, "root": "budew"}
    chains["chingling"] = {"next": "chimecho", "stage": 1, "root": "chingling"}
    chains["chimecho"] = {"next": "", "stage": 1, "root": "chimecho"}
    chains["bonsly"] = {"next": "sudowoodo", "stage": 1, "root": "bonsly"}
    chains["sudowoodo"] = {"next": "", "stage": 1, "root": "sudowoodo"}
    chains["mime_jr"] = {"next": "mr_mime", "stage": 1, "root": "mime_jr"}
    chains["mr_mime"] = {"next": "", "stage": 1, "root": "mr_mime"}
    chains["happiny"] = {"next": "chansey", "stage": 1, "root": "happiny"}
    chains["chansey"] = {"next": "blissey", "stage": 1, "root": "chansey"}
    chains["munchlax"] = {"next": "snorlax", "stage": 1, "root": "munchlax"}
    chains["snorlax"] = {"next": "", "stage": 1, "root": "snorlax"}
    chains["mantyke"] = {"next": "mantine", "stage": 1, "root": "mantyke"}
    chains["mantine"] = {"next": "", "stage": 1, "root": "mantine"}

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
    lines[-1] = lines[-1].rstrip(',')
    lines.append('}')
    return "\n".join(lines)

def main():
    print("Reading current pokemon_database.gd...")
    with open(DB_PATH, "r", encoding="utf-8") as f:
        code = f.read()

    # Load Gen 4 data
    with open(os.path.join(CACHE_DIR, "gen4_pokemons.json"), "r", encoding="utf-8") as f:
        gen4_dict = json.load(f)

    print(f"Loaded {len(gen4_dict)} Gen 4 Pokemon from cache.")

    # 1. Format new Pokemon
    formatted_new = []
    for pid, pdata in gen4_dict.items():
        formatted_new.append(format_pokemon_entry(pdata))

    new_pokes_str = ",\n" + ",\n".join(formatted_new)

    # 2. Insert before var synergies if not already present
    if '\t"turtwig": {' in code:
        print("Gen 4 Pokemon already present in var pokemons, skipping insertion.")
    else:
        p_end_marker = '\t}\n}\n\n# Synergy definitions\n\nvar synergies: Dictionary = {'
        assert p_end_marker in code, "Could not find p_end_marker in pokemon_database.gd!"
        new_p_end = '\t}' + new_pokes_str + '\n}\n\n# Synergy definitions\n\nvar synergies: Dictionary = {'
        code = code.replace(p_end_marker, new_p_end, 1)
        print("Successfully injected 106 Gen 4 Pokemon into var pokemons!")

    # 3. Replace evolution_chains with 493 chains
    print("Building evolution chains for all 493 Pokemon...")
    all_chains = build_all_evolution_chains_493()
    print(f"Total evolution chains built: {len(all_chains)}")
    new_chains_block = format_evolution_chains(all_chains)

    evo_start = code.find("var evolution_chains: Dictionary = {")
    evo_end = code.find("\nfunc get_next_evolution(")
    assert evo_start != -1 and evo_end != -1, "Could not find evolution_chains block boundaries!"

    code = code[:evo_start] + new_chains_block + "\n" + code[evo_end:]
    print("Successfully updated evolution_chains dictionary!")

    with open(DB_PATH, "w", encoding="utf-8") as f:
        f.write(code)

    print(f"Saved changes to {DB_PATH} successfully!")

if __name__ == '__main__':
    main()
