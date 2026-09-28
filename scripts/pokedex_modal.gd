extends Panel

# Pokédex Modal: Displays complete character encyclopedia, lore, stats, evolution chains, and branching skill details

@onready var backdrop: ColorRect = $Backdrop
@onready var close_btn: Button = $Dialog/Header/CloseBtn
@onready var list_container: GridContainer = $Dialog/HBox/LeftPanel/Scroll/GridContainer
@onready var filter_container: HBoxContainer = $Dialog/HBox/LeftPanel/FilterHBox

# Showcase nodes
@onready var icon_rect: TextureRect = $Dialog/HBox/RightPanel/HeaderHBox/IconRect
@onready var name_label: Label = $Dialog/HBox/RightPanel/HeaderHBox/VBox/NameLabel
@onready var title_label: Label = $Dialog/HBox/RightPanel/HeaderHBox/VBox/TitleLabel
@onready var cost_label: Label = $Dialog/HBox/RightPanel/HeaderHBox/VBox/CostLabel
@onready var types_hbox: HBoxContainer = $Dialog/HBox/RightPanel/HeaderHBox/VBox/TypesHBox
@onready var evo_chain_hbox: HBoxContainer = $Dialog/HBox/RightPanel/HeaderHBox/VBox/EvoChainHBox

@onready var desc_label: Label = $Dialog/HBox/RightPanel/DescCard/DescLabel
@onready var stats_grid: GridContainer = $Dialog/HBox/RightPanel/StatsCard/GridContainer

@onready var skill_title: Label = $Dialog/HBox/RightPanel/SkillCard/VBox/SkillTitle
@onready var basic_atk_btn: Button = $Dialog/HBox/RightPanel/SkillCard/VBox/StarTabs/BasicAtkBtn
@onready var star1_btn: Button = $Dialog/HBox/RightPanel/SkillCard/VBox/StarTabs/Star1Btn
@onready var star2_btn: Button = $Dialog/HBox/RightPanel/SkillCard/VBox/StarTabs/Star2Btn
@onready var star3_btn: Button = $Dialog/HBox/RightPanel/SkillCard/VBox/StarTabs/Star3Btn

@onready var branch_hbox: HBoxContainer = $Dialog/HBox/RightPanel/SkillCard/VBox/BranchHBox
@onready var branch1_btn: Button = $Dialog/HBox/RightPanel/SkillCard/VBox/BranchHBox/Branch1Btn
@onready var branch2_btn: Button = $Dialog/HBox/RightPanel/SkillCard/VBox/BranchHBox/Branch2Btn
@onready var branch3_btn: Button = $Dialog/HBox/RightPanel/SkillCard/VBox/BranchHBox/Branch3Btn
@onready var equipped_badge: Label = $Dialog/HBox/RightPanel/SkillCard/VBox/BranchHBox/EquippedBadge

@onready var skill_desc: Label = $Dialog/HBox/RightPanel/SkillCard/VBox/ContentHBox/SkillDesc
@onready var vfx_sprite: AnimatedSprite2D = $Dialog/HBox/RightPanel/SkillCard/VBox/ContentHBox/PreviewVBox/Frame/VFXSprite
@onready var play_btn: Button = $Dialog/HBox/RightPanel/SkillCard/VBox/ContentHBox/PreviewVBox/PlayBtn

var current_skill_star: int = 1
var current_branch_idx: int = 0
var branch_btns: Array[Button] = []

