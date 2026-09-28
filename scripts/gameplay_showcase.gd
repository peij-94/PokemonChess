extends Node2D

# Gameplay Showcase: Automates a cinematic real-gameplay sequence demonstrating
# Direction 1 (Weather & Terrain), Direction 2 (Mega & Dynamax), Direction 5 (Team Comp & Crafting Tree),
# and extensive REAL COMBAT SCENES with Boss Health Bar, Mega burst, Max Moves, DPS Meter, and Drag Sell.

const MAIN_SCENE = preload("res://scenes/main.tscn")
const TeamCompPlannerScript = preload("res://scripts/team_comp_planner.gd")

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
const TOTAL_DURATION: float = 28.0

# Actors in showcase
var charizard_unit: Unit = null
var pikachu_unit: Unit = null
var blastoise_unit: Unit = null
var boss_snorlax: Unit = null

# Step execution flags
var step_0_initialized: bool = false
var step_planner_opened: bool = false
var step_planner_closed: bool = false
var step_crafting_shown: bool = false
var step_mega_equipped: bool = false
var step_dynamax_locked: bool = false
var step_combat_started: bool = false
var step_weather_and_mega: bool = false
var step_max_move_fired: bool = false
var step_boss_enraged: bool = false
var step_dps_meter_shown: bool = false
var step_drag_sell_shown: bool = false
var step_victory_shown: bool = false

func _ready() -> void:
	print(">>> STARTING REAL COMBAT GAMEPLAY SHOWCASE RECORDING <<<")
	# 1. Instantiate Main Scene
	main_node = MAIN_SCENE.instantiate()
	add_child(main_node)
	
	hud = main_node.get_node("HUD")
	board = main_node.get_node("Board")
	
	# CRITICAL FIX: Dismiss the StartMenuModal immediately so it never blocks the battlefield!
	if hud.has_node("StartMenuModal"):
		var start_modal = hud.get_node("StartMenuModal")
		start_modal.visible = false
		start_modal.queue_free()
		
	if "start_menu_modal" in hud and hud.start_menu_modal:
		hud.start_menu_modal.visible = false
		
	# Ensure Trainer Augment modal doesn't pop up over combat
	if "trainer_augment_modal" in hud and hud.trainer_augment_modal:
		hud.trainer_augment_modal.visible = false
		
	# Setup player state for showcase
	GameManager.gold = 50
	GameManager.level = 6
	GameManager.player_hp = 100
	GameManager.current_round = 5
	GameManager.gold_changed.emit(GameManager.gold, 0)
	GameManager.emit_level_signal()
	GameManager.round_changed.emit(GameManager.current_round)
	
	# Deploy player team on board (Charizard 3-star, Pikachu 2-star, Blastoise 2-star)
	charizard_unit = board.spawn_unit_at_coord("charizard", Vector2i(3, 4), 3, false)
	pikachu_unit = board.spawn_unit_at_coord("pikachu", Vector2i(4, 4), 2, false)
	blastoise_unit = board.spawn_unit_at_coord("blastoise", Vector2i(2, 4), 2, false)
	
	# Bench item for sell demo
	board.add_pokemon_to_bench("bulbasaur", 1)
	
	# 2. Build Showcase Narrative Overlay (Top-center, compact, does not block combat)
	_build_narrative_overlay()
	_set_narrative(
		"🎮 宝可梦自走棋: 现代战略篇 (实机玩法演示)",
		"全系统实机联动：阵容构筑 · 装备合成树 · Mega进化 · 极巨化 · 动态环境与Boss战"
	)

