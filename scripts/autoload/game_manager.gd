extends Node

const FloatingTextPool = preload("res://scripts/floating_text_pool.gd")

# GameManager: Core game state, player economy, phase loops, and evolution logic

signal gold_changed(new_val: int, delta: int)
signal hp_changed(new_val: int, delta: int)
signal level_changed(new_level: int, current_exp: int, max_exp: int)
signal phase_changed(new_phase: String, time_left: float)
signal round_changed(new_round: int)
signal shop_refreshed(cards: Array)
signal unit_evolved(unit_id: String, new_star: int)
signal skill_choice_requested(unit: Unit, star_level: int)
signal evolution_choice_requested(unit: Unit, evolution_options: Array)
signal unit_inspected(unit: Unit)
signal unit_drag_started(unit: Unit, refund: int)
signal unit_drag_hover_sell(is_hovering: bool)
signal unit_drag_ended(sold: bool)
signal combat_ended(player_won: bool)
signal background_changed(bg_path: String, arena_info: Dictionary)
signal arena_modifiers_updated(active_mods: Array, arena_info: Dictionary)
signal target_comp_updated(comp: Dictionary)
signal camera_shake_requested(trauma: float, duration: float)
signal cinematic_spotlight_requested(duration: float, darkness: float)
signal sandbox_mode_toggled(is_sandbox: bool)
signal gym_mode_entered(gym_index: int, gym_data: Dictionary)

func shake_camera(trauma: float = 0.5, duration: float = 0.25) -> void:
	camera_shake_requested.emit(trauma, duration)

func trigger_cinematic_spotlight(duration: float = 0.5, darkness: float = 0.45) -> void:
	cinematic_spotlight_requested.emit(duration, darkness)

