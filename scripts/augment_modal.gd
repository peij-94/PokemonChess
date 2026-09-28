extends Panel
class_name TrainerAugmentModal

# TrainerAugmentModal: 3-Choice Pokémon Trainer Augment (Rune) Selection Dialog
# Offers 3 cards framed in Silver, Gold, or Prismatic Pokémon badge styling.

signal augment_chosen(augment_id: String)

@onready var backdrop: ColorRect = $Backdrop
@onready var dialog: Panel = $Dialog
@onready var title_label: Label = $Dialog/Header/TitleLabel
@onready var subtitle_label: Label = $Dialog/Header/SubtitleLabel
@onready var close_btn: Button = $Dialog/Header/CloseBtn
@onready var cards_container: HBoxContainer = $Dialog/CardsContainer
@onready var hint_label: Label = $Dialog/Footer/HintLabel

var current_choices: Array[Dictionary] = []
var is_opened: bool = false

func _ready() -> void:
	visible = false
	if close_btn:
		close_btn.pressed.connect(close)

# Opens the modal dialog with the given 3 augment choices
func open_with_choices(augments: Array[Dictionary]) -> void:
	current_choices = augments.duplicate(true)
	_populate_cards()
	
	visible = true
	is_opened = true
	modulate.a = 0.0
	scale = Vector2(0.96, 0.96)
	pivot_offset = size * 0.5
	
	var tw = create_tween().set_parallel(true)
	tw.tween_property(self, "modulate:a", 1.0, 0.18).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tw.tween_property(self, "scale", Vector2.ONE, 0.22).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	
	if AudioManager:
		AudioManager.play_sfx("click")

# Opens with random choices from the database
func open_random(count: int = 3, tier: String = "") -> void:
	var choices = AugmentDatabase.get_random_augments(count, tier)
	open_with_choices(choices)

# Closes the modal
func close() -> void:
	if not visible:
		return
	is_opened = false
	
	var tw = create_tween().set_parallel(true)
	tw.tween_property(self, "modulate:a", 0.0, 0.12).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	tw.tween_property(self, "scale", Vector2(0.96, 0.96), 0.12)
	await tw.finished
	visible = false
	modulate.a = 1.0
	scale = Vector2.ONE

func _populate_cards() -> void:
	if not cards_container:
		return
		
	for child in cards_container.get_children():
		child.queue_free()
		
	for idx in range(current_choices.size()):
		var aug = current_choices[idx]
		var card = _create_augment_card(aug, idx)
		cards_container.add_child(card)

