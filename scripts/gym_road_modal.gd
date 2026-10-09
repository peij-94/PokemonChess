extends Panel

# GymRoadModal: Modal UI for the 8 Gym Battle Road tower climb and Badge Case.

@onready var close_btn: Button = $Dialog/Margin/VBox/Header/CloseBtn
@onready var bottom_close_btn: Button = $Dialog/Margin/VBox/Footer/BottomCloseBtn
@onready var badge_stats_label: Label = $Dialog/Margin/VBox/Header/BadgeStatsLabel
@onready var badge_list: HBoxContainer = $Dialog/Margin/VBox/BadgeCaseContainer/BadgeCaseVBox/BadgeList
@onready var gym_card_list: VBoxContainer = $Dialog/Margin/VBox/Scroll/GymCardList

var badge_slots: Array[PanelContainer] = []
var gym_cards: Array[PanelContainer] = []

func _ready() -> void:
	visible = false
	if close_btn:
		close_btn.pressed.connect(hide_modal)
	if bottom_close_btn:
		bottom_close_btn.pressed.connect(hide_modal)
		
	if GymRoadManager:
		if not GymRoadManager.badges_updated.is_connected(refresh_ui):
			GymRoadManager.badges_updated.connect(refresh_ui)
		if not GymRoadManager.gym_cleared.is_connected(_on_gym_cleared):
			GymRoadManager.gym_cleared.connect(_on_gym_cleared)
			
	_build_ui_elements()
	refresh_ui()

func open_modal() -> void:
	visible = true
	move_to_front()
	refresh_ui()

func hide_modal() -> void:
	visible = false
	if GameManager and GameManager.hud_ref:
		if "start_menu_modal" in GameManager.hud_ref and GameManager.hud_ref.start_menu_modal:
			if GameManager.hud_ref.start_menu_modal.visible and not GameManager.is_game_started:
				GameManager.hud_ref.start_menu_modal.move_to_front()

func _on_gym_cleared(_gym_index: int, _stars: int, _hp_left: int) -> void:
	refresh_ui()

func _build_ui_elements() -> void:
	if not GymRoadManager:
		return
		
	# 1. Build Badge Case Slots
	for c in badge_list.get_children():
		c.queue_free()
	badge_slots.clear()
	
	var gyms = GymRoadManager.get_all_gyms()
	for i in range(gyms.size()):
		var g = gyms[i]
		var slot = _create_badge_slot(g)
		badge_list.add_child(slot)
		badge_slots.append(slot)
		
	# 2. Build Gym Challenge Cards
	for c in gym_card_list.get_children():
		c.queue_free()
	gym_cards.clear()
	
	for i in range(gyms.size()):
		var g = gyms[i]
		var card = _create_gym_card(g)
		gym_card_list.add_child(card)
		gym_cards.append(card)

func _create_badge_slot(gym: Dictionary) -> PanelContainer:
	var slot = PanelContainer.new()
	slot.name = "BadgeSlot_%d" % int(gym.get("index", 0))
	slot.custom_minimum_size = Vector2(115, 80)
	slot.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	
	var sb = StyleBoxFlat.new()
	sb.corner_radius_top_left = 6
	sb.corner_radius_top_right = 6
	sb.corner_radius_bottom_right = 6
	sb.corner_radius_bottom_left = 6
	sb.content_margin_left = 6
	sb.content_margin_right = 6
	sb.content_margin_top = 6
	sb.content_margin_bottom = 6
	slot.add_theme_stylebox_override("panel", sb)
	
	var vbox = VBoxContainer.new()
	vbox.name = "VBox"
	vbox.alignment = BoxContainer.ALIGNMENT_CENTER
	vbox.add_theme_constant_override("separation", 2)
	slot.add_child(vbox)
	
	var icon_name_lbl = Label.new()
	icon_name_lbl.name = "IconNameLabel"
	icon_name_lbl.text = "%s %s" % [gym.get("badge_icon", "🏅"), gym.get("badge_name", "徽章")]
	icon_name_lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	icon_name_lbl.add_theme_font_size_override("font_size", 12)
	vbox.add_child(icon_name_lbl)
	
	var star_lbl = Label.new()
	star_lbl.name = "StarLabel"
	star_lbl.text = "☆☆☆"
	star_lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	star_lbl.add_theme_font_size_override("font_size", 13)
	vbox.add_child(star_lbl)
	
	var info_lbl = Label.new()
	info_lbl.name = "InfoLabel"
	info_lbl.text = "未解锁"
	info_lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	info_lbl.add_theme_font_size_override("font_size", 10)
	vbox.add_child(info_lbl)
	
	return slot

