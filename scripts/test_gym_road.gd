extends Node

# test_gym_road.gd: Automated tests for Gym Battle Road (Module 3)
# Covers 8 gym data validity, badge case & star rating, GameManager mode loading, and modal UI display.

func _ready() -> void:
	print("\n========================================================")
	print(">>> STARTING GYM BATTLE ROAD AUTOMATED TESTS (MODULE 3) <<<")
	print("========================================================\n")
	
	# Wait for autoloads to settle
	await get_tree().process_frame
	
	test_gym_stages_and_lineup_validity()
	test_star_ratings_and_badge_records()
	test_game_manager_mode_integration()
	test_modal_ui_and_badge_case()
	
	print("\n========================================================")
	print(">>> ALL GYM BATTLE ROAD TESTS PASSED (100%)!        <<<")
	print("========================================================\n")
	
	get_tree().quit(0)

func test_gym_stages_and_lineup_validity() -> void:
	print("--- Test 1: 8 Gym Stages Configuration & Lineup Validity ---")
	
	assert(GymRoadManager != null, "GymRoadManager singleton must be available")
	var count = GymRoadManager.get_gym_count()
	assert(count == 8, "Must have exactly 8 gym stages configured, got %d" % count)
	print("[PASS] Exactly 8 gym challenge stages registered.")
	
	var expected_gyms = [
		{"index": 0, "leader": "小刚", "type": "Rock", "ace": "onix"},
		{"index": 1, "leader": "小霞", "type": "Water", "ace": "starmie"},
		{"index": 2, "leader": "马志士", "type": "Electric", "ace": "raichu"},
		{"index": 3, "leader": "莉佳", "type": "Grass", "ace": "vileplume"},
		{"index": 4, "leader": "阿桔", "type": "Poison", "ace": "weezing"},
		{"index": 5, "leader": "娜姿", "type": "Psychic", "ace": "alakazam"},
		{"index": 6, "leader": "夏伯", "type": "Fire", "ace": "arcanine"},
		{"index": 7, "leader": "竹兰", "type": "Dragon", "ace": "garchomp"}
	]
	
	for exp_info in expected_gyms:
		var idx = exp_info["index"]
		var g = GymRoadManager.get_gym_data(idx)
		assert(not g.is_empty(), "Gym index %d must have valid data" % idx)
		assert(exp_info["leader"] in g.get("leader", ""), "Gym %d leader mismatch: expected %s, got %s" % [idx, exp_info["leader"], g.get("leader", "")])
		assert(g.get("type", "") == exp_info["type"], "Gym %d type mismatch: expected %s, got %s" % [idx, exp_info["type"], g.get("type", "")])
		assert(g.get("ace_id", "") == exp_info["ace"], "Gym %d ace mismatch: expected %s, got %s" % [idx, exp_info["ace"], g.get("ace_id", "")])
		assert(g.has("badge_name") and g["badge_name"] != "", "Gym %d must have badge name" % idx)
		assert(g.has("badge_icon") and g["badge_icon"] != "", "Gym %d must have badge icon" % idx)
		
		# Verify lineup
		var lineup: Array = g.get("lineup", [])
		assert(lineup.size() >= 3, "Gym %d must have at least 3 pokemons in lineup" % idx)
		var has_boss = false
		for unit_cfg in lineup:
			var pid = unit_cfg.get("id", "")
			assert(PokemonDatabase.pokemons.has(pid), "Gym %d pokemon '%s' must exist in PokemonDatabase" % [idx, pid])
			var star = unit_cfg.get("star", 1)
			assert(star >= 1 and star <= 3, "Gym %d unit '%s' star level must be 1..3, got %d" % [idx, pid, star])
			var coord: Vector2i = unit_cfg.get("coord", Vector2i(-1, -1))
			assert(coord.x >= 0 and coord.x < 8, "Gym %d unit coord.x must be 0..7, got %d" % [idx, coord.x])
			assert(coord.y >= 0 and coord.y <= 2, "Gym %d unit coord.y must be 0..2 (enemy half), got %d" % [idx, coord.y])
			if unit_cfg.get("is_boss", false):
				has_boss = true
		assert(has_boss, "Gym %d must have at least one boss unit designated" % idx)
		print("[PASS] Gym %d (%s • %s) validated with %d pokemons and boss!" % [idx + 1, g["name"], g["badge_name"], lineup.size()])

