extends Node

# Automated test suite for Pokémon Passive Abilities & Type Effectiveness System

func _ready() -> void:
	print("\n========================================================")
	print(">>> STARTING ABILITIES & TYPE SYSTEM AUTOMATED TESTS <<<")
	print("========================================================\n")
	
	# Wait one frame for autoloads
	await get_tree().process_frame
	
	test_type_effectiveness()
	test_dual_types()
	test_effectiveness_labels()
	test_ability_database()
	test_pokemon_ability_mappings()
	test_edge_cases()
	
	print("\n========================================================")
	print(">>> ALL ABILITY & TYPE SYSTEM TESTS PASSED (100%)!   <<<")
	print("========================================================\n")
	
	get_tree().quit(0)

func test_type_effectiveness() -> void:
	print("--- Test 1: Core Type Effectiveness Matchups ---")
	
	# Water -> Fire (1.35x)
	var w_v_f = TypeSystem.get_type_multiplier(["Water"], ["Fire"])
	assert(is_equal_approx(w_v_f, 1.35), "Water vs Fire should be 1.35, got %f" % w_v_f)
	print("[PASS] Water -> Fire: %.2fx (Super Effective)" % w_v_f)
	
	# Fire -> Grass (1.35x)
	var f_v_g = TypeSystem.get_type_multiplier(["Fire"], ["Grass"])
	assert(is_equal_approx(f_v_g, 1.35), "Fire vs Grass should be 1.35, got %f" % f_v_g)
	print("[PASS] Fire -> Grass: %.2fx (Super Effective)" % f_v_g)
	
	# Grass -> Water (1.35x)
	var g_v_w = TypeSystem.get_type_multiplier(["Grass"], ["Water"])
	assert(is_equal_approx(g_v_w, 1.35), "Grass vs Water should be 1.35, got %f" % g_v_w)
	print("[PASS] Grass -> Water: %.2fx (Super Effective)" % g_v_w)
	
	# Electric -> Water (1.35x) and Electric -> Flying (1.35x)
	var e_v_w = TypeSystem.get_type_multiplier(["Electric"], ["Water"])
	var e_v_fly = TypeSystem.get_type_multiplier(["Electric"], ["Flying"])
	assert(is_equal_approx(e_v_w, 1.35), "Electric vs Water should be 1.35")
	assert(is_equal_approx(e_v_fly, 1.35), "Electric vs Flying should be 1.35")
	print("[PASS] Electric -> Water (%.2fx) & Flying (%.2fx)" % [e_v_w, e_v_fly])
	
	# Electric -> Ground (0.5x Immune / Ineffective)
	var e_v_gnd = TypeSystem.get_type_multiplier(["Electric"], ["Ground"])
	assert(is_equal_approx(e_v_gnd, 0.50), "Electric vs Ground should be 0.50, got %f" % e_v_gnd)
	print("[PASS] Electric -> Ground: %.2fx (Immune/Ineffective)" % e_v_gnd)
	
	# Normal <-> Ghost (0.5x Immune / Ineffective)
	var n_v_gh = TypeSystem.get_type_multiplier(["Normal"], ["Ghost"])
	var gh_v_n = TypeSystem.get_type_multiplier(["Ghost"], ["Normal"])
	assert(is_equal_approx(n_v_gh, 0.50), "Normal vs Ghost should be 0.50")
	assert(is_equal_approx(gh_v_n, 0.50), "Ghost vs Normal should be 0.50")
	print("[PASS] Normal <-> Ghost: %.2fx (Immune/Ineffective bidirectional)" % n_v_gh)
	
	# Ground -> Flying (0.5x Immune / Ineffective)
	var gnd_v_fly = TypeSystem.get_type_multiplier(["Ground"], ["Flying"])
	assert(is_equal_approx(gnd_v_fly, 0.50), "Ground vs Flying should be 0.50, got %f" % gnd_v_fly)
	print("[PASS] Ground -> Flying: %.2fx (Immune/Ineffective)" % gnd_v_fly)
	
	# Psychic -> Dark (0.5x Immune / Ineffective)
	var psy_v_dk = TypeSystem.get_type_multiplier(["Psychic"], ["Dark"])
	assert(is_equal_approx(psy_v_dk, 0.50), "Psychic vs Dark should be 0.50")
	print("[PASS] Psychic -> Dark: %.2fx (Immune/Ineffective)" % psy_v_dk)
	
	# Dragon -> Fairy (0.5x Immune / Ineffective)
	var dra_v_fy = TypeSystem.get_type_multiplier(["Dragon"], ["Fairy"])
	assert(is_equal_approx(dra_v_fy, 0.50), "Dragon vs Fairy should be 0.50")
	print("[PASS] Dragon -> Fairy: %.2fx (Immune/Ineffective)" % dra_v_fy)
	
	# Poison -> Steel (0.5x Immune / Ineffective)
	var poi_v_stl = TypeSystem.get_type_multiplier(["Poison"], ["Steel"])
	assert(is_equal_approx(poi_v_stl, 0.50), "Poison vs Steel should be 0.50")
	print("[PASS] Poison -> Steel: %.2fx (Immune/Ineffective)" % poi_v_stl)
	
	# Not very effective (0.75x)
	var f_v_w = TypeSystem.get_type_multiplier(["Fire"], ["Water"])
	var w_v_g = TypeSystem.get_type_multiplier(["Water"], ["Grass"])
	var g_v_f = TypeSystem.get_type_multiplier(["Grass"], ["Fire"])
	assert(is_equal_approx(f_v_w, 0.75), "Fire vs Water should be 0.75")
	assert(is_equal_approx(w_v_g, 0.75), "Water vs Grass should be 0.75")
	assert(is_equal_approx(g_v_f, 0.75), "Grass vs Fire should be 0.75")
	print("[PASS] Not Very Effective tests (Fire->Water 0.75x, Water->Grass 0.75x, Grass->Fire 0.75x)")
	
	# Neutral (1.0x)
	var n_v_n = TypeSystem.get_type_multiplier(["Normal"], ["Normal"])
	assert(is_equal_approx(n_v_n, 1.00), "Normal vs Normal should be 1.00")
	print("[PASS] Neutral test (Normal->Normal 1.00x)")

