extends PanelContainer
class_name TrainerWidget

# TrainerWidget: HUD micro-widget for Trainer Avatars & Tactical Support Skills (Module 4)
# Placed on HUD (top-left or top-right) with 2D classic pixel & Dream World styling.

signal tactic_button_pressed()
signal trainer_avatar_clicked()

@onready var avatar_btn: TextureButton = $Margin/HBox/AvatarBtn
@onready var avatar_rect: TextureRect = $Margin/HBox/AvatarBtn/AvatarRect
@onready var name_label: Label = $Margin/HBox/InfoVBox/NameLabel
@onready var passive_tag: Label = $Margin/HBox/InfoVBox/PassiveTag
@onready var tactic_btn: Button = $Margin/HBox/TacticBtn
@onready var glow_overlay: ColorRect = $GlowOverlay

var trainer_selection_modal: Panel = null

# Styles for Tactic Button
var style_ready: StyleBoxFlat
var style_cooldown: StyleBoxFlat
var is_casting_animation: bool = false

func _ready() -> void:
	_init_styles()
	_create_selection_modal()
	
	if avatar_btn:
		avatar_btn.pressed.connect(_on_avatar_pressed)
	if tactic_btn:
		tactic_btn.pressed.connect(_on_tactic_pressed)
		
	if TrainerSystem:
		if not TrainerSystem.trainer_changed.is_connected(_on_trainer_changed):
			TrainerSystem.trainer_changed.connect(_on_trainer_changed)
		if not TrainerSystem.cooldown_changed.is_connected(_on_cooldown_changed):
			TrainerSystem.cooldown_changed.connect(_on_cooldown_changed)
		if not TrainerSystem.tactic_ready.is_connected(_on_tactic_ready):
			TrainerSystem.tactic_ready.connect(_on_tactic_ready)
		if not TrainerSystem.tactic_cast.is_connected(_on_tactic_cast):
			TrainerSystem.tactic_cast.connect(_on_tactic_cast)
			
	refresh_display()

func _init_styles() -> void:
	# Ready golden glowing style
	style_ready = StyleBoxFlat.new()
	style_ready.bg_color = Color(0.72, 0.52, 0.12, 0.95)
	style_ready.border_color = Color(1.0, 0.9, 0.4, 1.0)
	style_ready.set_border_width_all(2)
	style_ready.set_corner_radius_all(6)
	style_ready.shadow_color = Color(1.0, 0.8, 0.2, 0.45)
	style_ready.shadow_size = 4
	
	# Cooldown style
	style_cooldown = StyleBoxFlat.new()
	style_cooldown.bg_color = Color(0.18, 0.2, 0.26, 0.85)
	style_cooldown.border_color = Color(0.35, 0.4, 0.5, 0.6)
	style_cooldown.set_border_width_all(1)
	style_cooldown.set_corner_radius_all(6)
	style_cooldown.shadow_size = 0

func refresh_display() -> void:
	if not TrainerSystem:
		return
	var data = TrainerSystem.get_current_trainer()
	if data.is_empty():
		return
		
	# Avatar
	var avatar_path = data.get("avatar_path", "")
	if ResourceLoader.exists(avatar_path):
		var tex = load(avatar_path)
		if avatar_rect and tex:
			avatar_rect.texture = tex
			
	# Name & Theme
	if name_label:
		name_label.text = data.get("name", "赤红 (Red)")
		var col = data.get("theme_color", Color(1.0, 0.85, 0.25))
		name_label.add_theme_color_override("font_color", col)
		
	# Passive Tag & Tooltip
	if passive_tag:
		var p_name = data.get("passive_name", "真新意志")
		var p_short = data.get("passive_short", "")
		passive_tag.text = "✦ %s" % p_short
		var p_desc = data.get("passive_desc", "")
		passive_tag.tooltip_text = "【%s 特性】\n%s\n(点击头像可自由切换训练家)" % [p_name, p_desc]
		
	# Button Cooldown Status
	_update_tactic_button(TrainerSystem.current_cooldown, TrainerSystem.max_cooldown)

func _update_tactic_button(cd: int, max_cd: int) -> void:
	if not tactic_btn:
		return
		
	var data = TrainerSystem.get_current_trainer() if TrainerSystem else {}
	var t_name = data.get("tactic_name", "战术技能")
	var t_desc = data.get("tactic_desc", "")
	var t_icon = data.get("tactic_icon", "⚡")
	
	if cd <= 0:
		tactic_btn.text = "%s %s (Q)" % [t_icon, t_name]
		tactic_btn.tooltip_text = "【%s】(就绪)\n%s\n快捷键 [Q] 立即释放" % [t_name, t_desc]
		tactic_btn.add_theme_stylebox_override("normal", style_ready)
		tactic_btn.add_theme_color_override("font_color", Color(1.0, 1.0, 0.9))
		tactic_btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	else:
		tactic_btn.text = "⏳ %d回合" % cd
		tactic_btn.tooltip_text = "【%s】(冷却中: 还需 %d 回合)\n%s" % [t_name, cd, t_desc]
		tactic_btn.add_theme_stylebox_override("normal", style_cooldown)
		tactic_btn.add_theme_color_override("font_color", Color(0.7, 0.75, 0.85))
		tactic_btn.mouse_default_cursor_shape = Control.CURSOR_ARROW

