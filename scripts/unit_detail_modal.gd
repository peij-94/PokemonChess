extends Panel
class_name UnitDetailModal

const ELEMENTAL_HEX_SYSTEM_SCRIPT = preload("res://scripts/elemental_hex_system.gd")

# UnitDetailModal: Comprehensive character inspection card
# Pops up upon clicking ANY character (player or enemy, board or bench, prep or combat).
# Displays full stats, live HP/Mana bars, basic attack info, and detailed equipped skill mechanics.
# In preparation phase, offers Sell, Switch Skill (★2/★3), and Switch Evolution Form (★3).

@onready var close_btn: Button = $Header/CloseBtn
@onready var icon_rect: TextureRect = $Header/IconRect
@onready var name_label: Label = $Header/InfoVBox/NameLabel
@onready var badges_hbox: HBoxContainer = $Header/InfoVBox/BadgesHBox
@onready var types_hbox: HBoxContainer = $Header/InfoVBox/TypesHBox

# Bars
@onready var hp_bar: ProgressBar = $Body/BarsVBox/HPBar
@onready var hp_label: Label = $Body/BarsVBox/HPBar/HPLabel
@onready var mp_bar: ProgressBar = $Body/BarsVBox/MPBar
@onready var mp_label: Label = $Body/BarsVBox/MPBar/MPLabel

# Stats
@onready var stats_grid: GridContainer = $Body/StatsGrid

# Skill card
@onready var skill_title_lbl: Label = $Body/SkillPanel/Margin/VBox/SkillTitleLabel
@onready var skill_badges_hbox: HBoxContainer = $Body/SkillPanel/Margin/VBox/SkillBadgesHBox
@onready var skill_flavor_lbl: Label = $Body/SkillPanel/Margin/VBox/SkillFlavorLabel
@onready var skill_detail_lbl: Label = $Body/SkillPanel/Margin/VBox/SkillDetailLabel

# Actions
@onready var actions_hbox: HBoxContainer = $Footer/ActionsHBox
@onready var sell_btn: Button = $Footer/ActionsHBox/SellBtn
@onready var switch_skill_btn: Button = $Footer/ActionsHBox/SwitchSkillBtn
@onready var switch_form_btn: Button = $Footer/ActionsHBox/SwitchFormBtn
var unequip_btn: Button = null
var dynamax_btn: Button = null

# Dynamic Ability & Items Panels
var ability_panel: PanelContainer = null
var ability_title_lbl: Label = null
var ability_desc_lbl: Label = null
var items_hbox: HBoxContainer = null