func test_dual_types() -> void:
	print("\n--- Test 2: Dual-Type & Compound Effectiveness ---")
	
	# Electric vs Water/Flying (e.g. Gyarados): 1.35 * 1.35 = 1.8225x
	var gyarados_mult = TypeSystem.get_type_multiplier(["Electric"], ["Water", "Flying"])
	var expected_double_super = 1.35 * 1.35
	assert(is_equal_approx(gyarados_mult, expected_double_super), "Electric vs Water/Flying should be ~1.8225")
	print("[PASS] Electric vs Gyarados (Water/Flying): %.4fx (Compound Super)" % gyarados_mult)
	
	# Ice vs Grass/Dragon: 1.35 * 1.35 = 1.8225x
	var ice_v_grass_dragon = TypeSystem.get_type_multiplier(["Ice"], ["Grass", "Dragon"])
	assert(is_equal_approx(ice_v_grass_dragon, expected_double_super), "Ice vs Grass/Dragon should be ~1.8225")
	print("[PASS] Ice vs Grass/Dragon: %.4fx (Double Super)" % ice_v_grass_dragon)
	
	# Dual-type attacker choosing best advantage:
	# Charizard (Fire, Flying) vs Grass: Fire is 1.35, Flying is 1.35 -> 1.35
	var cz_v_grass = TypeSystem.get_type_multiplier(["Fire", "Flying"], ["Grass"])
	assert(is_equal_approx(cz_v_grass, 1.35), "Fire/Flying vs Grass should be 1.35")
	print("[PASS] Charizard (Fire/Flying) vs Grass: %.2fx" % cz_v_grass)
	
	# Charizard (Fire, Flying) vs Water: Fire is 0.75, Flying is 1.0 -> Charizard uses Flying for 1.0
	var cz_v_water = TypeSystem.get_type_multiplier(["Fire", "Flying"], ["Water"])
	assert(is_equal_approx(cz_v_water, 1.00), "Fire/Flying vs Water should leverage Flying for 1.00")
	print("[PASS] Charizard (Fire/Flying) vs Water: %.2fx (Offensive advantage selection)" % cz_v_water)

