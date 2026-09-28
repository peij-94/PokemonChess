extends Node3D
class_name Unit3D

# Unit3D: 3D Character representation for Pokemon Auto-Chess
# Features:
# - AnimatedSprite3D with authentic sprite animations (idle, walk, attack, hurt)
# - Y-Billboard mode with 3D shadow casting onto the arena floor
# - 3D dynamic combat animations: 3D jump leaps, attack lunges, hit flinches, death dissolves
# - 3D floating status bar (HP bar, Mana bar, Name, Star badges)
# - 3D cast particles & elemental auras

@onready var sprite: AnimatedSprite3D = $Sprite
@onready var shadow_mesh: MeshInstance3D = $Shadow
@onready var cast_particles: CPUParticles3D = $CastParticles
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

# Floating bobbing
var bob_time: float = 0.0
var is_animating_action: bool = false

func _ready() -> void:
	if ui_viewport and ui_bar_3d:
		ui_bar_3d.texture = ui_viewport.get_texture()

func setup_visuals(p_id: String, p_star: int, p_is_enemy: bool, p_name: String) -> void:
	pokemon_id = p_id
	star_level = p_star
	is_enemy = p_is_enemy
	
	name_label.text = p_name
	
	# Load sprite frames from PokemonDatabase
	var sf = PokemonDatabase.get_sprite_frames(pokemon_id)
	sprite.sprite_frames = sf
	sprite.play("idle")
	
	# Adjust 3D size so unit is ~1.2m to 1.5m tall
	var target_height = 1.25 + (star_level - 1) * 0.20
	sprite.pixel_size = 0.016 * (target_height / 1.25)
	
	# Star badges in 3D UI
	for c in star_container.get_children():
		c.queue_free()
	for i in range(star_level):
		var star = TextureRect.new()
		star.texture = load("res://assets/ui/star_badge.png")
		star.custom_minimum_size = Vector2(16, 16)
		star.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		star_container.add_child(star)
		
	if is_enemy:
		hp_bar.modulate = Color(0.95, 0.3, 0.3)
	else:
		hp_bar.modulate = Color(0.3, 0.85, 0.4)
		
	# Subtle random bob phase so units don't breathe in unison
	bob_time = randf() * PI * 2.0

func update_bars(current_hp: float, max_hp: float, current_mana: float, max_mana: float) -> void:
	if hp_bar:
		hp_bar.max_value = max_hp
		hp_bar.value = current_hp
	if mana_bar:
		mana_bar.max_value = max_mana
		mana_bar.value = current_mana

func play_animation(anim_name: String) -> void:
	if sprite.sprite_frames and sprite.sprite_frames.has_animation(anim_name):
		sprite.play(anim_name)

func _process(delta: float) -> void:
	if not is_animating_action:
		bob_time += delta * 2.8
		# Gentle 3D breathing micro-bobbing on Y axis
		sprite.position.y = 0.65 + sin(bob_time) * 0.03

# 3D Physical Attack Leap toward target
func perform_3d_attack_leap(target_world_pos: Vector3, duration: float = 0.22) -> void:
	is_animating_action = true
	play_animation("attack")
	
	var home_pos = position
	var dir = (target_world_pos - home_pos)
	var leap_offset = dir.normalized() * min(dir.length() * 0.38, 0.65)
	
	var tw = create_tween()
	# Leap forward + upward in 3D
	tw.tween_property(self, "position", home_pos + leap_offset + Vector3(0, 0.35, 0), duration * 0.45).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	# Strike down and return
	tw.tween_property(self, "position", home_pos, duration * 0.55).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tw.tween_callback(func():
		is_animating_action = false
		play_animation("idle")
	)

# 3D Skill Cast Glow & Elevation
func perform_3d_skill_cast() -> void:
	is_animating_action = true
	play_animation("attack")
	if cast_particles:
		cast_particles.restart()
		cast_particles.emitting = true
		
	var home_y = position.y
	var tw = create_tween()
	# Elevate in 3D air with glow
	tw.tween_property(self, "position:y", home_y + 0.45, 0.16).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tw.parallel().tween_property(sprite, "modulate", Color(2.5, 2.5, 2.5), 0.16)
	tw.tween_property(self, "position:y", home_y, 0.22).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	tw.parallel().tween_property(sprite, "modulate", Color(1.0, 1.0, 1.0), 0.22)
	tw.tween_callback(func():
		is_animating_action = false
		play_animation("idle")
	)

# 3D Damage Flinch
func perform_3d_hurt() -> void:
	play_animation("hurt")
	var home_pos = position
	var tw = create_tween()
	tw.tween_property(sprite, "modulate", Color(3.0, 0.5, 0.5), 0.08)
	tw.parallel().tween_property(self, "position", home_pos + Vector3(0, 0.12, 0.15), 0.08)
	tw.tween_property(sprite, "modulate", Color(1.0, 1.0, 1.0), 0.12)
	tw.parallel().tween_property(self, "position", home_pos, 0.12)
	tw.tween_callback(func():
		if sprite.animation == "hurt":
			play_animation("idle")
	)

# 3D Dissolve Death
func perform_3d_death() -> void:
	is_animating_action = true
	play_animation("hurt")
	if ui_bar_3d:
		ui_bar_3d.visible = false
	var tw = create_tween()
	tw.tween_property(self, "scale", Vector3(0.1, 0.1, 0.1), 0.35).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
	tw.parallel().tween_property(sprite, "modulate:a", 0.0, 0.35)
	tw.tween_callback(queue_free)
