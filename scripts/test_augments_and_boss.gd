extends Node

# Test suite for Trainer Augments (Runes) & Epic Boss Health Bar

const TrainerAugmentModalScript = preload("res://scripts/augment_modal.gd")
const BossHealthBarScript = preload("res://scripts/boss_health_bar.gd")

func _ready() -> void:
	print("\n========================================================")
	print("=== STARTING AUGMENTS & BOSS ENCOUNTERS VERIFICATION ===")
	print("========================================================\n")
	await get_tree().process_frame
	await get_tree().process_frame

	_test_augment_database_catalog()
	_test_augment_database_random_selection()
	_test_augment_database_active_state()
	await _test_trainer_augment_modal()
	await _test_boss_health_bar()

	print("\n========================================================")
	print(">>> ALL AUGMENTS & BOSS ENCOUNTER TESTS PASSED (100%) <<<")
	print("========================================================\n")
	get_tree().quit(0)

func _test_augment_database_catalog() -> void:
	print("--- Test 1: AugmentDatabase Catalog Integrity ---")
	
	# Autoload availability
	assert(AugmentDatabase != null, "AugmentDatabase singleton must be loaded")
	
	var all_augments = AugmentDatabase.get_all_augments()
	print("  Total augments registered: %d" % all_augments.size())
	assert(all_augments.size() >= 15, "Catalog must have at least 15 augments, found %d" % all_augments.size())
	
	# Verify the 12 required augments from user specification
	var required_ids = [
		# Economy
		"interest_tycoon", "free_reroll", "jackpot", "hyper_roll",
		# Synergy & Team
		"nature_alliance", "blazing_soul", "thunder_overload", "dragon_heritage",
		# Combat & Battle
		"destiny_bond", "gigantamax_potion", "quick_draw", "battle_frenzy"
	]
	
	for req_id in required_ids:
		var aug = AugmentDatabase.get_augment(req_id)
		assert(not aug.is_empty(), "Required augment '%s' must exist in AugmentDatabase" % req_id)
		assert(aug.get("id", "") == req_id, "Augment id mismatch for '%s'" % req_id)
		assert(aug.get("name", "").length() > 0, "Augment '%s' must have valid name" % req_id)
		assert(aug.get("desc", "").length() > 0, "Augment '%s' must have valid description" % req_id)
		assert(aug.get("detail", "").length() > 0, "Augment '%s' must have valid detail text" % req_id)
		assert(aug.get("icon", "").length() > 0, "Augment '%s' must have an icon" % req_id)
		assert(aug.get("tier", "") in ["silver", "gold", "prismatic"], "Augment '%s' tier must be silver/gold/prismatic" % req_id)
		assert(aug.get("category", "") in ["economy", "synergy", "combat"], "Augment '%s' category must be economy/synergy/combat" % req_id)
		print("  [PASS] Required augment verified: %s (%s, %s, %s)" % [aug.name, aug.id, aug.tier, aug.category])
		
	# Verify non-existent ID lookup returns empty dict
	var dummy = AugmentDatabase.get_augment("non_existent_augment_xyz")
	assert(dummy.is_empty(), "Querying non-existent augment should return empty Dictionary")
	print("  [PASS] Non-existent augment query handled safely.")