func test_effectiveness_labels() -> void:
	print("\n--- Test 3: Effectiveness Label Generation ---")
	
	var label_super = TypeSystem.get_effectiveness_label(1.35)
	assert(label_super.get("tag") == "super", "Tag should be 'super'")
	assert(label_super.get("text") == "效果绝佳！", "Text should be '效果绝佳！'")
	print("[PASS] Super label: %s | tag=%s" % [label_super["text"], label_super["tag"]])
	
	var label_double_super = TypeSystem.get_effectiveness_label(1.8225)
	assert(label_double_super.get("tag") == "super", "Tag should be 'super'")
	assert(label_double_super.get("text") == "效果绝佳！", "Text should be '效果绝佳！'")
	print("[PASS] Double-Super label: %s | tag=%s" % [label_double_super["text"], label_double_super["tag"]])
	
	var label_weak = TypeSystem.get_effectiveness_label(0.75)
	assert(label_weak.get("tag") == "weak", "Tag should be 'weak'")
	assert(label_weak.get("text") == "效果不理想", "Text should be '效果不理想'")
	print("[PASS] Weak label: %s | tag=%s" % [label_weak["text"], label_weak["tag"]])
	
	var label_immune = TypeSystem.get_effectiveness_label(0.50)
	assert(label_immune.get("tag") == "weak", "Tag should be 'weak'")
	assert(label_immune.get("text") == "效果不理想", "Text should be '效果不理想'")
	print("[PASS] Ineffective label (0.5x): %s | tag=%s" % [label_immune["text"], label_immune["tag"]])
	
	var label_normal = TypeSystem.get_effectiveness_label(1.00)
	assert(label_normal.get("tag") == "normal", "Tag should be 'normal'")
	assert(label_normal.get("text") == "", "Text should be empty for normal")
	print("[PASS] Normal label: tag=%s, empty text" % label_normal["tag"])