const BATTLE_ARENAS: Array[Dictionary] = [
	{
		"id": "stadium",
		"name": "冠军联盟竞技场",
		"path": "res://assets/backgrounds/arena_stadium.jpg",
		"desc": "汇聚千万观众与绚丽烟火的宝可梦世界大赛主赛场",
		"modifiers": [
			{
				"stage": 1,
				"name": "聚光灯聚焦",
				"type": "buff",
				"desc": "全员注意力高度集中，暴击率提升 15%",
				"stat": "crit_chance",
				"val": 0.15
			},
			{
				"stage": 2,
				"name": "大赛气势",
				"type": "hybrid",
				"desc": "战斗开始获得 25 点初始法力，但首段受到的技能伤害增加 10%",
				"stat": "start_mana",
				"val": 25.0,
				"debuff_amp": 0.10
			},
			{
				"stage": 3,
				"name": "观众欢呼",
				"type": "buff",
				"desc": "敌方阵亡时全员恢复 80 点生命值并获得 15% 攻速",
				"stat": "kill_heal",
				"val": 80.0
			},
			{
				"stage": 4,
				"name": "终局决斗",
				"type": "buff",
				"desc": "我方存活少于 3 人时，攻击力与技能伤害提升 30%",
				"stat": "last_stand",
				"val": 0.30
			}
		]
	},
	{
		"id": "volcano",
		"name": "红莲熔岩火山群",
		"path": "res://assets/backgrounds/arena_volcano.jpg",
		"desc": "赤红玄武岩战台，滚滚熔岩溪流环绕的炎系试炼地",
		"modifiers": [
			{
				"stage": 1,
				"name": "熔岩地热",
				"type": "buff",
				"desc": "火系技能威力 +25%，普攻有 20% 几率灼烧目标（每秒 35 点真实伤害）",
				"stat": "fire_amp",
				"val": 0.25,
				"burn_chance": 0.20,
				"burn_dps": 35.0
			},
			{
				"stage": 2,
				"name": "焦土热浪",
				"type": "hybrid",
				"desc": "全体攻速 +18%；战斗 10 秒后非火系单位每秒受到微量环境灼伤",
				"stat": "atk_speed",
				"val": 0.18,
				"heat_wave_dps": 12.0
			},
			{
				"stage": 3,
				"name": "狂暴火山",
				"type": "buff",
				"desc": "生命值低于 40% 时爆发熔岩狂暴，立即获得 180 点护盾",
				"stat": "lava_shield",
				"val": 180.0
			},
			{
				"stage": 4,
				"name": "炼狱风暴",
				"type": "buff",
				"desc": "火系技能威力额外提升 35%，普攻暴击时引爆周围产生群体灼伤",
				"stat": "fire_crit_amp",
				"val": 0.35
			}
		]
	},
	{
		"id": "glacier",
		"name": "极地冰渊瀑布",
		"path": "res://assets/backgrounds/arena_glacier.jpg",
		"desc": "碧蓝幽光涌动的极寒冰泉与电光瀑布古迹",
		"modifiers": [
			{
				"stage": 1,
				"name": "极寒冰霜",
				"type": "hybrid",
				"desc": "水系与冰系生命恢复 +30%；普通攻击命中时降低目标 20% 攻速",
				"stat": "water_regen",
				"val": 0.30,
				"slow_ratio": 0.20
			},
			{
				"stage": 2,
				"name": "幽蓝电瀑",
				"type": "hybrid",
				"desc": "施法额外召唤落雷弹射（120伤害）；磁场干扰使回蓝速度 -10%",
				"stat": "lightning_proc",
				"val": 120.0,
				"mana_debuff": -0.10
			},
			{
				"stage": 3,
				"name": "极地绝对零度",
				"type": "buff",
				"desc": "战斗进行至 15 秒时，霜冻全场敌方单位 1.5 秒",
				"stat": "blizzard_freeze",
				"val": 1.5
			},
			{
				"stage": 4,
				"name": "极光庇佑",
				"type": "buff",
				"desc": "水系与冰系在战斗开始时获得 180 点极光护盾",
				"stat": "ice_shield",
				"val": 180.0
			}
		]
	},
	{
		"id": "astral",
		"name": "紫苑幽冥幻境",
		"path": "res://assets/backgrounds/arena_astral.jpg",
		"desc": "超梦与幽灵系盘踞的暗紫星穹与神秘符文擂台",
		"modifiers": [
			{
				"stage": 1,
				"name": "幽冥幻影",
				"type": "buff",
				"desc": "全员闪避率提升 15%；幽灵系与超能系闪避后额外恢复 15 点法力",
				"stat": "dodge_chance",
				"val": 0.15
			},
			{
				"stage": 2,
				"name": "念力潮涌",
				"type": "hybrid",
				"desc": "全体法术技能增幅 +20%；虚空侵蚀使全员护甲降低 12 点",
				"stat": "spell_amp",
				"val": 0.20,
				"armor_debuff": -12.0
			},
			{
				"stage": 3,
				"name": "灵魂收割",
				"type": "buff",
				"desc": "敌方单位阵亡时，随机一名友军夺取其 25% 攻击力直至战斗结束",
				"stat": "soul_steal",
				"val": 0.25
			},
			{
				"stage": 4,
				"name": "虚空主宰",
				"type": "buff",
				"desc": "超能系与幽灵系普通攻击附带 25% 真实伤害",
				"stat": "void_pierce",
				"val": 0.25
			}
		]
	},
	{
		"id": "emerald",
		"name": "烈空坐翡翠古殿",
		"path": "res://assets/backgrounds/arena_emerald.jpg",
		"desc": "蕴含青龙之力的荧光翡翠地宫与龙之遗迹",
		"modifiers": [
			{
				"stage": 1,
				"name": "龙神甘露",
				"type": "buff",
				"desc": "全队生命上限 +150；草系与龙系宝可梦每秒恢复 2% 最大生命值",
				"stat": "hp_bonus",
				"val": 150.0,
				"dragon_regen": 0.02
			},
			{
				"stage": 2,
				"name": "疾风领域",
				"type": "hybrid",
				"desc": "移动速度 +25%，攻击速度 +15%；由于强气流使护盾获取量降低 20%",
				"stat": "atk_speed",
				"val": 0.15,
				"shield_debuff": -0.20
			},
			{
				"stage": 3,
				"name": "龙威天罚",
				"type": "buff",
				"desc": "对生命值低于 25% 的敌人造成直接斩杀，并触发全屏翡翠龙吟",
				"stat": "execute_thresh",
				"val": 0.25
			},
			{
				"stage": 4,
				"name": "德尔塔气流",
				"type": "buff",
				"desc": "烈空坐领域守护全场：我方全员暴击伤害减免 30%，龙系技能伤害额外提升 30%",
				"stat": "delta_stream",
				"val": 0.30
			}
		]
	}
]

