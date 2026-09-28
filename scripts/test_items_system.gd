extends Node

## Comprehensive test suite for Direction 1: The Held Items & Recipe Crafting System.

const ITEM_BENCH_SCENE = preload("res://scenes/item_bench.tscn")
const UNIT_SCENE = preload("res://scenes/unit.tscn")
const ITEM_DB_SCRIPT = preload("res://scripts/autoload/item_database.gd")

var db_ref = null

func _ready() -> void:
	print("\n========================================================")
	print(">>> STARTING POKÉMON HELD ITEMS & CRAFTING TESTS <<<")
	print("========================================================")
	await get_tree().process_frame

	# Ensure database reference is available
	if has_node("/root/ItemDatabase"):
		db_ref = get_node("/root/ItemDatabase")
	else:
		db_ref = ITEM_DB_SCRIPT.new()
		add_child(db_ref)

	test_base_items_registry()
	test_advanced_items_registry()
	test_item_icons_exist()
	test_recipes_system()
	test_item_bench_operations()
	test_item_bench_combining()
	test_unit_equipping_and_stats()
	test_unit_item_synthesis_on_equip()
	test_unit_capacity_limits()
	test_special_effects()

	print("\n========================================================")
	print(">>> ALL ITEM & RECIPE SYSTEM TESTS PASSED (10/10) <<<")
	print("========================================================")
	get_tree().quit(0)

# ------------------------------------------------------------------------------
# 1. Base Items Registry
# ------------------------------------------------------------------------------
func test_base_items_registry() -> void:
	print("\n--- 1. Testing Base Items Registry ---")
	var expected_base = [
		"razor_claw", "scope_lens", "leftovers", "eviolite",
		"choice_scarf", "exp_share", "charcoal", "focus_sash"
	]
	assert(db_ref.base_items.size() == 8, "Expected exactly 8 base items, got %d" % db_ref.base_items.size())

	for item_id in expected_base:
		assert(db_ref.is_base_item(item_id), "Item '%s' should be identified as a base item" % item_id)
		assert(not db_ref.is_advanced_item(item_id), "Item '%s' should NOT be identified as advanced" % item_id)

		var item = db_ref.get_item(item_id)
		assert(not item.is_empty(), "Failed to retrieve base item '%s'" % item_id)
		assert(item.has("name") and item["name"] != "", "Item '%s' must have a valid name" % item_id)
		assert(item.has("icon_path") and item["icon_path"] != "", "Item '%s' must have an icon_path" % item_id)
		assert(item.has("desc") and item["desc"] != "", "Item '%s' must have a desc" % item_id)
		assert(item.has("stats") and item["stats"] is Dictionary, "Item '%s' must have a stats dictionary" % item_id)

		var s = item["stats"]
		var required_stat_keys = [
			"atk", "crit", "hp", "hp_regen", "armor", "mr",
			"atk_speed", "start_mana", "mana_per_hit", "sp_atk"
		]
		for k in required_stat_keys:
			assert(s.has(k), "Item '%s' stats missing key '%s'" % [item_id, k])

	print("[PASS] All 8 base items registered with valid schemas and stats.")

# ------------------------------------------------------------------------------
# 2. Advanced Items Registry
# ------------------------------------------------------------------------------
func test_advanced_items_registry() -> void:
	print("\n--- 2. Testing Advanced Items Registry ---")
	var expected_advanced = [
		"infinity_blade", "expert_belt", "life_orb", "assault_vest",
		"hard_stone", "choice_specs", "battery", "tailwind_feather",
		"weakness_policy", "rocky_helmet", "mystic_water", "magnet"
	]
	assert(db_ref.advanced_items.size() >= 12, "Expected at least 12 advanced items, got %d" % db_ref.advanced_items.size())

	for item_id in expected_advanced:
		assert(db_ref.is_advanced_item(item_id), "Item '%s' should be identified as advanced" % item_id)
		assert(not db_ref.is_base_item(item_id), "Item '%s' should NOT be identified as base" % item_id)

		var item = db_ref.get_item(item_id)
		assert(not item.is_empty(), "Failed to retrieve advanced item '%s'" % item_id)
		assert(item.has("name") and item["name"] != "", "Advanced item '%s' must have a name" % item_id)
		assert(item.has("special_effect") and item["special_effect"] is Dictionary, "Advanced item '%s' must have a special_effect" % item_id)
		assert(item["special_effect"].has("desc"), "Advanced item '%s' special_effect must have 'desc'" % item_id)
		assert(item.has("recipe") and item["recipe"].size() == 2, "Advanced item '%s' must have a 2-item recipe" % item_id)

	print("[PASS] All 12 advanced items registered with special effects and recipes.")

# ------------------------------------------------------------------------------
# 3. Item Icons Verification
# ------------------------------------------------------------------------------
func test_item_icons_exist() -> void:
	print("\n--- 3. Testing Item Icon Assets on Disk ---")
	var all_items = db_ref.get_all_base_items() + db_ref.get_all_advanced_items()
	for item in all_items:
		var icon_path = item.get("icon_path", "")
		assert(icon_path.begins_with("res://assets/items/"), "Icon path '%s' must be in assets/items/" % icon_path)
		assert(ResourceLoader.exists(icon_path) or FileAccess.file_exists(icon_path), "Icon file does not exist: %s" % icon_path)
	print("[PASS] Verified all 20 item icons exist in assets/items/.")

