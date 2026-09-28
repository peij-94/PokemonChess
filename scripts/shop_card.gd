extends Control

# ShopCard: Displays single purchasable Pokemon in the shop

signal card_clicked(index: int)

var card_index: int = 0
var pokemon_id: String = ""

@onready var bg_panel: Panel = $Panel
@onready var icon_rect: TextureRect = $Panel/Icon
@onready var name_label: Label = $Panel/NameLabel
@onready var cost_label: Label = $Panel/CostLabel
@onready var types_container: HBoxContainer = $Panel/TypesContainer
@onready var skill_label: Label = $Panel/SkillLabel
@onready var buy_button: Button = $Panel/BuyButton

const TIER_COLORS = {
	1: Color(0.55, 0.58, 0.65), # Gray
	2: Color(0.15, 0.75, 0.45), # Green
	3: Color(0.25, 0.55, 0.95), # Blue
	4: Color(0.70, 0.35, 0.95), # Purple
	5: Color(0.95, 0.70, 0.15)  # Gold
}

func setup(p_id: String, p_index: int) -> void:
	card_index = p_index
	pokemon_id = p_id
	
	if not is_node_ready():
		await ready
		
	if pokemon_id == "":
		visible = false
		return
		
	visible = true
	var data = PokemonDatabase.get_pokemon(pokemon_id)
	if data.is_empty():
		visible = false
		return
		
	var cost = data.get("cost", 1)
	name_label.text = data.get("name", "")
	var is_deployed = GameManager.is_pokemon_deployed(pokemon_id)
	if is_deployed:
		cost_label.text = "%d 金币 [已上场 UP]" % cost
		cost_label.add_theme_color_override("font_color", Color(1.0, 0.92, 0.3))
	else:
		cost_label.text = "%d 金币" % cost
		cost_label.add_theme_color_override("font_color", Color(1.0, 0.8, 0.2))
	skill_label.text = data.get("skill_name", "")
	
	# Icon
	var icon_path = data.get("icon", "")
	if ResourceLoader.exists(icon_path):
		icon_rect.texture = load(icon_path)
		
	# Border color & Target Comp Highlight
	var tier_col = TIER_COLORS.get(cost, Color.WHITE)
	var style = bg_panel.get_theme_stylebox("panel").duplicate() as StyleBoxFlat
	
	var target_badge = bg_panel.get_node_or_null("TargetBadge") as Label
	if target_badge == null:
		target_badge = Label.new()
		target_badge.name = "TargetBadge"
		target_badge.offset_left = 6.0
		target_badge.offset_top = 4.0
		target_badge.offset_right = 76.0
		target_badge.offset_bottom = 18.0
		target_badge.add_theme_font_size_override("font_size", 9)
		bg_panel.add_child(target_badge)
		
	var is_target = GameManager.is_target_pokemon(pokemon_id)
	var owned_count = GameManager.board_ref.count_owned_pokemon(pokemon_id, 1) if GameManager.board_ref and GameManager.board_ref.has_method("count_owned_pokemon") else 0
	
	if style:
		if is_target:
			target_badge.text = "⭐阵容所需"
			target_badge.add_theme_color_override("font_color", Color(1.0, 0.9, 0.2))
			target_badge.visible = true
			style.border_color = Color(1.0, 0.85, 0.2)
			style.set_border_width_all(2)
		elif owned_count == 2:
			target_badge.text = "🔥升星关键"
			target_badge.add_theme_color_override("font_color", Color(1.0, 0.45, 0.3))
			target_badge.visible = true
			style.border_color = Color(1.0, 0.4, 0.3)
			style.set_border_width_all(2)
		else:
			target_badge.visible = false
			style.border_color = tier_col
			style.set_border_width_all(1)
		bg_panel.add_theme_stylebox_override("panel", style)
		
	# Type badges
	for c in types_container.get_children():
		c.queue_free()
	for t in data.get("types", []):
		var t_icon = TextureRect.new()
		var t_path = "res://assets/ui/type_%s.png" % t.to_lower()
		if ResourceLoader.exists(t_path):
			t_icon.texture = load(t_path)
		t_icon.custom_minimum_size = Vector2(18, 18)
		t_icon.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		types_container.add_child(t_icon)

func _on_buy_button_pressed() -> void:
	if pokemon_id != "":
		GameManager.buy_card(card_index)