var current_arena_index: int = -1
var current_background_path: String = ""

enum Phase { PREPARATION, COMBAT, RESOLVE, GAME_OVER, VICTORY }

var current_phase: Phase = Phase.PREPARATION
var current_round: int = 1
var is_game_started: bool = true # Defaults to true for test scenes; set to false when on start menu
var is_sandbox_mode: bool = false
var is_gym_road_mode: bool = false
var active_gym_index: int = -1
var phase_timer: float = 20.0
const PREP_TIME: float = 20.0
const COMBAT_MAX_TIME: float = 40.0

# Player stats
var player_hp: int = 100
var gold: int = 10
var level: int = 1
var current_exp: int = 0
var win_streak: int = 0
var loss_streak: int = 0

# Exp thresholds for level 1 -> 9
var exp_thresholds: Array[int] = [0, 2, 6, 10, 20, 36, 56, 80, 999]

# Shop state
var shop_locked: bool = false
var current_shop_cards: Array = []

# Active references
var board_ref: Node = null
var hud_ref: Node = null
var item_bench: Node = null

var target_team_comp: Dictionary = {}

func set_target_team_comp(comp: Dictionary) -> void:
	target_team_comp = comp.duplicate(true)
	target_comp_updated.emit(target_team_comp)
	# Re-trigger shop refresh visuals if cards exist
	if not current_shop_cards.is_empty():
		shop_refreshed.emit(current_shop_cards)

func is_target_pokemon(p_id: String) -> bool:
	if target_team_comp.is_empty():
		return false
	var list: Array = target_team_comp.get("units", [])
	return p_id in list

func add_item_to_bench(item_id: String) -> bool:
	if item_bench and item_bench.has_method("add_item"):
		return item_bench.add_item(item_id)
	return false

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func get_active_arena_tier() -> int:
	return 1 + int((current_round - 1) / 3)

func get_next_awaken_round() -> int:
	return (int((current_round - 1) / 3) + 1) * 3 + 1

func get_active_arena_modifiers() -> Array[Dictionary]:
	var info = get_current_arena_info()
	var all_mods: Array = info.get("modifiers", [])
	var active_count = min(get_active_arena_tier(), all_mods.size())
	var active: Array[Dictionary] = []
	for i in range(active_count):
		active.append(all_mods[i])
	return active

func has_arena_modifier(stat_key: String) -> bool:
	for mod in get_active_arena_modifiers():
		if mod.has(stat_key) or mod.get("stat", "") == stat_key:
			return true
	return false

func get_arena_modifier_val(stat_key: String, default_val: float = 0.0) -> float:
	for mod in get_active_arena_modifiers():
		if mod.get("stat", "") == stat_key:
			return float(mod.get("val", default_val))
		if mod.has(stat_key):
			return float(mod.get(stat_key, default_val))
	return default_val

func get_arena_modifier_info(stat_key: String) -> Dictionary:
	for mod in get_active_arena_modifiers():
		if mod.get("stat", "") == stat_key or mod.has(stat_key):
			return mod
	return {}

func emit_arena_modifiers_updated() -> void:
	arena_modifiers_updated.emit(get_active_arena_modifiers(), get_current_arena_info())

