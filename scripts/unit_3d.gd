extends Node3D
class_name Unit3D

# Unit3D: Amiibo / Tabletop Figure 3D Representation for Pokemon Auto-Chess
# Features:
# - Supports both genuine 3D GLB models and authentic 2D AnimatedSprite3D billboard fallback
# - Premium acrylic crystal pedestal base with gold metallic bezel rim
# - Translucent crystal body (Sapphire for Player, Ruby for Enemy)
# - Polished metallic rim with Star-level evolution trim (Gold, Platinum, Radiant Prismatic)
# - Tactile pick-up & drop-snap physics (elevation, dynamic motion tilt, bounce compression)
# - Weighted tabletop clack impact sound & ground impact dust particles
# - 3D floating status bar & elemental particles

@onready var sprite: AnimatedSprite3D = $Sprite
@onready var floor_shadow: MeshInstance3D = $FloorShadow
@onready var shadow_mesh: MeshInstance3D = $FloorShadow # Alias for backward compatibility
@onready var pedestal: Node3D = $Pedestal
@onready var base_cylinder: MeshInstance3D = $Pedestal/BaseCylinder
@onready var gold_rim: MeshInstance3D = $Pedestal/GoldRim
@onready var inner_plate: MeshInstance3D = $Pedestal/InnerPlate
@onready var contact_shadow: MeshInstance3D = $Pedestal/PedestalShadow
@onready var cast_particles: CPUParticles3D = $CastParticles
@onready var drop_particles: CPUParticles3D = $DropParticles
@onready var ui_bar_3d: Sprite3D = $UIBar3D
@onready var ui_viewport: SubViewport = $SubViewport

# SubViewport UI elements
@onready var hp_bar: ProgressBar = $SubViewport/UIContainer/HPBar
@onready var mana_bar: ProgressBar = $SubViewport/UIContainer/ManaBar
@onready var name_label: Label = $SubViewport/UIContainer/NameLabel
@onready var star_container: HBoxContainer = $SubViewport/UIContainer/StarContainer

var pokemon_id: String = ""
var star_level: int = 1
var is_enemy: bool = false
var base_scale_3d: Vector3 = Vector3(1, 1, 1)

# True 3D GLB Model Instance
var model_anchor: Node3D = null
var model_3d: Node3D = null
var anim_player_3d: AnimationPlayer = null
var model_base_y: float = 0.08

# Tactile Amiibo Drag & Drop state
var is_dragged: bool = false
var drag_elevation: float = 0.0
var tilt_target: Vector3 = Vector3.ZERO
var current_tilt: Vector3 = Vector3.ZERO
var last_drag_pos: Vector3 = Vector3.ZERO
var elevation_tween: Tween = null
var squash_tween: Tween = null

# Micro-breathing & combat state
var bob_time: float = 0.0
var is_animating_action: bool = false

# Materials
var crystal_mat: StandardMaterial3D = null
var rim_mat: StandardMaterial3D = null
var plate_mat: StandardMaterial3D = null

func _ready() -> void:
	if ui_viewport and ui_bar_3d:
		ui_bar_3d.texture = ui_viewport.get_texture()
	_init_materials()

func _init_materials() -> void:
	if base_cylinder:
		var orig = base_cylinder.get_active_material(0)
		crystal_mat = orig.duplicate() if orig else StandardMaterial3D.new()
		base_cylinder.set_surface_override_material(0, crystal_mat)
	if gold_rim:
		var orig_rim = gold_rim.get_active_material(0)
		rim_mat = orig_rim.duplicate() if orig_rim else StandardMaterial3D.new()
		gold_rim.set_surface_override_material(0, rim_mat)
	if inner_plate:
		var orig_pl = inner_plate.get_active_material(0)
		plate_mat = orig_pl.duplicate() if orig_pl else StandardMaterial3D.new()
		inner_plate.set_surface_override_material(0, plate_mat)

