extends Node
class_name ElementalHexSystem

## ElementalHexSystem
## Manages 2D Elemental Hex Nodes (Fire, Water, Rock, Wind)
## Handles round-by-round procedural generation, combat buffs, micro-auras, and visual inspection tags.

signal hexes_generated(hex_dict: Dictionary)
signal hex_buff_activated(unit: Unit, hex_type: String, coord: Vector2i)
signal hex_buffs_cleared()

const HEX_TYPES: Dictionary = {
	"fire": {
		"id": "fire",
		"name": "炽热地核",
		"symbol": "🔥",
		"color": Color(1.0, 0.48, 0.12), # 烈焰金橙
		"glow_color": Color(1.0, 0.35, 0.05, 0.45),
		"desc": "驻守单位攻击附带 25% 真实伤害灼烧",
		"badge": "🔥 炽热地核 (+25%真伤灼烧)",
		"icon_path": "res://assets/ui/type_fire.png",
		"sfx": "fire"
	},
	"water": {
		"id": "water",
		"name": "宁静泉眼",
		"symbol": "💧",
		"color": Color(0.22, 0.68, 1.0), # 碧蓝泉涌
		"glow_color": Color(0.15, 0.5, 0.95, 0.45),
		"desc": "驻守单位每秒额外回复 6 点法力值",
		"badge": "💧 宁静泉眼 (+6/s回蓝)",
		"icon_path": "res://assets/ui/type_water.png",
		"sfx": "water"
	},
	"rock": {
		"id": "rock",
		"name": "坚毅磐石",
		"symbol": "🪨",
		"color": Color(0.85, 0.62, 0.22), # 琥珀坚石
		"glow_color": Color(0.75, 0.52, 0.15, 0.45),
		"desc": "驻守单位开局获得 30% 最大生命护盾，免疫击退",
		"badge": "🪨 坚毅磐石 (+30%护盾·免退)",
		"icon_path": "res://assets/ui/type_rock.png",
		"sfx": "attack"
	},
	"wind": {
		"id": "wind",
		"name": "疾风跃迁",
		"symbol": "🌪️",
		"color": Color(0.22, 0.85, 0.52), # 翡翠疾风
		"glow_color": Color(0.15, 0.75, 0.42, 0.45),
		"desc": "驻守单位攻速 +35%，拥有 15% 物理闪避",
		"badge": "🌪️ 疾风跃迁 (+35%攻速·15%闪避)",
		"icon_path": "res://assets/ui/type_flying.png",
		"sfx": "swift"
	}
}

const ELEMENT_KEYS: Array[String] = ["fire", "water", "rock", "wind"]

# Active round hexes mapping: Vector2i(col, row) -> "fire" | "water" | "rock" | "wind"
var active_hexes: Dictionary = {}

# Units that have activated hex buffs this combat
var buffed_units: Array[WeakRef] = []

func _ready() -> void:
	pass

## Generates random elemental hexes for both enemy and player sides of the board.
## By default: Enemy y in [0, 3], Player y in [4, 7], x in [0, 7].
## count: 2~3 distinct coordinates per side.
func generate_round_hexes(
	count: int = 3,
	player_y_range: Vector2i = Vector2i(4, 7),
	enemy_y_range: Vector2i = Vector2i(0, 3),
	x_range: Vector2i = Vector2i(0, 7)
) -> Dictionary:
	active_hexes.clear()
	count = clampi(count, 2, 8)
	
	# 1. Pick distinct coordinates for Enemy board half
	var enemy_candidates: Array[Vector2i] = []
	for x in range(x_range.x, x_range.y + 1):
		for y in range(enemy_y_range.x, enemy_y_range.y + 1):
			enemy_candidates.append(Vector2i(x, y))
	enemy_candidates.shuffle()
	
	var actual_enemy_count = mini(count, enemy_candidates.size())
	for i in range(actual_enemy_count):
		var coord = enemy_candidates[i]
		var elem = ELEMENT_KEYS[randi() % ELEMENT_KEYS.size()]
		active_hexes[coord] = elem
		
	# 2. Pick distinct coordinates for Player board half
	var player_candidates: Array[Vector2i] = []
	for x in range(x_range.x, x_range.y + 1):
		for y in range(player_y_range.x, player_y_range.y + 1):
			player_candidates.append(Vector2i(x, y))
	player_candidates.shuffle()
	
	var actual_player_count = mini(count, player_candidates.size())
	for i in range(actual_player_count):
		var coord = player_candidates[i]
		var elem = ELEMENT_KEYS[randi() % ELEMENT_KEYS.size()]
		active_hexes[coord] = elem
		
	hexes_generated.emit(active_hexes)
	return active_hexes

