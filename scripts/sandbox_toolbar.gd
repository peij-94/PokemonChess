extends PanelContainer

# SandboxToolbar: Floating control bar for Sandbox / Training Mode
# Allows spawning any of the 493 Pokemon, granting items, target dummies, clearing board, etc.

signal pokemon_spawn_requested(pokemon_id: String, star_level: int)
signal item_grant_requested(item_id: String)
signal dummy_spawn_requested()
signal clear_board_requested()

@onready var mode_badge: Label = $Margin/HBox/ModeBadge
@onready var spawn_pokemon_btn: Button = $Margin/HBox/SpawnPokemonBtn
@onready var grant_item_btn: Button = $Margin/HBox/GrantItemBtn
@onready var spawn_dummy_btn: Button = $Margin/HBox/SpawnDummyBtn
@onready var add_gold_btn: Button = $Margin/HBox/AddGoldBtn
@onready var clear_board_btn: Button = $Margin/HBox/ClearBoardBtn
@onready var start_combat_btn: Button = $Margin/HBox/StartCombatBtn
@onready var exit_sandbox_btn: Button = $Margin/HBox/ExitSandboxBtn

# Spawner sub-modals
var pokemon_spawner_panel: Panel = null
var item_spawner_panel: Panel = null
var search_line_edit: LineEdit = null
var star_select_option: OptionButton = null
var pokemon_scroll_container: VBoxContainer = null

var selected_spawn_star: int = 1

func _ready() -> void:
	if spawn_pokemon_btn:
		spawn_pokemon_btn.pressed.connect(_on_spawn_pokemon_pressed)
	if grant_item_btn:
		grant_item_btn.pressed.connect(_on_grant_item_pressed)
	if spawn_dummy_btn:
		spawn_dummy_btn.pressed.connect(_on_spawn_dummy_pressed)
	if add_gold_btn:
		add_gold_btn.pressed.connect(_on_add_gold_pressed)
	if clear_board_btn:
		clear_board_btn.pressed.connect(_on_clear_board_pressed)
	if start_combat_btn:
		start_combat_btn.pressed.connect(_on_start_combat_pressed)
	if exit_sandbox_btn:
		exit_sandbox_btn.pressed.connect(_on_exit_sandbox_pressed)
		
	var hbox = $Margin/HBox if has_node("Margin/HBox") else null
	if hbox and not hbox.has_node("TrainerBtn"):
		var trainer_btn = Button.new()
		trainer_btn.name = "TrainerBtn"
		trainer_btn.text = "👑 训练家"
		trainer_btn.add_theme_font_size_override("font_size", 12)
		trainer_btn.custom_minimum_size = Vector2(70, 28)
		var t_style = StyleBoxFlat.new()
		t_style.bg_color = Color(0.2, 0.3, 0.45, 1)
		t_style.border_color = Color(0.4, 0.7, 1.0, 0.8)
		t_style.set_border_width_all(1)
		t_style.set_corner_radius_all(4)
		trainer_btn.add_theme_stylebox_override("normal", t_style)
		trainer_btn.pressed.connect(func():
			if GameManager and GameManager.hud_ref and "trainer_widget" in GameManager.hud_ref and GameManager.hud_ref.trainer_widget:
				GameManager.hud_ref.trainer_widget.open_trainer_selection_modal()
		)
		hbox.add_child(trainer_btn)
		
	_create_spawner_panels()

