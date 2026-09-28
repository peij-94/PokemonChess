extends Panel
class_name EvolutionChoiceModal

# EvolutionChoiceModal: Step 1 of the 3-Star evolution flow
# When a unit reaches ★3, player chooses whether to evolve to a new form or keep current form (not evolve).
# Once form is chosen, transitions immediately to Step 2: SkillChoiceModal (at star 3).

@onready var backdrop: ColorRect = $Backdrop
@onready var dialog: Panel = $Dialog
@onready var title_label: Label = $Dialog/Header/TitleLabel
@onready var subtitle_label: Label = $Dialog/Header/SubtitleLabel
@onready var close_btn: Button = $Dialog/Header/CloseBtn
@onready var cards_container: HBoxContainer = $Dialog/CardsContainer

var target_unit_ref: WeakRef = null
var current_options: Array = []

const TYPE_COLORS = {
	"Normal": Color(0.66, 0.66, 0.53),
	"Fire": Color(0.95, 0.45, 0.22),
	"Water": Color(0.35, 0.58, 0.95),
	"Grass": Color(0.42, 0.78, 0.32),
	"Electric": Color(0.98, 0.82, 0.18),
	"Ice": Color(0.55, 0.85, 0.85),
	"Fighting": Color(0.78, 0.25, 0.2),
	"Poison": Color(0.65, 0.3, 0.65),
	"Ground": Color(0.85, 0.72, 0.4),
	"Flying": Color(0.62, 0.55, 0.92),
	"Psychic": Color(0.96, 0.35, 0.55),
	"Bug": Color(0.62, 0.72, 0.15),
	"Rock": Color(0.72, 0.62, 0.25),
	"Ghost": Color(0.45, 0.35, 0.62),
	"Dragon": Color(0.42, 0.25, 0.95),
	"Steel": Color(0.7, 0.7, 0.78),
	"Fairy": Color(0.92, 0.62, 0.75),
}

const TYPE_NAMES_CN = {
	"Normal": "一般", "Fire": "火", "Water": "水", "Grass": "草",
	"Electric": "电", "Ice": "冰", "Fighting": "格斗", "Poison": "毒",
	"Ground": "地面", "Flying": "飞行", "Psychic": "超能", "Bug": "虫",
	"Rock": "岩石", "Ghost": "幽灵", "Dragon": "龙", "Steel": "钢", "Fairy": "妖精"
}

func _ready() -> void:
	visible = false
	if close_btn:
		close_btn.pressed.connect(_on_close_pressed)

func open_for_unit(unit: Unit, evolution_options: Array) -> void:
	if not is_instance_valid(unit):
		return
		
	target_unit_ref = weakref(unit)
	current_options = evolution_options.duplicate()
	
	var cur_data = PokemonDatabase.get_pokemon(unit.pokemon_id)
	var cur_name = cur_data.get("name", unit.pokemon_id)
	
	title_label.text = "【%s ★3】满星达成！请选择形态" % cur_name
	subtitle_label.text = "角色已满3星！您可以选择进化为更强形态，亦可选择保持当前形态（不进化）。确定形态后将挑选其 ★3 专属强力招式！"
	
	_populate_cards(unit, cur_data, cur_name)
	
	visible = true
	modulate.a = 0.0
	var tw = create_tween()
	tw.tween_property(self, "modulate:a", 1.0, 0.15)
	AudioManager.play_sfx("click")

func _populate_cards(unit: Unit, cur_data: Dictionary, cur_name: String) -> void:
	for c in cards_container.get_children():
		c.queue_free()
		
	# 1. Cards for available evolution options
	for evo_id in current_options:
		if evo_id == unit.pokemon_id:
			continue
		var evo_data = PokemonDatabase.get_pokemon(evo_id)
		if evo_data.is_empty():
			continue
		var evo_card = _create_form_card(evo_id, evo_data, true)
		cards_container.add_child(evo_card)
		
	# 2. Card for "保持形态 (不进化)"
	var keep_card = _create_form_card(unit.pokemon_id, cur_data, false)
	cards_container.add_child(keep_card)

