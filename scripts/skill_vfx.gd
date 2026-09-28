extends Node2D
class_name SkillVFX

# High-impact Animated Sprite 2D Visual Effects System for Pokemon Auto-Chess
# Powered by sequence sprite sheets in res://assets/vfx/<skill_name>/

static var _cached_sprite_frames: Dictionary = {}

static func get_skill_frames(skill_name: String, fps: float = 14.0) -> SpriteFrames:
	if _cached_sprite_frames.has(skill_name):
		return _cached_sprite_frames[skill_name]
		
	var sf = SpriteFrames.new()
	if not sf.has_animation("default"):
		sf.add_animation("default")
	sf.set_animation_loop("default", false)
	sf.set_animation_speed("default", fps)
	
	var base_dir = "res://assets/vfx/%s" % skill_name
	var idx = 0
	while true:
		var frame_path = "%s/frame_%d.png" % [base_dir, idx]
		if ResourceLoader.exists(frame_path):
			sf.add_frame("default", load(frame_path))
			idx += 1
		else:
			break
			
	_cached_sprite_frames[skill_name] = sf
	return sf

# -------------------------------------------------------------
# 1. 十万伏特 (Thunderbolt - Pikachu)
# -------------------------------------------------------------
static func spawn_thunderbolt(parent: Node2D, target_pos: Vector2, scale_factor: float = 1.0) -> void:
	var vfx = Node2D.new()
	vfx.z_index = 40
	vfx.position = target_pos
	parent.add_child(vfx)
	
	var sf = get_skill_frames("thunderbolt", 15.0)
	var anim = AnimatedSprite2D.new()
	anim.sprite_frames = sf
	# Thunderbolt frame (240x360): scaled down to ~115x170px, anchored onto target
	anim.position = Vector2(0, -78)
	anim.scale = Vector2(0.48, 0.48) * scale_factor * scale_factor
	vfx.add_child(anim)
	anim.play("default")
	
	# Electric spark burst
	var cpu = CPUParticles2D.new()
	cpu.emitting = true
	cpu.one_shot = true
	cpu.explosiveness = 0.95
	cpu.amount = 14
	cpu.lifetime = 0.35
	cpu.spread = 180.0
	cpu.gravity = Vector2.ZERO
	cpu.initial_velocity_min = 45.0
	cpu.initial_velocity_max = 95.0
	cpu.scale_amount_min = 2.0
	cpu.scale_amount_max = 3.5
	cpu.color = Color(1.0, 0.95, 0.35, 1.0)
	vfx.add_child(cpu)
	
	anim.animation_finished.connect(func():
		var tw = vfx.create_tween()
		tw.tween_property(vfx, "modulate:a", 0.0, 0.1)
		tw.tween_callback(vfx.queue_free)
	)

# -------------------------------------------------------------
# 2. 喷射火焰 / 大字爆炎 (Flamethrower / Fire Blast - Charmander, Charizard)
# -------------------------------------------------------------
static func spawn_flamethrower(parent: Node2D, origin_pos: Vector2, target_pos: Vector2, scale_factor: float = 1.0) -> void:
	var vfx = Node2D.new()
	vfx.z_index = 40
	vfx.position = origin_pos
	parent.add_child(vfx)
	
	var dir = (target_pos - origin_pos).normalized()
	var angle = dir.angle()
	
	var sf = get_skill_frames("flamethrower", 16.0)
	var anim = AnimatedSprite2D.new()
	anim.sprite_frames = sf
	anim.rotation = angle
	# Offset so the flame base (x=24) begins cleanly right in front of the caster
	anim.offset = Vector2(106, 0)
	anim.position = dir * 18.0
	# Scaled down by 20% to Vector2(0.44, 0.44)
	anim.scale = Vector2(0.44, 0.44) * scale_factor
	vfx.add_child(anim)
	anim.play("default")
	
	# Flying flame spark particles
	var burst = CPUParticles2D.new()
	burst.position = target_pos - origin_pos
	burst.emitting = true
	burst.one_shot = true
	burst.explosiveness = 0.9
	burst.amount = 14
	burst.lifetime = 0.4
	burst.spread = 180.0
	burst.gravity = Vector2(0, -20)
	burst.initial_velocity_min = 40.0
	burst.initial_velocity_max = 90.0
	burst.scale_amount_min = 2.0
	burst.scale_amount_max = 4.0
	burst.color = Color(1.0, 0.5, 0.1, 1.0)
	vfx.add_child(burst)
	
	anim.animation_finished.connect(func():
		var tw = vfx.create_tween()
		tw.tween_property(vfx, "modulate:a", 0.0, 0.1)
		tw.tween_callback(vfx.queue_free)
	)

# -------------------------------------------------------------
# 3. 水炮 / 水流尾 (Hydro Pump / Aqua Tail - Squirtle, Gyarados)
# -------------------------------------------------------------
static func spawn_hydro_pump(parent: Node2D, origin_pos: Vector2, target_pos: Vector2, scale_factor: float = 1.0) -> void:
	var vfx = Node2D.new()
	vfx.z_index = 40
	vfx.position = origin_pos
	parent.add_child(vfx)
	
	var dir = (target_pos - origin_pos).normalized()
	var dist = origin_pos.distance_to(target_pos)
	
	# High-pressure water jet stream beam (slimmed by 20%)
	var line = Line2D.new()
	line.width = 11.0 * scale_factor
	line.default_color = Color(0.2, 0.65, 1.0, 0.85)
	line.begin_cap_mode = Line2D.LINE_CAP_ROUND
	line.end_cap_mode = Line2D.LINE_CAP_ROUND
	line.points = PackedVector2Array([Vector2.ZERO, dir * dist])
	vfx.add_child(line)
	
	var inner_line = Line2D.new()
	inner_line.width = 5.5 * scale_factor
	inner_line.default_color = Color(0.85, 0.95, 1.0, 0.95)
	inner_line.points = line.points
	vfx.add_child(inner_line)
	
	var l_tw = line.create_tween().set_parallel(true)
	l_tw.tween_property(line, "width", 0.0, 0.22).set_delay(0.08)
	l_tw.tween_property(inner_line, "width", 0.0, 0.22).set_delay(0.08)
	
	# Crashing wave animation at target (scaled down by 20% to Vector2(0.38, 0.38))
	var sf = get_skill_frames("hydro_pump", 14.0)
	var anim = AnimatedSprite2D.new()
	anim.sprite_frames = sf
	anim.position = target_pos - origin_pos
	anim.scale = Vector2(0.38, 0.38) * scale_factor
	vfx.add_child(anim)
	anim.play("default")
	
	anim.animation_finished.connect(func():
		var tw = vfx.create_tween()
		tw.tween_property(vfx, "modulate:a", 0.0, 0.1)
		tw.tween_callback(vfx.queue_free)
	)

# -------------------------------------------------------------
# 4. 飞叶快刀 (Razor Leaf - Bulbasaur)
# -------------------------------------------------------------
static func spawn_razor_leaf(parent: Node2D, origin_pos: Vector2, targets: Array, scale_factor: float = 1.0) -> void:
	var vfx = Node2D.new()
	vfx.z_index = 40
	vfx.position = origin_pos
	parent.add_child(vfx)
	
	var sf = get_skill_frames("razor_leaf", 15.0)
	for target in targets:
		if not is_instance_valid(target):
			continue
		var t_pos = target.position
		
		# Spawn emerald blade storm at target position
		var anim = AnimatedSprite2D.new()
		anim.sprite_frames = sf
		anim.position = t_pos - origin_pos
		anim.scale = Vector2(0.50, 0.50) * scale_factor * scale_factor
		vfx.add_child(anim)
		anim.play("default")
		
		# Fast flying razor leaves toward target
		for l in range(2):
			var leaf_proj = ColorRect.new()
			leaf_proj.size = Vector2(10, 5)
			leaf_proj.pivot_offset = Vector2(5, 2.5)
			leaf_proj.color = Color(0.3, 1.0, 0.45, 0.95)
			vfx.add_child(leaf_proj)
			leaf_proj.position = Vector2(randf_range(-8, 8), randf_range(-8, 8))
			leaf_proj.rotation = (t_pos - origin_pos).angle()
			
			var tw = leaf_proj.create_tween().set_parallel(true)
			tw.tween_property(leaf_proj, "position", t_pos - origin_pos, 0.18).set_delay(float(l) * 0.06)
			tw.tween_property(leaf_proj, "modulate:a", 0.0, 0.05).set_delay(0.18 + float(l) * 0.06)
			tw.chain().tween_callback(leaf_proj.queue_free)
			
	var timer = vfx.get_tree().create_timer(0.6)
	timer.timeout.connect(func():
		var tw = vfx.create_tween()
		tw.tween_property(vfx, "modulate:a", 0.0, 0.1)
		tw.tween_callback(vfx.queue_free)
	)

