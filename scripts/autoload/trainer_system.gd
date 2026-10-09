extends Node

# TrainerSystem: Manages Trainer Avatars, Passives, and Active Tactical Skills (Module 4)
# Follows classic 2D retro & Dream World aesthetics with zero 3D dependencies.

signal trainer_changed(trainer_id: String, trainer_data: Dictionary)
signal tactic_cast(trainer_id: String, tactic_info: Dictionary)
signal cooldown_changed(current_cooldown: int, max_cooldown: int)
signal tactic_ready(trainer_id: String)
signal tactic_effect_triggered(trainer_id: String, details: Dictionary)

const SAVE_PATH: String = "user://trainer_preference.json"
const TACTIC_MAX_CD: int = 3

const TRAINERS: Dictionary = {
	"red": {
		"id": "red",
		"name": "赤红 (Red)",
		"title": "真新镇传奇 • 宝可梦大师",
		"theme_color": Color(0.95, 0.25, 0.25),
		"avatar_path": "res://assets/ui/trainers/red.png",
		"passive_name": "真新意志",
		"passive_desc": "生命值 ≤ 50% 的友方单位攻击力提升 20%。",
		"passive_short": "残血友军攻击力 +20%",
		"tactic_name": "全员鼓舞",
		"tactic_desc": "全体友军获得 30% 攻速提升，持续 5.0 秒。",
		"tactic_cd": 3,
		"tactic_icon": "⚡"
	},
	"misty": {
		"id": "misty",
		"name": "小霞 (Misty)",
		"title": "华蓝道馆馆主 • 俏皮的美人鱼",
		"theme_color": Color(0.2, 0.65, 0.98),
		"avatar_path": "res://assets/ui/trainers/misty.png",
		"passive_name": "生命之泉",
		"passive_desc": "友军受到的所有治疗量与护盾效果提升 25%。",
		"passive_short": "友军治疗与护盾 +25%",
		"tactic_name": "水流环",
		"tactic_desc": "为当前生命百分比最低的 2 只友军回复 350 点生命值并驱散控制状态。",
		"tactic_cd": 3,
		"tactic_icon": "💧"
	},
	"steven": {
		"id": "steven",
		"name": "大吾 (Steven)",
		"title": "丰缘冠军 • 高贵岩石收藏家",
		"theme_color": Color(0.7, 0.8, 0.92),
		"avatar_path": "res://assets/ui/trainers/steven.png",
		"passive_name": "钢铁之躯",
		"passive_desc": "全队常驻获得 +25 物理护甲与 +25 魔法抗性。",
		"passive_short": "全队常驻 +25 双抗",
		"tactic_name": "流星落",
		"tactic_desc": "轰击敌方最高攻击力单位造成 450 真实伤害并眩晕 1.5 秒。",
		"tactic_cd": 3,
		"tactic_icon": "☄️"
	},
	"cynthia": {
		"id": "cynthia",
		"name": "竹兰 (Cynthia)",
		"title": "神奥冠军 • 考古学者",
		"theme_color": Color(0.98, 0.82, 0.25),
		"avatar_path": "res://assets/ui/trainers/cynthia.png",
		"passive_name": "神奥庇护",
		"passive_desc": "全队暴击率提升 15%，暴击伤害提升 25%。",
		"passive_short": "全队暴击率 +15% / 暴伤 +25%",
		"tactic_name": "波导共鸣",
		"tactic_desc": "立即为所有友军瞬间充能 30 点法力值。",
		"tactic_cd": 3,
		"tactic_icon": "🔵"
	},
	"giovanni": {
		"id": "giovanni",
		"name": "坂木 (Giovanni)",
		"title": "火箭队首领 • 常青道馆馆主",
		"theme_color": Color(0.85, 0.3, 0.9),
		"avatar_path": "res://assets/ui/trainers/giovanni.png",
		"passive_name": "火箭队底蕴",
		"passive_desc": "利息上限提升至 6 金币（原本 5）。",
		"passive_short": "利息上限提升至 6 金币",
		"tactic_name": "战术征用",
		"tactic_desc": "立即获得 4 枚应急金币。",
		"tactic_cd": 3,
		"tactic_icon": "💰"
	}
}

