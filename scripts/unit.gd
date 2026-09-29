extends Node2D
class_name Unit

signal unit_died(unit: Unit)
signal unit_clicked(unit: Unit)

const FLOATING_TEXT_SCENE = preload("res://scenes/floating_text.tscn")
const STUN_VFX_SCRIPT = preload("res://scripts/stun_vfx.gd")

# Configuration & Identity
var pokemon_id: String = "pikachu"
var star_level: int = 1
var is_enemy: bool = false
var is_on_bench: bool = false
var grid_coord: Vector2i = Vector2i(-1, -1)

# Base & Current Stats
var max_hp: float = 600.0
var current_hp: float = 600.0
var atk: float = 60.0
var armor: float = 20.0
var mr: float = 20.0
var attack_range: int = 2
var atk_speed: float = 0.75
var max_mana: float = 100.0
var current_mana: float = 0.0
var skill_name: String = ""
var skill_desc: String = ""
var skill_detail: String = ""
var skill_power: float = 200.0
var types: Array = []
var shield: float = 0.0
var selected_skill: Dictionary = {}
var has_unselected_upgrade: bool = false
var basic_attack_info: Dictionary = {}

# Item System
const MAX_HELD_ITEMS: int = 3
var held_items: Array[String] = []
var item_stats_cache: Dictionary = {}

# Combat State
var is_in_combat: bool = false
var is_dead: bool = false
var attack_timer: float = 0.0
var attack_count: int = 0
var target_unit: Unit = null
var is_stunned: bool = false
var stun_timer: float = 0.0
var burn_timer: float = 0.0
var burn_dps: float = 0.0
var stun_vfx: Node2D = null
var unit_3d: Unit3D = null

# Combat Metrics Tracking
var damage_dealt: float = 0.0
var damage_taken: float = 0.0
var healing_done: float = 0.0
var combat_time: float = 0.0

# Node references
@onready var icon_sprite: AnimatedSprite2D = $Icon
@onready var base_sprite: Sprite2D = $BasePlate
@onready var shadow_node: Sprite2D = $Shadow
@onready var click_ring: Node2D = $ClickRing
@onready var click_particles: CPUParticles2D = $ClickParticles
@onready var hp_bar: ProgressBar = $UIOverlay/HPBar
@onready var mana_bar: ProgressBar = $UIOverlay/ManaBar
@onready var name_label: Label = $UIOverlay/NameLabel
@onready var star_container: HBoxContainer = $UIOverlay/StarContainer
@onready var particles: CPUParticles2D = $CastParticles

var base_icon_scale: Vector2 = Vector2.ONE
var click_tween: Tween = null

const TYPE_COLORS: Dictionary = {
	"Electric": Color(1.0, 0.9, 0.2),
	"Fire": Color(1.0, 0.45, 0.15),
	"Water": Color(0.25, 0.75, 1.0),
	"Grass": Color(0.35, 0.9, 0.4),
	"Psychic": Color(0.95, 0.35, 0.85),
	"Ghost": Color(0.75, 0.4, 1.0),
	"Fighting": Color(1.0, 0.6, 0.25),
	"Dragon": Color(0.4, 0.6, 1.0),
	"Normal": Color(0.95, 0.95, 1.0)
}

const REACTION_EMOJIS: Array[String] = ["♪", "★", "✨", "♥", "⚡"]

func _ready() -> void:
	if not icon_sprite.animation_finished.is_connected(_on_animation_finished):
		icon_sprite.animation_finished.connect(_on_animation_finished)
	if stun_vfx == null:
		stun_vfx = STUN_VFX_SCRIPT.new()
		stun_vfx.position = Vector2(0, -32)
		add_child(stun_vfx)

func _on_animation_finished() -> void:
	if is_dead:
		return
	if icon_sprite.animation == "attack" or icon_sprite.animation == "hurt":
		icon_sprite.play("idle")

func transform_to_evolution(new_id: String, new_star: int) -> void:
	var old_id = pokemon_id
	pokemon_id = new_id
	star_level = new_star
	if new_id != old_id:
		selected_skill = {}
	setup(new_id, new_star, is_enemy)
	var data = PokemonDatabase.get_pokemon(new_id)
	var p_name = data.get("name", new_id)
	if new_id != old_id:
		spawn_floating_text("进化! %s ★%d" % [p_name, new_star], Color(1.0, 0.85, 0.2), true)
	else:
		spawn_floating_text("升级! ★%d" % new_star, Color(1.0, 0.9, 0.2), true)

func switch_evolution_form(new_id: String) -> void:
	if new_id == pokemon_id:
		return
	pokemon_id = new_id
	selected_skill = {}
	setup(new_id, star_level, is_enemy)
	var data = PokemonDatabase.get_pokemon(new_id)
	var p_name = data.get("name", new_id)
	spawn_floating_text("形态切换: %s (★%d)" % [p_name, star_level], Color(0.4, 0.9, 1.0), true)

func setup(p_id: String, p_star: int = 1, p_is_enemy: bool = false) -> void:
	pokemon_id = p_id
	star_level = p_star
	is_enemy = p_is_enemy
	
	var data = PokemonDatabase.get_pokemon(p_id)
	if data.is_empty():
		push_error("Unknown pokemon ID: " + p_id)
		return
		
	var mult = pow(1.8, star_level - 1)
	max_hp = data["hp"] * mult
	# Apply Water synergy bonus if player unit
	if not is_enemy:
		max_hp += SynergyManager.get_water_hp_bonus(is_enemy)
	current_hp = max_hp
	
	atk = data["atk"] * mult
	armor = data["armor"]
	mr = data["mr"]
	attack_range = data["range"]
	atk_speed = data["atk_speed"]
	# Apply Fire synergy attack speed bonus
	if not is_enemy:
		atk_speed += atk_speed * SynergyManager.get_fire_atk_speed_bonus(is_enemy)
		
	max_mana = data["max_mana"]
	current_mana = 0.0
	
	basic_attack_info = PokemonDatabase.get_basic_attack(pokemon_id)
	
	if selected_skill.is_empty():
		selected_skill = PokemonDatabase.get_skill_data(pokemon_id, star_level, 0)
		has_unselected_upgrade = false
	else:
		# Player upgraded star level! Retain existing skill from previous star level unless player chooses new one
		has_unselected_upgrade = true
		
	skill_name = selected_skill.get("name", data.get("skill_name", ""))
	skill_desc = selected_skill.get("desc", data.get("skill_desc", ""))
	skill_detail = selected_skill.get("detail", data.get("skill_detail", ""))
	skill_power = selected_skill.get("power", data.get("skill_power", 200))
	types = data["types"].duplicate()
	
	# Apply Fighting synergy bonus
	if not is_enemy and types.has("Fighting"):
		atk += SynergyManager.get_fighting_atk_bonus(is_enemy)
	# Apply Bug synergy attack speed bonus
	if not is_enemy and types.has("Bug"):
		atk_speed += atk_speed * SynergyManager.get_bug_atk_speed_bonus(is_enemy)
	# Apply Ground synergy armor bonus
	if not is_enemy and types.has("Ground"):
		armor += SynergyManager.get_ground_armor_bonus(is_enemy)
	# Apply Electric team attack speed bonus
	if not is_enemy:
		atk_speed += atk_speed * SynergyManager.get_electric_team_atk_speed(is_enemy)
	# Apply Rock team shield bonus
	if not is_enemy:
		var rock_shield = SynergyManager.get_rock_shield_bonus(is_enemy)
		if rock_shield > 0:
			shield += rock_shield
			
	# Apply Arena Environment Modifiers
	if not is_enemy:
		if GameManager.has_arena_modifier("hp_bonus"):
			max_hp += GameManager.get_arena_modifier_val("hp_bonus")
			current_hp = max_hp
		if GameManager.has_arena_modifier("atk_speed"):
			atk_speed += atk_speed * GameManager.get_arena_modifier_val("atk_speed")
		if GameManager.has_arena_modifier("armor_debuff"):
			armor = max(0.0, armor + GameManager.get_arena_modifier_val("armor_debuff"))
		if (types.has("Water") or types.has("Ice")) and GameManager.has_arena_modifier("ice_shield"):
			shield += GameManager.get_arena_modifier_val("ice_shield")

	_apply_item_stats()
	
	if not is_node_ready():
		await ready
		
	update_visuals(data)

func select_skill(skill_dict: Dictionary) -> void:
	if skill_dict.is_empty():
		return
	selected_skill = skill_dict.duplicate(true)
	has_unselected_upgrade = false
	skill_name = selected_skill.get("name", "")
	skill_desc = selected_skill.get("desc", "")
	skill_detail = selected_skill.get("detail", "")
	skill_power = selected_skill.get("power", 200.0)
	spawn_floating_text("已学习: " + skill_name, Color(1.0, 0.9, 0.3), true)
	AudioManager.play_sfx("click")

