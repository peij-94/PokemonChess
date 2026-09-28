extends Panel
class_name SkillChoiceModal

# SkillChoiceModal: Interactive 3-card branching skill selection modal upon star upgrade or skill swap
# Allows player to choose among 3 authentic canonical moves, or retain current move.

@onready var backdrop: ColorRect = $Backdrop
@onready var dialog: Panel = $Dialog
@onready var title_label: Label = $Dialog/Header/TitleLabel
@onready var subtitle_label: Label = $Dialog/Header/SubtitleLabel
@onready var close_btn: Button = $Dialog/Header/CloseBtn
@onready var form_choice_hbox: HBoxContainer = $Dialog/Header/FormChoiceHBox if has_node("Dialog/Header/FormChoiceHBox") else null

@onready var cards_container: HBoxContainer = $Dialog/CardsContainer
@onready var keep_current_btn: Button = $Dialog/Footer/KeepCurrentBtn

var target_unit_ref: WeakRef = null
var current_pokemon_id: String = ""
var current_star_level: int = 2
var available_choices: Array = []

func _ready() -> void:
	visible = false
	if close_btn:
		close_btn.pressed.connect(close)
	if keep_current_btn:
		keep_current_btn.pressed.connect(close)
	if form_choice_hbox:
		form_choice_hbox.visible = false

func open_for_unit(unit: Unit, star_lvl: int = -1) -> void:
	if not is_instance_valid(unit):
		return
		
	target_unit_ref = weakref(unit)
	current_pokemon_id = unit.pokemon_id
	current_star_level = star_lvl if star_lvl > 0 else unit.star_level
	
	if form_choice_hbox:
		form_choice_hbox.visible = false
		
	_refresh_modal_view()
	visible = true
	
	modulate.a = 0.0
	var tw = create_tween()
	tw.tween_property(self, "modulate:a", 1.0, 0.15)
	AudioManager.play_sfx("click")

func _refresh_modal_view() -> void:
	var unit = target_unit_ref.get_ref() as Unit if target_unit_ref else null
	var p_data = PokemonDatabase.get_pokemon(current_pokemon_id)
	var p_name = p_data.get("name", current_pokemon_id)
	
	if current_star_level >= 3:
		title_label.text = "【%s ★3】请选择满星专属终极招式" % p_name
		subtitle_label.text = "满星专属招式威力超绝，请选择最契合您战术的强力技能！（整备期随时可重新切换）"
	else:
		title_label.text = "【%s ★%d】升星成功！请选择新招式" % [p_name, current_star_level]
		var current_skill_name = unit.skill_name if unit and unit.skill_name != "" else "基础招式"
		subtitle_label.text = "若未做选择，将默认沿用原等级招式：【%s】（整备期随时可重新切换）" % current_skill_name
		
	available_choices = PokemonDatabase.get_skill_choices(current_pokemon_id, current_star_level)
	if available_choices.is_empty():
		available_choices = [PokemonDatabase.get_skill_data(current_pokemon_id, current_star_level, 0)]
		
	_populate_cards()

func _populate_cards() -> void:
	for child in cards_container.get_children():
		child.queue_free()
		
	var unit = target_unit_ref.get_ref() as Unit if target_unit_ref else null
	var active_skill_name = unit.skill_name if unit else ""
	
	for idx in range(available_choices.size()):
		var skill = available_choices[idx]
		var card = _create_skill_card(skill, idx, skill.get("name", "") == active_skill_name)
		cards_container.add_child(card)

