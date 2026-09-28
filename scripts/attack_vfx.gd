extends Node2D
class_name AttackVFX

# Modular, high-impact Basic Attack Animation & Visual Effects System for Pokemon Auto-Chess
# Supports distinctive melee slashes, heavy punches, dragon bites, and animated ranged projectiles.

# -------------------------------------------------------------
# 1. MELEE ATTACK VISUAL EFFECTS
# -------------------------------------------------------------

static func spawn_melee_attack_vfx(parent: Node2D, from_pos: Vector2, target: Unit, style: String, is_combo: bool = false) -> void:
	if not is_instance_valid(parent) or not is_instance_valid(target):
		return
		
	var target_pos = target.position
	var dir = (target_pos - from_pos).normalized()
	
	match style:
		"slash":
			_spawn_slash_arc(parent, target_pos, dir, is_combo, target.pokemon_id)
		"bite":
			_spawn_bite_vfx(parent, target_pos, dir, is_combo, target.pokemon_id)
		"punch":
			_spawn_punch_impact(parent, target_pos, dir, is_combo, target.pokemon_id)
		"tackle":
			_spawn_tackle_impact(parent, target_pos, dir, is_combo, target.pokemon_id)
		"water_bash":
			_spawn_water_bash(parent, target_pos, dir, is_combo)
		_:
			_spawn_punch_impact(parent, target_pos, dir, is_combo, target.pokemon_id)

# 1.1 Sharp Curved Slash Arc (Lucario, Gengar, Charizard)
static func _spawn_slash_arc(parent: Node2D, target_pos: Vector2, dir: Vector2, is_combo: bool, pid: String) -> void:
	var slash_node = Node2D.new()
	slash_node.z_index = 45
	slash_node.position = target_pos
	slash_node.rotation = dir.angle() + deg_to_rad(randf_range(-15, 15))
	parent.add_child(slash_node)
	
	var col = Color(0.3, 0.85, 1.0) # Default Azure (Lucario)
	if pid == "gengar":
		col = Color(0.75, 0.35, 1.0) # Phantom Violet
	elif pid in ["charizard", "growlithe"]:
		col = Color(1.0, 0.45, 0.15) # Flame Red
		
	var slash_draw = _SlashDraw.new()
	slash_draw.blade_color = col
	slash_draw.scale_mult = 1.4 if is_combo else 1.0
	slash_node.add_child(slash_draw)
	
	# Flying spark particles along slash cut
	var cpu = CPUParticles2D.new()
	cpu.emitting = true
	cpu.one_shot = true
	cpu.explosiveness = 0.9
	cpu.amount = 12 if not is_combo else 18
	cpu.lifetime = 0.25
	cpu.direction = Vector2(dir.y, -dir.x) # perpendicular to slash
	cpu.spread = 45.0
	cpu.gravity = Vector2.ZERO
	cpu.initial_velocity_min = 50.0
	cpu.initial_velocity_max = 110.0
	cpu.scale_amount_min = 2.5
	cpu.scale_amount_max = 5.0
	cpu.color = col
	slash_node.add_child(cpu)
	
	var tw = slash_node.create_tween()
	tw.tween_method(slash_draw.set_progress, 0.0, 1.0, 0.14).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tw.tween_callback(func():
		if is_instance_valid(slash_node):
			slash_node.queue_free()
	)

# 1.2 Dual Fang Clamping Bite (Gyarados, Growlithe)
static func _spawn_bite_vfx(parent: Node2D, target_pos: Vector2, dir: Vector2, is_combo: bool, pid: String) -> void:
	var bite_node = Node2D.new()
	bite_node.z_index = 45
	bite_node.position = target_pos
	bite_node.rotation = dir.angle()
	parent.add_child(bite_node)
	
	var col = Color(0.2, 0.6, 1.0) if pid == "gyarados" else Color(1.0, 0.45, 0.1)
	var bite_draw = _BiteDraw.new()
	bite_draw.fang_color = col
	bite_draw.scale_mult = 1.35 if is_combo else 1.0
	bite_node.add_child(bite_draw)
	
	var tw = bite_node.create_tween()
	tw.tween_method(bite_draw.set_progress, 0.0, 1.0, 0.16).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tw.tween_callback(func():
		if is_instance_valid(bite_node):
			bite_node.queue_free()
	)

# 1.3 Heavy Punch / Slam Shockwave (Machop, Snorlax, Electabuzz)
static func _spawn_punch_impact(parent: Node2D, target_pos: Vector2, dir: Vector2, is_combo: bool, pid: String) -> void:
	var punch_node = Node2D.new()
	punch_node.z_index = 45
	punch_node.position = target_pos
	parent.add_child(punch_node)
	
	var col = Color(1.0, 0.75, 0.2) # Machop fighting gold
	if pid == "electabuzz":
		col = Color(1.0, 0.95, 0.3) # Lightning yellow
	elif pid == "snorlax":
		col = Color(0.9, 0.85, 0.7) # Earth thud
		
	var punch_draw = _PunchDraw.new()
	punch_draw.impact_color = col
	punch_draw.is_heavy = is_combo or (pid == "snorlax")
	punch_node.add_child(punch_draw)
	
	var cpu = CPUParticles2D.new()
	cpu.emitting = true
	cpu.one_shot = true
	cpu.explosiveness = 0.95
	cpu.amount = 14 if not is_combo else 22
	cpu.lifetime = 0.30
	cpu.spread = 180.0
	cpu.gravity = Vector2(0, 40)
	cpu.initial_velocity_min = 40.0
	cpu.initial_velocity_max = 120.0
	cpu.scale_amount_min = 3.0
	cpu.scale_amount_max = 6.0
	cpu.color = col
	punch_node.add_child(cpu)
	
	var tw = punch_node.create_tween()
	tw.tween_method(punch_draw.set_progress, 0.0, 1.0, 0.18).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tw.tween_callback(func():
		if is_instance_valid(punch_node):
			punch_node.queue_free()
	)