func _build_narrative_overlay() -> void:
	overlay_layer = CanvasLayer.new()
	overlay_layer.layer = 200 # Above HUD
	add_child(overlay_layer)
	
	narrative_panel = PanelContainer.new()
	narrative_panel.offset_left = 320.0
	narrative_panel.offset_top = 80.0
	narrative_panel.offset_right = 960.0
	narrative_panel.offset_bottom = 124.0
	
	var style = StyleBoxFlat.new()
	style.bg_color = Color(0.05, 0.07, 0.12, 0.92)
	style.border_color = Color(1.0, 0.82, 0.22, 1.0) # Golden border
	style.set_border_width_all(2)
	style.corner_radius_top_left = 6
	style.corner_radius_top_right = 6
	style.corner_radius_bottom_left = 6
	style.corner_radius_bottom_right = 6
	style.content_margin_left = 12.0
	style.content_margin_right = 12.0
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
	# 0.0s - 2.5s: Team Comp Planner & Shop Highlights
	if elapsed >= 0.8 and not step_planner_opened:
		step_planner_opened = true
		_step_open_comp_planner()
		
	if elapsed >= 2.0 and not step_planner_closed:
		step_planner_closed = true
		_step_close_planner_and_setup_shop()
		
	# 2.5s - 5.5s: Crafting Tree Hover & Mega Equip & Dynamax
	if elapsed >= 3.0 and not step_crafting_shown:
		step_crafting_shown = true
		_step_show_crafting_tree()
		
	if elapsed >= 4.2 and not step_mega_equipped:
		step_mega_equipped = true
		_step_equip_mega_and_dynamax()
		
	# 5.5s - 20.0s: REAL COMBAT SCENE (Over 14 seconds of intense action!)
	if elapsed >= 5.5 and not step_combat_started:
		step_combat_started = true
		_step_start_real_combat()
		
	if elapsed >= 7.0 and not step_weather_and_mega:
		step_weather_and_mega = true
		_step_trigger_rain_and_mega_evo()
		
	if elapsed >= 10.5 and not step_max_move_fired:
		step_max_move_fired = true
		_step_fire_max_move_and_terrain()
		
	if elapsed >= 13.5 and not step_boss_enraged:
		step_boss_enraged = true
		_step_boss_enrage()
		
	if elapsed >= 16.0 and not step_dps_meter_shown:
		step_dps_meter_shown = true
		_step_unfold_dps_meter()
		
	# 20.0s - 24.0s: Drag-to-Sell & Finishing Combat
	if elapsed >= 20.0 and not step_drag_sell_shown:
		step_drag_sell_shown = true
		_step_drag_sell_unit()
		
	# 24.0s - 28.0s: Victory & Conclusion
	if elapsed >= 24.5 and not step_victory_shown:
		step_victory_shown = true
		_step_show_victory()
		
	if elapsed >= TOTAL_DURATION:
		print(">>> REAL COMBAT SHOWCASE COMPLETE! QUITTING GRACEFULLY <<<")
		get_tree().quit(0)

# --- Step Implementations ---

func _step_open_comp_planner() -> void:
	_set_narrative(
		"📋【方向五·智能阵容构筑】打开规划器锁定『深海风暴流』",
		"实时浏览6大正统流派羁绊，一键选定战术目标，调度全局卡池推荐！"
	)
	if hud.team_comp_planner:
		hud.team_comp_planner.open_modal()
		var deep_sea = TeamCompPlannerScript.PRESET_COMPS[0]
		hud.team_comp_planner._select_comp(deep_sea)

func _step_close_planner_and_setup_shop() -> void:
	if hud.team_comp_planner:
		hud.team_comp_planner.close()
		
	_set_narrative(
		"⭐【智能商店推荐】金边流光『⭐阵容所需』与『🔥升星关键』",
		"目标阵容棋子（杰尼龟）自动高亮金边星标，拥有2张时标注升星关键！"
	)
	
	if hud.cards_container:
		var cards = hud.cards_container.get_children()
		if cards.size() >= 4:
			cards[0].setup("squirtle", 0)   # ⭐阵容所需
			cards[1].setup("charmander", 1) # 🔥升星关键
			cards[2].setup("pikachu", 2)
			cards[3].setup("gyarados", 3)

func _step_show_crafting_tree() -> void:
	_set_narrative(
		"🔨【方向五·实时背包合成树】散件悬停即刻预览合成矩阵",
		"悬停【锐利之爪】，动态合成树实时识别背包【进化学者之石】，高亮提示可即刻合成【超级手环】！"
	)
	var bench = hud.item_bench
	if bench:
		bench.clear_all()
		bench.add_item("razor_claw")
		bench.add_item("eviolite")
		bench.add_item("scope_lens")
		if bench.slot_buttons.size() > 0:
			bench._show_tooltip_for_item("razor_claw", bench.slot_buttons[0])

func _step_equip_mega_and_dynamax() -> void:
	var bench = hud.item_bench
	if bench:
		bench._hide_tooltip()
		
	_set_narrative(
		"🔴【动作特效·满蓝能量流光 & 极巨化】皮卡丘蓄满法力浮现电气金色光晕！",
		"3星喷火龙佩戴超级手环，皮卡丘蓄能达85%激发周身呼吸光晕，启动1.6倍巨大化！"
	)
	
	# Equip mega bracelet to Charizard
	if charizard_unit and is_instance_valid(charizard_unit):
		charizard_unit.equip_item("mega_bracelet")
		
	# Dynamax Pikachu & give 85% mana to showcase Mana Glow aura
	if pikachu_unit and is_instance_valid(pikachu_unit):
		pikachu_unit.activate_dynamax()
		pikachu_unit.current_mana = pikachu_unit.max_mana * 0.85