func setup_visuals(p_id: String, p_star: int, p_is_enemy: bool, p_name: String) -> void:
	pokemon_id = p_id
	star_level = p_star
	is_enemy = p_is_enemy
	
	if crystal_mat == null:
		_init_materials()
	
	if name_label:
		name_label.text = p_name
	
	var target_height = 1.15 + (star_level - 1) * 0.16
	
	# Configure Amiibo Pedestal Crystal & Gold Materials
	_apply_pedestal_materials()
	
	# Check if a genuine 3D GLB model exists in assets/models/<pokemon_id>.glb
	var model_path = "res://assets/models/%s.glb" % pokemon_id
	if FileAccess.file_exists(model_path):
		_setup_3d_mesh(model_path, target_height)
	else:
		_setup_2d_sprite(target_height)
	
	# Star badges in 3D UI
	if star_container:
		for c in star_container.get_children():
			c.queue_free()
		for i in range(star_level):
			var star = TextureRect.new()
			star.texture = load("res://assets/ui/star_badge.png")
			star.custom_minimum_size = Vector2(16, 16)
			star.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
			star_container.add_child(star)
			
	if hp_bar:
		if is_enemy:
			hp_bar.modulate = Color(0.95, 0.3, 0.3)
		else:
			hp_bar.modulate = Color(0.3, 0.85, 0.4)
			
	# Subtle random bob phase so figurines have natural micro-presence
	bob_time = randf() * PI * 2.0

func _setup_2d_sprite(target_height: float) -> void:
	if model_3d and is_instance_valid(model_3d):
		model_3d.visible = false
	sprite.visible = true
	var sf = PokemonDatabase.get_sprite_frames(pokemon_id)
	sprite.sprite_frames = sf
	sprite.play("idle")
	sprite.pixel_size = 0.016 * (target_height / 1.15)

func _setup_3d_mesh(model_path: String, target_height: float) -> void:
	sprite.visible = false
	if model_anchor != null and is_instance_valid(model_anchor):
		model_anchor.queue_free()
		model_anchor = null
		model_3d = null
		anim_player_3d = null
	elif model_3d != null and is_instance_valid(model_3d):
		model_3d.queue_free()
		model_3d = null
		anim_player_3d = null
		
	var gltf = GLTFDocument.new()
	var state = GLTFState.new()
	var err = gltf.append_from_file(model_path, state)
	if err != OK:
		_setup_2d_sprite(target_height)
		return
		
	model_3d = gltf.generate_scene(state)
	if model_3d == null:
		_setup_2d_sprite(target_height)
		return
		
	model_anchor = Node3D.new()
	model_anchor.name = "ModelAnchor"
	model_anchor.position = Vector3(0, model_base_y, 0)
	add_child(model_anchor)
	model_anchor.add_child(model_3d)
	
	# Calculate bounding box to normalize scale
	var aabb = _calculate_model_aabb(model_3d)
	var max_dim = max(aabb.size.x, max(aabb.size.y, aabb.size.z))
	var s = target_height / max_dim if max_dim > 0.001 else 1.0
	model_3d.scale = Vector3(s, s, s)
	
	# Position model inside anchor so feet are grounded and centered horizontally
	model_3d.position.x = -(aabb.position.x + aabb.size.x * 0.5) * s
	model_3d.position.y = -aabb.position.y * s
	model_3d.position.z = -(aabb.position.z + aabb.size.z * 0.5) * s
	
	# Facing orientation: player units face towards enemy side (-Z), enemy units face (+Z)
	if is_enemy:
		model_anchor.rotation.y = 0.0
	else:
		model_anchor.rotation.y = PI
		
	anim_player_3d = model_3d.find_child("AnimationPlayer", true, false)
	if anim_player_3d:
		var anims = anim_player_3d.get_animation_list()
		if not anims.is_empty():
			anim_player_3d.play(anims[0])

func _calculate_model_aabb(node: Node) -> AABB:
	var total_aabb = AABB()
	var first = true
	var stack = [node]
	while not stack.is_empty():
		var curr = stack.pop_back()
		if curr is MeshInstance3D and curr.mesh:
			var maabb = curr.get_aabb()
			if first:
				total_aabb = maabb
				first = false
			else:
				total_aabb = total_aabb.merge(maabb)
		for c in curr.get_children():
			stack.push_back(c)
	if first:
		return AABB(Vector3(-0.5, 0, -0.5), Vector3(1, 1, 1))
	return total_aabb

