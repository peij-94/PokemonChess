extends CanvasLayer

# HUD Controller: Handles all UI overlays, shop, synergies, and player controls

const SHOP_CARD_SCENE = preload("res://scenes/shop_card.tscn")

@onready var hp_bar: ProgressBar = $TopBar/PlayerInfo/HPBar
@onready var hp_label: Label = $TopBar/PlayerInfo/HPLabel
@onready var gold_label: Label = $TopBar/PlayerInfo/GoldLabel
@onready var interest_label: Label = $TopBar/PlayerInfo/InterestLabel

@onready var round_label: Label = $TopBar/RoundInfo/RoundLabel
@onready var phase_label: Label = $TopBar/RoundInfo/PhaseLabel
@onready var timer_label: Label = $TopBar/RoundInfo/TimerLabel
@onready var start_battle_btn: Button = $TopBar/RoundInfo/StartBattleBtn
@onready var action_buttons: HBoxContainer = $TopBar/ActionButtons if has_node("TopBar/ActionButtons") else null
@onready var arena_bg_btn: Button = $TopBar/ActionButtons/ArenaBgBtn if has_node("TopBar/ActionButtons/ArenaBgBtn") else ($TopBar/ArenaBgBtn if has_node("TopBar/ArenaBgBtn") else null)
@onready var environment_bar: HBoxContainer = $EnvironmentBar if has_node("EnvironmentBar") else null
@onready var arena_banner: Button = $EnvironmentBar/ArenaBanner if has_node("EnvironmentBar/ArenaBanner") else ($ArenaBanner if has_node("ArenaBanner") else null)
@onready var arena_modal: Panel = $ArenaModal if has_node("ArenaModal") else null

@onready var level_label: Label = $TopBar/LevelInfo/LevelLabel
@onready var exp_bar: ProgressBar = $TopBar/LevelInfo/EXPBar
@onready var exp_label: Label = $TopBar/LevelInfo/EXPLabel

# Left Synergy Panel
@onready var synergy_list: VBoxContainer = $SynergyPanel/Scroll/VBox

# Shop Controls
@onready var shop_panel: Panel = $ShopPanel
@onready var cards_container: HBoxContainer = $ShopPanel/CardsContainer
@onready var reroll_btn: Button = $ShopPanel/Controls/RerollBtn
@onready var exp_btn: Button = $ShopPanel/Controls/BuyExpBtn
@onready var lock_btn: Button = $ShopPanel/Controls/LockBtn

# Action & Unit Info
@onready var sell_btn: Button = $BottomActions/SellBtn
@onready var big_start_battle_btn: Button = $BottomActions/BigStartBattleBtn
@onready var unit_info_panel: Panel = $BottomActions/UnitInfoPanel
@onready var unit_info_name: Label = $BottomActions/UnitInfoPanel/Name
@onready var unit_info_stats: Label = $BottomActions/UnitInfoPanel/Stats

# End Game Modal
@onready var end_modal: Panel = $EndGameModal
@onready var end_title: Label = $EndGameModal/VBox/Title
@onready var end_subtitle: Label = $EndGameModal/VBox/Subtitle
@onready var restart_btn: Button = $EndGameModal/VBox/RestartBtn

# Start Menu Modal
@onready var start_menu_modal: Panel = $StartMenuModal
@onready var play_game_btn: Button = $StartMenuModal/Dialog/VBox/BtnRow/PlayGameBtn
@onready var menu_pokedex_btn: Button = $StartMenuModal/Dialog/VBox/BtnRow/MenuPokedexBtn
@onready var pokedex_btn: Button = $TopBar/ActionButtons/PokedexBtn if has_node("TopBar/ActionButtons/PokedexBtn") else ($TopBar/PokedexBtn if has_node("TopBar/PokedexBtn") else null)
@onready var pokedex_modal: Panel = $PokedexModal
@onready var dps_meter: Control = $DPSMeter if has_node("DPSMeter") else null
var dps_update_timer: float = 0.0

const SKILL_CHOICE_MODAL_SCENE = preload("res://scenes/skill_choice_modal.tscn")
const EVOLUTION_CHOICE_MODAL_SCENE = preload("res://scenes/evolution_choice_modal.tscn")
const UNIT_DETAIL_MODAL_SCENE = preload("res://scenes/unit_detail_modal.tscn")
const TRAINER_AUGMENT_MODAL_SCENE = preload("res://scenes/trainer_augment_modal.tscn")
const BOSS_HEALTH_BAR_SCENE = preload("res://scenes/boss_health_bar.tscn")
const ITEM_BENCH_SCENE = preload("res://scenes/item_bench.tscn")
const WEATHER_OVERLAY_SCENE = preload("res://scenes/weather_overlay.tscn")
const WEATHER_BANNER_SCENE = preload("res://scenes/weather_banner.tscn")
const TEAM_COMP_PLANNER_SCENE = preload("res://scenes/team_comp_planner.tscn")
const SANDBOX_TOOLBAR_SCENE = preload("res://scenes/sandbox_toolbar.tscn")
const DAMAGE_RECAP_MODAL_SCENE = preload("res://scenes/damage_recap_modal.tscn")
const GYM_ROAD_MODAL_SCENE = preload("res://scenes/gym_road_modal.tscn")
const TRAINER_WIDGET_SCENE = preload("res://scenes/trainer_widget.tscn")

var skill_choice_modal: Panel = null
var evolution_choice_modal: Panel = null
var unit_detail_modal: Panel = null
var trainer_augment_modal: Panel = null
var trainer_widget: PanelContainer = null
var boss_health_bar: PanelContainer = null
var item_bench: PanelContainer = null
var weather_overlay: ColorRect = null
var weather_banner: PanelContainer = null
var team_comp_planner: Panel = null
var sandbox_toolbar: PanelContainer = null
var damage_recap_modal: Panel = null
var gym_road_modal: Panel = null
var recap_btn: Button = null
var gym_road_btn: Button = null
@onready var team_comp_btn: Button = $TopBar/ActionButtons/TeamCompBtn if has_node("TopBar/ActionButtons/TeamCompBtn") else null
@onready var dynamax_btn: Button = $TopBar/ActionButtons/DynamaxBtn if has_node("TopBar/ActionButtons/DynamaxBtn") else null
var audio_btn: Button = null

var card_instances: Array = []

# Sell Drop Zone
var sell_drop_zone: Panel = null
var sell_drop_label: Label = null
var sell_drop_sub_label: Label = null
var sell_drop_icon: Label = null
var is_drag_selling: bool = false
var current_drag_refund: int = 0
var current_drag_unit_name: String = ""
var cinematic_spotlight: ColorRect = null
var active_toast: PanelContainer = null
var streak_badge: PanelContainer = null
var streak_badge_label: Label = null

