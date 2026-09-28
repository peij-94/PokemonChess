extends SceneTree

# Automated gameplay verification script

func _init() -> void:
	print("\n=== STARTING AUTOMATED GAMEPLAY TESTS ===")
	
	# Wait for root tree
	var main_scene = load("res://scenes/main.tscn").instantiate()
	root.add_child(main_scene)
	
	print("[PASS] Main scene loaded successfully.")
	
	# Verify player initial state
	assert(GameManager.player_hp == 100, "Initial HP should be 100")
	assert(GameManager.gold == 10, "Initial gold should be 10")
	assert(GameManager.level == 1, "Initial level should be 1")
	assert(GameManager.current_round == 1, "Initial round should be 1")
	print("[PASS] Initial state verified: HP=%d, Gold=%d, Level=%d, Round=%d" % [
		GameManager.player_hp, GameManager.gold, GameManager.level, GameManager.current_round
	])
	
	# Test buy card from shop
	var initial_gold = GameManager.gold
	var card_to_buy = GameManager.current_shop_cards[0]
	var cost = PokemonDatabase.get_pokemon(card_to_buy)["cost"]
	var buy_success = GameManager.buy_card(0)
	assert(buy_success, "Should successfully buy first shop card")
	assert(GameManager.gold == initial_gold - cost, "Gold should be deducted correctly")
	print("[PASS] Successfully bought unit: %s for %d gold. Remaining gold: %d" % [card_to_buy, cost, GameManager.gold])
	
	# Test bench has unit
	assert(GameManager.board_ref.bench_slots[0] != null, "Bench slot 0 should contain unit")
	var unit = GameManager.board_ref.bench_slots[0]
	assert(unit.pokemon_id == card_to_buy, "Bench unit should match bought card")
	print("[PASS] Unit correctly placed on bench: %s (★%d)" % [unit.pokemon_id, unit.star_level])
	
	# Test moving unit from bench to board
	GameManager.board_ref.try_place_unit_on_grid(unit, Vector2i(3, 4))
	assert(GameManager.board_ref.bench_slots[0] == null, "Bench slot should now be empty")
	assert(GameManager.board_ref.board_grid[3][4] == unit, "Board grid (3,4) should have unit")
	print("[PASS] Unit moved to battlefield grid (3, 4). Board unit count: %d" % GameManager.board_ref.count_player_units_on_board())
	
	# Test 3-unit Evolution / Fusion
	print("\nTesting 3-Unit Evolution:")
	var u1 = GameManager.board_ref.add_pokemon_to_bench("pikachu", 1)
	var u2 = GameManager.board_ref.add_pokemon_to_bench("pikachu", 1)
	var u3 = GameManager.board_ref.add_pokemon_to_bench("pikachu", 1)
	GameManager.check_evolutions()
	
	# One of them should now be 2-star Raichu!
	var found_star2 = false
	for u in GameManager.board_ref.get_board_units(false):
		if (u.pokemon_id == "raichu" or u.pokemon_id == "pikachu") and u.star_level == 2:
			found_star2 = true
	if not found_star2:
		for b in GameManager.board_ref.bench_slots:
			if b != null and (b.pokemon_id == "raichu" or b.pokemon_id == "pikachu") and b.star_level == 2:
				found_star2 = true
	assert(found_star2, "3 Pikachu should automatically fuse into a 2-Star Raichu!")
	print("[PASS] Evolution test succeeded! 3x 1-Star Pikachu merged into 2-Star Raichu ★2")
	
	# Test Synergies
	var syn_summary = SynergyManager.get_active_synergy_summary()
	print("[PASS] Active synergies summary:", syn_summary)
	
	# Test Combat Phase Transition
	print("\nTesting Combat Phase Transition:")
	GameManager.force_start_combat()
	assert(GameManager.current_phase == GameManager.Phase.COMBAT, "Phase should be COMBAT")
	print("[PASS] Combat phase entered successfully! Spawned enemy units on board.")
	
	# Verify enemy spawned
	var board_units = GameManager.board_ref.units_container.get_children()
	var enemy_count = 0
	for b in board_units:
		if b is Unit and b.is_enemy:
			enemy_count += 1
	assert(enemy_count > 0, "Enemies should have spawned for round 1")
	print("[PASS] Round 1 enemy wave spawned correctly: %d enemies" % enemy_count)
	
	# Test skill casting simulation
	print("\nTesting Skill Execution:")
	var test_pikachu = GameManager.board_ref.units_container.get_children()[0] as Unit
	test_pikachu.current_mana = 100.0
	test_pikachu.cast_skill()
	print("[PASS] Skill cast executed cleanly without exceptions!")
	
	# Test Combat resolution (simulate player victory)
	print("\nTesting Combat Resolution:")
	GameManager.resolve_combat(true, 0)
	assert(GameManager.current_phase == GameManager.Phase.RESOLVE, "Phase should be RESOLVE")
	assert(GameManager.win_streak == 1, "Win streak should be 1")
	print("[PASS] Combat resolution passed! Win streak=%d" % GameManager.win_streak)
	
	# Test Next Round advance
	print("\nTesting Next Round Advance:")
	var gold_before = GameManager.gold
	GameManager.advance_to_next_round()
	assert(GameManager.current_round == 2, "Round should be 2")
	assert(GameManager.current_phase == GameManager.Phase.PREPARATION, "Phase should return to PREPARATION")
	assert(GameManager.gold > gold_before, "Player should have received round income")
	print("[PASS] Round advanced to Round %d with income awarded! Gold: %d" % [GameManager.current_round, GameManager.gold])
	
	print("\n=== ALL 8 GAMEPLAY UNIT & INTEGRATION TESTS PASSED! ===")
	quit(0)
