extends Node2D

const FloatingTextPool = preload("res://scripts/floating_text_pool.gd")

@onready var label: Label = $Label
var is_pooled: bool = false
var _active_tween: Tween = null

func setup(text: String, color: Color, is_crit: bool = false, custom_scale: float = -1.0) -> void:
	if not is_node_ready():
		await ready
	label.text = text
	label.modulate = color
	modulate.a = 1.0
	
	if _active_tween != null and _active_tween.is_valid():
		_active_tween.kill()
	
	# Determine category of floating text
	var is_numeric = text.is_valid_int() or text.is_valid_float() or (text.begins_with("+") and text.substr(1).is_valid_int())
	var is_combo_text = "连击" in text
	var is_dodge_text = "闪避" in text
	
	# Default multipliers:
	# Damage numbers shrunk by 70% -> 0.3x
	# Combo text shrunk to 40% of original -> 0.4x
	# Dodge text -> 0.7x
	var default_mult: float = 1.0
	if is_numeric:
		default_mult = 0.3
	elif is_combo_text:
		default_mult = 0.4
	elif is_dodge_text:
		default_mult = 0.7
		
	var scale_mult: float = custom_scale if custom_scale > 0.0 else default_mult
	
	if is_crit:
		scale = Vector2(1.5, 1.5) * scale_mult
	else:
		scale = Vector2(1.0, 1.0) * scale_mult
		
	# Determine drift trajectory and distance
	var upward_dist = -45.0
	var horizontal_dist = randf_range(-10, 10)
	if is_numeric:
		upward_dist = -26.0
	elif is_combo_text:
		upward_dist = -28.0
	elif is_dodge_text:
		upward_dist = -32.0
		horizontal_dist = randf_range(12, 22) * (-1.0 if randf() > 0.5 else 1.0)
		
	_active_tween = create_tween().set_parallel(true)
	var target_pos = position + Vector2(horizontal_dist, upward_dist)
	_active_tween.tween_property(self, "position", target_pos, 0.75).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	# Fade out
	_active_tween.tween_property(self, "modulate:a", 0.0, 0.75).set_delay(0.2)
	# Scale punch (more dramatic on crit)
	var punch_ratio = 1.35 if is_crit else 1.2
	_active_tween.tween_property(self, "scale", scale * punch_ratio, 0.18).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	
	if is_pooled:
		_active_tween.chain().tween_callback(_on_finish_pooled)
	else:
		_active_tween.chain().tween_callback(queue_free)

func _on_finish_pooled() -> void:
	visible = false
	FloatingTextPool.recycle(self)