const POKEMON_SKILL_VFX = {
	"pikachu": {"vfx": "thunderbolt", "sfx": "thunder", "scale": 0.36, "offset": Vector2(0, 15)},
	"charmander": {"vfx": "flamethrower", "sfx": "fire", "scale": 0.34, "offset": Vector2.ZERO},
	"charmeleon": {"vfx": "flamethrower", "sfx": "fire", "scale": 0.34, "offset": Vector2.ZERO},
	"charizard": {"vfx": "flamethrower", "sfx": "fire", "scale": 0.34, "offset": Vector2.ZERO},
	"squirtle": {"vfx": "hydro_pump", "sfx": "water", "scale": 0.38, "offset": Vector2.ZERO},
	"wartortle": {"vfx": "hydro_pump", "sfx": "water", "scale": 0.38, "offset": Vector2.ZERO},
	"blastoise": {"vfx": "hydro_pump", "sfx": "water", "scale": 0.38, "offset": Vector2.ZERO},
	"gyarados": {"vfx": "hydro_pump", "sfx": "water", "scale": 0.38, "offset": Vector2.ZERO},
	"bulbasaur": {"vfx": "razor_leaf", "sfx": "skill", "scale": 0.45, "offset": Vector2.ZERO},
	"ivysaur": {"vfx": "razor_leaf", "sfx": "skill", "scale": 0.45, "offset": Vector2.ZERO},
	"venusaur": {"vfx": "solar_beam", "sfx": "skill", "scale": 0.50, "offset": Vector2.ZERO},
	"gengar": {"vfx": "shadow_ball", "sfx": "skill", "scale": 0.45, "offset": Vector2.ZERO},
	"machop": {"vfx": "body_slam", "sfx": "skill", "scale": 0.42, "offset": Vector2.ZERO},
	"machamp": {"vfx": "close_combat", "sfx": "skill", "scale": 0.45, "offset": Vector2.ZERO},
	"snorlax": {"vfx": "body_slam", "sfx": "skill", "scale": 0.42, "offset": Vector2.ZERO},
	"alakazam": {"vfx": "psystrike", "sfx": "skill", "scale": 0.44, "offset": Vector2.ZERO},
	"mewtwo": {"vfx": "psystrike", "sfx": "skill", "scale": 0.44, "offset": Vector2.ZERO},
	"dragonite": {"vfx": "draco_meteor", "sfx": "skill", "scale": 0.42, "offset": Vector2.ZERO},
	"eevee": {"vfx": "swift", "sfx": "swift", "scale": 0.42, "offset": Vector2.ZERO},
	"growlithe": {"vfx": "flame_wheel", "sfx": "fire", "scale": 0.42, "offset": Vector2.ZERO},
	"arcanine": {"vfx": "fire_blast", "sfx": "fire", "scale": 0.45, "offset": Vector2.ZERO},
	"psyduck": {"vfx": "zen_headbutt", "sfx": "skill", "scale": 0.42, "offset": Vector2.ZERO},
	"golduck": {"vfx": "hydro_pump", "sfx": "water", "scale": 0.42, "offset": Vector2.ZERO},
	"electabuzz": {"vfx": "discharge", "sfx": "discharge", "scale": 0.40, "offset": Vector2.ZERO},
	"lapras": {"vfx": "blizzard", "sfx": "blizzard", "scale": 0.40, "offset": Vector2.ZERO},
	"lucario": {"vfx": "aura_sphere", "sfx": "aura_sphere", "scale": 0.42, "offset": Vector2.ZERO}
}

const TIER_COLORS = {
	1: Color(0.55, 0.58, 0.65), # Gray
	2: Color(0.15, 0.75, 0.45), # Green
	3: Color(0.25, 0.55, 0.95), # Blue
	4: Color(0.70, 0.35, 0.95), # Purple
	5: Color(0.95, 0.70, 0.15)  # Gold
}

var current_cost_filter: int = 0 # 0 means all
var selected_id: String = "pikachu"
var filter_btns: Array[Button] = []
var pokemon_cards: Dictionary = {}

func _ready() -> void:
	close_btn.pressed.connect(hide_pokedex)
	
	basic_atk_btn.pressed.connect(func(): _on_basic_atk_tab_pressed())
	star1_btn.pressed.connect(func(): _on_star_tab_pressed(1))
	star2_btn.pressed.connect(func(): _on_star_tab_pressed(2))
	star3_btn.pressed.connect(func(): _on_star_tab_pressed(3))
	
	branch_btns = [branch1_btn, branch2_btn, branch3_btn]
	for i in range(branch_btns.size()):
		var idx = i
		branch_btns[idx].pressed.connect(func():
			_on_branch_btn_pressed(idx)
		)
		
	play_btn.pressed.connect(func():
		if current_skill_star == 0:
			play_basic_attack_vfx(selected_id, true)
		else:
			play_skill_vfx(selected_id, true, current_skill_star)
	)
	if not vfx_sprite.animation_finished.is_connected(_on_vfx_animation_finished):
		vfx_sprite.animation_finished.connect(_on_vfx_animation_finished)
	backdrop.gui_input.connect(func(event: InputEvent):
		if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			hide_pokedex()
	)
	build_filter_buttons()
	populate_pokemon_list()
	showcase_pokemon("pikachu")