var target_unit_ref: WeakRef = null

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
		close_btn.pressed.connect(close)
	if sell_btn:
		sell_btn.pressed.connect(_on_sell_pressed)
	if switch_skill_btn:
		switch_skill_btn.pressed.connect(_on_switch_skill_pressed)
	if switch_form_btn:
		switch_form_btn.pressed.connect(_on_switch_form_pressed)
		
	unequip_btn = Button.new()
	unequip_btn.name = "UnequipBtn"
	unequip_btn.text = "🎒 卸下装备"
	unequip_btn.add_theme_font_size_override("font_size", 12)
	var u_style = StyleBoxFlat.new()
	u_style.bg_color = Color(0.18, 0.28, 0.42, 1.0)
	u_style.border_color = Color(0.35, 0.65, 0.95, 1.0)
	u_style.set_border_width_all(1)
	u_style.set_corner_radius_all(4)
	unequip_btn.add_theme_stylebox_override("normal", u_style)
	unequip_btn.pressed.connect(_on_unequip_pressed)
	actions_hbox.add_child(unequip_btn)
	
	dynamax_btn = Button.new()
	dynamax_btn.name = "ModalDynamaxBtn"
	dynamax_btn.text = "🔴 极巨化"
	dynamax_btn.add_theme_font_size_override("font_size", 12)
	var d_style = StyleBoxFlat.new()
	d_style.bg_color = Color(0.45, 0.12, 0.18, 1.0)
	d_style.border_color = Color(0.95, 0.35, 0.5, 1.0)
	d_style.set_border_width_all(1)
	d_style.set_corner_radius_all(4)
	dynamax_btn.add_theme_stylebox_override("normal", d_style)
	dynamax_btn.pressed.connect(_on_dynamax_pressed)
	actions_hbox.add_child(dynamax_btn)
	
	var body = get_node_or_null("Body")
	if body:
		ability_panel = PanelContainer.new()
		ability_panel.name = "AbilityPanel"
		var a_style = StyleBoxFlat.new()
		a_style.bg_color = Color(0.08, 0.12, 0.18, 0.9)
		a_style.border_color = Color(0.3, 0.5, 0.75, 0.7)
		a_style.set_border_width_all(1)
		a_style.set_corner_radius_all(6)
		ability_panel.add_theme_stylebox_override("panel", a_style)
		
		var a_margin = MarginContainer.new()
		a_margin.add_theme_constant_override("margin_left", 8)
		a_margin.add_theme_constant_override("margin_right", 8)
		a_margin.add_theme_constant_override("margin_top", 6)
		a_margin.add_theme_constant_override("margin_bottom", 6)
		
		var a_vbox = VBoxContainer.new()
		a_vbox.add_theme_constant_override("separation", 3)
		a_margin.add_child(a_vbox)
		ability_panel.add_child(a_margin)
		
		ability_title_lbl = Label.new()
		ability_title_lbl.add_theme_font_size_override("font_size", 12)
		ability_title_lbl.add_theme_color_override("font_color", Color(1.0, 0.85, 0.35))
		a_vbox.add_child(ability_title_lbl)
		
		ability_desc_lbl = Label.new()
		ability_desc_lbl.add_theme_font_size_override("font_size", 11)
		ability_desc_lbl.add_theme_color_override("font_color", Color(0.8, 0.88, 0.95))
		ability_desc_lbl.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		a_vbox.add_child(ability_desc_lbl)
		
		var skill_p = body.get_node_or_null("SkillPanel")
		if skill_p:
			body.add_child(ability_panel)
			body.move_child(ability_panel, skill_p.get_index())
		else:
			body.add_child(ability_panel)
			
		items_hbox = HBoxContainer.new()
		items_hbox.name = "ItemsHBox"
		items_hbox.add_theme_constant_override("separation", 6)
		body.add_child(items_hbox)
		body.move_child(items_hbox, ability_panel.get_index() + 1)

func open(unit: Unit) -> void:
	open_for_unit(unit)

func open_for_unit(unit: Unit) -> void:
	if unit == null or not is_instance_valid(unit):
		close()
		return
		
	target_unit_ref = weakref(unit)
	_refresh_display()
	visible = true
	z_index = 25
	move_to_front()
	
	modulate.a = 0.0
	var tw = create_tween()
	tw.tween_property(self, "modulate:a", 1.0, 0.12)
	AudioManager.play_sfx("click")

func _process(_delta: float) -> void:
	if not visible or target_unit_ref == null:
		return
	var unit = target_unit_ref.get_ref() as Unit
	if unit == null or not is_instance_valid(unit) or unit.is_queued_for_deletion():
		close()
		return
		
	# Keep HP and MP bars updated in real time during combat
	hp_bar.max_value = max(1.0, unit.max_hp)
	hp_bar.value = clamp(unit.current_hp, 0.0, unit.max_hp)
	if unit.is_dead:
		hp_label.text = "生命: 已阵亡"
	else:
		hp_label.text = "生命: %d / %d" % [int(unit.current_hp), int(unit.max_hp)]
		
	mp_bar.max_value = max(1.0, unit.max_mana)
	mp_bar.value = clamp(unit.current_mana, 0.0, unit.max_mana)
	mp_label.text = "法力: %d / %d" % [int(unit.current_mana), int(unit.max_mana)]

