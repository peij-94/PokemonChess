extends Node2D

# Board: Manages combat grid, bench slots, drag-drop placement, wave enemies, and combat resolution

const UNIT_SCENE = preload("res://scenes/unit.tscn")
const ELEMENTAL_HEX_NODE_SCRIPT = preload("res://scripts/elemental_hex_node.gd")
const ELEMENTAL_HEX_SYSTEM_SCRIPT = preload("res://scripts/elemental_hex_system.gd")

const COLS = 8
const ROWS = 6
const TILE_SIZE = 64.0
const BOARD_ORIGIN = Vector2(384, 80)

const BENCH_SLOTS = 8
const BENCH_ORIGIN = Vector2(356, 480)
const BENCH_SLOT_SIZE = 64.0
const BENCH_SPACING = 8.0

# Node containers
@onready var tiles_container: Node2D = $Tiles
@onready var bench_container: Node2D = $Bench
@onready var units_container: Node2D = $Units
@onready var selector_sprite: Sprite2D = $Selector

# Board state: board_grid[col][row] = Unit or null
var board_grid: Array = []
# Bench state: bench_slots[i] = Unit or null
var bench_slots: Array = []

# Selected unit for moving / swapping
var selected_unit: Unit = null
var dragged_unit: Unit = null
var drag_start_pos: Vector2 = Vector2.ZERO
var is_dragging: bool = false

# Elemental Hex System integration
var hex_system = null
var hexes_container: Node2D = null
var hex_nodes: Dictionary = {} # Vector2i -> Node2D

# Stored layout to reset after combat
var home_positions: Dictionary = {} # unit -> Vector2i(col, row)

func _ready() -> void:
	GameManager.board_ref = self
	init_grid_data()
	build_visual_board()
	build_visual_bench()
	selector_sprite.visible = false
	
	# Initialize 2D Elemental Hexes container and system
	hexes_container = Node2D.new()
	hexes_container.name = "ElementalHexes"
	hexes_container.z_index = 1
	add_child(hexes_container)
	if tiles_container:
		move_child(hexes_container, tiles_container.get_index() + 1)
		
	if get_node_or_null("/root/ElementalHexSystem") != null:
		hex_system = get_node("/root/ElementalHexSystem")
	else:
		hex_system = ELEMENTAL_HEX_SYSTEM_SCRIPT.new()
		add_child(hex_system)
		
	refresh_round_elemental_hexes(3)

func init_grid_data() -> void:
	board_grid.clear()
	for c in range(COLS):
		var col_arr = []
		for r in range(ROWS):
			col_arr.append(null)
		board_grid.append(col_arr)
		
	bench_slots.clear()
	for i in range(BENCH_SLOTS):
		bench_slots.append(null)

func build_visual_board() -> void:
	for c in range(COLS):
		for r in range(ROWS):
			var tile = Sprite2D.new()
			# Top 3 rows are enemy, bottom 3 rows are player
			if r < 3:
				tile.texture = load("res://assets/arena/tile_enemy.png")
			else:
				tile.texture = load("res://assets/arena/tile_player.png")
			tile.position = grid_to_world(Vector2i(c, r))
			tiles_container.add_child(tile)

func build_visual_bench() -> void:
	for i in range(BENCH_SLOTS):
		var slot_tile = Sprite2D.new()
		slot_tile.texture = load("res://assets/arena/tile_player.png")
		slot_tile.modulate = Color(0.7, 0.8, 1.0, 0.7)
		slot_tile.position = bench_to_world(i)
		bench_container.add_child(slot_tile)

func grid_to_world(coord: Vector2i) -> Vector2:
	return BOARD_ORIGIN + Vector2(coord.x * TILE_SIZE + TILE_SIZE/2, coord.y * TILE_SIZE + TILE_SIZE/2)

func world_to_grid(w_pos: Vector2) -> Vector2i:
	var local = w_pos - BOARD_ORIGIN
	var c = int(local.x / TILE_SIZE)
	var r = int(local.y / TILE_SIZE)
	if c >= 0 and c < COLS and r >= 0 and r < ROWS:
		return Vector2i(c, r)
	return Vector2i(-1, -1)

func bench_to_world(slot_idx: int) -> Vector2:
	var step = BENCH_SLOT_SIZE + BENCH_SPACING
	return BENCH_ORIGIN + Vector2(slot_idx * step + BENCH_SLOT_SIZE/2, BENCH_SLOT_SIZE/2)

func world_to_bench(w_pos: Vector2) -> int:
	var step = BENCH_SLOT_SIZE + BENCH_SPACING
	var local = w_pos - BENCH_ORIGIN
	if local.y >= 0 and local.y <= BENCH_SLOT_SIZE:
		var idx = int(local.x / step)
		if idx >= 0 and idx < BENCH_SLOTS:
			var slot_x = idx * step
			if local.x - slot_x <= BENCH_SLOT_SIZE:
				return idx
	return -1

func has_available_bench_slot() -> bool:
	for i in range(BENCH_SLOTS):
		if bench_slots[i] == null:
			return true
	return false

func init_starter_pokemon() -> void:
	# Give the player a starter Pokemon on the board if they have no units
	if count_player_units_on_board() == 0 and not has_any_bench_units():
		add_pokemon_bought("pikachu", 1)

func has_any_bench_units() -> bool:
	for i in range(BENCH_SLOTS):
		if bench_slots[i] != null:
			return true
	return false

func find_first_empty_player_tile() -> Vector2i:
	for r in [4, 3, 5]:
		for c in [3, 4, 2, 5, 1, 6, 0, 7]:
			if board_grid[c][r] == null:
				return Vector2i(c, r)
	return Vector2i(-1, -1)

