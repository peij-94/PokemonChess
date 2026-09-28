extends Control
class_name DPSMeter

# ==============================================================================
# Direction 2: The Real-time Battle Data Statistics Meter
# (DPS / Damage Dealt / Damage Taken / Healing & Shielding Meter)
# ==============================================================================

signal view_mode_changed(new_mode: String)
signal visibility_toggled(is_expanded: bool)

# Visual colors for each metric view mode
const COLOR_DAMAGE = Color(0.92, 0.28, 0.28, 1.0)
const COLOR_TAKEN = Color(0.28, 0.58, 0.96, 1.0)
const COLOR_HEALING = Color(0.28, 0.88, 0.45, 1.0)

const COLOR_DAMAGE_TAB_BG = Color(0.55, 0.18, 0.18, 0.95)
const COLOR_TAKEN_TAB_BG = Color(0.18, 0.35, 0.65, 0.95)
const COLOR_HEALING_TAB_BG = Color(0.18, 0.50, 0.28, 0.95)

const COLOR_INACTIVE_TAB_BG = Color(0.12, 0.15, 0.22, 0.75)
const COLOR_INACTIVE_BORDER = Color(0.22, 0.28, 0.38, 0.6)

@onready var toggle_btn: Button = $ToggleBtn
@onready var main_panel: Panel = $MainPanel
@onready var header_title: Label = $MainPanel/ContentVBox/Header/TitleLabel
@onready var team_toggle_btn: Button = $MainPanel/ContentVBox/Header/TeamToggleBtn
@onready var close_btn: Button = $MainPanel/ContentVBox/Header/CloseBtn

@onready var damage_tab: Button = $MainPanel/ContentVBox/TabBar/DamageTab
@onready var taken_tab: Button = $MainPanel/ContentVBox/TabBar/TakenTab
@onready var healing_tab: Button = $MainPanel/ContentVBox/TabBar/HealingTab

@onready var summary_label: Label = $MainPanel/ContentVBox/SummaryBar/HBox/SummaryLabel
@onready var mode_label: Label = $MainPanel/ContentVBox/SummaryBar/HBox/ModeLabel
@onready var rows_container: VBoxContainer = $MainPanel/ContentVBox/Scroll/RowsContainer

# State variables
var current_mode: String = "damage" # "damage", "taken", "healing"
var is_expanded: bool = false
var show_enemies: bool = false
var animate_bars: bool = true

var raw_unit_data: Array = []
var active_rows_data: Array = []
var row_nodes: Array[PanelContainer] = []
var mvp_unit_id: String = ""
var team_total: float = 0.0

func _ready() -> void:
	if DisplayServer.get_name() == "headless":
		animate_bars = false
		
	if toggle_btn and not toggle_btn.pressed.is_connected(toggle_visibility):
		toggle_btn.pressed.connect(toggle_visibility)
	if close_btn and not close_btn.pressed.is_connected(collapse):
		close_btn.pressed.connect(collapse)
	if team_toggle_btn and not team_toggle_btn.pressed.is_connected(_on_team_toggle_pressed):
		team_toggle_btn.pressed.connect(_on_team_toggle_pressed)
		
	if damage_tab and not damage_tab.pressed.is_connected(_on_damage_tab_pressed):
		damage_tab.pressed.connect(_on_damage_tab_pressed)
	if taken_tab and not taken_tab.pressed.is_connected(_on_taken_tab_pressed):
		taken_tab.pressed.connect(_on_taken_tab_pressed)
	if healing_tab and not healing_tab.pressed.is_connected(_on_healing_tab_pressed):
		healing_tab.pressed.connect(_on_healing_tab_pressed)
		
	_apply_tab_styles()
	collapse()

# ==============================================================================
# Public API
# ==============================================================================

## Updates the metrics with a list of unit dictionaries:
## Each entry has: { "unit": Unit, "id": String, "name": String, "star": int, "damage": float, "taken": float, "healing": float, "dps": float }
func update_metrics(unit_data_list: Array) -> void:
	raw_unit_data = unit_data_list.duplicate(true)
	_refresh_display()