# -------------------------------------------------------------
# 5. 暗影球 (Shadow Ball - Gengar)
# -------------------------------------------------------------
static func spawn_shadow_ball(parent: Node2D, origin_pos: Vector2, target_pos: Vector2, scale_factor: float = 1.0) -> void:
	var vfx = Node2D.new()
	vfx.z_index = 40
	vfx.position = origin_pos
	parent.add_child(vfx)
	
	# Flying shadowy missile
	var sf = get_skill_frames("shadow_ball", 15.0)
	var anim = AnimatedSprite2D.new()
	anim.sprite_frames = sf
	anim.scale = Vector2(0.52, 0.52) * scale_factor * scale_factor * scale_factor
	vfx.add_child(anim)
	anim.play("default")
	
	# Tween missile to target, then hold for explosion frames
	var tw = anim.create_tween()
	tw.tween_property(anim, "position", target_pos - origin_pos, 0.22).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	anim.animation_finished.connect(func():
		var f_tw = vfx.create_tween()
		f_tw.tween_property(vfx, "modulate:a", 0.0, 0.1)
		f_tw.tween_callback(vfx.queue_free)
	)

# -------------------------------------------------------------
# 6. 泰山压顶 / 地狱翻滚 (Body Slam / Seismic Toss - Snorlax, Machop)
# -------------------------------------------------------------
static func spawn_body_slam(parent: Node2D, center_pos: Vector2, scale_factor: float = 1.0) -> void:
	var vfx = Node2D.new()
	vfx.z_index = 40
	vfx.position = center_pos
	parent.add_child(vfx)
	
	var sf = get_skill_frames("body_slam", 15.0)
	var anim = AnimatedSprite2D.new()
	anim.sprite_frames = sf
	anim.scale = Vector2(0.58, 0.58) * scale_factor * scale_factor
	vfx.add_child(anim)
	anim.play("default")
	
	anim.animation_finished.connect(func():
		var tw = vfx.create_tween()
		tw.tween_property(vfx, "modulate:a", 0.0, 0.1)
		tw.tween_callback(vfx.queue_free)
	)

# -------------------------------------------------------------
# 7. 精神击破 / 精神强念 (Psystrike / Psychic - Mewtwo, Alakazam)
# -------------------------------------------------------------
static func spawn_psystrike(parent: Node2D, center_pos: Vector2, scale_factor: float = 1.0) -> void:
	var vfx = Node2D.new()
	vfx.z_index = 40
	vfx.position = center_pos
	parent.add_child(vfx)
	
	var sf = get_skill_frames("psystrike", 15.0)
	var anim = AnimatedSprite2D.new()
	anim.sprite_frames = sf
	anim.scale = Vector2(0.62, 0.62) * scale_factor
	vfx.add_child(anim)
	anim.play("default")
	
	anim.animation_finished.connect(func():
		var tw = vfx.create_tween()
		tw.tween_property(vfx, "modulate:a", 0.0, 0.1)
		tw.tween_callback(vfx.queue_free)
	)

# -------------------------------------------------------------
# 8. 流星群 (Draco Meteor - Dragonite)
# -------------------------------------------------------------
static func spawn_draco_meteor(parent: Node2D, target_positions: Array, scale_factor: float = 1.0) -> void:
	var vfx = Node2D.new()
	vfx.z_index = 40
	parent.add_child(vfx)
	
	var sf = get_skill_frames("draco_meteor", 14.0)
	for idx in range(target_positions.size()):
		var t_pos: Vector2 = target_positions[idx]
		var delay = float(idx) * 0.12
		
		var timer = vfx.get_tree().create_timer(delay)
		timer.timeout.connect(func():
			if not is_instance_valid(vfx):
				return
			var anim = AnimatedSprite2D.new()
			anim.sprite_frames = sf
			anim.position = t_pos
			anim.scale = Vector2(0.55, 0.55) * scale_factor
			vfx.add_child(anim)
			anim.play("default")
			
			anim.animation_finished.connect(func():
				anim.queue_free()
			)
		)
		
	var clean_timer = vfx.get_tree().create_timer(target_positions.size() * 0.12 + 0.7)
	clean_timer.timeout.connect(func():
		if is_instance_valid(vfx):
			vfx.queue_free()
	)

# -------------------------------------------------------------
# 9. 高速星星 (Swift - Eevee)
# -------------------------------------------------------------
static func spawn_swift(parent: Node2D, origin_pos: Vector2, target_pos: Vector2, scale_factor: float = 1.0) -> void:
	var vfx = Node2D.new()
	vfx.z_index = 40
	vfx.position = origin_pos
	parent.add_child(vfx)
	
	var dir = (target_pos - origin_pos).normalized()
	var angle = dir.angle()
	
	var sf = get_skill_frames("swift", 15.0)
	var anim = AnimatedSprite2D.new()
	anim.sprite_frames = sf
	anim.rotation = angle
	anim.scale = Vector2(0.48, 0.48) * scale_factor * scale_factor
	vfx.add_child(anim)
	anim.play("default")
	
	# Tween fast towards target
	var tw = vfx.create_tween()
	tw.tween_property(anim, "position", target_pos - origin_pos, 0.3).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	anim.animation_finished.connect(func():
		var tw_fade = vfx.create_tween()
		tw_fade.tween_property(vfx, "modulate:a", 0.0, 0.1)
		tw_fade.tween_callback(vfx.queue_free)
	)

# -------------------------------------------------------------
# 10. 火焰轮 (Flame Wheel - Growlithe)
# -------------------------------------------------------------
static func spawn_flame_wheel(parent: Node2D, origin_pos: Vector2, target_pos: Vector2, scale_factor: float = 1.0) -> void:
	var vfx = Node2D.new()
	vfx.z_index = 40
	vfx.position = origin_pos
	parent.add_child(vfx)
	
	var sf = get_skill_frames("flame_wheel", 14.0)
	var anim = AnimatedSprite2D.new()
	anim.sprite_frames = sf
	anim.scale = Vector2(0.50, 0.50) * scale_factor * scale_factor
	vfx.add_child(anim)
	anim.play("default")
	
	# Fast spiral dash towards target
	var tw = vfx.create_tween()
	tw.tween_property(anim, "position", target_pos - origin_pos, 0.28).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	
	# Spark burst on arrival
	var burst = CPUParticles2D.new()
	burst.position = target_pos - origin_pos
	burst.emitting = true
	burst.one_shot = true
	burst.explosiveness = 0.9
	burst.amount = 12
	burst.lifetime = 0.35
	burst.spread = 180.0
	burst.gravity = Vector2.ZERO
	burst.initial_velocity_min = 40.0
	burst.initial_velocity_max = 85.0
	burst.color = Color(1.0, 0.6, 0.1, 1.0)
	vfx.add_child(burst)
	
	anim.animation_finished.connect(func():
		var tw_fade = vfx.create_tween()
		tw_fade.tween_property(vfx, "modulate:a", 0.0, 0.1)
		tw_fade.tween_callback(vfx.queue_free)
	)

# -------------------------------------------------------------
# 11. 念力头槌 (Zen Headbutt - Psyduck)
# -------------------------------------------------------------
static func spawn_zen_headbutt(parent: Node2D, target_pos: Vector2, scale_factor: float = 1.0) -> void:
	var vfx = Node2D.new()
	vfx.z_index = 40
	vfx.position = target_pos
	parent.add_child(vfx)
	
	var sf = get_skill_frames("zen_headbutt", 14.0)
	var anim = AnimatedSprite2D.new()
	anim.sprite_frames = sf
	anim.scale = Vector2(0.52, 0.52) * scale_factor * scale_factor * scale_factor
	vfx.add_child(anim)
	anim.play("default")
	
	anim.animation_finished.connect(func():
		var tw = vfx.create_tween()
		tw.tween_property(vfx, "modulate:a", 0.0, 0.1)
		tw.tween_callback(vfx.queue_free)
	)