# 1.4 Water Shell Bash (Squirtle)
static func _spawn_water_bash(parent: Node2D, target_pos: Vector2, dir: Vector2, is_combo: bool) -> void:
	var node = Node2D.new()
	node.z_index = 45
	node.position = target_pos
	parent.add_child(node)
	
	var col = Color(0.25, 0.75, 1.0)
	var cpu = CPUParticles2D.new()
	cpu.emitting = true
	cpu.one_shot = true
	cpu.explosiveness = 0.92
	cpu.amount = 16 if not is_combo else 24
	cpu.lifetime = 0.32
	cpu.spread = 180.0
	cpu.gravity = Vector2(0, 60)
	cpu.initial_velocity_min = 50.0
	cpu.initial_velocity_max = 110.0
	cpu.scale_amount_min = 3.5
	cpu.scale_amount_max = 6.5
	cpu.color = col
	node.add_child(cpu)
	
	var ripple = _PunchDraw.new()
	ripple.impact_color = col
	ripple.is_heavy = is_combo
	node.add_child(ripple)
	
	var tw = node.create_tween()
	tw.tween_method(ripple.set_progress, 0.0, 1.0, 0.20)
	tw.tween_callback(func():
		if is_instance_valid(node):
			node.queue_free()
	)

# 1.5 Heavy Body Tackle Shockwave (Normal/Bug/Rock units, Caterpie, Eevee, Geodude)
static func _spawn_tackle_impact(parent: Node2D, target_pos: Vector2, dir: Vector2, is_combo: bool, _pid: String) -> void:
	var tackle_node = Node2D.new()
	tackle_node.z_index = 45
	tackle_node.position = target_pos
	tackle_node.rotation = dir.angle()
	parent.add_child(tackle_node)
	
	var tackle_draw = _TackleDraw.new()
	tackle_draw.is_heavy = is_combo
	tackle_node.add_child(tackle_draw)
	
	# Air burst and dust particles along tackle direction
	var cpu = CPUParticles2D.new()
	cpu.emitting = true
	cpu.one_shot = true
	cpu.explosiveness = 0.95
	cpu.amount = 14 if not is_combo else 22
	cpu.lifetime = 0.26
	cpu.spread = 45.0
	cpu.gravity = Vector2.ZERO
	cpu.initial_velocity_min = 60.0
	cpu.initial_velocity_max = 140.0
	cpu.scale_amount_min = 2.5
	cpu.scale_amount_max = 5.5
	cpu.color = Color(1.0, 0.95, 0.85, 0.85)
	tackle_node.add_child(cpu)
	
	var tw = tackle_node.create_tween()
	tw.tween_method(tackle_draw.set_progress, 0.0, 1.0, 0.18).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tw.tween_callback(func():
		if is_instance_valid(tackle_node):
			tackle_node.queue_free()
	)

# -------------------------------------------------------------
# 2. RANGED ATTACK PROJECTILES
# -------------------------------------------------------------