func _create_spawner_panels() -> void:
	# 1. Pokemon Spawner Window
	pokemon_spawner_panel = Panel.new()
	pokemon_spawner_panel.name = "PokemonSpawnerPanel"
	pokemon_spawner_panel.custom_minimum_size = Vector2(480, 520)
	pokemon_spawner_panel.position = Vector2(300, 80)
	var p_style = StyleBoxFlat.new()
	p_style.bg_color = Color(0.08, 0.1, 0.15, 0.96)
	p_style.border_color = Color(0.4, 0.7, 1.0, 0.85)
	p_style.set_border_width_all(2)
	p_style.set_corner_radius_all(8)
	pokemon_spawner_panel.add_theme_stylebox_override("panel", p_style)
	pokemon_spawner_panel.visible = false
	add_child(pokemon_spawner_panel)
	
	var vbox = VBoxContainer.new()
	vbox.set_anchors_preset(Control.PRESET_FULL_RECT)
	vbox.offset_left = 16
	vbox.offset_top = 16
	vbox.offset_right = -16
	vbox.offset_bottom = -16
	vbox.add_theme_constant_override("separation", 10)
	pokemon_spawner_panel.add_child(vbox)
	
	# Header
	var header_hbox = HBoxContainer.new()
	vbox.add_child(header_hbox)
	
	var title = Label.new()
	title.text = "🧪 沙盒宝可梦召唤器 (全493只可选)"
	title.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	title.add_theme_font_size_override("font_size", 14)
	title.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2))
	header_hbox.add_child(title)
	
	var close_p_btn = Button.new()
	close_p_btn.text = "✕"
	close_p_btn.custom_minimum_size = Vector2(28, 24)
	close_p_btn.pressed.connect(func(): pokemon_spawner_panel.visible = false)
	header_hbox.add_child(close_p_btn)
	
	# Controls row (Search & Star level)
	var ctrl_row = HBoxContainer.new()
	ctrl_row.add_theme_constant_override("separation", 10)
	vbox.add_child(ctrl_row)
	
	search_line_edit = LineEdit.new()
	search_line_edit.placeholder_text = "搜索宝可梦名称或英文拼写..."
	search_line_edit.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	search_line_edit.text_changed.connect(_on_search_text_changed)
	ctrl_row.add_child(search_line_edit)
	
	star_select_option = OptionButton.new()
	star_select_option.add_item("★1 基础", 1)
	star_select_option.add_item("★2 进阶", 2)
	star_select_option.add_item("★3 终极", 3)
	star_select_option.select(0)
	star_select_option.item_selected.connect(func(idx): selected_spawn_star = idx + 1)
	ctrl_row.add_child(star_select_option)
	
	# Scroll area with Grid of Pokemon
	var scroll = ScrollContainer.new()
	scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	vbox.add_child(scroll)
	
	pokemon_scroll_container = VBoxContainer.new()
	pokemon_scroll_container.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	scroll.add_child(pokemon_scroll_container)
	
	# 2. Item Spawner Window
	item_spawner_panel = Panel.new()
	item_spawner_panel.name = "ItemSpawnerPanel"
	item_spawner_panel.custom_minimum_size = Vector2(400, 360)
	item_spawner_panel.position = Vector2(340, 120)
	var i_style = StyleBoxFlat.new()
	i_style.bg_color = Color(0.08, 0.1, 0.15, 0.96)
	i_style.border_color = Color(0.9, 0.7, 0.2, 0.85)
	i_style.set_border_width_all(2)
	i_style.set_corner_radius_all(8)
	item_spawner_panel.add_theme_stylebox_override("panel", i_style)
	item_spawner_panel.visible = false
	add_child(item_spawner_panel)
	
	var i_vbox = VBoxContainer.new()
	i_vbox.set_anchors_preset(Control.PRESET_FULL_RECT)
	i_vbox.offset_left = 16
	i_vbox.offset_top = 16
	i_vbox.offset_right = -16
	i_vbox.offset_bottom = -16
	i_vbox.add_theme_constant_override("separation", 10)
	item_spawner_panel.add_child(i_vbox)
	
	var i_header = HBoxContainer.new()
	i_vbox.add_child(i_header)
	
	var i_title = Label.new()
	i_title.text = "🎁 沙盒自选装备发放"
	i_title.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	i_title.add_theme_font_size_override("font_size", 14)
	i_title.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2))
	i_header.add_child(i_title)
	
	var close_i_btn = Button.new()
	close_i_btn.text = "✕"
	close_i_btn.custom_minimum_size = Vector2(28, 24)
	close_i_btn.pressed.connect(func(): item_spawner_panel.visible = false)
	i_header.add_child(close_i_btn)
	
	var i_scroll = ScrollContainer.new()
	i_scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	i_vbox.add_child(i_scroll)
	
	var i_grid = GridContainer.new()
	i_grid.columns = 2
	i_grid.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	i_grid.add_theme_constant_override("h_separation", 8)
	i_grid.add_theme_constant_override("v_separation", 6)
	i_scroll.add_child(i_grid)
	
	_populate_item_grid(i_grid)

func _populate_item_grid(grid: GridContainer) -> void:
	if not ItemDatabase:
		return
	var all_items = ItemDatabase.get_all_base_item_ids() + ItemDatabase.get_all_advanced_item_ids()
	for it_id in all_items:
		var it_data = ItemDatabase.get_item(it_id)
		var btn = Button.new()
		btn.text = "%s %s" % [it_data.get("icon", "⚔️"), it_data.get("name", it_id)]
		btn.custom_minimum_size = Vector2(170, 32)
		btn.add_theme_font_size_override("font_size", 11)
		btn.pressed.connect(func():
			if GameManager.item_bench and GameManager.item_bench.has_method("add_item"):
				GameManager.add_item_to_bench(it_id)
				AudioManager.play_sfx("buy")
				if GameManager.hud_ref and GameManager.hud_ref.has_method("show_toast"):
					GameManager.hud_ref.show_toast("已获得装备: %s" % it_data.get("name", it_id), Color(0.4, 0.9, 1.0))
		)
		grid.add_child(btn)

