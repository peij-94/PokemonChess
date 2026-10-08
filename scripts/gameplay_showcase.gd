extends Node2D

# Gameplay Showcase: Automates a cinematic real-gameplay sequence demonstrating
# 2D Classic Pixel Art & Vector Illustration mechanics:
# 1. Preparation Phase (HUD, Streaks, Item Bench synthesis)
# 2. Boss Encounter (Gen 1 Snorlax ★3 with Golden Crown 👑 BOSS)
# 3. Assassin Sneak Leap (Weavile leaping to backline)
# 4. Fairy Synergy (Shield aura)
# 5. Skill Bursts & Cinematic Spotlight (Lucario Aura Sphere, Charizard Fire Blast)
# 6. Real-time DPS Meter & Boss AOE Telegraph
# 7. Boss Defeat & Loot Drop
# 8. Detailed Battle Stats & Damage Recap Modal (MVP podium 🥇🥈🥉)

const MAIN_SCENE = preload("res://scenes/main.tscn")

var main_node: Node2D = null
var hud: CanvasLayer = null
var board: Node2D = null

# Showcase Overlay UI elements
var overlay_layer: CanvasLayer = null
var narrative_panel: PanelContainer = null
var tag_label: Label = null
var desc_label: Label = null
var progress_bar: ProgressBar = null

var elapsed: float = 0.0
const TOTAL_DURATION: float = 25.5

# Actors in showcase
var charizard_unit: Unit = null
var lucario_unit: Unit = null
var weavile_unit: Unit = null
var gardevoir_unit: Unit = null
var boss_snorlax: Unit = null

# Step execution flags
var step_0_initialized: bool = false
var step_item_synthesized: bool = false
var step_item_equipped: bool = false
var step_combat_started: bool = false
var step_assassin_leaped: bool = false
var step_skills_burst: bool = false
var step_boss_stomp: bool = false
var step_dps_meter_shown: bool = false
var step_victory_shown: bool = false
var step_recap_modal_shown: bool = false

func _ready() -> void:
	print(">>> STARTING REAL GAMEPLAY SHOWCASE RECORDING <<<")
	# 1. Instantiate Main Scene
	main_node = MAIN_SCENE.instantiate()
	add_child(main_node)
	
	hud = main_node.get_node("HUD")
	board = main_node.get_node("Board")
	
	# Dismiss any blocking start/augment modals
	if hud.has_node("StartMenuModal"):
		var start_modal = hud.get_node("StartMenuModal")
		start_modal.visible = false
		start_modal.queue_free()
		
	if "start_menu_modal" in hud and hud.start_menu_modal:
		hud.start_menu_modal.visible = false
		
	if "trainer_augment_modal" in hud and hud.trainer_augment_modal:
		hud.trainer_augment_modal.visible = false
		
	# Setup player state for showcase
	GameManager.gold = 50
	GameManager.level = 7
	GameManager.player_hp = 100
	GameManager.current_round = 5
	GameManager.win_streak = 5
	GameManager.gold_changed.emit(GameManager.gold, 0)
	GameManager.emit_level_signal()
	GameManager.round_changed.emit(GameManager.current_round)
	if hud.has_method("_update_streak_badge"):
		hud._update_streak_badge()
	
	# Deploy player team on board
	charizard_unit = board.spawn_unit_at_coord("charizard", Vector2i(3, 4), 3, false)
	lucario_unit = board.spawn_unit_at_coord("lucario", Vector2i(4, 4), 2, false)
	gardevoir_unit = board.spawn_unit_at_coord("gardevoir", Vector2i(2, 4), 2, false)
	weavile_unit = board.spawn_unit_at_coord("weavile", Vector2i(1, 4), 2, false)
	
	# Bench unit
	board.add_pokemon_to_bench("bulbasaur", 1)
	
	# Setup Item Bench items
	if hud.item_bench:
		hud.item_bench.clear_all()
		hud.item_bench.add_item("razor_claw")
		hud.item_bench.add_item("exp_share")
		hud.item_bench.add_item("assault_vest")
	
	# Build Showcase Narrative Overlay
	_build_narrative_overlay()
	_set_narrative(
		"🎮 宝可梦自走棋: 现代战略篇 (实机深度演示)",
		"全系统实机联动：开局筹备 · 装备二合一合成 · 妖精护盾 · 连胜勋章"
	)