static func spawn_ranged_projectile(parent: Node2D, from_pos: Vector2, target: Unit, pid: String, is_combo: bool, on_hit: Callable, custom_style: String = "") -> void:
	if not is_instance_valid(parent) or not is_instance_valid(target):
		return
		
	var proj = Node2D.new()
	proj.z_index = 42
	proj.position = from_pos
	parent.add_child(proj)
	
	# Determine projectile archetype & style
	var atk_style = custom_style
	if atk_style == "":
		var b_info = PokemonDatabase.get_basic_attack(pid)
		atk_style = b_info.get("style", "")
	if atk_style == "" and pid in ["lapras", "articuno"]:
		atk_style = "powder_snow"
	elif atk_style == "" and pid in ["eevee", "clefairy", "clefable"]:
		atk_style = "magic_spark"
		
	var proj_col = _get_projectile_color(pid, atk_style)
	
	# Projectile visual core
	var core = _ProjectileDraw.new()
	core.pid = pid
	core.style = atk_style
	core.proj_color = proj_col
	core.is_combo = is_combo
	proj.add_child(core)
	
	# Trailing particles with matching elemental color
	var trail = CPUParticles2D.new()
	trail.emitting = true
	trail.amount = 18 if not is_combo else 28
	trail.lifetime = 0.22
	trail.scale_amount_min = 2.5
	trail.scale_amount_max = 5.2
	trail.direction = Vector2(-1, 0)
	trail.spread = 28.0
	trail.gravity = Vector2.ZERO
	trail.initial_velocity_min = 35.0
	trail.initial_velocity_max = 85.0
	trail.color = proj_col
	proj.add_child(trail)
	
	var target_pos = target.position
	var dist = from_pos.distance_to(target_pos)
	var travel_time = clamp(dist / 680.0, 0.12, 0.24)
	
	# Dynamic Parabolic Arc Trajectory
	var arc_height = clamp(dist * 0.18, 14.0, 38.0)
	var mid_pos = (from_pos + target_pos) * 0.5 + Vector2(0, -arc_height)
	
	var tw = proj.create_tween()
	tw.tween_method(func(t: float):
		if not is_instance_valid(proj):
			return
		var p0 = from_pos
		var p1 = mid_pos
		var p2 = target_pos
		var cur_p = (1.0 - t) * (1.0 - t) * p0 + 2.0 * (1.0 - t) * t * p1 + t * t * p2
		proj.position = cur_p
		if t < 0.95:
			var nt = min(1.0, t + 0.05)
			var nxt_p = (1.0 - nt) * (1.0 - nt) * p0 + 2.0 * (1.0 - nt) * nt * p1 + nt * nt * p2
			proj.rotation = (nxt_p - cur_p).angle()
	, 0.0, 1.0, travel_time).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	# Continuous spin on visual core ONLY for non-directional projectiles (leaves, sparks, stars, snowflakes)
	# Directional shapes (fire ember flame, water droplet, toxic sludge, psywave) must face forward along tangent!
	var should_spin = atk_style in ["leaf", "spark", "magic_spark", "swift", "powder_snow", "ice_shard"] or pid in ["eevee", "lapras"]
	if should_spin:
		tw.parallel().tween_property(core, "rotation", deg_to_rad(360.0 if not is_combo else 720.0), travel_time)
	
	tw.tween_callback(func():
		if is_instance_valid(proj):
			proj.queue_free()
		# Spawn explosion impact at target
		if is_instance_valid(parent):
			spawn_hit_impact(parent, target_pos, proj_col, is_combo)
		if on_hit.is_valid():
			var target_obj = on_hit.get_object()
			if target_obj == null or target_obj is Script or (is_instance_valid(target_obj) and target_obj.get_script() != null):
				on_hit.call()
	)

static func _get_projectile_color(pid: String, style: String = "") -> Color:
	match style:
		"fire_ember":
			return Color(1.0, 0.45, 0.12)
		"water_bullet":
			return Color(0.25, 0.80, 1.0)
		"spark":
			return Color(1.0, 0.92, 0.20)
		"leaf":
			return Color(0.35, 0.95, 0.40)
		"psywave":
			return Color(0.95, 0.40, 0.85)
		"shadow_orb":
			return Color(0.75, 0.35, 1.0)
		"magic_spark", "swift":
			return Color(1.0, 0.90, 0.35)
		"powder_snow", "ice_shard":
			return Color(0.55, 0.88, 1.0)
		"sludge_bullet":
			return Color(0.75, 0.25, 0.85)

	match pid:
		"pikachu":
			return Color(1.0, 0.92, 0.2)  # Gold Spark
		"charmander", "charizard":
			return Color(1.0, 0.45, 0.12) # Fireball
		"bulbasaur":
			return Color(0.35, 0.95, 0.4)  # Razor Leaf
		"lapras":
			return Color(0.55, 0.88, 1.0)  # Ice Shard
		"psyduck":
			return Color(0.30, 0.80, 1.0)  # Water Pulse
		"gengar":
			return Color(0.75, 0.35, 1.0)  # Shadow Orb
		"alakazam":
			return Color(0.95, 0.40, 0.85) # Psybeam
		"mewtwo":
			return Color(0.90, 0.30, 0.95) # Psystrike
		"dragonite":
			return Color(0.35, 0.60, 1.0)  # Dragon Pulse
		"eevee":
			return Color(1.0, 0.90, 0.35)  # Swift Star
		_:
			var data = PokemonDatabase.get_pokemon(pid)
			var types = data.get("types", [])
			if types.has("Fire"):
				return Color(1.0, 0.45, 0.12)
			elif types.has("Water"):
				return Color(0.25, 0.75, 1.0)
			elif types.has("Electric"):
				return Color(1.0, 0.92, 0.2)
			elif types.has("Grass"):
				return Color(0.35, 0.95, 0.4)
			elif types.has("Ice"):
				return Color(0.55, 0.88, 1.0)
			elif types.has("Psychic"):
				return Color(0.95, 0.40, 0.85)
			elif types.has("Ghost"):
				return Color(0.75, 0.35, 1.0)
			elif types.has("Poison"):
				return Color(0.75, 0.25, 0.85)
			return Color(1.0, 0.85, 0.4)

# -------------------------------------------------------------
# 3. HIT IMPACT BURST
# -------------------------------------------------------------

static func spawn_hit_impact(parent: Node2D, pos: Vector2, color: Color, is_combo: bool = false) -> void:
	if not is_instance_valid(parent):
		return
	var impact = Node2D.new()
	impact.z_index = 46
	impact.position = pos
	parent.add_child(impact)
	
	# Flash circle
	var draw_node = _PunchDraw.new()
	draw_node.impact_color = color
	draw_node.is_heavy = is_combo
	impact.add_child(draw_node)
	
	# Sparks burst
	var cpu = CPUParticles2D.new()
	cpu.emitting = true
	cpu.one_shot = true
	cpu.explosiveness = 0.95
	cpu.amount = 10 if not is_combo else 18
	cpu.lifetime = 0.22
	cpu.spread = 180.0
	cpu.gravity = Vector2.ZERO
	cpu.initial_velocity_min = 40.0
	cpu.initial_velocity_max = 95.0
	cpu.scale_amount_min = 2.5
	cpu.scale_amount_max = 5.0
	cpu.color = color
	impact.add_child(cpu)
	
	var tw = impact.create_tween()
	tw.tween_method(draw_node.set_progress, 0.0, 1.0, 0.16)
	tw.tween_callback(func():
		if is_instance_valid(impact):
			impact.queue_free()
	)