# -------------------------------------------------------------
# 12. 放电 (Discharge - Electabuzz)
# -------------------------------------------------------------
static func spawn_discharge(parent: Node2D, caster_pos: Vector2, scale_factor: float = 1.0) -> void:
	var vfx = Node2D.new()
	vfx.z_index = 40
	vfx.position = caster_pos
	parent.add_child(vfx)
	
	var sf = get_skill_frames("discharge", 14.0)
	var anim = AnimatedSprite2D.new()
	anim.sprite_frames = sf
	anim.scale = Vector2(0.56, 0.56) * scale_factor
	vfx.add_child(anim)
	anim.play("default")
	
	# Electric spark burst
	var cpu = CPUParticles2D.new()
	cpu.emitting = true
	cpu.one_shot = true
	cpu.explosiveness = 0.95
	cpu.amount = 16
	cpu.lifetime = 0.35
	cpu.spread = 180.0
	cpu.gravity = Vector2.ZERO
	cpu.initial_velocity_min = 45.0
	cpu.initial_velocity_max = 95.0
	cpu.color = Color(1.0, 0.9, 0.2, 1.0)
	vfx.add_child(cpu)
	
	anim.animation_finished.connect(func():
		var tw = vfx.create_tween()
		tw.tween_property(vfx, "modulate:a", 0.0, 0.1)
		tw.tween_callback(vfx.queue_free)
	)

# -------------------------------------------------------------
# 13. 暴风雪 (Blizzard - Lapras)
# -------------------------------------------------------------
static func spawn_blizzard(parent: Node2D, target_pos: Vector2, scale_factor: float = 1.0) -> void:
	var vfx = Node2D.new()
	vfx.z_index = 40
	vfx.position = target_pos
	parent.add_child(vfx)
	
	var sf = get_skill_frames("blizzard", 14.0)
	var anim = AnimatedSprite2D.new()
	anim.sprite_frames = sf
	anim.scale = Vector2(0.58, 0.58) * scale_factor * scale_factor
	vfx.add_child(anim)
	anim.play("default")
	
	# Frost mist particles
	var cpu = CPUParticles2D.new()
	cpu.emitting = true
	cpu.one_shot = true
	cpu.explosiveness = 0.85
	cpu.amount = 16
	cpu.lifetime = 0.45
	cpu.spread = 180.0
	cpu.gravity = Vector2(0, 15)
	cpu.initial_velocity_min = 35.0
	cpu.initial_velocity_max = 75.0
	cpu.color = Color(0.7, 0.9, 1.0, 0.9)
	vfx.add_child(cpu)
	
	anim.animation_finished.connect(func():
		var tw = vfx.create_tween()
		tw.tween_property(vfx, "modulate:a", 0.0, 0.1)
		tw.tween_callback(vfx.queue_free)
	)

# -------------------------------------------------------------
# 14. 波导弹 (Aura Sphere - Lucario)
# -------------------------------------------------------------
static func spawn_aura_sphere(parent: Node2D, origin_pos: Vector2, target_pos: Vector2, scale_factor: float = 1.0) -> void:
	var vfx = Node2D.new()
	vfx.z_index = 40
	vfx.position = origin_pos
	parent.add_child(vfx)
	
	var dir = (target_pos - origin_pos).normalized()
	var angle = dir.angle()
	
	var sf = get_skill_frames("aura_sphere", 14.0)
	var anim = AnimatedSprite2D.new()
	anim.sprite_frames = sf
	anim.rotation = angle
	anim.scale = Vector2(0.52, 0.52) * scale_factor * scale_factor * scale_factor
	vfx.add_child(anim)
	anim.play("default")
	
	# Tween fast towards target
	var tw = vfx.create_tween()
	tw.tween_property(anim, "position", target_pos - origin_pos, 0.25).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	anim.animation_finished.connect(func():
		var tw_fade = vfx.create_tween()
		tw_fade.tween_property(vfx, "modulate:a", 0.0, 0.1)
		tw_fade.tween_callback(vfx.queue_free)
	)