func _ready() -> void:
	end_modal.visible = false
	unit_info_panel.visible = false
	sell_btn.visible = false
	start_menu_modal.visible = true
	pokedex_modal.visible = false
	
	# Create Cinematic Spotlight Layer
	cinematic_spotlight = ColorRect.new()
	cinematic_spotlight.name = "CinematicSpotlight"
	cinematic_spotlight.set_anchors_preset(Control.PRESET_FULL_RECT)
	cinematic_spotlight.color = Color(0.02, 0.03, 0.05, 0.0)
	cinematic_spotlight.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(cinematic_spotlight)
	move_child(cinematic_spotlight, 0)
	
	# Connect GameManager signals
	GameManager.hp_changed.connect(_on_hp_changed)
	GameManager.gold_changed.connect(_on_gold_changed)
	GameManager.level_changed.connect(_on_level_changed)
	GameManager.round_changed.connect(_on_round_changed)
	GameManager.phase_changed.connect(_on_phase_changed)
	GameManager.shop_refreshed.connect(_on_shop_refreshed)
	GameManager.skill_choice_requested.connect(_on_skill_choice_requested)
	GameManager.evolution_choice_requested.connect(_on_evolution_choice_requested)
	GameManager.unit_inspected.connect(_on_unit_inspected)
	GameManager.unit_drag_started.connect(_on_unit_drag_started)
	GameManager.unit_drag_hover_sell.connect(_on_unit_drag_hover_sell)
	GameManager.unit_drag_ended.connect(_on_unit_drag_ended)
	GameManager.cinematic_spotlight_requested.connect(_on_cinematic_spotlight_requested)
	SynergyManager.synergies_updated.connect(_on_synergies_updated)
	if ShinyAndLoreManager:
		ShinyAndLoreManager.lore_synergy_activated.connect(_on_lore_synergy_activated)
	
	# Connect UI buttons
	start_battle_btn.pressed.connect(_on_start_battle_pressed)
	big_start_battle_btn.pressed.connect(_on_start_battle_pressed)
	play_game_btn.pressed.connect(_on_play_game_pressed)
	menu_pokedex_btn.pressed.connect(_on_pokedex_pressed)
	pokedex_btn.pressed.connect(_on_pokedex_pressed)
	reroll_btn.pressed.connect(_on_reroll_pressed)
	exp_btn.pressed.connect(_on_buy_exp_pressed)
	lock_btn.toggled.connect(_on_lock_toggled)
	sell_btn.pressed.connect(_on_sell_pressed)
	restart_btn.pressed.connect(_on_restart_pressed)
	if arena_bg_btn:
		arena_bg_btn.pressed.connect(_on_arena_bg_pressed)
	if arena_banner:
		arena_banner.pressed.connect(_on_arena_banner_pressed)
	if not GameManager.background_changed.is_connected(_on_background_changed):
		GameManager.background_changed.connect(_on_background_changed)
	if not GameManager.arena_modifiers_updated.is_connected(_on_arena_modifiers_updated):
		GameManager.arena_modifiers_updated.connect(_on_arena_modifiers_updated)
	if GameManager.current_background_path != "":
		_on_background_changed(GameManager.current_background_path, GameManager.get_current_arena_info())
	_on_arena_modifiers_updated(GameManager.get_active_arena_modifiers(), GameManager.get_current_arena_info())
	
	skill_choice_modal = SKILL_CHOICE_MODAL_SCENE.instantiate()
	add_child(skill_choice_modal)
	
	evolution_choice_modal = EVOLUTION_CHOICE_MODAL_SCENE.instantiate()
	add_child(evolution_choice_modal)
	
	unit_detail_modal = UNIT_DETAIL_MODAL_SCENE.instantiate()
	add_child(unit_detail_modal)
	
	trainer_augment_modal = TRAINER_AUGMENT_MODAL_SCENE.instantiate()
	add_child(trainer_augment_modal)
	
	boss_health_bar = BOSS_HEALTH_BAR_SCENE.instantiate()
	add_child(boss_health_bar)
	
	weather_overlay = WEATHER_OVERLAY_SCENE.instantiate()
	add_child(weather_overlay)
	move_child(weather_overlay, 0)
	
	weather_banner = WEATHER_BANNER_SCENE.instantiate()
	weather_banner.name = "WeatherBanner"
	if environment_bar:
		environment_bar.add_child(weather_banner)
	else:
		weather_banner.position = Vector2(810, 58)
		add_child(weather_banner)
	
	team_comp_planner = TEAM_COMP_PLANNER_SCENE.instantiate()
	add_child(team_comp_planner)
	
	if team_comp_btn == null:
		team_comp_btn = Button.new()
		team_comp_btn.name = "TeamCompBtn"
		team_comp_btn.text = "📋 阵容 [C]"
		team_comp_btn.custom_minimum_size = Vector2(80, 30)
		team_comp_btn.add_theme_font_size_override("font_size", 11)
		var tc_style = StyleBoxFlat.new()
		tc_style.bg_color = Color(0.18, 0.24, 0.35, 1)
		tc_style.border_color = Color(0.35, 0.55, 0.85, 1)
		tc_style.set_border_width_all(1)
		tc_style.set_corner_radius_all(4)
		team_comp_btn.add_theme_stylebox_override("normal", tc_style)
		if action_buttons:
			action_buttons.add_child(team_comp_btn)
		else:
			team_comp_btn.position = Vector2(820, 13)
			add_child(team_comp_btn)
	team_comp_btn.pressed.connect(_on_team_comp_btn_pressed)
	
	if dynamax_btn == null:
		dynamax_btn = Button.new()
		dynamax_btn.name = "DynamaxBtn"
		dynamax_btn.text = "🔴 极巨化"
		dynamax_btn.custom_minimum_size = Vector2(90, 30)
		dynamax_btn.add_theme_font_size_override("font_size", 11)
		var d_style = StyleBoxFlat.new()
		d_style.bg_color = Color(0.45, 0.12, 0.18, 1)
		d_style.border_color = Color(0.95, 0.3, 0.45, 1)
		d_style.set_border_width_all(1)
		d_style.set_corner_radius_all(4)
		dynamax_btn.add_theme_stylebox_override("normal", d_style)
		if action_buttons:
			action_buttons.add_child(dynamax_btn)
		else:
			dynamax_btn.position = Vector2(910, 13)
			add_child(dynamax_btn)
	dynamax_btn.pressed.connect(_on_dynamax_btn_pressed)
	if MegaDatabase:
		if not MegaDatabase.dynamax_energy_changed.is_connected(_on_dynamax_energy_changed):
			MegaDatabase.dynamax_energy_changed.connect(_on_dynamax_energy_changed)
	_update_dynamax_btn_display()
	
	if audio_btn == null:
		audio_btn = Button.new()
		audio_btn.name = "AudioToggleBtn"
		audio_btn.text = "🎵 音乐 [M]"
		audio_btn.custom_minimum_size = Vector2(75, 30)
		audio_btn.add_theme_font_size_override("font_size", 11)
		var a_style = StyleBoxFlat.new()
		a_style.bg_color = Color(0.18, 0.24, 0.35, 1)
		a_style.border_color = Color(0.4, 0.6, 0.8, 1)
		a_style.set_border_width_all(1)
		a_style.set_corner_radius_all(4)
		audio_btn.add_theme_stylebox_override("normal", a_style)
		if action_buttons:
			action_buttons.add_child(audio_btn)
		else:
			audio_btn.position = Vector2(1010, 13)
			add_child(audio_btn)
	audio_btn.pressed.connect(_toggle_audio_mute)
	
	if recap_btn == null:
		recap_btn = Button.new()
		recap_btn.name = "RecapBtn"
		recap_btn.text = "📊 战报 [Tab]"
		recap_btn.custom_minimum_size = Vector2(75, 30)
		recap_btn.add_theme_font_size_override("font_size", 11)
		var r_style = StyleBoxFlat.new()
		r_style.bg_color = Color(0.18, 0.28, 0.45, 1)
		r_style.border_color = Color(0.4, 0.7, 1.0, 1)
		r_style.set_border_width_all(1)
		r_style.set_corner_radius_all(4)
		recap_btn.add_theme_stylebox_override("normal", r_style)
		if action_buttons:
			action_buttons.add_child(recap_btn)
		else:
			recap_btn.position = Vector2(1090, 13)
			add_child(recap_btn)
	recap_btn.pressed.connect(_on_recap_btn_pressed)
	
	trainer_widget = TRAINER_WIDGET_SCENE.instantiate()
	trainer_widget.name = "TrainerWidget"
	trainer_widget.position = Vector2(15, 60)
	add_child(trainer_widget)
	if has_node("SynergyPanel"):
		var syn_panel = get_node("SynergyPanel") as Control
		syn_panel.offset_top = 114.0

	sandbox_toolbar = SANDBOX_TOOLBAR_SCENE.instantiate()
	sandbox_toolbar.name = "SandboxToolbar"
	sandbox_toolbar.visible = false
	add_child(sandbox_toolbar)
	if not GameManager.sandbox_mode_toggled.is_connected(_on_sandbox_mode_toggled):
		GameManager.sandbox_mode_toggled.connect(_on_sandbox_mode_toggled)

	damage_recap_modal = DAMAGE_RECAP_MODAL_SCENE.instantiate()
	damage_recap_modal.name = "DamageRecapModal"
	damage_recap_modal.visible = false
	add_child(damage_recap_modal)

	gym_road_modal = GYM_ROAD_MODAL_SCENE.instantiate()
	gym_road_modal.name = "GymRoadModal"
	gym_road_modal.visible = false
	add_child(gym_road_modal)

	if gym_road_btn == null:
		gym_road_btn = Button.new()
		gym_road_btn.name = "GymRoadBtn"
		gym_road_btn.text = "🏛️ 道馆 [G]"
		gym_road_btn.custom_minimum_size = Vector2(75, 30)
		gym_road_btn.add_theme_font_size_override("font_size", 11)
		var gr_style = StyleBoxFlat.new()
		gr_style.bg_color = Color(0.18, 0.32, 0.48, 1)
		gr_style.border_color = Color(0.4, 0.7, 0.95, 1)
		gr_style.set_border_width_all(1)
		gr_style.set_corner_radius_all(4)
		gym_road_btn.add_theme_stylebox_override("normal", gr_style)
		if action_buttons:
			action_buttons.add_child(gym_road_btn)
		else:
			gym_road_btn.position = Vector2(1090, 13)
			add_child(gym_road_btn)
	gym_road_btn.pressed.connect(_on_gym_road_btn_pressed)
	
	# Add Sandbox Mode Button to Start Menu
	var btn_row = start_menu_modal.get_node_or_null("Dialog/VBox/BtnRow") if start_menu_modal else null
	if btn_row and not btn_row.has_node("GymRoadBtn"):
		var gym_start_btn = Button.new()
		gym_start_btn.name = "GymRoadBtn"
		gym_start_btn.text = "🏛️ 道馆巡礼"
		gym_start_btn.custom_minimum_size = Vector2(160, 52)
		gym_start_btn.add_theme_font_size_override("font_size", 18)
		var g_style = StyleBoxFlat.new()
		g_style.bg_color = Color(0.2, 0.35, 0.55, 1)
		g_style.border_color = Color(0.45, 0.75, 1.0, 0.9)
		g_style.set_border_width_all(1)
		g_style.set_corner_radius_all(6)
		gym_start_btn.add_theme_stylebox_override("normal", g_style)
		gym_start_btn.pressed.connect(_on_gym_road_btn_pressed)
		btn_row.add_child(gym_start_btn)
	if btn_row and not btn_row.has_node("SandboxBtn"):
		var sandbox_btn = Button.new()
		sandbox_btn.name = "SandboxBtn"
		sandbox_btn.text = "🧪 演练沙盒"
		sandbox_btn.custom_minimum_size = Vector2(160, 52)
		sandbox_btn.add_theme_font_size_override("font_size", 18)
		var s_style = StyleBoxFlat.new()
		s_style.bg_color = Color(0.35, 0.18, 0.52, 1)
		s_style.border_color = Color(0.75, 0.45, 1, 0.9)
		s_style.set_border_width_all(1)
		s_style.set_corner_radius_all(6)
		sandbox_btn.add_theme_stylebox_override("normal", s_style)
		sandbox_btn.pressed.connect(_on_sandbox_btn_pressed)
		btn_row.add_child(sandbox_btn)
	if btn_row and not btn_row.has_node("TrainerBtn"):
		var trainer_start_btn = Button.new()
		trainer_start_btn.name = "TrainerBtn"
		trainer_start_btn.text = "👑 训练家身份"
		trainer_start_btn.custom_minimum_size = Vector2(160, 52)
		trainer_start_btn.add_theme_font_size_override("font_size", 18)
		var t_style = StyleBoxFlat.new()
		t_style.bg_color = Color(0.22, 0.32, 0.5, 1)
		t_style.border_color = Color(0.45, 0.75, 1.0, 0.9)
		t_style.set_border_width_all(1)
		t_style.set_corner_radius_all(6)
		trainer_start_btn.add_theme_stylebox_override("normal", t_style)
		trainer_start_btn.pressed.connect(func():
			if trainer_widget and trainer_widget.has_method("open_trainer_selection_modal"):
				trainer_widget.open_trainer_selection_modal()
		)
		btn_row.add_child(trainer_start_btn)
		
	# Add Detailed Recap Button to End Game Modal
	var end_vbox = end_modal.get_node_or_null("VBox") if end_modal else null
	if end_vbox and not end_vbox.has_node("ViewRecapBtn"):
		var view_recap_btn = Button.new()
		view_recap_btn.name = "ViewRecapBtn"
		view_recap_btn.text = "📊 查看完整战报数据"
		view_recap_btn.custom_minimum_size = Vector2(180, 38)
		view_recap_btn.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
		var vr_style = StyleBoxFlat.new()
		vr_style.bg_color = Color(0.18, 0.28, 0.45, 1)
		vr_style.border_color = Color(0.4, 0.7, 1.0, 1)
		vr_style.set_border_width_all(1)
		vr_style.set_corner_radius_all(4)
		view_recap_btn.add_theme_stylebox_override("normal", vr_style)
		view_recap_btn.pressed.connect(_on_recap_btn_pressed)
		end_vbox.add_child(view_recap_btn)
		end_vbox.move_child(view_recap_btn, end_vbox.get_child_count() - 2)
	
	# Win/Loss Streak Visual Badge Indicator
	if streak_badge == null:
		streak_badge = PanelContainer.new()
		streak_badge.name = "StreakBadge"
		var sb_style = StyleBoxFlat.new()
		sb_style.bg_color = Color(0.12, 0.14, 0.18, 0.9)
		sb_style.set_corner_radius_all(4)
		sb_style.content_margin_left = 6
		sb_style.content_margin_right = 6
		sb_style.content_margin_top = 2
		sb_style.content_margin_bottom = 2
		streak_badge.add_theme_stylebox_override("panel", sb_style)
		
		streak_badge_label = Label.new()
		streak_badge_label.name = "StreakBadgeLabel"
		streak_badge_label.add_theme_font_size_override("font_size", 11)
		streak_badge.add_child(streak_badge_label)
		
		var round_info = $TopBar/RoundInfo if has_node("TopBar/RoundInfo") else null
		if round_info:
			round_info.add_child(streak_badge)
			round_info.move_child(streak_badge, 1)
		streak_badge.visible = false
	update_streak_badge()
	
	item_bench = ITEM_BENCH_SCENE.instantiate()
	item_bench.name = "ItemBench"
	item_bench.offset_left = 1090.0
	item_bench.offset_top = 265.0
	item_bench.offset_right = 1265.0
	item_bench.offset_bottom = 468.0
	add_child(item_bench)
	
	# Only visible once game has actually started (hidden during start menu modal)
	if start_menu_modal and start_menu_modal.visible:
		item_bench.visible = false
		GameManager.is_game_started = false
		start_menu_modal.z_index = 50
		start_menu_modal.move_to_front()
	else:
		item_bench.visible = true
		GameManager.is_game_started = true
	
	GameManager.hud_ref = self
	GameManager.item_bench = item_bench
	
	init_shop_cards()
	init_sell_drop_zone()
	if start_menu_modal and start_menu_modal.visible:
		start_menu_modal.move_to_front()

