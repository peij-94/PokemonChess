extends Panel

# DamageRecapModal: Detailed post-round / end-game battle statistical analysis modal
# Displays MVP podium (1st, 2nd, 3rd), comparative graphical bars, and tabbed metrics (Damage / Taken / Healing).

@onready var close_btn: Button = $Dialog/VBox/Header/CloseBtn
@onready var title_label: Label = $Dialog/VBox/Header/TitleLabel
@onready var round_info_label: Label = $Dialog/VBox/Header/RoundInfoLabel

# MVP Podium nodes
@onready var mvp_container: HBoxContainer = $Dialog/VBox/PodiumContainer

# Tab buttons
@onready var damage_tab: Button = $Dialog/VBox/TabBar/DamageTab
@onready var taken_tab: Button = $Dialog/VBox/TabBar/TakenTab
@onready var healing_tab: Button = $Dialog/VBox/TabBar/HealingTab

# Metrics list & summary
@onready var rows_container: VBoxContainer = $Dialog/VBox/Scroll/RowsContainer
@onready var summary_label: Label = $Dialog/VBox/SummaryLabel

var current_mode: String = "damage" # "damage", "taken", "healing"
var stored_metrics: Array = []

func _ready() -> void:
	visible = false
	if close_btn:
		close_btn.pressed.connect(close_modal)
	if damage_tab:
		damage_tab.pressed.connect(func(): _switch_mode("damage"))
	if taken_tab:
		taken_tab.pressed.connect(func(): _switch_mode("taken"))
	if healing_tab:
		healing_tab.pressed.connect(func(): _switch_mode("healing"))
	_apply_tab_styles()

func open_recap(metrics_list: Array, round_num: int = 1) -> void:
	stored_metrics = metrics_list.duplicate(true)
	visible = true
	title_label.text = "📊 战斗结算详细战报"
	round_info_label.text = "第 %d 回合战况分析" % round_num
	_refresh_display()

func close_modal() -> void:
	visible = false

func _switch_mode(mode: String) -> void:
	current_mode = mode
	_apply_tab_styles()
	_refresh_display()

func _apply_tab_styles() -> void:
	if not damage_tab or not taken_tab or not healing_tab:
		return
	damage_tab.modulate = Color(1.2, 0.8, 0.8) if current_mode == "damage" else Color(0.7, 0.7, 0.7)
	taken_tab.modulate = Color(0.8, 1.0, 1.2) if current_mode == "taken" else Color(0.7, 0.7, 0.7)
	healing_tab.modulate = Color(0.8, 1.2, 0.9) if current_mode == "healing" else Color(0.7, 0.7, 0.7)

func _refresh_display() -> void:
	# Filter only player units for player recap
	var player_units: Array = []
	for m in stored_metrics:
		if not m.get("is_enemy", false):
			player_units.append(m)
			
	# If no player units recorded, use all
	var target_list = player_units if not player_units.is_empty() else stored_metrics
	
	# Sort according to current mode
	target_list.sort_custom(func(a, b):
		var val_a = a.get(current_mode, 0.0)
		var val_b = b.get(current_mode, 0.0)
		return val_a > val_b
	)
	
	# Calculate total and maximum
	var total_val = 0.0
	var max_val = 1.0
	for m in target_list:
		var v = m.get(current_mode, 0.0)
		total_val += v
		if v > max_val:
			max_val = v
			
	var mode_name = "输出伤害" if current_mode == "damage" else ("承受伤害" if current_mode == "taken" else "治疗护盾")
	summary_label.text = "全队总%s: %d" % [mode_name, int(total_val)]
	
	_render_podium(target_list)
	_render_rows(target_list, total_val, max_val)