func test_star_ratings_and_badge_records() -> void:
	print("\n--- Test 2: Star Rating System & Badge Case Record Logic ---")
	
	# Test Star Calculation Rules:
	# ★1: > 0 HP
	# ★2: >= 50 HP
	# ★3: >= 80 HP
	assert(GymRoadManager.calculate_stars(100) == 3, "100 HP should be 3 stars")
	assert(GymRoadManager.calculate_stars(80) == 3, "80 HP should be 3 stars")
	assert(GymRoadManager.calculate_stars(79) == 2, "79 HP should be 2 stars")
	assert(GymRoadManager.calculate_stars(50) == 2, "50 HP should be 2 stars")
	assert(GymRoadManager.calculate_stars(49) == 1, "49 HP should be 1 star")
	assert(GymRoadManager.calculate_stars(1) == 1, "1 HP should be 1 star")
	assert(GymRoadManager.calculate_stars(0) == 0, "0 HP should be 0 stars")
	assert(GymRoadManager.calculate_stars(-10) == 0, "Negative HP should be 0 stars")
	print("[PASS] Star evaluation algorithm verified (★1: >0, ★2: ≥50, ★3: ≥80).")
	
	# Reset progress for clean testing
	GymRoadManager.reset_progress()
	assert(GymRoadManager.get_total_unlocked_badges() == 0, "Initially 0 badges should be unlocked")
	assert(GymRoadManager.get_total_stars() == 0, "Initially 0 stars should be unlocked")
	
	# Test settlement on Brock (Gym 0)
	var res1 = GymRoadManager.settle_gym_battle(0, true, 35) # 1 star
	assert(res1["won"] == true, "Battle 1 should be recorded as won")
	assert(res1["stars"] == 1, "35 HP should give 1 star")
	assert(res1["newly_unlocked"] == true, "Badge should be newly unlocked")
	
	var rec0 = GymRoadManager.get_badge_record(0)
	assert(rec0["unlocked"] == true, "Gym 0 badge must be unlocked")
	assert(rec0["best_stars"] == 1, "Gym 0 best stars should be 1")
	assert(rec0["best_hp"] == 35, "Gym 0 best HP should be 35")
	assert(rec0["cleared_count"] == 1, "Gym 0 cleared count should be 1")
	print("[PASS] Gym 0 first victory: 1 Star unlocked with 35 HP.")
	
	# Settle again with higher HP (60 -> 2 stars)
	var res2 = GymRoadManager.settle_gym_battle(0, true, 60)
	assert(res2["stars"] == 2, "60 HP should give 2 stars")
	assert(res2["newly_unlocked"] == false, "Badge was already unlocked")
	rec0 = GymRoadManager.get_badge_record(0)
	assert(rec0["best_stars"] == 2, "Best stars should be updated to 2")
	assert(rec0["best_hp"] == 60, "Best HP should be updated to 60")
	assert(rec0["cleared_count"] == 2, "Cleared count should be 2")
	print("[PASS] Gym 0 score improved to 2 Stars with 60 HP.")
	
	# Settle again with 3 stars (90 -> 3 stars)
	GymRoadManager.settle_gym_battle(0, true, 90)
	rec0 = GymRoadManager.get_badge_record(0)
	assert(rec0["best_stars"] == 3, "Best stars should be 3")
	assert(rec0["best_hp"] == 90, "Best HP should be 90")
	
	# Settle with lower HP (20 HP -> 1 star): best_stars must NOT downgrade
	GymRoadManager.settle_gym_battle(0, true, 20)
	rec0 = GymRoadManager.get_badge_record(0)
	assert(rec0["best_stars"] == 3, "Best stars must remain 3 even if subsequent run got 1 star")
	assert(rec0["cleared_count"] == 4, "Cleared count should be 4")
	print("[PASS] Gym 0 best star retention verified (maintained 3 stars after lower HP run).")
	
	# Settle Misty (Gym 1) with defeat
	var res_loss = GymRoadManager.settle_gym_battle(1, false, 0)
	assert(res_loss["won"] == false, "Loss should be recorded as not won")
	var rec1 = GymRoadManager.get_badge_record(1)
	assert(rec1["unlocked"] == false, "Defeat should not unlock badge")
	
	# Settle Misty with 3-star victory
	GymRoadManager.settle_gym_battle(1, true, 85)
	rec1 = GymRoadManager.get_badge_record(1)
	assert(rec1["unlocked"] == true, "Gym 1 badge must now be unlocked")
	assert(rec1["best_stars"] == 3, "Gym 1 best stars should be 3")
	
	assert(GymRoadManager.get_total_unlocked_badges() == 2, "Should have 2 unlocked badges")
	assert(GymRoadManager.get_total_stars() == 6, "Should have 6 total stars (3 + 3)")
	print("[PASS] Badge Case totals verified: 2 badges, 6 stars.")
	
	# Test save and load persistence
	GymRoadManager.save_progress()
	GymRoadManager.load_progress()
	assert(GymRoadManager.get_total_unlocked_badges() == 2, "Persistence should retain 2 badges")
	assert(GymRoadManager.get_total_stars() == 6, "Persistence should retain 6 stars")
	print("[PASS] Save/load persistence verified.")

