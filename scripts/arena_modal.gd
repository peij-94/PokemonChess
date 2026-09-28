extends Panel

# ArenaModal: Displays the current battle arena environmental buffs and debuffs

@onready var title_label: Label = $Dialog/VBox/Header/Title
@onready var desc_label: Label = $Dialog/VBox/Desc
@onready var cards_container: VBoxContainer = $Dialog/VBox/Scroll/Cards
@onready var awaken_label: Label = $Dialog/VBox/AwakenLabel
@onready var cycle_btn: Button = $Dialog/VBox/Footer/CycleBtn
@onready var close_btn: Button = $Dialog/VBox/Footer/CloseBtn

func _ready() -> void:
	visible = false
	if close_btn:
		close_btn.pressed.connect(hide_modal)
	if cycle_btn:
		cycle_btn.pressed.connect(_on_cycle_pressed)
	if not GameManager.arena_modifiers_updated.is_connected(_on_arena_modifiers_updated):
		GameManager.arena_modifiers_updated.connect(_on_arena_modifiers_updated)

func open_modal() -> void:
	visible = true
	update_content()

func hide_modal() -> void:
	visible = false

func _on_cycle_pressed() -> void:
	GameManager.cycle_background()
	update_content()

func _on_arena_modifiers_updated(_active_mods: Array, _arena_info: Dictionary) -> void:
	if visible:
		update_content()

func update_content() -> void:
	var info = GameManager.get_current_arena_info()
	if info.is_empty():
		return
		
	var a_name = info.get("name", "战斗场地")
	var a_desc = info.get("desc", "")
	var mods: Array = info.get("modifiers", [])
	var current_tier = GameManager.get_active_arena_tier()
	var current_round = GameManager.current_round
	var next_round = GameManager.get_next_awaken_round()
	
	title_label.text = "🏟️ %s • 场地特性环境" % a_name
	desc_label.text = "%s\n（每 3 局追加一项新特性，当前已激活 %d / %d 项）" % [a_desc, min(current_tier, mods.size()), mods.size()]
	
	if current_tier < mods.size():
		awaken_label.text = "⚡ 下一特性觉醒：第 %d 回合（当前第 %d 回合）" % [next_round, current_round]
		awaken_label.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2))
	else:
		awaken_label.text = "✨ 场地全特性已完全觉醒！"
		awaken_label.add_theme_color_override("font_color", Color(0.3, 0.95, 0.5))
		
	# Clear and rebuild modifier cards
	for c in cards_container.get_children():
		c.queue_free()
		
	for i in range(mods.size()):
		var mod = mods[i]
		var is_active = (i + 1) <= current_tier
		var card = _create_modifier_card(mod, i + 1, is_active)
		cards_container.add_child(card)

func _create_modifier_card(mod: Dictionary, stage_num: int, is_active: bool) -> PanelContainer:
	var pc = PanelContainer.new()
	var sb = StyleBoxFlat.new()
	sb.corner_radius_top_left = 6
	sb.corner_radius_top_right = 6
	sb.corner_radius_bottom_right = 6
	sb.corner_radius_bottom_left = 6
	
	var m_type = mod.get("type", "buff")
	var unlock_round = (stage_num - 1) * 3 + 1
	
	if is_active:
		sb.bg_color = Color(0.12, 0.18, 0.26, 0.95)
		sb.border_width_left = 3
		sb.border_width_top = 1
		sb.border_width_right = 1
		sb.border_width_bottom = 1
		if m_type == "buff":
			sb.border_color = Color(0.25, 0.85, 0.45, 0.9)
		elif m_type == "debuff":
			sb.border_color = Color(0.95, 0.35, 0.3, 0.9)
		else:
			sb.border_color = Color(1.0, 0.8, 0.2, 0.9)
	else:
		sb.bg_color = Color(0.09, 0.11, 0.15, 0.6)
		sb.border_width_left = 1
		sb.border_width_top = 1
		sb.border_width_right = 1
		sb.border_width_bottom = 1
		sb.border_color = Color(0.25, 0.3, 0.4, 0.4)
		
	pc.add_theme_stylebox_override("panel", sb)
	
	var vbox = VBoxContainer.new()
	vbox.name = "VBox"
	vbox.add_theme_constant_override("separation", 4)
	
	var hbox = HBoxContainer.new()
	hbox.name = "HBox"
	hbox.add_theme_constant_override("separation", 8)
	
	var status_lbl = Label.new()
	if is_active:
		status_lbl.text = "【✅ 阶段 %d 已激活】" % stage_num
		status_lbl.add_theme_color_override("font_color", Color(0.3, 0.9, 0.4))
	else:
		status_lbl.text = "【🔒 第 %d 回合觉醒】" % unlock_round
		status_lbl.add_theme_color_override("font_color", Color(0.6, 0.65, 0.75))
	status_lbl.add_theme_font_size_override("font_size", 12)
	hbox.add_child(status_lbl)
	
	var name_lbl = Label.new()
	name_lbl.text = mod.get("name", "")
	name_lbl.add_theme_font_size_override("font_size", 13)
	name_lbl.add_theme_color_override("font_color", Color(1.0, 0.95, 0.8) if is_active else Color(0.6, 0.65, 0.7))
	hbox.add_child(name_lbl)
	
	var type_lbl = Label.new()
	if m_type == "buff":
		type_lbl.text = "[增益 Buff]"
		type_lbl.add_theme_color_override("font_color", Color(0.2, 0.9, 0.4))
	elif m_type == "debuff":
		type_lbl.text = "[减益 Debuff]"
		type_lbl.add_theme_color_override("font_color", Color(0.95, 0.35, 0.3))
	else:
		type_lbl.text = "[双刃剑 Hybrid]"
		type_lbl.add_theme_color_override("font_color", Color(1.0, 0.8, 0.2))
	type_lbl.add_theme_font_size_override("font_size", 11)
	hbox.add_child(type_lbl)
	
	vbox.add_child(hbox)
	
	var desc_lbl = Label.new()
	desc_lbl.text = mod.get("desc", "")
	desc_lbl.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	desc_lbl.add_theme_font_size_override("font_size", 12)
	desc_lbl.add_theme_color_override("font_color", Color(0.85, 0.9, 0.95) if is_active else Color(0.5, 0.55, 0.6))
	vbox.add_child(desc_lbl)
	
	var margin = MarginContainer.new()
	margin.name = "Margin"
	margin.add_theme_constant_override("margin_left", 12)
	margin.add_theme_constant_override("margin_top", 8)
	margin.add_theme_constant_override("margin_right", 12)
	margin.add_theme_constant_override("margin_bottom", 8)
	margin.add_child(vbox)
	
	pc.add_child(margin)
	return pc