# -------------------------------------------------------------
# 4. CRITICAL HIT & DODGE SPECIAL VFX
# -------------------------------------------------------------

static func spawn_crit_impact(parent: Node2D, pos: Vector2) -> void:
	if not is_instance_valid(parent):
		return
	var crit_node = Node2D.new()
	crit_node.z_index = 48
	crit_node.position = pos
	parent.add_child(crit_node)
	
	var draw_node = _CritDraw.new()
	crit_node.add_child(draw_node)
	
	# Flying sparks burst
	var cpu = CPUParticles2D.new()
	cpu.emitting = true
	cpu.one_shot = true
	cpu.explosiveness = 0.95
	cpu.amount = 18
	cpu.lifetime = 0.28
	cpu.spread = 180.0
	cpu.gravity = Vector2.ZERO
	cpu.initial_velocity_min = 70.0
	cpu.initial_velocity_max = 150.0
	cpu.scale_amount_min = 3.0
	cpu.scale_amount_max = 6.0
	cpu.color = Color(1.0, 0.8, 0.2)
	crit_node.add_child(cpu)
	
	var tw = crit_node.create_tween()
	tw.tween_method(draw_node.set_progress, 0.0, 1.0, 0.24)
	tw.tween_callback(func():
		if is_instance_valid(crit_node):
			crit_node.queue_free()
	)

static func spawn_dodge_vfx(parent: Node2D, pos: Vector2, dir: Vector2 = Vector2.ZERO) -> void:
	if not is_instance_valid(parent):
		return
	var dodge_node = Node2D.new()
	dodge_node.z_index = 44
	dodge_node.position = pos
	parent.add_child(dodge_node)
	
	var draw_node = _DodgeDraw.new()
	draw_node.dodge_dir = dir
	dodge_node.add_child(draw_node)
	
	# Wind puff particles
	var cpu = CPUParticles2D.new()
	cpu.emitting = true
	cpu.one_shot = true
	cpu.explosiveness = 0.85
	cpu.amount = 10
	cpu.lifetime = 0.22
	cpu.spread = 60.0
	cpu.direction = -dir.normalized() if dir.length_squared() > 0.01 else Vector2(-1, 0)
	cpu.gravity = Vector2.ZERO
	cpu.initial_velocity_min = 40.0
	cpu.initial_velocity_max = 80.0
	cpu.scale_amount_min = 2.0
	cpu.scale_amount_max = 4.0
	cpu.color = Color(0.6, 0.9, 1.0, 0.8)
	dodge_node.add_child(cpu)
	
	var tw = dodge_node.create_tween()
	tw.tween_method(draw_node.set_progress, 0.0, 1.0, 0.20)
	tw.tween_callback(func():
		if is_instance_valid(dodge_node):
			dodge_node.queue_free()
	)

# -------------------------------------------------------------
# CUSTOM DRAWING HELPERS
# -------------------------------------------------------------

class _SlashDraw extends Node2D:
	var blade_color: Color = Color.CYAN
	var scale_mult: float = 1.0
	var progress: float = 0.0

	func set_progress(p: float) -> void:
		progress = p
		queue_redraw()

	func _draw() -> void:
		var alpha = clamp(1.0 - progress, 0.0, 1.0)
		var r = 26.0 * scale_mult * (0.8 + 0.4 * progress)
		var width = lerp(4.5, 0.5, progress)
		var col_glow = Color(blade_color.r, blade_color.g, blade_color.b, alpha * 0.45)
		var col_core = Color(1.0, 1.0, 1.0, alpha)
		
		# Triple razor claw cuts
		# 1. Main center slash
		draw_arc(Vector2.ZERO, r, deg_to_rad(-50), deg_to_rad(50), 20, col_glow, width * 2.2, true)
		draw_arc(Vector2.ZERO, r, deg_to_rad(-45), deg_to_rad(45), 20, col_core, width, true)
		
		# 2. Upper claw cut
		var r_up = r * 1.18
		var offset_up = Vector2(-2, -6)
		draw_arc(offset_up, r_up, deg_to_rad(-42), deg_to_rad(38), 16, col_glow, width * 1.4, true)
		draw_arc(offset_up, r_up, deg_to_rad(-38), deg_to_rad(34), 16, col_core, width * 0.75, true)
		
		# 3. Lower claw cut
		var r_down = r * 0.82
		var offset_down = Vector2(2, 6)
		draw_arc(offset_down, r_down, deg_to_rad(-38), deg_to_rad(42), 16, col_glow, width * 1.4, true)
		draw_arc(offset_down, r_down, deg_to_rad(-34), deg_to_rad(38), 16, col_core, width * 0.75, true)