func update_visuals(data: Dictionary) -> void:
	name_label.text = data["name"]
	
	# Load animation frames from PokemonDatabase
	var sf = PokemonDatabase.get_sprite_frames(pokemon_id)
	icon_sprite.sprite_frames = sf
	icon_sprite.play("idle")
	
	# Scale animation sprite nicely to fit tile (~52x52 for rich 3D model volume)
	if sf.has_animation("idle") and sf.get_frame_count("idle") > 0:
		var tex = sf.get_frame_texture("idle", 0)
		if tex:
			var tex_size = tex.get_size()
			if tex_size.x > 0 and tex_size.y > 0:
				var target_sz = 68.0
				var max_dim = max(tex_size.x, tex_size.y)
				var s = target_sz / max_dim
				base_icon_scale = Vector2(s, s)
				icon_sprite.scale = base_icon_scale
				
	# Apply 2.5D Volumetric Relief & Dynamic Rim Lighting Shader
	if icon_sprite.material == null and ResourceLoader.exists("res://shaders/unit_3d_relief.gdshader"):
		var mat = ShaderMaterial.new()
		mat.shader = load("res://shaders/unit_3d_relief.gdshader")
		icon_sprite.material = mat
	
	# Star badges
	for c in star_container.get_children():
		c.queue_free()
	for i in range(star_level):
		var star = TextureRect.new()
		star.texture = load("res://assets/ui/star_badge.png")
		star.custom_minimum_size = Vector2(16, 16)
		star.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		star_container.add_child(star)
		
	# No grid plate around unit - clean 3D look with soft contact shadow
	base_sprite.visible = false
	if has_node("Shadow"):
		var shadow_node = get_node("Shadow")
		shadow_node.position = Vector2(0, 18)
		shadow_node.scale = Vector2(0.95, 0.75)
	if is_enemy:
		hp_bar.modulate = Color(0.95, 0.3, 0.3)
	else:
		hp_bar.modulate = Color(0.3, 0.85, 0.4)
		
	update_bars()
	_sync_unit_3d(data)

func _sync_unit_3d(data: Dictionary = {}) -> void:
	if not GameManager.has_meta("arena_3d"):
		return
	var arena_3d: Arena3D = GameManager.get_meta("arena_3d")
	if arena_3d == null or not is_instance_valid(arena_3d):
		return
	if unit_3d == null or not is_instance_valid(unit_3d):
		unit_3d = preload("res://scenes/unit_3d.tscn").instantiate() as Unit3D
		if arena_3d.units_container:
			arena_3d.units_container.add_child(unit_3d)
	
	unit_3d.position = arena_3d.pos_2d_to_3d(position, is_on_bench)
	var p_name = data.get("name", name_label.text if name_label else pokemon_id)
	unit_3d.setup_visuals(pokemon_id, star_level, is_enemy, p_name)
	unit_3d.update_bars(current_hp, max_hp, current_mana, max_mana)
	
	# In 3D mode, the 3D unit provides visuals while 2D Area2D provides interaction
	if icon_sprite:
		icon_sprite.visible = false
		icon_sprite.modulate.a = 0.0
	if base_sprite:
		base_sprite.visible = false
	if has_node("Shadow"):
		get_node("Shadow").visible = false
	if has_node("UIOverlay"):
		get_node("UIOverlay").visible = false
	if has_node("CastParticles"):
		get_node("CastParticles").visible = false
	if has_node("ClickRing"):
		get_node("ClickRing").visible = false
	if has_node("ClickParticles"):
		get_node("ClickParticles").visible = false

func _exit_tree() -> void:
	if unit_3d and is_instance_valid(unit_3d):
		unit_3d.queue_free()
		unit_3d = null

func update_bars() -> void:
	if hp_bar:
		hp_bar.max_value = max_hp
		hp_bar.value = current_hp
	if mana_bar:
		mana_bar.max_value = max_mana
		mana_bar.value = current_mana
	if unit_3d and is_instance_valid(unit_3d):
		unit_3d.update_bars(current_hp, max_hp, current_mana, max_mana)

func _process(delta: float) -> void:
	# Synchronize 3D unit position with 2D position (dragging, bench, combat movement)
	if unit_3d == null and GameManager.has_meta("arena_3d") and not is_dead:
		var p_data = PokemonDatabase.get_pokemon(pokemon_id)
		_sync_unit_3d(p_data)

	if unit_3d and is_instance_valid(unit_3d):
		if icon_sprite and icon_sprite.visible:
			icon_sprite.visible = false
		if has_node("Shadow") and get_node("Shadow").visible:
			get_node("Shadow").visible = false
		if has_node("UIOverlay") and get_node("UIOverlay").visible:
			get_node("UIOverlay").visible = false
		if base_sprite and base_sprite.visible:
			base_sprite.visible = false
		if not unit_3d.is_animating_action:
			var a3d: Arena3D = GameManager.get_meta("arena_3d", null) if GameManager.has_meta("arena_3d") else null
			if a3d:
				var target_3d = a3d.pos_2d_to_3d(position, is_on_bench)
				if unit_3d.is_dragged or unit_3d.drag_elevation > 0.001:
					target_3d.y = unit_3d.drag_elevation
					unit_3d.update_drag_motion(target_3d)
				unit_3d.position = target_3d

	if is_dead or not is_in_combat:
		return
		
	combat_time += delta
		
	# Mana Glow: Pulsating aura when mana reaches >= 80% (Ultimate Readiness)
	if icon_sprite and icon_sprite.material is ShaderMaterial:
		var smat = icon_sprite.material as ShaderMaterial
		if current_mana >= max_mana * 0.8:
			var prim_type = types[0] if not types.is_empty() else "Normal"
			var glow_col = TypeSystem.get_type_color(prim_type) if TypeSystem else Color(0.3, 0.75, 1.0)
			var pulse = 0.55 + sin(Time.get_ticks_msec() * 0.007) * 0.35
			smat.set_shader_parameter("mana_glow", pulse)
			smat.set_shader_parameter("mana_glow_color", glow_col)
		else:
			smat.set_shader_parameter("mana_glow", 0.0)
		
	# Stun handling
	if is_stunned:
		stun_timer -= delta
		if stun_timer <= 0.0:
			is_stunned = false
			icon_sprite.rotation = 0.0
			if stun_vfx:
				stun_vfx.stop_stun()
		else:
			# Dizzy sway wobble
			icon_sprite.rotation = sin(stun_timer * 9.0) * 0.12
		return
		
	# Water regen synergy
	if not is_enemy:
		var regen_ratio = SynergyManager.get_water_regen_ratio(is_enemy)
		if regen_ratio > 0:
			heal(max_hp * regen_ratio * delta, false)
			
	# Emerald Arena: Dragon & Grass HP Regen
	if not is_enemy and (types.has("Grass") or types.has("Dragon")):
		if GameManager.has_arena_modifier("dragon_regen"):
			var d_regen = GameManager.get_arena_modifier_val("dragon_regen")
			heal(max_hp * d_regen * delta, false)
			
	# Glacier Arena: Blizzard Freeze at 15s in combat
	if is_enemy and GameManager.has_arena_modifier("blizzard_freeze"):
		if not has_meta("blizzard_frozen"):
			var elapsed = GameManager.COMBAT_MAX_TIME - GameManager.phase_timer
			if elapsed >= 15.0:
				set_meta("blizzard_frozen", true)
				apply_stun(GameManager.get_arena_modifier_val("blizzard_freeze"))
				spawn_floating_text("绝对零度!", Color(0.3, 0.8, 1.0), true)
			
	# Burn damage ticking
	if burn_timer > 0.0:
		burn_timer -= delta
		take_damage(burn_dps * delta, true, false, false)
		
	# Attack timer
	if attack_timer > 0.0:
		attack_timer -= delta
		
	# Combat AI loop
	run_combat_ai(delta)

func run_combat_ai(delta: float) -> void:
	# Check target validity
	if target_unit == null or not is_instance_valid(target_unit) or target_unit.is_dead:
		target_unit = find_closest_enemy()
		if target_unit == null:
			if icon_sprite.animation != "idle" and icon_sprite.animation != "attack":
				icon_sprite.play("idle")
			return # No enemies left!
			
	var dist_pixels = position.distance_to(target_unit.position)
	# 64 pixels per board tile
	var tile_dist = dist_pixels / 64.0
	var dir = (target_unit.position - position).normalized()
	
	# Flip sprite towards enemy
	if abs(dir.x) > 0.05:
		icon_sprite.flip_h = (dir.x < 0)
		if unit_3d and is_instance_valid(unit_3d) and unit_3d.sprite:
			unit_3d.sprite.flip_h = (dir.x < 0)
	
	if tile_dist <= attack_range + 0.4:
		# In attack range!
		if current_mana >= max_mana:
			cast_skill()
		elif attack_timer <= 0.0:
			perform_attack(target_unit)
			attack_timer = 1.0 / max(0.4, atk_speed)
		else:
			# Standing in range waiting for next attack
			if icon_sprite.animation != "attack" and icon_sprite.animation != "hurt":
				if icon_sprite.animation != "idle":
					icon_sprite.play("idle")
			if unit_3d and is_instance_valid(unit_3d) and not unit_3d.is_animating_action:
				unit_3d.play_animation("idle")
	else:
		# Move towards enemy
		var move_speed = 135.0
		position += dir * move_speed * delta
		if icon_sprite.animation != "attack" and icon_sprite.animation != "hurt":
			if icon_sprite.animation != "walk":
				icon_sprite.play("walk")
		if unit_3d and is_instance_valid(unit_3d) and not unit_3d.is_animating_action:
			unit_3d.play_animation("walk")