func _create_gym_card(gym: Dictionary) -> PanelContainer:
	var card = PanelContainer.new()
	var g_idx = int(gym.get("index", 0))
	card.name = "GymCard_%d" % g_idx
	card.custom_minimum_size = Vector2(0, 96)
	card.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	
	var sb = StyleBoxFlat.new()
	sb.bg_color = Color(0.09, 0.12, 0.17, 0.95)
	sb.border_color = Color(0.24, 0.35, 0.5, 0.8)
	sb.set_border_width_all(1)
	sb.corner_radius_top_left = 6
	sb.corner_radius_top_right = 6
	sb.corner_radius_bottom_right = 6
	sb.corner_radius_bottom_left = 6
	sb.content_margin_left = 12
	sb.content_margin_right = 12
	sb.content_margin_top = 8
	sb.content_margin_bottom = 8
	card.add_theme_stylebox_override("panel", sb)
	
	var hbox = HBoxContainer.new()
	hbox.name = "HBox"
	hbox.add_theme_constant_override("separation", 14)
	hbox.alignment = BoxContainer.ALIGNMENT_CENTER
	card.add_child(hbox)
	
	# Left: Ace Avatar Frame
	var avatar_box = VBoxContainer.new()
	avatar_box.name = "AvatarBox"
	avatar_box.custom_minimum_size = Vector2(72, 80)
	avatar_box.alignment = BoxContainer.ALIGNMENT_CENTER
	hbox.add_child(avatar_box)
	
	var tex_rect = TextureRect.new()
	tex_rect.name = "AvatarTexture"
	tex_rect.custom_minimum_size = Vector2(56, 56)
	tex_rect.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	tex_rect.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	tex_rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	tex_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	var ace_path = "res://assets/units/%s.png" % gym.get("ace_id", "pikachu")
	if ResourceLoader.exists(ace_path):
		tex_rect.texture = load(ace_path)
	avatar_box.add_child(tex_rect)
	
	var leader_lbl = Label.new()
	leader_lbl.name = "LeaderLabel"
	leader_lbl.text = gym.get("leader", "")
	leader_lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	leader_lbl.add_theme_font_size_override("font_size", 11)
	leader_lbl.add_theme_color_override("font_color", Color(0.9, 0.85, 0.7))
	avatar_box.add_child(leader_lbl)
	
	# Middle: Gym Details
	var info_vbox = VBoxContainer.new()
	info_vbox.name = "InfoVBox"
	info_vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	info_vbox.alignment = BoxContainer.ALIGNMENT_CENTER
	info_vbox.add_theme_constant_override("separation", 3)
	hbox.add_child(info_vbox)
	
	# Row 1: Title + Theme
	var title_row = HBoxContainer.new()
	title_row.add_theme_constant_override("separation", 10)
	info_vbox.add_child(title_row)
	
	var title_lbl = Label.new()
	title_lbl.name = "TitleLabel"
	title_lbl.text = "关卡 %d: %s" % [g_idx + 1, gym.get("name", "")]
	title_lbl.add_theme_font_size_override("font_size", 15)
	title_lbl.add_theme_color_override("font_color", Color(1.0, 0.9, 0.4))
	title_row.add_child(title_lbl)
	
	var theme_lbl = Label.new()
	theme_lbl.name = "ThemeLabel"
	theme_lbl.text = "【%s】 代表属性: %s" % [gym.get("title", ""), gym.get("type_name", "")]
	theme_lbl.add_theme_font_size_override("font_size", 12)
	theme_lbl.add_theme_color_override("font_color", Color(0.4, 0.8, 1.0))
	title_row.add_child(theme_lbl)
	
	var badge_tag = Label.new()
	badge_tag.name = "BadgeTag"
	badge_tag.text = "🏅 %s" % gym.get("badge_name", "")
	badge_tag.add_theme_font_size_override("font_size", 12)
	badge_tag.add_theme_color_override("font_color", gym.get("badge_color", Color(1, 1, 1)))
	title_row.add_child(badge_tag)
	
	# Row 2: Desc
	var desc_lbl = Label.new()
	desc_lbl.name = "DescLabel"
	desc_lbl.text = gym.get("desc", "")
	desc_lbl.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	desc_lbl.add_theme_font_size_override("font_size", 11)
	desc_lbl.add_theme_color_override("font_color", Color(0.72, 0.78, 0.85))
	info_vbox.add_child(desc_lbl)
	
	# Row 3: Lineup preview
	var lineup_lbl = Label.new()
	lineup_lbl.name = "LineupLabel"
	var lineup_parts: Array[String] = []
	for u in gym.get("lineup", []):
		var p_name = u.get("id", "")
		if PokemonDatabase and PokemonDatabase.pokemons.has(u.get("id", "")):
			p_name = PokemonDatabase.pokemons[u["id"]].get("name", u["id"])
		var star_str = "★%d" % u.get("star", 1)
		var boss_str = "[👑BOSS]" if u.get("is_boss", false) else ""
		lineup_parts.append("%s%s%s" % [boss_str, p_name, star_str])
	lineup_lbl.text = "⚔️ 敌方主力: " + "、".join(lineup_parts)
	lineup_lbl.add_theme_font_size_override("font_size", 11)
	lineup_lbl.add_theme_color_override("font_color", Color(0.95, 0.75, 0.4))
	info_vbox.add_child(lineup_lbl)
	
	# Row 4: Record
	var record_lbl = Label.new()
	record_lbl.name = "RecordLabel"
	record_lbl.text = "⭐ 挑战记录: 未通关"
	record_lbl.add_theme_font_size_override("font_size", 11)
	record_lbl.add_theme_color_override("font_color", Color(0.5, 0.75, 0.5))
	info_vbox.add_child(record_lbl)
	
	# Right: Action Button
	var btn_box = VBoxContainer.new()
	btn_box.alignment = BoxContainer.ALIGNMENT_CENTER
	hbox.add_child(btn_box)
	
	var challenge_btn = Button.new()
	challenge_btn.name = "ChallengeBtn"
	challenge_btn.text = "⚔️ 挑战道馆"
	challenge_btn.custom_minimum_size = Vector2(130, 42)
	challenge_btn.add_theme_font_size_override("font_size", 14)
	var b_style = StyleBoxFlat.new()
	b_style.bg_color = Color(0.18, 0.42, 0.75, 1.0)
	b_style.border_color = Color(0.4, 0.75, 1.0, 1.0)
	b_style.set_border_width_all(1)
	b_style.set_corner_radius_all(6)
	challenge_btn.add_theme_stylebox_override("normal", b_style)
	challenge_btn.pressed.connect(func(): _on_challenge_pressed(g_idx))
	btn_box.add_child(challenge_btn)
	
	return card