# -------------------------------------------------------------
# Unified Multi-Tier Skill VFX Dispatcher (Supports all 49 skills)
# -------------------------------------------------------------
static func spawn_skill_vfx(vfx_name: String, parent: Node2D, origin_pos: Vector2, target_pos: Vector2, scale_factor: float = 1.0, extra_targets: Array = []) -> void:
	# If 3D Arena is present, dispatch 3D volumetric skill visual effect
	if GameManager.has_meta("arena_3d"):
		var a3d: Arena3D = GameManager.get_meta("arena_3d")
		if a3d and is_instance_valid(a3d) and a3d.vfx_container:
			var o3d = a3d.pos_2d_to_3d(origin_pos)
			var t3d = a3d.pos_2d_to_3d(target_pos)
			var extras_3d = []
			for t in extra_targets:
				if is_instance_valid(t) and t is Node2D:
					extras_3d.append(a3d.pos_2d_to_3d(t.position))
				elif t is Vector2:
					extras_3d.append(a3d.pos_2d_to_3d(t))
			SkillVFX3D.spawn_skill_vfx_3d(vfx_name, a3d.vfx_container, o3d, t3d, scale_factor, extras_3d)
			return

	match vfx_name:
		"thunderbolt":
			spawn_thunderbolt(parent, target_pos, scale_factor)
		"flamethrower":
			spawn_flamethrower(parent, origin_pos, target_pos, scale_factor)
		"hydro_pump":
			spawn_hydro_pump(parent, origin_pos, target_pos, scale_factor)
		"razor_leaf":
			spawn_razor_leaf(parent, origin_pos, extra_targets, scale_factor)
		"shadow_ball":
			spawn_shadow_ball(parent, origin_pos, target_pos, scale_factor)
		"body_slam":
			spawn_body_slam(parent, origin_pos, scale_factor)
		"psystrike":
			spawn_psystrike(parent, target_pos, scale_factor)
		"draco_meteor":
			var pts = []
			for t in extra_targets:
				if is_instance_valid(t):
					pts.append(t.position)
			if pts.is_empty():
				pts.append(target_pos)
			spawn_draco_meteor(parent, pts, scale_factor)
		"swift":
			spawn_swift(parent, origin_pos, target_pos, scale_factor)
		"flame_wheel":
			spawn_flame_wheel(parent, origin_pos, target_pos, scale_factor)
		"zen_headbutt":
			spawn_zen_headbutt(parent, target_pos, scale_factor)
		"discharge":
			spawn_discharge(parent, origin_pos, scale_factor)
		"blizzard":
			spawn_blizzard(parent, target_pos, scale_factor)
		"aura_sphere":
			spawn_aura_sphere(parent, origin_pos, target_pos, scale_factor)
			
		# ★1 Starters: Light overhead, melee strikes, directional streams
		"thundershock":
			_spawn_overhead_lightning(parent, target_pos, "thundershock", scale_factor * 0.85, Color(1.0, 0.95, 0.4), 8)
		"ember":
			_spawn_directional_stream(parent, origin_pos, target_pos, "ember", scale_factor * 0.85, Color(1.0, 0.6, 0.2))
		"water_gun":
			_spawn_directional_stream(parent, origin_pos, target_pos, "water_gun", scale_factor * 0.85, Color(0.3, 0.75, 1.0), true)
		"leech_seed":
			_spawn_projectile_with_impact(parent, origin_pos, target_pos, "leech_seed", scale_factor * 0.85, Color(0.4, 0.95, 0.35))
		"low_kick":
			_spawn_impact_strike(parent, target_pos, "low_kick", scale_factor * 0.9, Color(1.0, 0.85, 0.3))
		"quick_attack":
			_spawn_projectile_with_impact(parent, origin_pos, target_pos, "quick_attack", scale_factor * 0.85, Color(1.0, 1.0, 1.0))
		"fire_fang":
			_spawn_impact_strike(parent, target_pos, "fire_fang", scale_factor * 0.9, Color(1.0, 0.5, 0.1))
		"lick":
			_spawn_impact_strike(parent, target_pos, "lick", scale_factor * 0.9, Color(0.7, 0.3, 0.9))
		"rest":
			_spawn_caster_aura(parent, origin_pos, "rest", scale_factor * 0.9, Color(0.4, 0.85, 1.0))
		"thunder_punch":
			_spawn_impact_strike(parent, target_pos, "thunder_punch", scale_factor * 0.9, Color(1.0, 0.9, 0.2))
		"ice_shard":
			_spawn_projectile_with_impact(parent, origin_pos, target_pos, "ice_shard", scale_factor * 0.85, Color(0.7, 0.95, 1.0))
		"psybeam":
			_spawn_directional_stream(parent, origin_pos, target_pos, "psybeam", scale_factor * 0.9, Color(0.9, 0.4, 1.0))
		"force_palm":
			_spawn_impact_strike(parent, target_pos, "force_palm", scale_factor * 0.9, Color(0.3, 0.8, 1.0))
		"dragon_pulse":
			_spawn_directional_stream(parent, origin_pos, target_pos, "dragon_pulse", scale_factor * 0.9, Color(0.2, 0.95, 0.6))
		"psycho_cut":
			_spawn_projectile_with_impact(parent, origin_pos, target_pos, "psycho_cut", scale_factor * 0.85, Color(0.9, 0.3, 0.95))

		# ★2 Signatures
		"fire_blast":
			_spawn_projectile_with_impact(parent, origin_pos, target_pos, "fire_blast", scale_factor * 1.15, Color(1.0, 0.4, 0.05), 18)
		"hyper_beam":
			_spawn_hyper_beam(parent, origin_pos, target_pos, scale_factor * 1.15)

		# --- WATER ---
		"water_pulse":
			_spawn_projectile_with_impact(parent, origin_pos, target_pos, "water_pulse", scale_factor * 1.05, Color(0.25, 0.8, 1.0), 16)
		"bubble_beam":
			_spawn_directional_stream(parent, origin_pos, target_pos, "bubble_beam", scale_factor * 0.95, Color(0.35, 0.85, 1.0), true)
		"aqua_tail":
			_spawn_impact_strike(parent, target_pos, "aqua_tail", scale_factor * 1.15, Color(0.2, 0.75, 1.0))
		"surf":
			_spawn_cataclysm_aoe(parent, target_pos, "surf", scale_factor * 1.3, Color(0.15, 0.85, 1.0))
		"crabhammer":
			_spawn_impact_strike(parent, target_pos, "crabhammer", scale_factor * 1.2, Color(0.2, 0.8, 1.0))

		# --- FIRE ---
		"fire_spin":
			_spawn_cataclysm_aoe(parent, target_pos, "fire_spin", scale_factor * 1.15, Color(1.0, 0.45, 0.1))
		"heat_wave":
			_spawn_cataclysm_aoe(parent, target_pos, "heat_wave", scale_factor * 1.25, Color(1.0, 0.35, 0.05))
		"fire_punch":
			_spawn_impact_strike(parent, target_pos, "fire_punch", scale_factor * 1.05, Color(1.0, 0.5, 0.1))

		# --- GRASS ---
		"seed_bomb":
			_spawn_projectile_with_impact(parent, origin_pos, target_pos, "seed_bomb", scale_factor * 1.0, Color(0.4, 0.95, 0.3), 16)
		"solar_beam":
			_spawn_laser_beam(parent, origin_pos, target_pos, "solar_beam", scale_factor * 1.25, Color(0.35, 1.0, 0.45))
		"petal_dance":
			_spawn_cataclysm_aoe(parent, target_pos, "petal_dance", scale_factor * 1.2, Color(1.0, 0.55, 0.8))
		"power_whip":
			_spawn_impact_strike(parent, target_pos, "power_whip", scale_factor * 1.15, Color(0.25, 0.95, 0.35))
		"vine_whip":
			_spawn_directional_stream(parent, origin_pos, target_pos, "vine_whip", scale_factor * 0.95, Color(0.3, 0.9, 0.35))
		"leaf_blade":
			_spawn_impact_strike(parent, target_pos, "leaf_blade", scale_factor * 1.1, Color(0.3, 0.95, 0.4))

		# --- ELECTRIC ---
		"electro_ball":
			_spawn_projectile_with_impact(parent, origin_pos, target_pos, "electro_ball", scale_factor * 1.05, Color(1.0, 0.95, 0.3), 18)
		"spark":
			_spawn_impact_strike(parent, target_pos, "spark", scale_factor * 1.0, Color(1.0, 0.9, 0.2))
		"electroweb":
			_spawn_cataclysm_aoe(parent, target_pos, "electroweb", scale_factor * 1.1, Color(1.0, 0.95, 0.35))
		"thunder_fang":
			_spawn_impact_strike(parent, target_pos, "thunder_fang", scale_factor * 1.0, Color(1.0, 0.95, 0.3))
		"thunder":
			_spawn_overhead_lightning(parent, target_pos, "thunder", scale_factor * 1.35, Color(1.0, 0.95, 0.4), 24)

		# --- ICE ---
		"ice_punch":
			_spawn_impact_strike(parent, target_pos, "ice_punch", scale_factor * 1.0, Color(0.65, 0.9, 1.0))
		"ice_fang":
			_spawn_impact_strike(parent, target_pos, "ice_fang", scale_factor * 1.0, Color(0.6, 0.9, 1.0))
		"icicle_spear":
			_spawn_projectile_with_impact(parent, origin_pos, target_pos, "icicle_spear", scale_factor * 0.95, Color(0.7, 0.95, 1.0), 14)
		"avalanche":
			_spawn_cataclysm_aoe(parent, target_pos, "avalanche", scale_factor * 1.25, Color(0.7, 0.9, 1.0))
		"ice_beam":
			_spawn_laser_beam(parent, origin_pos, target_pos, "ice_beam", scale_factor * 1.1, Color(0.65, 0.9, 1.0))
		"aurora_beam":
			_spawn_directional_stream(parent, origin_pos, target_pos, "aurora_beam", scale_factor * 1.05, Color(0.75, 0.95, 0.9))

		# --- PSYCHIC ---
		"hypnosis":
			_spawn_directional_stream(parent, origin_pos, target_pos, "hypnosis", scale_factor * 1.0, Color(0.75, 0.4, 1.0))
		"confusion":
			_spawn_caster_aura(parent, target_pos, "confusion", scale_factor * 1.0, Color(0.85, 0.4, 0.95))
		"psychic":
			_spawn_cataclysm_aoe(parent, target_pos, "psychic", scale_factor * 1.2, Color(0.9, 0.35, 1.0))
		"dream_eater":
			_spawn_projectile_with_impact(parent, origin_pos, target_pos, "dream_eater", scale_factor * 1.0, Color(0.6, 0.2, 0.8), 12)

		# --- DARK / GHOST ---
		"bite":
			_spawn_impact_strike(parent, target_pos, "bite", scale_factor * 1.0, Color(0.45, 0.3, 0.6))
		"crunch":
			_spawn_impact_strike(parent, target_pos, "crunch", scale_factor * 1.15, Color(0.35, 0.15, 0.5))
		"dark_pulse":
			_spawn_cataclysm_aoe(parent, target_pos, "dark_pulse", scale_factor * 1.2, Color(0.4, 0.1, 0.65))
		"night_shade":
			_spawn_cataclysm_aoe(parent, target_pos, "night_shade", scale_factor * 1.15, Color(0.7, 0.15, 0.3))
		"shadow_punch":
			_spawn_impact_strike(parent, target_pos, "shadow_punch", scale_factor * 1.05, Color(0.5, 0.2, 0.7))
		"perish_song":
			_spawn_cataclysm_aoe(parent, origin_pos, "perish_song", scale_factor * 1.25, Color(0.45, 0.25, 0.75))

		# --- BUG ---
		"leech_life":
			_spawn_impact_strike(parent, target_pos, "leech_life", scale_factor * 1.0, Color(0.3, 0.85, 0.3))
		"bug_buzz":
			_spawn_cataclysm_aoe(parent, target_pos, "bug_buzz", scale_factor * 1.15, Color(0.6, 0.85, 0.2))
		"string_shot":
			_spawn_projectile_with_impact(parent, origin_pos, target_pos, "string_shot", scale_factor * 0.9, Color(0.95, 0.95, 0.95), 10)
		"silver_wind":
			_spawn_directional_stream(parent, origin_pos, target_pos, "silver_wind", scale_factor * 1.1, Color(0.85, 0.95, 0.95))
		"x_scissor":
			_spawn_impact_strike(parent, target_pos, "x_scissor", scale_factor * 1.15, Color(0.4, 0.9, 0.3))
		"pin_missile":
			_spawn_projectile_with_impact(parent, origin_pos, target_pos, "pin_missile", scale_factor * 0.95, Color(0.7, 0.9, 0.2), 12)

		# --- FLYING ---
		"air_slash":
			_spawn_projectile_with_impact(parent, origin_pos, target_pos, "air_slash", scale_factor * 1.05, Color(0.7, 0.9, 1.0), 12)
		"wing_attack":
			_spawn_impact_strike(parent, target_pos, "wing_attack", scale_factor * 1.05, Color(0.9, 0.95, 1.0))
		"gust":
			_spawn_directional_stream(parent, origin_pos, target_pos, "gust", scale_factor * 0.95, Color(0.85, 0.95, 1.0))
		"twister":
			_spawn_cataclysm_aoe(parent, target_pos, "twister", scale_factor * 1.2, Color(0.8, 0.92, 1.0))
		"drill_peck":
			_spawn_impact_strike(parent, target_pos, "drill_peck", scale_factor * 1.05, Color(0.95, 0.85, 0.7))
		"brave_bird":
			_spawn_flare_blitz(parent, origin_pos, target_pos, scale_factor * 1.35)

		# --- FIGHTING / NORMAL ---
		"mach_punch":
			_spawn_impact_strike(parent, target_pos, "mach_punch", scale_factor * 0.95, Color(1.0, 0.85, 0.3))
		"cross_chop":
			_spawn_impact_strike(parent, target_pos, "cross_chop", scale_factor * 1.1, Color(1.0, 0.85, 0.3))
		"dynamic_punch":
			_spawn_impact_strike(parent, target_pos, "dynamic_punch", scale_factor * 1.2, Color(1.0, 0.8, 0.25))
		"mega_punch":
			_spawn_impact_strike(parent, target_pos, "mega_punch", scale_factor * 1.25, Color(1.0, 0.8, 0.2))
		"mega_kick":
			_spawn_impact_strike(parent, target_pos, "mega_kick", scale_factor * 1.25, Color(1.0, 0.75, 0.2))
		"headbutt":
			_spawn_impact_strike(parent, target_pos, "headbutt", scale_factor * 1.0, Color(0.95, 0.85, 0.4))
		"tackle":
			_spawn_impact_strike(parent, target_pos, "tackle", scale_factor * 0.9, Color(0.9, 0.9, 0.9))
		"take_down":
			_spawn_impact_strike(parent, target_pos, "take_down", scale_factor * 1.1, Color(1.0, 0.7, 0.4))
		"double_edge":
			_spawn_impact_strike(parent, target_pos, "double_edge", scale_factor * 1.2, Color(1.0, 0.8, 0.3))
		"slash":
			_spawn_impact_strike(parent, target_pos, "slash", scale_factor * 1.0, Color(1.0, 1.0, 1.0))
		"tri_attack":
			_spawn_projectile_with_impact(parent, origin_pos, target_pos, "tri_attack", scale_factor * 1.1, Color(1.0, 0.85, 0.5), 18)

		# --- ROCK / GROUND ---
		"rock_throw":
			_spawn_projectile_with_impact(parent, origin_pos, target_pos, "rock_throw", scale_factor * 0.95, Color(0.75, 0.65, 0.35))
		"rock_slide":
			_spawn_cataclysm_aoe(parent, target_pos, "rock_slide", scale_factor * 1.2, Color(0.75, 0.65, 0.35))
		"ancient_power":
			_spawn_projectile_with_impact(parent, origin_pos, target_pos, "ancient_power", scale_factor * 1.1, Color(0.85, 0.7, 0.4), 16)
		"stone_edge":
			_spawn_cataclysm_aoe(parent, target_pos, "stone_edge", scale_factor * 1.25, Color(0.75, 0.65, 0.35))
		"earthquake":
			_spawn_cataclysm_aoe(parent, target_pos, "earthquake", scale_factor * 1.35, Color(0.7, 0.55, 0.3))
		"mud_slap":
			_spawn_projectile_with_impact(parent, origin_pos, target_pos, "mud_slap", scale_factor * 0.9, Color(0.65, 0.5, 0.3))
		"bone_rush":
			_spawn_projectile_with_impact(parent, origin_pos, target_pos, "bone_rush", scale_factor * 1.0, Color(0.9, 0.88, 0.8), 12)
		"bonemerang":
			_spawn_projectile_with_impact(parent, origin_pos, target_pos, "bonemerang", scale_factor * 1.1, Color(0.9, 0.88, 0.8), 14)

		# --- POISON ---
		"poison_sting":
			_spawn_projectile_with_impact(parent, origin_pos, target_pos, "poison_sting", scale_factor * 0.85, Color(0.7, 0.25, 0.8), 8)
		"sludge_bomb":
			_spawn_projectile_with_impact(parent, origin_pos, target_pos, "sludge_bomb", scale_factor * 1.1, Color(0.65, 0.2, 0.75), 16)
		"gunk_shot":
			_spawn_projectile_with_impact(parent, origin_pos, target_pos, "gunk_shot", scale_factor * 1.2, Color(0.55, 0.15, 0.7), 20)
		"poison_jab":
			_spawn_impact_strike(parent, target_pos, "poison_jab", scale_factor * 1.0, Color(0.7, 0.2, 0.8))
		"toxic":
			_spawn_cataclysm_aoe(parent, target_pos, "toxic", scale_factor * 1.15, Color(0.6, 0.15, 0.75))
		"acid_armor":
			_spawn_caster_aura(parent, origin_pos, "acid_armor", scale_factor * 1.0, Color(0.65, 0.3, 0.85))

		# --- DRAGON ---
		"dragon_breath":
			_spawn_directional_stream(parent, origin_pos, target_pos, "dragon_breath", scale_factor * 0.95, Color(0.3, 0.95, 0.7))
		"dragon_claw":
			_spawn_impact_strike(parent, target_pos, "dragon_claw", scale_factor * 1.1, Color(0.3, 0.8, 1.0))

		# --- STATUS ---
		"heal_pulse":
			_spawn_caster_aura(parent, target_pos, "heal_pulse", scale_factor * 1.1, Color(0.4, 0.95, 0.6))
		"softboiled":
			_spawn_caster_aura(parent, origin_pos, "softboiled", scale_factor * 1.1, Color(1.0, 0.95, 0.6))
		"reflect":
			_spawn_caster_aura(parent, origin_pos, "reflect", scale_factor * 1.1, Color(0.3, 0.75, 1.0))
		"light_screen":
			_spawn_caster_aura(parent, origin_pos, "light_screen", scale_factor * 1.1, Color(1.0, 0.9, 0.4))

		# ★3 Ultimate Cataclysm Moves
		"volt_catastrophe":
			_spawn_cataclysm_overhead(parent, target_pos, "volt_catastrophe", scale_factor * 1.4, Color(1.0, 0.95, 0.3), extra_targets)
		"inferno":
			_spawn_cataclysm_aoe(parent, target_pos, "inferno", scale_factor * 1.4, Color(1.0, 0.35, 0.05))
		"hydro_cannon":
			_spawn_cataclysm_aoe(parent, target_pos, "hydro_cannon", scale_factor * 1.4, Color(0.2, 0.8, 1.0))
		"frenzy_plant":
			_spawn_cataclysm_aoe(parent, target_pos, "frenzy_plant", scale_factor * 1.4, Color(0.25, 1.0, 0.4))
		"close_combat":
			_spawn_cataclysm_aoe(parent, (origin_pos + target_pos) * 0.5, "close_combat", scale_factor * 1.35, Color(1.0, 0.85, 0.2))
		"extreme_evoboost":
			_spawn_cataclysm_aoe(parent, origin_pos, "extreme_evoboost", scale_factor * 1.35, Color(0.95, 0.75, 1.0))
		"flare_blitz":
			_spawn_flare_blitz(parent, origin_pos, target_pos, scale_factor * 1.4)
		"psychokinesis":
			_spawn_cataclysm_aoe(parent, target_pos, "psychokinesis", scale_factor * 1.4, Color(0.85, 0.25, 1.0))
		"hex_nightmare":
			_spawn_cataclysm_aoe(parent, target_pos, "hex_nightmare", scale_factor * 1.4, Color(0.55, 0.1, 0.8))
		"giga_impact":
			_spawn_cataclysm_aoe(parent, target_pos, "giga_impact", scale_factor * 1.45, Color(0.95, 0.75, 0.3))
		"thunder_tempest":
			_spawn_cataclysm_aoe(parent, target_pos, "thunder_tempest", scale_factor * 1.4, Color(0.8, 1.0, 0.3))
		"sheer_cold":
			_spawn_cataclysm_aoe(parent, target_pos, "sheer_cold", scale_factor * 1.4, Color(0.75, 0.95, 1.0))
		"future_sight":
			_spawn_cataclysm_overhead(parent, target_pos, "future_sight", scale_factor * 1.4, Color(0.85, 0.4, 1.0), extra_targets)
		"blast_burn":
			_spawn_cataclysm_aoe(parent, target_pos, "blast_burn", scale_factor * 1.45, Color(1.0, 0.25, 0.05))
		"hydro_tempest":
			_spawn_cataclysm_aoe(parent, target_pos, "hydro_tempest", scale_factor * 1.4, Color(0.15, 0.85, 1.0))
		"aura_storm":
			_spawn_cataclysm_aoe(parent, target_pos, "aura_storm", scale_factor * 1.4, Color(0.25, 0.9, 1.0))
		"dragon_apocalypse":
			_spawn_dragon_apocalypse(parent, target_pos, scale_factor * 1.4, extra_targets)
		"cosmic_singularity":
			_spawn_cataclysm_aoe(parent, (origin_pos + target_pos) * 0.5, "cosmic_singularity", scale_factor * 1.45, Color(0.65, 0.2, 0.95))

		_:
			var vfx = Node2D.new()
			vfx.z_index = 40
			vfx.position = target_pos
			parent.add_child(vfx)
			var sf = get_skill_frames(vfx_name, 15.0)
			var anim = AnimatedSprite2D.new()
			anim.sprite_frames = sf
			anim.scale = Vector2(0.5, 0.5) * scale_factor
			vfx.add_child(anim)
			anim.play("default")
			anim.animation_finished.connect(func():
				var tw = vfx.create_tween()
				tw.tween_property(vfx, "modulate:a", 0.0, 0.1)
				tw.tween_callback(vfx.queue_free)
			)

