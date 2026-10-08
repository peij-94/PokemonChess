extends Node2D
class_name ElementalHexNode2D

## ElementalHexNode2D
## 2D Classic Pixel Retro & Dream World Elemental Hex Node
## Renders a magical elemental rune aura with smooth micro-breathing animation and element symbol

var coord: Vector2i = Vector2i.ZERO
var hex_type: String = ""
var hex_info: Dictionary = {}

var breath_timer: float = 0.0
var ring_color: Color = Color.WHITE
var glow_color: Color = Color.WHITE

var icon_sprite: Sprite2D = null
var symbol_label: Label = null
var particles: CPUParticles2D = null

func _init() -> void:
	z_index = 1

func setup(p_coord: Vector2i, p_hex_type: String, p_hex_info: Dictionary) -> void:
	coord = p_coord
	hex_type = p_hex_type
	hex_info = p_hex_info
	ring_color = hex_info.get("color", Color(1.0, 0.6, 0.2))
	glow_color = hex_info.get("glow_color", ring_color.darkened(0.2))
	
	_setup_visuals()
	queue_redraw()

func _setup_visuals() -> void:
	# Clean any existing children
	for child in get_children():
		child.queue_free()
		
	# 1. 2D Micro-Particles (rising elemental sparks)
	particles = CPUParticles2D.new()
	particles.name = "HexParticles"
	particles.amount = 6
	particles.lifetime = 1.2
	particles.emission_shape = CPUParticles2D.EMISSION_SHAPE_SPHERE
	particles.emission_sphere_radius = 16.0
	particles.gravity = Vector2(0, -18.0)
	particles.initial_velocity_min = 4.0
	particles.initial_velocity_max = 12.0
	particles.scale_amount_min = 1.8
	particles.scale_amount_max = 2.6
	particles.color = ring_color
	add_child(particles)
	
	# 2. Type Icon Sprite
	var icon_path = hex_info.get("icon_path", "")
	if icon_path != "" and ResourceLoader.exists(icon_path):
		icon_sprite = Sprite2D.new()
		icon_sprite.name = "TypeIcon"
		icon_sprite.texture = load(icon_path)
		icon_sprite.scale = Vector2(0.65, 0.65)
		icon_sprite.modulate = Color(ring_color.r, ring_color.g, ring_color.b, 0.75)
		icon_sprite.position = Vector2(0, -2)
		add_child(icon_sprite)
		
	# 3. Clear Rune Symbol Label
	symbol_label = Label.new()
	symbol_label.name = "SymbolLabel"
	symbol_label.text = hex_info.get("symbol", "")
	symbol_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	symbol_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	symbol_label.position = Vector2(-16, -16)
	symbol_label.size = Vector2(32, 32)
	symbol_label.add_theme_font_size_override("font_size", 14)
	symbol_label.add_theme_color_override("font_color", Color(1.0, 1.0, 1.0, 0.95))
	symbol_label.add_theme_color_override("font_shadow_color", Color(0, 0, 0, 0.8))
	symbol_label.add_theme_constant_override("shadow_offset_x", 1)
	symbol_label.add_theme_constant_override("shadow_offset_y", 1)
	add_child(symbol_label)

func _process(delta: float) -> void:
	breath_timer += delta * 2.2
	# Smooth micro-breathing scale oscillation
	var breath_s = 1.0 + sin(breath_timer) * 0.05
	scale = Vector2(breath_s, breath_s)
	# Smooth brightness/alpha breathing
	var breath_a = 0.82 + sin(breath_timer * 1.3) * 0.18
	modulate.a = breath_a

func _draw() -> void:
	if hex_info.is_empty():
		return
		
	var radius = 25.0
	# 1. Inner soft glowing fill
	var fill_col = Color(ring_color.r, ring_color.g, ring_color.b, 0.22)
	draw_circle(Vector2.ZERO, radius - 4.0, fill_col)
	
	# 2. Central focal glow
	var center_glow = Color(ring_color.r, ring_color.g, ring_color.b, 0.35)
	draw_circle(Vector2.ZERO, 10.0, center_glow)
	
	# 3. Outer Hexagonal Rune Ring
	var points = PackedVector2Array()
	for i in range(6):
		var angle = deg_to_rad(60.0 * i - 30.0)
		points.append(Vector2(cos(angle) * radius, sin(angle) * radius))
	points.append(points[0]) # close loop
	draw_polyline(points, ring_color, 2.0, true)
	
	# 4. Corner runic nodes (6 corner accent dots)
	for i in range(6):
		var angle = deg_to_rad(60.0 * i - 30.0)
		var corner_pt = Vector2(cos(angle) * radius, sin(angle) * radius)
		draw_circle(corner_pt, 2.5, Color(1.0, 1.0, 1.0, 0.9))
		draw_circle(corner_pt, 4.0, Color(ring_color.r, ring_color.g, ring_color.b, 0.5))
		
	# 5. Inner circular runic ring
	draw_arc(Vector2.ZERO, radius * 0.65, 0, TAU, 24, Color(ring_color.r, ring_color.g, ring_color.b, 0.45), 1.0)
