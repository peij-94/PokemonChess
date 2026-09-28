class_name ClickRing
extends Node2D

var ring_radius: float = 0.0
var ring_width: float = 2.0
var ring_color: Color = Color(1.0, 1.0, 1.0, 0.0)
var current_tween: Tween = null

func _draw() -> void:
	if ring_radius > 0.5 and ring_color.a > 0.01:
		var halo_col = Color(ring_color.r, ring_color.g, ring_color.b, ring_color.a * 0.35)
		draw_arc(Vector2.ZERO, ring_radius, 0, TAU, 40, halo_col, ring_width * 2.2, true)
		draw_arc(Vector2.ZERO, ring_radius, 0, TAU, 40, ring_color, ring_width, true)

func play_ripple(col: Color) -> void:
	if current_tween and current_tween.is_valid():
		current_tween.kill()
		
	ring_color = col
	current_tween = create_tween()
	current_tween.tween_method(_animate_step, 0.0, 1.0, 0.35).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	current_tween.tween_callback(func():
		ring_radius = 0.0
		queue_redraw()
	)

func _animate_step(progress: float) -> void:
	ring_radius = lerp(8.0, 48.0, progress)
	ring_width = lerp(3.6, 0.8, progress)
	ring_color.a = lerp(0.95, 0.0, progress * progress)
	queue_redraw()