func init_shop_cards() -> void:
	for c in cards_container.get_children():
		c.queue_free()
	card_instances.clear()
	for i in range(5):
		var card = SHOP_CARD_SCENE.instantiate()
		cards_container.add_child(card)
		card_instances.append(card)

func _process(_delta: float) -> void:
	# Update phase timer text
	if GameManager.current_phase == GameManager.Phase.PREPARATION:
		var sec = max(0, int(GameManager.phase_timer))
		timer_label.text = "%ds" % sec
		start_battle_btn.visible = true
		big_start_battle_btn.visible = true
		big_start_battle_btn.text = "⚔️ 开始战斗 (%ds)" % sec
	elif GameManager.current_phase == GameManager.Phase.COMBAT:
		timer_label.text = "%ds" % max(0, int(GameManager.phase_timer))
		start_battle_btn.visible = false
		big_start_battle_btn.visible = false
		if dps_meter:
			dps_update_timer += _delta
			if dps_update_timer >= 0.2:
				dps_update_timer = 0.0
				_update_dps_meter_from_combat()
	else:
		timer_label.text = "--"
		start_battle_btn.visible = false
		big_start_battle_btn.visible = false

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_SPACE:
			if start_menu_modal.visible:
				_on_play_game_pressed()
			elif GameManager.current_phase == GameManager.Phase.PREPARATION:
				_on_start_battle_pressed()
		elif event.keycode == KEY_P:
			_on_pokedex_pressed()
		elif event.keycode == KEY_B:
			_on_arena_bg_pressed()
		elif event.keycode == KEY_S:
			if dps_meter:
				dps_meter.toggle_visibility()
		elif event.keycode == KEY_M:
			_toggle_audio_mute()
		elif event.keycode == KEY_C:
			_on_team_comp_btn_pressed()
		elif event.keycode == KEY_D:
			_on_dynamax_btn_pressed()
		elif event.keycode == KEY_F:
			_on_buy_exp_pressed()
		elif event.keycode == KEY_R:
			_on_reroll_pressed()
		elif event.keycode == KEY_E:
			_on_sell_pressed()
		elif event.keycode == KEY_L:
			if lock_btn:
				lock_btn.button_pressed = not lock_btn.button_pressed
				_on_lock_toggled(lock_btn.button_pressed)
		elif event.keycode == KEY_TAB:
			_on_recap_btn_pressed()
		elif event.keycode == KEY_G:
			_on_gym_road_btn_pressed()
		elif event.keycode == KEY_Q:
			if trainer_widget and trainer_widget.has_method("execute_active_tactic"):
				trainer_widget.execute_active_tactic()

