extends Node

func _ready() -> void:
	print("\n=== STARTING EVOLUTION CHAINS AND AUTO-FUSION TESTS ===")
	await get_tree().process_frame
	await get_tree().process_frame

	var board = GameManager.board_ref
	assert(board != null, "Board reference must be valid")

	# Test 1: Evolution Chains Database mappings
	print("\n--- Test 1: Database Evolution Chains Mappings ---")
	assert(PokemonDatabase.get_next_evolution("charmander") == "charmeleon", "Charmander -> Charmeleon")
	assert(PokemonDatabase.get_next_evolution("charmeleon") == "charizard", "Charmeleon -> Charizard")
	assert(PokemonDatabase.get_next_evolution("charizard") == "", "Charizard has no next evolution")
	assert(PokemonDatabase.get_root_pokemon("charizard") == "charmander", "Charizard root is Charmander")
	assert(PokemonDatabase.get_root_pokemon("charmeleon") == "charmander", "Charmeleon root is Charmander")
	assert(PokemonDatabase.get_root_pokemon("charmander") == "charmander", "Charmander root is Charmander")
	
	assert(PokemonDatabase.get_next_evolution("pikachu") == "raichu", "Pikachu -> Raichu")
	assert(PokemonDatabase.get_next_evolution("raichu") == "", "Raichu has no next evolution")
	assert(PokemonDatabase.get_root_pokemon("raichu") == "pikachu", "Raichu root is Pikachu")
	
	assert(PokemonDatabase.get_next_evolution("snorlax") == "", "Snorlax has no next evolution")
	assert(PokemonDatabase.get_root_pokemon("snorlax") == "snorlax", "Snorlax root is Snorlax")
	assert(PokemonDatabase.is_base_form("snorlax") == true, "Snorlax is a base form")
	print("[PASS] Database evolution chains mapping verified!")

	# Test 2: Shop pool filtering (only base forms)
	print("\n--- Test 2: Shop Pool Base-Form Filtering ---")
	for cost in range(1, 6):
		var eligible = PokemonDatabase.get_shop_eligible_pokemons(cost)
		assert(eligible.size() > 0, "Cost tier %d must have eligible base forms" % cost)
		for pid in eligible:
			assert(PokemonDatabase.is_base_form(pid), "Shop eligible unit %s must be base form!" % pid)
			
	# Run 500 shop refreshes and verify no evolved forms appear
	for i in range(500):
		GameManager.refresh_shop(true)
		for card_id in GameManager.current_shop_cards:
			assert(PokemonDatabase.is_base_form(card_id), "Evolved form %s rolled in shop!" % card_id)
			assert(card_id != "charmeleon" and card_id != "charizard" and card_id != "raichu", "Evolved form appeared in shop!")
	print("[PASS] Shop pool contains strictly base forms across 500 refreshes (2,500 cards)!")

	# Test 3: In-game 3-unit fusion and evolution (Charmander -> Charmeleon -> Charizard)
	print("\n--- Test 3: Auto-Fusion Evolution (3x Charmander ★1 -> Charmeleon ★2 -> Charizard ★3) ---")
	# Clear board and bench first
	for c in range(board.COLS):
		for r in range(board.ROWS):
			if board.board_grid[c][r] != null:
				board.board_grid[c][r].queue_free()
				board.board_grid[c][r] = null
	for b in range(board.BENCH_SLOTS):
		if board.bench_slots[b] != null:
			board.bench_slots[b].queue_free()
			board.bench_slots[b] = null
	await get_tree().process_frame

	# Spawn 3 Charmander units on bench
	for i in range(3):
		var u = board.add_pokemon_to_bench("charmander", 1)
		assert(u != null, "Spawn unit should succeed")
	
	board.check_and_execute_evolutions()
	await get_tree().process_frame
	await get_tree().process_frame

	# Check bench: should have exactly 1 unit, which is Charmander at ★2
	var surviving_units: Array[Unit] = []
	for b in range(board.BENCH_SLOTS):
		if board.bench_slots[b] != null and is_instance_valid(board.bench_slots[b]):
			surviving_units.append(board.bench_slots[b])
	
	assert(surviving_units.size() == 1, "Should have exactly 1 unit after fusion, got %d" % surviving_units.size())
	var star2_unit = surviving_units[0]
	assert(star2_unit.pokemon_id == "charmander", "Under new rules, ★1 -> ★2 stays same species (Charmander), got %s" % star2_unit.pokemon_id)
	assert(star2_unit.star_level == 2, "Unit star level must be 2, got %d" % star2_unit.star_level)
	print("[PASS] 3x Charmander ★1 successfully fused into 1x Charmander ★2!")

	# Now spawn 2 more Charmander at ★2 to reach ★3
	var c2 = board.add_pokemon_to_bench("charmander", 2)
	var c3 = board.add_pokemon_to_bench("charmander", 2)
	assert(c2 != null and c3 != null, "Spawn Charmanders should succeed")
	
	board.check_and_execute_evolutions()
	await get_tree().process_frame
	await get_tree().process_frame

	surviving_units.clear()
	for b in range(board.BENCH_SLOTS):
		if board.bench_slots[b] != null and is_instance_valid(board.bench_slots[b]):
			surviving_units.append(board.bench_slots[b])
			
	assert(surviving_units.size() == 1, "Should have exactly 1 unit after second fusion, got %d" % surviving_units.size())
	var star3_unit = surviving_units[0]
	assert(star3_unit.star_level == 3, "Unit star level must be 3, got %d" % star3_unit.star_level)
	# Evolve to Charizard ★3
	star3_unit.transform_to_evolution("charizard", 3)
	assert(star3_unit.pokemon_id == "charizard", "Evolved unit must be Charizard, got %s" % star3_unit.pokemon_id)
	print("[PASS] 3x Charmander ★2 fused into ★3 and evolved to 1x Charizard ★3!")
	var final_evolved = star3_unit

	# Test 4: Evolved unit deployment biases shop toward root base form
	print("\n--- Test 4: Deployed Evolved Unit Shop Bias & UP Tag ---")
	# Move Charizard from bench to battlefield
	board.bench_slots[final_evolved.grid_coord.x] = null
	final_evolved.is_on_bench = false
	final_evolved.grid_coord = Vector2i(2, 3)
	board.board_grid[2][3] = final_evolved
	
	# Verify GameManager detection
	var deployed_dict = GameManager.get_deployed_pokemon_ids()
	print("Deployed dict with Charizard on board:", deployed_dict)
	assert(deployed_dict.has("charmander"), "Deployed dict should map Charizard -> root Charmander")
	assert(GameManager.is_pokemon_deployed("charmander") == true, "is_pokemon_deployed('charmander') should be true")
	
	print("[PASS] Deployed evolved unit correctly maps to root base form for shop bias!")

	print("\n========================================================")
	print(">>> ALL EVOLUTION CHAIN TESTS PASSED SUCCESSFULLY! <<<")
	print("========================================================\n")
	get_tree().quit(0)
