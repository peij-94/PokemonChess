extends Node2D
class_name StunVFX

# Animated 3D-orbiting Dizzy Stars (💫) effect for stunned units
# Features 3 golden stars orbiting in a tilted ellipse above the character's head,
# complete with depth-sorted scaling, brightness, sparkle trail particles, and smooth transitions.

var is_active: bool = false
var orbit_angle: float = 0.0
var orbit_speed: float = 6.28 # ~1 rotation per second
var radius_x: float = 18.0
var radius_y: float = 6.5
var current_scale: float = 0.0
var star_pulse: float = 0.0

# Star colors
const COLOR_CORE = Color(1.0, 1.0, 0.85, 1.0) # Bright gleaming center
const COLOR_GOLD = Color(1.0, 0.85, 0.15, 1.0) # Rich Pokemon golden-yellow
const COLOR_AMBER = Color(1.0, 0.65, 0.05, 0.8) # Warm outer glow
const COLOR_RING = Color(1.0, 0.9, 0.4, 0.25) # Faint dizzy orbit guide ring

func _ready() -> void:
	z_index = 25
	visible = false
	scale = Vector2.ZERO

func _process(delta: float) -> void:
	if not is_active and scale.x <= 0.01:
		visible = false
		return
		
	orbit_angle += orbit_speed * delta
	if orbit_angle >= TAU:
		orbit_angle -= TAU
		
	star_pulse += delta * 12.0
	queue_redraw()

func start_stun() -> void:
	is_active = true
	visible = true
	var tw = create_tween()
	tw.tween_property(self, "scale", Vector2(1.2, 1.2), 0.15).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tw.tween_property(self, "scale", Vector2(1.0, 1.0), 0.1)

func stop_stun() -> void:
	is_active = false
	var tw = create_tween()
	tw.tween_property(self, "scale", Vector2.ZERO, 0.2).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	tw.tween_callback(func():
		if not is_active:
			visible = false
	)

func stop_immediate() -> void:
	is_active = false
	visible = false
	scale = Vector2.ZERO

func _draw() -> void:
	if scale.x <= 0.01:
		return
		
	# 1. Draw subtle tilted dizzy orbit ring
	draw_arc(Vector2.ZERO, radius_x, 0.0, TAU, 32, COLOR_RING, 1.2, true)
	
	# 2. Compute 3 stars at 120-degree angular intervals
	var stars: Array = []
	for i in range(3):
		var ang = orbit_angle + i * (TAU / 3.0)
		var sx = cos(ang) * radius_x
		# Tilt orbit slightly (15 degrees)
		var sy = sin(ang) * radius_y + (sx * 0.15)
		var depth_factor = sin(ang) # -1 (back) to +1 (front)
		stars.append({
			"pos": Vector2(sx, sy),
			"depth": depth_factor,
			"index": i
		})
		
	# Sort back-to-front for proper depth layering
	stars.sort_custom(func(a, b): return a["depth"] < b["depth"])
	
	for s in stars:
		var pos: Vector2 = s["pos"]
		var depth: float = s["depth"] # -1.0 to 1.0
		# Depth scaling: 0.75x in back, 1.25x in front
		var d_scale = lerp(0.75, 1.25, (depth + 1.0) * 0.5)
		var d_alpha = lerp(0.65, 1.0, (depth + 1.0) * 0.5)
		
		# Individual star spin
		var star_rot = orbit_angle * 2.0 + s["index"] * 2.0
		
		# Draw trailing sparkle micro-dots behind each star (dizzy whoosh trail 💫)
		for t in range(1, 3):
			var trail_ang = (orbit_angle - t * 0.22) + s["index"] * (TAU / 3.0)
			var tx = cos(trail_ang) * radius_x
			var ty = sin(trail_ang) * radius_y + (tx * 0.15)
			var t_alpha = d_alpha * (0.6 - t * 0.22)
			var t_col = Color(COLOR_GOLD.r, COLOR_GOLD.g, COLOR_GOLD.b, t_alpha)
			draw_circle(Vector2(tx, ty), 1.8 * d_scale * (1.0 - t * 0.25), t_col)
			
		_draw_sharp_star(pos, 5.0 * d_scale, star_rot, d_alpha)

# Helper to draw a cartoon 4-pointed radiant star with glowing aura
func _draw_sharp_star(center: Vector2, size: float, rot: float, alpha_mult: float) -> void:
	var cos_r = cos(rot)
	var sin_r = sin(rot)
	
	# Outer amber glow
	var glow_col = Color(COLOR_AMBER.r, COLOR_AMBER.g, COLOR_AMBER.b, COLOR_AMBER.a * alpha_mult)
	draw_circle(center, size * 1.5, glow_col)
	
	# 4-point sharp star polygon
	var pts: PackedVector2Array = PackedVector2Array()
	var num_points = 8
	for i in range(num_points):
		var a = rot + i * (TAU / num_points)
		var r = size if (i % 2 == 0) else (size * 0.32)
		pts.append(center + Vector2(cos(a) * r, sin(a) * r))
		
	var gold_col = Color(COLOR_GOLD.r, COLOR_GOLD.g, COLOR_GOLD.b, alpha_mult)
	draw_colored_polygon(pts, gold_col)
	
	# Crisp bright white core diamond
	var core_col = Color(COLOR_CORE.r, COLOR_CORE.g, COLOR_CORE.b, alpha_mult)
	var core_pts: PackedVector2Array = PackedVector2Array()
	for i in range(4):
		var a = rot + i * (TAU / 4.0)
		core_pts.append(center + Vector2(cos(a) * (size * 0.45), sin(a) * (size * 0.45)))
	draw_colored_polygon(core_pts, core_col)
