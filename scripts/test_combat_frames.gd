extends Node

# Comprehensive combat loop verification

func _ready() -> void:
	await get_tree().process_frame
	
	print("\n=== VERIFYING COMBAT & AUTO-DEPLOY LOGIC ===")
	
	# Verify starter Pokemon was initialized
	var board = GameManager.board_ref
	print("Initial player units on board:", board.count_player_units_on_board())
	assert(board.count_player_units_on_board() >= 1, "Player should start with at least 1 unit on board")
	var starter = board.get_board_units(false)[0]
	print("[PASS] Starter unit present: %s (HP: %f)" % [starter.pokemon_id, starter.current_hp])
	
	# Test buy card - should auto deploy to board if space, or to bench if board full
	GameManager.level = 2 # Increase level to 2 so we have 2 capacity
	GameManager.emit_level_signal()
	var bought = GameManager.buy_card(0)
	assert(bought, "Card purchase should succeed")
	print("[PASS] Bought card. Board units count now: %d" % board.count_player_units_on_board())
	assert(board.count_player_units_on_board() == 2, "Bought unit should auto-deploy onto board when space is open!")
	
	# Start combat
	print("\nStarting combat phase...")
	GameManager.force_start_combat()
	assert(GameManager.current_phase == GameManager.Phase.COMBAT, "Phase should be COMBAT")
	
	var player_units = board.get_board_units(false)
	var enemy_units = []
	for n in get_tree().get_nodes_in_group("units"):
		var u = n as Unit
		if u and u.is_enemy:
			enemy_units.append(u)
			
	print("Player units in battle: %d, Enemy units in battle: %d" % [player_units.size(), enemy_units.size()])
	assert(player_units.size() >= 1, "Player must have units fighting on the board")
	assert(enemy_units.size() >= 1, "Enemies must have spawned")
	
	# Track damage and movements over 180 frames (3 seconds)
	var initial_enemy_hp = enemy_units[0].current_hp
	var initial_player_hp = player_units[0].current_hp
	var initial_enemy_pos = enemy_units[0].position
	var initial_player_pos = player_units[0].position
	
	var damage_dealt = false
	var units_moved = false
	
	for frame in range(180):
		await get_tree().process_frame
		
		# Check if units moved
		if not units_moved:
			if is_instance_valid(player_units[0]) and player_units[0].position != initial_player_pos:
				units_moved = true
			if is_instance_valid(enemy_units[0]) and enemy_units[0].position != initial_enemy_pos:
				units_moved = true
				
		# Check if damage was exchanged
		if not damage_dealt:
			if is_instance_valid(enemy_units[0]) and enemy_units[0].current_hp < initial_enemy_hp:
				damage_dealt = true
			if is_instance_valid(player_units[0]) and player_units[0].current_hp < initial_player_hp:
				damage_dealt = true

	print("[PASS] Units moved autonomously towards each other: %s" % units_moved)
	assert(units_moved, "Units MUST move autonomously towards targets!")
	
	print("[PASS] Units attacked and dealt damage: %s" % damage_dealt)
	assert(damage_dealt, "Units MUST attack and deal damage!")
	
	print("\n=== ALL AUTO-COMBAT & ENGAGEMENT TESTS PASSED! ===")
	get_tree().quit(0)
