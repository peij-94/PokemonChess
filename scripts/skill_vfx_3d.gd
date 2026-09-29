extends Node3D
class_name SkillVFX3D

# SkillVFX3D: Volumetric 3D Visual Effects System for Pokemon Auto-Chess
# Supports true 3D particles, 3D laser beams, 3D parabolic arcs, 3D ground shockwaves,
# and 3D animated billboard sprite sequences for all 128 skills.

static var _cached_frames_3d: Dictionary = {}

static func get_vfx_frames(vfx_name: String, fps: float = 15.0) -> SpriteFrames:
	if _cached_frames_3d.has(vfx_name):
		return _cached_frames_3d[vfx_name]
		
	var sf = SpriteFrames.new()
	if not sf.has_animation("default"):
		sf.add_animation("default")
	sf.set_animation_loop("default", false)
	sf.set_animation_speed("default", fps)
	
	var base_dir = "res://assets/vfx/%s" % vfx_name
	var idx = 0
	while true:
		var frame_path = "%s/frame_%d.png" % [base_dir, idx]
		if ResourceLoader.exists(frame_path):
			sf.add_frame("default", load(frame_path))
			idx += 1
		else:
			break
			
	_cached_frames_3d[vfx_name] = sf
	return sf

# Main 3D VFX Dispatcher
static func spawn_skill_vfx_3d(vfx_name: String, parent_3d: Node3D, origin_3d: Vector3, target_3d: Vector3, scale_factor: float = 1.0, extra_targets_3d: Array = []) -> void:
	if parent_3d == null:
		return
		
	# Determine VFX category
	match vfx_name:
		"thunderbolt", "thundershock", "thunder", "volt_catastrophe", "discharge", "thunder_tempest":
			spawn_3d_lightning(parent_3d, target_3d, scale_factor, Color(1.0, 0.95, 0.35))
		"flamethrower", "fire_blast", "ember", "heat_wave", "blast_burn", "inferno":
			spawn_3d_fire_stream(parent_3d, origin_3d, target_3d, scale_factor)
		"hydro_pump", "hydro_cannon", "water_gun", "bubble_beam":
			spawn_3d_water_beam(parent_3d, origin_3d, target_3d, scale_factor)
		"solar_beam":
			spawn_3d_solar_beam(parent_3d, origin_3d, target_3d, scale_factor)
		"draco_meteor", "dragon_apocalypse":
			spawn_3d_meteor_shower(parent_3d, target_3d, scale_factor, extra_targets_3d)
		"blizzard", "avalanche", "sheer_cold":
			spawn_3d_ice_cataclysm(parent_3d, target_3d, scale_factor)
		"earthquake", "rock_slide", "stone_edge":
			spawn_3d_ground_rupture(parent_3d, target_3d, scale_factor)
		"shadow_ball", "dark_pulse", "night_shade", "hex_nightmare":
			spawn_3d_shadow_burst(parent_3d, origin_3d, target_3d, scale_factor)
		"psybeam", "psystrike", "future_sight", "hypnosis":
			spawn_3d_psychic_wave(parent_3d, origin_3d, target_3d, scale_factor)
		_:
			# Default: 3D Billboard Sprite Animation + 3D particle impact
			spawn_3d_billboard_vfx(parent_3d, vfx_name, origin_3d, target_3d, scale_factor)