func find_closest_enemy() -> Unit:
	var potential_targets = get_tree().get_nodes_in_group("units")
	var closest: Unit = null
	var min_dist: float = 999999.0
	
	for node in potential_targets:
		var u = node as Unit
		if u == null or u == self or u.is_dead or u.is_on_bench:
			continue
		if u.is_enemy != self.is_enemy:
			var d = position.distance_to(u.position)
			if d < min_dist:
				min_dist = d
				closest = u
	return closest

func get_melee_attack_style() -> String:
	if basic_attack_info.has("style") and basic_attack_info["style"] != "":
		return basic_attack_info["style"]
	match pokemon_id:
		"lucario", "gengar", "scyther", "sandslash":
			return "slash"
		"gyarados", "growlithe", "arbok", "ekans":
			return "bite"
		"squirtle":
			return "water_bash"
		"charizard":
			return "slash"
		"machop", "snorlax", "electabuzz":
			return "punch"
		_:
			return "tackle"

func perform_attack(target: Unit) -> void:
	if target == null or target.is_dead:
		return
		
	attack_count += 1
	var is_combo = (attack_count % 3 == 0)
	
	if unit_3d and is_instance_valid(unit_3d):
		var target_3d_pos = target.unit_3d.position if (target and target.unit_3d and is_instance_valid(target.unit_3d)) else unit_3d.position + Vector3(0, 0, -1.0)
		unit_3d.perform_3d_attack_leap(target_3d_pos)
	
	# Play attack animation based on basic_attack type
	var atk_type = basic_attack_info.get("type", "special" if attack_range >= 2 else "physical")
	if atk_type == "physical":
		if icon_sprite.sprite_frames and icon_sprite.sprite_frames.has_animation("attack_physical"):
			icon_sprite.play("attack_physical")
		else:
			icon_sprite.play("attack")
	else:
		if icon_sprite.sprite_frames and icon_sprite.sprite_frames.has_animation("attack_special"):
			icon_sprite.play("attack_special")
		else:
			icon_sprite.play("attack")
	
	var dir = (target.position - position).normalized()
	if abs(dir.x) > 0.05:
		icon_sprite.flip_h = (dir.x < 0)
		
	# Damage calculation with Fighting synergy, Arena Modifiers & 3-Hit Combo
	var crit_chance = 0.20 + get_item_stat_bonus("crit")
	var crit_mult = 1.75
	if has_held_item("infinity_blade"):
		crit_mult = 2.20
	if not is_enemy and types.has("Fighting"):
		crit_chance += SynergyManager.get_fighting_crit_bonus(is_enemy)
		if SynergyManager.active_tiers.get("Fighting", 0) >= 2:
			crit_mult = 2.15
	if not is_enemy and GameManager.has_arena_modifier("crit_chance"):
		crit_chance += GameManager.get_arena_modifier_val("crit_chance")
	var is_crit = (randf() < crit_chance) or (is_combo and pokemon_id == "machop")
	var damage = atk
	if has_held_item("expert_belt") and target and target.current_hp / max(1.0, target.max_hp) >= 0.60:
		damage *= 1.25
	if is_crit:
		damage *= crit_mult
		if types.has("Fire") and not is_enemy and GameManager.has_arena_modifier("fire_crit_amp"):
			damage *= (1.0 + GameManager.get_arena_modifier_val("fire_crit_amp"))
	if not is_enemy and GameManager.has_arena_modifier("last_stand"):
		if GameManager.board_ref and GameManager.board_ref.count_player_units_on_board() < 3:
			damage *= (1.0 + GameManager.get_arena_modifier_val("last_stand"))
	if is_combo:
		damage *= 1.25
		spawn_floating_text("3连击!", Color(1.0, 0.85, 0.2), true, 0.4)
		
	var parent_node = get_parent() as Node2D
	if parent_node == null:
		parent_node = self
		
	if attack_range >= 2:
		# --- RANGED ATTACK ---
		var tw = create_tween()
		tw.tween_property(icon_sprite, "position", dir * 8.0, 0.06)
		tw.tween_property(icon_sprite, "position", Vector2.ZERO, 0.08)
		
		# Play ranged launch sound
		var b_sfx = basic_attack_info.get("sfx", "")
		if b_sfx != "":
			AudioManager.play_sfx(b_sfx, randf_range(1.1, 1.3), -2.0)
		else:
			match pokemon_id:
				"pikachu":
					AudioManager.play_sfx("spark", 1.2, -2.0)
				"charmander", "charizard":
					AudioManager.play_sfx("fire", 1.3, -4.0)
				"lapras", "psyduck":
					AudioManager.play_sfx("water", 1.3, -4.0)
				"eevee":
					AudioManager.play_sfx("swift", 1.3, -4.0)
				_:
					AudioManager.play_sfx("attack", randf_range(1.0, 1.2), -3.0)
				
		var shooter_ref = weakref(self)
		var target_ref = weakref(target)
		var attacker_pid = pokemon_id
		var custom_style = basic_attack_info.get("style", "")
		AttackVFX.spawn_ranged_projectile(parent_node, position, target, pokemon_id, is_combo, func():
			var tgt = target_ref.get_ref() as Unit
			if tgt != null and is_instance_valid(tgt) and not tgt.is_dead:
				var shooter = shooter_ref.get_ref() as Unit
				if shooter != null and is_instance_valid(shooter) and not shooter.is_dead:
					shooter._apply_attack_damage_and_passives(tgt, damage, is_crit, is_combo)
				else:
					var is_true_damage = (is_combo and attacker_pid == "lucario")
					tgt.take_damage(damage, is_true_damage, is_crit)
		, custom_style)
	else:
		# --- MELEE ATTACK ---
		var lunge_dist = 22.0 if is_combo else 15.0
		var style = get_melee_attack_style()
		
		var tw = create_tween()
		tw.tween_property(icon_sprite, "position", dir * lunge_dist, 0.07)
		tw.tween_callback(func():
			if is_instance_valid(target) and not target.is_dead:
				AttackVFX.spawn_melee_attack_vfx(parent_node, position, target, style, is_combo)
				_apply_attack_damage_and_passives(target, damage, is_crit, is_combo)
				# Sound on impact
				match style:
					"slash":
						AudioManager.play_sfx("slash", randf_range(1.05, 1.25), -2.0)
					"punch":
						AudioManager.play_sfx("punch", randf_range(0.95, 1.15), -2.0)
					"bite":
						AudioManager.play_sfx("slash", 0.85, -2.0)
					"tackle":
						AudioManager.play_sfx("attack", randf_range(1.1, 1.25), -2.0)
					_:
						AudioManager.play_sfx("attack", 1.1, -3.0)
		)
		tw.tween_property(icon_sprite, "position", Vector2.ZERO, 0.09)
		
	# Gain mana on attack with item bonuses
	var mana_gain = 18.0 + get_item_stat_bonus("mana_per_hit")
	if has_held_item("battery"):
		mana_gain += 10.0
	gain_mana(mana_gain)

	# Item on-hit effects
	if has_held_item("magnet") and target:
		target.armor = max(0.0, target.armor * 0.75)
		target.mr = max(0.0, target.mr * 0.75)
	
	# Global synergies on attack:
	if SynergyManager.has_fire_burn(is_enemy):
		target.apply_burn(3.0, 25.0)
		
	if SynergyManager.has_poison_debuff(is_enemy):
		var poison_dps = SynergyManager.get_poison_dps(is_enemy)
		target.apply_burn(3.0, poison_dps)

		
	if not is_enemy and types.has("Electric"):
		var bounce_chance = SynergyManager.get_electric_bounce_chance(is_enemy)
		if randf() < bounce_chance:
			trigger_chain_lightning(target)
		
	if not is_enemy and types.has("Grass"):
		heal(damage * 0.25, true)

func _apply_attack_damage_and_passives(target: Unit, damage: float, is_crit: bool, is_combo: bool) -> void:
	var is_true_damage = (is_combo and pokemon_id == "lucario")
	target.take_damage(damage, is_true_damage, is_crit, true, self)
	
	# Arena Environment Hit Effects
	if not is_enemy:
		if GameManager.has_arena_modifier("fire_amp"):
			var f_info = GameManager.get_arena_modifier_info("fire_amp")
			if randf() < f_info.get("burn_chance", 0.20):
				target.apply_burn(3.0, f_info.get("burn_dps", 35.0))
				target.spawn_floating_text("地热灼烧!", Color(1.0, 0.45, 0.1))
		if GameManager.has_arena_modifier("slow_ratio"):
			var slow = GameManager.get_arena_modifier_val("slow_ratio")
			target.atk_speed = max(0.35, target.atk_speed * (1.0 - slow * 0.4))
			target.spawn_floating_text("寒霜迟缓!", Color(0.4, 0.85, 1.0))
	
	if is_combo:
		match pokemon_id:
			"squirtle":
				shield += 45.0
				update_bars()
				spawn_floating_text("+护盾!", Color(0.3, 0.8, 1.0))
			"bulbasaur":
				heal(damage * 0.35, true)
			"gengar":
				var stolen = min(target.current_mana, 12.0)
				target.current_mana = max(0.0, target.current_mana - stolen)
				target.update_bars()
				gain_mana(stolen)
				spawn_floating_text("吸蓝!", Color(0.8, 0.4, 1.0))
			"snorlax":
				_trigger_snorlax_splash(target, damage * 0.35)
			"charmander", "charizard":
				target.apply_burn(2.5, 30.0)
			"pikachu":
				_trigger_pikachu_combo_spark(target, damage * 0.5)
			"machop":
				var knock_dir = (target.position - position).normalized()
				var tw = target.create_tween()
				tw.tween_property(target, "position", target.position + knock_dir * 12.0, 0.08)