func _refresh_display() -> void:
	var unit = target_unit_ref.get_ref() as Unit if target_unit_ref else null
	if unit == null or not is_instance_valid(unit):
		return
		
	var data = PokemonDatabase.get_pokemon(unit.pokemon_id)
	var p_name = data.get("name", unit.pokemon_id)
	
	# 1. Icon
	var sf = PokemonDatabase.get_sprite_frames(unit.pokemon_id)
	if sf and sf.has_animation("idle") and sf.get_frame_count("idle") > 0:
		icon_rect.texture = sf.get_frame_texture("idle", 0)
	elif ResourceLoader.exists(data.get("icon", "")):
		icon_rect.texture = load(data.get("icon", ""))
		
	# 2. Name & Stars
	var star_str = ""
	for i in range(unit.star_level):
		star_str += "★"
	name_label.text = "%s %s" % [p_name, star_str]
	if unit.star_level >= 3:
		name_label.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2))
	elif unit.star_level == 2:
		name_label.add_theme_color_override("font_color", Color(0.4, 0.85, 1.0))
	else:
		name_label.add_theme_color_override("font_color", Color(0.9, 0.95, 1.0))
		
	# 3. Badges Row (Team, Cost)
	for b in badges_hbox.get_children():
		b.queue_free()
		
	# Team badge
	var team_lbl = Label.new()
	if unit.is_enemy:
		team_lbl.text = "🔴 敌方目标"
		team_lbl.add_theme_color_override("font_color", Color(1.0, 0.4, 0.4))
	else:
		team_lbl.text = "🔵 我方主力"
		team_lbl.add_theme_color_override("font_color", Color(0.4, 0.8, 1.0))
	team_lbl.add_theme_font_size_override("font_size", 11)
	badges_hbox.add_child(team_lbl)
	
	# Cost badge
	var cost_val = data.get("cost", 1)
	var cost_lbl = Label.new()
	cost_lbl.text = "💰 %d费" % cost_val
	cost_lbl.add_theme_color_override("font_color", Color(1.0, 0.85, 0.3))
	cost_lbl.add_theme_font_size_override("font_size", 11)
	badges_hbox.add_child(cost_lbl)
	
	# Elemental Hex Badge
	if unit.has_meta("elemental_hex"):
		var hex_type = unit.get_meta("elemental_hex")
		var hex_info = ELEMENTAL_HEX_SYSTEM_SCRIPT.HEX_TYPES.get(hex_type, {})
		if not hex_info.is_empty():
			var hex_badge = PanelContainer.new()
			hex_badge.name = "HexBadge"
			var b_style = StyleBoxFlat.new()
			var h_col = hex_info.get("color", Color(0.8, 0.5, 0.2))
			b_style.bg_color = h_col.darkened(0.55)
			b_style.border_color = h_col
			b_style.set_border_width_all(1)
			b_style.set_corner_radius_all(4)
			b_style.set_content_margin_all(2)
			hex_badge.add_theme_stylebox_override("panel", b_style)
			
			var hex_lbl = Label.new()
			hex_lbl.text = " " + hex_info.get("badge", hex_info.get("name", "元素符文")) + " "
			hex_lbl.add_theme_color_override("font_color", h_col)
			hex_lbl.add_theme_font_size_override("font_size", 10)
			hex_badge.add_child(hex_lbl)
			badges_hbox.add_child(hex_badge)
	
	# 4. Types Badges
	for t in types_hbox.get_children():
		t.queue_free()
	for t_name in data.get("types", []):
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
		
	# 5. Live Bars
	hp_bar.max_value = max(1.0, unit.max_hp)
	hp_bar.value = clamp(unit.current_hp, 0.0, unit.max_hp)
	hp_label.text = "生命: %d / %d" % [int(unit.current_hp), int(unit.max_hp)]
	
	mp_bar.max_value = max(1.0, unit.max_mana)
	mp_bar.value = clamp(unit.current_mana, 0.0, unit.max_mana)
	mp_label.text = "法力: %d / %d" % [int(unit.current_mana), int(unit.max_mana)]
	
	# 6. Stats Grid
	for c in stats_grid.get_children():
		c.queue_free()
		
	var range_str = "%d格 (%s)" % [unit.attack_range, "远程" if unit.attack_range > 1 else "近战"]
	var b_atk_name = unit.basic_attack_info.get("name", "普攻")
	var b_atk_type = "法术" if unit.basic_attack_info.get("type", "") == "special" else "物理"
	
	var stat_items = [
		["🗡️ 攻击: %d" % int(unit.atk), Color(1.0, 0.5, 0.4)],
		["🛡️ 护甲: %d" % int(unit.armor), Color(0.85, 0.75, 0.5)],
		["🔮 魔抗: %d" % int(unit.mr), Color(0.7, 0.7, 1.0)],
		["🎯 射程: %s" % range_str, Color(0.5, 0.9, 0.7)],
		["⚡ 攻速: %.2f/s" % unit.atk_speed, Color(1.0, 0.9, 0.3)],
		["💥 普攻: %s(%s)" % [b_atk_name, b_atk_type], Color(0.9, 0.9, 0.95)]
	]
	
	for item in stat_items:
		if item[0].begins_with("💥 普攻"):
			var atk_btn = Button.new()
			atk_btn.text = "%s ▶️演示" % item[0]
			atk_btn.add_theme_color_override("font_color", Color(1.0, 0.85, 0.3))
			atk_btn.add_theme_font_size_override("font_size", 11)
			atk_btn.flat = true
			atk_btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
			atk_btn.pressed.connect(func(): _preview_basic_attack())
			stats_grid.add_child(atk_btn)
		else:
			var lbl = Label.new()
			lbl.text = item[0]
			lbl.add_theme_color_override("font_color", item[1])
			lbl.add_theme_font_size_override("font_size", 11)
			stats_grid.add_child(lbl)
		
	# 7. Equipped Skill Details
	var skill_dict = unit.selected_skill
	var s_name = unit.skill_name if unit.skill_name != "" else skill_dict.get("name", data.get("skill_name", "专属技能"))
	skill_title_lbl.text = "⚡ 技能: 【%s】 (★%d专属)" % [s_name, unit.star_level]
	
	# Badges for mana, power, targets, stun
	for b in skill_badges_hbox.get_children():
		b.queue_free()
		
	var mana_cost = int(unit.max_mana)
	var power_val = int(skill_dict.get("power", data.get("skill_power", 200)))
	var targets_val = int(skill_dict.get("target_count", 1))
	var stun_val = float(skill_dict.get("stun_duration", 0.0))
	
	var badges_data = [
		["🔷 耗能: %d" % mana_cost, Color(0.4, 0.8, 1.0)],
		["💥 威力: %d" % power_val, Color(1.0, 0.5, 0.4)],
		["🎯 目标: %d体" % targets_val, Color(0.5, 0.9, 0.6)]
	]
	if stun_val > 0.0:
		badges_data.append(["💫 眩晕: %.1fs" % stun_val, Color(1.0, 0.85, 0.2)])
		
	for bd in badges_data:
		var b_lbl = Label.new()
		b_lbl.text = bd[0]
		b_lbl.add_theme_color_override("font_color", bd[1])
		b_lbl.add_theme_font_size_override("font_size", 10)
		skill_badges_hbox.add_child(b_lbl)
		
	var flavor = skill_dict.get("desc", data.get("skill_desc", ""))
	if flavor != "":
		skill_flavor_lbl.text = "“%s”" % flavor
		skill_flavor_lbl.visible = true
	else:
		skill_flavor_lbl.visible = false
		
	var detail_text = skill_dict.get("detail", "")
	if detail_text == "":
		detail_text = unit.skill_desc
	if detail_text == "":
		detail_text = data.get("skill_detail", data.get("skill_desc", "对目标造成强力伤害。"))
	skill_detail_lbl.text = detail_text
	
	# 8. Ability Information
	if ability_panel and ability_title_lbl and ability_desc_lbl:
		var ab_data = AbilityDatabase.get_ability_for_pokemon(unit.pokemon_id) if AbilityDatabase else {}
		if not ab_data.is_empty():
			ability_title_lbl.text = "🌟 特性: 【%s】" % ab_data.get("name", "未知特性")
			ability_desc_lbl.text = ab_data.get("description", "")
			ability_panel.visible = true
		else:
			ability_panel.visible = false
			
	# 9. Held Items Slots
	if items_hbox:
		for c in items_hbox.get_children():
			c.queue_free()
		var held = unit.held_items if "held_items" in unit else []
		for i in range(Unit.MAX_HELD_ITEMS):
			var slot_p = PanelContainer.new()
			var slot_style = StyleBoxFlat.new()
			slot_style.set_corner_radius_all(4)
			slot_style.set_content_margin_all(3)
			if i < held.size():
				var item_id = held[i]
				var item_data = ItemDatabase.get_item(item_id) if ItemDatabase else {}
				slot_style.bg_color = Color(0.12, 0.2, 0.28, 0.9)
				slot_style.border_color = Color(0.3, 0.7, 1.0, 0.8)
				slot_style.set_border_width_all(1)
				slot_p.add_theme_stylebox_override("panel", slot_style)
				
				var h = HBoxContainer.new()
				h.add_theme_constant_override("separation", 4)
				
				var icon_p = TextureRect.new()
				icon_p.custom_minimum_size = Vector2(20, 20)
				icon_p.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
				icon_p.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
				var tex_path = item_data.get("icon", "")
				if ResourceLoader.exists(tex_path):
					icon_p.texture = load(tex_path)
				h.add_child(icon_p)
				
				var name_l = Label.new()
				name_l.text = item_data.get("name", item_id)
				name_l.add_theme_font_size_override("font_size", 10)
				name_l.add_theme_color_override("font_color", Color(0.9, 0.95, 1.0))
				h.add_child(name_l)
				slot_p.add_child(h)
				slot_p.tooltip_text = "%s\n%s" % [item_data.get("name", ""), item_data.get("description", "")]
			else:
				slot_style.bg_color = Color(0.08, 0.1, 0.14, 0.5)
				slot_style.border_color = Color(0.2, 0.3, 0.4, 0.4)
				slot_style.set_border_width_all(1)
				slot_p.add_theme_stylebox_override("panel", slot_style)
				var empty_l = Label.new()
				empty_l.text = " [空装备栏] "
				empty_l.add_theme_font_size_override("font_size", 10)
				empty_l.add_theme_color_override("font_color", Color(0.4, 0.5, 0.6))
				slot_p.add_child(empty_l)
			items_hbox.add_child(slot_p)

	# 10. Action Buttons (Only in Preparation Phase for Player Units)
	var is_prep = (GameManager.current_phase == GameManager.Phase.PREPARATION)
	var is_player = (not unit.is_enemy)
	
	if is_prep and is_player:
		actions_hbox.visible = true
		var refund = data.get("cost", 1) * int(pow(3, unit.star_level - 1))
		sell_btn.text = "💰 出售 (+%d金)" % refund
		sell_btn.visible = true
		
		# Skill swap: visible for ★2 and ★3
		switch_skill_btn.visible = (unit.star_level >= 2 or unit.has_unselected_upgrade)
		
		# Evolution form switch: visible for ★3 if chain has options
		var chain_forms = PokemonDatabase.get_all_chain_forms(unit.pokemon_id)
		switch_form_btn.visible = (unit.star_level >= 3 and chain_forms.size() > 1)
		
		# Unequip button: visible when carrying items
		if unequip_btn:
			var held = unit.held_items if "held_items" in unit else []
			unequip_btn.visible = (held.size() > 0)
			
		# Dynamax button in modal
		if dynamax_btn:
			if unit.is_on_bench:
				dynamax_btn.visible = false
			elif MegaDatabase and MegaDatabase.current_dynamax_target == unit:
				dynamax_btn.visible = true
				dynamax_btn.text = "🔴 取消极巨"
				dynamax_btn.modulate = Color(1.0, 0.4, 0.5)
			else:
				dynamax_btn.visible = true
				if MegaDatabase and MegaDatabase.is_energy_full():
					dynamax_btn.text = "🔴 极巨化 [就绪]"
					dynamax_btn.modulate = Color(1.0, 0.9, 0.3)
				else:
					var cur_e = MegaDatabase.dynamax_energy if MegaDatabase else 0
					dynamax_btn.text = "⚡ 能量: %d%%" % cur_e
					dynamax_btn.modulate = Color(0.7, 0.8, 0.9)
	else:
		actions_hbox.visible = false