# -------------------------------------------------------------
# 1. 3D Lightning Strike (Thunderbolt / Thunder / Discharge)
# -------------------------------------------------------------
static func spawn_3d_lightning(parent: Node3D, target_pos: Vector3, scale_factor: float, color: Color) -> void:
	var root = Node3D.new()
	root.position = target_pos
	parent.add_child(root)
	
	# Vertical 3D Lightning Cylinder Bolt from Sky (y=8 to y=0)
	var bolt = MeshInstance3D.new()
	var cyl = CylinderMesh.new()
	cyl.top_radius = 0.12 * scale_factor
	cyl.bottom_radius = 0.22 * scale_factor
	cyl.height = 8.0
	bolt.mesh = cyl
	
	var mat = StandardMaterial3D.new()
	mat.shading_mode = StandardMaterial3D.SHADING_MODE_UNSHADED
	mat.albedo_color = color
	mat.emission_enabled = true
	mat.emission = color
	mat.emission_energy_multiplier = 2.5
	bolt.set_surface_override_material(0, mat)
	bolt.position = Vector3(0, 4.0, 0)
	root.add_child(bolt)
	
	# 3D Ground Expanding Spark Ring
	var ring = MeshInstance3D.new()
	var torus = TorusMesh.new()
	torus.inner_radius = 0.4 * scale_factor
	torus.outer_radius = 0.6 * scale_factor
	ring.mesh = torus
	ring.set_surface_override_material(0, mat)
	ring.position = Vector3(0, 0.05, 0)
	root.add_child(ring)
	
	# 3D Particles Burst
	var particles = CPUParticles3D.new()
	particles.emitting = true
	particles.one_shot = true
	particles.explosiveness = 0.95
	particles.amount = 24
	particles.lifetime = 0.45
	particles.spread = 180.0
	particles.gravity = Vector3(0, -2.0, 0)
	particles.initial_velocity_min = 4.0
	particles.initial_velocity_max = 8.5
	particles.color = color
	root.add_child(particles)
	
	# 3D Billboard Sprite Frames overlay
	var anim = AnimatedSprite3D.new()
	anim.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	anim.sprite_frames = get_vfx_frames("thunderbolt", 16.0)
	anim.position = Vector3(0, 1.2, 0)
	anim.pixel_size = 0.018 * scale_factor
	root.add_child(anim)
	anim.play("default")
	
	var tw = root.create_tween()
	tw.tween_property(bolt, "scale:x", 0.0, 0.35)
	tw.parallel().tween_property(bolt, "scale:z", 0.0, 0.35)
	tw.parallel().tween_property(ring, "scale", Vector3(2.5, 1.0, 2.5), 0.35)
	tw.parallel().tween_property(ring, "transparency", 1.0, 0.35)
	tw.tween_callback(root.queue_free)

# -------------------------------------------------------------
# 2. 3D Fire Stream & Fireball (Flamethrower / Fire Blast)
# -------------------------------------------------------------
static func spawn_3d_fire_stream(parent: Node3D, origin_pos: Vector3, target_pos: Vector3, scale_factor: float) -> void:
	var root = Node3D.new()
	parent.add_child(root)
	
	var dir = (target_pos - origin_pos)
	var dist = dir.length()
	
	# 3D Projectile Fireball launching in 3D arc
	var ball = MeshInstance3D.new()
	var sphere = SphereMesh.new()
	sphere.radius = 0.35 * scale_factor
	sphere.height = 0.70 * scale_factor
	ball.mesh = sphere
	
	var mat = StandardMaterial3D.new()
	mat.shading_mode = StandardMaterial3D.SHADING_MODE_UNSHADED
	mat.albedo_color = Color(1.0, 0.45, 0.1)
	mat.emission_enabled = true
	mat.emission = Color(1.0, 0.5, 0.0)
	mat.emission_energy_multiplier = 2.0
	ball.set_surface_override_material(0, mat)
	ball.position = origin_pos + Vector3(0, 0.6, 0)
	root.add_child(ball)
	
	# 3D Particle Flame Cone
	var particles = CPUParticles3D.new()
	particles.position = origin_pos + Vector3(0, 0.6, 0)
	particles.emitting = true
	particles.one_shot = true
	particles.amount = 32
	particles.lifetime = 0.35
	particles.direction = dir.normalized()
	particles.spread = 22.0
	particles.gravity = Vector3(0, 0.5, 0)
	particles.initial_velocity_min = dist * 2.2
	particles.initial_velocity_max = dist * 3.5
	particles.color = Color(1.0, 0.35, 0.05)
	root.add_child(particles)
	
	# Tween fireball along 3D path with slight elevation arc
	var tw = ball.create_tween()
	tw.tween_property(ball, "position", target_pos + Vector3(0, 0.5, 0), 0.28).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tw.tween_callback(func():
		ball.visible = false
		# Impact 3D Explosion
		var burst = CPUParticles3D.new()
		burst.position = target_pos + Vector3(0, 0.5, 0)
		burst.emitting = true
		burst.one_shot = true
		burst.explosiveness = 0.95
		burst.amount = 26
		burst.lifetime = 0.45
		burst.spread = 180.0
		burst.gravity = Vector3(0, -1.0, 0)
		burst.initial_velocity_min = 4.0
		burst.initial_velocity_max = 8.0
		burst.color = Color(1.0, 0.5, 0.1)
		root.add_child(burst)
	)
	
	var clean_tw = root.create_tween()
	clean_tw.tween_interval(0.75)
	clean_tw.tween_callback(root.queue_free)