func _test_augment_database_random_selection() -> void:
	print("\n--- Test 2: AugmentDatabase Random Selection ---")
	
	# 1. Pick 3 random across all tiers
	var random_3 = AugmentDatabase.get_random_augments(3)
	assert(random_3.size() == 3, "Expected 3 random augments, got %d" % random_3.size())
	assert(random_3[0].id != random_3[1].id and random_3[1].id != random_3[2].id and random_3[0].id != random_3[2].id, 
		"Random selection must not return duplicate augments")
	print("  [PASS] 3 distinct random augments selected: %s, %s, %s" % [random_3[0].name, random_3[1].name, random_3[2].name])

	# 2. Pick by Silver Tier
	var silver_choices = AugmentDatabase.get_random_augments(3, "silver")
	assert(silver_choices.size() == 3, "Expected 3 silver augments, got %d" % silver_choices.size())
	for item in silver_choices:
		assert(item.tier == "silver", "Augment %s should be silver tier, got %s" % [item.id, item.tier])
	print("  [PASS] Silver tier selection verified (3 silver augments).")

	# 3. Pick by Gold Tier
	var gold_choices = AugmentDatabase.get_random_augments(3, "gold")
	assert(gold_choices.size() == 3, "Expected 3 gold augments, got %d" % gold_choices.size())
	for item in gold_choices:
		assert(item.tier == "gold", "Augment %s should be gold tier, got %s" % [item.id, item.tier])
	print("  [PASS] Gold tier selection verified (3 gold augments).")

	# 4. Pick by Prismatic Tier
	var prismatic_choices = AugmentDatabase.get_random_augments(3, "prismatic")
	assert(prismatic_choices.size() == 3, "Expected 3 prismatic augments, got %d" % prismatic_choices.size())
	for item in prismatic_choices:
		assert(item.tier == "prismatic", "Augment %s should be prismatic tier, got %s" % [item.id, item.tier])
	print("  [PASS] Prismatic tier selection verified (3 prismatic augments).")

func _test_augment_database_active_state() -> void:
	print("\n--- Test 3: Active Augments Tracking & Lifecycle ---")
	
	AugmentDatabase.clear_augments()
	assert(AugmentDatabase.get_active_augments().is_empty(), "Active augments must be empty after clear")
	assert(not AugmentDatabase.has_augment("interest_tycoon"), "has_augment must return false initially")
	
	# Add augment
	var added = AugmentDatabase.add_augment("interest_tycoon")
	assert(added, "add_augment should succeed for valid augment")
	assert(AugmentDatabase.has_augment("interest_tycoon"), "has_augment should return true after add")
	assert(AugmentDatabase.get_active_augments().size() == 1, "Should have 1 active augment")
	
	# Add duplicate should be rejected
	var duplicate_add = AugmentDatabase.add_augment("interest_tycoon")
	assert(not duplicate_add, "Adding duplicate augment should return false")
	assert(AugmentDatabase.get_active_augments().size() == 1, "Duplicate add should not increase count")
	
	# Add second augment
	AugmentDatabase.add_augment("nature_alliance")
	assert(AugmentDatabase.has_augment("nature_alliance"), "Should have nature_alliance active")
	assert(AugmentDatabase.get_active_augments().size() == 2, "Should have 2 active augments")
	
	# Remove augment
	var removed = AugmentDatabase.remove_augment("interest_tycoon")
	assert(removed, "remove_augment should return true")
	assert(not AugmentDatabase.has_augment("interest_tycoon"), "interest_tycoon should no longer be active")
	assert(AugmentDatabase.has_augment("nature_alliance"), "nature_alliance should still be active")
	
	AugmentDatabase.clear_augments()
	assert(AugmentDatabase.get_active_augments().is_empty(), "Should be empty after clear")
	print("  [PASS] Active augment add, query, duplicate prevention, remove, and clear all verified.")