func add_pokemon_bought(pokemon_id: String, star_level: int = 1, is_shiny: bool = false, affix: String = "") -> Unit:
	# If in prep phase and board has capacity, deploy directly onto board
	if GameManager.current_phase == GameManager.Phase.PREPARATION and count_player_units_on_board() < GameManager.level:
		var target_coord = find_first_empty_player_tile()
		if target_coord != Vector2i(-1, -1):
			var unit = UNIT_SCENE.instantiate() as Unit
			units_container.add_child(unit)
			unit.setup(pokemon_id, star_level, false, is_shiny, affix)
			unit.is_on_bench = false
			unit.grid_coord = target_coord
			unit.position = grid_to_world(target_coord)
			board_grid[target_coord.x][target_coord.y] = unit
			unit.unit_died.connect(_on_unit_died)
			unit.unit_clicked.connect(_on_unit_clicked)
			update_synergies()
			return unit
			
	# Otherwise (including during combat) place on bench
	return add_pokemon_to_bench(pokemon_id, star_level, is_shiny, affix)

func count_owned_pokemon(pid: String, star: int = 1) -> int:
	var count = 0
	for c in range(COLS):
		for r in range(ROWS):
			var u = board_grid[c][r]
			if u != null and not u.is_enemy and u.pokemon_id == pid and u.star_level == star:
				count += 1
	for u in bench_slots:
		if u != null and u.pokemon_id == pid and u.star_level == star:
			count += 1
	return count

func add_pokemon_to_bench(pokemon_id: String, star_level: int = 1, is_shiny: bool = false, affix: String = "") -> Unit:
	var slot_idx = -1
	for i in range(BENCH_SLOTS):
		if bench_slots[i] == null:
			slot_idx = i
			break
	if slot_idx == -1:
		return null
		
	var unit = UNIT_SCENE.instantiate() as Unit
	units_container.add_child(unit)
	unit.setup(pokemon_id, star_level, false, is_shiny, affix)
	unit.is_on_bench = true
	unit.grid_coord = Vector2i(slot_idx, -1)
	unit.position = bench_to_world(slot_idx)
	unit.unit_died.connect(_on_unit_died)
	unit.unit_clicked.connect(_on_unit_clicked)
	
	bench_slots[slot_idx] = unit
	return unit

func spawn_unit_at_coord(pokemon_id: String, coord: Vector2i, star_level: int = 1, is_enemy: bool = false) -> Unit:
	var unit = UNIT_SCENE.instantiate() as Unit
	units_container.add_child(unit)
	unit.setup(pokemon_id, star_level, is_enemy)
	unit.is_on_bench = false
	unit.grid_coord = coord
	unit.position = grid_to_world(coord)
	board_grid[coord.x][coord.y] = unit
	unit.unit_died.connect(_on_unit_died)
	unit.unit_clicked.connect(_on_unit_clicked)
	update_synergies()
	return unit

func clear_all_units() -> void:
	for c in range(COLS):
		for r in range(ROWS):
			if board_grid[c][r] != null and is_instance_valid(board_grid[c][r]):
				board_grid[c][r].queue_free()
				board_grid[c][r] = null
	for b in range(BENCH_SLOTS):
		if bench_slots[b] != null and is_instance_valid(bench_slots[b]):
			bench_slots[b].queue_free()
			bench_slots[b] = null
	update_synergies()

func spawn_training_dummy(dummy_hp: float = 30000.0) -> Unit:
	for c in range(COLS):
		for r in range(3):
			if board_grid[c][r] != null and is_instance_valid(board_grid[c][r]):
				board_grid[c][r].queue_free()
				board_grid[c][r] = null
	var u = spawn_unit_at_coord("snorlax", Vector2i(3, 1), 3, true)
	if u:
		u.max_hp = dummy_hp
		u.current_hp = dummy_hp
		u.atk = 5.0
		u.scale = Vector2(1.4, 1.4)
		if u.name_label:
			u.name_label.text = "🎯 训练木桩"
		u.spawn_floating_text("🎯 试炼靶桩就绪!", Color(0.4, 1.0, 0.6), true)
	return u

func auto_deploy_from_bench() -> void:
	while count_player_units_on_board() < GameManager.level:
		var bench_unit: Unit = null
		var b_slot = -1
		for i in range(BENCH_SLOTS):
			if bench_slots[i] != null and is_instance_valid(bench_slots[i]):
				bench_unit = bench_slots[i]
				b_slot = i
				break
		if bench_unit == null:
			break
			
		var target_coord = find_first_empty_player_tile()
		if target_coord == Vector2i(-1, -1):
			break
			
		bench_slots[b_slot] = null
		bench_unit.is_on_bench = false
		bench_unit.grid_coord = target_coord
		board_grid[target_coord.x][target_coord.y] = bench_unit
		bench_unit.position = grid_to_world(target_coord)
		
	update_synergies()

func quick_toggle_unit(unit: Unit) -> void:
	if GameManager.current_phase != GameManager.Phase.PREPARATION or unit == null or unit.is_enemy:
		return
		
	if unit.is_on_bench:
		if count_player_units_on_board() < GameManager.level:
			var target_coord = find_first_empty_player_tile()
			if target_coord != Vector2i(-1, -1):
				try_place_unit_on_grid(unit, target_coord)
		else:
			unit.spawn_floating_text("人口已满!", Color(1.0, 0.4, 0.4))
	else:
		var free_slot = -1
		for i in range(BENCH_SLOTS):
			if bench_slots[i] == null:
				free_slot = i
				break
		if free_slot != -1:
			try_place_unit_on_bench(unit, free_slot)
		else:
			unit.spawn_floating_text("备战席已满!", Color(1.0, 0.4, 0.4))