func _trigger_snorlax_splash(hit_target: Unit, splash_damage: float) -> void:
	var units = get_tree().get_nodes_in_group("units")
	for node in units:
		var u = node as Unit
		if u and u != hit_target and u.is_enemy != is_enemy and not u.is_dead and not u.is_on_bench:
			if hit_target.position.distance_to(u.position) <= 75.0:
				u.take_damage(splash_damage, false, false)

func _trigger_pikachu_combo_spark(hit_target: Unit, spark_damage: float) -> void:
	var units = get_tree().get_nodes_in_group("units")
	var closest_other: Unit = null
	var min_d = 99999.0
	for node in units:
		var u = node as Unit
		if u and u != hit_target and u.is_enemy != is_enemy and not u.is_dead and not u.is_on_bench:
			var d = hit_target.position.distance_to(u.position)
			if d < min_d and d <= 180.0:
				min_d = d
				closest_other = u
	if closest_other:
		var parent_node = get_parent() as Node2D
		if parent_node == null: parent_node = self
		var other_ref = weakref(closest_other)
		AttackVFX.spawn_ranged_projectile(parent_node, hit_target.position, closest_other, "pikachu", false, func():
			var other = other_ref.get_ref() as Unit
			if other != null and is_instance_valid(other) and not other.is_dead:
				other.take_damage(spark_damage, false, false, true, self)
		)

func spawn_projectile_to(target: Unit, damage: float, is_crit: bool) -> void:
	var parent_node = get_parent() as Node2D
	if parent_node == null: parent_node = self
	var target_ref = weakref(target)
	AttackVFX.spawn_ranged_projectile(parent_node, position, target, pokemon_id, false, func():
		var tgt = target_ref.get_ref() as Unit
		if tgt != null and is_instance_valid(tgt) and not tgt.is_dead:
			tgt.take_damage(damage, false, is_crit, true, self)
	)

func get_projectile_color() -> Color:
	return AttackVFX._get_projectile_color(pokemon_id)

func trigger_chain_lightning(initial_target: Unit) -> void:
	AudioManager.play_sfx("thunder", 1.2, -3.0)
	var enemies = get_tree().get_nodes_in_group("units")
	var hit_count = 0
	for e in enemies:
		var u = e as Unit
		if u != null and u != initial_target and u.is_enemy != self.is_enemy and not u.is_dead:
			u.take_damage(atk * 0.5, true, false)
			u.apply_stun(0.5)
			hit_count += 1
			if hit_count >= 2:
				break

func _proc_cascade_lightning(dmg: float) -> void:
	if not is_inside_tree():
		return
	var enemies = get_tree().get_nodes_in_group("units")
	for e in enemies:
		var u = e as Unit
		if is_instance_valid(u) and u.is_enemy != self.is_enemy and not u.is_dead and not u.is_on_bench:
			u.take_damage(dmg, true, false)
			u.spawn_floating_text("幽蓝落雷 -%d!" % int(dmg), Color(0.4, 0.8, 1.0))
			AudioManager.play_sfx("thunder", 1.4, -4.0)
			break