var current_trainer_id: String = "red"
var current_cooldown: int = 0
var max_cooldown: int = TACTIC_MAX_CD

func _ready() -> void:
	load_trainer_preference()
	
	# Connect to GameManager round advance to decrement cooldown
	if GameManager:
		if not GameManager.round_changed.is_connected(_on_game_round_changed):
			GameManager.round_changed.connect(_on_game_round_changed)
		if not GameManager.combat_ended.is_connected(_on_combat_ended):
			GameManager.combat_ended.connect(_on_combat_ended)

# -----------------------------------------------------------------------------
# Trainer Selection & Data Access
# -----------------------------------------------------------------------------
func select_trainer(trainer_id: String) -> bool:
	if not TRAINERS.has(trainer_id):
		push_warning("Unknown trainer_id: %s" % trainer_id)
		return false
	
	var old_id = current_trainer_id
	current_trainer_id = trainer_id
	save_trainer_preference()
	
	# If switched to/from Steven, refresh stats on existing units
	_update_team_passives_on_trainer_change(old_id, current_trainer_id)
	
	var data = get_current_trainer()
	trainer_changed.emit(current_trainer_id, data)
	return true

func get_current_trainer() -> Dictionary:
	return TRAINERS.get(current_trainer_id, TRAINERS["red"]).duplicate(true)

func get_trainer_data(trainer_id: String) -> Dictionary:
	if TRAINERS.has(trainer_id):
		return TRAINERS[trainer_id].duplicate(true)
	return {}

func get_all_trainers() -> Array[Dictionary]:
	var list: Array[Dictionary] = []
	for key in ["red", "misty", "steven", "cynthia", "giovanni"]:
		list.append(TRAINERS[key].duplicate(true))
	return list

# -----------------------------------------------------------------------------
# Cooldown & Tactical Execution
# -----------------------------------------------------------------------------
func can_cast_tactic(ignore_phase: bool = false) -> bool:
	if current_cooldown > 0:
		return false
	if not ignore_phase:
		if GameManager and GameManager.current_phase != GameManager.Phase.COMBAT:
			return false
	return true

func cast_active_tactic(force: bool = false) -> bool:
	if not can_cast_tactic(force):
		return false
	
	var trainer = get_current_trainer()
	var t_id = current_trainer_id
	var details: Dictionary = {}
	
	match t_id:
		"red":
			details = _execute_red_tactic()
		"misty":
			details = _execute_misty_tactic()
		"steven":
			details = _execute_steven_tactic()
		"cynthia":
			details = _execute_cynthia_tactic()
		"giovanni":
			details = _execute_giovanni_tactic()
	
	current_cooldown = max_cooldown
	cooldown_changed.emit(current_cooldown, max_cooldown)
	tactic_cast.emit(t_id, trainer)
	tactic_effect_triggered.emit(t_id, details)
	
	# Audio & Screen feedback
	if AudioManager:
		AudioManager.play_sfx("upgrade")
	if GameManager:
		GameManager.shake_camera(0.3, 0.25)
	
	return true

func _execute_red_tactic() -> Dictionary:
	# 全员鼓舞: 全体友军获得 30% 攻速提升，持续 5.0 秒
	var friendlies = get_alive_friendly_units()
	var count = 0
	for u in friendlies:
		if u != null and is_instance_valid(u) and not u.is_dead:
			u.atk_speed *= 1.30
			u.spawn_floating_text("⚡ 全员鼓舞! +30%攻速", Color(1.0, 0.35, 0.35), true, 0.6)
			count += 1
			_schedule_revert_red_buff(u, 1.30, 5.0)
	return {"buffed_units": count, "duration": 5.0, "atk_speed_bonus": 0.30}