func set_hex(coord: Vector2i, hex_type: String) -> void:
	if HEX_TYPES.has(hex_type):
		active_hexes[coord] = hex_type
	else:
		push_warning("Unknown hex type: %s" % hex_type)

func get_hex_type(coord: Vector2i) -> String:
	return active_hexes.get(coord, "")

func has_hex(coord: Vector2i) -> bool:
	return active_hexes.has(coord)

func get_hex_info(hex_type: String) -> Dictionary:
	return HEX_TYPES.get(hex_type, {})

func get_hex_info_at(coord: Vector2i) -> Dictionary:
	var h_type = get_hex_type(coord)
	return get_hex_info(h_type)

func clear_hexes() -> void:
	active_hexes.clear()

func is_valid_player_coord(coord: Vector2i, y_range: Vector2i = Vector2i(4, 7), x_range: Vector2i = Vector2i(0, 7)) -> bool:
	return coord.x >= x_range.x and coord.x <= x_range.y and coord.y >= y_range.x and coord.y <= y_range.y

func is_valid_enemy_coord(coord: Vector2i, y_range: Vector2i = Vector2i(0, 3), x_range: Vector2i = Vector2i(0, 7)) -> bool:
	return coord.x >= x_range.x and coord.x <= x_range.y and coord.y >= y_range.x and coord.y <= y_range.y

## Evaluates all board units at combat start.
## If standing on an elemental hex, grants corresponding buff & micro-aura.
func evaluate_combat_units(units: Array) -> void:
	for node in units:
		var u = node as Unit
		if u != null and is_instance_valid(u) and not u.is_dead and not u.is_on_bench:
			if has_hex(u.grid_coord):
				var h_type = get_hex_type(u.grid_coord)
				activate_hex_buff_for_unit(u, h_type)

## Real-time buff activation on a specific unit
func activate_hex_buff_for_unit(unit: Unit, hex_type: String) -> void:
	if unit == null or not is_instance_valid(unit) or not HEX_TYPES.has(hex_type):
		return
		
	var info = get_hex_info(hex_type)
	unit.set_meta("elemental_hex", hex_type)
	buffed_units.append(weakref(unit))
	
	# Apply element-specific buffs
	match hex_type:
		"fire":
			# 炽热地核：驻守单位攻击附带 25% 真实伤害灼烧
			unit.set_meta("hex_fire_burn", true)
			unit.set_meta("hex_fire_burn_ratio", 0.25)
		"water":
			# 宁静泉眼：驻守单位每秒额外回复 6 点法力值
			unit.set_meta("hex_water_mana", true)
			unit.set_meta("hex_water_mana_per_sec", 6.0)
		"rock":
			# 坚毅磐石：驻守单位开局获得 30% 最大生命护盾，免疫击退
			unit.set_meta("hex_rock_shield", true)
			unit.set_meta("hex_rock_immune_knockback", true)
			unit.is_immune_to_knockback = true
			var shield_amount = unit.max_hp * 0.30
			unit.shield += shield_amount
			unit.update_bars()
		"wind":
			# 疾风跃迁：驻守单位攻速 +35%，拥有 15% 物理闪避
			unit.set_meta("hex_wind_active", true)
			unit.set_meta("hex_wind_dodge_bonus", 0.15)
			var as_bonus = unit.atk_speed * 0.35
			unit.set_meta("hex_wind_as_bonus", as_bonus)
			unit.atk_speed += as_bonus

	# Visual: spawn micro-aura at unit's feet
	_attach_unit_aura(unit, info.color)
	
	# Audio & floating text
	if unit.has_method("spawn_floating_text"):
		unit.spawn_floating_text(info.name + " 激活!", info.color, true)
	if AudioManager:
		AudioManager.play_sfx(info.get("sfx", "attack"))
		
	hex_buff_activated.emit(unit, hex_type, unit.grid_coord)