# -------------------------------------------------------------
# 3. 3D Water Beam / Torrent (Hydro Pump / Surf)
# -------------------------------------------------------------
static func spawn_3d_water_beam(parent: Node3D, origin_pos: Vector3, target_pos: Vector3, scale_factor: float) -> void:
	var root = Node3D.new()
	parent.add_child(root)
	
	var start_pt = origin_pos + Vector3(0, 0.6, 0)
	var end_pt = target_pos + Vector3(0, 0.6, 0)
	var dir = end_pt - start_pt
	var dist = dir.length()
	
	# 3D Cylinder Water Jet
	var beam = MeshInstance3D.new()
	var cyl = CylinderMesh.new()
	cyl.top_radius = 0.28 * scale_factor
	cyl.bottom_radius = 0.38 * scale_factor
	cyl.height = dist
	beam.mesh = cyl
	
	var mat = StandardMaterial3D.new()
	mat.diffuse_mode = BaseMaterial3D.DIFFUSE_TOON
	mat.specular_mode = BaseMaterial3D.SPECULAR_TOON
	mat.transparency = StandardMaterial3D.TRANSPARENCY_ALPHA
	mat.albedo_color = Color(0.2, 0.65, 1.0, 0.75)
	mat.emission_enabled = true
	mat.emission = Color(0.3, 0.75, 1.0)
	mat.emission_energy_multiplier = 1.6
	beam.set_surface_override_material(0, mat)
	
	beam.position = start_pt + dir * 0.5
	root.add_child(beam)
	if not dir.is_zero_approx() and not dir.normalized().is_equal_approx(Vector3.UP) and not dir.normalized().is_equal_approx(Vector3.DOWN):
		if beam.is_inside_tree():
			beam.look_at(end_pt, Vector3.UP)
			beam.rotate_object_local(Vector3.RIGHT, PI * 0.5)
	
	# 3D Splash Particles at target
	var splash = CPUParticles3D.new()
	splash.position = end_pt
	splash.emitting = true
	splash.one_shot = true
	splash.explosiveness = 0.9
	splash.amount = 28
	splash.lifetime = 0.5
	splash.spread = 180.0
	splash.gravity = Vector3(0, -6.0, 0)
	splash.initial_velocity_min = 3.5
	splash.initial_velocity_max = 7.5
	splash.color = Color(0.3, 0.8, 1.0, 0.9)
	root.add_child(splash)
	
	var tw = root.create_tween()
	tw.tween_property(beam, "scale:x", 1.4, 0.15)
	tw.parallel().tween_property(beam, "scale:z", 1.4, 0.15)
	tw.tween_property(beam, "scale:x", 0.0, 0.2)
	tw.parallel().tween_property(beam, "scale:z", 0.0, 0.2)
	tw.tween_interval(0.3)
	tw.tween_callback(root.queue_free)