func pick_random_background() -> String:
	if BATTLE_ARENAS.is_empty():
		return ""
	var new_idx = randi() % BATTLE_ARENAS.size()
	if BATTLE_ARENAS.size() > 1 and new_idx == current_arena_index:
		new_idx = (new_idx + 1 + (randi() % (BATTLE_ARENAS.size() - 1))) % BATTLE_ARENAS.size()
	current_arena_index = new_idx
	current_background_path = BATTLE_ARENAS[current_arena_index]["path"]
	background_changed.emit(current_background_path, BATTLE_ARENAS[current_arena_index])
	emit_arena_modifiers_updated()
	return current_background_path

func cycle_background() -> String:
	if BATTLE_ARENAS.is_empty():
		return ""
	current_arena_index = (current_arena_index + 1) % BATTLE_ARENAS.size()
	current_background_path = BATTLE_ARENAS[current_arena_index]["path"]
	background_changed.emit(current_background_path, BATTLE_ARENAS[current_arena_index])
	emit_arena_modifiers_updated()
	AudioManager.play_sfx("click")
	return current_background_path

func get_current_arena_info() -> Dictionary:
	if current_arena_index >= 0 and current_arena_index < BATTLE_ARENAS.size():
		return BATTLE_ARENAS[current_arena_index]
	return {}

func start_new_game() -> void:
	is_gym_road_mode = false
	active_gym_index = -1
	if GymRoadManager:
		GymRoadManager.end_gym_challenge()
	FloatingTextPool.clear_pool()
	if PokemonDatabase and PokemonDatabase.has_method("prune_unused_cache"):
		PokemonDatabase.prune_unused_cache()
	SkillVFX.prune_unused_cache()
	pick_random_background()
	player_hp = 100
	gold = 10
	level = 1
	current_exp = 0
	current_round = 1
	win_streak = 0
	loss_streak = 0
	shop_locked = false
	current_phase = Phase.PREPARATION
	phase_timer = PREP_TIME
	
	hp_changed.emit(player_hp, 0)
	gold_changed.emit(gold, 0)
	emit_level_signal()
	if board_ref and board_ref.has_method("init_starter_pokemon"):
		board_ref.init_starter_pokemon()
	refresh_shop(true)
	AudioManager.play_bgm("shop")
	phase_changed.emit("PREP", phase_timer)
	
	if hud_ref and "start_menu_modal" in hud_ref and hud_ref.start_menu_modal and hud_ref.start_menu_modal.visible:
		is_game_started = false
	else:
		is_game_started = true

func enter_sandbox_mode() -> void:
	is_gym_road_mode = false
	active_gym_index = -1
	if GymRoadManager:
		GymRoadManager.end_gym_challenge()
	is_sandbox_mode = true
	is_game_started = true
	gold = 999
	level = 10
	player_hp = 100
	current_phase = Phase.PREPARATION
	phase_timer = PREP_TIME
	gold_changed.emit(gold, 0)
	emit_level_signal()
	hp_changed.emit(player_hp, 0)
	refresh_shop(true)
	phase_changed.emit("PREP", phase_timer)
	sandbox_mode_toggled.emit(true)

func enter_gym_road_mode(gym_index: int) -> void:
	if not GymRoadManager:
		return
	var gym_data = GymRoadManager.get_gym_data(gym_index)
	if gym_data.is_empty():
		return
		
	is_gym_road_mode = true
	active_gym_index = gym_index
	is_sandbox_mode = false
	is_game_started = true
	GymRoadManager.start_gym_challenge(gym_index)
	
	# Set background to match gym theme
	var bg_path = gym_data.get("arena_bg", "")
	if bg_path != "":
		current_background_path = bg_path
		background_changed.emit(bg_path, {"name": gym_data.get("name", ""), "desc": gym_data.get("desc", "")})
	else:
		pick_random_background()
		
	player_hp = 100
	level = gym_data.get("player_start_level", 4)
	gold = gym_data.get("player_start_gold", 40)
	current_exp = 0
	current_round = 1
	win_streak = 0
	loss_streak = 0
	shop_locked = false
	current_phase = Phase.PREPARATION
	phase_timer = PREP_TIME
	
	hp_changed.emit(player_hp, 0)
	gold_changed.emit(gold, 0)
	emit_level_signal()
	
	if board_ref:
		if board_ref.has_method("reset_board_for_prep"):
			board_ref.reset_board_for_prep()
		if board_ref.has_method("init_starter_pokemon"):
			board_ref.init_starter_pokemon()
			
	refresh_shop(true)
	AudioManager.play_bgm("shop")
	phase_changed.emit("PREP", phase_timer)
	
	if hud_ref:
		if "start_menu_modal" in hud_ref and hud_ref.start_menu_modal:
			hud_ref.start_menu_modal.visible = false
		if "gym_road_modal" in hud_ref and hud_ref.gym_road_modal:
			hud_ref.gym_road_modal.visible = false
		if "item_bench" in hud_ref and hud_ref.item_bench:
			hud_ref.item_bench.visible = true
			
	gym_mode_entered.emit(gym_index, gym_data)