func _input(event: InputEvent) -> void:
	if visible and event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_ESCAPE or event.keycode == KEY_P:
			hide_pokedex()
			get_viewport().set_input_as_handled()

func open_pokedex() -> void:
	visible = true
	z_index = 100
	move_to_front()
	AudioManager.play_sfx("click")
	# If a unit is selected on the battlefield or bench, showcase it directly!
	if GameManager.board_ref and GameManager.board_ref.selected_unit != null:
		var u = GameManager.board_ref.selected_unit
		var u_pid = u.pokemon_id
		var u_star = u.star_level
		var choices = PokemonDatabase.get_skill_choices(u_pid, u_star)
		var b_idx = 0
		var cur_sname = u.selected_skill.get("name", u.skill_name)
		for i in range(choices.size()):
			if choices[i].get("name", "") == cur_sname:
				b_idx = i
				break
		showcase_pokemon(u_pid, u_star, b_idx, false)
	else:
		showcase_pokemon(selected_id, current_skill_star, current_branch_idx, false)

func hide_pokedex() -> void:
	visible = false
	AudioManager.play_sfx("click")
	if GameManager.hud_ref and GameManager.hud_ref.start_menu_modal and GameManager.hud_ref.start_menu_modal.visible:
		GameManager.hud_ref.start_menu_modal.move_to_front()

func get_evolution_chain(pid: String) -> Array[String]:
	var root = PokemonDatabase.get_root_pokemon(pid)
	var chain: Array[String] = [root]
	var cur = root
	while true:
		var next_p = PokemonDatabase.get_next_evolution(cur)
		if next_p == "" or next_p == cur or chain.has(next_p):
			break
		chain.append(next_p)
		cur = next_p
	return chain

func _on_star_tab_pressed(target_star: int) -> void:
	AudioManager.play_sfx("click")
	current_skill_star = target_star
	current_branch_idx = 0
	update_skill_card(selected_id, target_star, true, 0)

func _on_branch_btn_pressed(idx: int) -> void:
	AudioManager.play_sfx("click")
	current_branch_idx = idx
	update_skill_card(selected_id, current_skill_star, true, idx)

func build_filter_buttons() -> void:
	for c in filter_container.get_children():
		filter_container.remove_child(c)
		c.queue_free()
	filter_btns.clear()
		
	var filters = [
		{"label": "全部", "cost": 0},
		{"label": "1费", "cost": 1},
		{"label": "2费", "cost": 2},
		{"label": "3费", "cost": 3},
		{"label": "4费", "cost": 4},
		{"label": "5费", "cost": 5}
	]
	
	for f in filters:
		var btn = Button.new()
		btn.text = f["label"]
		var cost_val = f["cost"]
		btn.pressed.connect(func():
			current_cost_filter = cost_val
			AudioManager.play_sfx("click")
			_update_filter_button_styles()
			populate_pokemon_list()
		)
		btn.custom_minimum_size = Vector2(48, 26)
		btn.add_theme_font_size_override("font_size", 12)
		filter_container.add_child(btn)
		filter_btns.append(btn)
	_update_filter_button_styles()

func _update_filter_button_styles() -> void:
	var costs = [0, 1, 2, 3, 4, 5]
	for i in range(filter_btns.size()):
		if i < costs.size():
			if costs[i] == current_cost_filter:
				filter_btns[i].modulate = Color(1.0, 0.85, 0.2)
			else:
				filter_btns[i].modulate = Color(0.8, 0.85, 0.9)