func get_board_units(include_enemy: bool = false) -> Array[Unit]:
	var result: Array[Unit] = []
	for c in range(COLS):
		for r in range(ROWS):
			var raw = board_grid[c][r]
			if raw != null and is_instance_valid(raw) and not raw.is_queued_for_deletion():
				var u = raw as Unit
				if u != null and not u.is_dead:
					if include_enemy or not u.is_enemy:
						result.append(u)
	return result

func get_deployed_player_units() -> Array[Unit]:
	var result: Array[Unit] = []
	for c in range(COLS):
		for r in range(ROWS):
			var raw = board_grid[c][r]
			if raw != null and is_instance_valid(raw) and not raw.is_queued_for_deletion():
				var u = raw as Unit
				if u != null and not u.is_enemy:
					result.append(u)
	return result

func count_player_units_on_board() -> int:
	var cnt = 0
	for c in range(COLS):
		for r in range(3, ROWS): # Only player half
			if board_grid[c][r] != null:
				cnt += 1
	return cnt

var is_hovering_sell_zone: bool = false

func is_pos_in_sell_zone(pos: Vector2) -> bool:
	# Bottom shop area: y >= 545.0, x in [200.0, 1270.0]
	if pos.y >= 545.0 and pos.x >= 200.0 and pos.x <= 1270.0:
		return true
	# Bottom right sell button area: y >= 475.0, x in [1120.0, 1270.0]
	if pos.y >= 475.0 and pos.x >= 1120.0 and pos.x <= 1270.0:
		return true
	return false

func _input(event: InputEvent) -> void:
	if is_dragging and dragged_unit != null:
		var can_continue = false
		if GameManager.current_phase == GameManager.Phase.PREPARATION:
			can_continue = true
		elif GameManager.current_phase == GameManager.Phase.COMBAT and dragged_unit.is_on_bench:
			can_continue = true
		if not can_continue:
			cancel_drag()
			return
	elif not is_dragging:
		return
		
	if event is InputEventMouseMotion and is_dragging and dragged_unit != null:
		var m_pos = get_global_mouse_position()
		dragged_unit.position = m_pos
		
		var in_sell = is_pos_in_sell_zone(m_pos)
		if in_sell != is_hovering_sell_zone:
			is_hovering_sell_zone = in_sell
			GameManager.unit_drag_hover_sell.emit(is_hovering_sell_zone)
			
		if in_sell:
			selector_sprite.visible = false
		else:
			var hover_grid = world_to_grid(dragged_unit.position)
			if GameManager.current_phase == GameManager.Phase.PREPARATION and hover_grid != Vector2i(-1, -1) and hover_grid.y >= 3:
				selector_sprite.visible = true
				selector_sprite.position = grid_to_world(hover_grid)
			else:
				var hover_bench = world_to_bench(dragged_unit.position)
				if hover_bench != -1:
					selector_sprite.visible = true
					selector_sprite.position = bench_to_world(hover_bench)
				else:
					selector_sprite.visible = false
					
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
		if is_dragging and dragged_unit != null:
			end_drag()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
		if GameManager.item_bench != null and "selected_slot" in GameManager.item_bench:
			GameManager.item_bench.deselect_all()

	if GameManager.current_phase != GameManager.Phase.PREPARATION:
		return
		
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var m_pos = get_global_mouse_position()
		var grid_pos = world_to_grid(m_pos)
		var bench_idx = world_to_bench(m_pos)
		
		if selected_unit != null:
			if grid_pos != Vector2i(-1, -1) and grid_pos.y >= 3:
				try_place_unit_on_grid(selected_unit, grid_pos)
			elif bench_idx != -1:
				try_place_unit_on_bench(selected_unit, bench_idx)
			else:
				deselect_unit()
				GameManager.inspect_unit(null)
		elif GameManager.item_bench != null and "selected_slot" in GameManager.item_bench and GameManager.item_bench.selected_slot != -1:
			GameManager.item_bench.deselect_all()

func _on_unit_clicked(unit: Unit) -> void:
	if unit == null or not is_instance_valid(unit):
		return

	# If an item is currently selected on the item bench, attempt to equip it to this friendly unit!
	if not unit.is_enemy and GameManager.item_bench != null and "selected_slot" in GameManager.item_bench:
		if GameManager.item_bench.selected_slot != -1:
			var success = GameManager.item_bench.handle_unit_clicked(unit)
			if success:
				AudioManager.play_sfx("click")
				if GameManager.hud_ref and GameManager.hud_ref.unit_detail_modal and GameManager.hud_ref.unit_detail_modal.visible:
					GameManager.hud_ref.unit_detail_modal.open(unit)
				return
			else:
				if unit.has_method("spawn_floating_text"):
					unit.spawn_floating_text("装备栏已满!", Color(1.0, 0.4, 0.4))
				GameManager.item_bench.deselect_all()
				return
		
	# Notify GameManager to inspect this unit in HUD (pop up detail card)
	GameManager.inspect_unit(unit)
	
	# Can drag player units in PREP phase, OR bench player units in COMBAT phase!
	var can_drag = false
	if not unit.is_enemy:
		if GameManager.current_phase == GameManager.Phase.PREPARATION:
			can_drag = true
		elif GameManager.current_phase == GameManager.Phase.COMBAT and unit.is_on_bench:
			can_drag = true
			
	if can_drag:
		select_unit(unit)
		start_drag(unit)

var selector_tween: Tween = null