func _apply_pedestal_materials() -> void:
	if crystal_mat:
		crystal_mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
		crystal_mat.roughness = 0.15
		crystal_mat.metallic = 0.10
		crystal_mat.clearcoat_enabled = true
		crystal_mat.clearcoat = 0.85
		crystal_mat.clearcoat_roughness = 0.12
		crystal_mat.rim_enabled = true
		crystal_mat.rim = 0.55
		crystal_mat.rim_tint = 0.5
		
		if is_enemy:
			# Ruby / Obsidian Crystal Base for Enemies
			crystal_mat.albedo_color = Color(0.85, 0.18, 0.28, 0.88)
			if plate_mat:
				plate_mat.albedo_color = Color(0.24, 0.06, 0.10, 1.0)
				plate_mat.metallic = 0.35
				plate_mat.roughness = 0.22
		else:
			# Sapphire / Cyan Crystal Base for Player Units
			crystal_mat.albedo_color = Color(0.18, 0.50, 0.90, 0.88)
			if plate_mat:
				plate_mat.albedo_color = Color(0.08, 0.16, 0.28, 1.0)
				plate_mat.metallic = 0.35
				plate_mat.roughness = 0.22

	if rim_mat:
		rim_mat.clearcoat_enabled = true
		rim_mat.clearcoat = 0.70
		if star_level == 1:
			# 1-Star: Polished Yellow Brass / Gold Bezel
			rim_mat.albedo_color = Color(1.0, 0.84, 0.35, 1.0)
			rim_mat.metallic = 0.92
			rim_mat.roughness = 0.20
			rim_mat.emission_enabled = false
		elif star_level == 2:
			# 2-Star: Brilliant Platinum / Chrome Bezel
			rim_mat.albedo_color = Color(0.92, 0.96, 1.0, 1.0)
			rim_mat.metallic = 0.96
			rim_mat.roughness = 0.12
			rim_mat.emission_enabled = true
			rim_mat.emission = Color(0.15, 0.20, 0.28)
			rim_mat.emission_energy_multiplier = 0.6
		else:
			# 3-Star: Royal Radiant Prismatic Gold Rim
			rim_mat.albedo_color = Color(1.0, 0.88, 0.40, 1.0)
			rim_mat.metallic = 0.98
			rim_mat.roughness = 0.08
			rim_mat.emission_enabled = true
			rim_mat.emission = Color(0.42, 0.32, 0.08)
			rim_mat.emission_energy_multiplier = 0.9

func update_bars(current_hp: float, max_hp: float, current_mana: float, max_mana: float) -> void:
	if hp_bar:
		hp_bar.max_value = max_hp
		hp_bar.value = current_hp
	if mana_bar:
		mana_bar.max_value = max_mana
		mana_bar.value = current_mana

func play_animation(anim_name: String) -> void:
	if anim_player_3d and is_instance_valid(anim_player_3d):
		if anim_player_3d.has_animation(anim_name):
			anim_player_3d.play(anim_name)
			return
		elif anim_name == "attack":
			for a in ["attack", "Attack", "Impactrueno", "hit", "strike"]:
				if anim_player_3d.has_animation(a):
					anim_player_3d.play(a)
					return
	if sprite.visible and sprite.sprite_frames and sprite.sprite_frames.has_animation(anim_name):
		sprite.play(anim_name)

func set_facing(dir_3d: Vector3) -> void:
	var anchor_target = model_anchor if (model_anchor and is_instance_valid(model_anchor)) else model_3d
	if anchor_target and is_instance_valid(anchor_target) and dir_3d.length_squared() > 0.01:
		var target_rot = atan2(dir_3d.x, dir_3d.z)
		anchor_target.rotation.y = lerp_angle(anchor_target.rotation.y, target_rot, 0.25)
	elif sprite.visible:
		sprite.flip_h = (dir_3d.x < 0)