func _build_narrative_overlay() -> void:
	overlay_layer = CanvasLayer.new()
	overlay_layer.layer = 200 # Above HUD
	add_child(overlay_layer)
	
	narrative_panel = PanelContainer.new()
	narrative_panel.offset_left = 300.0
	narrative_panel.offset_top = 70.0
	narrative_panel.offset_right = 980.0
	narrative_panel.offset_bottom = 118.0
	
	var style = StyleBoxFlat.new()
	style.bg_color = Color(0.04, 0.06, 0.10, 0.94)
	style.border_color = Color(1.0, 0.82, 0.22, 1.0) # Golden border
	style.set_border_width_all(2)
	style.corner_radius_top_left = 6
	style.corner_radius_top_right = 6
	style.corner_radius_bottom_left = 6
	style.corner_radius_bottom_right = 6
	style.content_margin_left = 14.0
	style.content_margin_right = 14.0
	style.content_margin_top = 4.0
	style.content_margin_bottom = 4.0
	narrative_panel.add_theme_stylebox_override("panel", style)
	overlay_layer.add_child(narrative_panel)
	
	var vbox = VBoxContainer.new()
	vbox.add_theme_constant_override("separation", 2)
	narrative_panel.add_child(vbox)
	
	tag_label = Label.new()
	tag_label.text = "🎮 宝可梦自走棋: 现代战略篇"
	tag_label.add_theme_color_override("font_color", Color(1.0, 0.88, 0.28))
	tag_label.add_theme_font_size_override("font_size", 14)
	vbox.add_child(tag_label)
	
	desc_label = Label.new()
	desc_label.text = "实机演示准备就绪..."
	desc_label.add_theme_color_override("font_color", Color(0.92, 0.96, 1.0))
	desc_label.add_theme_font_size_override("font_size", 11)
	desc_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	vbox.add_child(desc_label)
	
	progress_bar = ProgressBar.new()
	progress_bar.custom_minimum_size = Vector2(0, 3)
	progress_bar.max_value = TOTAL_DURATION
	progress_bar.value = 0.0
	progress_bar.show_percentage = false
	var pstyle = StyleBoxFlat.new()
	pstyle.bg_color = Color(1.0, 0.82, 0.22, 0.9)
	progress_bar.add_theme_stylebox_override("fill", pstyle)
	vbox.add_child(progress_bar)

func _set_narrative(tag: String, desc: String) -> void:
	if tag_label:
		tag_label.text = tag
	if desc_label:
		desc_label.text = desc

func _process(delta: float) -> void:
	elapsed += delta
	if progress_bar:
		progress_bar.value = elapsed
		
	# Timeline orchestration
	# 0.0s - 2.5s: Preparation Phase & Item Bench
	if elapsed >= 2.0 and not step_item_synthesized:
		step_item_synthesized = true
		_step_synthesize_and_equip_item()
		
	# 2.5s - 5.0s: Fairy Shield & Setup
	if elapsed >= 3.8 and not step_item_equipped:
		step_item_equipped = true
		_step_show_team_synergies()
		
	# 5.0s - 8.5s: Combat Starts & Boss Snorlax Spawns
	if elapsed >= 5.2 and not step_combat_started:
		step_combat_started = true
		_step_start_boss_combat()
		
	# 8.5s - 11.5s: Assassin Sneak Leap
	if elapsed >= 7.5 and not step_assassin_leaped:
		step_assassin_leaped = true
		_step_execute_assassin_leap()
		
	# 11.5s - 14.5s: Skills Burst & Cinematic Spotlight
	if elapsed >= 10.5 and not step_skills_burst:
		step_skills_burst = true
		_step_fire_skills_burst()
		
	# 14.5s - 17.0s: Boss Stomp & Telegraph Ring
	if elapsed >= 13.5 and not step_boss_stomp:
		step_boss_stomp = true
		_step_boss_stomp_telegraph()
		
	# 17.0s - 19.5s: DPS Meter Unfold
	if elapsed >= 16.5 and not step_dps_meter_shown:
		step_dps_meter_shown = true
		_step_unfold_dps_meter()
		
	# 19.5s - 21.5s: Boss Defeated & Victory Drops
	if elapsed >= 19.0 and not step_victory_shown:
		step_victory_shown = true
		_step_defeat_boss_and_victory()
		
	# 21.5s - 25.5s: Damage Recap Modal [Tab]
	if elapsed >= 21.5 and not step_recap_modal_shown:
		step_recap_modal_shown = true
		_step_open_damage_recap_modal()
		
	if elapsed >= TOTAL_DURATION:
		print(">>> REAL GAMEPLAY SHOWCASE COMPLETE! QUITTING GRACEFULLY <<<")
		get_tree().quit(0)

# --- Step Implementations ---

func _step_synthesize_and_equip_item() -> void:
	_set_narrative(
		"🎒【装备合成与佩戴】锐利之爪 + 学习装置 自动合成【生命宝珠】！",
		"拖拽装备散件二合一合成神装，装备给神奥战士路卡利欧，普攻附带25%真实伤害！"
	)
	if hud.item_bench:
		hud.item_bench.clear_all()
		hud.item_bench.add_item("life_orb")
		hud.item_bench.add_item("assault_vest")
	
	if lucario_unit and is_instance_valid(lucario_unit):
		lucario_unit.equip_item("life_orb")