func start_drag(unit: Unit) -> void:
	dragged_unit = unit
	drag_start_pos = unit.position
	is_dragging = true
	is_hovering_sell_zone = false
	unit.z_index = 50
	create_tween().tween_property(unit, "scale", Vector2(1.12, 1.12), 0.08)
	
	var data = PokemonDatabase.get_pokemon(unit.pokemon_id)
	var refund = data.get("cost", 1) * int(pow(3, unit.star_level - 1))
	GameManager.unit_drag_started.emit(unit, refund)

func end_drag() -> void:
	if dragged_unit == null:
		return
	var unit = dragged_unit
	unit.z_index = 5
	create_tween().tween_property(unit, "scale", Vector2(1.0, 1.0), 0.08)
	is_dragging = false
	dragged_unit = null
	
	var m_pos = get_global_mouse_position()
	var in_sell = is_pos_in_sell_zone(m_pos)
	is_hovering_sell_zone = false
	
	if in_sell:
		sell_unit(unit)
		GameManager.unit_drag_ended.emit(true)
		return
		
	GameManager.unit_drag_ended.emit(false)
	
	var drop_grid = world_to_grid(m_pos)
	var drop_bench = world_to_bench(m_pos)
	
	if GameManager.current_phase == GameManager.Phase.PREPARATION and drop_grid != Vector2i(-1, -1) and drop_grid.y >= 3:
		try_place_unit_on_grid(unit, drop_grid)
	elif drop_bench != -1:
		try_place_unit_on_bench(unit, drop_bench)
	else:
		# Return to start position
		var tw = create_tween()
		tw.tween_property(unit, "position", drag_start_pos, 0.12).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)

func cancel_drag() -> void:
	if dragged_unit != null:
		dragged_unit.z_index = 5
		dragged_unit.scale = Vector2(1.0, 1.0)
		dragged_unit.position = drag_start_pos
		dragged_unit = null
	is_dragging = false
	is_hovering_sell_zone = false
	GameManager.unit_drag_ended.emit(false)

func select_unit(unit: Unit) -> void:
	selected_unit = unit
	selector_sprite.visible = true
	selector_sprite.position = unit.position
	selector_sprite.scale = Vector2(0.85, 0.85)
	
	if selector_tween and selector_tween.is_valid():
		selector_tween.kill()
	selector_tween = create_tween().set_loops()
	selector_tween.tween_property(selector_sprite, "scale", Vector2(0.96, 0.96), 0.65).set_trans(Tween.TRANS_SINE)
	selector_tween.parallel().tween_property(selector_sprite, "rotation", deg_to_rad(45.0), 0.65)
	selector_tween.tween_property(selector_sprite, "scale", Vector2(0.82, 0.82), 0.65).set_trans(Tween.TRANS_SINE)
	selector_tween.parallel().tween_property(selector_sprite, "rotation", deg_to_rad(90.0), 0.65)

func deselect_unit() -> void:
	selected_unit = null
	selector_sprite.visible = false
	selector_sprite.rotation = 0.0
	if selector_tween and selector_tween.is_valid():
		selector_tween.kill()

func try_place_unit_on_grid(unit: Unit, target_coord: Vector2i) -> void:
	var existing = board_grid[target_coord.x][target_coord.y]
	
	if unit.is_on_bench:
		# Moving from bench to board
		if existing == null:
			if count_player_units_on_board() >= GameManager.level:
				# Max army size reached!
				unit.spawn_floating_text("人口已满!", Color(1.0, 0.4, 0.4))
				AudioManager.play_sfx("click", 0.8)
				deselect_unit()
				unit.position = bench_to_world(unit.grid_coord.x)
				return
			# Clear from bench
			bench_slots[unit.grid_coord.x] = null
			unit.is_on_bench = false
			unit.grid_coord = target_coord
			board_grid[target_coord.x][target_coord.y] = unit
			unit.position = grid_to_world(target_coord)
		else:
			# Swap bench unit with board unit
			bench_slots[unit.grid_coord.x] = existing
			existing.is_on_bench = true
			existing.grid_coord = Vector2i(unit.grid_coord.x, -1)
			existing.position = bench_to_world(unit.grid_coord.x)
			
			board_grid[target_coord.x][target_coord.y] = unit
			unit.is_on_bench = false
			unit.grid_coord = target_coord
			unit.position = grid_to_world(target_coord)
	else:
		# Moving from board to board
		if existing == null:
			board_grid[unit.grid_coord.x][unit.grid_coord.y] = null
			unit.grid_coord = target_coord
			board_grid[target_coord.x][target_coord.y] = unit
			unit.position = grid_to_world(target_coord)
		else:
			# Swap
			board_grid[unit.grid_coord.x][unit.grid_coord.y] = existing
			existing.grid_coord = unit.grid_coord
			existing.position = grid_to_world(existing.grid_coord)
			
			board_grid[target_coord.x][target_coord.y] = unit
			unit.grid_coord = target_coord
			unit.position = grid_to_world(target_coord)
			
	AudioManager.play_sfx("click", 1.0)
	deselect_unit()
	update_synergies()

func try_place_unit_on_bench(unit: Unit, target_slot: int) -> void:
	var existing = bench_slots[target_slot]
	
	if unit.is_on_bench:
		# Bench to bench swap/move
		bench_slots[unit.grid_coord.x] = existing
		if existing != null:
			existing.grid_coord = Vector2i(unit.grid_coord.x, -1)
			existing.position = bench_to_world(unit.grid_coord.x)
			
		bench_slots[target_slot] = unit
		unit.grid_coord = Vector2i(target_slot, -1)
		unit.position = bench_to_world(target_slot)
	else:
		# Board to bench
		board_grid[unit.grid_coord.x][unit.grid_coord.y] = existing
		if existing != null:
			existing.is_on_bench = false
			existing.grid_coord = unit.grid_coord
			existing.position = grid_to_world(unit.grid_coord)
			
		bench_slots[target_slot] = unit
		unit.is_on_bench = true
		unit.grid_coord = Vector2i(target_slot, -1)
		unit.position = bench_to_world(target_slot)
		
	AudioManager.play_sfx("click", 1.0)
	deselect_unit()
	update_synergies()