func _on_dynamax_pressed() -> void:
	var unit = target_unit_ref.get_ref() as Unit if target_unit_ref else null
	if unit == null or not is_instance_valid(unit):
		return
	if GameManager.current_phase != GameManager.Phase.PREPARATION:
		if GameManager.hud_ref and GameManager.hud_ref.has_method("show_toast"):
			GameManager.hud_ref.show_toast("⚠️ 只能在准备阶段激活极巨化！", Color(1.0, 0.4, 0.4))
		return
	if unit.is_on_bench:
		if GameManager.hud_ref and GameManager.hud_ref.has_method("show_toast"):
			GameManager.hud_ref.show_toast("⚠️ 备战席上的宝可梦无法极巨化！请先拖拽上阵", Color(1.0, 0.65, 0.3))
		return
		
	var target_name = PokemonDatabase.get_pokemon(unit.pokemon_id).get("name", unit.pokemon_id)
	if MegaDatabase and MegaDatabase.current_dynamax_target == unit:
		MegaDatabase.clear_dynamax()
		if GameManager.hud_ref and GameManager.hud_ref.has_method("show_toast"):
			GameManager.hud_ref.show_toast("已取消【%s】的本回合极巨化，能量已保留！" % target_name, Color(0.5, 0.85, 1.0))
		_refresh_display()
		return
		
	if MegaDatabase and not MegaDatabase.is_energy_full() and MegaDatabase.current_dynamax_target == null:
		if GameManager.hud_ref and GameManager.hud_ref.has_method("show_toast"):
			GameManager.hud_ref.show_toast("⚡ 极巨能量未满 (%d/%d)！无法激活" % [MegaDatabase.dynamax_energy, MegaDatabase.MAX_DYNAMAX_ENERGY], Color(1.0, 0.4, 0.4))
		return
		
	if MegaDatabase:
		MegaDatabase.set_dynamax_target(unit)
	unit.activate_dynamax()
	AudioManager.play_sfx("click")
	if GameManager.hud_ref and GameManager.hud_ref.has_method("show_toast"):
		GameManager.hud_ref.show_toast("🔴【%s】极巨化就绪！将在本回合战斗中以极巨形态出战！" % target_name, Color(1.0, 0.4, 0.6))
	_refresh_display()