func cast_skill() -> void:
	current_mana = 0.0
	update_bars()
	icon_sprite.play("attack")
	
	# Spell Amp from Psychic synergy & Arena Modifiers
	var amp = SynergyManager.get_spell_amp(is_enemy)
	if not is_enemy and GameManager.has_arena_modifier("spell_amp"):
		amp += GameManager.get_arena_modifier_val("spell_amp")
	if not is_enemy and types.has("Fire") and GameManager.has_arena_modifier("fire_amp"):
		amp += GameManager.get_arena_modifier_val("fire_amp")
	if not is_enemy and types.has("Fire") and GameManager.has_arena_modifier("fire_crit_amp"):
		amp += GameManager.get_arena_modifier_val("fire_crit_amp")
	if not is_enemy and (types.has("Grass") or types.has("Dragon")) and GameManager.has_arena_modifier("delta_stream"):
		amp += GameManager.get_arena_modifier_val("delta_stream")
	var final_power = skill_power * amp
	if has_held_item("life_orb"):
		final_power *= 1.40
		take_damage(max_hp * 0.05, false, false, false)
	
	if not is_enemy and MegaDatabase:
		MegaDatabase.add_dynamax_energy(2)
	
	# Mega Evolution check
	if star_level >= 3 and has_held_item("mega_bracelet") and not has_meta("is_mega"):
		trigger_mega_evolution()
		
	# Dynamax Max Move check
	if has_meta("is_dynamax") and MegaDatabase:
		var prim_type = types[0] if not types.is_empty() else "Normal"
		var max_move = MegaDatabase.get_dynamax_move(prim_type)
		spawn_floating_text("【%s】" % max_move.name, Color(1.0, 0.25, 0.35), true, 1.4)
		final_power *= 1.5
		match prim_type:
			"Fire": WeatherSystem.set_weather("sun", 15.0)
			"Water": WeatherSystem.set_weather("rain", 15.0)
			"Electric": WeatherSystem.set_terrain("electric", 15.0)
			"Grass": WeatherSystem.set_terrain("grassy", 15.0)
			"Ice": WeatherSystem.set_weather("snow", 15.0)
			"Rock", "Ground": WeatherSystem.set_weather("sandstorm", 15.0)
			"Psychic": WeatherSystem.set_terrain("psychic", 15.0)
	
	# Glacier Arena: Cascade Lightning Proc
	if not is_enemy and GameManager.has_arena_modifier("lightning_proc"):
		var l_dmg = GameManager.get_arena_modifier_val("lightning_proc")
		call_deferred("_proc_cascade_lightning", l_dmg)
	
	# Flash icon sprite & play cast_skill animation
	if icon_sprite.sprite_frames and icon_sprite.sprite_frames.has_animation("cast_skill"):
		icon_sprite.play("cast_skill")
	else:
		icon_sprite.play("attack")
		
	if particles:
		particles.restart()
		particles.emitting = true
		
	if unit_3d and is_instance_valid(unit_3d):
		unit_3d.perform_3d_skill_cast()
		
	var tw = create_tween()
	tw.tween_property(icon_sprite, "modulate", Color(2.5, 2.5, 2.5), 0.12)
	tw.tween_property(icon_sprite, "modulate", Color(1.0, 1.0, 1.0), 0.15)
	
	var parent_node = get_parent() as Node2D
	if parent_node == null:
		parent_node = self
		
	var vfx_scale: float = 0.82 if star_level == 1 else (1.10 if star_level == 2 else 1.55)
	var is_mega: bool = star_level >= 3
	var t_pos = target_unit.position if is_instance_valid(target_unit) else position + Vector2(0, -60)
	var skill_info = selected_skill if not selected_skill.is_empty() else PokemonDatabase.get_skill_data(pokemon_id, star_level)
	var vfx_name: String = skill_info.get("vfx", "thunderbolt")
	var sfx_name: String = skill_info.get("sfx", "skill")
	
	# Action VFX Enhancements: Cinematic Spotlight, Ground Telegraph & Decals
	var u_cost = PokemonDatabase.get_pokemon(pokemon_id).get("cost", 1) if PokemonDatabase else 1
	var is_legendary_or_boss = (u_cost >= 4) or has_meta("is_dynamax") or has_meta("is_mega") or (is_enemy and star_level >= 3)
	if is_legendary_or_boss:
		GameManager.trigger_cinematic_spotlight(0.55, 0.42)
		GameManager.shake_camera(0.65, 0.28)
		if parent_node:
			var tele_col = TypeSystem.get_type_color(types[0] if not types.is_empty() else "Normal") if TypeSystem else Color(1.0, 0.25, 0.25)
			SkillVFX.spawn_ground_telegraph(parent_node, t_pos, 52.0, 0.32, tele_col)
	else:
		GameManager.shake_camera(0.32, 0.16)
		
	# Ground Decal reaction (Fire scorch / Electric spark / Ice frost)
	if parent_node:
		if types.has("Fire"):
			SkillVFX.spawn_ground_decal(parent_node, t_pos, "scorch")
		elif types.has("Electric"):
			SkillVFX.spawn_ground_decal(parent_node, t_pos, "electric")
		elif types.has("Ice"):
			SkillVFX.spawn_ground_decal(parent_node, t_pos, "frost")
	
	# Specialized visual effects, floating skill text, and mechanics per Pokemon & star level
	match pokemon_id:
		"charmander":
			AudioManager.play_sfx(sfx_name)
			spawn_floating_text(skill_name + "!", Color(1.0, 0.45, 0.15), is_mega)
			SkillVFX.spawn_skill_vfx(vfx_name, parent_node, position, t_pos, vfx_scale)
			if star_level == 1:
				hit_targets_aoe(final_power, 1, 0.0)
			elif star_level == 2:
				hit_targets_aoe(final_power, 3, 0.4)
			else:
				hit_targets_aoe(final_power, 5, 0.8)
		"squirtle":
			AudioManager.play_sfx(sfx_name)
			spawn_floating_text(skill_name + "!", Color(0.25, 0.75, 1.0), is_mega)
			SkillVFX.spawn_skill_vfx(vfx_name, parent_node, position, t_pos, vfx_scale)
			if star_level == 1:
				shield += 200.0
				hit_targets_aoe(final_power, 1, 0.0)
			elif star_level == 2:
				shield += 380.0
				hit_targets_aoe(final_power, 3, 0.5)
			else:
				shield += 650.0
				hit_targets_aoe(final_power, 6, 1.2)
		"bulbasaur":
			AudioManager.play_sfx(sfx_name)
			spawn_floating_text(skill_name + "!", Color(0.35, 0.95, 0.35), is_mega)
			var count = 1 if star_level == 1 else (3 if star_level == 2 else 5)
			var targets = get_aoe_targets(count)
			SkillVFX.spawn_skill_vfx(vfx_name, parent_node, position, t_pos, vfx_scale, targets)
			if star_level == 1:
				hit_targets_aoe(final_power, 1, 0.0)
				heal(final_power, true)
			elif star_level == 2:
				hit_targets_aoe(final_power, 3, 0.0)
				heal(250.0, true)
			else:
				hit_targets_aoe(final_power, 5, 1.8)
				heal(480.0, true)
		"machop":
			AudioManager.play_sfx(sfx_name)
			spawn_floating_text(skill_name + "!", Color(0.95, 0.85, 0.3), is_mega)
			SkillVFX.spawn_skill_vfx(vfx_name, parent_node, position, t_pos, vfx_scale)
			if star_level == 1:
				hit_targets_aoe(final_power, 1, 0.6)
			elif star_level == 2:
				hit_targets_aoe(final_power, 2, 1.5)
			else:
				hit_targets_aoe(final_power, 4, 1.8)
		"pikachu":
			AudioManager.play_sfx(sfx_name)
			spawn_floating_text(skill_name + "!", Color(1.0, 0.92, 0.2), is_mega)
			var p_targets = get_aoe_targets(1 if star_level == 1 else (2 if star_level == 2 else 4))
			SkillVFX.spawn_skill_vfx(vfx_name, parent_node, position, t_pos, vfx_scale, p_targets)
			if star_level == 1:
				hit_targets_aoe(final_power, 1, 0.6)
			elif star_level == 2:
				hit_targets_aoe(final_power, 2, 1.0)
			else:
				hit_targets_aoe(final_power, 4, 1.5)
		"eevee":
			AudioManager.play_sfx(sfx_name)
			spawn_floating_text(skill_name + "!", Color(1.0, 0.9, 0.25), is_mega)
			SkillVFX.spawn_skill_vfx(vfx_name, parent_node, position, t_pos, vfx_scale)
			if star_level == 1:
				atk_speed += atk_speed * 0.35
				hit_targets_aoe(final_power, 1, 0.0)
			elif star_level == 2:
				hit_targets_aoe(final_power, 3, 0.0)
			else:
				heal(250.0, true)
				hit_targets_aoe(final_power, 5, 0.8)
		"growlithe":
			AudioManager.play_sfx(sfx_name)
			spawn_floating_text(skill_name + "!", Color(1.0, 0.5, 0.15), is_mega)
			SkillVFX.spawn_skill_vfx(vfx_name, parent_node, position, t_pos, vfx_scale)
			if star_level == 1:
				hit_targets_aoe(final_power, 1, 0.0)
			elif star_level == 2:
				hit_targets_aoe(final_power, 3, 0.0)
			else:
				hit_targets_aoe(final_power, 5, 1.2)
		"psyduck":
			AudioManager.play_sfx(sfx_name)
			spawn_floating_text(skill_name + "!", Color(0.35, 0.9, 1.0), is_mega)
			SkillVFX.spawn_skill_vfx(vfx_name, parent_node, position, t_pos, vfx_scale)
			if star_level == 1:
				hit_targets_aoe(final_power, 1, 0.5)
			elif star_level == 2:
				hit_targets_aoe(final_power, 3, 1.2)
			else:
				hit_targets_aoe(final_power, 5, 2.0)
		"gengar":
			AudioManager.play_sfx(sfx_name)
			spawn_floating_text(skill_name + "!", Color(0.75, 0.3, 0.95), is_mega)
			SkillVFX.spawn_skill_vfx(vfx_name, parent_node, position, t_pos, vfx_scale)
			if star_level == 1:
				hit_targets_aoe(final_power, 1, 1.5)
			elif star_level == 2:
				hit_targets_aoe(final_power, 3, 0.0)
			else:
				hit_targets_aoe(final_power, 5, 1.5)
		"snorlax":
			AudioManager.play_sfx(sfx_name)
			spawn_floating_text(skill_name + "!", Color(0.9, 0.85, 0.45), is_mega)
			SkillVFX.spawn_skill_vfx(vfx_name, parent_node, position, t_pos, vfx_scale)
			if star_level == 1:
				heal(max_hp * 0.35, true)
				armor += 40.0
				hit_targets_aoe(final_power, 1, 0.0)
			elif star_level == 2:
				hit_targets_aoe(final_power, 3, 1.2)
			else:
				shield += 500.0
				hit_targets_aoe(final_power, 5, 1.8)
		"electabuzz":
			AudioManager.play_sfx(sfx_name)
			spawn_floating_text(skill_name + "!", Color(1.0, 0.95, 0.3), is_mega)
			SkillVFX.spawn_skill_vfx(vfx_name, parent_node, position, t_pos, vfx_scale)
			if star_level == 1:
				hit_targets_aoe(final_power, 1, 0.8)
			elif star_level == 2:
				hit_targets_aoe(final_power, 4, 1.0)
			else:
				hit_targets_aoe(final_power, 6, 1.5)
		"lapras":
			AudioManager.play_sfx(sfx_name)
			spawn_floating_text(skill_name + "!", Color(0.65, 0.92, 1.0), is_mega)
			SkillVFX.spawn_skill_vfx(vfx_name, parent_node, position, t_pos, vfx_scale)
			if star_level == 1:
				hit_targets_aoe(final_power, 1, 0.0)
			elif star_level == 2:
				hit_targets_aoe(final_power, 4, 0.5)
			else:
				hit_targets_aoe(final_power, 6, 2.0)
		"alakazam":
			AudioManager.play_sfx(sfx_name)
			spawn_floating_text(skill_name + "!", Color(0.95, 0.35, 1.0), is_mega)
			SkillVFX.spawn_skill_vfx(vfx_name, parent_node, position, t_pos, vfx_scale)
			if star_level == 1:
				hit_targets_aoe(final_power, 1, 1.0)
			elif star_level == 2:
				hit_targets_aoe(final_power, 3, 0.5)
			else:
				hit_targets_aoe(final_power, 6, 1.0)
		"charizard":
			AudioManager.play_sfx(sfx_name)
			spawn_floating_text(skill_name + "!", Color(1.0, 0.4, 0.1), is_mega)
			SkillVFX.spawn_skill_vfx(vfx_name, parent_node, position, t_pos, vfx_scale)
			if star_level == 1:
				hit_targets_aoe(final_power, 2, 0.0)
			elif star_level == 2:
				hit_targets_aoe(final_power, 4, 0.0)
			else:
				hit_targets_aoe(final_power, 7, 1.2)
		"gyarados":
			AudioManager.play_sfx(sfx_name)
			spawn_floating_text(skill_name + "!", Color(0.2, 0.75, 1.0), is_mega)
			SkillVFX.spawn_skill_vfx(vfx_name, parent_node, position, t_pos, vfx_scale)
			if star_level == 1:
				hit_targets_aoe(final_power, 1, 1.2)
			elif star_level == 2:
				hit_targets_aoe(final_power, 3, 0.0)
			else:
				hit_targets_aoe(final_power, 6, 1.5)
		"lucario":
			AudioManager.play_sfx(sfx_name)
			spawn_floating_text(skill_name + "!", Color(0.2, 0.85, 1.0), is_mega)
			SkillVFX.spawn_skill_vfx(vfx_name, parent_node, position, t_pos, vfx_scale)
			if star_level == 1:
				hit_targets_aoe(final_power, 1, 1.0)
			elif star_level == 2:
				hit_targets_aoe(final_power, 4, 0.0)
			else:
				hit_targets_aoe(final_power, 6, 1.8)
		"dragonite":
			AudioManager.play_sfx(sfx_name)
			spawn_floating_text(skill_name + "!", Color(1.0, 0.65, 0.15), is_mega)
			var d_count = 2 if star_level == 1 else (5 if star_level == 2 else 8)
			var d_targets = get_aoe_targets(d_count)
			SkillVFX.spawn_skill_vfx(vfx_name, parent_node, position, t_pos, vfx_scale, d_targets)
			if star_level == 1:
				hit_targets_aoe(final_power, 2, 0.0)
			elif star_level == 2:
				hit_targets_aoe(final_power, 5, 0.5)
			else:
				heal(max_hp * 0.35, true)
				hit_targets_aoe(final_power, 8, 1.5)
		"mewtwo":
			AudioManager.play_sfx(sfx_name)
			spawn_floating_text(skill_name + "!", Color(0.95, 0.3, 1.0), is_mega)
			SkillVFX.spawn_skill_vfx(vfx_name, parent_node, position, t_pos, vfx_scale)
			if star_level == 1:
				hit_targets_aoe(final_power, 2, 0.0)
			elif star_level == 2:
				hit_targets_aoe(final_power, 6, 2.0)
			else:
				hit_targets_aoe(final_power, 9, 2.5)
		_:
			AudioManager.play_sfx(sfx_name)
			spawn_floating_text(skill_name + "!", Color(1.0, 1.0, 1.0), is_mega)
			var target_count: int = skill_info.get("target_count", 2)
			var stun_dur: float = skill_info.get("stun_duration", 0.5)
			SkillVFX.spawn_skill_vfx(vfx_name, parent_node, position, t_pos, vfx_scale)
			hit_targets_aoe(final_power, target_count, stun_dur)