func _test_trainer_augment_modal() -> void:
	print("\n--- Test 4: TrainerAugmentModal UI Rendering & Signals ---")
	
	var modal_scene = load("res://scenes/trainer_augment_modal.tscn")
	assert(modal_scene != null, "scenes/trainer_augment_modal.tscn must be loadable")
	var modal: TrainerAugmentModalScript = modal_scene.instantiate() as TrainerAugmentModalScript
	assert(modal != null, "Instantiated scene must be TrainerAugmentModal")
	add_child(modal)
	await get_tree().process_frame
	
	assert(not modal.visible, "Modal should start hidden")
	
	# Offer 3 mixed-tier augments
	var sample_choices: Array[Dictionary] = [
		AugmentDatabase.get_augment("free_reroll"),      # silver
		AugmentDatabase.get_augment("blazing_soul"),     # gold
		AugmentDatabase.get_augment("dragon_heritage")   # prismatic
	]
	
	var received_signal_id = [""]
	modal.augment_chosen.connect(func(aug_id: String):
		received_signal_id[0] = aug_id
	)
	
	# Open modal
	modal.open_with_choices(sample_choices)
	await get_tree().process_frame
	assert(modal.visible, "Modal must be visible after open_with_choices()")
	
	var cards_container = modal.get_node("Dialog/CardsContainer") as HBoxContainer
	assert(cards_container != null, "CardsContainer must exist")
	assert(cards_container.get_child_count() == 3, "Must render exactly 3 augment cards, found %d" % cards_container.get_child_count())
	
	# Inspect Card 1 (Silver)
	var card_1 = cards_container.get_child(0) as PanelContainer
	var card_1_style = card_1.get_theme_stylebox("panel") as StyleBoxFlat
	assert(card_1_style != null, "Card 1 must have StyleBoxFlat panel")
	assert(card_1_style.border_width_left == 3, "Card 1 border width must be 3px")
	
	# Inspect Card 2 (Gold)
	var card_2 = cards_container.get_child(1) as PanelContainer
	var card_2_name_node = card_2.find_child("TitleLabel", true, false) as Label
	assert(card_2_name_node != null, "Card 2 TitleLabel must exist")
	assert(card_2_name_node.text == "炽热之魂", "Card 2 title must be '炽热之魂', got '%s'" % card_2_name_node.text)
	
	# Inspect Card 3 (Prismatic)
	var card_3 = cards_container.get_child(2) as PanelContainer
	var card_3_name_node = card_3.find_child("TitleLabel", true, false) as Label
	assert(card_3_name_node != null, "Card 3 TitleLabel must exist")
	assert(card_3_name_node.text == "龙之血脉", "Card 3 title must be '龙之血脉', got '%s'" % card_3_name_node.text)
	
	print("  [PASS] 3 cards rendered with Silver, Gold, and Prismatic Pokémon badge framing.")
	
	# Simulate player clicking button on Card 2 (blazing_soul)
	var select_btn = card_2.find_child("SelectBtn", true, false) as Button
	assert(select_btn != null, "Card 2 must have a select button")
	select_btn.emit_signal("pressed")
	await get_tree().process_frame
	
	assert(received_signal_id[0] == "blazing_soul", "Modal must emit augment_chosen with 'blazing_soul', got '%s'" % received_signal_id[0])
	assert(AugmentDatabase.has_augment("blazing_soul"), "AugmentDatabase must register selected augment")
	
	# Allow close tween to complete
	await get_tree().create_timer(0.25).timeout
	assert(not modal.visible, "Modal should be closed after selection")
	print("  [PASS] Card selection emitted augment_chosen signal and closed modal.")
	
	modal.queue_free()