func swap_units(u1: Unit, u2: Unit) -> void:
	if u1.is_on_bench and u2.is_on_bench:
		try_place_unit_on_bench(u1, u2.grid_coord.x)
	elif not u1.is_on_bench and not u2.is_on_bench:
		try_place_unit_on_grid(u1, u2.grid_coord)
	elif u1.is_on_bench and not u2.is_on_bench:
		try_place_unit_on_grid(u1, u2.grid_coord)
	else:
		try_place_unit_on_bench(u1, u2.grid_coord.x)

func sell_unit(unit: Unit) -> void:
	if unit == null or unit.is_enemy:
		return
	var data = PokemonDatabase.get_pokemon(unit.pokemon_id)
	var refund = data.get("cost", 1) * int(pow(3, unit.star_level - 1))
	GameManager.add_gold(refund)
	AudioManager.play_sfx("sell")
	
	if unit.is_on_bench:
		bench_slots[unit.grid_coord.x] = null
	else:
		board_grid[unit.grid_coord.x][unit.grid_coord.y] = null
		
	if selected_unit == unit:
		deselect_unit()
		
	unit.queue_free()
	update_synergies()

func update_synergies() -> void:
	var player_units = get_board_units(false)
	SynergyManager.update_synergies_from_units(player_units)
	if ShinyAndLoreManager:
		ShinyAndLoreManager.check_lore_synergies(player_units)

func check_and_execute_evolutions() -> void:
	if GameManager.current_phase != GameManager.Phase.PREPARATION:
		return
	# Check all units owned by player (board + bench)
	var all_units: Array[Unit] = []
	for c in range(COLS):
		for r in range(3, ROWS):
			if board_grid[c][r] != null:
				all_units.append(board_grid[c][r])
	for i in range(BENCH_SLOTS):
		if bench_slots[i] != null:
			all_units.append(bench_slots[i])
			
	# Group by (pokemon_id, star_level)
	var groups: Dictionary = {}
	for u in all_units:
		if u.star_level >= 3:
			continue # Already max star
		var key = "%s_%d" % [u.pokemon_id, u.star_level]
		if not groups.has(key):
			groups[key] = []
		groups[key].append(u)
		
	for key in groups:
		var list: Array = groups[key]
		if list.size() >= 3:
			# Evolve! Take 3 units, upgrade first one, remove other two
			var prime = list[0] as Unit
			var sacrifice1 = list[1] as Unit
			var sacrifice2 = list[2] as Unit
			
			# Prefer keeping a unit already on the board
			for cand in list:
				if not cand.is_on_bench:
					prime = cand
					break
			# Pick 2 sacrifices not equal to prime
			var sacrifices: Array[Unit] = []
			for cand in list:
				if cand != prime and sacrifices.size() < 2:
					sacrifices.append(cand)
					
			for s in sacrifices:
				if "held_items" in s:
					while s.held_items.size() > 0:
						var item_id = s.unequip_item_at(0)
						if item_id != "" and GameManager.item_bench != null and GameManager.item_bench.has_method("add_item"):
							GameManager.item_bench.add_item(item_id)
				if s.is_on_bench:
					bench_slots[s.grid_coord.x] = null
				else:
					board_grid[s.grid_coord.x][s.grid_coord.y] = null
				s.queue_free()
				
			var is_any_shiny = prime.is_shiny or (sacrifice1 and sacrifice1.is_shiny) or (sacrifice2 and sacrifice2.is_shiny)
			var carried_affix = prime.shiny_affix if prime.is_shiny else (sacrifice1.shiny_affix if (sacrifice1 and sacrifice1.is_shiny) else (sacrifice2.shiny_affix if (sacrifice2 and sacrifice2.is_shiny) else ""))
			
			var target_star = prime.star_level + 1
			
			if target_star == 2:
				# ★1 -> ★2: Keep same species (only evolve at ★3!)
				prime.setup(prime.pokemon_id, 2, false, is_any_shiny, carried_affix)
				AudioManager.play_sfx("upgrade")
				prime.spawn_floating_text("升星! ★2", Color(1.0, 0.9, 0.2), true)
				GameManager.notify_unit_evolved(prime.pokemon_id, 2)
				GameManager.request_skill_choice(prime, 2)
				update_synergies()
				call_deferred("check_and_execute_evolutions")
				return
			elif target_star == 3:
				# ★2 -> ★3: Reaches max star!
				prime.setup(prime.pokemon_id, 3, false, is_any_shiny, carried_affix)
				var evo_options = PokemonDatabase.get_evolution_options(prime.pokemon_id)
				if not evo_options.is_empty():
					# Has evolution options: trigger Step 1 form choice, then 3-star skills
					AudioManager.play_sfx("upgrade")
					prime.spawn_floating_text("满星达成! ★3", Color(1.0, 0.85, 0.2), true)
					GameManager.notify_unit_evolved(prime.pokemon_id, 3)
					GameManager.request_evolution_choice(prime, evo_options)
					update_synergies()
					call_deferred("check_and_execute_evolutions")
					return
				else:
					# No evolutions (e.g. Snorlax, Mewtwo): directly trigger 3-star skills
					AudioManager.play_sfx("upgrade")
					prime.spawn_floating_text("满星达成! ★3", Color(1.0, 0.85, 0.2), true)
					GameManager.notify_unit_evolved(prime.pokemon_id, 3)
					GameManager.request_skill_choice(prime, 3)
					update_synergies()
					call_deferred("check_and_execute_evolutions")
					return