func _process(delta: float) -> void:
	if not is_game_started:
		return
	if current_phase == Phase.GAME_OVER or current_phase == Phase.VICTORY:
		return
		
	if phase_timer > 0.0:
		phase_timer -= delta
		if phase_timer <= 0.0:
			on_phase_timer_expired()

func on_phase_timer_expired() -> void:
	match current_phase:
		Phase.PREPARATION:
			start_combat_phase()
		Phase.COMBAT:
			# Combat time limit reached: draw or side with more HP
			resolve_combat(false, 5)
		Phase.RESOLVE:
			advance_to_next_round()

func start_combat_phase() -> void:
	current_phase = Phase.COMBAT
	phase_timer = COMBAT_MAX_TIME
	AudioManager.play_sfx("round_start")
	if current_round % 10 == 0 or current_round == 15:
		AudioManager.play_bgm("boss")
	else:
		AudioManager.play_bgm("battle")
	phase_changed.emit("COMBAT", phase_timer)
	if board_ref and board_ref.has_method("start_round_combat"):
		board_ref.start_round_combat()

func force_start_combat() -> void:
	if current_phase == Phase.PREPARATION:
		phase_timer = 0.0
		start_combat_phase()

func resolve_combat(player_won: bool, remaining_enemies: int = 0) -> void:
	if current_phase != Phase.COMBAT:
		return
	current_phase = Phase.RESOLVE
	phase_timer = 3.0
	
	if player_won:
		AudioManager.play_bgm("victory")
		AudioManager.play_sfx("victory")
		win_streak += 1
		loss_streak = 0
		add_gold(1) # Victory bonus gold
	else:
		AudioManager.play_bgm("defeat")
		AudioManager.play_sfx("defeat")
		loss_streak += 1
		win_streak = 0
		# Damage based on round + remaining enemies
		var damage = 2 + current_round + (remaining_enemies * 2)
		take_damage(damage)
		
	# Dynamax Energy: consume if used this round, then award round completion energy
	if MegaDatabase:
		if MegaDatabase.is_dynamax_active_this_round:
			MegaDatabase.consume_energy()
		var round_energy = 40 if player_won else 30
		if board_ref:
			var surviving = board_ref.count_player_units_on_board()
			round_energy += min(10, surviving * 2)
		MegaDatabase.add_dynamax_energy(round_energy)
		
	combat_ended.emit(player_won)
	phase_changed.emit("RESOLVE", phase_timer)
	
	if is_gym_road_mode and GymRoadManager:
		if player_won:
			GymRoadManager.settle_gym_battle(active_gym_index, true, player_hp)
			game_over(true)
		elif player_hp <= 0:
			GymRoadManager.settle_gym_battle(active_gym_index, false, 0)
			game_over(false)