func _attach_unit_aura(unit: Unit, color: Color) -> void:
	var existing = unit.get_node_or_null("HexUnitAura")
	if existing:
		existing.queue_free()
		
	var aura = HexUnitAuraNode.new()
	aura.name = "HexUnitAura"
	aura.setup(color)
	unit.add_child(aura)

## Clears hex buffs from a single unit
func clear_unit_hex_buff(unit: Unit) -> void:
	if unit == null or not is_instance_valid(unit):
		return
		
	if unit.has_meta("elemental_hex"):
		unit.remove_meta("elemental_hex")
	if unit.has_meta("hex_fire_burn"):
		unit.remove_meta("hex_fire_burn")
	if unit.has_meta("hex_fire_burn_ratio"):
		unit.remove_meta("hex_fire_burn_ratio")
	if unit.has_meta("hex_water_mana"):
		unit.remove_meta("hex_water_mana")
	if unit.has_meta("hex_water_mana_per_sec"):
		unit.remove_meta("hex_water_mana_per_sec")
	if unit.has_meta("hex_rock_shield"):
		unit.remove_meta("hex_rock_shield")
	if unit.has_meta("hex_rock_immune_knockback"):
		unit.remove_meta("hex_rock_immune_knockback")
	if unit.has_meta("hex_wind_active"):
		unit.remove_meta("hex_wind_active")
	if unit.has_meta("hex_wind_dodge_bonus"):
		unit.remove_meta("hex_wind_dodge_bonus")
	if unit.has_meta("hex_wind_as_bonus"):
		unit.atk_speed = max(0.4, unit.atk_speed - unit.get_meta("hex_wind_as_bonus"))
		unit.remove_meta("hex_wind_as_bonus")
		
	unit.is_immune_to_knockback = false
	unit.burn_is_true = false
	
	var aura = unit.get_node_or_null("HexUnitAura")
	if aura:
		aura.queue_free()

## Cleans up all units buffed by elemental hexes (called on round reset)
func clear_all_unit_hex_buffs() -> void:
	for uref in buffed_units:
		var u = uref.get_ref() as Unit
		if u != null and is_instance_valid(u):
			clear_unit_hex_buff(u)
	buffed_units.clear()
	hex_buffs_cleared.emit()

# Inner Class: HexUnitAuraNode (2D Micro-aura attached to unit feet)
class HexUnitAuraNode extends Node2D:
	var aura_color: Color = Color.WHITE
	var breath_time: float = 0.0

	func setup(color: Color) -> void:
		aura_color = color
		z_index = -1
		position = Vector2(0, 16)
		
		# Micro 2D CPU particles
		var p = CPUParticles2D.new()
		p.name = "AuraParticles"
		p.amount = 4
		p.lifetime = 1.0
		p.emission_shape = CPUParticles2D.EMISSION_SHAPE_SPHERE
		p.emission_sphere_radius = 12.0
		p.gravity = Vector2(0, -14.0)
		p.initial_velocity_min = 3.0
		p.initial_velocity_max = 8.0
		p.scale_amount_min = 1.4
		p.scale_amount_max = 2.2
		p.color = color
		add_child(p)
		queue_redraw()

	func _process(delta: float) -> void:
		breath_time += delta * 2.5
		var s = 1.0 + sin(breath_time) * 0.08
		scale = Vector2(s, s)
		modulate.a = 0.85 + sin(breath_time * 1.5) * 0.15

	func _draw() -> void:
		# Subtle base glowing ground disc
		draw_circle(Vector2.ZERO, 15.0, Color(aura_color.r, aura_color.g, aura_color.b, 0.25))
		draw_arc(Vector2.ZERO, 15.0, 0, TAU, 24, Color(aura_color.r, aura_color.g, aura_color.b, 0.8), 1.5)