func _create_skill_card(skill: Dictionary, idx: int, is_active: bool) -> PanelContainer:
	var pc = PanelContainer.new()
	pc.custom_minimum_size = Vector2(250, 330)
	pc.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	
	var style = StyleBoxFlat.new()
	if is_active:
		style.bg_color = Color(0.12, 0.20, 0.28, 0.95)
		style.border_color = Color(0.3, 0.85, 1.0, 1.0)
		style.set_border_width_all(2)
	else:
		style.bg_color = Color(0.08, 0.10, 0.14, 0.92)
		style.border_color = Color(0.25, 0.35, 0.45, 0.8)
		style.set_border_width_all(1)
	style.set_corner_radius_all(8)
	pc.add_theme_stylebox_override("panel", style)
	
	var vbox = VBoxContainer.new()
	vbox.add_theme_constant_override("separation", 8)
	pc.add_child(vbox)
	
	var margin = MarginContainer.new()
	margin.add_theme_constant_override("margin_left", 12)
	margin.add_theme_constant_override("margin_right", 12)
	margin.add_theme_constant_override("margin_top", 10)
	margin.add_theme_constant_override("margin_bottom", 10)
	vbox.add_child(margin)
	
	var inner_vbox = VBoxContainer.new()
	inner_vbox.add_theme_constant_override("separation", 6)
	margin.add_child(inner_vbox)
	
	# 1. Skill Name Header
	var title_lbl = Label.new()
	title_lbl.text = "招式 %d: 【%s】" % [idx + 1, skill.get("name", "招式")]
	title_lbl.add_theme_font_size_override("font_size", 16)
	title_lbl.add_theme_color_override("font_color", Color(1.0, 0.85, 0.3) if not is_active else Color(0.3, 0.9, 1.0))
	title_lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	inner_vbox.add_child(title_lbl)
	
	# 2. Key Combat Stats Badges
	var stats_hbox = HBoxContainer.new()
	stats_hbox.alignment = BoxContainer.ALIGNMENT_CENTER
	stats_hbox.add_theme_constant_override("separation", 10)
	
	var p_lbl = Label.new()
	p_lbl.text = "威力: %d" % int(skill.get("power", 200))
	p_lbl.add_theme_font_size_override("font_size", 11)
	p_lbl.add_theme_color_override("font_color", Color(1.0, 0.45, 0.35))
	stats_hbox.add_child(p_lbl)
	
	var tc_lbl = Label.new()
	tc_lbl.text = "目标: %d名" % int(skill.get("target_count", 1))
	tc_lbl.add_theme_font_size_override("font_size", 11)
	tc_lbl.add_theme_color_override("font_color", Color(0.45, 0.85, 1.0))
	stats_hbox.add_child(tc_lbl)
	
	var stun_val = float(skill.get("stun_duration", 0.0))
	if stun_val > 0.0:
		var st_lbl = Label.new()
		st_lbl.text = "控制: %.1fs" % stun_val
		st_lbl.add_theme_font_size_override("font_size", 11)
		st_lbl.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2))
		stats_hbox.add_child(st_lbl)
		
	inner_vbox.add_child(stats_hbox)
	
	# 3. Separator
	var hsep = HSeparator.new()
	inner_vbox.add_child(hsep)
	
	# 4. Flavor Description
	var desc_lbl = Label.new()
	desc_lbl.text = "“%s”" % skill.get("desc", "")
	desc_lbl.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	desc_lbl.add_theme_font_size_override("font_size", 11)
	desc_lbl.add_theme_color_override("font_color", Color(0.7, 0.75, 0.82))
	desc_lbl.custom_minimum_size = Vector2(0, 42)
	inner_vbox.add_child(desc_lbl)
	
	# 5. Tactical Auto-chess effect
	var detail_lbl = Label.new()
	detail_lbl.text = skill.get("detail", "")
	detail_lbl.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	detail_lbl.add_theme_font_size_override("font_size", 11)
	detail_lbl.add_theme_color_override("font_color", Color(0.88, 0.92, 0.96))
	detail_lbl.size_flags_vertical = Control.SIZE_EXPAND_FILL
	inner_vbox.add_child(detail_lbl)
	
	# 6. Action Button
	var btn = Button.new()
	btn.custom_minimum_size = Vector2(0, 34)
	if is_active:
		btn.text = "✓ 当前已装备"
		btn.disabled = true
	else:
		btn.text = "学习此招式"
		btn.pressed.connect(func(): _on_skill_selected(idx))
	inner_vbox.add_child(btn)
	
	return pc

func _on_skill_selected(choice_idx: int) -> void:
	if target_unit_ref:
		var unit = target_unit_ref.get_ref() as Unit
		if unit and is_instance_valid(unit) and choice_idx < available_choices.size():
			unit.select_skill(available_choices[choice_idx])
	close()

func close() -> void:
	visible = false
	modulate.a = 1.0
	target_unit_ref = null