class _TackleDraw extends Node2D:
	var is_heavy: bool = false
	var progress: float = 0.0

	func set_progress(p: float) -> void:
		progress = p
		queue_redraw()

	func _draw() -> void:
		var alpha = clamp(1.0 - progress, 0.0, 1.0)
		var base_r = 30.0 if is_heavy else 22.0
		var r = lerp(6.0, base_r, progress)
		
		# 1. Forward conical shockwave arc
		var col_wave = Color(1.0, 0.95, 0.8, alpha * 0.9)
		var col_glow = Color(1.0, 0.8, 0.4, alpha * 0.4)
		var cone_w = lerp(4.0, 0.8, progress)
		draw_arc(Vector2.ZERO, r, deg_to_rad(-65), deg_to_rad(65), 20, col_glow, cone_w * 2.2, true)
		draw_arc(Vector2.ZERO, r, deg_to_rad(-60), deg_to_rad(60), 20, col_wave, cone_w, true)
		
		# 2. Air compression lines trailing backwards
		var streak_len = lerp(8.0, 26.0, progress)
		var streak_col = Color(1.0, 1.0, 1.0, alpha * 0.75)
		draw_line(Vector2(-4, -10), Vector2(-4 - streak_len, -14), streak_col, 1.8, true)
		draw_line(Vector2(2, 0), Vector2(2 - streak_len * 1.2, 0), streak_col, 2.2, true)
		draw_line(Vector2(-4, 10), Vector2(-4 - streak_len, 14), streak_col, 1.8, true)
		
		# 3. Blunt impact flash
		if progress < 0.35:
			var flash_alpha = 1.0 - progress / 0.35
			draw_circle(Vector2.ZERO, lerp(4.0, 10.0, progress / 0.35), Color(1.0, 1.0, 1.0, flash_alpha * 0.85))

class _BiteDraw extends Node2D:
	var fang_color: Color = Color.BLUE
	var scale_mult: float = 1.0
	var progress: float = 0.0

	func set_progress(p: float) -> void:
		progress = p
		queue_redraw()

	func _draw() -> void:
		var alpha = clamp(1.0 - progress, 0.0, 1.0)
		var clamp_offset = lerp(22.0 * scale_mult, 2.0, min(progress * 2.0, 1.0))
		var col = Color(fang_color.r, fang_color.g, fang_color.b, alpha)
		var col_white = Color(1.0, 1.0, 1.0, alpha)
		# Upper fang
		var pts_up = PackedVector2Array([Vector2(-12, -clamp_offset), Vector2(12, -clamp_offset), Vector2(0, -clamp_offset + 14)])
		draw_colored_polygon(pts_up, col)
		draw_polyline(pts_up, col_white, 1.5)
		# Lower fang
		var pts_down = PackedVector2Array([Vector2(-12, clamp_offset), Vector2(12, clamp_offset), Vector2(0, clamp_offset - 14)])
		draw_colored_polygon(pts_down, col)
		draw_polyline(pts_down, col_white, 1.5)

class _PunchDraw extends Node2D:
	var impact_color: Color = Color.YELLOW
	var is_heavy: bool = false
	var progress: float = 0.0

	func set_progress(p: float) -> void:
		progress = p
		queue_redraw()

	func _draw() -> void:
		var alpha = clamp(1.0 - progress, 0.0, 1.0)
		var max_r = 34.0 if is_heavy else 24.0
		var r = lerp(6.0, max_r, progress)
		var w = lerp(4.0, 0.5, progress)
		var col = Color(impact_color.r, impact_color.g, impact_color.b, alpha)
		var col_glow = Color(impact_color.r, impact_color.g, impact_color.b, alpha * 0.35)
		draw_arc(Vector2.ZERO, r, 0, TAU, 24, col_glow, w * 2.0, true)
		draw_arc(Vector2.ZERO, r, 0, TAU, 24, col, w, true)
		# Inner flash
		if progress < 0.3:
			var flash_r = lerp(4.0, 12.0, progress / 0.3)
			draw_circle(Vector2.ZERO, flash_r, Color(1.0, 1.0, 1.0, 0.8 * (1.0 - progress / 0.3)))

