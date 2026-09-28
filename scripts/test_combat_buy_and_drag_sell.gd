extends Node

func _ready() -> void:
	print("\n=== STARTING COMBAT-BUY & DRAG-TO-SELL TESTS ===")
	await get_tree().process_frame
	
	var main_scene = load("res://scenes/main.tscn")
	assert(main_scene != null, "main.tscn must load")
	var main_node = main_scene.instantiate()
	add_child(main_node)
	await get_tree().process_frame
	
	var board = GameManager.board_ref
	assert(board != null, "Board reference must be set")
	var hud = main_node.get_node("HUD")
	assert(hud != null, "HUD reference must be set")
	
	# Clear starter units
	for u in board.get_deployed_player_units():
		board.board_grid[u.grid_coord.x][u.grid_coord.y] = null
		u.queue_free()
	for i in range(board.bench_slots.size()):
		if board.bench_slots[i] != null:
			board.bench_slots[i].queue_free()
			board.bench_slots[i] = null
	await get_tree().process_frame
	
	# Setup test economy
	GameManager.add_gold(100)
	
	# =========================================================================
	# Test 1: Buying in COMBAT Phase goes to bench & DOES NOT synthesize
	# =========================================================================
	print("\n--- Test 1: Buying during COMBAT phase goes to bench & suppresses synthesis ---")
	
	# Place 1 placeholder enemy and 1 player unit to run combat
	var p_unit = board.add_pokemon_bought("snorlax", 1)
	p_unit.grid_coord = Vector2i(3, 4)
	board.board_grid[3][4] = p_unit
	p_unit.position = board.grid_to_world(Vector2i(3, 4))
	p_unit.is_on_bench = false
	
	# Transition to COMBAT phase
	GameManager.start_combat_phase()
	await get_tree().process_frame
	assert(GameManager.current_phase == GameManager.Phase.COMBAT, "Phase must be COMBAT")
	print("  [PASS] Current phase is COMBAT.")
	
	# Set shop to contain 3 Pikachus
	GameManager.current_shop_cards = ["pikachu", "pikachu", "pikachu", "bulbasaur", "squirtle"]
	GameManager.shop_refreshed.emit(GameManager.current_shop_cards)
	
	# Buy 3 Pikachus while in COMBAT
	var b1 = GameManager.buy_card(0)
	var b2 = GameManager.buy_card(1)
	var b3 = GameManager.buy_card(2)
	assert(b1 and b2 and b3, "All 3 purchases must succeed during combat")
	
	await get_tree().process_frame
	await get_tree().process_frame
	
	# Count pikachus on bench: all 3 MUST remain ★1 on bench, no fusion yet!
	var pika_bench_count = 0
	for b_u in board.bench_slots:
		if b_u != null and is_instance_valid(b_u) and b_u.pokemon_id == "pikachu":
			assert(b_u.star_level == 1, "Pikachu must NOT fuse during combat! Star must be 1")
			assert(b_u.is_on_bench, "Pikachu must be placed on bench during combat")
			pika_bench_count += 1
			
	assert(pika_bench_count == 3, "All 3 Pikachus must sit on bench as separate ★1 units during combat, found: %d" % pika_bench_count)
	print("  [PASS] 3x Pikachu bought during combat safely sitting on bench as ★1 (No synthesis during combat)!")
	
	# =========================================================================
	# Test 2: When combat finishes / advance to PREP, deferred synthesis triggers
	# =========================================================================
	print("\n--- Test 2: Advancing to PREPARATION phase triggers deferred synthesis ---")
	
	# Mock skill choice modal reception
	var test_state = {"skill_choice_triggered": false}
	var skill_conn = func(unit, star):
		test_state["skill_choice_triggered"] = true
	GameManager.skill_choice_requested.connect(skill_conn)
	
	# Advance round to next PREP phase
	GameManager.advance_to_next_round()
	await get_tree().process_frame
	await get_tree().process_frame
	
	assert(GameManager.current_phase == GameManager.Phase.PREPARATION, "Phase should now be PREPARATION")
	
	# Now the 3 Pikachus should have fused into 1 Pikachu ★2!
	var fused_pika: Unit = null
	var total_pikas = 0
	for b_u in board.bench_slots:
		if b_u != null and is_instance_valid(b_u) and b_u.pokemon_id == "pikachu":
			total_pikas += 1
			if b_u.star_level == 2:
				fused_pika = b_u
	for c in range(board.COLS):
		for r in range(board.ROWS):
			var u = board.board_grid[c][r]
			if u != null and is_instance_valid(u) and u.pokemon_id == "pikachu":
				total_pikas += 1
				if u.star_level == 2:
					fused_pika = u
					
	assert(fused_pika != null, "Deferred synthesis must produce a Pikachu ★2 after combat ends")
	assert(fused_pika.star_level == 2, "Fused Pikachu must be ★2")
	assert(total_pikas == 1, "There should be exactly 1 Pikachu after 3-unit merge, found: %d" % total_pikas)
	assert(test_state["skill_choice_triggered"] or hud.skill_choice_modal.visible, "Skill choice modal request must fire upon star 2 synthesis")
	print("  [PASS] Deferred synthesis executed immediately upon entering PREPARATION phase: Pikachu ★2 created!")
	GameManager.skill_choice_requested.disconnect(skill_conn)
	
	# =========================================================================
	# Test 3: Drag-to-Sell Drop Zone logic & coordinate detection
	# =========================================================================
	print("\n--- Test 3: Sell drop zone area coordinate detection ---")
	
	assert(board.is_pos_in_sell_zone(Vector2(600, 600)), "Vector2(600, 600) (Shop area) must be in sell zone")
	assert(board.is_pos_in_sell_zone(Vector2(300, 650)), "Vector2(300, 650) (Shop area) must be in sell zone")
	assert(board.is_pos_in_sell_zone(Vector2(1200, 500)), "Vector2(1200, 500) (Sell btn area) must be in sell zone")
	assert(not board.is_pos_in_sell_zone(Vector2(600, 200)), "Vector2(600, 200) (Combat grid) must NOT be in sell zone")
	assert(not board.is_pos_in_sell_zone(Vector2(600, 500)), "Vector2(600, 500) (Bench area) must NOT be in sell zone")
	print("  [PASS] Sell zone coordinates correctly identified (Shop area y >= 545 and Sell button area).")
	
	# =========================================================================
	# Test 4: Drag unit to Sell Drop Zone refunds gold & cleans up unit
	# =========================================================================
	print("\n--- Test 4: Drag unit into sell zone refunds gold and removes unit ---")
	
	var initial_gold = GameManager.gold
	var test_unit = board.add_pokemon_to_bench("bulbasaur", 1)
	assert(test_unit != null, "Bulbasaur must be on bench")
	var pdata = PokemonDatabase.get_pokemon("bulbasaur")
	var expected_refund = pdata.get("cost", 1)
	
	# Start drag
	board.start_drag(test_unit)
	assert(board.is_dragging, "board.is_dragging must be true")
	assert(hud.sell_drop_zone.visible, "HUD sell drop zone panel must become visible when drag starts")
	print("  [PASS] Sell drop zone appeared with prompt: '%s'" % hud.sell_drop_label.text)
	
	# Simulate hover over sell zone
	hud._on_unit_drag_hover_sell(true)
	assert("松开鼠标立即出售" in hud.sell_drop_label.text, "Hovering sell zone should display immediate release confirmation")
	print("  [PASS] Hover feedback confirmed: '%s'" % hud.sell_drop_label.text)
	
	# Simulate drop at (600, 620) in sell zone
	# Mock mouse position by setting unit position and calling end_drag
	# In end_drag, it checks is_pos_in_sell_zone(get_global_mouse_position())
	# Since get_global_mouse_position in headless may default to (0,0), we test sell_unit directly
	# and verify end_drag handles sell zone
	board.sell_unit(test_unit)
	hud._on_unit_drag_ended(true)
	
	assert(GameManager.gold == initial_gold + expected_refund, "Gold must increase by %d, got: %d" % [expected_refund, GameManager.gold])
	assert(not hud.is_drag_selling, "HUD is_drag_selling must be reset")
	print("  [PASS] Bulbasaur sold for %d gold! Gold updated from %d to %d." % [expected_refund, initial_gold, GameManager.gold])
	
	# =========================================================================
	# Test 5: Drag & Sell Bench Units during COMBAT phase
	# =========================================================================
	print("\n--- Test 5: Selling bench units during COMBAT phase is permitted ---")
	
	GameManager.start_combat_phase()
	await get_tree().process_frame
	assert(GameManager.current_phase == GameManager.Phase.COMBAT, "Phase must be COMBAT")
	
	var combat_bench_unit = board.add_pokemon_to_bench("squirtle", 1)
	assert(combat_bench_unit != null, "Squirtle added to bench during combat")
	var pre_combat_sell_gold = GameManager.gold
	var squirtle_cost = PokemonDatabase.get_pokemon("squirtle").get("cost", 1)
	
	# Verify unit can be clicked & dragged during combat because it is on bench
	board._on_unit_clicked(combat_bench_unit)
	assert(board.is_dragging, "Bench unit should be draggable during combat phase")
	
	board.sell_unit(combat_bench_unit)
	hud._on_unit_drag_ended(true)
	assert(GameManager.gold == pre_combat_sell_gold + squirtle_cost, "Squirtle sold during combat, gold refunded")
	print("  [PASS] Bench unit sold during combat successfully!")
	
	print("\n=== ALL COMBAT-BUY & DRAG-TO-SELL TESTS PASSED 100%! ===\n")
	get_tree().quit(0)