# -------------------------------------------------------------
# 4. 3D Solar Beam (Giant Green-Gold Laser Column)
# -------------------------------------------------------------
static func spawn_3d_solar_beam(parent: Node3D, origin_pos: Vector3, target_pos: Vector3, scale_factor: float) -> void:
	var root = Node3D.new()
	parent.add_child(root)
	
	var start_pt = origin_pos + Vector3(0, 0.7, 0)
	var end_pt = target_pos + Vector3(0, 0.7, 0)
	var dir = end_pt - start_pt
	var dist = dir.length()
	
	var beam = MeshInstance3D.new()
	var cyl = CylinderMesh.new()
	cyl.top_radius = 0.45 * scale_factor
	cyl.bottom_radius = 0.55 * scale_factor
	cyl.height = dist
	beam.mesh = cyl
	
	var mat = StandardMaterial3D.new()
	mat.shading_mode = StandardMaterial3D.SHADING_MODE_UNSHADED
	mat.albedo_color = Color(0.9, 1.0, 0.3)
	mat.emission_enabled = true
	mat.emission = Color(0.6, 1.0, 0.2)
	mat.emission_energy_multiplier = 3.0
	beam.set_surface_override_material(0, mat)
	
	beam.position = start_pt + dir * 0.5
	root.add_child(beam)
	if not dir.is_zero_approx() and not dir.normalized().is_equal_approx(Vector3.UP) and not dir.normalized().is_equal_approx(Vector3.DOWN):
		if beam.is_inside_tree():
			beam.look_at(end_pt, Vector3.UP)
			beam.rotate_object_local(Vector3.RIGHT, PI * 0.5)
	
	var tw = root.create_tween()
	tw.tween_property(beam, "scale:x", 1.6, 0.12).set_trans(Tween.TRANS_BACK)
	tw.parallel().tween_property(beam, "scale:z", 1.6, 0.12)
	tw.tween_property(beam, "scale:x", 0.05, 0.25)
	tw.parallel().tween_property(beam, "scale:z", 0.05, 0.25)
	tw.tween_callback(root.queue_free)

# -------------------------------------------------------------
# 5. 3D Draco Meteor / Meteor Deluge
# -------------------------------------------------------------
static func spawn_3d_meteor_shower(parent: Node3D, target_pos: Vector3, scale_factor: float, extra_targets: Array) -> void:
	var root = Node3D.new()
	parent.add_child(root)
	
	var points = [target_pos]
	for t in extra_targets:
		if t is Node3D and is_instance_valid(t):
			points.append(t.position)
		elif t is Vector3:
			points.append(t)
			
	for idx in range(min(4, points.size())):
		var pt: Vector3 = points[idx]
		var delay = float(idx) * 0.12
		
		var meteor = MeshInstance3D.new()
		var sphere = SphereMesh.new()
		sphere.radius = 0.40 * scale_factor
		sphere.height = 0.80 * scale_factor
		meteor.mesh = sphere
		
		var mat = StandardMaterial3D.new()
		mat.albedo_color = Color(1.0, 0.35, 0.1)
		mat.emission_enabled = true
		mat.emission = Color(1.0, 0.4, 0.0)
		mat.emission_energy_multiplier = 2.5
		meteor.set_surface_override_material(0, mat)
		
		var sky_pos = pt + Vector3(randf_range(-1.0, 1.0), 7.5, randf_range(-1.0, 1.0))
		meteor.position = sky_pos
		root.add_child(meteor)
		
		var tw = meteor.create_tween()
		tw.tween_interval(delay)
		tw.tween_property(meteor, "position", pt + Vector3(0, 0.2, 0), 0.32).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
		tw.tween_callback(func():
			meteor.visible = false
			# 3D Ground Impact Shockwave
			var crater = MeshInstance3D.new()
			var torus = TorusMesh.new()
			torus.inner_radius = 0.45 * scale_factor
			torus.outer_radius = 0.65 * scale_factor
			crater.mesh = torus
			crater.set_surface_override_material(0, mat)
			crater.position = pt + Vector3(0, 0.05, 0)
			root.add_child(crater)
			
			var cr_tw = crater.create_tween()
			cr_tw.tween_property(crater, "scale", Vector3(2.2, 1.0, 2.2), 0.3)
			cr_tw.parallel().tween_property(crater, "transparency", 1.0, 0.3)
			cr_tw.tween_callback(crater.queue_free)
		)
	
	var clean_tw = root.create_tween()
	clean_tw.tween_interval(1.2)
	clean_tw.tween_callback(root.queue_free)

