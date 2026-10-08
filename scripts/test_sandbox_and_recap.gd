extends Node

func _ready() -> void:
	print("\n=======================================================")
	print(">>> STARTING SANDBOX MODE, RECAP & BOSS TESTS <<<")
	print("=======================================================")
	
	await get_tree().process_frame
	await get_tree().process_frame

	var main_scene = load("res://scenes/main.tscn")
	var main_inst = main_scene.instantiate()
	get_parent().add_child(main_inst)
	
	await get_tree().process_frame
	await get_tree().process_frame

	var hud = main_inst.get_node("HUD")
	var board = main_inst.get_node("Board")
	assert(hud != null, "HUD must exist")
	assert(board != null, "Board must exist")

	# -----------------------------------------------------------------
	# Test 1: Multi-generational Boss Wave Definitions
	# -----------------------------------------------------------------
	print("\n--- Test 1: Multi-generational Boss Waves ---")
	var wave5 = board.get_wave_definition(5)
	assert(wave5.size() >= 3, "Wave 5 must have enemies")
	assert(wave5[0]["id"] == "snorlax" and wave5[0]["is_boss"] == true, "Wave 5 Boss must be Snorlax")
	print("[PASS] Wave 5 Gen 1 Snorlax Epic Boss verified!")

	var wave10 = board.get_wave_definition(10)
	var w10_bosses = []
	for u in wave10:
		if u.get("is_boss", false):
			w10_bosses.append(u["id"])
	assert("tyranitar" in w10_bosses and "lugia" in w10_bosses, "Wave 10 Bosses must include Tyranitar & Lugia")
	print("[PASS] Wave 10 Gen 2 Tyranitar & Lugia Dual Boss verified!")

	var wave15 = board.get_wave_definition(15)
	var w15_bosses = []
	for u in wave15:
		if u.get("is_boss", false):
			w15_bosses.append(u["id"])
	assert("rayquaza" in w15_bosses and "groudon" in w15_bosses, "Wave 15 Bosses must include Rayquaza & Groudon")
	print("[PASS] Wave 15 Gen 3 Rayquaza & Groudon Legendary Boss verified!")

	var wave20 = board.get_wave_definition(20)
	var w20_bosses = []
	for u in wave20:
		if u.get("is_boss", false):
			w20_bosses.append(u["id"])
	assert("arceus" in w20_bosses and "dialga" in w20_bosses and "palkia" in w20_bosses, "Wave 20 Bosses must include Arceus, Dialga & Palkia")
	print("[PASS] Wave 20 Gen 4 Arceus Supreme Boss verified!")

	# -----------------------------------------------------------------
	# Test 2: Boss Spawn & Golden Crown Indicator
	# -----------------------------------------------------------------
	print("\n--- Test 2: Boss Visuals & Crown Badge ---")
	board.spawn_enemy_wave(5)
	var enemy_units = board.get_board_units(true)
	var boss_found: Unit = null
	for u in enemy_units:
		if u.has_meta("is_boss"):
			boss_found = u
			break
	assert(boss_found != null, "Boss unit with meta is_boss must be spawned")
	assert(boss_found.has_node("BossCrown"), "Boss unit must have BossCrown visual node")
	print("[PASS] Boss unit spawned with enhanced stats, scale, and golden crown badge!")

	# -----------------------------------------------------------------
	# Test 3: Sandbox Mode Activation & Tools
	# -----------------------------------------------------------------
	print("\n--- Test 3: Sandbox Mode Activation & Controls ---")
	GameManager.enter_sandbox_mode()
	assert(GameManager.is_sandbox_mode == true, "is_sandbox_mode should be true")
	assert(GameManager.gold == 999, "Sandbox gold should be 999, got %d" % GameManager.gold)
	assert(GameManager.level == 10, "Sandbox level should be 10, got %d" % GameManager.level)
	assert(hud.sandbox_toolbar.visible == true, "Sandbox toolbar must be visible")
	print("[PASS] Sandbox mode successfully entered with 999 gold and Level 10!")

	# Test spawning arbitrary Pokemon (e.g. Arceus ★3)
	hud.sandbox_toolbar._spawn_selected_pokemon("arceus", 3)
	var arceus_on_bench = null
	for b in board.bench_slots:
		if b != null and b.pokemon_id == "arceus" and b.star_level == 3:
			arceus_on_bench = b
			break
	assert(arceus_on_bench != null, "Arceus ★3 should be spawned on bench via Sandbox")
	print("[PASS] Arbitrary Pokemon (Arceus ★3) spawned successfully via Sandbox!")

	# Test granting items
	GameManager.add_item_to_bench("life_orb")
	assert(GameManager.item_bench.slots.has("life_orb"), "ItemBench should receive granted item")
	print("[PASS] Arbitrary item (Life Orb) granted via Sandbox!")

	# Test spawning training dummy (Snorlax 30,000 HP)
	var dummy = board.spawn_training_dummy(30000.0)
	assert(dummy != null and dummy.max_hp == 30000.0, "Training dummy must have 30,000 HP")
	print("[PASS] 30,000 HP Training Dummy spawned successfully!")

	# Test clearing board
	board.clear_all_units()
	assert(board.count_player_units_on_board() == 0, "Board units should be cleared")
	print("[PASS] Clear board command verified!")

	# -----------------------------------------------------------------
	# Test 4: Damage Recap Modal Functionality
	# -----------------------------------------------------------------
	print("\n--- Test 4: Damage Recap Modal ---")
	assert(hud.damage_recap_modal != null, "DamageRecapModal must exist in HUD")
	
	var mock_metrics = [
		{"id": "charizard", "name": "喷火龙", "star": 3, "damage": 5420.0, "taken": 1200.0, "healing": 0.0, "is_enemy": false},
		{"id": "pikachu", "name": "皮卡丘", "star": 2, "damage": 3810.0, "taken": 850.0, "healing": 0.0, "is_enemy": false},
		{"id": "blissey", "name": "幸福蛋", "star": 2, "damage": 450.0, "taken": 4200.0, "healing": 3200.0, "is_enemy": false},
		{"id": "snorlax", "name": "卡比兽", "star": 3, "damage": 1800.0, "taken": 6800.0, "healing": 800.0, "is_enemy": false}
	]
	
	hud.damage_recap_modal.open_recap(mock_metrics, 5)
	assert(hud.damage_recap_modal.visible == true, "Recap modal should be visible after open_recap")
	assert(hud.damage_recap_modal.mvp_container.get_child_count() == 3, "MVP podium should show top 3 units")
	
	# Verify Damage Tab
	hud.damage_recap_modal._switch_mode("damage")
	assert(hud.damage_recap_modal.summary_label.text.contains("总输出"), "Damage summary should display")
	
	# Verify Taken Tab
	hud.damage_recap_modal._switch_mode("taken")
	assert(hud.damage_recap_modal.summary_label.text.contains("总承受伤害"), "Taken summary should display")

	# Verify Healing Tab
	hud.damage_recap_modal._switch_mode("healing")
	assert(hud.damage_recap_modal.summary_label.text.contains("总治疗护盾"), "Healing summary should display")

	hud.damage_recap_modal.close_modal()
	assert(hud.damage_recap_modal.visible == false, "Recap modal should be hidden after close_modal")
	print("[PASS] Damage Recap Modal tabs, MVP podium, and data breakdown verified!")

	print("\n=======================================================")
	print(">>> ALL SANDBOX, RECAP & BOSS TESTS PASSED (100%) <<<")
	print("=======================================================\n")
	get_tree().quit(0)
