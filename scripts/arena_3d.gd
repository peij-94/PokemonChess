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
	# Gold bevel material shared across tiles
	var gold_bevel_mat = StandardMaterial3D.new()
	gold_bevel_mat.albedo_color = Color(0.76, 0.64, 0.38, 1.0)
	gold_bevel_mat.metallic = 0.88
	gold_bevel_mat.roughness = 0.26
	gold_bevel_mat.clearcoat_enabled = true
	gold_bevel_mat.clearcoat = 0.5
	
	for c in range(COLS):
		for r in range(ROWS):
			var tile_group = Node3D.new()
			tile_group.position = grid_to_world_3d(Vector2i(c, r))
			
			# Outer metallic gold chamfer inlay
			var border_mesh = MeshInstance3D.new()
			var border_box = BoxMesh.new()
			border_box.size = Vector3(CELL_SIZE_3D * 0.96, 0.02, CELL_SIZE_3D * 0.96)
			border_mesh.mesh = border_box
			border_mesh.position = Vector3(0, -0.015, 0)
			border_mesh.set_surface_override_material(0, gold_bevel_mat)
			tile_group.add_child(border_mesh)
			
			# Inner polished tabletop stone / wood slab
			var slab_mesh = MeshInstance3D.new()
			var slab_box = BoxMesh.new()
			slab_box.size = Vector3(CELL_SIZE_3D * 0.92, 0.035, CELL_SIZE_3D * 0.92)
			slab_mesh.mesh = slab_box
			slab_mesh.position = Vector3(0, -0.005, 0)
			
			var mat = StandardMaterial3D.new()
			mat.roughness = 0.24
			mat.metallic = 0.12
			mat.clearcoat_enabled = true
			mat.clearcoat = 0.65
			mat.clearcoat_roughness = 0.15
			
			# Top 3 rows: Enemy mahogany/crimson slate. Bottom 3 rows: Player obsidian/cobalt slate
			var is_dark = ((c + r) % 2 == 0)
			if r < 3:
				mat.albedo_color = Color(0.25, 0.08, 0.12, 1.0) if is_dark else Color(0.35, 0.13, 0.18, 1.0)
			else:
				mat.albedo_color = Color(0.10, 0.16, 0.28, 1.0) if is_dark else Color(0.16, 0.25, 0.40, 1.0)
			
			slab_mesh.set_surface_override_material(0, mat)
			tile_group.add_child(slab_mesh)
			
			tiles_node.add_child(tile_group)
			tile_meshes[Vector2i(c, r)] = slab_mesh

func build_bench_slots() -> void:
	for i in range(8):
		var slot_group = Node3D.new()
		slot_group.position = bench_to_world_3d(i)
		
		# Acrylic dock socket
		var dock_mesh = MeshInstance3D.new()
		var cylinder = CylinderMesh.new()
		cylinder.top_radius = 0.66
		cylinder.bottom_radius = 0.70
		cylinder.height = 0.04
		cylinder.radial_segments = 36
		dock_mesh.mesh = cylinder
		dock_mesh.position = Vector3(0, 0.015, 0)
		
		var mat = StandardMaterial3D.new()
		mat.albedo_color = Color(0.12, 0.22, 0.36, 0.92)
		mat.roughness = 0.18
		mat.metallic = 0.15
		mat.clearcoat_enabled = true
		mat.clearcoat = 0.75
		mat.emission_enabled = true
		mat.emission = Color(0.12, 0.32, 0.58)
		mat.emission_energy_multiplier = 0.45
		dock_mesh.set_surface_override_material(0, mat)
		slot_group.add_child(dock_mesh)
		
		# Gold metallic socket rim
		var rim_mesh = MeshInstance3D.new()
		var torus = TorusMesh.new()
		torus.inner_radius = 0.64
		torus.outer_radius = 0.71
		torus.rings = 36
		rim_mesh.mesh = torus
		rim_mesh.position = Vector3(0, 0.03, 0)
		
		var rim_mat = StandardMaterial3D.new()
		rim_mat.albedo_color = Color(0.96, 0.84, 0.38, 1.0)
		rim_mat.metallic = 0.90
		rim_mat.roughness = 0.20
		rim_mat.clearcoat_enabled = true
		rim_mat.clearcoat = 0.6
		rim_mesh.set_surface_override_material(0, rim_mat)
		slot_group.add_child(rim_mesh)
		
		bench_node.add_child(slot_group)
		bench_meshes.append(dock_mesh)