func advance_to_next_round() -> void:
	if player_hp <= 0:
		game_over(false)
		return
	if current_round >= 15: # Win after wave 15 boss
		game_over(true)
		return
		
	current_round += 1
	round_changed.emit(current_round)
	emit_arena_modifiers_updated()
	
	# Award round economy
	var max_interest = 8 if (AugmentDatabase and AugmentDatabase.has_augment("interest_tycoon")) else 5
	if TrainerSystem and TrainerSystem.has_giovanni_passive():
		max_interest = max(max_interest, TrainerSystem.get_giovanni_max_interest())
	var interest = min(max_interest, int(gold / 10))
	var streak_bonus = 0
	var streak_count = max(win_streak, loss_streak)
	if streak_count >= 5:
		streak_bonus = 3
	elif streak_count >= 3:
		streak_bonus = 2
	elif streak_count >= 2:
		streak_bonus = 1
		
	var round_income = 5 + interest + streak_bonus
	if AugmentDatabase and AugmentDatabase.has_augment("jackpot"):
		round_income += 1
	add_gold(round_income)
	
	# Grant +2 passive EXP every round
	add_exp(2)
	
	if not shop_locked:
		refresh_shop(true)
		
	current_phase = Phase.PREPARATION
	phase_timer = PREP_TIME
	AudioManager.play_bgm("shop")
	phase_changed.emit("PREP", phase_timer)
	
	if board_ref and board_ref.has_method("reset_board_for_prep"):
		board_ref.reset_board_for_prep()
		
	# Check and execute any deferred evolutions from combat purchases!
	check_evolutions()
	
	# Prompt trainer augment selection on rounds 1, 5, 9
	if current_round in [1, 5, 9]:
		if hud_ref and hud_ref.has_method("open_trainer_augment_modal"):
			hud_ref.open_trainer_augment_modal()

func take_damage(amount: int) -> void:
	player_hp = max(0, player_hp - amount)
	hp_changed.emit(player_hp, -amount)
	if player_hp <= 0:
		game_over(false)

func add_gold(amount: int) -> void:
	gold += amount
	gold_changed.emit(gold, amount)

func spend_gold(amount: int) -> bool:
	if gold >= amount:
		gold -= amount
		gold_changed.emit(gold, -amount)
		return true
	return false

func add_exp(amount: int) -> void:
	if level >= 9:
		return
	current_exp += amount
	var needed = exp_thresholds[level - 1]
	while level < 9 and current_exp >= needed:
		current_exp -= needed
		level += 1
		AudioManager.play_sfx("level_up")
		if AugmentDatabase and AugmentDatabase.has_augment("hyper_roll"):
			add_gold(4)
		needed = exp_thresholds[level - 1]
	emit_level_signal()

func emit_level_signal() -> void:
	var needed = exp_thresholds[level - 1] if level < 9 else 0
	level_changed.emit(level, current_exp, needed)

func buy_exp() -> bool:
	if level >= 9 or gold < 4:
		return false
	if spend_gold(4):
		AudioManager.play_sfx("click")
		add_exp(4)
		return true
	return false

func refresh_shop(is_free: bool = false) -> bool:
	if not is_free:
		if not spend_gold(2):
			return false
		AudioManager.play_sfx("click")
		
	current_shop_cards.clear()
	if ShinyAndLoreManager:
		ShinyAndLoreManager.on_shop_refreshed(5)
	var rates = PokemonDatabase.shop_rates.get(level, [100, 0, 0, 0, 0])
	var deployed_ids = get_deployed_pokemon_ids()
	
	for i in range(5):
		var chosen_id = ""
		# 20% flat priority chance to offer an already deployed unit
		if not deployed_ids.is_empty() and randf() < 0.20:
			chosen_id = deployed_ids.keys().pick_random()
		else:
			var tier = pick_tier_by_rates(rates)
			var possible_ids = PokemonDatabase.get_shop_eligible_pokemons(tier)
			if possible_ids.is_empty():
				possible_ids = PokemonDatabase.get_shop_eligible_pokemons(1)
			chosen_id = pick_pokemon_with_bias(possible_ids, deployed_ids)
			
		current_shop_cards.append(chosen_id)
		
	shop_refreshed.emit(current_shop_cards)
	return true

func get_deployed_pokemon_ids() -> Dictionary:
	var deployed: Dictionary = {}
	if board_ref and board_ref.has_method("get_deployed_player_units"):
		for u in board_ref.get_deployed_player_units():
			if is_instance_valid(u):
				var root_id = PokemonDatabase.get_root_pokemon(u.pokemon_id)
				if PokemonDatabase.is_base_form(root_id):
					deployed[root_id] = true
	return deployed