## Resets all metrics and clears or resets UI rows
func reset_metrics() -> void:
	raw_unit_data.clear()
	active_rows_data.clear()
	mvp_unit_id = ""
	team_total = 0.0
	for row in row_nodes:
		row.visible = false
		var bar: ProgressBar = row.find_child("GaugeBar", true, false)
		if bar:
			bar.value = 0.0
		var pct_label: Label = row.find_child("PercentLabel", true, false)
		if pct_label:
			pct_label.text = "0.0%"
		var val_label: Label = row.find_child("ValueLabel", true, false)
		if val_label:
			val_label.text = "0"
		row.set_meta("bar_value", 0.0)
		row.set_meta("percent_of_total", 0.0)
		row.set_meta("is_mvp", false)
	if summary_label:
		summary_label.text = "全队输出: 0"
	if mode_label:
		mode_label.text = "【输出】"

## Toggles between folded (collapsed) and expanded view
func toggle_visibility() -> void:
	if is_expanded:
		collapse()
	else:
		expand()

## Sets the view mode: "damage", "taken", or "healing"
func set_view_mode(mode: String) -> void:
	var m = mode.to_lower()
	match m:
		"damage", "dps", "damage_dealt", "attack", "输出":
			current_mode = "damage"
		"taken", "damage_taken", "defend", "承伤":
			current_mode = "taken"
		"healing", "heal", "shield", "healing_shielding", "治疗", "治疗/护盾":
			current_mode = "healing"
		_:
			current_mode = "damage"
			
	_apply_tab_styles()
	_refresh_display()
	view_mode_changed.emit(current_mode)

func get_view_mode() -> String:
	return current_mode

func expand() -> void:
	is_expanded = true
	if main_panel:
		main_panel.visible = true
	if toggle_btn:
		toggle_btn.text = "收起 ▶"
	visibility_toggled.emit(true)

func collapse() -> void:
	is_expanded = false
	if main_panel:
		main_panel.visible = false
	if toggle_btn:
		toggle_btn.visible = true
		toggle_btn.text = "📊 统计"
	visibility_toggled.emit(false)

func is_meter_expanded() -> bool:
	return is_expanded

func set_filter_enemies(show: bool) -> void:
	show_enemies = show
	if team_toggle_btn:
		team_toggle_btn.text = "全员" if show_enemies else "我方"
	_refresh_display()

func get_row_count() -> int:
	return active_rows_data.size()

func get_row_data(idx: int) -> Dictionary:
	if idx >= 0 and idx < active_rows_data.size():
		return active_rows_data[idx]
	return {}

func get_row_node(idx: int) -> PanelContainer:
	if idx >= 0 and idx < row_nodes.size():
		return row_nodes[idx]
	return null

func get_mvp_id() -> String:
	return mvp_unit_id

func get_mvp_data() -> Dictionary:
	if active_rows_data.size() > 0 and active_rows_data[0].get("_is_mvp", false):
		return active_rows_data[0]
	return {}

func get_team_total() -> float:
	return team_total

func get_bar_percentage(idx: int) -> float:
	if idx >= 0 and idx < active_rows_data.size():
		return float(active_rows_data[idx].get("_percent_of_total", 0.0))
	return 0.0

# ==============================================================================
# Internal Logic & Layout
# ==============================================================================

func _on_damage_tab_pressed() -> void:
	set_view_mode("damage")

func _on_taken_tab_pressed() -> void:
	set_view_mode("taken")

func _on_healing_tab_pressed() -> void:
	set_view_mode("healing")

func _on_team_toggle_pressed() -> void:
	set_filter_enemies(not show_enemies)

func _apply_tab_styles() -> void:
	if damage_tab == null or taken_tab == null or healing_tab == null:
		return
		
	_style_tab(damage_tab, current_mode == "damage", COLOR_DAMAGE_TAB_BG, COLOR_DAMAGE)
	_style_tab(taken_tab, current_mode == "taken", COLOR_TAKEN_TAB_BG, COLOR_TAKEN)
	_style_tab(healing_tab, current_mode == "healing", COLOR_HEALING_TAB_BG, COLOR_HEALING)