# Helper: Overhead Lightning Strike
static func _spawn_overhead_lightning(parent: Node2D, target_pos: Vector2, vfx_name: String, scale_factor: float, color: Color, spark_count: int) -> void:
	var vfx = Node2D.new()
	vfx.z_index = 42
	vfx.position = target_pos
	parent.add_child(vfx)
	var sf = get_skill_frames(vfx_name, 15.0)
	var anim = AnimatedSprite2D.new()
	anim.sprite_frames = sf
	anim.position = Vector2(0, -70 * scale_factor)
	anim.scale = Vector2(0.46, 0.46) * scale_factor
	vfx.add_child(anim)
	anim.play("default")
	
	var cpu = CPUParticles2D.new()
	cpu.emitting = true
	cpu.one_shot = true
	cpu.explosiveness = 0.95
	cpu.amount = spark_count
	cpu.lifetime = 0.35
	cpu.spread = 180.0
	cpu.gravity = Vector2.ZERO
	cpu.initial_velocity_min = 40.0
	cpu.initial_velocity_max = 80.0
	cpu.scale_amount_min = 2.0
	cpu.scale_amount_max = 3.5
	cpu.color = color
	vfx.add_child(cpu)
	
	anim.animation_finished.connect(func():
		var tw = vfx.create_tween()
		tw.tween_property(vfx, "modulate:a", 0.0, 0.1)
		tw.tween_callback(vfx.queue_free)
	)

