extends Node

# ShinyAndLoreManager: Manages Shiny Pokemon mechanics and Classic Lore Synergies
# Follows master branch 2D pixel & dream world vector illustration guidelines.

signal lore_synergy_activated(synergy_data: Dictionary)
signal lore_synergy_deactivated(synergy_id: String)
signal shiny_card_generated(index: int, card_info: Dictionary)

const SHINY_CHANCE: float = 0.015 # 1.5% chance per shop card slot

const SHINY_AFFIXES: Array[String] = ["fortune", "aura", "iron_will"]

const SHINY_AFFIX_NAMES: Dictionary = {
	"fortune": "招财",
	"aura": "领袖光环",
	"iron_will": "坚韧之躯"
}

const SHINY_AFFIX_DESCRIPTIONS: Dictionary = {
	"fortune": "普攻 10% 概率掉落 1 金币",
	"aura": "周围 1 格友军攻速 +12%",
	"iron_will": "控制时间减免 35%，双抗 +15"
}

const LORE_SYNERGIES: Dictionary = {
	"pallet_town_trio": {
		"id": "pallet_town_trio",
		"name": "真新镇起航",
		"en_name": "Pallet Town Trio",
		"description": "喷火龙 + 水箭龟 + 妙蛙花：开局全员获得满法力并施放绝招",
		"required_pokemon": ["charizard", "blastoise", "venusaur"],
		"icon": "🔥💧🍃"
	},
	"weather_trio": {
		"id": "weather_trio",
		"name": "丰缘三神",
		"en_name": "Weather Trio",
		"description": "固拉多 + 盖欧卡 + 烈空坐：全场天候共鸣，技能威能 +30%",
		"required_pokemon": ["groudon", "kyogre", "rayquaza"],
		"icon": "🌋🌊🌪️"
	},
	"creation_trio": {
		"id": "creation_trio",
		"name": "时空创世",
		"en_name": "Creation Trio",
		"description": "帝牙卢卡 + 帕路奇亚 + (骑拉帝纳 或 阿尔宙斯)：时空扭曲，击杀敌方产生 1.5 秒范围眩晕",
		"icon": "⏳🌌✨"
	},
	"eeveelution_family": {
		"id": "eeveelution_family",
		"name": "伊布家族",
		"en_name": "Eeveelution Family",
		"description": "上阵 ≥3 种不同伊布进化形态：全员获得全属性抗性 +20 与 20% 生命护盾",
		"icon": "🦊💎🛡️"
	}
}

const EEVEELUTIONS: Array[String] = [
	"vaporeon", "jolteon", "flareon", "espeon", "umbreon", "leafeon", "glaceon"
]

var force_shiny: bool = false
var force_affix: String = "" # Optional forced affix for sandbox/testing
var shop_shiny_data: Dictionary = {} # slot_index -> { "is_shiny": bool, "affix": String }
var active_lore_synergies: Array[Dictionary] = []
var active_lore_ids: Dictionary = {}

func _ready() -> void:
	shop_shiny_data.clear()
	active_lore_synergies.clear()
	active_lore_ids.clear()

# --- SHINY SHOP MECHANICS ---

func roll_shop_shiny(slot_index: int) -> Dictionary:
	var is_shiny = force_shiny or (randf() < SHINY_CHANCE)
	var affix = ""
	if is_shiny:
		if force_affix != "" and SHINY_AFFIXES.has(force_affix):
			affix = force_affix
		else:
			affix = SHINY_AFFIXES.pick_random()
			
	var info = {
		"is_shiny": is_shiny,
		"affix": affix
	}
	shop_shiny_data[slot_index] = info
	if is_shiny:
		shiny_card_generated.emit(slot_index, info)
	return info

func on_shop_refreshed(cards_count: int = 5) -> void:
	shop_shiny_data.clear()
	for i in range(cards_count):
		roll_shop_shiny(i)

func get_shop_card_shiny_info(slot_index: int) -> Dictionary:
	return shop_shiny_data.get(slot_index, { "is_shiny": false, "affix": "" })