# Combat phase logic
func start_round_combat() -> void:
	if is_dragging:
		cancel_drag()
	deselect_unit()
	auto_deploy_from_bench()
	
	# Smoothly fade out battlefield grid tiles for clean immersive combat arena
	var tw = create_tween()
	tw.tween_property(tiles_container, "modulate:a", 0.0, 0.25)
	selector_sprite.visible = false
	
	home_positions.clear()
	var player_units = get_board_units(false)
	for u in player_units:
		home_positions[u] = u.grid_coord
		u.is_in_combat = true
		u.damage_dealt = 0.0
		u.damage_taken = 0.0
		u.healing_done = 0.0
		u.combat_time = 0.0
		
	# Apply arena start_mana modifier (e.g. Stadium Stage 2)
	if GameManager.has_arena_modifier("start_mana"):
		var sm = GameManager.get_arena_modifier_val("start_mana")
		for u in player_units:
			u.current_mana = min(u.max_mana, u.current_mana + sm)
			u.update_bars()
		
	if ShinyAndLoreManager:
		ShinyAndLoreManager.apply_combat_start_effects(player_units)
		
	spawn_enemy_wave(GameManager.current_round)
	apply_round_elemental_hexes_to_units()

func spawn_enemy_wave(round_num: int) -> void:
	var wave_defs = []
	if GameManager.is_gym_road_mode and GymRoadManager and GymRoadManager.is_gym_battle_active():
		wave_defs = GymRoadManager.get_current_gym_wave_definition()
	else:
		wave_defs = get_wave_definition(round_num)
	var boss_unit_found: Unit = null
	
	for item in wave_defs:
		var pid = item["id"]
		var star = item.get("star", 1)
		var coord = item["coord"]
		var is_boss = item.get("is_boss", false)
		
		var unit = UNIT_SCENE.instantiate() as Unit
		units_container.add_child(unit)
		unit.setup(pid, star, true)
		unit.grid_coord = coord
		unit.position = grid_to_world(coord)
		board_grid[coord.x][coord.y] = unit
		unit.unit_died.connect(_on_unit_died)
		unit.unit_clicked.connect(_on_unit_clicked)
		unit.is_in_combat = true
		
		if is_boss:
			unit.max_hp *= 2.4
			unit.current_hp = unit.max_hp
			unit.atk *= 1.3
			unit.scale = Vector2(1.35, 1.35)
			unit.set_meta("is_boss", true)
			var crown = Label.new()
			crown.name = "BossCrown"
			crown.text = "👑 BOSS"
			crown.position = Vector2(-28, -50)
			crown.add_theme_font_size_override("font_size", 11)
			crown.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2))
			unit.add_child(crown)
			boss_unit_found = unit
			
	if boss_unit_found != null:
		if GameManager.hud_ref and GameManager.hud_ref.has_method("show_boss_health_bar"):
			GameManager.hud_ref.show_boss_health_bar(boss_unit_found)
	else:
		if GameManager.hud_ref and GameManager.hud_ref.has_method("hide_boss_health_bar"):
			GameManager.hud_ref.hide_boss_health_bar()

