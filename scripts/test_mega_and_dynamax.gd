extends Node

func _ready() -> void:
	print("\n========================================================")
	print(">>> STARTING MEGA EVOLUTION & DYNAMAX AUTOMATED TESTS <<<")
	print("========================================================")
	
	# --- Test 1: Mega Database Catalog & Forms ---
	print("\n--- Test 1: Mega Database Catalog & Forms ---")
	assert(MegaDatabase.is_mega_eligible("charizard"), "Charizard must be Mega eligible")
	assert(MegaDatabase.is_mega_eligible("blastoise"), "Blastoise must be Mega eligible")
	assert(MegaDatabase.is_mega_eligible("venusaur"), "Venusaur must be Mega eligible")
	assert(MegaDatabase.is_mega_eligible("gengar"), "Gengar must be Mega eligible")
	assert(MegaDatabase.is_mega_eligible("mewtwo"), "Mewtwo must be Mega eligible")
	assert(MegaDatabase.is_mega_eligible("gyarados"), "Gyarados must be Mega eligible")
	assert(MegaDatabase.is_mega_eligible("alakazam"), "Alakazam must be Mega eligible")
	assert(not MegaDatabase.is_mega_eligible("caterpie"), "Caterpie should not be Mega eligible")
	print("  [PASS] All 7 iconic Mega Evolutions verified in catalog.")
	
	var char_mega = MegaDatabase.get_mega_form("charizard")
	assert(char_mega["name"] == "超级喷火龙 X", "Charizard Mega form should be Mega Charizard X")
	assert(char_mega["types"] == ["Fire", "Dragon"], "Mega Charizard X should be Fire/Dragon")
	assert(char_mega["ability"]["name"] == "硬爪", "Mega Charizard X should have Tough Claws ability")
	print("  [PASS] Mega Charizard X form details and Tough Claws ability verified.")
	
	# --- Test 2: Unit Mega Evolution Trigger & Stats ---
	print("\n--- Test 2: Unit Mega Evolution Trigger & Stats ---")
	var unit_scene = load("res://scenes/unit.tscn")
	var unit = unit_scene.instantiate() as Unit
	add_child(unit)
	unit.setup("charizard", 3, false)
	
	var base_hp = unit.max_hp
	var base_atk = unit.atk
	
	unit.trigger_mega_evolution()
	assert(unit.has_meta("is_mega"), "Unit must have 'is_mega' meta set")
	assert(unit.max_hp > base_hp, "Mega HP must be higher than base 3-star HP")
	assert(unit.atk > base_atk, "Mega ATK must be higher than base 3-star ATK")
	assert(unit.types.has("Dragon"), "Mega Charizard X must gain Dragon typing")
	print("  [PASS] Mega Evolution executed! HP: %.0f -> %.0f, ATK: %.0f -> %.0f, Types: %s" % [base_hp, unit.max_hp, base_atk, unit.atk, str(unit.types)])
	
	# --- Test 3: Mega Gyarados Mold Breaker ---
	print("\n--- Test 3: Mega Gyarados Mold Breaker ---")
	var gyarados = unit_scene.instantiate() as Unit
	add_child(gyarados)
	gyarados.setup("gyarados", 3, false)
	gyarados.trigger_mega_evolution()
	assert(gyarados.has_meta("is_mega"), "Gyarados should be Mega")
	assert(gyarados.types.has("Dark"), "Mega Gyarados should have Dark typing")
	
	# Target with massive armor
	var defender = unit_scene.instantiate() as Unit
	add_child(defender)
	defender.setup("snorlax", 2, true)
	defender.armor = 200.0 # 66% damage reduction normally
	var hp_before = defender.current_hp
	defender.take_damage(100.0, false, false, false, gyarados)
	var dealt = hp_before - defender.current_hp
	assert(is_equal_approx(dealt, 100.0), "Mega Gyarados Mold Breaker must ignore defender armor! Dealt: %.1f" % dealt)
	print("  [PASS] Mold Breaker verified: 100 damage penetrated 200 armor cleanly (Dealt: %.0f)." % dealt)
	
	# --- Test 4: Dynamax Activation & Scale ---
	print("\n--- Test 4: Dynamax Activation & Scale ---")
	var pika = unit_scene.instantiate() as Unit
	add_child(pika)
	pika.setup("pikachu", 2, false)
	var pika_hp = pika.max_hp
	
	pika.activate_dynamax()
	assert(pika.has_meta("is_dynamax"), "Pikachu should be Dynamaxed")
	assert(pika.max_hp == pika_hp * 2.0, "Dynamax must double max HP")
	assert(pika.scale.x > 1.4, "Dynamax scale must expand to 1.6x")
	print("  [PASS] Dynamax activated: HP doubled (%.0f -> %.0f), Scale: %.2f" % [pika_hp, pika.max_hp, pika.scale.x])
	
	# --- Test 5: Dynamax Max Move Weather Generation ---
	print("\n--- Test 5: Dynamax Max Move Weather Generation ---")
	WeatherSystem.reset_environment()
	pika.current_mana = pika.max_mana
	pika.cast_skill()
	assert(WeatherSystem.current_terrain == "electric", "Electric Max Move must summon Electric Terrain!")
	print("  [PASS] Max Move (极巨闪电) successfully summoned Electric Terrain!")
	
	# --- Test 6: Prep Reset Cleanly Reverts Dynamax ---
	print("\n--- Test 6: Prep Reset Cleanly Reverts Dynamax ---")
	pika.reset_for_prep()
	assert(not pika.has_meta("is_dynamax"), "Dynamax meta should be cleared on prep reset")
	assert(pika.scale == Vector2.ONE, "Scale should revert to 1.0 on prep reset")
	print("  [PASS] Dynamax cleanly dismissed upon returning to prep phase.")
	
	# --- Test 7: Dynamax Energy Accumulation ---
	print("\n--- Test 7: Dynamax Energy Accumulation ---")
	MegaDatabase.reset_energy()
	assert(MegaDatabase.dynamax_energy == 0, "Energy should start at 0")
	assert(not MegaDatabase.is_energy_full(), "Energy should not be full at 0")
	
	# Unit casting skill generates energy (+2)
	var e_before = MegaDatabase.dynamax_energy
	pika.current_mana = pika.max_mana
	pika.cast_skill()
	assert(MegaDatabase.dynamax_energy == e_before + 2, "Casting skill should award +2 energy")
	
	# Enemy unit death generates energy (+3)
	defender.die()
	assert(MegaDatabase.dynamax_energy == e_before + 5, "Defeating enemy should award +3 energy")
	
	# Add energy up to 100
	MegaDatabase.add_dynamax_energy(120)
	assert(MegaDatabase.dynamax_energy == 100, "Energy should clamp at 100")
	assert(MegaDatabase.is_energy_full(), "Energy should be full at 100")
	print("  [PASS] Dynamax energy accumulation and clamp verified (0 -> %d/100)." % MegaDatabase.dynamax_energy)
	
	# --- Test 8: Character Selection & Toggle/Switch Target ---
	print("\n--- Test 8: Character Selection & Target Management ---")
	var charizard = unit_scene.instantiate() as Unit
	add_child(charizard)
	charizard.setup("charizard", 2, false)
	
	# Target charizard
	MegaDatabase.set_dynamax_target(charizard)
	charizard.activate_dynamax()
	assert(MegaDatabase.current_dynamax_target == charizard, "Charizard must be current dynamax target")
	assert(MegaDatabase.is_dynamax_active_this_round, "Dynamax active this round must be true")
	assert(charizard.has_meta("is_dynamax"), "Charizard must have dynamax meta")
	
	# Switch target to pikachu
	MegaDatabase.set_dynamax_target(pika)
	pika.activate_dynamax()
	assert(not charizard.has_meta("is_dynamax"), "Charizard dynamax must be cleared when switching")
	assert(charizard.scale == Vector2.ONE, "Charizard scale must revert to 1.0")
	assert(MegaDatabase.current_dynamax_target == pika, "Pikachu must now be target")
	assert(pika.has_meta("is_dynamax"), "Pikachu must have dynamax meta")
	
	# Clear dynamax (toggle cancel)
	MegaDatabase.clear_dynamax()
	assert(MegaDatabase.current_dynamax_target == null, "Target should be null after clearing")
	assert(not MegaDatabase.is_dynamax_active_this_round, "Active this round should be false after clear")
	assert(not pika.has_meta("is_dynamax"), "Pikachu dynamax meta should be cleared")
	print("  [PASS] Character selection, switching, and toggle cancellation verified.")
	
	# --- Test 9: Single-Round Duration & Energy Consumption ---
	print("\n--- Test 9: Single-Round Duration & Energy Consumption ---")
	MegaDatabase.dynamax_energy = 100
	MegaDatabase.set_dynamax_target(pika)
	pika.activate_dynamax()
	assert(MegaDatabase.is_dynamax_active_this_round, "Should be active before combat resolution")
	
	# Simulate combat resolution with Dynamax active
	MegaDatabase.consume_energy()
	assert(MegaDatabase.dynamax_energy == 0, "Consuming energy should reset to 0")
	assert(not MegaDatabase.is_dynamax_active_this_round, "Flag should reset after consumption")
	
	# Revert for next prep round
	pika.reset_for_prep()
	assert(not pika.has_meta("is_dynamax"), "Pikachu should revert back to normal")
	assert(pika.scale == Vector2.ONE, "Pikachu scale should revert back to normal")
	print("  [PASS] Single-round duration strictly enforced: energy consumed, unit cleanly reverted for next round.")
	
	print("\n========================================================")
	print(">>> ALL MEGA & DYNAMAX AUTOMATED TESTS PASSED (100%) <<<")
	print("========================================================\n")
	get_tree().quit(0)