func get_aoe_targets(count: int) -> Array:
	var result = []
	var units = get_tree().get_nodes_in_group("units")
	for u in units:
		var target = u as Unit
		if target and target.is_enemy != self.is_enemy and not target.is_dead and not target.is_on_bench:
			result.append(target)
			if result.size() >= count:
				break
	return result

func hit_targets_aoe(damage: float, count: int, stun_duration: float = 0.0) -> void:
	var units = get_tree().get_nodes_in_group("units")
	var hit = 0
	for u in units:
		var target = u as Unit
		if target and target.is_enemy != self.is_enemy and not target.is_dead and not target.is_on_bench:
			target.take_damage(damage, true, true)
			if stun_duration > 0.0:
				target.apply_stun(stun_duration)
			hit += 1
			if hit >= count:
				break

func take_damage(raw_amount: float, is_magic: bool, is_crit: bool = false, show_float: bool = true, attacker: Unit = null) -> void:
	if is_dead:
		return
		
	# Dodge check for Ghost, Flying, and Astral Arena
	var dodge_chance = 0.0
	if not is_enemy and types.has("Ghost"):
		dodge_chance += 0.25
	if not is_enemy and types.has("Flying"):
		dodge_chance += SynergyManager.get_flying_dodge_bonus(is_enemy)
	if not is_enemy and GameManager.has_arena_modifier("dodge_chance"):
		dodge_chance += GameManager.get_arena_modifier_val("dodge_chance")
	if dodge_chance > 0.0 and randf() < dodge_chance:
		_play_dodge_reaction()
		# Astral arena: Psychic & Ghost restore 15 mana on dodge
		if not is_enemy and (types.has("Psychic") or types.has("Ghost")) and GameManager.has_arena_modifier("dodge_chance"):
			gain_mana(15.0)
			spawn_floating_text("+15法力!", Color(0.8, 0.4, 1.0))
		return
		
	var def = mr if is_magic else armor
	
	# Weather defense bonuses (e.g. Sandstorm +40% Rock/Ground/Steel defenses, Snow +50% Ice armor)
	if WeatherSystem:
		var w_bonus = WeatherSystem.calculate_defense_bonus(self.types)
		if is_magic:
			def *= w_bonus["mr_mult"]
		else:
			def *= w_bonus["armor_mult"]
	
	# Mega Gyarados: Mold Breaker ignores defender's defenses
	if attacker and attacker.has_meta("is_mega") and attacker.pokemon_id == "gyarados":
		def = 0.0
	
	# Type effectiveness multiplier
	var type_mult = 1.0
	if attacker != null and is_instance_valid(attacker):
		type_mult = TypeSystem.get_type_multiplier(attacker.types, self.types)
		raw_amount *= type_mult
		
		# Weather & Terrain offensive multiplier
		if WeatherSystem:
			var m_type = "Fire" if attacker.types.has("Fire") else (attacker.types[0] if not attacker.types.is_empty() else "Normal")
			raw_amount *= WeatherSystem.calculate_weather_terrain_multiplier(attacker.types, m_type)

	# Ability: Thick Fat (Snorlax & Mega Venusaur) - reduction from Fire and Ice
	var my_ability = AbilityDatabase.get_ability_id_for_pokemon(pokemon_id)
	if (my_ability == "thick_fat" or (has_meta("is_mega") and pokemon_id == "venusaur")) and attacker and (attacker.types.has("Fire") or attacker.types.has("Ice")):
		raw_amount *= 0.55

	# Ability: Multiscale (Dragonite) - 60% reduction on first hit at 100% HP
	if my_ability == "multiscale" and current_hp >= max_hp * 0.99:
		raw_amount *= 0.40
		spawn_floating_text("多重鳞片!", Color(0.3, 0.9, 0.6), true)

	var reduced = raw_amount * (100.0 / (100.0 + max(0.0, def)))
	
	# Normal damage reduction
	if not is_enemy and types.has("Normal"):
		reduced *= 0.8
		
	# Stadium Arena Stage 2: 10% debuff amp on first skill hit received
	if is_magic and not is_enemy and GameManager.has_arena_modifier("debuff_amp"):
		if not has_meta("stadium_debuff_proced"):
			set_meta("stadium_debuff_proced", true)
			reduced *= (1.0 + GameManager.get_arena_modifier_val("debuff_amp"))
			
	# Emerald Arena Stage 4: Delta Stream crit damage reduction
	if is_crit and not is_enemy and GameManager.has_arena_modifier("delta_stream"):
		reduced *= (1.0 - GameManager.get_arena_modifier_val("delta_stream"))

	# Item Damage Reduction (Hard Stone)
	if has_held_item("hard_stone"):
		reduced *= 0.80

	# Item Thorns (Rocky Helmet)
	if not is_magic and has_held_item("rocky_helmet") and target_unit and is_instance_valid(target_unit) and not target_unit.is_dead:
		target_unit.take_damage(raw_amount * 0.30, false, false, false, self)
		
	# Track damage metrics
	damage_taken += reduced
	if attacker != null and is_instance_valid(attacker):
		attacker.damage_dealt += reduced
		
	# Shield absorption
	if shield > 0:
		if shield >= reduced:
			shield -= reduced
			healing_done += reduced
			reduced = 0
		else:
			healing_done += shield
			reduced -= shield
			shield = 0
			
	current_hp -= reduced
	gain_mana(8.0) # Mana gain upon taking hit

	# Weakness Policy: Trigger burst when falling below 50% HP
	if has_held_item("weakness_policy") and not has_meta("weakness_policy_triggered"):
		if current_hp <= max_hp * 0.50 and current_hp > 0:
			set_meta("weakness_policy_triggered", true)
			atk *= 1.50
			skill_power *= 1.50
			spawn_floating_text("弱点保险爆发! +50%双攻", Color(1.0, 0.4, 0.2), true)
	
	# Volcano Lava Shield on low HP
	if not is_enemy and GameManager.has_arena_modifier("lava_shield"):
		if current_hp <= max_hp * 0.40 and not has_meta("lava_shield_proced"):
			set_meta("lava_shield_proced", true)
			var s_val = GameManager.get_arena_modifier_val("lava_shield")
			shield += s_val
			spawn_floating_text("熔岩狂暴! +%d护盾" % int(s_val), Color(1.0, 0.55, 0.15), true)
			
	# Emerald Arena Dragon Execute
	if is_enemy and GameManager.has_arena_modifier("execute_thresh"):
		var thresh = GameManager.get_arena_modifier_val("execute_thresh")
		if current_hp <= max_hp * thresh and current_hp > 0:
			spawn_floating_text("龙威斩杀!", Color(0.3, 1.0, 0.5), true)
			current_hp = 0
			die()
			return
	
	if show_float and reduced > 0:
		var col = Color(0.9, 0.3, 0.8) if is_magic else (Color(1.0, 0.85, 0.15) if is_crit else Color(0.95, 0.3, 0.3))
		spawn_floating_text(str(int(reduced)), col, is_crit)
		if type_mult >= 1.25:
			spawn_floating_text("💥效果绝佳！", Color(1.0, 0.45, 0.15), true, 0.75)
		elif type_mult <= 0.80:
			spawn_floating_text("🛡️效果不佳", Color(0.65, 0.65, 0.75), false, 0.65)
			
	# Ability: Static (25% stun on melee attacker)
	if my_ability == "static" and attacker and not is_magic and not attacker.is_dead:
		if randf() < 0.25:
			attacker.apply_stun(1.0)
			attacker.spawn_floating_text("静电麻痹!", Color(1.0, 0.9, 0.2), true)

	# Ability: Cursed Body (20% disarm on attacker)
	if my_ability == "cursed_body" and attacker and not attacker.is_dead:
		if randf() < 0.20:
			attacker.attack_timer = max(attacker.attack_timer, 2.0)
			attacker.spawn_floating_text("诅咒之躯!", Color(0.7, 0.3, 0.9), true)
		
	update_bars()
	
	var parent_node = get_parent() as Node2D
	if is_crit and reduced > 0 and parent_node:
		AttackVFX.spawn_crit_impact(parent_node, position)
		AudioManager.play_sfx("punch", 1.35, 1.0)
	
	# Sprite hit shake & hurt animation
	if unit_3d and is_instance_valid(unit_3d):
		unit_3d.perform_3d_hurt()
		unit_3d.update_bars(current_hp, max_hp, current_mana, max_mana)
		
	var hit_tw = create_tween()
	if is_crit and reduced > 0:
		hit_tw.tween_property(icon_sprite, "modulate", Color(2.6, 2.0, 0.8), 0.06)
		GameManager.shake_camera(0.45, 0.2)
	else:
		hit_tw.tween_property(icon_sprite, "modulate", Color(1.5, 0.5, 0.5), 0.05)
	hit_tw.tween_property(icon_sprite, "modulate", Color(1.0, 1.0, 1.0), 0.06)
	
	# Shader Hit Flash (White-hot damage feedback)
	if reduced > 0 and icon_sprite and icon_sprite.material is ShaderMaterial:
		var smat = icon_sprite.material as ShaderMaterial
		smat.set_shader_parameter("hit_flash", 1.0)
		var flash_tw = create_tween()
		flash_tw.tween_method(func(val: float):
			if is_instance_valid(smat):
				smat.set_shader_parameter("hit_flash", val)
		, 1.0, 0.0, 0.07)
		
	# Micro-Stagger / Elastic Hit Reaction
	if reduced > 0 and not is_dead:
		icon_sprite.play("hurt")
		var push_dir = (position - attacker.position).normalized() if (attacker and is_instance_valid(attacker)) else Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
		var st_tw = create_tween()
		st_tw.tween_property(icon_sprite, "position", push_dir * (7.0 if is_crit else 4.0), 0.04).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		st_tw.tween_property(icon_sprite, "position", Vector2.ZERO, 0.07).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	
	if current_hp <= 0:
		die()