# --- REAL COMBAT PHASE ---

func _step_start_real_combat() -> void:
	_set_narrative(
		"⚔️【动作特效·弧线弹道 & 受击闪白】抛物线弹道拖曳彗星粒子，受击纯白顿挫！",
		"第5回合Boss对决！远程水流带起飞溅水滴，拳拳到肉触发【受击纯白闪光】与受力后仰！"
	)
	# Start official combat phase via GameManager
	GameManager.start_combat_phase()
	
	# Find the spawned Boss unit
	var units = get_tree().get_nodes_in_group("units")
	for u in units:
		var unit = u as Unit
		if unit and unit.is_enemy and unit.pokemon_id == "snorlax":
			boss_snorlax = unit
			break

func _step_trigger_rain_and_mega_evo() -> void:
	_set_narrative(
		"🌧️【动作特效·大招电影级暗化聚光灯】暴雨降临，全场背景暗化聚焦主角！",
		"超级喷火龙X爆发！全场背景瞬时压暗45%聚光聚焦，火龙近战撕扯迸发钻石暴击星芒！"
	)
	# Trigger Heavy Rain weather
	WeatherSystem.set_weather("rain", 30.0)
	
	# Trigger Mega Evolution on Charizard
	if charizard_unit and is_instance_valid(charizard_unit):
		charizard_unit.trigger_mega_evolution()

func _step_fire_max_move_and_terrain() -> void:
	_set_narrative(
		"⚡【动作特效·地面预警光圈 & 地表裂痕留存】极巨闪电轰击，地面蛛网电弧！",
		"目标脚底展开AOE预警红圈！全屏雷暴呼唤电气场地，地面生成持续跳跃的电火花残痕！"
	)
	if pikachu_unit and is_instance_valid(pikachu_unit):
		pikachu_unit.current_mana = pikachu_unit.max_mana
		pikachu_unit.cast_skill()
		WeatherSystem.set_terrain("electric", 25.0)

func _step_boss_enrage() -> void:
	_set_narrative(
		"💥【动作特效·物理屏幕震颤 & 地面焦痕】卡比兽血怒狂暴，镜头剧烈震颤！",
		"首领卡比兽血量过半触发狂暴！大招落地触发物理阻尼震屏，地面留下焦黑熔岩印记！"
	)
	if boss_snorlax and is_instance_valid(boss_snorlax):
		boss_snorlax.take_damage(boss_snorlax.max_hp * 0.55, true, false)

func _step_unfold_dps_meter() -> void:
	_set_narrative(
		"📊【核心机制·实时DPS战报】右侧数据面板展开，超级喷火龙X持续霸榜！",
		"DPS数据面板实时统计全员物理、特殊伤害与吸收承伤，战局贡献一目了然！"
	)
	if hud.dps_meter:
		hud.dps_meter.visible = true
		if hud.dps_meter.has_method("record_damage"):
			hud.dps_meter.record_damage("charizard", 4250)
			hud.dps_meter.record_damage("pikachu", 3100)
			hud.dps_meter.record_damage("blastoise", 1850)

func _step_drag_sell_unit() -> void:
	_set_narrative(
		"💰【核心机制·战斗中拖拽出售】备战席棋子拖动至下方出售区，即刻变现！",
		"拖拽备战席闲置妙蛙种子至下方红框出售区，立即获得金币返还，流畅运营！"
	)
	# Trigger sell zone visual feedback
	var sell_area = hud.sell_area if "sell_area" in hud else hud.get_node_or_null("SellArea")
	if sell_area and sell_area.has_method("show_zone"):
		var bulba = board.bench_slots[0]
		if bulba != null:
			sell_area.show_zone(bulba)
			sell_area.set_hover_state(true, bulba)
			GameManager.gold += 1
			GameManager.gold_changed.emit(GameManager.gold, 1)
			bulba.queue_free()
			board.bench_slots[0] = null

func _step_show_victory() -> void:
	_set_narrative(
		"🏆【实机演示大捷·动作特效全面升级】视觉表现与爽快打击感全面跃升！",
		"受击纯白闪光 · 抛物线彗星尾迹 · 满蓝光晕预警 · 电影级大招暗化 · 地表留痕震撼呈现！"
	)
	# Clean up remaining enemy units for smooth victory
	var units = get_tree().get_nodes_in_group("units")
	for u in units:
		var unit = u as Unit
		if unit and unit.is_enemy:
			unit.queue_free()
			
	GameManager.current_phase = GameManager.Phase.PREPARATION
	GameManager.phase_changed.emit("VICTORY", 5.0)
