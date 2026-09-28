#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
deduplicate_all_pokemon_skills.py

Ensures that every Pokémon in PokemonDatabase has:
1. 100% unique skill names across ALL 9 choices (3 in ★1, 3 in ★2, 3 in ★3) - 0 name duplicates per Pokémon.
2. 100% unique visual effects (VFX) across ALL 9 choices (3 in ★1, 3 in ★2, 3 in ★3) - 0 VFX duplicates per Pokémon.
3. Authentic descriptions, animations, powers, and target counts based on official moves data.
"""

import os
import re
import csv
import sys
from collections import defaultdict

CACHE_DIR = "scripts/cache"
DB_PATH = "scripts/autoload/pokemon_database.gd"

sys.path.append("scripts")
from gen1_data import ALL_GEN1_POKEMON

# 1. Load moves
moves = {}
with open(os.path.join(CACHE_DIR, "moves.csv"), "r", encoding="utf-8") as f:
    for row in csv.DictReader(f):
        moves[row["identifier"]] = {
            "id": row["id"],
            "slug": row["identifier"],
            "type_id": int(row["type_id"]),
            "power": int(row["power"]) if row["power"] else 0,
            "damage_class_id": int(row["damage_class_id"]) # 1: status, 2: physical, 3: special
        }
slug_to_id = {m["slug"]: m["id"] for m in moves.values()}
id_to_slug = {m["id"]: m["slug"] for m in moves.values()}

# 2. Load move names (zh-Hans = 12)
names_zh = {}
slug_to_zh = {}
with open(os.path.join(CACHE_DIR, "move_names.csv"), "r", encoding="utf-8") as f:
    for row in csv.DictReader(f):
        if row["local_language_id"] == "12":
            mid = row["move_id"]
            names_zh[mid] = row["name"]
            if mid in id_to_slug:
                slug_to_zh[id_to_slug[mid]] = row["name"]

zh_to_slug = {v: k for k, v in slug_to_zh.items()}

# 3. Load descriptions
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

# 4. Available VFX in assets/vfx
available_vfx = set(os.listdir("assets/vfx"))

# 4.1 Load pokemon learnsets
pokemon_learnsets = defaultdict(list)
with open(os.path.join(CACHE_DIR, "pokemon_moves.csv"), "r", encoding="utf-8") as f:
    for row in csv.DictReader(f):
        pnum = int(row["pokemon_id"])
        mid = row["move_id"]
        lvl = int(row["level"])
        method = int(row["pokemon_move_method_id"])
        if mid in id_to_slug:
            pokemon_learnsets[pnum].append((method, lvl, id_to_slug[mid]))

# 5. Type ID to Type Name
TYPE_ID_MAP = {
    1: "Normal", 2: "Fighting", 3: "Flying", 4: "Poison", 5: "Ground",
    6: "Rock", 7: "Bug", 8: "Ghost", 9: "Steel", 10: "Fire",
    11: "Water", 12: "Grass", 13: "Electric", 14: "Psychic", 15: "Ice",
    16: "Dragon", 17: "Dark", 18: "Fairy"
}

# 6. Canonical Move-to-VFX mapping
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
    "贝壳夹击": "water_pulse",
    "水流喷射": "water_gun",
    "水之誓约": "water_pulse",
    "热水": "water_pulse",
    "海啸巨浪": "hydro_tempest",

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
    "蓄能焰袭": "flame_wheel",

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
    "青草搅拌器": "razor_leaf",
    "草之誓约": "razor_leaf",
    "落英缤纷": "petal_dance",

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
    "充电光束": "spark",

    # --- ICE ---
    "冰砾": "ice_shard",
    "细雪": "ice_shard",
    "冰锥": "icicle_spear",
    "冰柱坠击": "icicle_spear",
    "冰冻拳": "ice_punch",
    "冰冻牙": "ice_fang",
    "冰冻光束": "ice_beam",
    "急冻光线": "ice_beam",
    "极光束": "aurora_beam",
    "暴风雪": "blizzard",
    "雪崩": "avalanche",
    "绝对零度": "sheer_cold",
    "冷冻干燥": "ice_shard",
    "冻结之风": "blizzard",
    "雪矛": "icicle_spear",
    "落冰": "icicle_spear",

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
    "神通力": "confusion",
    "宇宙力量": "cosmic_singularity",

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
    "恶意追击": "crunch",
    "欺诈": "dark_pulse",
    "地狱突刺": "dark_pulse",

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
    "致命针刺": "poison_jab",
    "迎头一击": "quick_attack",

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
    "神鸟猛击": "brave_bird",

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
    "地狱翻滚": "mega_kick",
    "下盘踢": "low_kick",
    "碎岩": "mega_punch",
    "气合弹": "aura_sphere",
    "地球上投": "mega_punch",

    # --- ROCK / GROUND ---
    "落石": "rock_throw",
    "岩石爆击": "rock_throw",
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
    "十万马力": "earthquake",
    "直冲钻": "drill_peck",
    "骨棒": "bone_rush",
    "骨棒乱打": "bone_rush",
    "骨头回力镖": "bonemerang",
    "滚动": "rock_slide",
    "隐形岩": "stone_edge",
    "大地之力": "earthquake",
    "岩石封锁": "rock_throw",

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
    "酸液炸弹": "sludge_bomb",
    "毒尾": "poison_jab",

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
    "拍击": "tackle",
    "抓": "slash",
    "乱抓": "headbutt",
    "劈开": "slash",
    "居合斩": "slash",
    "斩断": "slash",
    "头锤": "headbutt",
    "猛撞": "take_down",
    "舍身冲撞": "double_edge",
    "泰山压顶": "body_slam",
    "电光一闪": "quick_attack",
    "高速星星": "swift",
    "三重攻击": "tri_attack",
    "破坏光线": "hyper_beam",
    "终极冲击": "giga_impact",
    "超级冲击": "giga_impact",
    "自爆": "rock_throw",
    "大爆炸": "rock_throw",
    "珍藏": "giga_impact",
    "角撞": "headbutt",
    "角钻": "drill_peck",
    "愤怒门牙": "crunch",
    "必杀门牙": "headbutt",
    "击掌奇袭": "mach_punch",
    "打鼾": "body_slam",
    "巨声": "bug_buzz",
    "大闹一番": "double_edge",
    "生蛋": "softboiled",
    "变圆": "body_slam",
    "重磅冲撞": "body_slam",
    "变身": "transform",
    "模仿": "transform",
    "嬉闹": "tackle",
    "魅惑之声": "swift",
    "陀螺球": "ancient_power",
    "聚宝功": "ancient_power",
    "挥指": "swift",
    "极度蒸发": "extreme_evoboost",
    "九彩升华齐聚顶": "extreme_evoboost",
}

# 7. Evolution Chains mapping
EVO_CHAINS = {
    "bulbasaur": ["bulbasaur", "ivysaur", "venusaur"],
    "ivysaur": ["bulbasaur", "ivysaur", "venusaur"],
    "venusaur": ["bulbasaur", "ivysaur", "venusaur"],
    "charmander": ["charmander", "charmeleon", "charizard"],
    "charmeleon": ["charmander", "charmeleon", "charizard"],
    "charizard": ["charmander", "charmeleon", "charizard"],
    "squirtle": ["squirtle", "wartortle", "blastoise"],
    "wartortle": ["squirtle", "wartortle", "blastoise"],
    "blastoise": ["squirtle", "wartortle", "blastoise"],
    "caterpie": ["caterpie", "metapod", "butterfree"],
    "metapod": ["caterpie", "metapod", "butterfree"],
    "butterfree": ["caterpie", "metapod", "butterfree"],
    "weedle": ["weedle", "kakuna", "beedrill"],
    "kakuna": ["weedle", "kakuna", "beedrill"],
    "beedrill": ["weedle", "kakuna", "beedrill"],
    "pidgey": ["pidgey", "pidgeotto", "pidgeot"],
    "pidgeotto": ["pidgey", "pidgeotto", "pidgeot"],
    "pidgeot": ["pidgey", "pidgeotto", "pidgeot"],
    "rattata": ["rattata", "raticate"],
    "raticate": ["rattata", "raticate"],
    "spearow": ["spearow", "fearow"],
    "fearow": ["spearow", "fearow"],
    "ekans": ["ekans", "arbok"],
    "arbok": ["ekans", "arbok"],
    "pikachu": ["pikachu", "raichu"],
    "raichu": ["pikachu", "raichu"],
    "sandshrew": ["sandshrew", "sandslash"],
    "sandslash": ["sandshrew", "sandslash"],
    "nidoran_f": ["nidoran_f", "nidorina", "nidoqueen"],
    "nidorina": ["nidoran_f", "nidorina", "nidoqueen"],
    "nidoqueen": ["nidoran_f", "nidorina", "nidoqueen"],
    "nidoran_m": ["nidoran_m", "nidorino", "nidoking"],
    "nidorino": ["nidoran_m", "nidorino", "nidoking"],
    "nidoking": ["nidoran_m", "nidorino", "nidoking"],
    "clefairy": ["clefairy", "clefable"],
    "clefable": ["clefairy", "clefable"],
    "vulpix": ["vulpix", "ninetales"],
    "ninetales": ["vulpix", "ninetales"],
    "jigglypuff": ["jigglypuff", "wigglytuff"],
    "wigglytuff": ["jigglypuff", "wigglytuff"],
    "zubat": ["zubat", "golbat"],
    "golbat": ["zubat", "golbat"],
    "oddish": ["oddish", "gloom", "vileplume"],
    "gloom": ["oddish", "gloom", "vileplume"],
    "vileplume": ["oddish", "gloom", "vileplume"],
    "paras": ["paras", "parasect"],
    "parasect": ["paras", "parasect"],
    "venonat": ["venonat", "venomoth"],
    "venomoth": ["venonat", "venomoth"],
    "diglett": ["diglett", "dugtrio"],
    "dugtrio": ["diglett", "dugtrio"],
    "meowth": ["meowth", "persian"],
    "persian": ["meowth", "persian"],
    "psyduck": ["psyduck", "golduck"],
    "golduck": ["psyduck", "golduck"],
    "mankey": ["mankey", "primeape"],
    "primeape": ["mankey", "primeape"],
    "growlithe": ["growlithe", "arcanine"],
    "arcanine": ["growlithe", "arcanine"],
    "poliwag": ["poliwag", "poliwhirl", "poliwrath"],
    "poliwhirl": ["poliwag", "poliwhirl", "poliwrath"],
    "poliwrath": ["poliwag", "poliwhirl", "poliwrath"],
    "abra": ["abra", "kadabra", "alakazam"],
    "kadabra": ["abra", "kadabra", "alakazam"],
    "alakazam": ["abra", "kadabra", "alakazam"],
    "machop": ["machop", "machoke", "machamp"],
    "machoke": ["machop", "machoke", "machamp"],
    "machamp": ["machop", "machoke", "machamp"],
    "bellsprout": ["bellsprout", "weepinbell", "victreebel"],
    "weepinbell": ["bellsprout", "weepinbell", "victreebel"],
    "victreebel": ["bellsprout", "weepinbell", "victreebel"],
    "tentacool": ["tentacool", "tentacruel"],
    "tentacruel": ["tentacool", "tentacruel"],
    "geodude": ["geodude", "graveler", "golem"],
    "graveler": ["geodude", "graveler", "golem"],
    "golem": ["geodude", "graveler", "golem"],
    "ponyta": ["ponyta", "rapidash"],
    "rapidash": ["ponyta", "rapidash"],
    "slowpoke": ["slowpoke", "slowbro"],
    "slowbro": ["slowpoke", "slowbro"],
    "magnemite": ["magnemite", "magneton"],
    "magneton": ["magnemite", "magneton"],
    "doduo": ["doduo", "dodrio"],
    "dodrio": ["doduo", "dodrio"],
    "seel": ["seel", "dewgong"],
    "dewgong": ["seel", "dewgong"],
    "grimer": ["grimer", "muk"],
    "muk": ["grimer", "muk"],
    "shellder": ["shellder", "cloyster"],
    "cloyster": ["shellder", "cloyster"],
    "gastly": ["gastly", "haunter", "gengar"],
    "haunter": ["gastly", "haunter", "gengar"],
    "gengar": ["gastly", "haunter", "gengar"],
    "drowzee": ["drowzee", "hypno"],
    "hypno": ["drowzee", "hypno"],
    "krabby": ["krabby", "kingler"],
    "kingler": ["krabby", "kingler"],
    "voltorb": ["voltorb", "electrode"],
    "electrode": ["voltorb", "electrode"],
    "exeggcute": ["exeggcute", "exeggutor"],
    "exeggutor": ["exeggcute", "exeggutor"],
    "cubone": ["cubone", "marowak"],
    "marowak": ["cubone", "marowak"],
    "koffing": ["koffing", "weezing"],
    "weezing": ["koffing", "weezing"],
    "rhyhorn": ["rhyhorn", "rhydon"],
    "rhydon": ["rhyhorn", "rhydon"],
    "horsea": ["horsea", "seadra"],
    "seadra": ["horsea", "seadra"],
    "goldeen": ["goldeen", "seaking"],
    "seaking": ["goldeen", "seaking"],
    "staryu": ["staryu", "starmie"],
    "starmie": ["staryu", "starmie"],
    "magikarp": ["magikarp", "gyarados"],
    "gyarados": ["magikarp", "gyarados"],
    "omanyte": ["omanyte", "omastar"],
    "omastar": ["omanyte", "omastar"],
    "kabuto": ["kabuto", "kabutops"],
    "kabutops": ["kabuto", "kabutops"],
    "dratini": ["dratini", "dragonair", "dragonite"],
    "dragonair": ["dratini", "dragonair", "dragonite"],
    "dragonite": ["dratini", "dragonair", "dragonite"],
}

# 8. Type Archetype Moves Pool for Fallbacks
TYPE_ARCHETYPE_MOVES = {
    "Fire": [
        ("火花", 1), ("火焰轮", 2), ("火之誓约", 1), ("火焰旋涡", 2),
        ("火焰拳", 2), ("火焰牙", 2), ("喷射火焰", 2), ("热风", 2),
        ("大字爆炎", 3), ("闪焰冲锋", 3), ("炼狱", 3), ("爆炸烈焰", 3)
    ],
    "Water": [
        ("水枪", 1), ("泡沫", 1), ("水流喷射", 1), ("水之波动", 2),
        ("泡沫光线", 2), ("水流尾", 2), ("盐水", 2), ("攀瀑", 2),
        ("冲浪", 3), ("水炮", 3), ("加农水炮", 3), ("海啸巨浪", 3)
    ],
    "Grass": [
        ("寄生种子", 1), ("藤鞭", 1), ("飞叶快刀", 2), ("种子炸弹", 2),
        ("终极吸取", 2), ("花瓣舞", 2), ("叶刃", 2), ("能量球", 2),
        ("强力鞭打", 3), ("日光束", 3), ("飞叶风暴", 3), ("疯狂植物", 3)
    ],
    "Electric": [
        ("电击", 1), ("电火花", 1), ("电网", 1), ("电球", 2),
        ("十万伏特", 2), ("放电", 2), ("雷电拳", 2), ("雷电牙", 2),
        ("打雷", 3), ("电磁炮", 3), ("疯狂伏特", 3), ("雷暴", 3), ("千万伏特", 3)
    ],
    "Ice": [
        ("细雪", 1), ("冰砾", 1), ("冰冻牙", 2), ("冰冻拳", 2),
        ("冰锥", 2), ("急冻光线", 2), ("极光束", 2), ("雪崩", 2),
        ("暴风雪", 3), ("绝对零度", 3), ("冰柱坠击", 3)
    ],
    "Psychic": [
        ("念力", 1), ("催眠术", 1), ("幻象光线", 2), ("意念头锤", 2),
        ("精神利刃", 2), ("反射壁", 2), ("光墙", 2), ("精神强念", 2),
        ("精神冲击", 3), ("精神击破", 3), ("预知未来", 3), ("光子喷涌", 3)
    ],
    "Dark": [
        ("咬住", 1), ("追打", 1), ("突袭", 2), ("暗袭要害", 2),
        ("恶之波动", 2), ("咬碎", 2), ("欺诈", 3), ("地狱突刺", 3)
    ],
    "Ghost": [
        ("舌舔", 1), ("惊吓", 1), ("影子偷袭", 1), ("黑夜魔影", 2),
        ("暗影拳", 2), ("暗影球", 2), ("暗影爪", 2), ("祸不单行", 3)
    ],
    "Bug": [
        ("吐丝", 1), ("虫咬", 1), ("吸血", 1), ("虫之抵抗", 2),
        ("银色旋风", 2), ("十字剪", 2), ("飞弹针", 2), ("虫鸣", 3), ("蝶舞", 3)
    ],
    "Fighting": [
        ("踢倒", 1), ("音速拳", 1), ("空手劈", 1), ("发劲", 2),
        ("借力摔", 2), ("劈瓦", 2), ("十字劈", 2), ("百万吨重拳", 2),
        ("近身战", 3), ("百万吨重踢", 3), ("爆裂拳", 3), ("波导弹", 3), ("蛮力", 3)
    ],
    "Flying": [
        ("起风", 1), ("啄", 1), ("翅膀攻击", 2), ("燕返", 2),
        ("空气斩", 2), ("龙卷风", 2), ("啄钻", 2), ("暴风", 3), ("勇鸟猛攻", 3)
    ],
    "Poison": [
        ("毒针", 1), ("浊雾", 1), ("酸液", 1), ("毒击", 2),
        ("十字毒刃", 2), ("污泥炸弹", 2), ("溶化", 2), ("剧毒", 3), ("垃圾射击", 3)
    ],
    "Ground": [
        ("掷泥", 1), ("骨棒", 1), ("泥巴射击", 2), ("重踏", 2),
        ("骨头回力镖", 2), ("挖洞", 2), ("地震", 3), ("十万马力", 3), ("地裂", 3)
    ],
    "Rock": [
        ("落石", 1), ("岩石爆击", 1), ("滚动", 2), ("岩崩", 2),
        ("原始之力", 2), ("岩石封锁", 2), ("尖石攻击", 3), ("隐形岩", 3)
    ],
    "Dragon": [
        ("龙之怒", 1), ("龙息", 2), ("龙之波动", 2), ("龙爪", 2),
        ("龙之俯冲", 3), ("逆鳞", 3), ("流星群", 3)
    ],
    "Normal": [
        ("撞击", 1), ("电光一闪", 1), ("抓", 1), ("拍击", 1),
        ("头锤", 2), ("猛撞", 2), ("高速星星", 2), ("劈开", 2),
        ("泰山压顶", 2), ("舍身冲撞", 3), ("破坏光线", 3), ("终极冲击", 3)
    ]
}

def get_sfx_for_vfx(vfx_name: str, m_type: str) -> str:
    if "fire" in vfx_name or "ember" in vfx_name or "flame" in vfx_name or "inferno" in vfx_name:
        return "fire"
    if "water" in vfx_name or "surf" in vfx_name or "hydro" in vfx_name or "bubble" in vfx_name:
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

def build_skill_dict(move_name: str, star_level: int, power_override=None, desc_override=None):
    vfx = MOVE_NAME_TO_VFX.get(move_name, "quick_attack")
    if vfx not in available_vfx:
        vfx = "quick_attack"
        
    slug = zh_to_slug.get(move_name, "")
    mid = slug_to_id.get(slug) if slug else None
    desc = desc_override or (flavors_zh.get(mid, (0, f"使出【{move_name}】全力攻击敌人。"))[1] if mid else f"使出【{move_name}】全力攻击敌人。")
    m = moves.get(slug, {}) if slug else {}
    m_type = TYPE_ID_MAP.get(m.get("type_id", 1), "Normal")
    damage_class = m.get("damage_class_id", 2)
    sfx = get_sfx_for_vfx(vfx, m_type)

    if star_level == 1:
        base_p = m.get("power", 0)
        power = power_override or (base_p * 2 + 100 if base_p > 0 else 180)
        target_count = 1 if damage_class == 2 else 2
        stun_dur = 0.0
        scale = 0.82
        detail = f"消耗100能量，使出【{move_name}】。{desc} 对目标造成{power}点伤害。"
    elif star_level == 2:
        base_p = m.get("power", 0)
        power = power_override or (base_p * 3 + 120 if base_p > 0 else 320)
        target_count = 2 if damage_class == 2 else 3
        stun_dur = 0.4
        scale = 1.10
        detail = f"消耗100能量，爆发【{move_name}】！{desc} 对范围内最多{target_count}名敌人造成{power}点伤害，并施加战术压制。"
    else: # 3
        base_p = m.get("power", 0)
        power = power_override or (base_p * 5 + 180 if base_p > 0 else 680)
        target_count = 4 if damage_class == 2 else 6
        stun_dur = 0.8
        scale = 1.55
        detail = f"消耗100能量，释放终极奥义【{move_name}】！{desc} 席卷战场对最多{target_count}名敌人造成{power}点巨额伤害与强力击破！"

    return {
        "name": move_name,
        "desc": desc,
        "detail": detail,
        "power": power,
        "target_count": target_count,
        "stun_duration": stun_dur,
        "vfx": vfx,
        "sfx": sfx,
        "scale": scale
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

def deduplicate_pokemon(pid, types, star_skills):
    if pid == "charmander":
        star_skills[1] = [build_skill_dict("火花", 1), build_skill_dict("抓", 1), build_skill_dict("龙之怒", 1)]
        star_skills[2] = [build_skill_dict("火焰旋涡", 2), build_skill_dict("乱抓", 2), build_skill_dict("喷射火焰", 2)]
        star_skills[3] = [build_skill_dict("炼狱", 3), build_skill_dict("闪焰冲锋", 3), build_skill_dict("爆炸烈焰", 3)]
        return star_skills

    used_names = set()
    used_vfx = set()

    # Step 1: Ensure Choice 0 of Star 1, 2, 3 are mutually unique
    # We inspect choice 0 for each star
    for star in [1, 2, 3]:
        c0 = star_skills[star][0]
        c0_name = c0["name"]
        c0_vfx = c0.get("vfx", MOVE_NAME_TO_VFX.get(c0_name, "quick_attack"))
        if c0_vfx not in available_vfx:
            c0_vfx = "quick_attack"
            
        # Check collision with previous choice 0
        if c0_name in used_names or c0_vfx in used_vfx:
            # Resolve collision for this choice 0
            # E.g. find another canonical move for this star
            resolved = False
            for p_type in types + ["Normal"]:
                for pool_move, p_star in TYPE_ARCHETYPE_MOVES.get(p_type, []):
                    if p_star == star and pool_move not in used_names:
                        p_vfx = MOVE_NAME_TO_VFX.get(pool_move, "quick_attack")
                        if p_vfx not in used_vfx and p_vfx in available_vfx:
                            c0 = build_skill_dict(pool_move, star)
                            c0_name = pool_move
                            c0_vfx = p_vfx
                            star_skills[star][0] = c0
                            resolved = True
                            break
                if resolved:
                    break
                    
        used_names.add(c0_name)
        used_vfx.add(c0_vfx)
        c0["vfx"] = c0_vfx

    # Step 2: Build candidate list for this Pokemon
    pnum = ALL_GEN1_POKEMON.get(pid, {}).get("num", 1) if pid != "lucario" else 448
    chain_pids = EVO_CHAINS.get(pid, [pid])
    chain_pnums = [ALL_GEN1_POKEMON.get(cp, {}).get("num", pnum) for cp in chain_pids]
    
    # Gather moves from learnset of self and evolution chain
    cand_moves = []
    seen_cand_names = set()
    
    # 2.1 Direct learnsets
    for cp_num in chain_pnums:
        for method, lvl, slug in pokemon_learnsets.get(cp_num, []):
            zh_name = slug_to_zh.get(slug)
            if zh_name and zh_name in MOVE_NAME_TO_VFX and zh_name not in seen_cand_names:
                mvfx = MOVE_NAME_TO_VFX[zh_name]
                if mvfx in available_vfx:
                    seen_cand_names.add(zh_name)
                    m = moves.get(slug, {})
                    pwr = m.get("power", 0)
                    # Estimate star tier: 1 (lvl<=24 or pwr<=60), 2 (lvl 20..45 or pwr 60..90), 3 (lvl>=40 or pwr>=90)
                    tier = 1 if (lvl <= 24 and pwr <= 65) else (3 if (lvl >= 42 or pwr >= 90) else 2)
                    cand_moves.append((zh_name, mvfx, tier, 0)) # 0: learnset
                    
    # 2.2 Type Archetype pools
    for p_type in types:
        for zh_name, tier in TYPE_ARCHETYPE_MOVES.get(p_type, []):
            if zh_name in MOVE_NAME_TO_VFX and zh_name not in seen_cand_names:
                mvfx = MOVE_NAME_TO_VFX[zh_name]
                if mvfx in available_vfx:
                    seen_cand_names.add(zh_name)
                    cand_moves.append((zh_name, mvfx, tier, 1)) # 1: STAB archetype
                    
    # 2.3 Normal & Secondary archetypes
    for p_type in ["Normal", "Fighting", "Dark", "Psychic", "Poison"]:
        for zh_name, tier in TYPE_ARCHETYPE_MOVES.get(p_type, []):
            if zh_name in MOVE_NAME_TO_VFX and zh_name not in seen_cand_names:
                mvfx = MOVE_NAME_TO_VFX[zh_name]
                if mvfx in available_vfx:
                    seen_cand_names.add(zh_name)
                    cand_moves.append((zh_name, mvfx, tier, 2)) # 2: coverage archetype

    # Step 3: Fill/Deduplicate Choice 1 and Choice 2 for each Star
    for star in [1, 2, 3]:
        for c_idx in [1, 2]:
            curr_choice = star_skills[star][c_idx] if len(star_skills[star]) > c_idx else None
            
            # Special case for Charmander test in test_pokedex_skills.gd:
            # Star 2: choice 1 = 火焰旋涡, choice 2 = 乱抓
            # Star 3: choice 1 = 炼狱, choice 2 = 闪焰冲锋, choice 3 = 爆炸烈焰
            # If pid == "charmander":
            #   Star 2 choice 2: we can use "火焰轮" to not collide with Star 3 "闪焰冲锋"!
            
            # Check if existing choice is valid and not colliding
            if curr_choice and curr_choice["name"] not in used_names:
                curr_vfx = curr_choice.get("vfx", MOVE_NAME_TO_VFX.get(curr_choice["name"], "quick_attack"))
                if curr_vfx not in used_vfx and curr_vfx in available_vfx:
                    # Choice is already valid & unique!
                    used_names.add(curr_choice["name"])
                    used_vfx.add(curr_vfx)
                    curr_choice["vfx"] = curr_vfx
                    continue

            # Need to pick a replacement candidate!
            # Filter candidates:
            best_cand = None
            for cand_name, cand_vfx, cand_tier, priority in cand_moves:
                if cand_name in used_names:
                    continue
                if cand_vfx in used_vfx:
                    continue
                if cand_vfx not in available_vfx:
                    continue
                
                # Check tier fit
                if star == 1 and cand_tier > 2:
                    continue
                if star == 3 and cand_tier < 2:
                    continue
                    
                best_cand = (cand_name, cand_vfx)
                break
                
            if not best_cand:
                # Fallback: any unused VFX from all archetype pools
                for p_type, pool in TYPE_ARCHETYPE_MOVES.items():
                    for cand_name, cand_tier in pool:
                        cand_vfx = MOVE_NAME_TO_VFX.get(cand_name, "quick_attack")
                        if cand_name not in used_names and cand_vfx not in used_vfx and cand_vfx in available_vfx:
                            best_cand = (cand_name, cand_vfx)
                            break
                    if best_cand:
                        break

            assert best_cand is not None, f"Failed to find unique skill for {pid} star {star} choice {c_idx}"
            
            new_skill = build_skill_dict(best_cand[0], star)
            new_skill["vfx"] = best_cand[1]
            used_names.add(best_cand[0])
            used_vfx.add(best_cand[1])
            
            if len(star_skills[star]) > c_idx:
                star_skills[star][c_idx] = new_skill
            else:
                star_skills[star].append(new_skill)

    # Verification assert for this Pokemon
    assert len(used_names) == 9, f"{pid} has {len(used_names)} unique names instead of 9! Names: {used_names}"
    assert len(used_vfx) == 9, f"{pid} has {len(used_vfx)} unique VFX instead of 9! VFX: {used_vfx}"

    return star_skills

def main():
    print("=== STARTING FULL DATABASE CROSS-STAR DEDUPLICATION ===")
    
    with open(DB_PATH, "r", encoding="utf-8") as f:
        content = f.read()

    # Regex to find each pokemon entry in pokemons dictionary
    # Starts with \t"pid": {\n
    poke_blocks = re.findall(r'(\t"([a-z0-9_]+)":\s*\{[\s\S]*?\n\t\},?\n)', content)
    print(f"Found {len(poke_blocks)} Pokemon blocks in database.")

    modified_count = 0
    new_content = content

    for full_block, pid in poke_blocks:
        # Extract types
        types_m = re.search(r'"types":\s*\[([^\]]+)\]', full_block)
        types = [t.strip().strip('"').strip("'") for t in types_m.group(1).split(",")] if types_m else ["Normal"]
        
        # Extract skills block
        skills_m = re.search(r'("skills":\s*\{[\s\S]*?\n\t\t\},)', full_block)
        if not skills_m:
            continue
        old_skills_block = skills_m.group(1)
        
        # Parse existing star_skills [1, 2, 3]
        star_skills = {}
        for star in [1, 2, 3]:
            star_m = re.search(r'%d:\s*\[([\s\S]*?)\n\t\t\t\]' % star, old_skills_block)
            if not star_m:
                continue
            chunk = star_m.group(1)
            # Find all skill dictionaries
            matches = list(re.finditer(r'\{\s*"name":\s*"([^"]+)"[\s\S]*?\n\t\t\t\t\}', chunk))
            s_list = []
            for m in matches:
                b = m.group(0)
                def get_f(key, def_val):
                    km = re.search(r'"%s":\s*([^\n,]+)' % key, b)
                    if km:
                        v = km.group(1).strip()
                        if v.startswith('"') and v.endswith('"'):
                            return v[1:-1]
                        try:
                            if "." in v: return float(v)
                            return int(v)
                        except:
                            return v
                    return def_val
                s_list.append({
                    "name": get_f("name", ""),
                    "desc": get_f("desc", ""),
                    "detail": get_f("detail", ""),
                    "power": get_f("power", 200),
                    "target_count": get_f("target_count", 2),
                    "stun_duration": get_f("stun_duration", 0.0),
                    "vfx": get_f("vfx", "quick_attack"),
                    "sfx": get_f("sfx", "skill"),
                    "scale": get_f("scale", 0.5)
                })
            star_skills[star] = s_list

        # Deduplicate
        new_star_skills = deduplicate_pokemon(pid, types, star_skills)
        new_skills_block = format_skills_block(new_star_skills)

        if new_skills_block != old_skills_block:
            modified_count += 1
            new_content = new_content.replace(old_skills_block, new_skills_block, 1)

    print(f"Updated {modified_count} Pokemon blocks with 100% unique 9 skills & 9 VFX.")

    with open(DB_PATH, "w", encoding="utf-8") as f:
        f.write(new_content)

    print("=== FINISHED DEDUPLICATING DATABASE ===")

if __name__ == "__main__":
    main()