# Helper: Directional Stream / Laser
static func _spawn_directional_stream(parent: Node2D, origin_pos: Vector2, target_pos: Vector2, vfx_name: String, scale_factor: float, color: Color, with_jet_line: bool = false) -> void:
	var vfx = Node2D.new()
	vfx.z_index = 40
	vfx.position = origin_pos
	parent.add_child(vfx)
	
	var dir = (target_pos - origin_pos).normalized()
	var dist = origin_pos.distance_to(target_pos)
	var angle = dir.angle()
	
	if with_jet_line:
		var line = Line2D.new()
		line.width = 8.0 * scale_factor
		line.default_color = Color(color.r, color.g, color.b, 0.8)
		line.begin_cap_mode = Line2D.LINE_CAP_ROUND
		line.end_cap_mode = Line2D.LINE_CAP_ROUND
		line.points = PackedVector2Array([Vector2.ZERO, dir * dist])
		vfx.add_child(line)
		var l_tw = line.create_tween()
		l_tw.tween_property(line, "width", 0.0, 0.22).set_delay(0.06)
	
	var sf = get_skill_frames(vfx_name, 15.0)
	var anim = AnimatedSprite2D.new()
	anim.sprite_frames = sf
	anim.rotation = angle
	anim.offset = Vector2(80, 0)
	anim.position = dir * 15.0
	anim.scale = Vector2(0.42, 0.42) * scale_factor
	vfx.add_child(anim)
	anim.play("default")
	
	var burst = CPUParticles2D.new()
	burst.position = target_pos - origin_pos
	burst.emitting = true
	burst.one_shot = true
	burst.explosiveness = 0.9
	burst.amount = 12
	burst.lifetime = 0.35
	burst.spread = 180.0
	burst.gravity = Vector2.ZERO
	burst.initial_velocity_min = 35.0
	burst.initial_velocity_max = 75.0
	burst.color = color
	vfx.add_child(burst)
	
	anim.animation_finished.connect(func():
		var tw = vfx.create_tween()
		tw.tween_property(vfx, "modulate:a", 0.0, 0.1)
		tw.tween_callback(vfx.queue_free)
	)

# Helper: Projectile Moving to Target
static func _spawn_projectile_with_impact(parent: Node2D, origin_pos: Vector2, target_pos: Vector2, vfx_name: String, scale_factor: float, color: Color, burst_amount: int = 14) -> void:
	var vfx = Node2D.new()
	vfx.z_index = 41
	vfx.position = origin_pos
	parent.add_child(vfx)
	
	var sf = get_skill_frames(vfx_name, 15.0)
	var anim = AnimatedSprite2D.new()
	anim.sprite_frames = sf
	anim.rotation = (target_pos - origin_pos).angle()
	anim.scale = Vector2(0.48, 0.48) * scale_factor
	vfx.add_child(anim)
	anim.play("default")
	
	var tw = anim.create_tween()
	tw.tween_property(anim, "position", target_pos - origin_pos, 0.22).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tw.tween_callback(func():
		var burst = CPUParticles2D.new()
		burst.position = target_pos - origin_pos
		burst.emitting = true
		burst.one_shot = true
		burst.explosiveness = 0.92
		burst.amount = burst_amount
		burst.lifetime = 0.35
		burst.spread = 180.0
		burst.gravity = Vector2.ZERO
		burst.initial_velocity_min = 40.0
		burst.initial_velocity_max = 90.0
		burst.color = color
		vfx.add_child(burst)
	)
	
	anim.animation_finished.connect(func():
		var f_tw = vfx.create_tween()
		f_tw.tween_property(vfx, "modulate:a", 0.0, 0.1)
		f_tw.tween_callback(vfx.queue_free)
	)

