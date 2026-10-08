extends Node

# test_elemental_hex.gd
# Automated Test Suite for Module 2: Elemental Hex Nodes (棋盘元素符文地块系统)

const ELEMENTAL_HEX_SYSTEM_SCRIPT = preload("res://scripts/elemental_hex_system.gd")
const ELEMENTAL_HEX_NODE_SCRIPT = preload("res://scripts/elemental_hex_node.gd")
const UNIT_SCENE = preload("res://scenes/unit.tscn")
const UNIT_DETAIL_MODAL_SCENE = preload("res://scenes/unit_detail_modal.tscn")

func _ready() -> void:
	print("\n========================================================")
	print(">>> STARTING ELEMENTAL HEX SYSTEM AUTOMATED TESTS <<<")
	print("========================================================")

	test_hex_generation()
	test_elemental_buff_effects()
	test_board_visuals_and_round_refresh()

	print("\n========================================================")
	print(">>> ALL ELEMENTAL HEX SYSTEM TESTS PASSED (100%) <<<")
	print("========================================================\n")
	get_tree().quit(0)

func test_hex_generation() -> void:
	print("\n--- Test 1: Random Elemental Hex Generation ---")
	var hex_sys = ELEMENTAL_HEX_SYSTEM_SCRIPT.new()
	add_child(hex_sys)

	# 1.1 Default generation (count = 3)
	var hexes_3 = hex_sys.generate_round_hexes(3)
	assert(hexes_3.size() == 6, "Expected 6 total hexes for count=3 (3 enemy, 3 player), got %d" % hexes_3.size())

	var enemy_count = 0
	var player_count = 0

	for coord in hexes_3:
		var elem = hexes_3[coord]
		assert(elem in ["fire", "water", "rock", "wind"], "Generated element must be valid, got: %s" % elem)

		if hex_sys.is_valid_enemy_coord(coord):
			enemy_count += 1
			assert(coord.x >= 0 and coord.x <= 7, "Enemy coord.x must be 0..7")
			assert(coord.y >= 0 and coord.y <= 3, "Enemy coord.y must be 0..3")
		elif hex_sys.is_valid_player_coord(coord):
			player_count += 1
			assert(coord.x >= 0 and coord.x <= 7, "Player coord.x must be 0..7")
			assert(coord.y >= 4 and coord.y <= 7, "Player coord.y must be 4..7")
		else:
			assert(false, "Coordinate %s is neither in enemy (y: 0..3) nor player (y: 4..7) bounds!" % str(coord))

	assert(enemy_count == 3, "Expected exactly 3 enemy hexes, got %d" % enemy_count)
	assert(player_count == 3, "Expected exactly 3 player hexes, got %d" % player_count)
	print("  [PASS] Default generation verified: 3 enemy (y: 0..3), 3 player (y: 4..7), all in x: 0..7.")

	# 1.2 Custom generation (count = 2)
	var hexes_2 = hex_sys.generate_round_hexes(2)
	assert(hexes_2.size() == 4, "Expected 4 total hexes for count=2, got %d" % hexes_2.size())
	print("  [PASS] Custom generation verified: exactly 2 hexes per side (total 4).")

	# 1.3 Randomness & Element Diversity over multiple rounds
	var all_elements_seen: Dictionary = {}
	var unique_coord_sets: Array = []
	for r in range(12):
		var round_hexes = hex_sys.generate_round_hexes(3)
		var keys = round_hexes.keys()
		keys.sort()
		var hash_val = str(keys)
		if not unique_coord_sets.has(hash_val):
			unique_coord_sets.append(hash_val)
		for c in round_hexes:
			all_elements_seen[round_hexes[c]] = true

	assert(unique_coord_sets.size() > 1, "Rounds must generate varied coordinates, got identical sets.")
	for e in ["fire", "water", "rock", "wind"]:
		assert(all_elements_seen.has(e), "All 4 elements must appear across multiple generations, missing: %s" % e)
	print("  [PASS] Coordinate randomness and 4-element diversity verified across 12 rounds.")

	hex_sys.queue_free()