func test_ability_database() -> void:
	print("\n--- Test 4: Ability Database Direct Lookups ---")
	
	var static_ab = AbilityDatabase.get_ability("static")
	assert(not static_ab.is_empty(), "static ability should exist")
	assert(static_ab["name"] == "静电", "static name should be 静电")
	assert(static_ab["chance"] == 0.25, "static chance should be 0.25")
	assert(static_ab["stun_duration"] == 1.0, "static stun_duration should be 1.0")
	print("[PASS] static ability verified: %s (chance: %.0f%%, stun: %.1fs)" % [
		static_ab["name"], static_ab["chance"] * 100, static_ab["stun_duration"]
	])
	
	var blaze_ab = AbilityDatabase.get_ability("blaze")
	assert(blaze_ab["name"] == "猛火", "blaze name should be 猛火")
	assert(blaze_ab["hp_threshold"] == 0.40, "blaze hp threshold should be 0.40")
	assert(blaze_ab["skill_power_boost"] == 0.45, "blaze skill power boost should be 0.45")
	assert(blaze_ab["atk_speed_boost"] == 0.25, "blaze atk speed boost should be 0.25")
	print("[PASS] blaze ability verified: %s (HP<=%.0f%% -> +%.0f%% power, +%.0f%% atk_speed)" % [
		blaze_ab["name"], blaze_ab["hp_threshold"] * 100, blaze_ab["skill_power_boost"] * 100, blaze_ab["atk_speed_boost"] * 100
	])
	
	var torrent_ab = AbilityDatabase.get_ability("torrent")
	assert(torrent_ab["name"] == "激流", "torrent name should be 激流")
	assert(torrent_ab["damage_reduction"] == 0.30, "torrent dmg reduction should be 0.30")
	assert(torrent_ab["regen_pct_per_sec"] == 0.03, "torrent regen should be 0.03")
	print("[PASS] torrent ability verified: %s (HP<=40%% -> -30%% dmg, +3%% HP/s)" % torrent_ab["name"])
	
	var overgrow_ab = AbilityDatabase.get_ability("overgrow")
	assert(overgrow_ab["name"] == "茂盛", "overgrow name should be 茂盛")
	assert(overgrow_ab["skill_damage_boost"] == 0.40, "overgrow skill damage boost should be 0.40")
	assert(overgrow_ab["lifesteal_ratio"] == 0.30, "overgrow lifesteal ratio should be 0.30")
	print("[PASS] overgrow ability verified: %s (HP<=40%% -> +40%% skill dmg, 30%% lifesteal)" % overgrow_ab["name"])
	
	var cursed_ab = AbilityDatabase.get_ability("cursed_body")
	assert(cursed_ab["name"] == "诅咒之躯", "cursed_body name should be 诅咒之躯")
	assert(cursed_ab["chance"] == 0.20, "cursed_body chance should be 0.20")
	assert(cursed_ab["disarm_duration"] == 2.0, "cursed_body disarm should be 2.0")
	print("[PASS] cursed_body ability verified: %s (20%% chance disarm 2s)" % cursed_ab["name"])
	
	var thick_fat_ab = AbilityDatabase.get_ability("thick_fat")
	assert(thick_fat_ab["name"] == "厚脂肪", "thick_fat name should be 厚脂肪")
	assert(thick_fat_ab["damage_reduction"] == 0.40, "thick_fat damage reduction should be 0.40")
	assert(thick_fat_ab["affected_types"].has("Fire") and thick_fat_ab["affected_types"].has("Ice"), "thick_fat should affect Fire & Ice")
	print("[PASS] thick_fat ability verified: %s (-40%% Fire & Ice dmg)" % thick_fat_ab["name"])
	
	var pressure_ab = AbilityDatabase.get_ability("pressure")
	assert(pressure_ab["name"] == "压迫感", "pressure name should be 压迫感")
	assert(pressure_ab["mana_reduction"] == 20.0, "pressure mana reduction should be 20.0")
	print("[PASS] pressure ability verified: %s (Enemy initial mana -20)" % pressure_ab["name"])
	
	var multiscale_ab = AbilityDatabase.get_ability("multiscale")
	assert(multiscale_ab["name"] == "多重鳞片", "multiscale name should be 多重鳞片")
	assert(multiscale_ab["damage_reduction"] == 0.60, "multiscale reduction should be 0.60")
	print("[PASS] multiscale ability verified: %s (First hit at full HP -60%%)" % multiscale_ab["name"])
	
	var guts_ab = AbilityDatabase.get_ability("guts")
	assert(guts_ab["name"] == "毅力", "guts name should be 毅力")
	assert(guts_ab["atk_boost"] == 0.50, "guts atk boost should be 0.50")
	print("[PASS] guts ability verified: %s (Status -> +50%% ATK)" % guts_ab["name"])
	
	var magic_guard_ab = AbilityDatabase.get_ability("magic_guard")
	assert(magic_guard_ab["name"] == "魔法防守", "magic_guard name should be 魔法防守")
	assert(magic_guard_ab["immune_dot"] == true, "magic_guard immune_dot should be true")
	print("[PASS] magic_guard ability verified: %s (Full DoT/hazard immunity)" % magic_guard_ab["name"])
	
	var intimidate_ab = AbilityDatabase.get_ability("intimidate")
	assert(intimidate_ab["name"] == "威吓", "intimidate name should be 威吓")
	assert(intimidate_ab["enemy_atk_reduction"] == 0.15, "intimidate enemy atk reduction should be 0.15")
	print("[PASS] intimidate ability verified: %s (-15%% enemy ATK)" % intimidate_ab["name"])
	
	var levitate_ab = AbilityDatabase.get_ability("levitate")
	assert(levitate_ab["name"] == "飘浮", "levitate name should be 飘浮")
	assert(levitate_ab["immune_ground"] == true, "levitate immune_ground should be true")
	print("[PASS] levitate ability verified: %s (Full ground damage & control immunity)" % levitate_ab["name"])