func _style_tab(btn: Button, is_active: bool, active_bg: Color, active_color: Color) -> void:
	var sb = StyleBoxFlat.new()
	sb.corner_radius_top_left = 4
	sb.corner_radius_top_right = 4
	sb.corner_radius_bottom_right = 4
	sb.corner_radius_bottom_left = 4
	
	if is_active:
		sb.bg_color = active_bg
		sb.border_width_left = 1
		sb.border_width_top = 1
		sb.border_width_right = 1
		sb.border_width_bottom = 2
		sb.border_color = active_color
		btn.add_theme_color_override("font_color", Color(1.0, 1.0, 1.0))
	else:
		sb.bg_color = COLOR_INACTIVE_TAB_BG
		sb.border_width_left = 1
		sb.border_width_top = 1
		sb.border_width_right = 1
		sb.border_width_bottom = 1
		sb.border_color = COLOR_INACTIVE_BORDER
		btn.add_theme_color_override("font_color", Color(0.7, 0.76, 0.85))
		
	btn.add_theme_stylebox_override("normal", sb)
	btn.add_theme_stylebox_override("hover", sb)
	btn.add_theme_stylebox_override("pressed", sb)

func _refresh_display() -> void:
	# Filter units by player/enemy setting
	var filtered: Array = []
	for item in raw_unit_data:
		var u = item.get("unit", null)
		var is_enemy = item.get("is_enemy", u.is_enemy if u else false)
		if not show_enemies and is_enemy:
			continue
		var clone = item.duplicate(true)
		var val: float = 0.0
		match current_mode:
			"damage":
				val = float(clone.get("damage", 0.0))
			"taken":
				val = float(clone.get("taken", 0.0))
			"healing":
				val = float(clone.get("healing", 0.0))
		clone["_current_val"] = val
		filtered.append(clone)
		
	# Compute total
	team_total = 0.0
	for item in filtered:
		team_total += item["_current_val"]
		
	# Sort descending by metric value; secondary sort by ID
	filtered.sort_custom(func(a, b):
		if not is_equal_approx(a["_current_val"], b["_current_val"]):
			return a["_current_val"] > b["_current_val"]
		return str(a.get("id", "")) < str(b.get("id", ""))
	)
	
	# Determine MVP (top contributor with > 0 value)
	if filtered.size() > 0 and filtered[0]["_current_val"] > 0.0:
		mvp_unit_id = str(filtered[0].get("id", ""))
	else:
		mvp_unit_id = ""
		
	# Calculate percentages
	var max_val = filtered[0]["_current_val"] if filtered.size() > 0 else 0.0
	for item in filtered:
		var val = item["_current_val"]
		var pct_total = (val / team_total * 100.0) if team_total > 0.0 else 0.0
		var pct_max = (val / max_val * 100.0) if max_val > 0.0 else 0.0
		item["_percent_of_total"] = pct_total
		item["_percent_of_max"] = pct_max
		var uid = str(item.get("id", ""))
		item["_is_mvp"] = (uid == mvp_unit_id and mvp_unit_id != "")
		
	# Update summary labels
	var mode_name = "输出"
	var mode_col = COLOR_DAMAGE
	match current_mode:
		"taken":
			mode_name = "承伤"
			mode_col = COLOR_TAKEN
		"healing":
			mode_name = "治疗"
			mode_col = COLOR_HEALING
			
	if summary_label:
		summary_label.text = "全队%s: %s" % [mode_name, format_number(team_total)]
	if mode_label:
		mode_label.text = "【%s】" % mode_name
		mode_label.add_theme_color_override("font_color", mode_col)
		
	active_rows_data = filtered
	
	# Ensure enough row nodes exist
	if rows_container != null:
		while row_nodes.size() < filtered.size():
			var new_row = _create_row_node()
			rows_container.add_child(new_row)
			row_nodes.append(new_row)
			
		for i in range(row_nodes.size()):
			if i < filtered.size():
				row_nodes[i].visible = true
				_update_row_ui(row_nodes[i], filtered[i], i + 1)
			else:
				row_nodes[i].visible = false