class _ProjectileDraw extends Node2D:
	var pid: String = ""
	var style: String = ""
	var proj_color: Color = Color.YELLOW
	var is_combo: bool = false
	var anim_time: float = 0.0

	func _process(delta: float) -> void:
		anim_time += delta
		queue_redraw()

	func _draw() -> void:
		var r_mult = 1.3 if is_combo else 1.0
		
		# Match attack style for animated procedural projectile visuals conforming to skill descriptions
		match style:
			"fire_ember":
				# Fire Ember: Dynamic flickering flame pointing +X with fluttering tail tongues and dancing sparks
				var r = 8.5 * r_mult
				var t1 = sin(anim_time * 24.0) * 3.0
				var t2 = cos(anim_time * 28.0 + 1.2) * 4.0
				var t3 = sin(anim_time * 26.0 + 2.4) * 3.0

				var outer_pts = PackedVector2Array([
					Vector2(r * 1.3, 0),
					Vector2(r * 0.8, -r * 0.7),
					Vector2(0, -r * 0.9),
					Vector2(-r * 0.9, -r * 0.7 + t1),
					Vector2(-r * 1.5 + t2, 0),
					Vector2(-r * 0.9, r * 0.7 + t3),
					Vector2(0, r * 0.9),
					Vector2(r * 0.8, r * 0.7)
				])
				draw_colored_polygon(outer_pts, Color(1.0, 0.30, 0.05, 0.95))

				var mid_pts = PackedVector2Array([
					Vector2(r * 0.95, 0),
					Vector2(r * 0.5, -r * 0.45),
					Vector2(0, -r * 0.55),
					Vector2(-r * 0.7, -r * 0.35 + t1 * 0.6),
					Vector2(-r * 1.1 + t2 * 0.6, 0),
					Vector2(-r * 0.7, r * 0.35 + t3 * 0.6),
					Vector2(0, r * 0.55),
					Vector2(r * 0.5, r * 0.45)
				])
				draw_colored_polygon(mid_pts, Color(1.0, 0.78, 0.15, 0.95))

				# Hot white-yellow core
				draw_circle(Vector2(r * 0.2, 0), r * 0.42, Color(1.0, 0.98, 0.85, 0.95))

				# Detached dancing sparks behind flame
				var spark1 = Vector2(-r * 1.8 + sin(anim_time * 30.0) * 2.0, t1 * 0.8)
				var spark2 = Vector2(-r * 2.3 + cos(anim_time * 25.0) * 2.0, -t3 * 0.8)
				draw_circle(spark1, 1.8 * r_mult, Color(1.0, 0.65, 0.1, 0.85))
				draw_circle(spark2, 1.3 * r_mult, Color(1.0, 0.85, 0.2, 0.75))
				return

			"water_bullet":
				# Water Bullet: Hydrodynamic teardrop pointing +X with fluid wobble & glossy specular reflection
				var r = 8.0 * r_mult
				var wobble = sin(anim_time * 20.0) * 0.8
				var water_pts = PackedVector2Array([
					Vector2(r * 1.35, 0),
					Vector2(r * 0.7, -r * 0.75 - wobble),
					Vector2(-r * 0.3, -r * 0.85),
					Vector2(-r * 1.1, -r * 0.4),
					Vector2(-r * 1.4, 0),
					Vector2(-r * 1.1, r * 0.4),
					Vector2(-r * 0.3, r * 0.85),
					Vector2(r * 0.7, r * 0.75 + wobble)
				])
				draw_colored_polygon(water_pts, Color(0.2, 0.75, 1.0, 0.4))
				var inner_water = PackedVector2Array()
				for pt in water_pts:
					inner_water.append(pt * 0.82)
				draw_colored_polygon(inner_water, Color(0.25, 0.85, 1.0, 0.92))
				# Specular highlight
				draw_circle(Vector2(r * 0.4, -r * 0.35), r * 0.28, Color(1.0, 1.0, 1.0, 0.9))
				# Trailing droplets
				draw_circle(Vector2(-r * 1.7, 0), r * 0.28, Color(0.4, 0.9, 1.0, 0.7))
				draw_circle(Vector2(-r * 2.2, sin(anim_time * 15.0) * 2.0), r * 0.18, Color(0.5, 0.95, 1.0, 0.6))
				return

			"spark":
				# Electric Spark: Crackling 6-point jagged lightning star with jitter & micro electric arcs
				var r = 8.5 * r_mult
				var jitter = sin(anim_time * 40.0) * 1.5
				var pts = PackedVector2Array([
					Vector2(0, -r * 1.2),
					Vector2(r * 0.3 + jitter, -r * 0.4),
					Vector2(r * 1.2, -r * 0.2),
					Vector2(r * 0.5, r * 0.3),
					Vector2(r * 0.9 + jitter, r * 1.1),
					Vector2(0, r * 0.5),
					Vector2(-r * 0.9 - jitter, r * 1.0),
					Vector2(-r * 0.4, r * 0.2),
					Vector2(-r * 1.2, -r * 0.3),
					Vector2(-r * 0.3 - jitter, -r * 0.4)
				])
				draw_colored_polygon(pts, Color(1.0, 0.92, 0.2, 0.95))
				draw_circle(Vector2.ZERO, r * 0.45, Color.WHITE)
				var a1 = anim_time * 25.0
				var arc_p1 = Vector2(cos(a1), sin(a1)) * (r * 1.4)
				var arc_mid = Vector2(cos(a1 + 0.6), sin(a1 + 0.6)) * (r * 0.9)
				draw_line(Vector2.ZERO, arc_mid, Color(0.8, 1.0, 1.0, 0.8), 1.5)
				draw_line(arc_mid, arc_p1, Color(1.0, 1.0, 0.4, 0.9), 1.5)
				return

			"leaf":
				# Razor Leaf: Double spinning curved leaves with central veins
				var r = 8.5 * r_mult
				var spin = anim_time * 14.0
				var l1_tip = Vector2(cos(spin), sin(spin)) * (r * 1.2)
				var l1_base = -l1_tip * 0.2
				var l1_perp = Vector2(-sin(spin), cos(spin)) * (r * 0.6)
				var pts_l1 = PackedVector2Array([
					l1_base,
					l1_base + (l1_tip - l1_base) * 0.5 + l1_perp,
					l1_tip,
					l1_base + (l1_tip - l1_base) * 0.5 - l1_perp * 0.6
				])
				draw_colored_polygon(pts_l1, Color(0.2, 0.92, 0.35, 0.95))
				draw_line(l1_base, l1_tip, Color(0.85, 1.0, 0.6, 0.9), 1.2)

				var spin2 = spin + PI
				var l2_tip = Vector2(cos(spin2), sin(spin2)) * (r * 1.05)
				var l2_base = -l2_tip * 0.2
				var l2_perp = Vector2(-sin(spin2), cos(spin2)) * (r * 0.5)
				var pts_l2 = PackedVector2Array([
					l2_base,
					l2_base + (l2_tip - l2_base) * 0.5 + l2_perp,
					l2_tip,
					l2_base + (l2_tip - l2_base) * 0.5 - l2_perp * 0.6
				])
				draw_colored_polygon(pts_l2, Color(0.15, 0.82, 0.3, 0.95))
				draw_line(l2_base, l2_tip, Color(0.85, 1.0, 0.6, 0.9), 1.2)
				draw_circle(Vector2.ZERO, r * 0.25, Color(0.9, 1.0, 0.7, 0.9))
				return

			"psywave":
				# Psywave: Concentric expanding psychic wave rings + glowing nucleus
				var r = 8.0 * r_mult
				for i in range(3):
					var phase = fmod(anim_time * 3.5 + float(i) * 0.33, 1.0)
					var ring_r = lerp(4.0, 14.0 * r_mult, phase)
					var alpha = (1.0 - phase) * 0.8
					var col_wave = Color(0.95, 0.35, 0.9, alpha)
					draw_arc(Vector2.ZERO, ring_r, 0, TAU, 24, col_wave, 2.0, true)
				draw_circle(Vector2.ZERO, r * 0.6, Color(0.85, 0.2, 0.95, 0.9))
				draw_circle(Vector2.ZERO, r * 0.3, Color(1.0, 0.9, 1.0, 0.95))
				return

			"shadow_orb":
				# Shadow Orb: Ghostly purple orb with undulating shadowy flame wisps
				var r = 8.0 * r_mult
				var wisp_pts = PackedVector2Array()
				var steps = 16
				for i in range(steps):
					var a = float(i) * TAU / float(steps)
					var wave = sin(a * 4.0 + anim_time * 16.0) * (r * 0.35)
					var rad = r + wave
					wisp_pts.append(Vector2(cos(a) * rad, sin(a) * rad))
				draw_colored_polygon(wisp_pts, Color(0.4, 0.1, 0.65, 0.85))
				draw_circle(Vector2.ZERO, r * 0.65, Color(0.65, 0.2, 0.9, 0.95))
				var eye_offset = Vector2(cos(anim_time * 8.0), sin(anim_time * 8.0)) * 2.0
				draw_circle(eye_offset, r * 0.25, Color(1.0, 0.6, 1.0, 0.95))
				return

			"magic_spark", "swift":
				# 5-point swift star with orbiting star dust
				var col = Color(1.0, 0.9, 0.25)
				var r = 8.5 * r_mult
				var pts = PackedVector2Array()
				for i in range(10):
					var a = i * PI / 5.0 - PI / 2.0
					var rad = r if (i % 2 == 0) else (r * 0.45)
					pts.append(Vector2(cos(a) * rad, sin(a) * rad))
				draw_colored_polygon(pts, col)
				draw_circle(Vector2.ZERO, r * 0.35, Color.WHITE)
				for i in range(3):
					var dust_a = anim_time * 10.0 + float(i) * TAU / 3.0
					var dust_pos = Vector2(cos(dust_a), sin(dust_a)) * (r * 1.35)
					draw_circle(dust_pos, 1.4 * r_mult, Color(1.0, 0.95, 0.5, 0.8))
				return

			"powder_snow", "ice_shard":
				# Six-pointed crystalline snowflake / diamond ice shard
				var r = 8.5 * r_mult
				var col_white = Color(1.0, 1.0, 1.0, 0.95)
				for i in range(3):
					var a = float(i) * PI / 3.0 + anim_time * 4.0
					var v_len = Vector2(cos(a), sin(a)) * r
					var v_width = Vector2(-sin(a), cos(a)) * (r * 0.3)
					var diamond = PackedVector2Array([
						v_len,
						v_width,
						-v_len,
						-v_width
					])
					draw_colored_polygon(diamond, Color(0.5, 0.85, 1.0, 0.75))
					draw_line(-v_len, v_len, col_white, 1.2)
				draw_circle(Vector2.ZERO, r * 0.3, col_white)
				return

			"sludge_bullet":
				# Toxic Sludge Bullet: Viscous bubbling purple droplet
				var r = 7.5 * r_mult
				draw_circle(Vector2.ZERO, r * 1.2, Color(0.55, 0.15, 0.7, 0.7))
				draw_circle(Vector2.ZERO, r * 0.85, Color(0.7, 0.2, 0.85, 0.9))
				var b1_r = (sin(anim_time * 18.0) * 0.5 + 0.5) * (r * 0.4) + r * 0.1
				var b2_r = (cos(anim_time * 22.0) * 0.5 + 0.5) * (r * 0.35) + r * 0.1
				draw_circle(Vector2(r * 0.4, -r * 0.3), b1_r, Color(0.85, 0.4, 0.95, 0.85))
				draw_circle(Vector2(-r * 0.3, r * 0.35), b2_r, Color(0.85, 0.4, 0.95, 0.85))
				return

		# Fallback by Pokémon ID or default glowing energy comet
		match pid:
			"pikachu":
				# 4-point electric spark
				var col = Color(1.0, 0.95, 0.3)
				var r = 8.0 * r_mult
				var pts = PackedVector2Array([Vector2(0, -r), Vector2(r*0.35, -r*0.35), Vector2(r, 0), Vector2(r*0.35, r*0.35), Vector2(0, r), Vector2(-r*0.35, r*0.35), Vector2(-r, 0), Vector2(-r*0.35, -r*0.35)])
				draw_colored_polygon(pts, col)
				draw_circle(Vector2.ZERO, r * 0.4, Color.WHITE)
			"eevee":
				# 5-point swift star
				var col = Color(1.0, 0.9, 0.25)
				var r = 8.5 * r_mult
				var pts = PackedVector2Array()
				for i in range(10):
					var a = i * PI / 5.0 - PI / 2.0
					var rad = r if (i % 2 == 0) else (r * 0.45)
					pts.append(Vector2(cos(a) * rad, sin(a) * rad))
				draw_colored_polygon(pts, col)
				draw_circle(Vector2.ZERO, r * 0.3, Color.WHITE)
			"bulbasaur":
				# Curved spinning razor leaf
				var col = Color(0.3, 0.95, 0.35)
				var pts = PackedVector2Array([Vector2(-9*r_mult, 0), Vector2(0, -5*r_mult), Vector2(9*r_mult, 0), Vector2(0, 5*r_mult)])
				draw_colored_polygon(pts, col)
				draw_line(Vector2(-7*r_mult, 0), Vector2(7*r_mult, 0), Color.WHITE, 1.2)
			"lapras":
				# Ice crystal diamond
				var col = Color(0.6, 0.9, 1.0)
				var pts = PackedVector2Array([Vector2(0, -9*r_mult), Vector2(6*r_mult, 0), Vector2(0, 9*r_mult), Vector2(-6*r_mult, 0)])
				draw_colored_polygon(pts, col)
				draw_circle(Vector2.ZERO, 3.5 * r_mult, Color.WHITE)
			_:
				# Glowing energy comet (outer aura, body, bright forward core)
				var r = 7.5 * r_mult
				draw_circle(Vector2.ZERO, r * 1.4, Color(proj_color.r, proj_color.g, proj_color.b, 0.35))
				draw_circle(Vector2.ZERO, r, proj_color)
				draw_circle(Vector2(r * 0.2, 0), r * 0.5, Color.WHITE)