func trigger_cast_animation() -> void:
	if is_casting_animation:
		return
	is_casting_animation = true
	
	# 1. Gold Glow Overlay flash
	if glow_overlay:
		glow_overlay.visible = true
		glow_overlay.modulate = Color(1.0, 0.85, 0.25, 0.0)
		var gt = create_tween()
		gt.tween_property(glow_overlay, "modulate:a", 0.75, 0.12).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		gt.tween_property(glow_overlay, "modulate:a", 0.0, 0.35).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
		gt.tween_callback(func():
			glow_overlay.visible = false
			is_casting_animation = false
		)
		
	# 2. Button bounce & scale pop
	if tactic_btn:
		var bt = create_tween()
		bt.tween_property(tactic_btn, "scale", Vector2(1.12, 1.12), 0.08).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
		bt.tween_property(tactic_btn, "scale", Vector2(1.0, 1.0), 0.15).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)

func execute_active_tactic() -> bool:
	if not TrainerSystem:
		return false
	if TrainerSystem.current_cooldown > 0:
		if GameManager and GameManager.hud_ref and GameManager.hud_ref.has_method("show_toast"):
			GameManager.hud_ref.show_toast("⏳ 战术技能冷却中 (%d 回合)" % TrainerSystem.current_cooldown, Color(1.0, 0.6, 0.3))
		return false
		
	if GameManager and GameManager.current_phase != GameManager.Phase.COMBAT:
		if GameManager.hud_ref and GameManager.hud_ref.has_method("show_toast"):
			GameManager.hud_ref.show_toast("⚠️ 战术技能只能在战斗阶段施放！", Color(1.0, 0.45, 0.45))
		return false
		
	var success = TrainerSystem.cast_active_tactic()
	if success:
		trigger_cast_animation()
	return success

func _on_tactic_pressed() -> void:
	tactic_button_pressed.emit()
	execute_active_tactic()

func _on_avatar_pressed() -> void:
	trainer_avatar_clicked.emit()
	open_trainer_selection_modal()

func _on_trainer_changed(_id: String, _data: Dictionary) -> void:
	refresh_display()

func _on_cooldown_changed(cd: int, max_cd: int) -> void:
	_update_tactic_button(cd, max_cd)

func _on_tactic_ready(_id: String) -> void:
	_update_tactic_button(0, TrainerSystem.max_cooldown if TrainerSystem else 3)
	# Pulse flash when ready
	if tactic_btn:
		var tw = create_tween()
		tw.tween_property(tactic_btn, "modulate", Color(1.3, 1.2, 0.4, 1.0), 0.15)
		tw.tween_property(tactic_btn, "modulate", Color(1.0, 1.0, 1.0, 1.0), 0.25)

func _on_tactic_cast(_id: String, _info: Dictionary) -> void:
	trigger_cast_animation()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_Q:
			execute_active_tactic()

# -----------------------------------------------------------------------------
# Trainer Switch Modal Dialog
# -----------------------------------------------------------------------------
func _create_selection_modal() -> void:
	trainer_selection_modal = Panel.new()
	trainer_selection_modal.name = "TrainerSelectionModal"
	trainer_selection_modal.set_anchors_preset(Control.PRESET_FULL_RECT)
	trainer_selection_modal.visible = false
	trainer_selection_modal.z_index = 100
	
	var backdrop = ColorRect.new()
	backdrop.set_anchors_preset(Control.PRESET_FULL_RECT)
	backdrop.color = Color(0.02, 0.03, 0.06, 0.85)
	trainer_selection_modal.add_child(backdrop)
	
	var dialog = Panel.new()
	dialog.name = "Dialog"
	dialog.custom_minimum_size = Vector2(820, 480)
	dialog.position = Vector2(230, 120)
	var d_style = StyleBoxFlat.new()
	d_style.bg_color = Color(0.08, 0.1, 0.15, 0.98)
	d_style.border_color = Color(1.0, 0.84, 0.25, 0.9)
	d_style.set_border_width_all(2)
	d_style.set_corner_radius_all(10)
	d_style.shadow_color = Color(0, 0, 0, 0.8)
	d_style.shadow_size = 12
	dialog.add_theme_stylebox_override("panel", d_style)
	trainer_selection_modal.add_child(dialog)
	
	var vbox = VBoxContainer.new()
	vbox.set_anchors_preset(Control.PRESET_FULL_RECT)
	vbox.offset_left = 20
	vbox.offset_top = 16
	vbox.offset_right = -20
	vbox.offset_bottom = -16
	vbox.add_theme_constant_override("separation", 12)
	dialog.add_child(vbox)
	
	var title_lbl = Label.new()
	title_lbl.text = "👑 选择训练家身份 (Trainer Avatars & Tactics)"
	title_lbl.add_theme_font_size_override("font_size", 20)
	title_lbl.add_theme_color_override("font_color", Color(1.0, 0.88, 0.3))
	title_lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	vbox.add_child(title_lbl)
	
	var sub_lbl = Label.new()
	sub_lbl.text = "选择你的导师与战术支援技能，不同的被动特性与主动大招将重塑战局格局！"
	sub_lbl.add_theme_font_size_override("font_size", 12)
	sub_lbl.add_theme_color_override("font_color", Color(0.7, 0.8, 0.95))
	sub_lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	vbox.add_child(sub_lbl)
	
	var cards_hbox = HBoxContainer.new()
	cards_hbox.name = "CardsHBox"
	cards_hbox.size_flags_vertical = Control.SIZE_EXPAND_FILL
	cards_hbox.add_theme_constant_override("separation", 10)
	vbox.add_child(cards_hbox)
	
	_populate_modal_trainer_cards(cards_hbox)
	
	var close_btn = Button.new()
	close_btn.text = "关闭"
	close_btn.custom_minimum_size = Vector2(100, 32)
	close_btn.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	close_btn.pressed.connect(func(): trainer_selection_modal.visible = false)
	vbox.add_child(close_btn)
	
	add_child(trainer_selection_modal)