func _play_dodge_reaction() -> void:
	AudioManager.play_sfx("swift", 1.45, -1.0)
	spawn_floating_text("闪避", Color(0.35, 0.9, 1.0), false, 0.7)
	
	var parent_node = get_parent() as Node2D
	var dodge_dir = Vector2(-16.0 if not icon_sprite.flip_h else 16.0, -6.0)
	
	if parent_node:
		AttackVFX.spawn_dodge_vfx(parent_node, position, dodge_dir)
		
		# Translucent ghost afterimage
		if icon_sprite.sprite_frames:
			var ghost = Sprite2D.new()
			var curr_anim = icon_sprite.animation
			var curr_frame = icon_sprite.frame
			var tex = icon_sprite.sprite_frames.get_frame_texture(curr_anim, curr_frame)
			if tex:
				ghost.texture = tex
				ghost.scale = icon_sprite.scale
				ghost.flip_h = icon_sprite.flip_h
				ghost.position = position + icon_sprite.position
				ghost.modulate = Color(0.5, 0.85, 1.0, 0.65)
				ghost.z_index = z_index - 1
				parent_node.add_child(ghost)
				
				var gt = ghost.create_tween()
				gt.tween_property(ghost, "modulate:a", 0.0, 0.22)
				gt.tween_callback(ghost.queue_free)
				
	var dt = create_tween()
	dt.tween_property(icon_sprite, "position", dodge_dir, 0.08).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	dt.tween_property(icon_sprite, "position", Vector2.ZERO, 0.14).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)

func heal(amount: float, show_float: bool = true, healer: Unit = null) -> void:
	if is_dead:
		return
	var actual_healed = min(max_hp - current_hp, amount)
	current_hp = min(max_hp, current_hp + amount)
	healing_done += actual_healed
	if healer != null and is_instance_valid(healer) and healer != self:
		healer.healing_done += actual_healed
	update_bars()
	if show_float and amount > 5:
		spawn_floating_text("+" + str(int(amount)), Color(0.2, 0.95, 0.3))

func gain_mana(amount: float) -> void:
	if is_dead:
		return
	current_mana = min(max_mana, current_mana + amount)
	update_bars()

func apply_burn(duration: float, dps: float) -> void:
	burn_timer = max(burn_timer, duration)
	burn_dps = dps

func apply_stun(duration: float) -> void:
	is_stunned = true
	stun_timer = max(stun_timer, duration)
	if stun_vfx == null:
		stun_vfx = STUN_VFX_SCRIPT.new()
		stun_vfx.position = Vector2(0, -32)
		add_child(stun_vfx)
	stun_vfx.start_stun()

func die() -> void:
	if is_dead:
		return
	is_dead = true
	is_stunned = false
	icon_sprite.rotation = 0.0
	if stun_vfx:
		stun_vfx.stop_immediate()
	current_hp = 0
	update_bars()
	icon_sprite.play("hurt")
	if unit_3d and is_instance_valid(unit_3d):
		unit_3d.perform_3d_death()
		unit_3d = null
	
	if is_enemy:
		if MegaDatabase:
			MegaDatabase.add_dynamax_energy(3)
	
	var tw = create_tween()
	tw.tween_property(self, "modulate:a", 0.0, 0.3)
	tw.tween_callback(func():
		unit_died.emit(self)
		if is_enemy:
			# Stadium Arena: kill_heal
			if GameManager.has_arena_modifier("kill_heal"):
				var heal_val = GameManager.get_arena_modifier_val("kill_heal")
				if GameManager.board_ref:
					for ally in GameManager.board_ref.get_board_units(false):
						if is_instance_valid(ally) and not ally.is_dead:
							ally.heal(heal_val)
							ally.atk_speed += ally.atk_speed * 0.15
							ally.spawn_floating_text("欢呼鼓舞! +%d" % int(heal_val), Color(0.2, 0.95, 0.4))
			# Astral Arena: soul_steal
			if GameManager.has_arena_modifier("soul_steal"):
				var steal_pct = GameManager.get_arena_modifier_val("soul_steal")
				if GameManager.board_ref:
					var allies = GameManager.board_ref.get_board_units(false)
					var live_allies: Array[Unit] = []
					for a in allies:
						if is_instance_valid(a) and not a.is_dead:
							live_allies.append(a)
					if not live_allies.is_empty():
						var lucky = live_allies.pick_random()
						lucky.atk += atk * steal_pct
						lucky.spawn_floating_text("灵魂收割! 攻击+%d" % int(atk * steal_pct), Color(0.85, 0.35, 1.0))
			queue_free()
		else:
			# Player units stay hidden until round resets
			visible = false
	)

func reset_for_prep() -> void:
	if has_meta("lava_shield_proced"):
		remove_meta("lava_shield_proced")
	if has_meta("stadium_debuff_proced"):
		remove_meta("stadium_debuff_proced")
	if has_meta("blizzard_frozen"):
		remove_meta("blizzard_frozen")
	if has_meta("weakness_policy_triggered"):
		remove_meta("weakness_policy_triggered")
	if has_meta("is_dynamax"):
		deactivate_dynamax()
	is_dead = false
	visible = true
	modulate.a = 1.0
	current_hp = max_hp
	current_mana = max_mana if has_held_item("choice_specs") else min(max_mana, get_item_stat_bonus("start_mana"))
	shield = (max_hp * 0.40) if has_held_item("assault_vest") else 0.0
	is_stunned = false
	stun_timer = 0.0
	icon_sprite.rotation = 0.0
	if stun_vfx:
		stun_vfx.stop_immediate()
	burn_timer = 0.0
	is_in_combat = false
	attack_count = 0
	target_unit = null
	icon_sprite.position = Vector2.ZERO
	icon_sprite.flip_h = false
	icon_sprite.play("idle")
	update_bars()

func trigger_mega_evolution() -> void:
	if has_meta("is_mega") or not MegaDatabase or not MegaDatabase.is_mega_eligible(pokemon_id):
		return
	var mega_data = MegaDatabase.get_mega_form(pokemon_id)
	if mega_data.is_empty():
		return
		
	set_meta("is_mega", true)
	
	# Stat multipliers
	var stat_mults: Dictionary = mega_data.get("stat_multipliers", {})
	max_hp *= stat_mults.get("hp", 1.25)
	current_hp = min(max_hp, current_hp * stat_mults.get("hp", 1.25))
	atk *= stat_mults.get("atk", 1.40)
	armor *= stat_mults.get("armor", 1.25)
	mr *= stat_mults.get("mr", 1.25)
	atk_speed *= stat_mults.get("atk_speed", 1.20)
	
	# Update types
	var new_types = mega_data.get("types", [])
	if not new_types.is_empty():
		types = new_types
		
	# Mega burst visual animation & sound
	var mega_name = mega_data.get("name", "超级进化")
	spawn_floating_text("✨ MEGA 超级进化! ✨\n【%s】" % mega_name, Color(1.0, 0.85, 0.2), true)
	AudioManager.play_sfx("upgrade")
	
	var tw = create_tween()
	tw.tween_property(self, "scale", scale * 1.2, 0.2).set_trans(Tween.TRANS_BACK)
	tw.tween_property(icon_sprite, "modulate", Color(1.2, 1.2, 1.5), 0.2)
	
	# Weather trigger if Charizard Y (Drought)
	if mega_data.get("mega_id", "") == "mega_charizard_y":
		WeatherSystem.set_weather("sun", 25.0)
		
	MegaDatabase.mega_evolved.emit(self, mega_data.get("mega_id", ""))

func activate_dynamax() -> void:
	if has_meta("is_dynamax"):
		return
	set_meta("is_dynamax", true)
	max_hp *= 2.0
	current_hp = max_hp
	scale = scale * 1.6
	spawn_floating_text("🔴 极巨化 DYNAMAX! 🔴", Color(1.0, 0.2, 0.35), true)
	AudioManager.play_sfx("round_start")