func populate_pokemon_list() -> void:
	for c in list_container.get_children():
		list_container.remove_child(c)
		c.queue_free()
	pokemon_cards.clear()
		
	for pid in PokemonDatabase.pokemons:
		var data = PokemonDatabase.pokemons[pid]
		if current_cost_filter != 0 and data["cost"] != current_cost_filter:
			continue
			
		var card = Button.new()
		card.custom_minimum_size = Vector2(90, 85)
		card.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
		
		var vbox = VBoxContainer.new()
		vbox.anchors_preset = Control.PRESET_FULL_RECT
		vbox.alignment = BoxContainer.ALIGNMENT_CENTER
		vbox.mouse_filter = Control.MOUSE_FILTER_IGNORE
		card.add_child(vbox)
		
		var icon = TextureRect.new()
		if ResourceLoader.exists(data["icon"]):
			icon.texture = load(data["icon"])
		icon.custom_minimum_size = Vector2(42, 42)
		icon.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		icon.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
		vbox.add_child(icon)
		
		var lbl = Label.new()
		var is_base = PokemonDatabase.is_base_form(pid)
		var evo_stage = PokemonDatabase.evolution_chains.get(pid, {}).get("stage", 1)
		if is_base:
			lbl.text = "%s (%dG)" % [data["name"], data["cost"]]
		else:
			lbl.text = "%s (★%d)" % [data["name"], evo_stage]
		lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		lbl.add_theme_font_size_override("font_size", 11)
		lbl.modulate = TIER_COLORS.get(data["cost"], Color.WHITE)
		vbox.add_child(lbl)
		
		card.pressed.connect(func():
			AudioManager.play_sfx("click")
			showcase_pokemon(pid, 1, 0, true)
		)
		list_container.add_child(card)
		pokemon_cards[pid] = card
		
	_update_card_highlights()

func _update_card_highlights() -> void:
	for pid in pokemon_cards:
		var card: Button = pokemon_cards[pid]
		if pid == selected_id:
			card.modulate = Color(1.2, 1.2, 1.2)
		else:
			card.modulate = Color(0.85, 0.85, 0.85)

