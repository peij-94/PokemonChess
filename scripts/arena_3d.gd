extends Node3D
class_name Arena3D

# Arena3D: 3D Auto-Chess Battlefield
# Manages 3D camera perspective, 3D arena stadium, 3D grid tiles, 3D bench slots,
# 3D lighting with shadows, and provides 2D-to-3D screen raycasting.

const COLS = 8
const ROWS = 6
const CELL_SIZE_3D = 1.6
const BENCH_Z = 5.8
const BENCH_SPACING_3D = 1.5

@onready var camera: Camera3D = $Camera3D
@onready var dir_light: DirectionalLight3D = $DirectionalLight3D
@onready var tiles_node: Node3D = $Tiles
@onready var bench_node: Node3D = $Bench
@onready var units_container: Node3D = $UnitsContainer
@onready var vfx_container: Node3D = $VFXContainer
@onready var selector_3d: MeshInstance3D = $Selector3D

var tile_meshes: Dictionary = {} # Vector2i -> MeshInstance3D
var bench_meshes: Array = [] # idx -> MeshInstance3D

func _ready() -> void:
	GameManager.set_meta("arena_3d", self)
	build_arena_tiles()
	build_bench_slots()
	if selector_3d:
		selector_3d.visible = false
	if not GameManager.background_changed.is_connected(_on_background_changed):
		GameManager.background_changed.connect(_on_background_changed)
	if GameManager.current_background_path != "":
		update_theme(GameManager.current_background_path)

func _on_background_changed(bg_path: String, _arena_info: Dictionary = {}) -> void:
	update_theme(bg_path)

func update_theme(bg_path: String) -> void:
	if not ResourceLoader.exists(bg_path):
		return
	var tex = load(bg_path)
	if tex and has_node("StadiumFloor"):
		var floor_mesh: MeshInstance3D = get_node("StadiumFloor")
		var mat = floor_mesh.get_active_material(0)
		if mat is StandardMaterial3D:
			mat.albedo_texture = tex
	if dir_light:
		if "volcano" in bg_path:
			dir_light.light_color = Color(1.0, 0.85, 0.75)
		elif "glacier" in bg_path:
			dir_light.light_color = Color(0.85, 0.95, 1.0)
		elif "emerald" in bg_path:
			dir_light.light_color = Color(0.9, 1.0, 0.9)
		elif "astral" in bg_path:
			dir_light.light_color = Color(0.95, 0.85, 1.0)
		else:
			dir_light.light_color = Color(1.0, 0.96, 0.9)

# Converts grid coordinate (0..7, 0..5) to 3D world position
func grid_to_world_3d(coord: Vector2i) -> Vector3:
	var x = (float(coord.x) - 3.5) * CELL_SIZE_3D
	var z = (float(coord.y) - 2.5) * CELL_SIZE_3D
	return Vector3(x, 0.0, z)

# Converts 3D world position to grid coordinate
func world_3d_to_grid(pos: Vector3) -> Vector2i:
	var col = round((pos.x / CELL_SIZE_3D) + 3.5)
	var row = round((pos.z / CELL_SIZE_3D) + 2.5)
	if col >= 0 and col < COLS and row >= 0 and row < ROWS:
		return Vector2i(int(col), int(row))
	return Vector2i(-1, -1)

# Converts bench slot index (0..7) to 3D world position
func bench_to_world_3d(slot_idx: int) -> Vector3:
	var x = (float(slot_idx) - 3.5) * BENCH_SPACING_3D
	return Vector3(x, 0.0, BENCH_Z)

# Converts 3D world position to bench slot index
func world_3d_to_bench(pos: Vector3) -> int:
	if abs(pos.z - BENCH_Z) > 1.2:
		return -1
	var slot = round((pos.x / BENCH_SPACING_3D) + 3.5)
	if slot >= 0 and slot < 8:
		return int(slot)
	return -1