func is_pokemon_deployed(pid: String) -> bool:
	if not board_ref or not board_ref.has_method("get_deployed_player_units"):
		return false
	var target_root = PokemonDatabase.get_root_pokemon(pid)
	for u in board_ref.get_deployed_player_units():
		if is_instance_valid(u):
			var u_root = PokemonDatabase.get_root_pokemon(u.pokemon_id)
			if u.pokemon_id == pid or u_root == pid or u_root == target_root or u.pokemon_id == target_root:
				return true
	return false

func pick_pokemon_with_bias(possible_ids: Array[String], deployed_ids: Dictionary) -> String:
	if possible_ids.is_empty():
		return ""
	if deployed_ids.is_empty():
		return possible_ids.pick_random()
		
	# Baseline weight 1.0; deployed units get +20% -> 1.20
	var total_weight: float = 0.0
	var weights: Array[float] = []
	for pid in possible_ids:
		var w: float = 1.20 if deployed_ids.has(pid) else 1.0
		weights.append(w)
		total_weight += w
		
	var roll = randf() * total_weight
	var cumulative: float = 0.0
	for idx in range(possible_ids.size()):
		cumulative += weights[idx]
		if roll <= cumulative:
			return possible_ids[idx]
			
	return possible_ids.pick_random()

func pick_tier_by_rates(rates: Array) -> int:
	var roll = randi_range(1, 100)
	var cumulative = 0
	for idx in range(rates.size()):
		cumulative += rates[idx]
		if roll <= cumulative:
			return idx + 1
	return 1

func buy_card(card_index: int) -> bool:
	if card_index < 0 or card_index >= current_shop_cards.size():
		return false
	var pid = current_shop_cards[card_index]
	if pid == "":
		return false
	var pdata = PokemonDatabase.get_pokemon(pid)
	var cost = pdata.get("cost", 1)
	
	if gold < cost:
		return false
	if not board_ref:
		return false
	var has_space = false
	if current_phase == Phase.PREPARATION:
		has_space = board_ref.has_available_bench_slot() or (board_ref.count_player_units_on_board() < level)
	else:
		# During combat: bought units cannot deploy to the combat battlefield, must go to bench!
		has_space = board_ref.has_available_bench_slot()
	if not has_space:
		return false
		
	if spend_gold(cost):
		AudioManager.play_sfx("buy")
		current_shop_cards[card_index] = "" # Empty this card slot
		var shiny_info = ShinyAndLoreManager.consume_shop_card(card_index) if ShinyAndLoreManager else {}
		var is_shiny = shiny_info.get("is_shiny", false)
		var affix = shiny_info.get("affix", "")
		var bought_unit = board_ref.add_pokemon_bought(pid, 1, is_shiny, affix)
		if bought_unit and is_shiny:
			bought_unit.set_shiny(true, affix)
		# Only check and execute evolutions during PREPARATION phase!
		if current_phase == Phase.PREPARATION:
			check_evolutions()
		shop_refreshed.emit(current_shop_cards)
		return true
	return false

func check_evolutions() -> void:
	if not board_ref:
		return
	board_ref.check_and_execute_evolutions()

func notify_unit_evolved(unit_id: String, new_star: int) -> void:
	unit_evolved.emit(unit_id, new_star)

func request_skill_choice(unit: Unit, star_level: int) -> void:
	skill_choice_requested.emit(unit, star_level)

func request_evolution_choice(unit: Unit, evolution_options: Array) -> void:
	evolution_choice_requested.emit(unit, evolution_options)

func inspect_unit(unit: Unit) -> void:
	unit_inspected.emit(unit)

func game_over(won: bool) -> void:
	current_phase = Phase.VICTORY if won else Phase.GAME_OVER
	phase_timer = 999999.0
	if won:
		AudioManager.play_sfx("victory")
		phase_changed.emit("VICTORY", 0)
	else:
		AudioManager.play_sfx("defeat")
		phase_changed.emit("GAME_OVER", 0)