func _toggle_audio_mute() -> void:
	var muted = AudioManager.toggle_mute()
	if audio_btn:
		audio_btn.text = "🔇 静音 [M]" if muted else "🎵 音乐 [M]"
	show_toast("🔇 背景音乐与音效已静音" if muted else "🎵 背景音乐与音效已开启", Color(0.8, 0.9, 1.0))

func _on_team_comp_btn_pressed() -> void:
	if team_comp_planner:
		if team_comp_planner.visible:
			team_comp_planner.close()
		else:
			team_comp_planner.open_modal()

func _on_dynamax_btn_pressed() -> void:
	if GameManager.current_phase != GameManager.Phase.PREPARATION:
		show_toast("⚠️ 只能在准备阶段激活或调整极巨化！", Color(1.0, 0.4, 0.4))
		_flash_dynamax_btn_warning()
		return
	if not GameManager.board_ref:
		return
	
	var target: Unit = GameManager.board_ref.selected_unit
	
	# If no unit selected on board
	if target == null:
		if MegaDatabase and MegaDatabase.current_dynamax_target != null:
			var prev_target = MegaDatabase.current_dynamax_target
			var prev_name = PokemonDatabase.get_pokemon(prev_target.pokemon_id).get("name", prev_target.pokemon_id) if is_instance_valid(prev_target) else "宝可梦"
			MegaDatabase.clear_dynamax()
			show_toast("已取消【%s】的本回合极巨化，能量已保留！" % prev_name, Color(0.5, 0.85, 1.0))
			_update_dynamax_btn_display()
			return
		show_toast("⚠️ 请先在棋盘上点击选择要极巨化的己方宝可梦！", Color(1.0, 0.75, 0.3))
		_flash_dynamax_btn_warning()
		return
		
	# If enemy selected
	if target.is_enemy:
		show_toast("⚠️ 无法对敌方目标使用极巨化！请选择己方宝可梦", Color(1.0, 0.4, 0.4))
		_flash_dynamax_btn_warning()
		return
		
	# If bench unit selected
	if target.is_on_bench:
		show_toast("⚠️ 备战席上的宝可梦无法极巨化！请先将其放置上阵并选中", Color(1.0, 0.65, 0.3))
		_flash_dynamax_btn_warning()
		return
		
	var target_name = PokemonDatabase.get_pokemon(target.pokemon_id).get("name", target.pokemon_id)
	
	# If this unit is ALREADY the dynamaxed unit, toggle off (cancel)
	if MegaDatabase and MegaDatabase.current_dynamax_target == target:
		MegaDatabase.clear_dynamax()
		show_toast("已取消【%s】的本回合极巨化，能量已保留！" % target_name, Color(0.5, 0.85, 1.0))
		_update_dynamax_btn_display()
		return
		
	# If another unit is already dynamaxed, switch to this unit
	if MegaDatabase and MegaDatabase.current_dynamax_target != null:
		MegaDatabase.set_dynamax_target(target)
		target.activate_dynamax()
		AudioManager.play_sfx("click")
		show_toast("🔴 已将本回合极巨化切换为【%s】！" % target_name, Color(1.0, 0.4, 0.6))
		_update_dynamax_btn_display()
		return
		
	# Check if energy is full
	if not MegaDatabase.is_energy_full():
		show_toast("⚡ 极巨能量未满 (%d/%d)！通过战斗积攒能量后再激活" % [MegaDatabase.dynamax_energy, MegaDatabase.MAX_DYNAMAX_ENERGY], Color(1.0, 0.4, 0.4))
		_flash_dynamax_btn_warning()
		return
		
	# Activate dynamax on selected target
	MegaDatabase.set_dynamax_target(target)
	target.activate_dynamax()
	AudioManager.play_sfx("click")
	show_toast("🔴【%s】极巨化就绪！将在本回合战斗中以极巨形态出战！" % target_name, Color(1.0, 0.4, 0.6))
	_update_dynamax_btn_display()