func _on_spawn_pokemon_pressed() -> void:
	pokemon_spawner_panel.visible = !pokemon_spawner_panel.visible
	if pokemon_spawner_panel.visible:
		_populate_pokemon_list("")

func _on_grant_item_pressed() -> void:
	item_spawner_panel.visible = !item_spawner_panel.visible

func _on_search_text_changed(new_text: String) -> void:
	_populate_pokemon_list(new_text)

func _populate_pokemon_list(filter_str: String) -> void:
	for c in pokemon_scroll_container.get_children():
		c.queue_free()
		
	var grid = GridContainer.new()
	grid.columns = 3
	grid.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	grid.add_theme_constant_override("h_separation", 6)
	grid.add_theme_constant_override("v_separation", 6)
	pokemon_scroll_container.add_child(grid)
	
	var query = filter_str.strip_edges().to_lower()
	var count = 0
	
	for pid in PokemonDatabase.pokemons.keys():
		var p_data = PokemonDatabase.get_pokemon(pid)
		var p_name = p_data.get("name", pid)
		if query != "" and not (pid.contains(query) or p_name.contains(query)):
			continue
			
		var card_btn = Button.new()
		card_btn.text = "%s (★%d)" % [p_name, selected_spawn_star]
		card_btn.custom_minimum_size = Vector2(140, 32)
		card_btn.add_theme_font_size_override("font_size", 11)
		
		# Set type-themed border color
		var types_arr = p_data.get("types", [])
		var prim_type = types_arr[0] if not types_arr.is_empty() else "Normal"
		var t_color = TypeSystem.get_type_color(prim_type) if TypeSystem else Color(0.6, 0.7, 0.8)
		card_btn.modulate = Color.WHITE
		card_btn.pressed.connect(func():
			_spawn_selected_pokemon(pid, selected_spawn_star)
		)
		grid.add_child(card_btn)
		count += 1
		if count >= 90:
			break # Paginate to prevent massive layout overhead

func _spawn_selected_pokemon(pid: String, star: int) -> void:
	if GameManager.board_ref:
		var u = GameManager.board_ref.add_pokemon_to_bench(pid, star)
		if u == null:
			# Bench full, try placing on battlefield
			for c in range(GameManager.board_ref.COLS):
				for r in range(3, GameManager.board_ref.ROWS):
					if GameManager.board_ref.board_grid[c][r] == null:
						u = GameManager.board_ref.spawn_unit_at_coord(pid, Vector2i(c, r), star, false)
						break
				if u != null:
					break
		if u:
			var p_name = PokemonDatabase.get_pokemon(pid).get("name", pid)
			AudioManager.play_sfx("buy")
			if GameManager.hud_ref and GameManager.hud_ref.has_method("show_toast"):
				GameManager.hud_ref.show_toast("已召唤【%s】(★%d)" % [p_name, star], Color(0.4, 0.9, 1.0))
		else:
			if GameManager.hud_ref and GameManager.hud_ref.has_method("show_toast"):
				GameManager.hud_ref.show_toast("⚠️ 备战席和战场已满，无法放置！", Color(1.0, 0.5, 0.4))

func _on_spawn_dummy_pressed() -> void:
	if GameManager.board_ref and GameManager.board_ref.has_method("spawn_training_dummy"):
		GameManager.board_ref.spawn_training_dummy(30000.0)
		AudioManager.play_sfx("upgrade")
		if GameManager.hud_ref and GameManager.hud_ref.has_method("show_toast"):
			GameManager.hud_ref.show_toast("🎯 训练木桩 (30,000 HP) 已生成至前排！", Color(0.4, 1.0, 0.6))

func _on_add_gold_pressed() -> void:
	GameManager.add_gold(100)
	AudioManager.play_sfx("coin")
	if GameManager.hud_ref and GameManager.hud_ref.has_method("show_toast"):
		GameManager.hud_ref.show_toast("💰 沙盒注资: +100 金币", Color(1.0, 0.85, 0.2))

func _on_clear_board_pressed() -> void:
	if GameManager.board_ref and GameManager.board_ref.has_method("clear_all_units"):
		GameManager.board_ref.clear_all_units()
		AudioManager.play_sfx("click")
		if GameManager.hud_ref and GameManager.hud_ref.has_method("show_toast"):
			GameManager.hud_ref.show_toast("🧹 战场与备战席已清空", Color(0.8, 0.8, 0.8))

func _on_start_combat_pressed() -> void:
	if GameManager.current_phase == GameManager.Phase.PREPARATION:
		GameManager.start_combat_phase()
	elif GameManager.current_phase == GameManager.Phase.COMBAT:
		GameManager.resolve_combat(true, 0)

func _on_exit_sandbox_pressed() -> void:
	GameManager.is_sandbox_mode = false
	GameManager.reset_game()
	visible = false