func _test_boss_health_bar() -> void:
	print("\n--- Test 5: BossHealthBar UI, Tracking, Enrage & Defeat ---")
	
	var bar_scene = load("res://scenes/boss_health_bar.tscn")
	assert(bar_scene != null, "scenes/boss_health_bar.tscn must be loadable")
	var boss_bar: BossHealthBarScript = bar_scene.instantiate() as BossHealthBarScript
	assert(boss_bar != null, "Instantiated scene must be BossHealthBar")
	add_child(boss_bar)
	await get_tree().process_frame
	
	assert(not boss_bar.visible, "BossHealthBar should start hidden")
	
	# Create a mock Boss Unit
	var unit_scene = load("res://scenes/unit.tscn")
	assert(unit_scene != null, "scenes/unit.tscn must exist")
	var boss_unit: Unit = unit_scene.instantiate() as Unit
	boss_unit.pokemon_id = "mewtwo"
	boss_unit.star_level = 3
	boss_unit.max_hp = 12000.0
	boss_unit.current_hp = 12000.0
	boss_unit.shield = 0.0
	boss_unit.is_enemy = true
	add_child(boss_unit)
	await get_tree().process_frame
	
	# 1. Track Boss
	boss_bar.track_boss(boss_unit)
	await get_tree().process_frame
	
	assert(boss_bar.visible, "BossHealthBar must be visible after track_boss()")
	assert(boss_bar.boss_name_label.text.contains("超梦") or boss_bar.boss_name_label.text.contains("mewtwo"), 
		"Boss bar name must identify Mewtwo, got: %s" % boss_bar.boss_name_label.text)
	assert(boss_bar.crown_icon.text == "👑", "Crown icon must be 👑 initially")
	assert(boss_bar.current_phase == 1, "Must start in Phase 1")
	assert(not boss_bar.is_enraged, "Must not be enraged initially")
	assert(boss_bar.hp_bar.max_value == 12000.0, "HPBar max_value must be 12000.0")
	assert(boss_bar.hp_bar.value == 12000.0, "HPBar value must be 12000.0")
	assert(boss_bar.hp_text_label.text.contains("100%"), "HP text must show 100%%, got: %s" % boss_bar.hp_text_label.text)
	print("  [PASS] BossHealthBar successfully initialized and tracking Mewtwo (12000 HP).")

	# 2. Simulate damage down to 8000 HP (66.6% -> Still Phase 1)
	boss_unit.current_hp = 8000.0
	boss_bar._process(0.016)
	await get_tree().process_frame
	assert(boss_bar.hp_bar.value == 8000.0, "HPBar value must update to 8000.0")
	assert(boss_bar.current_phase == 1, "Should still be in Phase 1 at 66%% HP")
	assert(not boss_bar.is_enraged, "Should not be enraged at 66%% HP")
	print("  [PASS] Damage update to 8000 HP tracked correctly (Phase 1 maintained).")

	# 3. Simulate Enrage Threshold (HP drops to 4800, which is 40% <= 50% enrage threshold)
	var enraged_signal_fired = [false]
	boss_bar.boss_enraged.connect(func(): enraged_signal_fired[0] = true)
	
	boss_unit.current_hp = 4800.0
	boss_bar._process(0.016)
	await get_tree().process_frame
	
	assert(boss_bar.is_enraged, "Boss must enter enraged state when HP <= 50%")
	assert(boss_bar.current_phase == 2, "Boss must advance to Phase 2")
	assert(enraged_signal_fired[0], "boss_enraged signal must be fired")
	assert(boss_bar.crown_icon.text == "💀", "Crown icon must switch to skull 💀 when enraged")
	assert(boss_bar.phase_label.text.contains("阶段 2") or boss_bar.phase_label.text.contains("狂暴"), 
		"Phase label must show Phase 2 Enrage: %s" % boss_bar.phase_label.text)
	print("  [PASS] Enrage trigger verified: Skull icon 💀, Phase 2 indicator, and signal emitted.")

	# 4. Simulate Shield addition
	boss_unit.shield = 1500.0
	boss_bar._process(0.016)
	await get_tree().process_frame
	assert(boss_bar.hp_text_label.text.contains("护盾"), "HP label should display shield indicator")
	print("  [PASS] Shield tracking verified in HP text overlay.")

	# 5. Simulate Boss Defeat
	var defeated_signal_fired = [false]
	boss_bar.boss_defeated.connect(func(): defeated_signal_fired[0] = true)
	
	boss_unit.current_hp = 0.0
	boss_unit.is_dead = true
	boss_unit.unit_died.emit(boss_unit)
	await get_tree().process_frame
	
	assert(defeated_signal_fired[0], "boss_defeated signal must be fired")
	assert(boss_bar.boss_name_label.text.contains("已击溃") or boss_bar.boss_name_label.text.contains("DEFEATED"), 
		"Boss name must indicate defeat")
	print("  [PASS] Boss defeat handling and signal verified.")

	# 6. Test hide_bar()
	boss_bar.hide_bar()
	await get_tree().create_timer(0.35).timeout
	assert(not boss_bar.visible, "hide_bar() must hide the health bar")
	print("  [PASS] hide_bar() successfully hides the boss health bar.")

	boss_unit.queue_free()
	boss_bar.queue_free()