func test_pokemon_ability_mappings() -> void:
	print("\n--- Test 5: Pokemon -> Ability Mapping Lookups ---")
	
	# Pikachu -> static
	var pika_ab = AbilityDatabase.get_ability_for_pokemon("pikachu")
	assert(pika_ab.get("id") == "static", "Pikachu should have static")
	print("[PASS] Pikachu mapped to: %s (%s)" % [pika_ab["id"], pika_ab["name"]])
	
	# Charizard -> blaze
	var cz_ab = AbilityDatabase.get_ability_for_pokemon("charizard")
	assert(cz_ab.get("id") == "blaze", "Charizard should have blaze")
	print("[PASS] Charizard mapped to: %s (%s)" % [cz_ab["id"], cz_ab["name"]])
	
	# Blastoise -> torrent
	var blast_ab = AbilityDatabase.get_ability_for_pokemon("blastoise")
	assert(blast_ab.get("id") == "torrent", "Blastoise should have torrent")
	print("[PASS] Blastoise mapped to: %s (%s)" % [blast_ab["id"], blast_ab["name"]])
	
	# Snorlax -> thick_fat
	var snor_ab = AbilityDatabase.get_ability_for_pokemon("snorlax")
	assert(snor_ab.get("id") == "thick_fat", "Snorlax should have thick_fat")
	print("[PASS] Snorlax mapped to: %s (%s)" % [snor_ab["id"], snor_ab["name"]])
	
	# Mewtwo -> pressure
	var mewtwo_ab = AbilityDatabase.get_ability_for_pokemon("mewtwo")
	assert(mewtwo_ab.get("id") == "pressure", "Mewtwo should have pressure")
	print("[PASS] Mewtwo mapped to: %s (%s)" % [mewtwo_ab["id"], mewtwo_ab["name"]])
	
	# Dragonite -> multiscale
	var dn_ab = AbilityDatabase.get_ability_for_pokemon("dragonite")
	assert(dn_ab.get("id") == "multiscale", "Dragonite should have multiscale")
	print("[PASS] Dragonite mapped to: %s (%s)" % [dn_ab["id"], dn_ab["name"]])
	
	# Additional requested units:
	var vena_ab = AbilityDatabase.get_ability_for_pokemon("venusaur")
	assert(vena_ab.get("id") == "overgrow", "Venusaur should have overgrow")
	print("[PASS] Venusaur mapped to: %s (%s)" % [vena_ab["id"], vena_ab["name"]])
	
	var geng_ab = AbilityDatabase.get_ability_for_pokemon("gengar")
	assert(geng_ab.get("id") == "cursed_body", "Gengar should have cursed_body")
	print("[PASS] Gengar mapped to: %s (%s)" % [geng_ab["id"], geng_ab["name"]])
	
	var mach_ab = AbilityDatabase.get_ability_for_pokemon("machamp")
	assert(mach_ab.get("id") == "guts", "Machamp should have guts")
	print("[PASS] Machamp mapped to: %s (%s)" % [mach_ab["id"], mach_ab["name"]])
	
	var alak_ab = AbilityDatabase.get_ability_for_pokemon("alakazam")
	assert(alak_ab.get("id") == "magic_guard", "Alakazam should have magic_guard")
	print("[PASS] Alakazam mapped to: %s (%s)" % [alak_ab["id"], alak_ab["name"]])
	
	var gyar_ab = AbilityDatabase.get_ability_for_pokemon("gyarados")
	assert(gyar_ab.get("id") == "intimidate", "Gyarados should have intimidate")
	print("[PASS] Gyarados mapped to: %s (%s)" % [gyar_ab["id"], gyar_ab["name"]])
	
	var weez_ab = AbilityDatabase.get_ability_for_pokemon("weezing")
	assert(weez_ab.get("id") == "levitate", "Weezing should have levitate")
	print("[PASS] Weezing mapped to: %s (%s)" % [weez_ab["id"], weez_ab["name"]])

func test_edge_cases() -> void:
	print("\n--- Test 6: Edge Cases & Robustness ---")
	
	# Case-insensitive queries
	var pika_caps = AbilityDatabase.get_ability_for_pokemon("PIKACHU")
	assert(pika_caps.get("id") == "static", "Case insensitive lookup should work")
	print("[PASS] Case-insensitivity: 'PIKACHU' -> static")
	
	# Non-existent pokemon lookup
	var non_exist = AbilityDatabase.get_ability_for_pokemon("missingno_999")
	assert(non_exist.is_empty(), "Non-existent pokemon should return empty dict")
	print("[PASS] Non-existent Pokémon returns empty Dictionary safely")
	
	# TypeSystem empty types
	var empty_mult = TypeSystem.get_type_multiplier([], [])
	assert(is_equal_approx(empty_mult, 1.0), "Empty types should return 1.0")
	print("[PASS] Empty types defaults to 1.00x")
	
	# String inputs to get_type_multiplier
	var str_mult = TypeSystem.get_type_multiplier("Water", "Fire")
	assert(is_equal_approx(str_mult, 1.35), "String input should work identically to Array")
	print("[PASS] String parameters ('Water', 'Fire') supported and correct")