func _process(delta: float) -> void:
	# Keep floor shadow on the ground plane when unit is lifted during dragging
	if floor_shadow:
		floor_shadow.position.y = -drag_elevation + 0.008
		
	var anchor_target = model_anchor if (model_anchor and is_instance_valid(model_anchor)) else model_3d
	if is_dragged:
		# Smoothly lerp towards drag tilt
		current_tilt = current_tilt.lerp(tilt_target, delta * 12.0)
		pedestal.rotation = current_tilt
		if sprite.visible:
			sprite.rotation = current_tilt * 0.7
		elif anchor_target and is_instance_valid(anchor_target):
			anchor_target.rotation.x = current_tilt.x * 0.8
			anchor_target.rotation.z = current_tilt.z * 0.8
		# Gradually decay tilt target towards neutral if no further motion
		tilt_target = tilt_target.lerp(Vector3.ZERO, delta * 6.0)
	else:
		# Settle rotation
		pedestal.rotation = pedestal.rotation.lerp(Vector3.ZERO, delta * 15.0)
		if sprite.visible:
			sprite.rotation = sprite.rotation.lerp(Vector3.ZERO, delta * 15.0)
		elif anchor_target and is_instance_valid(anchor_target):
			anchor_target.rotation.x = lerpf(anchor_target.rotation.x, 0.0, delta * 15.0)
			anchor_target.rotation.z = lerpf(anchor_target.rotation.z, 0.0, delta * 15.0)
			
		if not is_animating_action:
			bob_time += delta * 2.8
			# Subtle tactile breathing: Pokemon figurine slightly bobs on pedestal
			if sprite.visible:
				sprite.position.y = 0.70 + sin(bob_time) * 0.02
			elif anchor_target and is_instance_valid(anchor_target):
				anchor_target.position.y = model_base_y + sin(bob_time) * 0.015

# === TACTILE AMIIBO DRAG & DROP SYSTEM ===

# Called when player picks up the figurine
func perform_pickup() -> void:
	is_dragged = true
	last_drag_pos = position
	tilt_target = Vector3(-0.12, 0.0, 0.08) # Initial natural lift tilt
	
	if elevation_tween:
		elevation_tween.kill()
	elevation_tween = create_tween()
	elevation_tween.tween_property(self, "drag_elevation", 0.70, 0.16).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	
	# Soften floor shadow as figurine is lifted
	if floor_shadow:
		var tw = create_tween()
		tw.tween_property(floor_shadow, "scale", Vector3(1.22, 1.0, 1.22), 0.16)
		
	# Subtle grab highlight on gold rim
	if rim_mat:
		rim_mat.emission_enabled = true
		rim_mat.emission = Color(0.45, 0.35, 0.12)
		rim_mat.emission_energy_multiplier = 0.8

# Called during dragging to calculate physical figurine tilt from hand movement
func update_drag_motion(current_world_pos: Vector3) -> void:
	if not is_dragged:
		return
	var delta_v = current_world_pos - last_drag_pos
	last_drag_pos = current_world_pos
	
	# Tilt physically into movement direction:
	var roll = clamp(-delta_v.x * 2.8, -0.28, 0.28)
	var pitch = clamp(delta_v.z * 2.8, -0.28, 0.28)
	tilt_target = Vector3(pitch, 0.0, roll)

# Called when figurine is dropped onto a tile or bench slot
func perform_drop_bounce() -> void:
	is_dragged = false
	tilt_target = Vector3.ZERO
	
	if elevation_tween:
		elevation_tween.kill()
	elevation_tween = create_tween()
	# Fast drop to board surface
	elevation_tween.tween_property(self, "drag_elevation", 0.0, 0.11).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	elevation_tween.tween_callback(_on_drop_impact)

func _on_drop_impact() -> void:
	# 1. Play tactile clack SFX
	AudioManager.play_sfx("click", 1.25, 2.5)
	
	# 2. Emit ground dust/spark puff
	if drop_particles:
		drop_particles.restart()
		drop_particles.emitting = true
		
	# 3. Squash and spring rebound
	if squash_tween:
		squash_tween.kill()
	squash_tween = create_tween()
	# Impact squash: compress Y, expand X/Z
	squash_tween.tween_property(self, "scale", Vector3(1.08, 0.88, 1.08), 0.05).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	# Spring rebound
	squash_tween.tween_property(self, "scale", Vector3(0.97, 1.05, 0.97), 0.06).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	# Settle to neutral
	squash_tween.tween_property(self, "scale", Vector3(1.0, 1.0, 1.0), 0.07).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	
	# 4. Restore floor shadow
	if floor_shadow:
		var tw = create_tween()
		tw.tween_property(floor_shadow, "scale", Vector3(1.0, 1.0, 1.0), 0.12)
		
	# 5. Restore rim materials
	_apply_pedestal_materials()