func _on_sell_pressed() -> void:
	var unit = target_unit_ref.get_ref() as Unit if target_unit_ref else null
	if unit and is_instance_valid(unit) and GameManager.board_ref:
		GameManager.board_ref.sell_unit(unit)
	close()

func _on_switch_skill_pressed() -> void:
	var unit = target_unit_ref.get_ref() as Unit if target_unit_ref else null
	if unit and is_instance_valid(unit):
		GameManager.request_skill_choice(unit, unit.star_level)

func _on_switch_form_pressed() -> void:
	var unit = target_unit_ref.get_ref() as Unit if target_unit_ref else null
	if unit and is_instance_valid(unit):
		var chain_forms = PokemonDatabase.get_all_chain_forms(unit.pokemon_id)
		GameManager.request_evolution_choice(unit, chain_forms)

func _on_unequip_pressed() -> void:
	var unit = target_unit_ref.get_ref() as Unit if target_unit_ref else null
	if unit and is_instance_valid(unit) and not unit.is_enemy:
		while unit.held_items.size() > 0:
			var removed_id = unit.unequip_item_at(0)
			if removed_id != "":
				if GameManager.item_bench != null and GameManager.item_bench.has_method("add_item"):
					GameManager.item_bench.add_item(removed_id)
		AudioManager.play_sfx("click")
		_refresh_display()