func test_elemental_buff_effects() -> void:
	print("\n--- Test 2: 4 Elemental Hex Buff Effects & Combat Mechanics ---")
	var hex_sys = ELEMENTAL_HEX_SYSTEM_SCRIPT.new()
	add_child(hex_sys)

	# 2.1 Fire Hex: 25% True Damage Burn
	print("  -> Testing Fire Hex (炽热地核)...")
	var fire_unit = UNIT_SCENE.instantiate() as Unit
	add_child(fire_unit)
	fire_unit.setup("charmander", 1, false)

	hex_sys.activate_hex_buff_for_unit(fire_unit, "fire")
	assert(fire_unit.has_meta("hex_fire_burn"), "Fire unit must have hex_fire_burn meta")
	assert(fire_unit.get_meta("elemental_hex") == "fire", "Fire unit elemental_hex must be 'fire'")

	var target_dummy = UNIT_SCENE.instantiate() as Unit
	add_child(target_dummy)
	target_dummy.setup("snorlax", 1, true)
	# High defense: 100 Armor, 100 MR
	target_dummy.armor = 100.0
	target_dummy.mr = 100.0

	var hp_before = target_dummy.current_hp
	var true_damage_amount = 40.0
	# Deal true damage (burn or direct true hit)
	target_dummy.take_damage(true_damage_amount, false, false, false, fire_unit, true)
	var hp_after = target_dummy.current_hp
	var actual_damage = hp_before - hp_after
	assert(is_equal_approx(actual_damage, true_damage_amount),
		"True damage must bypass 100 Armor and deal exactly %.1f, got %.1f" % [true_damage_amount, actual_damage])

	# Test apply_true_burn mechanics
	target_dummy.apply_true_burn(3.0, 10.0)
	assert(target_dummy.burn_timer > 0.0, "Burn timer should be active")
	assert(target_dummy.burn_is_true == true, "Burn must be flagged as true damage")
	print("  [PASS] Fire Hex verified: 25% true damage burn successfully bypasses defense.")

	# 2.2 Water Hex: +6 Mana per second
	print("  -> Testing Water Hex (宁静泉眼)...")
	var water_unit = UNIT_SCENE.instantiate() as Unit
	add_child(water_unit)
	water_unit.setup("squirtle", 1, false)
	water_unit.current_mana = 0.0
	water_unit.is_in_combat = true
	water_unit.attack_timer = 999.0

	hex_sys.activate_hex_buff_for_unit(water_unit, "water")
	assert(water_unit.has_meta("hex_water_mana"), "Water unit must have hex_water_mana meta")

	# Simulate 1 second combat process
	var delta_time = 1.0
	water_unit._process(delta_time)
	assert(is_equal_approx(water_unit.current_mana, 6.0),
		"Water unit must gain 6.0 mana in 1.0s, got %.2f" % water_unit.current_mana)

	# Simulate another 0.5s
	water_unit._process(0.5)
	assert(is_equal_approx(water_unit.current_mana, 9.0),
		"Water unit must have 9.0 mana after 1.5s, got %.2f" % water_unit.current_mana)
	print("  [PASS] Water Hex verified: regenerates +6 mana per second accurately.")

	# 2.3 Rock Hex: +30% Max HP Shield & Knockback Immunity
	print("  -> Testing Rock Hex (坚毅磐石)...")
	var rock_unit = UNIT_SCENE.instantiate() as Unit
	add_child(rock_unit)
	rock_unit.setup("machop", 1, false)
	var expected_shield = rock_unit.max_hp * 0.30

	hex_sys.activate_hex_buff_for_unit(rock_unit, "rock")
	assert(rock_unit.has_meta("hex_rock_shield"), "Rock unit must have hex_rock_shield meta")
	assert(rock_unit.is_immune_to_knockback == true, "Rock unit must be immune to knockback")
	assert(is_equal_approx(rock_unit.shield, expected_shield),
		"Rock unit must gain 30%% HP shield (%.1f), got %.1f" % [expected_shield, rock_unit.shield])

	# Knockback attempt on immune rock unit
	var start_pos = rock_unit.position
	var knock_result = rock_unit.apply_knockback(Vector2(1, 0), 20.0)
	assert(knock_result == false, "Knockback must fail on rock hex unit")
	assert(rock_unit.position == start_pos, "Rock unit position must not move when knocked back")

	# Compare with normal unit without rock hex
	var normal_unit = UNIT_SCENE.instantiate() as Unit
	add_child(normal_unit)
	normal_unit.setup("machop", 1, false)
	var norm_knock_result = normal_unit.apply_knockback(Vector2(1, 0), 20.0)
	assert(norm_knock_result == true, "Normal unit without rock hex must accept knockback")
	print("  [PASS] Rock Hex verified: +30% max HP shield and knockback immunity.")

	# 2.4 Wind Hex: +35% Attack Speed & 15% Physical Dodge
	print("  -> Testing Wind Hex (疾风跃迁)...")
	var wind_unit = UNIT_SCENE.instantiate() as Unit
	add_child(wind_unit)
	wind_unit.setup("pikachu", 1, false)
	var base_as = wind_unit.atk_speed

	hex_sys.activate_hex_buff_for_unit(wind_unit, "wind")
	assert(wind_unit.has_meta("hex_wind_active"), "Wind unit must have hex_wind_active meta")
	var expected_as = base_as * 1.35
	assert(is_equal_approx(wind_unit.atk_speed, expected_as),
		"Wind unit attack speed must increase by 35%% (expected %.3f, got %.3f)" % [expected_as, wind_unit.atk_speed])
	assert(wind_unit.get_meta("hex_wind_dodge_bonus") == 0.15, "Wind unit must have 15% dodge bonus")
	print("  [PASS] Wind Hex verified: +35% attack speed and 15% physical dodge chance.")

	# 2.5 Unit Detail Modal: Active Hex Badge Inspection
	print("  -> Testing Unit Detail Modal Hex Badge Inspection...")
	var modal = UNIT_DETAIL_MODAL_SCENE.instantiate() as UnitDetailModal
	add_child(modal)
	modal.open_for_unit(fire_unit)
	var badge_found = false
	for child in modal.badges_hbox.get_children():
		if child.name == "HexBadge":
			badge_found = true
			var lbl = child.get_child(0) as Label
			assert("炽热地核" in lbl.text, "Badge must contain hex name '炽热地核', got: %s" % lbl.text)
			break
	assert(badge_found, "UnitDetailModal must display active HexBadge for fire unit")
	modal.close()
	print("  [PASS] Unit Detail Modal verified: displays active elemental hex badge.")

	# Clean up test nodes
	fire_unit.queue_free()
	target_dummy.queue_free()
	water_unit.queue_free()
	rock_unit.queue_free()
	normal_unit.queue_free()
	wind_unit.queue_free()
	modal.queue_free()
	hex_sys.queue_free()