func _on_dynamax_energy_changed(_cur: int, _max_val: int) -> void:
	_update_dynamax_btn_display()

func _update_dynamax_btn_display() -> void:
	if dynamax_btn == null:
		return
	
	var is_prep = (GameManager.current_phase == GameManager.Phase.PREPARATION)
	var active_target = MegaDatabase.current_dynamax_target if MegaDatabase else null
	
	if active_target != null and is_instance_valid(active_target):
		var p_name = PokemonDatabase.get_pokemon(active_target.pokemon_id).get("name", active_target.pokemon_id)
		if is_prep:
			dynamax_btn.text = "🔴 极巨生效: 【%s】" % p_name
			dynamax_btn.modulate = Color(1.0, 0.35, 0.55)
			dynamax_btn.tooltip_text = "【%s】已激活极巨化 (仅本回合生效)\n在准备阶段再次点击可取消，或选中其他棋子切换目标" % p_name
		else:
			dynamax_btn.text = "🔴 极巨作战: 【%s】" % p_name
			dynamax_btn.modulate = Color(1.0, 0.45, 0.45)
			dynamax_btn.tooltip_text = "【%s】正在以极巨形态进行本回合对决！" % p_name
	elif MegaDatabase and MegaDatabase.is_energy_full():
		dynamax_btn.text = "🔴 极巨化就绪 [100%]"
		dynamax_btn.modulate = Color(1.0, 0.85, 0.25)
		dynamax_btn.tooltip_text = "极巨能量已满 (100/100)！\n在战场上点击选中己方宝可梦后，点击此按钮激活极巨化 (单回合有效，快捷键 D)"
	else:
		var cur = MegaDatabase.dynamax_energy if MegaDatabase else 0
		var max_e = MegaDatabase.MAX_DYNAMAX_ENERGY if MegaDatabase else 100
		var pct = int((float(cur) / float(max_e)) * 100.0)
		dynamax_btn.text = "⚡ 极巨能量: %d%%" % pct
		dynamax_btn.modulate = Color(0.72, 0.78, 0.88)
		dynamax_btn.tooltip_text = "极巨能量蓄能中: %d/%d (%d%%)\n• 宝可梦释放技能: +2 能量\n• 击败敌方棋子: +3 能量\n• 回合胜利: +40 能量 / 失败: +30 能量\n能量攒满 (100%%) 即可激活单回合极巨化！" % [cur, max_e, pct]

func _flash_dynamax_btn_warning() -> void:
	if dynamax_btn == null:
		return
	var tw = create_tween()
	tw.tween_property(dynamax_btn, "modulate", Color(1.0, 0.2, 0.2), 0.08)
	tw.tween_property(dynamax_btn, "modulate", Color.WHITE, 0.08)
	tw.tween_property(dynamax_btn, "modulate", Color(1.0, 0.2, 0.2), 0.08)
	tw.tween_callback(func(): _update_dynamax_btn_display())

func show_toast(msg: String, col: Color = Color.WHITE) -> void:
	if active_toast and is_instance_valid(active_toast):
		active_toast.queue_free()
		active_toast = null
	
	var toast = PanelContainer.new()
	toast.name = "GameToast"
	toast.mouse_filter = Control.MOUSE_FILTER_IGNORE
	toast.z_index = 100
	
	var style = StyleBoxFlat.new()
	style.bg_color = Color(0.06, 0.08, 0.12, 0.94)
	style.border_color = col if col != Color.WHITE else Color(0.95, 0.75, 0.2, 0.9)
	style.set_border_width_all(2)
	style.set_corner_radius_all(8)
	style.content_margin_left = 18.0
	style.content_margin_right = 18.0
	style.content_margin_top = 8.0
	style.content_margin_bottom = 8.0
	toast.add_theme_stylebox_override("panel", style)
	
	var lbl = Label.new()
	lbl.text = msg
	lbl.add_theme_font_size_override("font_size", 14)
	lbl.add_theme_color_override("font_color", col)
	lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	toast.add_child(lbl)
	
	add_child(toast)
	active_toast = toast
	
	var sw = get_viewport().get_visible_rect().size.x if get_viewport() else 1280.0
	toast.custom_minimum_size = Vector2(400, 36)
	toast.position = Vector2(max(10.0, (sw - 420.0) * 0.5), 110.0)
	toast.modulate.a = 0.0
	
	var tw = create_tween()
	tw.tween_property(toast, "modulate:a", 1.0, 0.14)
	tw.parallel().tween_property(toast, "position:y", 100.0, 0.14)
	tw.tween_interval(1.8)
	tw.tween_property(toast, "modulate:a", 0.0, 0.28)
	tw.parallel().tween_property(toast, "position:y", 90.0, 0.28)
	tw.tween_callback(func():
		if is_instance_valid(toast):
			toast.queue_free()
	)

func _on_lore_synergy_activated(synergy: Dictionary) -> void:
	show_lore_synergy_banner(synergy)

func show_lore_synergy_banner(synergy: Dictionary) -> void:
	var banner = PanelContainer.new()
	banner.name = "LoreSynergyBanner"
	banner.mouse_filter = Control.MOUSE_FILTER_IGNORE
	banner.z_index = 120
	
	var style = StyleBoxFlat.new()
	style.bg_color = Color(0.08, 0.10, 0.16, 0.96)
	style.border_color = Color(1.0, 0.85, 0.25, 0.95)
	style.set_border_width_all(2)
	style.set_corner_radius_all(10)
	style.shadow_color = Color(1.0, 0.85, 0.2, 0.45)
	style.shadow_size = 8
	style.content_margin_left = 24.0
	style.content_margin_right = 24.0
	style.content_margin_top = 10.0
	style.content_margin_bottom = 10.0
	banner.add_theme_stylebox_override("panel", style)
	
	var vbox = VBoxContainer.new()
	vbox.add_theme_constant_override("separation", 4)
	
	var title_lbl = Label.new()
	var syn_name = synergy.get("name", "")
	var syn_en = synergy.get("en_name", "")
	var syn_icon = synergy.get("icon", "🌟")
	title_lbl.text = "%s 【经典情怀隐藏羁绊激活】%s (%s) %s" % [syn_icon, syn_name, syn_en, syn_icon]
	title_lbl.add_theme_font_size_override("font_size", 15)
	title_lbl.add_theme_color_override("font_color", Color(1.0, 0.92, 0.3))
	title_lbl.add_theme_color_override("font_outline_color", Color(0.4, 0.25, 0.0, 0.9))
	title_lbl.add_theme_constant_override("outline_size", 3)
	title_lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	vbox.add_child(title_lbl)
	
	var desc_lbl = Label.new()
	desc_lbl.text = synergy.get("description", "")
	desc_lbl.add_theme_font_size_override("font_size", 12)
	desc_lbl.add_theme_color_override("font_color", Color(0.9, 0.95, 1.0))
	desc_lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	vbox.add_child(desc_lbl)
	
	banner.add_child(vbox)
	add_child(banner)
	
	var sw = get_viewport().get_visible_rect().size.x if get_viewport() else 1280.0
	banner.custom_minimum_size = Vector2(460, 56)
	banner.position = Vector2(max(10.0, (sw - 480.0) * 0.5), 140.0)
	banner.modulate.a = 0.0
	
	var tw = create_tween()
	tw.tween_property(banner, "modulate:a", 1.0, 0.18)
	tw.parallel().tween_property(banner, "position:y", 125.0, 0.18)
	tw.tween_interval(2.6)
	tw.tween_property(banner, "modulate:a", 0.0, 0.35)
	tw.parallel().tween_property(banner, "position:y", 110.0, 0.35)
	tw.tween_callback(func():
		if is_instance_valid(banner):
			banner.queue_free()
	)

