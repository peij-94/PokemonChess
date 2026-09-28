#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
build_authentic_moves.py
Generates authentic Pokemon skill sets for all 152 Pokemon using official Pokemon data.
"""
import csv
import os
import re

CACHE_DIR = "scripts/cache"
DB_PATH = "scripts/autoload/pokemon_database.gd"

def main():
    print("Loading official Pokemon move database...")
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

    # 2. Load move_names.csv
    names_zh = {}
    with open(os.path.join(CACHE_DIR, "move_names.csv"), "r", encoding="utf-8") as f:
        for row in csv.DictReader(f):
            if row["local_language_id"] == "12": # zh-Hans
                names_zh[row["move_id"]] = row["name"]

    # 3. Load move_flavor_text.csv
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

    # 4. Map slug to move_id
    slug_to_id = {m["slug"]: m["id"] for m in moves.values()}

    # 5. Load available VFX in assets/vfx/
    available_vfx = set(os.listdir("assets/vfx"))
    print(f"Loaded {len(moves)} moves, {len(names_zh)} Chinese names, {len(flavors_zh)} flavor texts, {len(available_vfx)} VFX folders.")

    # Helper to resolve move info
    def resolve_move(slug_or_id):
        mid = str(slug_or_id) if str(slug_or_id) in moves else slug_to_id.get(slug_or_id)
        if not mid or mid not in moves:
            return None
        m = moves[mid]
        name = names_zh.get(mid, m["slug"])
        desc = flavors_zh.get(mid, (0, f"使出{name}攻击敌人。"))[1]
        return {
            "id": mid,
            "slug": m["slug"],
            "name": name,
            "desc": desc,
            "power": m["power"]
        }

    # Verify key test moves
    print("Verification of sample moves:")
    for test_slug in ["thunder-shock", "thunderbolt", "10-000-000-volt-thunderbolt", "ember", "fire-spin", "inferno", "water-gun", "hydro-pump", "hydro-cannon"]:
        res = resolve_move(test_slug)
        if res:
            print(f"  {res['name']} ({res['slug']}): {res['desc']}")
        else:
            print(f"  FAILED to resolve: {test_slug}")

if __name__ == "__main__":
    main()