func _create_form_card(pid: String, data: Dictionary, is_evolution: bool) -> PanelContainer:
	var pc = PanelContainer.new()
	pc.custom_minimum_size = Vector2(240, 340)
	pc.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	
	var style = StyleBoxFlat.new()
	if is_evolution:
		style.bg_color = Color(0.08, 0.13, 0.20, 0.95)
		style.border_color = Color(0.3, 0.85, 1.0, 1.0)
		style.set_border_width_all(2)
	else:
		style.bg_color = Color(0.12, 0.11, 0.07, 0.95)
		style.border_color = Color(1.0, 0.85, 0.3, 1.0)
		style.set_border_width_all(2)
	style.set_corner_radius_all(10)
	pc.add_theme_stylebox_override("panel", style)
	
	var margin = MarginContainer.new()
	margin.add_theme_constant_override("margin_left", 14)
	margin.add_theme_constant_override("margin_right", 14)
	margin.add_theme_constant_override("margin_top", 12)
	margin.add_theme_constant_override("margin_bottom", 12)
	pc.add_child(margin)
	
	var vbox = VBoxContainer.new()
	vbox.add_theme_constant_override("separation", 8)
	margin.add_child(vbox)
	
	# Tag / Mode label
	var mode_lbl = Label.new()
	mode_lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	if is_evolution:
		mode_lbl.text = "🧬 进化形态"
		mode_lbl.add_theme_color_override("font_color", Color(0.4, 0.9, 1.0))
	else:
		mode_lbl.text = "⭐ 保持形态 (不进化)"
		mode_lbl.add_theme_color_override("font_color", Color(1.0, 0.85, 0.3))
	mode_lbl.add_theme_font_size_override("font_size", 13)
	vbox.add_child(mode_lbl)
	
	# Icon display
	var icon_center = CenterContainer.new()
	icon_center.custom_minimum_size = Vector2(0, 64)
	var icon_rect = TextureRect.new()
	icon_rect.custom_minimum_size = Vector2(56, 56)
	icon_rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	icon_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	var sf = PokemonDatabase.get_sprite_frames(pid)
	if sf and sf.has_animation("idle") and sf.get_frame_count("idle") > 0:
		icon_rect.texture = sf.get_frame_texture("idle", 0)
	elif ResourceLoader.exists(data.get("icon", "")):
		icon_rect.texture = load(data.get("icon", ""))
	icon_center.add_child(icon_rect)
	vbox.add_child(icon_center)
	
	# Name & Stars
	var p_name = data.get("name", pid)
	var name_lbl = Label.new()
	name_lbl.text = "%s ★3" % p_name
	name_lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	name_lbl.add_theme_font_size_override("font_size", 16)
	name_lbl.add_theme_color_override("font_color", Color(1.0, 0.9, 0.3) if not is_evolution else Color(0.9, 0.95, 1.0))
	vbox.add_child(name_lbl)
	
	# Types row
	var types_hbox = HBoxContainer.new()
	types_hbox.alignment = BoxContainer.ALIGNMENT_CENTER
	types_hbox.add_theme_constant_override("separation", 6)
	var types_arr = data.get("types", [])
	for t_name in types_arr:
		var t_panel = PanelContainer.new()
		var t_style = StyleBoxFlat.new()
		t_style.bg_color = TYPE_COLORS.get(t_name, Color(0.4, 0.4, 0.5))
		t_style.set_corner_radius_all(4)
		t_style.set_content_margin_all(2)
		t_panel.add_theme_stylebox_override("panel", t_style)
		var t_lbl = Label.new()
		t_lbl.text = " %s " % TYPE_NAMES_CN.get(t_name, t_name)
		t_lbl.add_theme_font_size_override("font_size", 10)
		t_panel.add_child(t_lbl)
		types_hbox.add_child(t_panel)
	vbox.add_child(types_hbox)
	
	# Base stats preview (at ★3, scaling ~3.24x)
	var mult = pow(1.8, 2.0)
	var hp_val = int(data.get("hp", 500) * mult)
	var atk_val = int(data.get("atk", 50) * mult)
	var stats_lbl = Label.new()
	stats_lbl.text = "生命: %d  |  攻击: %d\n护甲: %d  |  魔抗: %d  |  射程: %d" % [
		hp_val, atk_val,
		int(data.get("armor", 30)), int(data.get("mr", 25)),
		int(data.get("range", 1))
	]
	stats_lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	stats_lbl.add_theme_font_size_override("font_size", 10)
	stats_lbl.add_theme_color_override("font_color", Color(0.75, 0.82, 0.9))
	vbox.add_child(stats_lbl)
	
	# Desc / note
	var desc_lbl = Label.new()
	desc_lbl.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	desc_lbl.add_theme_font_size_override("font_size", 10)
	desc_lbl.size_flags_vertical = Control.SIZE_EXPAND_FILL
	if is_evolution:
		desc_lbl.text = "蜕变升级为全新进化形态，解锁专属高阶属性与 ★3 终极技能！"
		desc_lbl.add_theme_color_override("font_color", Color(0.65, 0.85, 0.95))
	else:
		desc_lbl.text = "维持原始基础外观与定位，直接获得 ★3 满星专属强化数值与强力招式！"
		desc_lbl.add_theme_color_override("font_color", Color(0.95, 0.85, 0.6))
	vbox.add_child(desc_lbl)
	
	# Action button
	var btn = Button.new()
	btn.custom_minimum_size = Vector2(0, 36)
	if is_evolution:
		btn.text = "🧬 确认进化为 %s" % p_name
	else:
		btn.text = "⭐ 保持形态 (不进化)"
	btn.pressed.connect(func(): _on_form_chosen(pid, is_evolution))
	vbox.add_child(btn)
	
	return pc

func _on_form_chosen(chosen_id: String, is_evolution: bool) -> void:
	AudioManager.play_sfx("click")
	var unit = target_unit_ref.get_ref() as Unit if target_unit_ref else null
	if unit and is_instance_valid(unit):
		unit.transform_to_evolution(chosen_id, 3)
		if is_evolution:
			AudioManager.play_sfx("evolve")
		else:
			AudioManager.play_sfx("upgrade")
		GameManager.notify_unit_evolved(unit.pokemon_id, 3)
		GameManager.board_ref.update_synergies()
		
		# Close this modal and proceed immediately to Step 2: 3-Star Skill Choice!
		close()
		GameManager.request_skill_choice(unit, 3)
	else:
		close()

func _on_close_pressed() -> void:
	var unit = target_unit_ref.get_ref() as Unit if target_unit_ref else null
	if unit and is_instance_valid(unit):
		# Default to keeping current form and opening 3-star skills
		unit.transform_to_evolution(unit.pokemon_id, 3)
		close()
		GameManager.request_skill_choice(unit, 3)
	else:
		close()

func close() -> void:
	visible = false
	modulate.a = 1.0
	target_unit_ref = null