func set_shop_card_shiny(slot_index: int, p_is_shiny: bool, p_affix: String = "") -> void:
	var affix = p_affix
	if p_is_shiny and affix == "":
		affix = SHINY_AFFIXES.pick_random()
	var info = {
		"is_shiny": p_is_shiny,
		"affix": affix if p_is_shiny else ""
	}
	shop_shiny_data[slot_index] = info

func consume_shop_card(slot_index: int) -> Dictionary:
	var info = shop_shiny_data.get(slot_index, { "is_shiny": false, "affix": "" })
	shop_shiny_data.erase(slot_index)
	return info

func get_affix_name(affix: String) -> String:
	return SHINY_AFFIX_NAMES.get(affix, "")

func get_affix_description(affix: String) -> String:
	return SHINY_AFFIX_DESCRIPTIONS.get(affix, "")

# --- LORE SYNERGIES DETECTION ---

func check_lore_synergies(deployed_units: Array) -> Array[Dictionary]:
	var unique_pids: Dictionary = {}
	for item in deployed_units:
		if item == null:
			continue
		var pid = ""
		if item is Unit:
			var u = item as Unit
			if not is_instance_valid(u) or u.is_dead or u.is_enemy:
				continue
			pid = u.pokemon_id
		elif item is String:
			pid = item
		elif item is Dictionary:
			pid = item.get("id", item.get("pokemon_id", ""))
		
		if pid != "":
			unique_pids[pid] = true

	var detected: Array[Dictionary] = []
	var detected_ids: Dictionary = {}

	# 1. 【真新镇起航】(Pallet Town Trio): 喷火龙 + 水箭龟 + 妙蛙花
	if unique_pids.has("charizard") and unique_pids.has("blastoise") and unique_pids.has("venusaur"):
		var syn = LORE_SYNERGIES["pallet_town_trio"].duplicate(true)
		syn["active"] = true
		detected.append(syn)
		detected_ids["pallet_town_trio"] = true

	# 2. 【丰缘三神】(Weather Trio): 固拉多 + 盖欧卡 + 烈空坐
	if unique_pids.has("groudon") and unique_pids.has("kyogre") and unique_pids.has("rayquaza"):
		var syn = LORE_SYNERGIES["weather_trio"].duplicate(true)
		syn["active"] = true
		detected.append(syn)
		detected_ids["weather_trio"] = true

	# 3. 【时空创世】(Creation Trio): 帝牙卢卡 + 帕路奇亚 + (骑拉帝纳 或 阿尔宙斯)
	if unique_pids.has("dialga") and unique_pids.has("palkia") and (unique_pids.has("giratina") or unique_pids.has("arceus")):
		var syn = LORE_SYNERGIES["creation_trio"].duplicate(true)
		syn["active"] = true
		detected.append(syn)
		detected_ids["creation_trio"] = true

	# 4. 【伊布家族】(Eeveelution Family): 上阵 ≥3 种不同伊布进化形态
	var eeveelution_count = 0
	var matched_eeveelutions: Array[String] = []
	for form in EEVEELUTIONS:
		if unique_pids.has(form):
			eeveelution_count += 1
			matched_eeveelutions.append(form)
	if eeveelution_count >= 3:
		var syn = LORE_SYNERGIES["eeveelution_family"].duplicate(true)
		syn["active"] = true
		syn["matched_forms"] = matched_eeveelutions
		detected.append(syn)
		detected_ids["eeveelution_family"] = true

	# Check for new activations to broadcast
	for syn in detected:
		var sid = syn["id"]
		if not active_lore_ids.has(sid):
			lore_synergy_activated.emit(syn)
			broadcast_lore_synergy(syn)

	for old_id in active_lore_ids:
		if not detected_ids.has(old_id):
			lore_synergy_deactivated.emit(old_id)

	active_lore_synergies = detected
	active_lore_ids = detected_ids
	return active_lore_synergies