class _CritDraw extends Node2D:
	var progress: float = 0.0

	func set_progress(p: float) -> void:
		progress = p
		queue_redraw()

	func _draw() -> void:
		var alpha = clamp(1.0 - progress, 0.0, 1.0)
		var flare_len = lerp(12.0, 36.0, progress)
		var ring_r = lerp(8.0, 42.0, progress)
		
		# 1. Expanding golden shockwave ring
		var ring_col = Color(1.0, 0.8, 0.15, alpha * 0.7)
		var ring_glow = Color(1.0, 0.35, 0.1, alpha * 0.35)
		draw_arc(Vector2.ZERO, ring_r, 0, TAU, 32, ring_glow, 5.0, true)
		draw_arc(Vector2.ZERO, ring_r, 0, TAU, 32, ring_col, 2.0, true)
		
		# 2. Dramatic cross slash flares (X and + sharp flares)
		var col_flare = Color(1.0, 0.9, 0.25, alpha)
		var col_core = Color(1.0, 1.0, 1.0, alpha)
		var angles = [PI * 0.25, -PI * 0.25, 0.0, PI * 0.5]
		for a in angles:
			var p1 = Vector2(cos(a), sin(a)) * flare_len
			var p2 = -p1
			draw_line(p2, p1, col_flare, lerp(4.0, 1.0, progress), true)
			draw_line(p2 * 0.6, p1 * 0.6, col_core, lerp(2.0, 0.5, progress), true)
			
		# 3. Blinding center flare in early frames
		if progress < 0.35:
			var core_alpha = (1.0 - progress / 0.35)
			draw_circle(Vector2.ZERO, lerp(5.0, 14.0, progress / 0.35), Color(1.0, 1.0, 1.0, core_alpha * 0.9))
			draw_circle(Vector2.ZERO, lerp(8.0, 22.0, progress / 0.35), Color(1.0, 0.75, 0.2, core_alpha * 0.5))

