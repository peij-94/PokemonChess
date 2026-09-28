import json
import re
from gen1_data import ALL_GEN1_POKEMON

EXISTING_IDS = {
    "charmander", "squirtle", "bulbasaur", "machop", "pikachu", 
    "gengar", "snorlax", "alakazam", "charizard", "gyarados", 
    "dragonite", "mewtwo", "eevee", "growlithe", "psyduck", 
    "electabuzz", "lapras", "lucario"
}

with open("scripts/autoload/pokemon_database.gd", "r", encoding="utf-8") as f:
    text = f.read()

# 1. Prepare Pokemon insertion
new_pokemon_list = []
for pid, p in ALL_GEN1_POKEMON.items():
    if pid in EXISTING_IDS:
        continue
    code = f"""\t"{pid}": {{
\t\t"id": "{p["id"]}",
\t\t"name": "{p["name"]}",
\t\t"title": "{p.get("title", "")}",
\t\t"cost": {p["cost"]},
\t\t"types": {json.dumps(p["types"])},
\t\t"hp": {p["hp"]},
\t\t"atk": {p["atk"]},
\t\t"armor": {p["armor"]},
\t\t"mr": {p["mr"]},
\t\t"range": {p["range"]},
\t\t"atk_speed": {p["atk_speed"]},
\t\t"max_mana": {p["max_mana"]},
\t\t"desc": "{p.get("desc", "")}",
\t\t"skill_name": "{p.get("skill_name", "")}",
\t\t"skill_desc": "{p.get("skill_desc", "")}",
\t\t"skill_detail": "{p.get("skill_detail", "")}",
\t\t"skill_power": {p.get("skill_power", 200)},
\t\t"skills": {{
\t\t\t1: {{
\t\t\t\t"name": "{p["skills"][1]["name"]}",
\t\t\t\t"desc": "{p["skills"][1]["desc"]}",
\t\t\t\t"detail": "{p["skills"][1]["detail"]}",
\t\t\t\t"power": {p["skills"][1]["power"]},
\t\t\t\t"vfx": "{p["skills"][1]["vfx"]}",
\t\t\t\t"sfx": "{p["skills"][1]["sfx"]}",
\t\t\t\t"scale": {p["skills"][1]["scale"]}
\t\t\t}},
\t\t\t2: {{
\t\t\t\t"name": "{p["skills"][2]["name"]}",
\t\t\t\t"desc": "{p["skills"][2]["desc"]}",
\t\t\t\t"detail": "{p["skills"][2]["detail"]}",
\t\t\t\t"power": {p["skills"][2]["power"]},
\t\t\t\t"vfx": "{p["skills"][2]["vfx"]}",
\t\t\t\t"sfx": "{p["skills"][2]["sfx"]}",
\t\t\t\t"scale": {p["skills"][2]["scale"]}
\t\t\t}},
\t\t\t3: {{
\t\t\t\t"name": "{p["skills"][3]["name"]}",
\t\t\t\t"desc": "{p["skills"][3]["desc"]}",
\t\t\t\t"detail": "{p["skills"][3]["detail"]}",
\t\t\t\t"power": {p["skills"][3]["power"]},
\t\t\t\t"vfx": "{p["skills"][3]["vfx"]}",
\t\t\t\t"sfx": "{p["skills"][3]["sfx"]}",
\t\t\t\t"scale": {p["skills"][3]["scale"]}
\t\t\t}}
\t\t}},
\t\t"icon": "res://assets/units/{pid}.png"
\t}}"""
    new_pokemon_list.append(code)

pokemon_insert_str = ",\n" + ",\n".join(new_pokemon_list)

old_lucario_mark = '\t\t"icon": "res://assets/units/lucario.png"\n\t}\n}'
assert old_lucario_mark in text, "lucario mark not found!"
new_lucario_mark = '\t\t"icon": "res://assets/units/lucario.png"\n\t}' + pokemon_insert_str + '\n}'
text = text.replace(old_lucario_mark, new_lucario_mark, 1)

# 2. Add 6 new synergies
new_synergies = """,
\t"Poison": {
\t\t"name": "毒系",
\t\t"icon": "res://assets/ui/type_poison.png",
\t\t"tiers": [
\t\t\t{"count": 2, "desc": "友军普攻与技能附加剧毒，每秒造成25点真实伤害并降低敌方20%双抗"},
\t\t\t{"count": 4, "desc": "剧毒伤害提升至每秒60点，敌方双抗降低40%"}
\t\t]
\t},
\t"Bug": {
\t\t"name": "虫系",
\t\t"icon": "res://assets/ui/type_bug.png",
\t\t"tiers": [
\t\t\t{"count": 2, "desc": "虫系单位攻速+30%，每次普攻获得额外+5点能量"},
\t\t\t{"count": 4, "desc": "全队攻速+45%，开局获得30点初始能量"}
\t\t]
\t},
\t"Flying": {
\t\t"name": "飞行系",
\t\t"icon": "res://assets/ui/type_flying.png",
\t\t"tiers": [
\t\t\t{"count": 2, "desc": "飞行系单位获得25%物理闪避率，移动速度+30%"},
\t\t\t{"count": 4, "desc": "全队获得30%闪避率，闪避成功时回复自身5%最大生命值"}
\t\t]
\t},
\t"Ground": {
\t\t"name": "地面系",
\t\t"icon": "res://assets/ui/type_ground.png",
\t\t"tiers": [
\t\t\t{"count": 2, "desc": "地面系单位攻击附带震荡波，削弱目标30%护甲，自身护甲+30"},
\t\t\t{"count": 4, "desc": "全队护甲+60，技能伤害附带30%真实破甲伤害"}
\t\t]
\t},
\t"Rock": {
\t\t"name": "岩石系",
\t\t"icon": "res://assets/ui/type_rock.png",
\t\t"tiers": [
\t\t\t{"count": 2, "desc": "战斗开始时全队获得300点坚岩护盾，受到暴击伤害降低50%"},
\t\t\t{"count": 4, "desc": "坚岩护盾提升至650点，护盾存在期间免控并反弹20%受到的伤害"}
\t\t]
\t},
\t"Ice": {
\t\t"name": "冰系",
\t\t"icon": "res://assets/ui/type_ice.png",
\t\t"tiers": [
\t\t\t{"count": 2, "desc": "冰系技能使目标减速40%，对受控目标造成伤害提升30%"},
\t\t\t{"count": 4, "desc": "全队普攻有20%几率冰冻目标1秒，对冰冻目标造成伤害提升60%"}
\t\t]
\t}"""

ghost_end = '\t"Ghost": {\n\t\t"name": "幽灵系",\n\t\t"icon": "res://assets/ui/type_ghost.png",\n\t\t"tiers": [\n\t\t\t{"count": 1, "desc": "拥有25%物理闪避几率，攻击无视目标20点护甲"}\n\t\t]\n\t}'
assert ghost_end in text, "ghost mark not found!"
text = text.replace(ghost_end, ghost_end + new_synergies, 1)

with open("scripts/autoload/pokemon_database.gd", "w", encoding="utf-8") as f:
    f.write(text)

print("pokemon_database.gd successfully updated with all 151 Pokemon + 6 new synergies!")