func _populate_modal_trainer_cards(container: HBoxContainer) -> void:
	if not TrainerSystem:
		return
	var all = TrainerSystem.get_all_trainers()
	for t in all:
		var card = PanelContainer.new()
		card.custom_minimum_size = Vector2(146, 320)
		card.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		var c_style = StyleBoxFlat.new()
		c_style.bg_color = Color(0.12, 0.15, 0.22, 0.92)
		c_style.border_color = t.get("theme_color", Color(0.4, 0.6, 0.8))
		c_style.set_border_width_all(1)
		c_style.set_corner_radius_all(6)
		card.add_theme_stylebox_override("panel", c_style)
		
		var cvbox = VBoxContainer.new()
		cvbox.offset_left = 6
		cvbox.offset_top = 8
		cvbox.offset_right = -6
		cvbox.offset_bottom = -8
		cvbox.add_theme_constant_override("separation", 6)
		card.add_child(cvbox)
		
		# Avatar
		var img_rect = TextureRect.new()
		img_rect.custom_minimum_size = Vector2(64, 64)
		img_rect.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
		img_rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		img_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		var a_path = t.get("avatar_path", "")
		if ResourceLoader.exists(a_path):
			img_rect.texture = load(a_path)
		cvbox.add_child(img_rect)
		
		# Name
		var name_l = Label.new()
		name_l.text = t.get("name", "")
		name_l.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		name_l.add_theme_font_size_override("font_size", 13)
		name_l.add_theme_color_override("font_color", t.get("theme_color", Color.WHITE))
		cvbox.add_child(name_l)
		
		# Title
		var title_l = Label.new()
		title_l.text = t.get("title", "")
		title_l.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		title_l.add_theme_font_size_override("font_size", 10)
		title_l.add_theme_color_override("font_color", Color(0.7, 0.75, 0.85))
		cvbox.add_child(title_l)
		
		# Divider
		var sep = HSeparator.new()
		cvbox.add_child(sep)
		
		# Passive
		var pass_lbl = Label.new()
		pass_lbl.text = "【%s】\n%s" % [t.get("passive_name", ""), t.get("passive_desc", "")]
		pass_lbl.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		pass_lbl.add_theme_font_size_override("font_size", 10)
		pass_lbl.add_theme_color_override("font_color", Color(0.9, 0.95, 0.8))
		cvbox.add_child(pass_lbl)
		
		# Tactic
		var tac_lbl = Label.new()
		tac_lbl.text = "⚡【%s】(CD 3)\n%s" % [t.get("tactic_name", ""), t.get("tactic_desc", "")]
		tac_lbl.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		tac_lbl.add_theme_font_size_override("font_size", 10)
		tac_lbl.add_theme_color_override("font_color", Color(0.95, 0.85, 0.4))
		cvbox.add_child(tac_lbl)
		
		var spacer = Control.new()
		spacer.size_flags_vertical = Control.SIZE_EXPAND_FILL
		cvbox.add_child(spacer)
		
		# Select Button
		var sel_btn = Button.new()
		var is_cur = (TrainerSystem.current_trainer_id == t.get("id", ""))
		sel_btn.text = "✓ 当前选用" if is_cur else "选择"
		sel_btn.disabled = is_cur
		var t_id = t.get("id", "")
		sel_btn.pressed.connect(func():
			TrainerSystem.select_trainer(t_id)
			trainer_selection_modal.visible = false
		)
		cvbox.add_child(sel_btn)
		
		container.add_child(card)

func open_trainer_selection_modal() -> void:
	if not trainer_selection_modal:
		_create_selection_modal()
		
	# Re-populate to update selected status
	var cards_hbox = trainer_selection_modal.get_node_or_null("Dialog/VBoxContainer/CardsHBox")
	if not cards_hbox:
		cards_hbox = trainer_selection_modal.find_child("CardsHBox", true, false)
	if cards_hbox:
		for c in cards_hbox.get_children():
			c.queue_free()
		_populate_modal_trainer_cards(cards_hbox)
		
	trainer_selection_modal.visible = true