func test_game_manager_mode_integration() -> void:
	print("\n--- Test 3: GameManager Mode Launch & Level Loading Integration ---")
	
	# Test enter_gym_road_mode for Gym 0 (Brock)
	GameManager.enter_gym_road_mode(0)
	assert(GameManager.is_gym_road_mode == true, "GameManager.is_gym_road_mode should be true")
	assert(GameManager.active_gym_index == 0, "GameManager.active_gym_index should be 0")
	assert(GymRoadManager.is_gym_battle_active() == true, "GymRoadManager battle should be active")
	assert(GameManager.player_hp == 100, "Player HP should start at 100")
	assert(GameManager.level == 3, "Brock Gym starting level should be 3")
	assert(GameManager.gold == 26, "Brock Gym starting gold should be 26")
	assert(GameManager.current_phase == GameManager.Phase.PREPARATION, "Phase should be PREPARATION")
	
	# Verify wave definition
	var wave_def = GymRoadManager.get_current_gym_wave_definition()
	assert(wave_def.size() == 4, "Brock lineup should contain 4 units")
	assert(wave_def[0]["id"] == "onix", "First unit in Brock lineup should be onix")
	print("[PASS] Gym 0 (Brock) loaded: level 3, 26 gold, 4 units.")
	
	# Test enter_gym_road_mode for Gym 7 (Cynthia)
	GameManager.enter_gym_road_mode(7)
	assert(GameManager.active_gym_index == 7, "Active gym index should be 7")
	assert(GameManager.level == 9, "Cynthia Gym starting level should be 9")
	assert(GameManager.gold == 95, "Cynthia Gym starting gold should be 95")
	var cynthia_lineup = GymRoadManager.get_current_gym_wave_definition()
	assert(cynthia_lineup.size() == 6, "Cynthia lineup should contain 6 units")
	assert(cynthia_lineup[0]["id"] == "garchomp", "Cynthia ace should be garchomp")
	print("[PASS] Gym 7 (Cynthia) loaded: level 9, 95 gold, 6 units.")
	
	# Test victory auto-settlement in GameManager
	GameManager.current_phase = GameManager.Phase.COMBAT
	GameManager.player_hp = 88
	GameManager.resolve_combat(true, 0)
	
	assert(GameManager.current_phase == GameManager.Phase.VICTORY, "Player victory should transition to VICTORY phase")
	var cynthia_rec = GymRoadManager.get_badge_record(7)
	assert(cynthia_rec["unlocked"] == true, "Cynthia badge should be unlocked upon victory")
	assert(cynthia_rec["best_stars"] == 3, "88 HP victory should award 3 stars")
	print("[PASS] Combat victory settlement automatically awarded Cynthia Champion Crest and 3 stars!")
	
	# Test defeat auto-settlement
	GameManager.enter_gym_road_mode(3) # Erika
	GameManager.current_phase = GameManager.Phase.COMBAT
	GameManager.player_hp = 5
	GameManager.resolve_combat(false, 3) # take lethal damage
	assert(GameManager.current_phase == GameManager.Phase.GAME_OVER, "Lethal defeat should transition to GAME_OVER")
	var erika_rec = GymRoadManager.get_badge_record(3)
	assert(erika_rec["unlocked"] == false, "Defeat should leave Erika badge locked")
	print("[PASS] Combat defeat settlement verified: GAME_OVER and badge remains locked.")
	
	# Reset back to standard game
	GameManager.start_new_game()
	assert(GameManager.is_gym_road_mode == false, "Standard game should clear gym mode")
	assert(GymRoadManager.is_gym_battle_active() == false, "Gym battle should be inactive")
	print("[PASS] Reset to standard game properly clears gym mode.")