func showcase_pokemon(pid: String, star: int = -1, branch_idx: int = 0, with_sound: bool = false) -> void:
	selected_id = pid
	if star != -1:
		current_skill_star = star
	current_branch_idx = branch_idx
	_update_card_highlights()
	
	var data = PokemonDatabase.get_pokemon(pid)
	if data.is_empty():
		return
		
	# 1. Header info
	if ResourceLoader.exists(data["icon"]):
		icon_rect.texture = load(data["icon"])
		
	var tier_col = TIER_COLORS.get(data["cost"], Color.WHITE)
	name_label.text = data["name"]
	name_label.modulate = tier_col
	title_label.text = "【%s】" % data.get("title", "宝可梦")
	
	var chain = get_evolution_chain(pid)
	var is_base = PokemonDatabase.is_base_form(pid)
	var stage = PokemonDatabase.evolution_chains.get(pid, {}).get("stage", 1)
	if is_base:
		if chain.size() > 1:
			cost_label.text = "招募费用: %d 金币 | 基础形态 (★1 可合成升级进化)" % data["cost"]
		else:
			cost_label.text = "招募费用: %d 金币 | 单阶段形态 (无进化)" % data["cost"]
	else:
		var root_pid = chain[0]
		var root_name = PokemonDatabase.pokemons.get(root_pid, {}).get("name", root_pid)
		cost_label.text = "进阶形态 (由 %s ★%d 升级进化)" % [root_name, stage]
	cost_label.modulate = Color(1.0, 0.85, 0.3)
	
	# Type badges
	for c in types_hbox.get_children():
		types_hbox.remove_child(c)
		c.queue_free()
	for t in data["types"]:
		var t_badge = HBoxContainer.new()
		var t_icon = TextureRect.new()
		var icon_path = "res://assets/ui/type_%s.png" % t.to_lower()
		if ResourceLoader.exists(icon_path):
			t_icon.texture = load(icon_path)
		t_icon.custom_minimum_size = Vector2(20, 20)
		t_icon.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		t_badge.add_child(t_icon)
		
		var t_lbl = Label.new()
		var syn_name = PokemonDatabase.synergies[t]["name"] if PokemonDatabase.synergies.has(t) else t
		t_lbl.text = syn_name
		t_lbl.add_theme_font_size_override("font_size", 12)
		t_badge.add_child(t_lbl)
		types_hbox.add_child(t_badge)
		
	# Evolution Chain UI
	_update_evolution_chain_ui(chain, pid)
	
	# Star tabs label updates based on evolution chain
	_update_star_tabs_labels(chain)
	
	# 2. Lore Description
	desc_label.text = data.get("desc", "强大的宝可梦，拥有独特的战斗技能与属性羁绊。")
	
	# 3. Base Stats
	for c in stats_grid.get_children():
		stats_grid.remove_child(c)
		c.queue_free()
		
	var stats = [
		{"name": "❤️ 基础生命", "val": str(data["hp"])},
		{"name": "⚔️ 基础攻击", "val": str(data["atk"])},
		{"name": "🛡️ 物理护甲", "val": str(data["armor"])},
		{"name": "🔮 魔法抗性", "val": str(data["mr"])},
		{"name": "🏹 攻击距离", "val": "%d 格 (%s)" % [data["range"], "近战" if data["range"] == 1 else "远程"]},
		{"name": "⚡ 攻击速度", "val": "%.2f 次/秒" % data["atk_speed"]}
	]
	
	for s in stats:
		var lbl_name = Label.new()
		lbl_name.text = s["name"] + ": "
		lbl_name.add_theme_font_size_override("font_size", 12)
		lbl_name.modulate = Color(0.75, 0.8, 0.9)
		stats_grid.add_child(lbl_name)
		
		var lbl_val = Label.new()
		lbl_val.text = s["val"]
		lbl_val.add_theme_font_size_override("font_size", 12)
		lbl_val.modulate = Color(1.0, 1.0, 1.0)
		stats_grid.add_child(lbl_val)
		
	# 4. Skill Details & Animated VFX Preview
	update_skill_card(pid, current_skill_star, with_sound, current_branch_idx)

func _update_evolution_chain_ui(chain: Array[String], active_pid: String) -> void:
	if not is_instance_valid(evo_chain_hbox):
		return
	for c in evo_chain_hbox.get_children():
		evo_chain_hbox.remove_child(c)
		c.queue_free()
		
	var header_lbl = Label.new()
	header_lbl.text = "🧬 进化链:"
	header_lbl.add_theme_font_size_override("font_size", 11)
	header_lbl.modulate = Color(0.95, 0.8, 0.35)
	evo_chain_hbox.add_child(header_lbl)
	
	if chain.size() <= 1:
		var single_lbl = Label.new()
		single_lbl.text = "单阶段 (无进化链)"
		single_lbl.add_theme_font_size_override("font_size", 11)
		single_lbl.modulate = Color(0.7, 0.75, 0.85)
		evo_chain_hbox.add_child(single_lbl)
		return
		
	for i in range(chain.size()):
		var c_pid = chain[i]
		var c_data = PokemonDatabase.get_pokemon(c_pid)
		var c_name = c_data.get("name", c_pid)
		var btn = Button.new()
		var stage_num = i + 1
		btn.text = "★%d %s" % [stage_num, c_name]
		btn.custom_minimum_size = Vector2(0, 22)
		btn.add_theme_font_size_override("font_size", 11)
		
		if c_pid == active_pid:
			btn.modulate = Color(1.3, 1.2, 0.3)
		else:
			btn.modulate = Color(0.8, 0.85, 0.95)
			
		btn.pressed.connect(func():
			AudioManager.play_sfx("click")
			showcase_pokemon(c_pid, stage_num, 0, true)
		)
		evo_chain_hbox.add_child(btn)
		
		if i < chain.size() - 1:
			var arrow_lbl = Label.new()
			arrow_lbl.text = "➔"
			arrow_lbl.add_theme_font_size_override("font_size", 11)
			arrow_lbl.modulate = Color(0.6, 0.65, 0.75)
			evo_chain_hbox.add_child(arrow_lbl)