func _on_pokedex_pressed() -> void:
	if pokedex_modal.visible:
		pokedex_modal.hide_pokedex()
	else:
		pokedex_modal.open_pokedex()

func _on_play_game_pressed() -> void:
	AudioManager.play_sfx("round_start")
	GameManager.is_game_started = true
	GameManager.phase_timer = GameManager.PREP_TIME
	if item_bench:
		item_bench.visible = true
	var tw = create_tween()
	tw.tween_property(start_menu_modal, "modulate:a", 0.0, 0.25)
	tw.tween_callback(func():
		start_menu_modal.visible = false
		start_menu_modal.modulate.a = 1.0
		# If round 1, open trainer augment selection modal
		if GameManager.current_round == 1:
			open_trainer_augment_modal()
	)

func _on_sandbox_btn_pressed() -> void:
	AudioManager.play_sfx("round_start")
	if item_bench:
		item_bench.visible = true
	var tw = create_tween()
	tw.tween_property(start_menu_modal, "modulate:a", 0.0, 0.2)
	tw.tween_callback(func():
		start_menu_modal.visible = false
		start_menu_modal.modulate.a = 1.0
		GameManager.enter_sandbox_mode()
	)

func _on_sandbox_mode_toggled(is_sandbox: bool) -> void:
	if sandbox_toolbar:
		sandbox_toolbar.visible = is_sandbox

func _on_gym_road_btn_pressed() -> void:
	if gym_road_modal == null:
		return
	if gym_road_modal.visible:
		gym_road_modal.hide_modal()
	else:
		gym_road_modal.open_modal()

func _on_recap_btn_pressed() -> void:
	if damage_recap_modal == null:
		return
	if damage_recap_modal.visible:
		damage_recap_modal.close_modal()
	else:
		var metrics: Array = []
		if dps_meter and "raw_unit_data" in dps_meter and not dps_meter.raw_unit_data.is_empty():
			metrics = dps_meter.raw_unit_data
		else:
			var all_units = get_tree().get_nodes_in_group("units")
			for node in all_units:
				var u = node as Unit
				if u != null and not u.is_on_bench:
					var uname = PokemonDatabase.get_pokemon(u.pokemon_id).get("name", u.pokemon_id)
					metrics.append({
						"unit": u,
						"id": u.pokemon_id,
						"name": uname,
						"star": u.star_level,
						"damage": u.damage_dealt,
						"taken": u.damage_taken,
						"healing": u.healing_done,
						"is_enemy": u.is_enemy
					})
		damage_recap_modal.open_recap(metrics, GameManager.current_round)

func _on_hp_changed(new_hp: int, _delta: int) -> void:
	hp_bar.value = new_hp
	hp_label.text = "HP: %d / 100" % new_hp

func _on_gold_changed(new_gold: int, _delta: int) -> void:
	gold_label.text = "%d" % new_gold
	var max_cap = 8 if (AugmentDatabase and AugmentDatabase.has_augment("interest_tycoon")) else (6 if (TrainerSystem and TrainerSystem.has_giovanni_passive()) else 5)
	var interest = min(max_cap, int(new_gold / 10))
	interest_label.text = "利息 +%d" % interest

func _on_level_changed(new_lvl: int, cur_exp: int, max_exp: int) -> void:
	var cur_count = GameManager.board_ref.count_player_units_on_board() if GameManager.board_ref else 0
	level_label.text = "Lv.%d (棋子: %d/%d)" % [new_lvl, cur_count, new_lvl]
	exp_bar.max_value = max_exp if max_exp > 0 else 1
	exp_bar.value = cur_exp
	exp_label.text = "%d / %d EXP" % [cur_exp, max_exp]

func _on_round_changed(new_round: int) -> void:
	round_label.text = "第 %d 回合" % new_round
	update_streak_badge()

func update_streak_badge() -> void:
	if streak_badge == null or streak_badge_label == null:
		return
	if GameManager.win_streak >= 2:
		var bonus = 1
		if GameManager.win_streak >= 5:
			bonus = 3
		elif GameManager.win_streak >= 3:
			bonus = 2
		streak_badge_label.text = "🔥 %d连胜 (+%dG)" % [GameManager.win_streak, bonus]
		streak_badge_label.add_theme_color_override("font_color", Color(1.0, 0.7, 0.2))
		var style: StyleBoxFlat = streak_badge.get_theme_stylebox("panel") as StyleBoxFlat
		if style:
			style.bg_color = Color(0.38, 0.12, 0.05, 0.88)
			style.border_color = Color(1.0, 0.55, 0.2, 0.95)
			style.set_border_width_all(1)
		streak_badge.tooltip_text = "当前处于连胜状态！每回合额外奖励 +%d 金币" % bonus
		streak_badge.visible = true
	elif GameManager.loss_streak >= 2:
		var bonus = 1
		if GameManager.loss_streak >= 5:
			bonus = 3
		elif GameManager.loss_streak >= 3:
			bonus = 2
		streak_badge_label.text = "❄️ %d连败 (+%dG)" % [GameManager.loss_streak, bonus]
		streak_badge_label.add_theme_color_override("font_color", Color(0.45, 0.82, 1.0))
		var style: StyleBoxFlat = streak_badge.get_theme_stylebox("panel") as StyleBoxFlat
		if style:
			style.bg_color = Color(0.06, 0.18, 0.35, 0.88)
			style.border_color = Color(0.3, 0.75, 1.0, 0.95)
			style.set_border_width_all(1)
		streak_badge.tooltip_text = "当前处于连败状态！每回合额外奖励 +%d 金币" % bonus
		streak_badge.visible = true
	else:
		streak_badge.visible = false

func _on_cinematic_spotlight_requested(duration: float, darkness: float) -> void:
	if cinematic_spotlight:
		var tw = create_tween()
		tw.tween_property(cinematic_spotlight, "color:a", darkness, 0.12).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tw.tween_interval(max(0.1, duration * 0.5))
		tw.tween_property(cinematic_spotlight, "color:a", 0.0, 0.25).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)

func _on_phase_changed(phase_str: String, _time_left: float) -> void:
	update_streak_badge()
	match phase_str:
		"PREP":
			phase_label.text = "【准备阶段】"
			phase_label.modulate = Color(0.3, 0.85, 0.4)
			shop_panel.modulate = Color(1.0, 1.0, 1.0, 1.0)
			if MegaDatabase:
				MegaDatabase.clear_dynamax()
			_update_dynamax_btn_display()
		"COMBAT":
			phase_label.text = "【战斗阶段】"
			phase_label.modulate = Color(0.95, 0.35, 0.35)
			shop_panel.modulate = Color(1.0, 1.0, 1.0, 1.0)
			if dps_meter:
				dps_meter.reset_metrics()
			_update_dynamax_btn_display()
		"RESOLVE":
			phase_label.text = "【回合结算】"
			phase_label.modulate = Color(0.9, 0.8, 0.2)
			if dps_meter:
				_update_dps_meter_from_combat()
			_update_dynamax_btn_display()
		"GAME_OVER":
			show_end_modal(false)
		"VICTORY":
			show_end_modal(true)