func _render_podium(sorted_list: Array) -> void:
	for c in mvp_container.get_children():
		c.queue_free()
		
	var medals = ["🥇 MVP 状元", "🥈 榜眼", "🥉 探花"]
	var colors = [Color(1.0, 0.85, 0.25), Color(0.85, 0.9, 0.95), Color(0.85, 0.6, 0.35)]
	
	for i in range(min(3, sorted_list.size())):
		var entry = sorted_list[i]
		var val = entry.get(current_mode, 0.0)
		if val <= 0.0 and i > 0:
			continue
			
		var card = PanelContainer.new()
		card.custom_minimum_size = Vector2(170, 75)
		var style = StyleBoxFlat.new()
		style.bg_color = Color(0.12, 0.15, 0.22, 0.9)
		style.border_color = colors[i]
		style.set_border_width_all(1)
		style.set_corner_radius_all(6)
		card.add_theme_stylebox_override("panel", style)
		
		var vbox = VBoxContainer.new()
		vbox.alignment = BoxContainer.ALIGNMENT_CENTER
		vbox.add_theme_constant_override("separation", 3)
		card.add_child(vbox)
		
		var medal_lbl = Label.new()
		medal_lbl.text = medals[i]
		medal_lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		medal_lbl.add_theme_font_size_override("font_size", 11)
		medal_lbl.add_theme_color_override("font_color", colors[i])
		vbox.add_child(medal_lbl)
		
		var name_lbl = Label.new()
		name_lbl.text = "%s (★%d)" % [entry.get("name", "宝可梦"), entry.get("star", 1)]
		name_lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		name_lbl.add_theme_font_size_override("font_size", 13)
		name_lbl.add_theme_color_override("font_color", Color.WHITE)
		vbox.add_child(name_lbl)
		
		var val_lbl = Label.new()
		val_lbl.text = "%d" % int(val)
		val_lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		val_lbl.add_theme_font_size_override("font_size", 12)
		val_lbl.add_theme_color_override("font_color", colors[i])
		vbox.add_child(val_lbl)
		
		mvp_container.add_child(card)

func _render_rows(sorted_list: Array, total_val: float, max_val: float) -> void:
	for c in rows_container.get_children():
		c.queue_free()
		
	var bar_color = Color(0.92, 0.28, 0.28) if current_mode == "damage" else (Color(0.28, 0.58, 0.96) if current_mode == "taken" else Color(0.28, 0.88, 0.45))
	
	for entry in sorted_list:
		var val = entry.get(current_mode, 0.0)
		var pct = (val / total_val * 100.0) if total_val > 0.0 else 0.0
		var bar_pct = (val / max_val * 100.0) if max_val > 0.0 else 0.0
		
		var row = PanelContainer.new()
		row.custom_minimum_size = Vector2(0, 36)
		var r_style = StyleBoxFlat.new()
		r_style.bg_color = Color(0.10, 0.13, 0.18, 0.8)
		r_style.set_corner_radius_all(4)
		row.add_theme_stylebox_override("panel", r_style)
		
		var hbox = HBoxContainer.new()
		hbox.add_theme_constant_override("separation", 12)
		row.add_child(hbox)
		
		# Name & Star
		var name_lbl = Label.new()
		name_lbl.text = " %s (★%d)" % [entry.get("name", "宝可梦"), entry.get("star", 1)]
		name_lbl.custom_minimum_size = Vector2(140, 0)
		name_lbl.add_theme_font_size_override("font_size", 12)
		hbox.add_child(name_lbl)
		
		# Progress Gauge Bar
		var bar = ProgressBar.new()
		bar.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		bar.size_flags_vertical = Control.SIZE_SHRINK_CENTER
		bar.custom_minimum_size = Vector2(0, 14)
		bar.show_percentage = false
		bar.max_value = 100.0
		bar.value = bar_pct
		
		var bg_sb = StyleBoxFlat.new()
		bg_sb.bg_color = Color(0.06, 0.08, 0.12, 0.8)
		bg_sb.set_corner_radius_all(3)
		bar.add_theme_stylebox_override("background", bg_sb)
		
		var fill_sb = StyleBoxFlat.new()
		fill_sb.bg_color = bar_color
		fill_sb.set_corner_radius_all(3)
		bar.add_theme_stylebox_override("fill", fill_sb)
		hbox.add_child(bar)
		
		# Percentage & Value
		var val_lbl = Label.new()
		val_lbl.text = "%d (%.1f%%) " % [int(val), pct]
		val_lbl.custom_minimum_size = Vector2(110, 0)
		val_lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
		val_lbl.add_theme_font_size_override("font_size", 12)
		val_lbl.add_theme_color_override("font_color", bar_color)
		hbox.add_child(val_lbl)
		
		rows_container.add_child(row)