func test_modal_ui_and_badge_case() -> void:
	print("\n--- Test 4: Modal UI Opening, Card Selection & Badge Case Rendering ---")
	
	var modal_scene = load("res://scenes/gym_road_modal.tscn")
	assert(modal_scene != null, "scenes/gym_road_modal.tscn must be loadable")
	var modal = modal_scene.instantiate()
	add_child(modal)
	
	assert(modal.visible == false, "Modal should initially be hidden")
	modal.open_modal()
	assert(modal.visible == true, "Modal should be visible after open_modal()")
	
	# Check Badge Slots
	assert(modal.badge_slots.size() == 8, "Badge Case must have exactly 8 badge slots, got %d" % modal.badge_slots.size())
	
	# Check Gym Cards
	assert(modal.gym_cards.size() == 8, "Gym Card list must have exactly 8 cards, got %d" % modal.gym_cards.size())
	
	# Verify Gym 0 Slot (Unlocked with 3 stars)
	var slot0 = modal.badge_slots[0]
	var star_lbl0 = slot0.get_node("VBox/StarLabel") as Label
	assert(star_lbl0.text == "★★★", "Gym 0 slot must show ★★★, got %s" % star_lbl0.text)
	
	# Verify Gym 2 Slot (Locked)
	var slot2 = modal.badge_slots[2]
	var star_lbl2 = slot2.get_node("VBox/StarLabel") as Label
	var info_lbl2 = slot2.get_node("VBox/InfoLabel") as Label
	assert(star_lbl2.text == "☆☆☆", "Gym 2 slot must show ☆☆☆")
	assert(info_lbl2.text == "未解锁", "Gym 2 slot info must show '未解锁'")
	print("[PASS] Badge Case UI properly differentiates unlocked vs locked badges.")
	
	# Test challenge button on Gym 2 (Lt. Surge)
	modal._on_challenge_pressed(2)
	assert(GameManager.is_gym_road_mode == true, "Clicking challenge should activate gym mode")
	assert(GameManager.active_gym_index == 2, "Clicking challenge should select gym index 2")
	assert(modal.visible == false, "Modal should close upon starting challenge")
	print("[PASS] Challenge button correctly initiates gym challenge and closes modal.")
	
	# Test reopen and close
	modal.open_modal()
	assert(modal.visible == true, "Modal re-opened successfully")
	modal.hide_modal()
	assert(modal.visible == false, "hide_modal() properly hides modal")
	print("[PASS] Modal open/hide lifecycle verified.")
	
	modal.queue_free()
	# Clean up any test save files
	GymRoadManager.reset_progress()
	print("[PASS] Cleaned up UI modal instance and reset test progress.")