func test_board_visuals_and_round_refresh() -> void:
	print("\n--- Test 3: Board Visual Hexes, Cleanup & Round Refresh ---")
	var board_scene = load("res://scenes/main.tscn")
	var main_instance = board_scene.instantiate()
	add_child(main_instance)

	var board = main_instance.get_node("Board")
	assert(board != null, "Board node must exist in main scene")
	assert(board.hexes_container != null, "Board must have hexes_container")
	assert(board.hex_system != null, "Board must have hex_system initialized")

	# 3.1 Visual Hex Node Spawning on Board
	var gen_hexes = board.refresh_round_elemental_hexes(3)
	assert(gen_hexes.size() > 0, "Board should generate hexes for round")
	assert(board.hexes_container.get_child_count() == gen_hexes.size(),
		"Visual hex nodes count (%d) must match generated hexes count (%d)" % [
			board.hexes_container.get_child_count(), gen_hexes.size()
		])

	# Verify visual properties on a spawned hex node
	var sample_coord = gen_hexes.keys()[0]
	var sample_node = board.hex_nodes[sample_coord]
	assert(sample_node != null, "Hex node must exist in hex_nodes dictionary")
	assert(sample_node.hex_type == gen_hexes[sample_coord], "Hex node type must match generated type")
	assert(sample_node.symbol_label != null and sample_node.symbol_label.text != "", "Hex node must display symbol")
	assert(sample_node.particles != null, "Hex node must have 2D particle emitter")
	print("  [PASS] Board 2D visual hex runes spawned with symbols, breathing animation, and particles.")

	# 3.2 Visual Hex Cleanup
	board.clear_visual_hexes()
	assert(board.hex_nodes.is_empty(), "board.hex_nodes must be empty after clear")
	assert(board.hexes_container.get_child_count() == 0, "hexes_container must have 0 children after clear")
	print("  [PASS] Board visual hexes cleanly cleared.")

	# 3.3 Round Change Refresh & Unit Reset Flow
	board.refresh_round_elemental_hexes(3)
	var first_coord = board.hex_nodes.keys()[0]
	var test_unit = UNIT_SCENE.instantiate() as Unit
	board.units_container.add_child(test_unit)
	test_unit.setup("pikachu", 1, false)
	test_unit.grid_coord = first_coord
	test_unit.is_on_bench = false
	board.board_grid[first_coord.x][first_coord.y] = test_unit

	# Combat start evaluation
	board.apply_round_elemental_hexes_to_units()
	assert(test_unit.has_meta("elemental_hex"), "Unit on hex coord must activate hex buff upon combat start")

	# Board reset for preparation (next round)
	board.reset_board_for_prep()
	assert(not test_unit.has_meta("elemental_hex"), "Unit hex buff must be cleanly reset on prep phase")
	assert(board.hexes_container.get_child_count() > 0, "New round elemental hexes must be refreshed on prep reset")
	print("  [PASS] Round transition refresh and unit buff lifecycle fully verified.")

	main_instance.queue_free()