# Helper: Snappy Impact Strike on Target
static func _spawn_impact_strike(parent: Node2D, target_pos: Vector2, vfx_name: String, scale_factor: float, color: Color) -> void:
	var vfx = Node2D.new()
	vfx.z_index = 42
	vfx.position = target_pos
	parent.add_child(vfx)
	
	var sf = get_skill_frames(vfx_name, 16.0)
	var anim = AnimatedSprite2D.new()
	anim.sprite_frames = sf
	anim.scale = Vector2(0.52, 0.52) * scale_factor
	vfx.add_child(anim)
	anim.play("default")
	
	var burst = CPUParticles2D.new()
	burst.emitting = true
	burst.one_shot = true
	burst.explosiveness = 0.95
	burst.amount = 14
	burst.lifetime = 0.3
	burst.spread = 180.0
	burst.gravity = Vector2.ZERO
	burst.initial_velocity_min = 45.0
	burst.initial_velocity_max = 85.0
	burst.color = color
	vfx.add_child(burst)
	
	anim.animation_finished.connect(func():
		var tw = vfx.create_tween()
		tw.tween_property(vfx, "modulate:a", 0.0, 0.1)
		tw.tween_callback(vfx.queue_free)
	)

# Helper: Caster Centered Aura
static func _spawn_caster_aura(parent: Node2D, origin_pos: Vector2, vfx_name: String, scale_factor: float, color: Color) -> void:
	var vfx = Node2D.new()
	vfx.z_index = 40
	vfx.position = origin_pos
	parent.add_child(vfx)
	
	var sf = get_skill_frames(vfx_name, 14.0)
	var anim = AnimatedSprite2D.new()
	anim.sprite_frames = sf
	anim.scale = Vector2(0.54, 0.54) * scale_factor
	vfx.add_child(anim)
	anim.play("default")
	
	var p = CPUParticles2D.new()
	p.emitting = true
	p.one_shot = true
	p.explosiveness = 0.8
	p.amount = 16
	p.lifetime = 0.5
	p.spread = 180.0
	p.gravity = Vector2(0, -25)
	p.initial_velocity_min = 20.0
	p.initial_velocity_max = 50.0
	p.color = color
	vfx.add_child(p)
	
	anim.animation_finished.connect(func():
		var tw = vfx.create_tween()
		tw.tween_property(vfx, "modulate:a", 0.0, 0.1)
		tw.tween_callback(vfx.queue_free)
	)

# Helper: Hyper Beam Laser
static func _spawn_hyper_beam(parent: Node2D, origin_pos: Vector2, target_pos: Vector2, scale_factor: float) -> void:
	var vfx = Node2D.new()
	vfx.z_index = 45
	vfx.position = origin_pos
	parent.add_child(vfx)
	
	var dir = (target_pos - origin_pos).normalized()
	var dist = origin_pos.distance_to(target_pos)
	
	var line = Line2D.new()
	line.width = 16.0 * scale_factor
	line.default_color = Color(1.0, 0.92, 0.45, 0.95)
	line.begin_cap_mode = Line2D.LINE_CAP_ROUND
	line.end_cap_mode = Line2D.LINE_CAP_ROUND
	line.points = PackedVector2Array([Vector2.ZERO, dir * dist])
	vfx.add_child(line)
	
	var inner_line = Line2D.new()
	inner_line.width = 8.0 * scale_factor
	inner_line.default_color = Color(1.0, 1.0, 1.0, 1.0)
	inner_line.points = line.points
	vfx.add_child(inner_line)
	
	var l_tw = line.create_tween().set_parallel(true)
	l_tw.tween_property(line, "width", 0.0, 0.28).set_delay(0.12)
	l_tw.tween_property(inner_line, "width", 0.0, 0.28).set_delay(0.12)
	
	var sf = get_skill_frames("hyper_beam", 15.0)
	var anim = AnimatedSprite2D.new()
	anim.sprite_frames = sf
	anim.position = target_pos - origin_pos
	anim.scale = Vector2(0.58, 0.58) * scale_factor
	vfx.add_child(anim)
	anim.play("default")
	
	anim.animation_finished.connect(func():
		var tw = vfx.create_tween()
		tw.tween_property(vfx, "modulate:a", 0.0, 0.1)
		tw.tween_callback(vfx.queue_free)
	)

# Helper: Colored Laser Beam (Solar Beam, Ice Beam, Hyper Beam)
static func _spawn_laser_beam(parent: Node2D, origin_pos: Vector2, target_pos: Vector2, vfx_name: String, scale_factor: float, beam_color: Color) -> void:
	var vfx = Node2D.new()
	vfx.z_index = 45
	vfx.position = origin_pos
	parent.add_child(vfx)
	
	var dir = (target_pos - origin_pos).normalized()
	var dist = origin_pos.distance_to(target_pos)
	
	var line = Line2D.new()
	line.width = 16.0 * scale_factor
	line.default_color = beam_color
	line.begin_cap_mode = Line2D.LINE_CAP_ROUND
	line.end_cap_mode = Line2D.LINE_CAP_ROUND
	line.points = PackedVector2Array([Vector2.ZERO, dir * dist])
	vfx.add_child(line)
	
	var inner_line = Line2D.new()
	inner_line.width = 8.0 * scale_factor
	inner_line.default_color = Color(1.0, 1.0, 1.0, 0.95)
	inner_line.points = line.points
	vfx.add_child(inner_line)
	
	var l_tw = line.create_tween().set_parallel(true)
	l_tw.tween_property(line, "width", 0.0, 0.28).set_delay(0.12)
	l_tw.tween_property(inner_line, "width", 0.0, 0.28).set_delay(0.12)
	
	var sf = get_skill_frames(vfx_name, 15.0)
	var anim = AnimatedSprite2D.new()
	anim.sprite_frames = sf
	anim.position = target_pos - origin_pos
	anim.scale = Vector2(0.58, 0.58) * scale_factor
	vfx.add_child(anim)
	anim.play("default")
	
	anim.animation_finished.connect(func():
		var tw = vfx.create_tween()
		tw.tween_property(vfx, "modulate:a", 0.0, 0.1)
		tw.tween_callback(vfx.queue_free)
	)

# Helper: Epic ★3 Ultimate Cataclysm AOE
static func _spawn_cataclysm_aoe(parent: Node2D, center_pos: Vector2, vfx_name: String, scale_factor: float, color: Color) -> void:
	var vfx = Node2D.new()
	vfx.z_index = 48
	vfx.position = center_pos
	parent.add_child(vfx)
	
	var sf = get_skill_frames(vfx_name, 15.0)
	var anim = AnimatedSprite2D.new()
	anim.sprite_frames = sf
	anim.scale = Vector2(0.68, 0.68) * scale_factor
	vfx.add_child(anim)
	anim.play("default")
	
	var burst = CPUParticles2D.new()
	burst.emitting = true
	burst.one_shot = true
	burst.explosiveness = 0.94
	burst.amount = 26
	burst.lifetime = 0.45
	burst.spread = 180.0
	burst.gravity = Vector2.ZERO
	burst.initial_velocity_min = 60.0
	burst.initial_velocity_max = 130.0
	burst.scale_amount_min = 2.5
	burst.scale_amount_max = 4.5
	burst.color = color
	vfx.add_child(burst)
	
	anim.animation_finished.connect(func():
		var tw = vfx.create_tween()
		tw.tween_property(vfx, "modulate:a", 0.0, 0.15)
		tw.tween_callback(vfx.queue_free)
	)

# Helper: Epic ★3 Ultimate Sky Cataclysm (Volt Catastrophe, Future Sight)
static func _spawn_cataclysm_overhead(parent: Node2D, target_pos: Vector2, vfx_name: String, scale_factor: float, color: Color, extra_targets: Array) -> void:
	var vfx = Node2D.new()
	vfx.z_index = 50
	vfx.position = target_pos
	parent.add_child(vfx)
	
	var sf = get_skill_frames(vfx_name, 15.0)
	var anim = AnimatedSprite2D.new()
	anim.sprite_frames = sf
	anim.position = Vector2(0, -85 * scale_factor)
	anim.scale = Vector2(0.72, 0.72) * scale_factor
	vfx.add_child(anim)
	anim.play("default")
	
	var burst = CPUParticles2D.new()
	burst.emitting = true
	burst.one_shot = true
	burst.explosiveness = 0.96
	burst.amount = 32
	burst.lifetime = 0.5
	burst.spread = 180.0
	burst.gravity = Vector2.ZERO
	burst.initial_velocity_min = 70.0
	burst.initial_velocity_max = 150.0
	burst.scale_amount_min = 2.8
	burst.scale_amount_max = 5.0
	burst.color = color
	vfx.add_child(burst)
	
	for i in range(min(2, extra_targets.size())):
		var t = extra_targets[i]
		if is_instance_valid(t) and t.position != target_pos:
			var sub_anim = AnimatedSprite2D.new()
			sub_anim.sprite_frames = sf
			sub_anim.position = (t.position - target_pos) + Vector2(0, -60 * scale_factor)
			sub_anim.scale = Vector2(0.45, 0.45) * scale_factor
			vfx.add_child(sub_anim)
			sub_anim.play("default")
	
	anim.animation_finished.connect(func():
		var tw = vfx.create_tween()
		tw.tween_property(vfx, "modulate:a", 0.0, 0.15)
		tw.tween_callback(vfx.queue_free)
	)