func _update_star_tabs_labels(_chain: Array[String] = []) -> void:
	if is_instance_valid(basic_atk_btn):
		basic_atk_btn.text = "💥 普通攻击"
	if is_instance_valid(star1_btn):
		star1_btn.text = "★1 基础技能"
	if is_instance_valid(star2_btn):
		star2_btn.text = "★2 进阶技能"
	if is_instance_valid(star3_btn):
		star3_btn.text = "★3 终极技能"

func update_skill_card(pid: String, star: int, with_sound: bool = false, branch_idx: int = 0) -> void:
	current_skill_star = star
	current_branch_idx = branch_idx
	var data = PokemonDatabase.get_pokemon(pid)
	var skill_info = PokemonDatabase.get_skill_data(pid, star, branch_idx)
	var choices = PokemonDatabase.get_skill_choices(pid, star)
	
	# Update Branch buttons visibility and texts
	if is_instance_valid(branch_hbox):
		branch_hbox.visible = choices.size() > 0
		
	for i in range(branch_btns.size()):
		if i < choices.size():
			branch_btns[i].visible = true
			var b_data = choices[i]
			var b_name = b_data.get("name", "招式%d" % (i + 1))
			branch_btns[i].text = "招式 %d: %s" % [i + 1, b_name]
			if i == branch_idx:
				branch_btns[i].modulate = Color(1.3, 1.2, 0.4)
			else:
				branch_btns[i].modulate = Color(0.8, 0.85, 0.95)
		else:
			branch_btns[i].visible = false
			
	# Check if equipped on player's unit
	var is_equipped = false
	var active_skill_name = skill_info.get("name", "")
	if GameManager.board_ref and GameManager.board_ref.selected_unit != null:
		var u = GameManager.board_ref.selected_unit
		if u.pokemon_id == pid and u.star_level == star:
			var cur_sname = u.selected_skill.get("name", u.skill_name)
			if cur_sname == active_skill_name:
				is_equipped = true
				if is_instance_valid(equipped_badge):
					equipped_badge.text = "【✅ 选定角色已装备此招式】"
					
	if not is_equipped and GameManager.board_ref:
		var all_units = []
		if GameManager.board_ref.has_method("get_deployed_player_units") and "board_grid" in GameManager.board_ref and GameManager.board_ref.board_grid.size() > 0:
			all_units.append_array(GameManager.board_ref.get_deployed_player_units())
		if "bench_slots" in GameManager.board_ref:
			for b_u in GameManager.board_ref.bench_slots:
				if b_u != null and is_instance_valid(b_u):
					all_units.append(b_u)
		for u in all_units:
			if is_instance_valid(u) and u.pokemon_id == pid and u.star_level == star:
				var cur_sname = u.selected_skill.get("name", u.skill_name)
				if cur_sname == active_skill_name:
					is_equipped = true
					if is_instance_valid(equipped_badge):
						equipped_badge.text = "【✅ 阵容当前已装备】"
					break
					
	if is_instance_valid(equipped_badge):
		equipped_badge.visible = is_equipped
	
	var star_prefix = "★%d " % star
	if star == 1:
		star_prefix += "基础技能"
	elif star == 2:
		star_prefix += "进阶技能"
	else:
		star_prefix += "终极技能"
		
	var power = skill_info.get("power", data.get("skill_power", 0))
	var targets = skill_info.get("target_count", 1)
	var stun = skill_info.get("stun_duration", 0.0)
	var power_text = ""
	if power > 0:
		power_text += " | 威力: %d" % power
	if targets > 1:
		power_text += " (群攻: %d体)" % targets
	elif targets == 1:
		power_text += " (单体)"
	if stun > 0.0:
		power_text += " (眩晕: %.1fs)" % stun
		
	var s_name = skill_info.get("name", data.get("skill_name", ""))
	skill_title.text = "⚡ %s [招式 %d/3]: 【%s】 (消耗能量: %d%s)" % [
		star_prefix, branch_idx + 1, s_name, data.get("max_mana", 100), power_text
	]
	skill_title.modulate = Color(1.0, 0.9, 0.3) if star == 1 else (Color(0.4, 0.85, 1.0) if star == 2 else Color(1.0, 0.45, 0.2))
	
	# Rich formatted description with 3-skill overview
	var lines: Array[String] = []
	var detail_text = skill_info.get("detail", skill_info.get("desc", data.get("skill_desc", "")))
	lines.append("【当前选定招式详情】")
	lines.append("• 招式描述: %s" % detail_text)
	
	if choices.size() > 1:
		lines.append("")
		lines.append("📋 ★%d 可选招式一览 (升星时可在 3 招中自由选择其一):" % star)
		for i in range(choices.size()):
			var c_skill = choices[i]
			var c_name = c_skill.get("name", "招式%d" % (i + 1))
			var c_pow = c_skill.get("power", 0)
			var c_tgt = c_skill.get("target_count", 1)
			var c_st = c_skill.get("stun_duration", 0.0)
			var c_desc = c_skill.get("desc", "")
			var tgt_str = "单体" if c_tgt <= 1 else "群攻%d体" % c_tgt
			var st_str = " | 眩晕%.1fs" % c_st if c_st > 0.0 else ""
			var marker = "▶" if i == branch_idx else " "
			lines.append("%s [招式 %d] 【%s】 威力: %d (%s%s) - %s" % [marker, i + 1, c_name, c_pow, tgt_str, st_str, c_desc])
			
	skill_desc.text = "\n".join(lines)
	
	# Update tab buttons styling
	if is_instance_valid(basic_atk_btn):
		basic_atk_btn.modulate = Color(0.65, 0.7, 0.8)
	if is_instance_valid(star1_btn):
		star1_btn.modulate = Color(1.2, 1.1, 0.6) if star == 1 else Color(0.65, 0.7, 0.8)
	if is_instance_valid(star2_btn):
		star2_btn.modulate = Color(0.6, 1.1, 1.3) if star == 2 else Color(0.65, 0.7, 0.8)
	if is_instance_valid(star3_btn):
		star3_btn.modulate = Color(1.3, 0.6, 0.3) if star == 3 else Color(0.65, 0.7, 0.8)
		
	play_skill_vfx(pid, with_sound, star)

