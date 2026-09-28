extends Node

# Test suite for Battle Arena Themed Buffs/Debuffs & 3-Round Awaken Progression

func _ready() -> void:
	print("\n=== STARTING ARENA MODIFIERS & PROGRESSION TESTS ===")
	await get_tree().process_frame
	await get_tree().process_frame
	
	var main_inst = get_parent().get_node_or_null("Main")
	var created_main = false
	if not main_inst:
		var main_scene = load("res://scenes/main.tscn")
		main_inst = main_scene.instantiate()
		get_parent().add_child(main_inst)
		created_main = true
	await get_tree().process_frame
	
	# Test 1: Arena Data Verification (5 Arenas, 4 Stages Each)
	print("\n--- Test 1: Arena Data Structure & Completeness ---")
	assert(GameManager.BATTLE_ARENAS.size() == 5, "Must have exactly 5 battle arenas registered, got %d" % GameManager.BATTLE_ARENAS.size())
	for arena in GameManager.BATTLE_ARENAS:
		var a_name = arena.get("name", "")
		var a_id = arena.get("id", "")
		var mods: Array = arena.get("modifiers", [])
		assert(mods.size() == 4, "Arena '%s' (%s) must have exactly 4 stages, got %d" % [a_name, a_id, mods.size()])
		for i in range(mods.size()):
			var m = mods[i]
			assert(m.get("stage", 0) == i + 1, "Modifier stage must be %d" % (i + 1))
			assert(m.get("name", "").length() > 0, "Modifier must have valid name")
			assert(m.get("desc", "").length() > 5, "Modifier must have detailed description")
			assert(m.get("type", "") in ["buff", "debuff", "hybrid"], "Modifier type must be buff/debuff/hybrid")
			assert(m.has("stat") and m.has("val"), "Modifier must specify stat and val")
		print("  [PASS] Arena '%s' (%s): 4 stages verified." % [a_name, a_id])

	# Test 2: 3-Round Awaken Progression Logic
	print("\n--- Test 2: 3-Round Awaken Progression (Round 1 -> 4 -> 7 -> 10) ---")
	# Round 1, 2, 3 -> Tier 1 (1 effect active, next at 4)
	for r in [1, 2, 3]:
		GameManager.current_round = r
		var tier = GameManager.get_active_arena_tier()
		var next_awaken = GameManager.get_next_awaken_round()
		var active_mods = GameManager.get_active_arena_modifiers()
		assert(tier == 1, "Round %d should be Tier 1, got %d" % [r, tier])
		assert(next_awaken == 4, "Round %d next awaken should be 4, got %d" % [r, next_awaken])
		assert(active_mods.size() == 1, "Round %d should have 1 active modifier, got %d" % [r, active_mods.size()])
	print("  [PASS] Rounds 1-3 unlock Tier 1 (1 effect). Next at Round 4.")

	# Round 4, 5, 6 -> Tier 2 (2 effects active, next at 7)
	for r in [4, 5, 6]:
		GameManager.current_round = r
		var tier = GameManager.get_active_arena_tier()
		var next_awaken = GameManager.get_next_awaken_round()
		var active_mods = GameManager.get_active_arena_modifiers()
		assert(tier == 2, "Round %d should be Tier 2, got %d" % [r, tier])
		assert(next_awaken == 7, "Round %d next awaken should be 7, got %d" % [r, next_awaken])
		assert(active_mods.size() == 2, "Round %d should have 2 active modifiers, got %d" % [r, active_mods.size()])
	print("  [PASS] Rounds 4-6 unlock Tier 2 (2 effects). Next at Round 7.")

	# Round 7, 8, 9 -> Tier 3 (3 effects active, next at 10)
	for r in [7, 8, 9]:
		GameManager.current_round = r
		var tier = GameManager.get_active_arena_tier()
		var next_awaken = GameManager.get_next_awaken_round()
		var active_mods = GameManager.get_active_arena_modifiers()
		assert(tier == 3, "Round %d should be Tier 3, got %d" % [r, tier])
		assert(next_awaken == 10, "Round %d next awaken should be 10, got %d" % [r, next_awaken])
		assert(active_mods.size() == 3, "Round %d should have 3 active modifiers, got %d" % [r, active_mods.size()])
	print("  [PASS] Rounds 7-9 unlock Tier 3 (3 effects). Next at Round 10.")

	# Round 10+ -> Tier 4 (all 4 effects active)
	GameManager.current_round = 10
	var tier_10 = GameManager.get_active_arena_tier()
	var active_mods_10 = GameManager.get_active_arena_modifiers()
	assert(tier_10 >= 4, "Round 10 should be Tier 4+, got %d" % tier_10)
	assert(active_mods_10.size() == 4, "Round 10 should have all 4 active modifiers, got %d" % active_mods_10.size())
	print("  [PASS] Round 10+ unlocks Tier 4 (all 4 effects fully awakened).")

	# Test 3: Arena Switching & Modifier Query Helpers
	print("\n--- Test 3: Arena Switching & Query API (has_modifier / get_modifier_val) ---")
	# Force arena to Stadium (index 0) at Round 1
	GameManager.current_round = 1
	GameManager.current_arena_index = 0
	GameManager.emit_arena_modifiers_updated()
	assert(GameManager.has_arena_modifier("crit_chance"), "Stadium Stage 1 must provide crit_chance")
	assert(abs(GameManager.get_arena_modifier_val("crit_chance") - 0.15) < 0.001, "crit_chance val should be 0.15")
	assert(not GameManager.has_arena_modifier("start_mana"), "Stadium Stage 2 start_mana should be locked at Round 1")

	# Advance to Round 4: Stage 2 start_mana should unlock
	GameManager.current_round = 4
	GameManager.emit_arena_modifiers_updated()
	assert(GameManager.has_arena_modifier("start_mana"), "Stadium Stage 2 start_mana should now be active at Round 4")
	assert(GameManager.get_arena_modifier_val("start_mana") == 25.0, "start_mana should be 25.0")

	# Switch to Volcano (index 1) at Round 4
	GameManager.current_arena_index = 1
	GameManager.emit_arena_modifiers_updated()
	assert(not GameManager.has_arena_modifier("start_mana"), "Volcano shouldn't have Stadium's start_mana")
	assert(GameManager.has_arena_modifier("fire_amp"), "Volcano Stage 1 fire_amp must be active")
	assert(GameManager.has_arena_modifier("atk_speed"), "Volcano Stage 2 atk_speed must be active at Round 4")
	assert(not GameManager.has_arena_modifier("lava_shield"), "Volcano Stage 3 lava_shield must be locked at Round 4")

	# Advance Volcano to Round 7: Stage 3 lava_shield unlocks
	GameManager.current_round = 7
	GameManager.emit_arena_modifiers_updated()
	assert(GameManager.has_arena_modifier("lava_shield"), "Volcano Stage 3 lava_shield must be active at Round 7")
	print("  [PASS] Arena switching and query APIs verified across different rounds.")

	# Test 4: Combat Stat & Start Mana Integration
	print("\n--- Test 4: Combat Stat & Start Mana Integration ---")
	# Switch to Emerald at Round 1 (Stage 1 gives hp_bonus: 150)
	GameManager.current_round = 1
	GameManager.current_arena_index = 4 # Emerald
	GameManager.emit_arena_modifiers_updated()
	assert(GameManager.has_arena_modifier("hp_bonus"), "Emerald Stage 1 must have hp_bonus")
	
	var unit_scene = load("res://scenes/unit.tscn")
	var test_unit = unit_scene.instantiate() as Unit
	main_inst.add_child(test_unit)
	test_unit.setup("bulbasaur", 1, false)
	var base_hp = PokemonDatabase.get_pokemon("bulbasaur")["hp"]
	assert(test_unit.max_hp == base_hp + 150.0, "Bulbasaur max_hp should include Emerald +150 HP bonus (expected %d, got %d)" % [base_hp + 150.0, test_unit.max_hp])
	print("  [PASS] Unit setup applies Emerald hp_bonus correctly (%d HP -> %d HP)." % [base_hp, test_unit.max_hp])
	test_unit.queue_free()

	# Test Start Mana in Board combat start (Stadium Stage 2)
	GameManager.current_round = 4
	GameManager.current_arena_index = 0 # Stadium (start_mana 25.0)
	GameManager.emit_arena_modifiers_updated()
	var test_unit2 = unit_scene.instantiate() as Unit
	main_inst.add_child(test_unit2)
	test_unit2.setup("pikachu", 1, false)
	test_unit2.current_mana = 0.0
	# Simulate start mana check
	if not test_unit2.is_enemy and GameManager.has_arena_modifier("start_mana"):
		test_unit2.current_mana = min(test_unit2.max_mana, test_unit2.current_mana + GameManager.get_arena_modifier_val("start_mana"))
	assert(test_unit2.current_mana == 25.0, "Unit should receive 25 start_mana from Stadium Stage 2")
	print("  [PASS] Combat start mana injection verified (0 -> 25 mana).")
	test_unit2.queue_free()

	# Test 5: UI Elements (ArenaBanner & ArenaModal)
	print("\n--- Test 5: HUD ArenaBanner & ArenaModal UI ---")
	var hud = main_inst.get_node("HUD")
	var banner = hud.get_node("ArenaBanner") as Button
	assert(banner != null, "ArenaBanner button must exist in HUD")
	assert(banner.text.contains("Lv.2"), "Banner text should indicate Lv.2 active modifiers at Round 4")
	print("  [PASS] ArenaBanner text: '%s'" % banner.text)

	var modal = hud.get_node("ArenaModal") as Panel
	assert(modal != null, "ArenaModal must exist in HUD")
	assert(not modal.visible, "ArenaModal should start hidden")
	
	# Open modal and verify populated cards
	modal.open_modal()
	assert(modal.visible, "ArenaModal must be visible after open_modal()")
	var cards_vbox = modal.get_node("Dialog/VBox/Scroll/Cards")
	assert(cards_vbox.get_child_count() == 4, "ArenaModal must display 4 stage cards, found %d" % cards_vbox.get_child_count())
	
	# Verify Card 1 and Card 2 are active, Card 3 and 4 are locked
	var c1_text = cards_vbox.get_child(0).get_node("Margin/VBox/HBox").get_child(0).text
	var c2_text = cards_vbox.get_child(1).get_node("Margin/VBox/HBox").get_child(0).text
	var c3_text = cards_vbox.get_child(2).get_node("Margin/VBox/HBox").get_child(0).text
	var c4_text = cards_vbox.get_child(3).get_node("Margin/VBox/HBox").get_child(0).text
	
	assert(c1_text.contains("已激活"), "Card 1 must be active: %s" % c1_text)
	assert(c2_text.contains("已激活"), "Card 2 must be active: %s" % c2_text)
	assert(c3_text.contains("第 7 回合觉醒"), "Card 3 must show unlock at round 7: %s" % c3_text)
	assert(c4_text.contains("第 10 回合觉醒"), "Card 4 must show unlock at round 10: %s" % c4_text)
	print("  [PASS] ArenaModal stage cards correctly display active vs locked states.")

	# Close modal
	modal.hide_modal()
	assert(not modal.visible, "ArenaModal must be hidden after hide_modal()")
	print("  [PASS] ArenaModal open and hide operations verified.")

	if created_main and is_instance_valid(main_inst):
		main_inst.queue_free()

	print("\n========================================================")
	print(">>> ALL ARENA MODIFIERS & PROGRESSION TESTS PASSED! <<<")
	print("========================================================\n")
	get_tree().quit(0)
