extends Node

func _ready() -> void:
	print("\n=== STARTING BATTLE ARENA BACKGROUND TESTS ===")
	await get_tree().process_frame
	await get_tree().process_frame

	# Test 1: Verify battle arenas list in GameManager
	print("\n--- Test 1: BATTLE_ARENAS list and assets validity ---")
	assert(GameManager.BATTLE_ARENAS.size() >= 3, "Must have at least 3 battle backgrounds, got %d" % GameManager.BATTLE_ARENAS.size())
	print("Registered arenas count: %d" % GameManager.BATTLE_ARENAS.size())
	
	for arena in GameManager.BATTLE_ARENAS:
		var p = arena.get("path", "")
		var a_name = arena.get("name", "")
		assert(ResourceLoader.exists(p), "Arena background file must exist: " + p)
		var tex = load(p)
		assert(tex != null, "Arena background texture must load successfully: " + p)
		print("  [PASS] Arena '%s' (%s) loaded successfully. Size: %s" % [a_name, arena.get("id", ""), str(tex.get_size())])

	# Test 2: Random selection on game start
	print("\n--- Test 2: Random background selection distribution ---")
	var counts: Dictionary = {}
	for arena in GameManager.BATTLE_ARENAS:
		counts[arena["path"]] = 0
		
	var iterations = 200
	for i in range(iterations):
		var picked = GameManager.pick_random_background()
		assert(counts.has(picked), "Picked path must be one of the registered backgrounds")
		counts[picked] += 1
		
	print("Simulation over %d match starts:" % iterations)
	for p in counts:
		print("  %s: %d times (%.1f%%)" % [p.get_file(), counts[p], float(counts[p]) / iterations * 100.0])
		assert(counts[p] > 0, "Each background must be chosen at least once!")
	print("[PASS] Random distribution verified across %d game starts!" % iterations)

	# Test 3: Sequential cycling via cycle_background()
	print("\n--- Test 3: Sequential arena cycling ---")
	var initial_idx = GameManager.current_arena_index
	for step in range(GameManager.BATTLE_ARENAS.size()):
		var next_path = GameManager.cycle_background()
		var expected_idx = (initial_idx + 1 + step) % GameManager.BATTLE_ARENAS.size()
		assert(GameManager.current_arena_index == expected_idx, "Current index should cycle cleanly")
		assert(next_path == GameManager.BATTLE_ARENAS[expected_idx]["path"], "Path should match current index")
	print("[PASS] Arena cycling through all %d backgrounds verified!" % GameManager.BATTLE_ARENAS.size())

	# Test 4: Main scene TextureRect integration
	print("\n--- Test 4: Main scene background texture integration ---")
	var main_node = get_parent().get_node_or_null("Main")
	if main_node:
		var tex_rect = main_node.get_node_or_null("Background/BattleBgTexture")
		assert(tex_rect != null, "BattleBgTexture must exist in Main/Background")
		assert(tex_rect.texture != null, "BattleBgTexture must have a loaded texture")
		print("  [PASS] Main/Background/BattleBgTexture is active with texture: %s" % tex_rect.texture.resource_path)

	print("\n==========================================================")
	print(">>> ALL BATTLE ARENA BACKGROUND TESTS PASSED (4/4)! <<<")
	print("==========================================================\n")
	get_tree().quit(0)