func _on_basic_atk_tab_pressed() -> void:
	AudioManager.play_sfx("click")
	current_skill_star = 0
	update_basic_attack_card(selected_id, true)

func update_basic_attack_card(pid: String, with_sound: bool = false) -> void:
	current_skill_star = 0
	var data = PokemonDatabase.get_pokemon(pid)
	var b_atk = PokemonDatabase.get_basic_attack(pid)
	var b_name = b_atk.get("name", "普通攻击")
	var b_type = b_atk.get("type", "physical")
	var b_style = b_atk.get("style", "tackle")
	var b_sfx = b_atk.get("sfx", "attack")
	var rng = data.get("range", 1)
	var rng_str = "%d格 (%s)" % [rng, "远程" if rng > 1 else "近战"]
	var type_str = "特殊法术" if b_type == "special" else "近战物理"
	
	if is_instance_valid(branch_hbox):
		branch_hbox.visible = false
	if is_instance_valid(equipped_badge):
		equipped_badge.visible = false
		
	if is_instance_valid(basic_atk_btn):
		basic_atk_btn.modulate = Color(1.3, 1.2, 0.3)
	if is_instance_valid(star1_btn):
		star1_btn.modulate = Color(0.65, 0.7, 0.8)
	if is_instance_valid(star2_btn):
		star2_btn.modulate = Color(0.65, 0.7, 0.8)
	if is_instance_valid(star3_btn):
		star3_btn.modulate = Color(0.65, 0.7, 0.8)
		
	skill_title.text = "💥 普通攻击: 【%s】 (%s / %s)" % [b_name, type_str, rng_str]
	skill_title.modulate = Color(1.0, 0.82, 0.3)
	
	var desc_str = "【%s】普通攻击动作演示：\n" % b_name
	desc_str += "• 伤害类型: %s | 攻击距离: %s\n" % [type_str, rng_str]
	desc_str += "• 攻击风格: %s | 打击音效: %s\n" % [b_style, b_sfx]
	if b_type == "physical":
		desc_str += "• 动作特征: 冲刺突进18px蓄势切击/重拳，命中目标造成微硬直受力后仰并弹性回位；暴击触发金红交叉斩光与震屏。"
	else:
		desc_str += "• 动作特征: 身体后仰凝聚元素魔力，承受后坐力后退射出二次贝塞尔抛物线弹道，附带密集彗星光芒拖尾与命中爆破。"
	skill_desc.text = desc_str
	
	play_basic_attack_vfx(pid, with_sound)