func _schedule_revert_red_buff(unit: Node, mult: float, duration: float) -> void:
	var tree = get_tree()
	if not tree:
		return
	var timer = tree.create_timer(duration)
	timer.timeout.connect(func():
		if is_instance_valid(unit) and not unit.is_dead:
			unit.atk_speed /= mult
			unit.spawn_floating_text("鼓舞结束", Color(0.7, 0.7, 0.7))
	)

func _execute_misty_tactic() -> Dictionary:
	# 水流环: 为当前生命百分比最低的 2 只友军回复 350 点生命值并驱散控制状态
	var friendlies = get_alive_friendly_units()
	# Sort by HP percentage ascending
	friendlies.sort_custom(func(a, b):
		var pct_a = float(a.current_hp) / max(1.0, float(a.max_hp))
		var pct_b = float(b.current_hp) / max(1.0, float(b.max_hp))
		return pct_a < pct_b
	)
	
	var healed_units: Array = []
	var heal_val = 350.0
	for i in range(min(2, friendlies.size())):
		var u = friendlies[i]
		if u != null and is_instance_valid(u) and not u.is_dead:
			if u.has_method("cleanse_cc"):
				u.cleanse_cc()
			else:
				u.is_stunned = false
				u.stun_timer = 0.0
			u.heal(heal_val, true)
			u.spawn_floating_text("💧 水流环 净化+治愈!", Color(0.25, 0.8, 1.0), true, 0.6)
			healed_units.append(u)
			
	return {"healed_count": healed_units.size(), "base_heal": heal_val}

func _execute_steven_tactic() -> Dictionary:
	# 流星落: 轰击敌方最高攻击力单位造成 450 真实伤害并眩晕 1.5 秒
	var enemies = get_alive_enemy_units()
	if enemies.is_empty():
		return {"hit": false}
	
	# Find enemy with highest attack
	var target = enemies[0]
	var max_atk = -1.0
	for e in enemies:
		var e_atk = e.atk
		if e.has_method("get_effective_atk"):
			e_atk = e.get_effective_atk()
		if e_atk > max_atk:
			max_atk = e_atk
			target = e
			
	if target != null and is_instance_valid(target) and not target.is_dead:
		target.take_damage(450.0, false, true, true, null, true) # true damage
		target.apply_stun(1.5)
		target.spawn_floating_text("☄️ 流星落! 450真伤+眩晕", Color(1.0, 0.85, 0.2), true, 0.8)
		if GameManager:
			GameManager.shake_camera(0.6, 0.4)
		return {"hit": true, "target_atk": max_atk, "damage": 450.0, "stun": 1.5}
	return {"hit": false}

func _execute_cynthia_tactic() -> Dictionary:
	# 波导共鸣: 立即为所有友军瞬间充能 30 点法力值
	var friendlies = get_alive_friendly_units()
	var count = 0
	for u in friendlies:
		if u != null and is_instance_valid(u) and not u.is_dead:
			u.gain_mana(30.0)
			u.spawn_floating_text("🔵 波导共鸣 +30法力!", Color(0.4, 0.75, 1.0), true, 0.6)
			count += 1
	return {"charged_units": count, "mana_gain": 30.0}

func _execute_giovanni_tactic() -> Dictionary:
	# 战术征用: 立即获得 4 枚应急金币
	if GameManager:
		GameManager.add_gold(4)
	if AudioManager:
		AudioManager.play_sfx("coin")
	return {"gold_granted": 4}

# -----------------------------------------------------------------------------
# Round Pipeline & Cooldown Management
# -----------------------------------------------------------------------------
func _on_game_round_changed(_round_num: int) -> void:
	decrease_cooldown()

func _on_combat_ended(_player_won: bool) -> void:
	pass