func _create_row_node() -> PanelContainer:
	var row = PanelContainer.new()
	var row_style = StyleBoxFlat.new()
	row_style.bg_color = Color(0.10, 0.13, 0.19, 0.85)
	row_style.corner_radius_top_left = 4
	row_style.corner_radius_top_right = 4
	row_style.corner_radius_bottom_right = 4
	row_style.corner_radius_bottom_left = 4
	row_style.border_width_left = 2
	row_style.border_color = Color(0.25, 0.35, 0.5, 0.5)
	row_style.content_margin_left = 5
	row_style.content_margin_right = 5
	row_style.content_margin_top = 4
	row_style.content_margin_bottom = 4
	row.add_theme_stylebox_override("panel", row_style)
	
	var vbox = VBoxContainer.new()
	vbox.add_theme_constant_override("separation", 2)
	row.add_child(vbox)
	
	# Top line: [MVP/Rank] [Icon] [Name ★Star] [Spacer] [Value (DPS)]
	var top_line = HBoxContainer.new()
	top_line.name = "TopLine"
	top_line.add_theme_constant_override("separation", 4)
	vbox.add_child(top_line)
	
	var rank_label = Label.new()
	rank_label.name = "RankLabel"
	rank_label.custom_minimum_size = Vector2(18, 0)
	rank_label.add_theme_font_size_override("font_size", 11)
	top_line.add_child(rank_label)
	
	var icon_rect = TextureRect.new()
	icon_rect.name = "IconRect"
	icon_rect.custom_minimum_size = Vector2(20, 20)
	icon_rect.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	icon_rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	icon_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	top_line.add_child(icon_rect)
	
	var name_label = Label.new()
	name_label.name = "NameLabel"
	name_label.add_theme_font_size_override("font_size", 11)
	name_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	name_label.clip_text = true
	top_line.add_child(name_label)
	
	var val_label = Label.new()
	val_label.name = "ValueLabel"
	val_label.add_theme_font_size_override("font_size", 10)
	val_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	top_line.add_child(val_label)
	
	# Bottom line: [ProgressBar] [PercentLabel]
	var bottom_line = HBoxContainer.new()
	bottom_line.name = "BottomLine"
	bottom_line.add_theme_constant_override("separation", 6)
	vbox.add_child(bottom_line)
	
	var bar = ProgressBar.new()
	bar.name = "GaugeBar"
	bar.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	bar.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	bar.custom_minimum_size = Vector2(0, 10)
	bar.show_percentage = false
	bar.max_value = 100.0
	bar.value = 0.0
	
	var bg_sb = StyleBoxFlat.new()
	bg_sb.bg_color = Color(0.08, 0.10, 0.14, 0.9)
	bg_sb.corner_radius_top_left = 3
	bg_sb.corner_radius_top_right = 3
	bg_sb.corner_radius_bottom_right = 3
	bg_sb.corner_radius_bottom_left = 3
	bar.add_theme_stylebox_override("background", bg_sb)
	
	var fill_sb = StyleBoxFlat.new()
	fill_sb.bg_color = COLOR_DAMAGE
	fill_sb.corner_radius_top_left = 3
	fill_sb.corner_radius_top_right = 3
	fill_sb.corner_radius_bottom_right = 3
	fill_sb.corner_radius_bottom_left = 3
	bar.add_theme_stylebox_override("fill", fill_sb)
	
	bottom_line.add_child(bar)
	
	var pct_label = Label.new()
	pct_label.name = "PercentLabel"
	pct_label.custom_minimum_size = Vector2(38, 0)
	pct_label.add_theme_font_size_override("font_size", 10)
	pct_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	pct_label.text = "0.0%"
	bottom_line.add_child(pct_label)
	
	return row