# Helper: Flare Blitz Meteor Charge
static func _spawn_flare_blitz(parent: Node2D, origin_pos: Vector2, target_pos: Vector2, scale_factor: float) -> void:
	var vfx = Node2D.new()
	vfx.z_index = 46
	vfx.position = origin_pos
	parent.add_child(vfx)
	
	var sf = get_skill_frames("flare_blitz", 15.0)
	var anim = AnimatedSprite2D.new()
	anim.sprite_frames = sf
	anim.rotation = (target_pos - origin_pos).angle()
	anim.scale = Vector2(0.65, 0.65) * scale_factor
	vfx.add_child(anim)
	anim.play("default")
	
	var tw = anim.create_tween()
	tw.tween_property(anim, "position", target_pos - origin_pos, 0.25).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tw.tween_callback(func():
		var burst = CPUParticles2D.new()
		burst.position = target_pos - origin_pos
		burst.emitting = true
		burst.one_shot = true
		burst.explosiveness = 0.95
		burst.amount = 28
		burst.lifetime = 0.4
		burst.spread = 180.0
		burst.gravity = Vector2.ZERO
		burst.initial_velocity_min = 60.0
		burst.initial_velocity_max = 120.0
		burst.color = Color(1.0, 0.4, 0.05)
		vfx.add_child(burst)
	)
	
	anim.animation_finished.connect(func():
		var tw_fade = vfx.create_tween()
		tw_fade.tween_property(vfx, "modulate:a", 0.0, 0.1)
		tw_fade.tween_callback(vfx.queue_free)
	)

# Helper: Dragon Apocalypse Celestial Meteor Deluge
static func _spawn_dragon_apocalypse(parent: Node2D, target_pos: Vector2, scale_factor: float, extra_targets: Array) -> void:
	var vfx = Node2D.new()
	vfx.z_index = 50
	parent.add_child(vfx)
	
	var pts = []
	for t in extra_targets:
		if is_instance_valid(t):
			pts.append(t.position)
	if pts.is_empty():
		pts.append(target_pos)
		pts.append(target_pos + Vector2(-60, -30))
		pts.append(target_pos + Vector2(60, 20))
	
	var sf = get_skill_frames("dragon_apocalypse", 15.0)
	for idx in range(pts.size()):
		var pt: Vector2 = pts[idx]
		var timer = vfx.get_tree().create_timer(float(idx) * 0.09)
		timer.timeout.connect(func():
			if not is_instance_valid(vfx):
				return
			var anim = AnimatedSprite2D.new()
			anim.sprite_frames = sf
			anim.position = pt
			anim.scale = Vector2(0.68, 0.68) * scale_factor
			vfx.add_child(anim)
			anim.play("default")
			
			var burst = CPUParticles2D.new()
			burst.position = pt
			burst.emitting = true
			burst.one_shot = true
			burst.explosiveness = 0.95
			burst.amount = 20
			burst.lifetime = 0.4
			burst.spread = 180.0
			burst.gravity = Vector2.ZERO
			burst.initial_velocity_min = 50.0
			burst.initial_velocity_max = 110.0
			burst.color = Color(1.0, 0.7, 0.2)
			vfx.add_child(burst)
			
			anim.animation_finished.connect(func(): anim.queue_free())
		)
	
	var clean_timer = vfx.get_tree().create_timer(pts.size() * 0.09 + 0.8)
	clean_timer.timeout.connect(func():
		if is_instance_valid(vfx):
			vfx.queue_free()
	)

# -------------------------------------------------------------
# GROUND TELEGRAPH & GROUND DECALS (3-LAYER COMPOSITE VFX)
# -------------------------------------------------------------

static func spawn_ground_telegraph(parent: Node2D, pos: Vector2, radius: float = 48.0, duration: float = 0.35, color: Color = Color(1.0, 0.25, 0.25, 0.7)) -> void:
	if not is_instance_valid(parent):
		return
	var tele = Node2D.new()
	tele.z_index = 5
	tele.position = pos
	parent.add_child(tele)
	
	var td = _TelegraphDraw.new()
	td.max_radius = radius
	td.ring_color = color
	tele.add_child(td)
	
	var tw = tele.create_tween()
	tw.tween_method(td.set_progress, 0.0, 1.0, duration).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tw.tween_callback(func():
		if is_instance_valid(tele):
			tele.queue_free()
	)

static func spawn_ground_decal(parent: Node2D, pos: Vector2, type: String = "scorch") -> void:
	if not is_instance_valid(parent):
		return
	var decal = Node2D.new()
	decal.z_index = 6
	decal.position = pos
	parent.add_child(decal)
	
	var dd = _GroundDecalDraw.new()
	dd.decal_type = type
	decal.add_child(dd)
	
	var tw = decal.create_tween()
	tw.tween_interval(1.2)
	tw.tween_method(dd.set_alpha, 1.0, 0.0, 1.3).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	tw.tween_callback(func():
		if is_instance_valid(decal):
			decal.queue_free()
	)

class _TelegraphDraw extends Node2D:
	var current_radius: float = 0.0
	var max_radius: float = 48.0
	var ring_color: Color = Color(1.0, 0.2, 0.2, 0.7)
	
	func set_progress(p: float) -> void:
		current_radius = max_radius * p
		queue_redraw()
		
	func _draw() -> void:
		draw_circle(Vector2.ZERO, current_radius, Color(ring_color.r, ring_color.g, ring_color.b, ring_color.a * 0.22))
		draw_arc(Vector2.ZERO, current_radius, 0, TAU, 32, ring_color, 2.5, true)
		draw_arc(Vector2.ZERO, max_radius, 0, TAU, 32, Color(ring_color.r, ring_color.g, ring_color.b, ring_color.a * 0.45), 1.5, true)

class _GroundDecalDraw extends Node2D:
	var decal_type: String = "scorch"
	var alpha_mult: float = 1.0
	
	func set_alpha(a: float) -> void:
		alpha_mult = a
		queue_redraw()
		
	func _draw() -> void:
		match decal_type:
			"scorch":
				draw_circle(Vector2.ZERO, 36.0, Color(0.10, 0.05, 0.03, 0.65 * alpha_mult))
				draw_circle(Vector2.ZERO, 18.0, Color(1.0, 0.42, 0.08, 0.45 * alpha_mult))
				for angle in [0.4, 1.8, 3.5, 5.0]:
					var ep = Vector2(cos(angle), sin(angle)) * 32.0
					draw_line(Vector2.ZERO, ep, Color(1.0, 0.35, 0.05, 0.75 * alpha_mult), 2.0)
			"electric":
				var spark_col = Color(1.0, 0.95, 0.3, 0.85 * alpha_mult)
				for i in range(5):
					var a1 = (i * 1.25)
					var p1 = Vector2(cos(a1), sin(a1)) * 14.0
					var p2 = p1 + Vector2(cos(a1 + 0.8), sin(a1 + 0.8)) * 18.0
					draw_line(p1, p2, spark_col, 2.0)
			"frost":
				draw_circle(Vector2.ZERO, 32.0, Color(0.4, 0.7, 0.95, 0.35 * alpha_mult))
				draw_arc(Vector2.ZERO, 32.0, 0, TAU, 6, Color(0.55, 0.88, 1.0, 0.7 * alpha_mult), 2.0)