# Direct mapping from 2D board screen coordinates to 3D world coordinates
func pos_2d_to_3d(pos_2d: Vector2, on_bench: bool = false) -> Vector3:
	var x_3d = (pos_2d.x - 640.0) * 0.025
	if on_bench and pos_2d.y >= 440.0:
		return Vector3(x_3d, 0.0, BENCH_Z)
	var z_3d = (pos_2d.y - 272.0) * 0.025
	return Vector3(x_3d, 0.0, z_3d)

# Projects 2D screen coordinates (e.g. mouse position) onto 3D ground plane (y=0)
func screen_to_ground_3d(screen_pos: Vector2) -> Vector3:
	if camera == null:
		return Vector3.ZERO
	var from = camera.project_ray_origin(screen_pos)
	var dir = camera.project_ray_normal(screen_pos)
	if abs(dir.y) < 0.0001:
		return Vector3.ZERO
	var t = -from.y / dir.y
	return from + dir * t

# Highlights a 3D grid tile
func highlight_tile(coord: Vector2i, color: Color = Color(1.0, 0.9, 0.3, 0.7)) -> void:
	if selector_3d == null:
		return
	if coord == Vector2i(-1, -1):
		selector_3d.visible = false
	else:
		selector_3d.position = grid_to_world_3d(coord) + Vector3(0, 0.02, 0)
		var mat = selector_3d.get_surface_override_material(0) as StandardMaterial3D
		if mat:
			mat.albedo_color = color
		selector_3d.visible = true

# Highlights a 3D bench slot
func highlight_bench(slot_idx: int, color: Color = Color(1.0, 0.9, 0.3, 0.7)) -> void:
	if selector_3d == null:
		return
	if slot_idx < 0 or slot_idx >= 8:
		selector_3d.visible = false
	else:
		selector_3d.position = bench_to_world_3d(slot_idx) + Vector3(0, 0.02, 0)
		var mat = selector_3d.get_surface_override_material(0) as StandardMaterial3D
		if mat:
			mat.albedo_color = color
		selector_3d.visible = true

func build_arena_tiles() -> void:
	for c in range(COLS):
		for r in range(ROWS):
			var tile = MeshInstance3D.new()
			var plane = BoxMesh.new()
			plane.size = Vector3(CELL_SIZE_3D * 0.94, 0.04, CELL_SIZE_3D * 0.94)
			tile.mesh = plane
			
			var mat = StandardMaterial3D.new()
			mat.roughness = 0.65
			mat.metallic = 0.1
			# Top 3 rows are enemy side (crimson tint), bottom 3 are player side (cyan/amber tint)
			if r < 3:
				var is_dark = ((c + r) % 2 == 0)
				mat.albedo_color = Color(0.38, 0.18, 0.22, 1.0) if is_dark else Color(0.48, 0.22, 0.26, 1.0)
			else:
				var is_dark = ((c + r) % 2 == 0)
				mat.albedo_color = Color(0.18, 0.30, 0.42, 1.0) if is_dark else Color(0.24, 0.38, 0.52, 1.0)
			
			tile.set_surface_override_material(0, mat)
			tile.position = grid_to_world_3d(Vector2i(c, r)) - Vector3(0, 0.02, 0)
			tiles_node.add_child(tile)
			tile_meshes[Vector2i(c, r)] = tile

func build_bench_slots() -> void:
	for i in range(8):
		var slot = MeshInstance3D.new()
		var cylinder = CylinderMesh.new()
		cylinder.top_radius = 0.65
		cylinder.bottom_radius = 0.70
		cylinder.height = 0.06
		slot.mesh = cylinder
		
		var mat = StandardMaterial3D.new()
		mat.albedo_color = Color(0.22, 0.40, 0.55, 0.85)
		mat.roughness = 0.5
		mat.emission_enabled = true
		mat.emission = Color(0.1, 0.25, 0.4)
		mat.emission_energy_multiplier = 0.4
		slot.set_surface_override_material(0, mat)
		
		slot.position = bench_to_world_3d(i)
		bench_node.add_child(slot)
		bench_meshes.append(slot)