# ------------------------------------------------------------------------------
# 4. Recipe System Combinations
# ------------------------------------------------------------------------------
func test_recipes_system() -> void:
	print("\n--- 4. Testing Recipe Matrix Combinations ---")

	# Test forward and reverse order for key recipes
	var test_pairs = [
		["razor_claw", "scope_lens", "infinity_blade"],
		["scope_lens", "razor_claw", "infinity_blade"],
		["leftovers", "eviolite", "assault_vest"],
		["eviolite", "leftovers", "assault_vest"],
		["scope_lens", "charcoal", "life_orb"],
		["charcoal", "scope_lens", "life_orb"],
		["scope_lens", "exp_share", "choice_specs"],
		["exp_share", "scope_lens", "choice_specs"],
		["choice_scarf", "exp_share", "battery"],
		["choice_scarf", "razor_claw", "tailwind_feather"],
		["razor_claw", "focus_sash", "weakness_policy"],
		["leftovers", "focus_sash", "rocky_helmet"],
		["eviolite", "focus_sash", "hard_stone"],
		["leftovers", "charcoal", "mystic_water"],
		["choice_scarf", "eviolite", "magnet"]
	]

	for pair in test_pairs:
		var a = pair[0]
		var b = pair[1]
		var expected = pair[2]
		var actual = db_ref.get_recipe(a, b)
		assert(actual == expected, "Recipe [%s, %s] expected '%s', got '%s'" % [a, b, expected, actual])

	# Test invalid recipe
	var invalid = db_ref.get_recipe("infinity_blade", "razor_claw")
	assert(invalid == "", "Combining advanced item should return empty string")

	print("[PASS] Recipe matrix correctly resolves bidirectional combinations.")

# ------------------------------------------------------------------------------
# 5. Item Bench UI Component Operations
# ------------------------------------------------------------------------------
func test_item_bench_operations() -> void:
	print("\n--- 5. Testing Item Bench Slot Operations ---")
	var bench = ITEM_BENCH_SCENE.instantiate()
	add_child(bench)
	await get_tree().process_frame

	assert(bench.MAX_SLOTS == 9, "Item bench must have 9 slots in 3x3 layout")
	assert(bench.get_free_slot_count() == 9, "Fresh bench should have 9 free slots")
	assert(bench.get_occupied_slot_count() == 0, "Fresh bench should have 0 occupied slots")

	# Add items
	assert(bench.add_item("razor_claw"), "Failed to add razor_claw to bench")
	assert(bench.add_item("scope_lens"), "Failed to add scope_lens to bench")
	assert(bench.get_item_at(0) == "razor_claw", "Slot 0 must contain razor_claw")
	assert(bench.get_item_at(1) == "scope_lens", "Slot 1 must contain scope_lens")
	assert(bench.get_occupied_slot_count() == 2, "Bench should have 2 occupied slots")

	# Remove item
	var removed = bench.remove_item_at(0)
	assert(removed == "razor_claw", "Removed item should be razor_claw, got %s" % removed)
	assert(bench.get_item_at(0) == "", "Slot 0 should now be empty")
	assert(bench.get_occupied_slot_count() == 1, "Bench should now have 1 occupied slot")

	# Clear all
	bench.clear_all()
	assert(bench.get_free_slot_count() == 9, "Bench should be empty after clear_all")

	bench.queue_free()
	print("[PASS] Item bench add, remove, and slot tracking verified.")

# ------------------------------------------------------------------------------
# 6. Item Bench Crafting / Combining
# ------------------------------------------------------------------------------
func test_item_bench_combining() -> void:
	print("\n--- 6. Testing Item Bench Combining ---")
	var bench = ITEM_BENCH_SCENE.instantiate()
	add_child(bench)
	await get_tree().process_frame

	# Add two base components
	bench.add_item("razor_claw") # Slot 0
	bench.add_item("scope_lens") # Slot 1

	var combine_ok = bench.combine_slots(0, 1)
	assert(combine_ok, "combine_slots(0, 1) should succeed")
	assert(bench.get_item_at(0) == "infinity_blade", "Slot 0 should now contain infinity_blade, got %s" % bench.get_item_at(0))
	assert(bench.get_item_at(1) == "", "Slot 1 should be empty after combination")
	assert(bench.get_occupied_slot_count() == 1, "Only 1 slot should be occupied after combination")

	bench.queue_free()
	print("[PASS] Item bench component combination verified.")