func _update_dps_meter_from_combat() -> void:
	if dps_meter == null:
		return
	var metrics: Array = []
	var all_units = get_tree().get_nodes_in_group("units")
	for node in all_units:
		var u = node as Unit
		if u != null and not u.is_on_bench:
			var c_time = max(0.5, u.combat_time)
			var dps_val = u.damage_dealt / c_time if u.damage_dealt > 0 else 0.0
			var uname = PokemonDatabase.get_pokemon(u.pokemon_id).get("name", u.pokemon_id)
			metrics.append({
				"unit": u,
				"id": u.pokemon_id,
				"name": uname,
				"star": u.star_level,
				"damage": u.damage_dealt,
				"taken": u.damage_taken,
				"healing": u.healing_done,
				"dps": dps_val,
				"is_enemy": u.is_enemy
			})
	dps_meter.update_metrics(metrics)

func _on_shop_refreshed(cards: Array) -> void:
	for i in range(card_instances.size()):
		if i < cards.size():
			var s_info = ShinyAndLoreManager.get_shop_card_shiny_info(i) if ShinyAndLoreManager else {}
			card_instances[i].setup(cards[i], i, s_info.get("is_shiny", false), s_info.get("affix", ""))
		else:
			card_instances[i].setup("", i)

func _on_synergies_updated(syn_dict: Dictionary) -> void:
	for c in synergy_list.get_children():
		c.queue_free()
		
	for tname in syn_dict:
		var item = syn_dict[tname]
		var count = item["count"]
		var tier = item["tier"]
		
		var panel = PanelContainer.new()
		var p_style = StyleBoxFlat.new()
		p_style.bg_color = Color(0.12, 0.15, 0.22, 0.85)
		p_style.set_corner_radius_all(4)
		if tier > 0:
			p_style.border_width_left = 3
			p_style.border_color = Color(1.0, 0.8, 0.2)
		panel.add_theme_stylebox_override("panel", p_style)
		
		var hbox = HBoxContainer.new()
		hbox.custom_minimum_size = Vector2(170, 32)
		
		# Icon
		var icon_rect = TextureRect.new()
		if ResourceLoader.exists(item["icon"]):
			icon_rect.texture = load(item["icon"])
		icon_rect.custom_minimum_size = Vector2(24, 24)
		icon_rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		hbox.add_child(icon_rect)
		
		# Text
		var lbl = Label.new()
		lbl.add_theme_font_size_override("font_size", 12)
		lbl.text = " %s: %d个" % [item["name"], count]
		if tier > 0:
			lbl.modulate = Color(1.0, 0.9, 0.3)
		else:
			lbl.modulate = Color(0.7, 0.75, 0.8)
		hbox.add_child(lbl)
		
		panel.add_child(hbox)
		synergy_list.add_child(panel)

func _on_start_battle_pressed() -> void:
	AudioManager.play_sfx("click")
	GameManager.force_start_combat()

func _on_reroll_pressed() -> void:
	GameManager.refresh_shop(false)

func _on_buy_exp_pressed() -> void:
	GameManager.buy_exp()

func _on_lock_toggled(toggled_on: bool) -> void:
	GameManager.shop_locked = toggled_on
	AudioManager.play_sfx("click")
	lock_btn.text = "已锁定" if toggled_on else "锁定"

func _on_sell_pressed() -> void:
	if GameManager.board_ref and GameManager.board_ref.selected_unit != null:
		var u = GameManager.board_ref.selected_unit
		var can_sell = (GameManager.current_phase == GameManager.Phase.PREPARATION) or (GameManager.current_phase == GameManager.Phase.COMBAT and u.is_on_bench)
		if can_sell:
			GameManager.board_ref.sell_unit(u)
			sell_btn.visible = false

func show_end_modal(won: bool) -> void:
	end_modal.visible = true
	if won:
		end_title.text = "🎉 恭喜达成全胜冠军! 🎉"
		end_title.modulate = Color(1.0, 0.85, 0.2)
		end_subtitle.text = "您成功击溃了所有波次与 Boss 试炼，成为宝可梦大师！"
	else:
		end_title.text = "💀 游戏结束 💀"
		end_title.modulate = Color(0.95, 0.3, 0.3)
		end_subtitle.text = "您的生命值已耗尽。坚持到了第 %d 回合！" % GameManager.current_round

func _on_restart_pressed() -> void:
	end_modal.visible = false
	AudioManager.play_sfx("click")
	get_tree().reload_current_scene()

func _on_skill_choice_requested(unit: Unit, star_lvl: int) -> void:
	if skill_choice_modal and is_instance_valid(unit) and not unit.is_enemy:
		skill_choice_modal.open_for_unit(unit, star_lvl)

func _on_skill_swap_pressed() -> void:
	if GameManager.board_ref and GameManager.board_ref.selected_unit != null:
		var u = GameManager.board_ref.selected_unit
		if skill_choice_modal:
			skill_choice_modal.open_for_unit(u, u.star_level)

func _on_unit_inspected(unit: Unit) -> void:
	if unit_detail_modal:
		if unit != null and is_instance_valid(unit):
			unit_detail_modal.open_for_unit(unit)
		else:
			unit_detail_modal.close()
			
	if not is_drag_selling:
		if unit != null and is_instance_valid(unit) and not unit.is_enemy:
			var can_sell = (GameManager.current_phase == GameManager.Phase.PREPARATION) or (GameManager.current_phase == GameManager.Phase.COMBAT and unit.is_on_bench)
			if can_sell:
				var data = PokemonDatabase.get_pokemon(unit.pokemon_id)
				var refund = data.get("cost", 1) * int(pow(3, unit.star_level - 1))
				sell_btn.text = "出售 (%dG)" % refund
				sell_btn.visible = true
			else:
				sell_btn.visible = false
		else:
			sell_btn.visible = false

func _on_evolution_choice_requested(unit: Unit, evo_options: Array) -> void:
	if evolution_choice_modal and is_instance_valid(unit) and not unit.is_enemy:
		evolution_choice_modal.open_for_unit(unit, evo_options)

func _on_arena_bg_pressed() -> void:
	if arena_modal and arena_modal.has_method("open_modal"):
		if arena_modal.visible:
			arena_modal.hide_modal()
		else:
			arena_modal.open_modal()
	else:
		GameManager.cycle_background()

func _on_arena_banner_pressed() -> void:
	if arena_modal and arena_modal.has_method("open_modal"):
		arena_modal.open_modal()

func _on_background_changed(_bg_path: String, arena_info: Dictionary = {}) -> void:
	var a_name = arena_info.get("name", "场地")
	if arena_bg_btn:
		arena_bg_btn.text = "🏟️ 场地 (B)"
		arena_bg_btn.tooltip_text = "%s: %s (快捷键 B)" % [a_name, arena_info.get("desc", "")]