# === COMBAT ACTIONS (WEIGHTY TABLETOP FIGURE PHYSICS) ===

# 3D Physical Tabletop Leap toward target
func perform_3d_attack_leap(target_world_pos: Vector3, duration: float = 0.22) -> void:
	is_animating_action = true
	play_animation("attack")
	
	var home_pos = position
	var dir = (target_world_pos - home_pos)
	var leap_offset = dir.normalized() * min(dir.length() * 0.38, 0.65)
	
	var tw = create_tween()
	# Figurine hops forward and tilts into strike
	tw.tween_property(self, "position", home_pos + leap_offset + Vector3(0, 0.32, 0), duration * 0.45).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tw.parallel().tween_property(pedestal, "rotation:x", -0.15, duration * 0.45)
	# Strikes down onto tile with clack
	tw.tween_property(self, "position", home_pos, duration * 0.55).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tw.parallel().tween_property(pedestal, "rotation:x", 0.0, duration * 0.55)
	tw.tween_callback(func():
		is_animating_action = false
		play_animation("idle")
	)

# 3D Skill Cast: Figurine elevates, crystal pedestal glows, cast particles explode
func perform_3d_skill_cast() -> void:
	is_animating_action = true
	play_animation("attack")
	if cast_particles:
		cast_particles.restart()
		cast_particles.emitting = true
		
	var home_y = position.y
	var tw = create_tween()
	# Elevate in 3D air with radiant pedestal rim glow
	tw.tween_property(self, "position:y", home_y + 0.45, 0.16).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	if sprite.visible:
		tw.parallel().tween_property(sprite, "modulate", Color(2.4, 2.4, 2.4), 0.16)
	if rim_mat:
		tw.parallel().tween_property(rim_mat, "emission_energy_multiplier", 2.2, 0.16)
		
	# Lands firmly back on board
	tw.tween_property(self, "position:y", home_y, 0.20).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	if sprite.visible:
		tw.parallel().tween_property(sprite, "modulate", Color(1.0, 1.0, 1.0), 0.20)
	if rim_mat:
		tw.parallel().tween_property(rim_mat, "emission_energy_multiplier", 0.8, 0.20)
		
	tw.tween_callback(func():
		is_animating_action = false
		play_animation("idle")
		_apply_pedestal_materials()
	)

# 3D Damage Flinch: Figurine rocks back and flashes
func perform_3d_hurt() -> void:
	play_animation("hurt")
	var home_pos = position
	var tw = create_tween()
	if sprite.visible:
		tw.tween_property(sprite, "modulate", Color(3.0, 0.5, 0.5), 0.08)
	tw.parallel().tween_property(pedestal, "rotation:x", 0.18, 0.08)
	tw.parallel().tween_property(self, "position", home_pos + Vector3(0, 0.10, 0.12), 0.08)
	
	if sprite.visible:
		tw.tween_property(sprite, "modulate", Color(1.0, 1.0, 1.0), 0.12)
	tw.parallel().tween_property(pedestal, "rotation:x", 0.0, 0.12)
	tw.parallel().tween_property(self, "position", home_pos, 0.12)
	tw.tween_callback(func():
		play_animation("idle")
	)

# 3D Dissolve Death: Figurine shrinks into acrylic pedestal and vanishes
func perform_3d_death() -> void:
	is_animating_action = true
	play_animation("hurt")
	if ui_bar_3d:
		ui_bar_3d.visible = false
	var tw = create_tween()
	tw.tween_property(self, "scale", Vector3(0.08, 0.08, 0.08), 0.35).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
	if sprite.visible:
		tw.parallel().tween_property(sprite, "modulate:a", 0.0, 0.35)
	if crystal_mat:
		tw.parallel().tween_property(crystal_mat, "albedo_color:a", 0.0, 0.35)
	tw.tween_callback(queue_free)