class _DodgeDraw extends Node2D:
	var progress: float = 0.0
	var dodge_dir: Vector2 = Vector2.RIGHT

	func set_progress(p: float) -> void:
		progress = p
		queue_redraw()

	func _draw() -> void:
		var alpha = clamp(1.0 - progress, 0.0, 1.0)
		var d = dodge_dir.normalized() if dodge_dir.length_squared() > 0.01 else Vector2(1, -0.3).normalized()
		var perp = Vector2(-d.y, d.x)
		
		# Draw 3 swift wind ribbon arcs
		var col_wind = Color(0.4, 0.9, 1.0, alpha * 0.8)
		var col_white = Color(1.0, 1.0, 1.0, alpha * 0.9)
		
		for offset_idx in [-1, 0, 1]:
			var ribbon_center = perp * (offset_idx * 10.0) + d * (progress * 18.0)
			var w_len = lerp(24.0, 8.0, progress)
			var start_pt = ribbon_center - d * (w_len * 0.5)
			var end_pt = ribbon_center + d * (w_len * 0.5)
			draw_line(start_pt, end_pt, col_wind, lerp(3.0, 0.8, progress), true)
			draw_line(start_pt + d * 4.0, end_pt - d * 4.0, col_white, lerp(1.5, 0.5, progress), true)