func decrease_cooldown() -> void:
	if current_cooldown > 0:
		current_cooldown -= 1
		cooldown_changed.emit(current_cooldown, max_cooldown)
		if current_cooldown == 0:
			tactic_ready.emit(current_trainer_id)

func reset_cooldown() -> void:
	current_cooldown = 0
	cooldown_changed.emit(0, max_cooldown)
	tactic_ready.emit(current_trainer_id)

# -----------------------------------------------------------------------------
# Unit Queries Helper
# -----------------------------------------------------------------------------
func get_alive_friendly_units() -> Array:
	var result: Array = []
	var tree = get_tree()
	if not tree:
		return result
	var units = tree.get_nodes_in_group("units")
	for u in units:
		if u != null and is_instance_valid(u) and not u.is_dead and not u.is_enemy:
			result.append(u)
	return result

func get_alive_enemy_units() -> Array:
	var result: Array = []
	var tree = get_tree()
	if not tree:
		return result
	var units = tree.get_nodes_in_group("units")
	for u in units:
		if u != null and is_instance_valid(u) and not u.is_dead and u.is_enemy:
			result.append(u)
	return result

# -----------------------------------------------------------------------------
# Passive Helpers for Units & Economy
# -----------------------------------------------------------------------------
func has_red_passive() -> bool:
	return current_trainer_id == "red"

func get_red_atk_bonus(unit: Node = null) -> float:
	if not has_red_passive():
		return 0.0
	if unit == null:
		return 0.20
	if unit.current_hp <= unit.max_hp * 0.50:
		return 0.20
	return 0.0

func has_misty_passive() -> bool:
	return current_trainer_id == "misty"

func get_misty_heal_shield_bonus() -> float:
	return 0.25 if has_misty_passive() else 0.0

func has_steven_passive() -> bool:
	return current_trainer_id == "steven"

func get_steven_armor_bonus() -> float:
	return 25.0 if has_steven_passive() else 0.0

func get_steven_mr_bonus() -> float:
	return 25.0 if has_steven_passive() else 0.0

func has_cynthia_passive() -> bool:
	return current_trainer_id == "cynthia"

func get_cynthia_crit_chance_bonus() -> float:
	return 0.15 if has_cynthia_passive() else 0.0

func get_cynthia_crit_dmg_bonus() -> float:
	return 0.25 if has_cynthia_passive() else 0.0

func has_giovanni_passive() -> bool:
	return current_trainer_id == "giovanni"

func get_giovanni_max_interest() -> int:
	return 6 if has_giovanni_passive() else 5

func _update_team_passives_on_trainer_change(old_id: String, new_id: String) -> void:
	if old_id == new_id:
		return
	var friendlies = get_alive_friendly_units()
	# Handle Steven armor/mr transitions
	if old_id == "steven" and new_id != "steven":
		for u in friendlies:
			if u.has_meta("steven_passive_applied") and u.get_meta("steven_passive_applied") == true:
				u.armor = max(0.0, u.armor - 25.0)
				u.mr = max(0.0, u.mr - 25.0)
				u.set_meta("steven_passive_applied", false)
	elif new_id == "steven" and old_id != "steven":
		for u in friendlies:
			if not u.has_meta("steven_passive_applied") or u.get_meta("steven_passive_applied") == false:
				u.armor += 25.0
				u.mr += 25.0
				u.set_meta("steven_passive_applied", true)

# -----------------------------------------------------------------------------
# Persistence
# -----------------------------------------------------------------------------
func save_trainer_preference() -> void:
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		var data = {"selected_trainer": current_trainer_id}
		file.store_string(JSON.stringify(data))
		file.close()

func load_trainer_preference() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		current_trainer_id = "red"
		return
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file:
		var content = file.get_as_text()
		file.close()
		var parsed = JSON.parse_string(content)
		if parsed is Dictionary and parsed.has("selected_trainer"):
			var t_id = str(parsed["selected_trainer"])
			if TRAINERS.has(t_id):
				current_trainer_id = t_id