func get_wave_definition(round_num: int) -> Array:
	match round_num:
		1:
			return [
				{"id": "charmander", "star": 1, "coord": Vector2i(3, 1)},
				{"id": "squirtle", "star": 1, "coord": Vector2i(4, 1)}
			]
		2:
			return [
				{"id": "bulbasaur", "star": 1, "coord": Vector2i(2, 1)},
				{"id": "machop", "star": 1, "coord": Vector2i(5, 1)},
				{"id": "pikachu", "star": 1, "coord": Vector2i(4, 0)}
			]
		3:
			return [
				{"id": "squirtle", "star": 2, "coord": Vector2i(3, 1)},
				{"id": "charmander", "star": 2, "coord": Vector2i(4, 1)}
			]
		4:
			return [
				{"id": "machop", "star": 2, "coord": Vector2i(2, 1)},
				{"id": "pikachu", "star": 2, "coord": Vector2i(5, 0)},
				{"id": "bulbasaur", "star": 2, "coord": Vector2i(3, 1)}
			]
		5: # Wave 5: Snorlax Epic Boss Wave (Gen 1)
			return [
				{"id": "snorlax", "star": 3, "coord": Vector2i(3, 1), "is_boss": true},
				{"id": "gengar", "star": 2, "coord": Vector2i(2, 0)},
				{"id": "alakazam", "star": 2, "coord": Vector2i(5, 0)}
			]
		6:
			return [
				{"id": "gyarados", "star": 2, "coord": Vector2i(2, 1)},
				{"id": "charizard", "star": 2, "coord": Vector2i(5, 1)},
				{"id": "dragonite", "star": 1, "coord": Vector2i(4, 0)}
			]
		7:
			return [
				{"id": "scizor", "star": 2, "coord": Vector2i(2, 1)},
				{"id": "heracross", "star": 2, "coord": Vector2i(5, 1)},
				{"id": "houndoom", "star": 2, "coord": Vector2i(3, 0)}
			]
		8:
			return [
				{"id": "ampharos", "star": 2, "coord": Vector2i(2, 0)},
				{"id": "kingdra", "star": 2, "coord": Vector2i(5, 0)},
				{"id": "steelix", "star": 2, "coord": Vector2i(3, 1)},
				{"id": "skarmory", "star": 2, "coord": Vector2i(4, 1)}
			]
		9:
			return [
				{"id": "espeon", "star": 3, "coord": Vector2i(2, 0)},
				{"id": "umbreon", "star": 3, "coord": Vector2i(5, 1)},
				{"id": "gengar", "star": 3, "coord": Vector2i(3, 1)}
			]
		10: # Wave 10: Tyranitar & Lugia Epic Dual Boss (Gen 2)
			return [
				{"id": "tyranitar", "star": 3, "coord": Vector2i(3, 1), "is_boss": true},
				{"id": "lugia", "star": 2, "coord": Vector2i(4, 0), "is_boss": true},
				{"id": "houndoom", "star": 2, "coord": Vector2i(1, 1)},
				{"id": "ampharos", "star": 2, "coord": Vector2i(6, 1)}
			]
		11:
			return [
				{"id": "blaziken", "star": 2, "coord": Vector2i(2, 1)},
				{"id": "swampert", "star": 2, "coord": Vector2i(4, 1)},
				{"id": "sceptile", "star": 2, "coord": Vector2i(5, 1)},
				{"id": "gardevoir", "star": 2, "coord": Vector2i(3, 0)}
			]
		12:
			return [
				{"id": "salamence", "star": 3, "coord": Vector2i(3, 0)},
				{"id": "flygon", "star": 2, "coord": Vector2i(5, 0)},
				{"id": "aggron", "star": 2, "coord": Vector2i(2, 1)},
				{"id": "milotic", "star": 2, "coord": Vector2i(4, 1)}
			]
		13:
			return [
				{"id": "metagross", "star": 3, "coord": Vector2i(3, 1)},
				{"id": "lucario", "star": 2, "coord": Vector2i(4, 1)},
				{"id": "garchomp", "star": 2, "coord": Vector2i(2, 1)},
				{"id": "togekiss", "star": 2, "coord": Vector2i(5, 0)}
			]
		14:
			return [
				{"id": "infernape", "star": 3, "coord": Vector2i(2, 1)},
				{"id": "empoleon", "star": 3, "coord": Vector2i(4, 1)},
				{"id": "torterra", "star": 3, "coord": Vector2i(5, 1)},
				{"id": "staraptor", "star": 3, "coord": Vector2i(3, 0)}
			]
		15: # Wave 15: Rayquaza & Groudon Superboss (Gen 3)
			return [
				{"id": "rayquaza", "star": 3, "coord": Vector2i(3, 0), "is_boss": true},
				{"id": "groudon", "star": 3, "coord": Vector2i(4, 1), "is_boss": true},
				{"id": "kyogre", "star": 2, "coord": Vector2i(1, 0)},
				{"id": "deoxys", "star": 2, "coord": Vector2i(6, 0)}
			]
		16:
			return [
				{"id": "electivire", "star": 3, "coord": Vector2i(2, 1)},
				{"id": "magmortar", "star": 3, "coord": Vector2i(4, 1)},
				{"id": "rhyperior", "star": 3, "coord": Vector2i(5, 1)},
				{"id": "tangrowth", "star": 3, "coord": Vector2i(3, 1)}
			]
		17:
			return [
				{"id": "weavile", "star": 3, "coord": Vector2i(2, 1)},
				{"id": "drapion", "star": 3, "coord": Vector2i(4, 1)},
				{"id": "honchkrow", "star": 3, "coord": Vector2i(3, 0)},
				{"id": "spiritomb", "star": 3, "coord": Vector2i(5, 0)}
			]
		18:
			return [
				{"id": "heatran", "star": 3, "coord": Vector2i(3, 1)},
				{"id": "regigigas", "star": 3, "coord": Vector2i(4, 1)},
				{"id": "cresselia", "star": 3, "coord": Vector2i(2, 0)},
				{"id": "darkrai", "star": 3, "coord": Vector2i(5, 0)}
			]
		19:
			return [
				{"id": "giratina", "star": 3, "coord": Vector2i(3, 0)},
				{"id": "darkrai", "star": 3, "coord": Vector2i(2, 0)},
				{"id": "mewtwo", "star": 3, "coord": Vector2i(5, 0)},
				{"id": "lucario", "star": 3, "coord": Vector2i(4, 1)}
			]
		20: # Wave 20: Arceus, Dialga & Palkia Mythical Supreme Boss (Gen 4 Finale)
			return [
				{"id": "arceus", "star": 3, "coord": Vector2i(3, 0), "is_boss": true},
				{"id": "dialga", "star": 3, "coord": Vector2i(2, 1), "is_boss": true},
				{"id": "palkia", "star": 3, "coord": Vector2i(5, 1), "is_boss": true},
				{"id": "giratina", "star": 3, "coord": Vector2i(4, 0)}
			]
		_: # Endgame Endless Waves (Rounds > 20)
			return [
				{"id": "arceus", "star": 3, "coord": Vector2i(3, 0), "is_boss": true},
				{"id": "rayquaza", "star": 3, "coord": Vector2i(4, 0)},
				{"id": "mewtwo", "star": 3, "coord": Vector2i(2, 1)},
				{"id": "dialga", "star": 3, "coord": Vector2i(5, 1)}
			]

func _on_unit_died(_unit: Unit) -> void:
	if GameManager.current_phase != GameManager.Phase.COMBAT:
		return
		
	# Check victory or defeat
	var all_units = get_tree().get_nodes_in_group("units")
	var live_players = 0
	var live_enemies = 0
	
	for node in all_units:
		var u = node as Unit
		if u != null and not u.is_dead and not u.is_on_bench:
			if u.is_enemy:
				live_enemies += 1
			else:
				live_players += 1
				
	if live_enemies == 0 and live_players > 0:
		_award_victory_item_drops(GameManager.current_round)
		GameManager.resolve_combat(true, 0)
	elif live_players == 0:
		GameManager.resolve_combat(false, live_enemies)