func deactivate_dynamax() -> void:
	if not has_meta("is_dynamax"):
		return
	remove_meta("is_dynamax")
	scale = Vector2.ONE
	recalculate_item_stats()
	current_hp = min(current_hp, max_hp)
	spawn_floating_text("极巨化解除", Color(0.85, 0.85, 0.9))

func spawn_floating_text(txt: String, col: Color, is_crit: bool = false, custom_scale: float = -1.0) -> void:
	if get_parent() == null:
		return
	var ft = FLOATING_TEXT_SCENE.instantiate()
	get_parent().add_child(ft)
	ft.position = position + Vector2(0, -20)
	ft.setup(txt, col, is_crit, custom_scale)

func play_click_reaction() -> void:
	if is_dead:
		return
		
	# 1. Playful sound effect with subtle pitch variation
	AudioManager.play_sfx("click", randf_range(1.15, 1.35), -2.0)
	
	# 2. Determine element theme color
	var elem_color = Color(1.0, 0.85, 0.3)
	if types.size() > 0 and TYPE_COLORS.has(types[0]):
		elem_color = TYPE_COLORS[types[0]]
		
	# 3. Ground energy ripple
	if click_ring and click_ring.has_method("play_ripple"):
		click_ring.play_ripple(elem_color)
		
	# 4. Element sparkle particle burst
	if click_particles:
		click_particles.color = elem_color
		click_particles.restart()
		click_particles.emitting = true
		
	# 5. Floating interactive emoji/symbol above head
	var emoji = REACTION_EMOJIS[randi() % REACTION_EMOJIS.size()]
	spawn_floating_text(emoji, elem_color, false)
	
	# 6. Squash & Stretch 3D Jump + Dynamic Shadow Sync
	if click_tween and click_tween.is_valid():
		click_tween.kill()
		
	click_tween = create_tween()
	
	# Model rim light flash
	icon_sprite.modulate = Color(1.7, 1.7, 1.7)
	click_tween.tween_property(icon_sprite, "modulate", Color.WHITE, 0.20).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	# In combat, don't override active attack displacement
	if is_in_combat and icon_sprite.animation == "attack":
		return
		
	# Phase 1: Squash (0.05s) - physical weight anticipation
	click_tween.parallel().tween_property(icon_sprite, "scale", Vector2(base_icon_scale.x * 1.22, base_icon_scale.y * 0.80), 0.05).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	click_tween.parallel().tween_property(icon_sprite, "position", Vector2(0, 3), 0.05)
	
	# Phase 2: Hop in the air (0.12s) - stretch and rise
	click_tween.chain().tween_property(icon_sprite, "scale", Vector2(base_icon_scale.x * 0.86, base_icon_scale.y * 1.25), 0.12).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	click_tween.parallel().tween_property(icon_sprite, "position", Vector2(0, -18), 0.12).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	if shadow_node:
		click_tween.parallel().tween_property(shadow_node, "scale", Vector2(0.65, 0.45), 0.12)
		click_tween.parallel().tween_property(shadow_node, "modulate:a", 0.4, 0.12)
		
	# Phase 3: Land & Elastic Settle (0.20s) - bouncy recovery
	click_tween.chain().tween_property(icon_sprite, "scale", base_icon_scale, 0.20).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	click_tween.parallel().tween_property(icon_sprite, "position", Vector2.ZERO, 0.20).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	if shadow_node:
		click_tween.parallel().tween_property(shadow_node, "scale", Vector2(0.95, 0.75), 0.20)
		click_tween.parallel().tween_property(shadow_node, "modulate:a", 0.8, 0.20)

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			play_click_reaction()
			unit_clicked.emit(self)
			get_viewport().set_input_as_handled()
		elif event.button_index == MOUSE_BUTTON_RIGHT and event.pressed and not is_enemy:
			if GameManager.board_ref and GameManager.board_ref.has_method("quick_toggle_unit"):
				GameManager.board_ref.quick_toggle_unit(self)
			get_viewport().set_input_as_handled()

# ==============================================================================
# ITEM SYSTEM API
# ==============================================================================

func can_equip_item(item_id: String) -> bool:
	if item_id == "" or ItemDatabase.get_item(item_id).is_empty():
		return false
	if held_items.size() < MAX_HELD_ITEMS:
		return true
	# If at capacity, check if incoming item can combine with an existing base item
	if ItemDatabase.is_base_item(item_id):
		for it in held_items:
			if ItemDatabase.is_base_item(it) and ItemDatabase.get_recipe(it, item_id) != "":
				return true
	return false

func equip_item(item_id: String) -> bool:
	if item_id == "":
		return false
	var item_data = ItemDatabase.get_item(item_id)
	if item_data.is_empty():
		return false

	# 1. Check if can combine with an already held base item
	if ItemDatabase.is_base_item(item_id):
		for i in range(held_items.size()):
			var existing = held_items[i]
			if ItemDatabase.is_base_item(existing):
				var recipe_res = ItemDatabase.get_recipe(existing, item_id)
				if recipe_res != "":
					held_items[i] = recipe_res
					var res_data = ItemDatabase.get_item(recipe_res)
					var res_name = res_data.get("name", recipe_res)
					spawn_floating_text("装备合成: %s!" % res_name, Color(1.0, 0.85, 0.2), true)
					recalculate_item_stats()
					_update_item_icons_display()
					return true

	# 2. Add as new item if slot available
	if held_items.size() < MAX_HELD_ITEMS:
		held_items.append(item_id)
		var item_name = item_data.get("name", item_id)
		spawn_floating_text("+%s" % item_name, Color(0.3, 0.9, 1.0), false)
		recalculate_item_stats()
		_update_item_icons_display()
		return true

	return false

func unequip_item_at(index: int) -> String:
	if index < 0 or index >= held_items.size():
		return ""
	var removed = held_items[index]
	held_items.remove_at(index)
	recalculate_item_stats()
	_update_item_icons_display()
	return removed

func unequip_all_items() -> Array[String]:
	var old = held_items.duplicate()
	held_items.clear()
	recalculate_item_stats()
	_update_item_icons_display()
	return old

func get_held_items() -> Array[String]:
	return held_items.duplicate()

func has_held_item(item_id: String) -> bool:
	return held_items.has(item_id)

func get_item_stat_bonus(stat_name: String) -> float:
	return item_stats_cache.get(stat_name, 0.0)

func recalculate_item_stats() -> void:
	item_stats_cache.clear()
	for it_id in held_items:
		var d = ItemDatabase.get_item(it_id)
		var s = d.get("stats", {})
		for key in s:
			item_stats_cache[key] = item_stats_cache.get(key, 0.0) + s[key]

	# Refresh base unit setup with items
	setup(pokemon_id, star_level, is_enemy)
	_update_item_icons_display()

func _apply_item_stats() -> void:
	item_stats_cache.clear()
	for it_id in held_items:
		var d = ItemDatabase.get_item(it_id)
		var s = d.get("stats", {})
		for key in s:
			item_stats_cache[key] = item_stats_cache.get(key, 0.0) + s[key]

	# Stat additions
	max_hp += get_item_stat_bonus("hp")
	current_hp = max_hp
	atk += get_item_stat_bonus("atk")
	armor += get_item_stat_bonus("armor")
	mr += get_item_stat_bonus("mr")
	var as_pct = get_item_stat_bonus("atk_speed")
	if as_pct > 0.0:
		atk_speed += atk_speed * as_pct
	current_mana = min(max_mana, current_mana + get_item_stat_bonus("start_mana"))
	skill_power += get_item_stat_bonus("sp_atk")

	# Immediate special effects
	if has_held_item("assault_vest"):
		shield += max_hp * 0.40
	if has_held_item("choice_specs"):
		current_mana = max_mana

func _update_item_icons_display() -> void:
	if not is_node_ready():
		return
	var ui_overlay = get_node_or_null("UIOverlay")
	if ui_overlay == null:
		return
	var item_box = ui_overlay.get_node_or_null("ItemContainer") as HBoxContainer
	if item_box == null:
		item_box = HBoxContainer.new()
		item_box.name = "ItemContainer"
		item_box.custom_minimum_size = Vector2(48, 14)
		item_box.layout_mode = 1
		item_box.anchors_preset = Control.PRESET_TOP_WIDE
		item_box.offset_top = -22.0
		item_box.offset_bottom = -10.0
		item_box.alignment = BoxContainer.ALIGNMENT_CENTER
		item_box.add_theme_constant_override("separation", 2)
		item_box.mouse_filter = Control.MOUSE_FILTER_IGNORE
		ui_overlay.add_child(item_box)

	for c in item_box.get_children():
		c.queue_free()

	for item_id in held_items:
		var db_item = ItemDatabase.get_item(item_id)
		var icon_p = db_item.get("icon_path", "")
		if ResourceLoader.exists(icon_p):
			var tr = TextureRect.new()
			tr.custom_minimum_size = Vector2(12, 12)
			tr.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
			tr.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
			tr.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
			tr.texture = load(icon_p)
			tr.mouse_filter = Control.MOUSE_FILTER_IGNORE
			item_box.add_child(tr)