func _preview_basic_attack() -> void:
	var unit = target_unit_ref.get_ref() as Unit if target_unit_ref else null
	if unit == null or not is_instance_valid(unit):
		return
	var b_info = unit.basic_attack_info
	var b_type = b_info.get("type", "physical")
	var b_sfx = b_info.get("sfx", "attack")
	var b_name = b_info.get("name", "普通攻击")
	
	# Icon lunge/recoil tween on icon_rect
	var orig_pos = icon_rect.position
	var tw = create_tween()
	if b_type == "physical":
		tw.tween_property(icon_rect, "position", orig_pos + Vector2(14, 0), 0.08)
		tw.tween_property(icon_rect, "position", orig_pos, 0.12)
	else:
		tw.tween_property(icon_rect, "position", orig_pos - Vector2(8, 0), 0.06)
		tw.tween_property(icon_rect, "position", orig_pos, 0.10)
		
	# Play SFX
	if b_sfx != "":
		AudioManager.play_sfx(b_sfx)
		
	# Temporary name feedback
	var old_text = name_label.text
	name_label.text = "【%s】演示普攻中..." % b_name
	var reset_t = get_tree().create_timer(1.0)
	reset_t.timeout.connect(func():
		if is_instance_valid(name_label) and visible:
			name_label.text = old_text
	)

func close() -> void:
	visible = false
	modulate.a = 1.0
	target_unit_ref = null