func _update_row_ui(row: PanelContainer, data: Dictionary, rank: int) -> void:
	var rank_label: Label = row.find_child("RankLabel", true, false)
	var icon_rect: TextureRect = row.find_child("IconRect", true, false)
	var name_label: Label = row.find_child("NameLabel", true, false)
	var val_label: Label = row.find_child("ValueLabel", true, false)
	var bar: ProgressBar = row.find_child("GaugeBar", true, false)
	var pct_label: Label = row.find_child("PercentLabel", true, false)
	
	var uid = str(data.get("id", ""))
	var star = int(data.get("star", 1))
	var is_mvp = bool(data.get("_is_mvp", false))
	var val = float(data.get("_current_val", 0.0))
	var dps = float(data.get("dps", 0.0))
	var pct = float(data.get("_percent_of_total", 0.0))
	
	# Rank / MVP Crown
	if rank_label:
		if is_mvp:
			rank_label.text = "👑"
			rank_label.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2))
		else:
			rank_label.text = "#%d" % rank
			rank_label.add_theme_color_override("font_color", Color(0.65, 0.72, 0.82))
			
	# Row border styling
	var r_style: StyleBoxFlat = row.get_theme_stylebox("panel").duplicate()
	if is_mvp:
		r_style.border_color = Color(1.0, 0.85, 0.2, 0.85)
		r_style.border_width_left = 3
	else:
		r_style.border_color = Color(0.25, 0.35, 0.5, 0.5)
		r_style.border_width_left = 2
	row.add_theme_stylebox_override("panel", r_style)
	
	# Icon
	if icon_rect:
		var tex = _get_unit_icon_texture(uid, data.get("unit", null))
		icon_rect.texture = tex
		icon_rect.visible = (tex != null)
		
	# Name & Star badge
	if name_label:
		var dname = str(data.get("name", ""))
		if dname == "" or dname == uid:
			dname = _get_unit_display_name(uid)
		var star_str = "★%d" % star
		name_label.text = "%s %s" % [dname, star_str]
		if data.get("is_enemy", false):
			name_label.text = "[敌] " + name_label.text
			name_label.add_theme_color_override("font_color", Color(1.0, 0.6, 0.6))
		else:
			name_label.add_theme_color_override("font_color", Color(0.95, 0.95, 1.0))
			
	# Value & DPS text
	if val_label:
		val_label.text = format_metric_display(val, dps)
		
	# Gauge progress bar fill and smooth animation
	if bar:
		var fill_sb: StyleBoxFlat = bar.get_theme_stylebox("fill").duplicate()
		match current_mode:
			"damage":
				fill_sb.bg_color = COLOR_DAMAGE
			"taken":
				fill_sb.bg_color = COLOR_TAKEN
			"healing":
				fill_sb.bg_color = COLOR_HEALING
		bar.add_theme_stylebox_override("fill", fill_sb)
		
		if animate_bars and is_inside_tree() and get_tree() != null:
			var tw = create_tween()
			tw.tween_property(bar, "value", pct, 0.25).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		else:
			bar.value = pct
			
	# Percentage text
	if pct_label:
		pct_label.text = "%.1f%%" % pct
		
	# Store metadata for direct inspection
	row.set_meta("data", data)
	row.set_meta("rank", rank)
	row.set_meta("is_mvp", is_mvp)
	row.set_meta("percent_of_total", pct)
	row.set_meta("percent_of_max", data.get("_percent_of_max", 0.0))
	row.set_meta("bar_value", pct)

func _get_unit_icon_texture(uid: String, unit: Unit) -> Texture2D:
	if PokemonDatabase:
		var pdata = PokemonDatabase.get_pokemon(uid)
		var icon_path = pdata.get("icon", "")
		if icon_path != "" and ResourceLoader.exists(icon_path):
			return load(icon_path)
	if ResourceLoader.exists("res://assets/units/%s.png" % uid):
		return load("res://assets/units/%s.png" % uid)
	if ResourceLoader.exists("res://assets/units/%s.jpg" % uid):
		return load("res://assets/units/%s.jpg" % uid)
	return null

func _get_unit_display_name(uid: String) -> String:
	if PokemonDatabase:
		var pdata = PokemonDatabase.get_pokemon(uid)
		if not pdata.is_empty():
			return pdata.get("name", uid)
	return uid.capitalize()

# ==============================================================================
# Number Formatting Utilities
# ==============================================================================

func format_number(val: float) -> String:
	var iv = int(round(val))
	if iv < 1000:
		return str(iv)
	var s = str(iv)
	var res = ""
	var count = 0
	for i in range(s.length() - 1, -1, -1):
		res = s[i] + res
		count += 1
		if count % 3 == 0 and i > 0:
			res = "," + res
	return res

func format_metric_display(val: float, dps: float) -> String:
	var v_str = format_number(val)
	if dps > 0.0:
		return "%s (%s/s)" % [v_str, format_number(dps)]
	return v_str