# -------------------------------------------------------------
# 6. 3D Ice Cataclysm (Blizzard / Avalanche / Ice Beam)
# -------------------------------------------------------------
static func spawn_3d_ice_cataclysm(parent: Node3D, target_pos: Vector3, scale_factor: float) -> void:
	var root = Node3D.new()
	root.position = target_pos
	parent.add_child(root)
	
	# 3D Glacier Spikes bursting up from ground
	for i in range(5):
		var spike = MeshInstance3D.new()
		var prism = BoxMesh.new()
		prism.size = Vector3(0.35, 1.4 * scale_factor, 0.35)
		spike.mesh = prism
		
		var mat = StandardMaterial3D.new()
		mat.diffuse_mode = BaseMaterial3D.DIFFUSE_TOON
		mat.specular_mode = BaseMaterial3D.SPECULAR_TOON
		mat.transparency = StandardMaterial3D.TRANSPARENCY_ALPHA
		mat.albedo_color = Color(0.65, 0.90, 1.0, 0.8)
		mat.roughness = 0.1
		mat.metallic = 0.3
		mat.emission_enabled = true
		mat.emission = Color(0.4, 0.8, 1.0)
		mat.emission_energy_multiplier = 1.2
		spike.set_surface_override_material(0, mat)
		
		var angle = float(i) * (PI * 2.0 / 5.0)
		var offset = Vector3(cos(angle) * 0.65, -0.7, sin(angle) * 0.65)
		spike.position = offset
		spike.rotation = Vector3(randf_range(-0.3, 0.3), randf_range(0, PI), randf_range(-0.3, 0.3))
		root.add_child(spike)
		
		var tw = spike.create_tween()
		tw.tween_property(spike, "position:y", 0.6 * scale_factor, 0.18).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
		tw.tween_interval(0.3)
		tw.tween_property(spike, "position:y", -0.7, 0.25).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	
	var clean_tw = root.create_tween()
	clean_tw.tween_interval(0.9)
	clean_tw.tween_callback(root.queue_free)

# -------------------------------------------------------------
# 7. 3D Ground Rupture (Earthquake / Rock Slide)
# -------------------------------------------------------------
static func spawn_3d_ground_rupture(parent: Node3D, target_pos: Vector3, scale_factor: float) -> void:
	var root = Node3D.new()
	root.position = target_pos
	parent.add_child(root)
	
	var ring = MeshInstance3D.new()
	var torus = TorusMesh.new()
	torus.inner_radius = 0.5 * scale_factor
	torus.outer_radius = 0.8 * scale_factor
	ring.mesh = torus
	
	var mat = StandardMaterial3D.new()
	mat.diffuse_mode = BaseMaterial3D.DIFFUSE_TOON
	mat.specular_mode = BaseMaterial3D.SPECULAR_TOON
	mat.albedo_color = Color(0.7, 0.5, 0.3)
	mat.emission_enabled = true
	mat.emission = Color(0.8, 0.6, 0.2)
	mat.emission_energy_multiplier = 1.5
	ring.set_surface_override_material(0, mat)
	ring.position = Vector3(0, 0.05, 0)
	root.add_child(ring)
	
	var tw = ring.create_tween()
	tw.tween_property(ring, "scale", Vector3(2.5, 1.0, 2.5), 0.35)
	tw.parallel().tween_property(ring, "transparency", 1.0, 0.35)
	tw.tween_callback(root.queue_free)