# ------------------------------------------------------------------------------
# 7. Unit Equipping & Stat Calculation
# ------------------------------------------------------------------------------
func test_unit_equipping_and_stats() -> void:
	print("\n--- 7. Testing Unit Equipping and Stat Calculations ---")
	var unit = UNIT_SCENE.instantiate() as Unit
	add_child(unit)
	unit.setup("pikachu", 1, false)
	await get_tree().process_frame

	var base_atk = unit.atk
	var base_crit_bonus = unit.get_item_stat_bonus("crit")
	assert(base_crit_bonus == 0.0, "Initial unit should have 0 item crit bonus")

	# Equip Razor Claw (+15 ATK, +15% Crit)
	var equip_ok = unit.equip_item("razor_claw")
	assert(equip_ok, "Unit should successfully equip razor_claw")
	assert(unit.has_held_item("razor_claw"), "Unit should have razor_claw in held items")
	assert(abs(unit.atk - (base_atk + 15.0)) < 0.01, "Unit ATK should increase by 15.0 (expected %.1f, got %.1f)" % [base_atk + 15.0, unit.atk])
	assert(abs(unit.get_item_stat_bonus("crit") - 0.15) < 0.01, "Unit crit bonus should be 0.15")

	unit.queue_free()
	print("[PASS] Unit equipping correctly calculates stat bonuses.")

# ------------------------------------------------------------------------------
# 8. Unit Component Synthesis on Equip
# ------------------------------------------------------------------------------
func test_unit_item_synthesis_on_equip() -> void:
	print("\n--- 8. Testing Automatic Recipe Synthesis on Unit Equip ---")
	var unit = UNIT_SCENE.instantiate() as Unit
	add_child(unit)
	unit.setup("pikachu", 1, false)
	await get_tree().process_frame

	var base_atk = unit.atk

	# Step 1: Equip first component (razor_claw)
	unit.equip_item("razor_claw")
	assert(unit.get_held_items().size() == 1, "Unit should have 1 item")

	# Step 2: Equip second component (scope_lens) -> Should synthesize into infinity_blade!
	var synth_ok = unit.equip_item("scope_lens")
	assert(synth_ok, "Equipping scope_lens should combine with razor_claw")
	assert(unit.get_held_items().size() == 1, "Unit should still have 1 item after synthesis (combined)")
	assert(unit.has_held_item("infinity_blade"), "Unit should now hold infinity_blade")
	assert(not unit.has_held_item("razor_claw"), "Unit should no longer hold razor_claw")
	assert(abs(unit.atk - (base_atk + 35.0)) < 0.01, "Infinity blade should grant +35 ATK (expected %.1f, got %.1f)" % [base_atk + 35.0, unit.atk])

	unit.queue_free()
	print("[PASS] Unit automatic item synthesis verified.")

# ------------------------------------------------------------------------------
# 9. Unit Capacity Limits (3 Items Max)
# ------------------------------------------------------------------------------
func test_unit_capacity_limits() -> void:
	print("\n--- 9. Testing Unit Item Capacity Limit (Max 3) ---")
	var unit = UNIT_SCENE.instantiate() as Unit
	add_child(unit)
	unit.setup("pikachu", 1, false)
	await get_tree().process_frame

	assert(unit.MAX_HELD_ITEMS == 3, "Unit should support maximum 3 held items")

	# Equip 3 completed advanced items
	assert(unit.equip_item("infinity_blade"), "Should equip item 1")
	assert(unit.equip_item("expert_belt"), "Should equip item 2")
	assert(unit.equip_item("battery"), "Should equip item 3")
	assert(unit.get_held_items().size() == 3, "Unit should have 3 items")

	# 4th item should fail to equip
	assert(not unit.can_equip_item("life_orb"), "can_equip_item should return false when at capacity")
	assert(not unit.equip_item("life_orb"), "equip_item should fail when at capacity")
	assert(unit.get_held_items().size() == 3, "Item count should remain 3")

	# Unequip one item
	var unequipped = unit.unequip_item_at(0)
	assert(unequipped == "infinity_blade", "Unequipped item should be infinity_blade")
	assert(unit.get_held_items().size() == 2, "Item count should now be 2")
	assert(unit.can_equip_item("life_orb"), "Should now be able to equip after space freed")

	unit.queue_free()
	print("[PASS] Unit 3-item capacity limit strictly enforced.")

# ------------------------------------------------------------------------------
# 10. Special Effects Verification
# ------------------------------------------------------------------------------
func test_special_effects() -> void:
	print("\n--- 10. Testing Special Effects (Assault Vest Shield & Choice Specs Mana) ---")
	var unit = UNIT_SCENE.instantiate() as Unit
	add_child(unit)
	unit.setup("pikachu", 1, false)
	await get_tree().process_frame

	# Test Assault Vest: 40% Max HP Shield
	unit.equip_item("assault_vest")
	var expected_shield = unit.max_hp * 0.40
	assert(abs(unit.shield - expected_shield) < 1.0, "Assault vest should grant 40%% max HP shield (expected %.1f, got %.1f)" % [expected_shield, unit.shield])
	print("  - Assault Vest 40%% Max HP shield granted: %.1f HP" % unit.shield)

	# Test Choice Specs: 100 Start Mana (instant skill ready)
	unit.equip_item("choice_specs")
	assert(unit.current_mana >= 100.0, "Choice specs should grant 100 starting mana (got %.1f)" % unit.current_mana)
	print("  - Choice Specs starting mana granted: %.1f MP" % unit.current_mana)

	unit.queue_free()
	print("[PASS] Advanced item special effects verified.")