# Creates a richly stylized Pokémon badge framed augment card
func _create_augment_card(aug: Dictionary, idx: int) -> PanelContainer:
	var pc = PanelContainer.new()
	pc.custom_minimum_size = Vector2(280, 390)
	pc.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	pc.size_flags_vertical = Control.SIZE_EXPAND_FILL
	
	var tier = aug.get("tier", "silver").to_lower()
	var tier_name = AugmentDatabase.get_tier_name(tier)
	var tier_col = AugmentDatabase.get_tier_color(tier)
	var bg_col = AugmentDatabase.get_tier_bg_color(tier)
	
	# Tier-specific border and badge styling
	var style = StyleBoxFlat.new()
	style.bg_color = bg_col
	style.border_color = tier_col
	style.set_border_width_all(3)
	style.set_corner_radius_all(12)
	style.shadow_color = Color(tier_col.r, tier_col.g, tier_col.b, 0.25)
	style.shadow_size = 8
	pc.add_theme_stylebox_override("panel", style)
	
	var margin = MarginContainer.new()
	margin.name = "Margin"
	margin.add_theme_constant_override("margin_left", 14)
	margin.add_theme_constant_override("margin_right", 14)
	margin.add_theme_constant_override("margin_top", 14)
	margin.add_theme_constant_override("margin_bottom", 14)
	pc.add_child(margin)
	
	var vbox = VBoxContainer.new()
	vbox.name = "VBox"
	vbox.add_theme_constant_override("separation", 8)
	margin.add_child(vbox)
	
	# 1. Top Tier Badge Pill
	var tier_pill = PanelContainer.new()
	tier_pill.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	var pill_style = StyleBoxFlat.new()
	pill_style.bg_color = Color(tier_col.r * 0.25, tier_col.g * 0.25, tier_col.b * 0.25, 0.9)
	pill_style.border_color = tier_col
	pill_style.set_border_width_all(1)
	pill_style.set_corner_radius_all(10)
	pill_style.content_margin_left = 12
	pill_style.content_margin_right = 12
	pill_style.content_margin_top = 3
	pill_style.content_margin_bottom = 3
	tier_pill.add_theme_stylebox_override("panel", pill_style)
	
	var tier_pill_lbl = Label.new()
	var tier_emoji = "🥈 " if tier == "silver" else ("🥇 " if tier == "gold" else "💎 ")
	tier_pill_lbl.text = tier_emoji + tier_name
	tier_pill_lbl.add_theme_font_size_override("font_size", 12)
	tier_pill_lbl.add_theme_color_override("font_color", tier_col)
	tier_pill.add_child(tier_pill_lbl)
	vbox.add_child(tier_pill)
	
	# 2. Icon Emblem / Badge
	var icon_container = PanelContainer.new()
	icon_container.custom_minimum_size = Vector2(64, 64)
	icon_container.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	var icon_style = StyleBoxFlat.new()
	icon_style.bg_color = Color(0.05, 0.07, 0.10, 0.85)
	icon_style.border_color = Color(tier_col.r, tier_col.g, tier_col.b, 0.7)
	icon_style.set_border_width_all(2)
	icon_style.set_corner_radius_all(32)
	icon_container.add_theme_stylebox_override("panel", icon_style)
	
	var icon_lbl = Label.new()
	icon_lbl.text = aug.get("icon", "✨")
	icon_lbl.add_theme_font_size_override("font_size", 30)
	icon_lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	icon_lbl.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	icon_container.add_child(icon_lbl)
	vbox.add_child(icon_container)
	
	# 3. Augment Name Title
	var title_lbl = Label.new()
	title_lbl.name = "TitleLabel"
	title_lbl.text = aug.get("name", "神秘符文")
	title_lbl.add_theme_font_size_override("font_size", 17)
	title_lbl.add_theme_color_override("font_color", Color(1.0, 0.96, 0.9))
	title_lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	vbox.add_child(title_lbl)
	
	# 4. Category Tag
	var cat_key = aug.get("category", "combat")
	var cat_name = AugmentDatabase.get_category_name(cat_key)
	var cat_icon = AugmentDatabase.get_category_icon(cat_key)
	var cat_lbl = Label.new()
	cat_lbl.text = "%s %s" % [cat_icon, cat_name]
	cat_lbl.add_theme_font_size_override("font_size", 11)
	cat_lbl.add_theme_color_override("font_color", Color(0.7, 0.76, 0.85))
	cat_lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	vbox.add_child(cat_lbl)
	
	# 5. Separator
	var sep = HSeparator.new()
	sep.add_theme_color_override("separator_color", Color(tier_col.r, tier_col.g, tier_col.b, 0.35))
	vbox.add_child(sep)
	
	# 6. Concise Effect (Desc)
	var desc_lbl = Label.new()
	desc_lbl.text = aug.get("desc", "")
	desc_lbl.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	desc_lbl.add_theme_font_size_override("font_size", 13)
	desc_lbl.add_theme_color_override("font_color", tier_col)
	desc_lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	desc_lbl.custom_minimum_size = Vector2(0, 36)
	vbox.add_child(desc_lbl)
	
	# 7. Detailed Flavor / Rules (Detail)
	var detail_lbl = Label.new()
	detail_lbl.text = aug.get("detail", "")
	detail_lbl.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	detail_lbl.add_theme_font_size_override("font_size", 11)
	detail_lbl.add_theme_color_override("font_color", Color(0.82, 0.86, 0.92))
	detail_lbl.size_flags_vertical = Control.SIZE_EXPAND_FILL
	vbox.add_child(detail_lbl)
	
	# 8. Select Button
	var btn = Button.new()
	btn.name = "SelectBtn"
	btn.custom_minimum_size = Vector2(0, 38)
	btn.text = "选择强化"
	btn.add_theme_font_size_override("font_size", 13)
	
	var btn_style = StyleBoxFlat.new()
	btn_style.bg_color = Color(tier_col.r * 0.35, tier_col.g * 0.35, tier_col.b * 0.35, 1.0)
	btn_style.border_color = tier_col
	btn_style.set_border_width_all(1)
	btn_style.set_corner_radius_all(6)
	btn.add_theme_stylebox_override("normal", btn_style)
	
	var btn_hover = btn_style.duplicate() as StyleBoxFlat
	btn_hover.bg_color = Color(tier_col.r * 0.55, tier_col.g * 0.55, tier_col.b * 0.55, 1.0)
	btn.add_theme_stylebox_override("hover", btn_hover)
	
	var aug_id = aug.get("id", "")
	btn.pressed.connect(func(): _on_card_selected(aug_id))
	vbox.add_child(btn)
	
	return pc

func _on_card_selected(aug_id: String) -> void:
	if AudioManager:
		AudioManager.play_sfx("buy")
	AugmentDatabase.add_augment(aug_id)
	augment_chosen.emit(aug_id)
	close()