# -------------------------------------------------------------
# 8. 3D Shadow Burst (Shadow Ball / Dark Pulse)
# -------------------------------------------------------------
static func spawn_3d_shadow_burst(parent: Node3D, origin_pos: Vector3, target_pos: Vector3, scale_factor: float) -> void:
	var root = Node3D.new()
	parent.add_child(root)
	
	var orb = MeshInstance3D.new()
	var sphere = SphereMesh.new()
	sphere.radius = 0.38 * scale_factor
	sphere.height = 0.76 * scale_factor
	orb.mesh = sphere
	
	var mat = StandardMaterial3D.new()
	mat.albedo_color = Color(0.25, 0.08, 0.35)
	mat.emission_enabled = true
	mat.emission = Color(0.65, 0.15, 0.85)
	mat.emission_energy_multiplier = 2.2
	orb.set_surface_override_material(0, mat)
	orb.position = origin_pos + Vector3(0, 0.6, 0)
	root.add_child(orb)
	
	var tw = orb.create_tween()
	tw.tween_property(orb, "position", target_pos + Vector3(0, 0.6, 0), 0.25).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tw.tween_callback(func():
		orb.visible = false
		var burst = CPUParticles3D.new()
		burst.position = target_pos + Vector3(0, 0.6, 0)
		burst.emitting = true
		burst.one_shot = true
		burst.explosiveness = 0.95
		burst.amount = 24
		burst.lifetime = 0.4
		burst.spread = 180.0
		burst.color = Color(0.7, 0.2, 0.9)
		root.add_child(burst)
	)
	
	var clean = root.create_tween()
	clean.tween_interval(0.7)
	clean.tween_callback(root.queue_free)

# -------------------------------------------------------------
# 9. 3D Psychic Wave (Psybeam / Psystrike)
# -------------------------------------------------------------
static func spawn_3d_psychic_wave(parent: Node3D, origin_pos: Vector3, target_pos: Vector3, scale_factor: float) -> void:
	var root = Node3D.new()
	root.position = target_pos
	parent.add_child(root)
	
	for i in range(3):
		var ring = MeshInstance3D.new()
		var torus = TorusMesh.new()
		torus.inner_radius = 0.3 * scale_factor
		torus.outer_radius = 0.45 * scale_factor
		ring.mesh = torus
		
		var mat = StandardMaterial3D.new()
		mat.albedo_color = Color(0.9, 0.35, 1.0)
		mat.emission_enabled = true
		mat.emission = Color(0.85, 0.4, 0.95)
		mat.emission_energy_multiplier = 2.0
		ring.set_surface_override_material(0, mat)
		ring.position = Vector3(0, 0.3 + float(i) * 0.35, 0)
		root.add_child(ring)
		
		var tw = ring.create_tween()
		tw.tween_interval(float(i) * 0.08)
		tw.tween_property(ring, "scale", Vector3(2.4, 1.0, 2.4), 0.32)
		tw.parallel().tween_property(ring, "transparency", 1.0, 0.32)
	
	var clean = root.create_tween()
	clean.tween_interval(0.7)
	clean.tween_callback(root.queue_free)

# -------------------------------------------------------------
# 10. 3D Billboard Sprite Animation for all 128 unique VFX
# -------------------------------------------------------------
static func spawn_3d_billboard_vfx(parent: Node3D, vfx_name: String, origin_pos: Vector3, target_pos: Vector3, scale_factor: float) -> void:
	var root = Node3D.new()
	root.position = target_pos
	parent.add_child(root)
	
	var anim = AnimatedSprite3D.new()
	anim.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	anim.sprite_frames = get_vfx_frames(vfx_name, 16.0)
	anim.position = Vector3(0, 0.8, 0)
	anim.pixel_size = 0.015 * scale_factor
	root.add_child(anim)
	anim.play("default")
	
	# Light impact sparks
	var sparks = CPUParticles3D.new()
	sparks.position = Vector3(0, 0.5, 0)
	sparks.emitting = true
	sparks.one_shot = true
	sparks.explosiveness = 0.9
	sparks.amount = 16
	sparks.lifetime = 0.35
	sparks.spread = 180.0
	sparks.gravity = Vector3(0, -2.0, 0)
	sparks.initial_velocity_min = 2.5
	sparks.initial_velocity_max = 5.5
	sparks.color = Color(1.0, 0.9, 0.4)
	root.add_child(sparks)
	
	anim.animation_finished.connect(func():
		var tw = root.create_tween()
		tw.tween_property(anim, "modulate:a", 0.0, 0.1)
		tw.tween_callback(root.queue_free)
	)