func _award_victory_item_drops(round_num: int) -> void:
	if GameManager.item_bench == null or not GameManager.item_bench.has_method("add_item"):
		return
	if round_num in [1, 2, 3]:
		# Creep rounds: drop 1 random base item component
		var bases = ItemDatabase.get_all_base_item_ids() if ItemDatabase else []
		if not bases.is_empty():
			var dropped = bases[randi() % bases.size()]
			GameManager.add_item_to_bench(dropped)
			AudioManager.play_sfx("buy")
	elif round_num == 5:
		# Snorlax Boss (Gen 1): drop 1 advanced item
		var advs = ItemDatabase.get_all_advanced_item_ids() if ItemDatabase else []
		if not advs.is_empty():
			var dropped = advs[randi() % advs.size()]
			GameManager.add_item_to_bench(dropped)
			AudioManager.play_sfx("upgrade")
	elif round_num == 10:
		# Tyranitar & Lugia (Gen 2 Dual Boss): drop 1 advanced item + 1 base item
		var advs = ItemDatabase.get_all_advanced_item_ids() if ItemDatabase else []
		if not advs.is_empty():
			GameManager.add_item_to_bench(advs[randi() % advs.size()])
		var bases = ItemDatabase.get_all_base_item_ids() if ItemDatabase else []
		if not bases.is_empty():
			GameManager.add_item_to_bench(bases[randi() % bases.size()])
		AudioManager.play_sfx("upgrade")
	elif round_num == 15:
		# Rayquaza & Groudon (Gen 3 Legendary Boss): drop 1 advanced item + 1 base item
		var advs = ItemDatabase.get_all_advanced_item_ids() if ItemDatabase else []
		if not advs.is_empty():
			GameManager.add_item_to_bench(advs[randi() % advs.size()])
		var bases = ItemDatabase.get_all_base_item_ids() if ItemDatabase else []
		if not bases.is_empty():
			GameManager.add_item_to_bench(bases[randi() % bases.size()])
		AudioManager.play_sfx("upgrade")
	elif round_num == 20:
		# Arceus Supreme Boss (Gen 4 Finale): drop 2 advanced items
		var advs = ItemDatabase.get_all_advanced_item_ids() if ItemDatabase else []
		if not advs.is_empty():
			GameManager.add_item_to_bench(advs[randi() % advs.size()])
			GameManager.add_item_to_bench(advs[randi() % advs.size()])
		AudioManager.play_sfx("upgrade")
	elif round_num in [4, 7, 8, 12, 16]:
		var bases = ItemDatabase.get_all_base_item_ids() if ItemDatabase else []
		if not bases.is_empty() and randf() < 0.5:
			var dropped = bases[randi() % bases.size()]
			GameManager.add_item_to_bench(dropped)
			AudioManager.play_sfx("buy")

func reset_board_for_prep() -> void:
	# Hide boss health bar if active
	if GameManager.hud_ref and GameManager.hud_ref.has_method("hide_boss_health_bar"):
		GameManager.hud_ref.hide_boss_health_bar()
		
	# Smoothly fade battlefield grid tiles back in for clear preparation placement
	var tw = create_tween()
	tw.tween_property(tiles_container, "modulate:a", 1.0, 0.25)
	
	# Clean up any leftover enemy units
	var all_units = get_tree().get_nodes_in_group("units")
	for node in all_units:
		var u = node as Unit
		if u != null and u.is_enemy:
			u.queue_free()
			
	# Restore player units to their pre-combat positions
	for unit in home_positions:
		if is_instance_valid(unit):
			var coord = home_positions[unit]
			unit.position = grid_to_world(coord)
			unit.grid_coord = coord
			unit.reset_for_prep()
			board_grid[coord.x][coord.y] = unit
			
	update_synergies()
	check_and_execute_evolutions()
	
	if hex_system:
		hex_system.clear_all_unit_hex_buffs()
	refresh_round_elemental_hexes(3)

func refresh_round_elemental_hexes(count: int = 3) -> Dictionary:
	clear_visual_hexes()
	if hex_system == null:
		return {}
	var p_range = Vector2i(3, ROWS - 1) if ROWS == 6 else Vector2i(4, 7)
	var e_range = Vector2i(0, 2) if ROWS == 6 else Vector2i(0, 3)
	var gen_hexes = hex_system.generate_round_hexes(count, p_range, e_range)
	spawn_visual_hexes(gen_hexes)
	return gen_hexes

func spawn_visual_hexes(hexes_data: Dictionary) -> void:
	clear_visual_hexes()
	for coord in hexes_data:
		var h_type = hexes_data[coord]
		var hex_node = ELEMENTAL_HEX_NODE_SCRIPT.new()
		hex_node.setup(coord, h_type, hex_system.get_hex_info(h_type))
		hex_node.position = grid_to_world(coord)
		hexes_container.add_child(hex_node)
		hex_nodes[coord] = hex_node

func clear_visual_hexes() -> void:
	for coord in hex_nodes:
		var node = hex_nodes[coord]
		if is_instance_valid(node):
			if node.get_parent():
				node.get_parent().remove_child(node)
			node.queue_free()
	hex_nodes.clear()
	if hexes_container:
		for child in hexes_container.get_children():
			hexes_container.remove_child(child)
			child.queue_free()

func apply_round_elemental_hexes_to_units() -> void:
	if hex_system == null:
		return
	var all_units = get_board_units(true)
	hex_system.evaluate_combat_units(all_units)