func refresh_ui() -> void:
	if not GymRoadManager:
		return
		
	var unlocked_count = GymRoadManager.get_total_unlocked_badges()
	var total_stars = GymRoadManager.get_total_stars()
	if badge_stats_label:
		badge_stats_label.text = "🏅 徽章收集: %d / 8  |  ⭐ 星级总览: %d / 24 ★" % [unlocked_count, total_stars]
		
	var gyms = GymRoadManager.get_all_gyms()
	
	# Update Badge Case Slots
	for i in range(badge_slots.size()):
		var slot = badge_slots[i]
		if not is_instance_valid(slot):
			continue
		var gym = gyms[i]
		var rec = GymRoadManager.get_badge_record(i)
		var is_unlocked = rec.get("unlocked", false)
		var best_stars = int(rec.get("best_stars", 0))
		var best_hp = int(rec.get("best_hp", 0))
		
		var sb = slot.get_theme_stylebox("panel") as StyleBoxFlat
		if not sb:
			sb = StyleBoxFlat.new()
			slot.add_theme_stylebox_override("panel", sb)
			
		var icon_lbl = slot.get_node_or_null("VBox/IconNameLabel") as Label
		var star_lbl = slot.get_node_or_null("VBox/StarLabel") as Label
		var info_lbl = slot.get_node_or_null("VBox/InfoLabel") as Label
		
		if is_unlocked:
			# Golden edge highlight
			sb.bg_color = Color(0.13, 0.17, 0.25, 0.98)
			sb.border_color = Color(1.0, 0.84, 0.22, 1.0)
			sb.border_width_left = 2
			sb.border_width_top = 2
			sb.border_width_right = 2
			sb.border_width_bottom = 2
			sb.shadow_size = 4
			sb.shadow_color = Color(1.0, 0.84, 0.22, 0.3)
			
			if icon_lbl:
				icon_lbl.text = "%s %s" % [gym.get("badge_icon", "🏅"), gym.get("badge_name", "")]
				icon_lbl.add_theme_color_override("font_color", gym.get("badge_color", Color(1, 0.9, 0.3)))
			if star_lbl:
				star_lbl.text = GymRoadManager.get_star_string(best_stars)
				star_lbl.add_theme_color_override("font_color", Color(1.0, 0.88, 0.2))
			if info_lbl:
				info_lbl.text = "剩余 %d HP" % best_hp
				info_lbl.add_theme_color_override("font_color", Color(0.4, 0.9, 0.6))
		else:
			# Grey locked style
			sb.bg_color = Color(0.08, 0.09, 0.12, 0.7)
			sb.border_color = Color(0.24, 0.28, 0.34, 0.6)
			sb.border_width_left = 1
			sb.border_width_top = 1
			sb.border_width_right = 1
			sb.border_width_bottom = 1
			sb.shadow_size = 0
			
			if icon_lbl:
				icon_lbl.text = "🔒 %s" % gym.get("badge_name", "")
				icon_lbl.add_theme_color_override("font_color", Color(0.45, 0.48, 0.52))
			if star_lbl:
				star_lbl.text = "☆☆☆"
				star_lbl.add_theme_color_override("font_color", Color(0.4, 0.42, 0.45))
			if info_lbl:
				info_lbl.text = "未解锁"
				info_lbl.add_theme_color_override("font_color", Color(0.45, 0.48, 0.52))

	# Update Gym Challenge Cards
	for i in range(gym_cards.size()):
		var card = gym_cards[i]
		if not is_instance_valid(card):
			continue
		var rec = GymRoadManager.get_badge_record(i)
		var is_unlocked = rec.get("unlocked", false)
		var best_stars = int(rec.get("best_stars", 0))
		var best_hp = int(rec.get("best_hp", 0))
		var clears = int(rec.get("cleared_count", 0))
		
		var record_lbl = card.get_node_or_null("HBox/InfoVBox/RecordLabel") as Label
		var challenge_btn = card.get_node_or_null("HBox/VBox/ChallengeBtn") as Button
		
		if record_lbl:
			if is_unlocked:
				record_lbl.text = "⭐ 最高评级: %s (%d/3星) | 最高剩余: %d HP | 通关次数: %d 次" % [
					GymRoadManager.get_star_string(best_stars), best_stars, best_hp, clears
				]
				record_lbl.add_theme_color_override("font_color", Color(0.4, 0.95, 0.55))
			else:
				record_lbl.text = "⭐ 挑战记录: 尚未攻克 (0/3星)"
				record_lbl.add_theme_color_override("font_color", Color(0.65, 0.7, 0.75))
				
		if challenge_btn:
			if is_unlocked:
				challenge_btn.text = "⚔️ 再次挑战"
			else:
				challenge_btn.text = "⚔️ 挑战道馆"

func _on_challenge_pressed(gym_index: int) -> void:
	if GameManager:
		GameManager.enter_gym_road_mode(gym_index)
	hide_modal()