func is_lore_synergy_active(synergy_id: String) -> bool:
	return active_lore_ids.get(synergy_id, false)

func get_active_lore_synergies() -> Array[Dictionary]:
	return active_lore_synergies

func broadcast_lore_synergy(synergy: Dictionary) -> void:
	var msg = "🌟【经典情怀羁绊激活】%s：%s" % [synergy.get("name", ""), synergy.get("description", "")]
	print("[ShinyAndLoreManager] ", msg)
	if GameManager.hud_ref:
		if GameManager.hud_ref.has_method("show_lore_synergy_banner"):
			GameManager.hud_ref.show_lore_synergy_banner(synergy)
		elif GameManager.hud_ref.has_method("show_toast"):
			GameManager.hud_ref.show_toast(msg, Color(1.0, 0.85, 0.2))

# --- COMBAT ROUND TRIGGERS ---

func apply_combat_start_effects(player_units: Array, _enemy_units: Array = []) -> void:
	# Filter live player units
	var live_player_units: Array[Unit] = []
	for u in player_units:
		if u != null and is_instance_valid(u) and not u.is_dead and not u.is_enemy:
			live_player_units.append(u)

	# 1. Shiny "aura" affix: Surrounding 1 tile allies get +12% attack speed
	for u in live_player_units:
		if u.is_shiny and u.shiny_affix == "aura":
			for ally in live_player_units:
				if ally == u:
					continue
				var is_neighbor = false
				if u.grid_coord.x >= 0 and ally.grid_coord.x >= 0:
					is_neighbor = max(abs(u.grid_coord.x - ally.grid_coord.x), abs(u.grid_coord.y - ally.grid_coord.y)) <= 1
				else:
					is_neighbor = u.position.distance_to(ally.position) <= 96.0
				
				if is_neighbor:
					ally.atk_speed += ally.atk_speed * 0.12
					ally.spawn_floating_text("领袖光环! +12%攻速", Color(1.0, 0.85, 0.3), true)

	# 2. Lore: Pallet Town Trio (真新镇起航) - 开局全员获得满法力/50法力并施放绝招
	if is_lore_synergy_active("pallet_town_trio"):
		for u in live_player_units:
			u.current_mana = max(50.0, u.max_mana)
			u.update_bars()
			u.call_deferred("cast_skill")
			u.spawn_floating_text("真新镇起航! 绝招齐发!", Color(1.0, 0.45, 0.2), true)

	# 3. Lore: Eeveelution Family (伊布家族) - 全员获得全属性抗性 +20 与 20% 生命护盾
	if is_lore_synergy_active("eeveelution_family"):
		for u in live_player_units:
			u.armor += 20.0
			u.mr += 20.0
			u.shield += u.max_hp * 0.20
			u.update_bars()
			u.spawn_floating_text("伊布家族! 双抗+20 护盾+20%", Color(1.0, 0.8, 0.4), true)

func trigger_creation_trio_stun(killed_unit: Unit) -> void:
	if not is_lore_synergy_active("creation_trio"):
		return
	if killed_unit == null or not is_instance_valid(killed_unit):
		return
		
	var tree = killed_unit.get_tree()
	if tree == null:
		return
		
	var units = tree.get_nodes_in_group("units")
	for u in units:
		if u != null and is_instance_valid(u) and not u.is_dead and u != killed_unit:
			# Stun enemy units in area around the fallen enemy
			if u.is_enemy == killed_unit.is_enemy:
				var dist = killed_unit.position.distance_to(u.position)
				if dist <= 160.0 or (killed_unit.grid_coord.x >= 0 and u.grid_coord.x >= 0 and max(abs(killed_unit.grid_coord.x - u.grid_coord.x), abs(killed_unit.grid_coord.y - u.grid_coord.y)) <= 2):
					u.apply_stun(1.5)
					u.spawn_floating_text("时空扭曲! 眩晕1.5s", Color(0.7, 0.45, 1.0), true)