func play_basic_attack_vfx(pid: String, with_sound: bool = true) -> void:
	var b_atk = PokemonDatabase.get_basic_attack(pid)
	var b_type = b_atk.get("type", "physical")
	var b_sfx = b_atk.get("sfx", "attack")
	var sf = PokemonDatabase.get_sprite_frames(pid)
	if sf == null:
		return
		
	vfx_sprite.sprite_frames = sf
	vfx_sprite.scale = Vector2(0.85, 0.85)
	vfx_sprite.position = Vector2(65, 48)
	vfx_sprite.visible = true
	
	var anim_name = "attack_physical" if b_type == "physical" else "attack_special"
	if not sf.has_animation(anim_name):
		anim_name = "attack"
	if sf.has_animation(anim_name):
		vfx_sprite.play(anim_name)
		
	var tw = create_tween()
	if b_type == "physical":
		tw.tween_property(vfx_sprite, "position", Vector2(65 + 16, 48), 0.08)
		tw.tween_property(vfx_sprite, "position", Vector2(65, 48), 0.12)
	else:
		tw.tween_property(vfx_sprite, "position", Vector2(65 - 8, 48), 0.06)
		tw.tween_property(vfx_sprite, "position", Vector2(65, 48), 0.10)
		
	if with_sound and b_sfx != "":
		AudioManager.play_sfx(b_sfx)

func play_skill_vfx(pid: String, with_sound: bool = true, star: int = -1) -> void:
	if star == -1:
		star = current_skill_star
	if star == 0:
		play_basic_attack_vfx(pid, with_sound)
		return
	var skill_info = PokemonDatabase.get_skill_data(pid, star, current_branch_idx)
	var vfx_name = skill_info.get("vfx", "")
	var sfx_name = skill_info.get("sfx", "")
	var v_scale = skill_info.get("scale", 0.4)
	
	if vfx_name == "" and POKEMON_SKILL_VFX.has(pid):
		var info = POKEMON_SKILL_VFX[pid]
		vfx_name = info["vfx"]
		sfx_name = info["sfx"]
		v_scale = info["scale"]
		
	var sf = SkillVFX.get_skill_frames(vfx_name, 14.0)
	if sf == null or sf.get_frame_count("default") == 0:
		return
		
	vfx_sprite.sprite_frames = sf
	vfx_sprite.scale = Vector2(v_scale, v_scale)
	var offset = Vector2(0, 15) if vfx_name == "thunderbolt" else Vector2.ZERO
	vfx_sprite.position = Vector2(65, 48) + offset
	vfx_sprite.visible = true
	vfx_sprite.play("default")
	
	if with_sound and sfx_name != "":
		AudioManager.play_sfx(sfx_name)

func _on_vfx_animation_finished() -> void:
	if not visible:
		return
	# Auto-reloop smoothly after short 1.4s delay while looking at Pokédex
	var t = get_tree().create_timer(1.4)
	t.timeout.connect(func():
		if visible and is_instance_valid(vfx_sprite) and vfx_sprite.sprite_frames != null:
			if current_skill_star == 0:
				play_basic_attack_vfx(selected_id, false)
			else:
				vfx_sprite.play("default")
	)