func _on_arena_modifiers_updated(active_mods: Array, arena_info: Dictionary = {}) -> void:
	var a_name = arena_info.get("name", "场地")
	var tier = GameManager.get_active_arena_tier()
	var all_mods: Array = arena_info.get("modifiers", [])
	var next_round = GameManager.get_next_awaken_round()
	
	if arena_bg_btn:
		if active_mods.size() > 0:
			arena_bg_btn.text = "🏟️ 场地 [%d] (B)" % active_mods.size()
		else:
			arena_bg_btn.text = "🏟️ 场地 (B)"
		arena_bg_btn.tooltip_text = "%s (点击查看场地环境特性 / 按 B 切换)" % a_name
		
	if arena_banner:
		var summary_parts: Array[String] = []
		for m in active_mods:
			summary_parts.append(m.get("name", ""))
		var summary_text = " + ".join(summary_parts) if not summary_parts.is_empty() else "暂无"
		var next_hint = " | 下一特性: 第%d局" % next_round if tier < all_mods.size() else " | 全特性觉醒!"
		arena_banner.text = "🏟️【%s Lv.%d】%s%s (点击查看)" % [a_name, active_mods.size(), summary_text, next_hint]

# ==================== 拖动出售区域 (Sell Drop Zone) ====================

func init_sell_drop_zone() -> void:
	sell_drop_zone = Panel.new()
	sell_drop_zone.name = "SellDropZone"
	sell_drop_zone.offset_left = 215.0
	sell_drop_zone.offset_top = 548.0
	sell_drop_zone.offset_right = 1265.0
	sell_drop_zone.offset_bottom = 712.0
	sell_drop_zone.mouse_filter = Control.MOUSE_FILTER_IGNORE
	sell_drop_zone.visible = false
	sell_drop_zone.z_index = 25
	
	var vbox = VBoxContainer.new()
	vbox.name = "VBox"
	vbox.set_anchors_preset(Control.PRESET_FULL_RECT)
	vbox.alignment = BoxContainer.ALIGNMENT_CENTER
	vbox.mouse_filter = Control.MOUSE_FILTER_IGNORE
	vbox.add_theme_constant_override("separation", 6)
	sell_drop_zone.add_child(vbox)
	
	var hbox = HBoxContainer.new()
	hbox.alignment = BoxContainer.ALIGNMENT_CENTER
	hbox.mouse_filter = Control.MOUSE_FILTER_IGNORE
	hbox.add_theme_constant_override("separation", 12)
	vbox.add_child(hbox)
	
	sell_drop_icon = Label.new()
	sell_drop_icon.text = "🪙"
	sell_drop_icon.add_theme_font_size_override("font_size", 34)
	sell_drop_icon.mouse_filter = Control.MOUSE_FILTER_IGNORE
	hbox.add_child(sell_drop_icon)
	
	sell_drop_label = Label.new()
	sell_drop_label.name = "TitleLabel"
	sell_drop_label.text = "拖动到此处出售角色"
	sell_drop_label.add_theme_font_size_override("font_size", 20)
	sell_drop_label.add_theme_color_override("font_color", Color(1.0, 0.9, 0.35))
	sell_drop_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	hbox.add_child(sell_drop_label)
	
	sell_drop_sub_label = Label.new()
	sell_drop_sub_label.name = "SubLabel"
	sell_drop_sub_label.text = "松开鼠标即可完成出售并立即返还金币"
	sell_drop_sub_label.add_theme_font_size_override("font_size", 13)
	sell_drop_sub_label.add_theme_color_override("font_color", Color(0.85, 0.85, 0.9, 0.9))
	sell_drop_sub_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	sell_drop_sub_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	vbox.add_child(sell_drop_sub_label)
	
	_update_sell_zone_style(false)
	add_child(sell_drop_zone)

func _on_unit_drag_started(unit: Unit, refund: int) -> void:
	if not is_instance_valid(unit):
		return
	is_drag_selling = true
	current_drag_refund = refund
	var data = PokemonDatabase.get_pokemon(unit.pokemon_id)
	var uname = data.get("name", unit.pokemon_id)
	current_drag_unit_name = "%s (★%d)" % [uname, unit.star_level]
	
	sell_drop_zone.visible = true
	sell_drop_zone.modulate.a = 0.0
	var tw = create_tween()
	tw.tween_property(sell_drop_zone, "modulate:a", 1.0, 0.1)
	
	_update_sell_zone_style(false)
	
	sell_btn.visible = true
	sell_btn.text = "松开出售 (+%dG)" % refund

func _on_unit_drag_hover_sell(is_hovering: bool) -> void:
	if not is_drag_selling or not sell_drop_zone.visible:
		return
	_update_sell_zone_style(is_hovering)

func _update_sell_zone_style(is_hovering: bool) -> void:
	if sell_drop_zone == null:
		return
	var style = StyleBoxFlat.new()
	style.set_corner_radius_all(10)
	if is_hovering:
		style.bg_color = Color(0.52, 0.10, 0.08, 0.96)
		style.border_color = Color(1.0, 0.88, 0.25, 1.0)
		style.set_border_width_all(3)
		sell_drop_label.text = "🔥 松开鼠标立即出售【%s】获得 +%d 金币! 🔥" % [current_drag_unit_name, current_drag_refund]
		sell_drop_label.add_theme_color_override("font_color", Color(1.0, 1.0, 0.6))
		sell_drop_icon.text = "🔥"
		sell_drop_sub_label.text = "松开即可卖出！全额返还金币"
		sell_drop_sub_label.add_theme_color_override("font_color", Color(1.0, 0.88, 0.75))
	else:
		style.bg_color = Color(0.14, 0.05, 0.05, 0.94)
		style.border_color = Color(0.95, 0.55, 0.2, 0.9)
		style.set_border_width_all(2)
		sell_drop_label.text = "拖动到此处出售【%s】获得 +%d 金币" % [current_drag_unit_name, current_drag_refund]
		sell_drop_label.add_theme_color_override("font_color", Color(1.0, 0.9, 0.35))
		sell_drop_icon.text = "🪙"
		sell_drop_sub_label.text = "松开鼠标即可完成出售并立即返还金币"
		sell_drop_sub_label.add_theme_color_override("font_color", Color(0.85, 0.85, 0.9, 0.85))
	sell_drop_zone.add_theme_stylebox_override("panel", style)

func _on_unit_drag_ended(sold: bool) -> void:
	is_drag_selling = false
	if sell_drop_zone and sell_drop_zone.visible:
		var tw = create_tween()
		tw.tween_property(sell_drop_zone, "modulate:a", 0.0, 0.12)
		tw.tween_callback(func():
			sell_drop_zone.visible = false
		)
	if not sold:
		if GameManager.board_ref and GameManager.board_ref.selected_unit != null:
			var u = GameManager.board_ref.selected_unit
			var can_sell = (GameManager.current_phase == GameManager.Phase.PREPARATION) or (GameManager.current_phase == GameManager.Phase.COMBAT and u.is_on_bench)
			if can_sell:
				var data = PokemonDatabase.get_pokemon(u.pokemon_id)
				var refund = data.get("cost", 1) * int(pow(3, u.star_level - 1))
				sell_btn.text = "出售 (%dG)" % refund
				sell_btn.visible = true
			else:
				sell_btn.visible = false
		else:
			sell_btn.visible = false
	else:
		sell_btn.visible = false

func open_trainer_augment_modal(augments: Array = []) -> void:
	if trainer_augment_modal:
		if augments.is_empty():
			trainer_augment_modal.open_random(3)
		else:
			trainer_augment_modal.open_with_choices(augments)

func show_boss_health_bar(boss_unit: Unit) -> void:
	if boss_health_bar:
		boss_health_bar.track_boss(boss_unit)

func hide_boss_health_bar() -> void:
	if boss_health_bar:
		boss_health_bar.hide_bar()