func _step_show_team_synergies() -> void:
	_set_narrative(
		"🛡️【阵容羁绊就绪】沙奈朵触发妖精护盾，玛纽拉暗影潜行待发！",
		"全队获自身最大生命18%魔法护盾，连胜达到 🔥 5连胜 (+3G)，进入第5回合首领战！"
	)
	if gardevoir_unit and is_instance_valid(gardevoir_unit):
		gardevoir_unit.shield += gardevoir_unit.max_hp * 0.25
	if lucario_unit and is_instance_valid(lucario_unit):
		lucario_unit.shield += lucario_unit.max_hp * 0.18
	if charizard_unit and is_instance_valid(charizard_unit):
		charizard_unit.shield += charizard_unit.max_hp * 0.18

func _step_start_boss_combat() -> void:
	_set_narrative(
		"👹【第5回合首领战】金色王冠首领卡比兽 👑 BOSS 震撼降临！",
		"首领卡比兽佩戴金色王冠，体型倍化，拥有高达2.4倍生命与毁灭级近战力量！"
	)
	GameManager.start_combat_phase()
	
	# Locate boss
	var units = get_tree().get_nodes_in_group("units")
	for u in units:
		var unit = u as Unit
		if unit and unit.is_enemy and unit.pokemon_id == "snorlax":
			boss_snorlax = unit
			break

func _step_execute_assassin_leap() -> void:
	_set_narrative(
		"🗡️【刺客暗影潜行突袭】玛纽拉跃过前排敌军，直插后排核心身侧！",
		"暗影潜行穿透前排防线，瞬移至敌方后排身侧施加突袭，触发黄色暴击高额打击！"
	)
	if weavile_unit and is_instance_valid(weavile_unit):
		weavile_unit.perform_assassin_leap()

func _step_fire_skills_burst() -> void:
	_set_narrative(
		"💥【专属绝招爆发】路卡利欧波导弹 & 喷火龙大字爆炎！",
		"满蓝法力激发聚光灯电影级全屏压暗，远程抛物线与暴击火十字震撼爆发！"
	)
	if lucario_unit and is_instance_valid(lucario_unit):
		lucario_unit.current_mana = lucario_unit.max_mana
		lucario_unit.cast_skill()
		
	if charizard_unit and is_instance_valid(charizard_unit):
		charizard_unit.current_mana = charizard_unit.max_mana
		charizard_unit.cast_skill()

func _step_boss_stomp_telegraph() -> void:
	_set_narrative(
		"⚠️【首领地面范围预警】首领卡比兽泰山压顶地面红圈预警，物理阻尼震屏！",
		"首领卡比兽暴怒起跳！脚底红色AOE预警光环展开，落地沉重震慑全屏敌军！"
	)
	if boss_snorlax and is_instance_valid(boss_snorlax):
		boss_snorlax.take_damage(boss_snorlax.max_hp * 0.45, true, false)
		if board and board.has_method("shake_screen"):
			board.shake_screen(12.0, 0.4)

func _step_unfold_dps_meter() -> void:
	_set_narrative(
		"📊【实时战斗数据统计】侧边 DPS 面板展开，全队攻防实时度量！",
		"右侧展开实时三维数据面板，路卡利欧与喷火龙持续领跑，输出承伤一目了然！"
	)
	if hud.dps_meter:
		hud.dps_meter.visible = true
		if hud.dps_meter.has_method("record_damage"):
			hud.dps_meter.record_damage("lucario", 4850)
			hud.dps_meter.record_damage("charizard", 4200)
			hud.dps_meter.record_damage("weavile", 3150)
			hud.dps_meter.record_damage("gardevoir", 1680)

func _step_defeat_boss_and_victory() -> void:
	_set_narrative(
		"🏆【首领战大捷】史诗巨兽破灭，掉落高级进阶成品神装！",
		"顺利斩获首领战利品，战绩跃升至 🔥 6连胜 (+3G)，迎来阶段性大胜！"
	)
	if boss_snorlax and is_instance_valid(boss_snorlax):
		boss_snorlax.take_damage(boss_snorlax.max_hp * 2.0, true, false)
		
	# Clean up any remaining enemies
	var units = get_tree().get_nodes_in_group("units")
	for u in units:
		var unit = u as Unit
		if unit and unit.is_enemy:
			unit.queue_free()
			
	GameManager.win_streak = 6
	if hud.has_method("_update_streak_badge"):
		hud._update_streak_badge()
		
	GameManager.current_phase = GameManager.Phase.PREPARATION
	GameManager.phase_changed.emit("VICTORY", 5.0)

func _step_open_damage_recap_modal() -> void:
	_set_narrative(
		"📊【详细战斗结算战报 (Tab)】MVP领奖台 🥇🥈🥉 与全员数据复盘！",
		"🥇路卡利欧(MVP 4,850) · 🥈喷火龙(4,200) · 🥉玛纽拉(3,150)，进度条对比一目了然！"
	)
	if hud.has_method("_on_recap_btn_pressed"):
		hud._on_recap_btn_pressed()
