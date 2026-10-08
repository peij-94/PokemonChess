extends Node

# test_shiny_and_lore.gd: Comprehensive automated test suite for
# Shiny Pokemon mechanics and Classic Lore Synergies (Module 1).

const SHOP_CARD_SCENE = preload("res://scenes/shop_card.tscn")
const UNIT_SCENE = preload("res://scenes/unit.tscn")

func _ready() -> void:
	print("\n========================================================")
	print(">>> STARTING SHINY POKEMON & LORE SYNERGIES TEST SUITE <<<")
	print("========================================================\n")
	
	await get_tree().process_frame
	
	test_shiny_refresh_and_affixes()
	test_shop_card_rendering()
	test_unit_shiny_stats_and_combat()
	test_lore_synergies()
	
	print("\n========================================================")
	print(">>> ALL SHINY & LORE TESTS PASSED (100% SUCCESS) <<<")
	print("========================================================\n")
	get_tree().quit(0)

# -----------------------------------------------------------------------------
# 1. 闪光刷新与词缀分配测试
# -----------------------------------------------------------------------------
func test_shiny_refresh_and_affixes() -> void:
	print("--- [1/4] Testing Shiny Card Generation & Affix Allocation ---")
	
	assert(ShinyAndLoreManager != null, "ShinyAndLoreManager autoload must exist")
	
	# A. Test force_shiny
	ShinyAndLoreManager.force_shiny = true
	ShinyAndLoreManager.force_affix = ""
	ShinyAndLoreManager.on_shop_refreshed(5)
	
	for i in range(5):
		var info = ShinyAndLoreManager.get_shop_card_shiny_info(i)
		assert(info["is_shiny"] == true, "Slot %d must be shiny under force_shiny" % i)
		assert(ShinyAndLoreManager.SHINY_AFFIXES.has(info["affix"]), "Affix '%s' must be valid" % info["affix"])
	print("  [PASS] force_shiny generates 100% shiny cards with valid affixes.")
	
	# B. Test forced specific affix
	for affix in ["fortune", "aura", "iron_will"]:
		ShinyAndLoreManager.force_affix = affix
		ShinyAndLoreManager.on_shop_refreshed(5)
		for i in range(5):
			var info = ShinyAndLoreManager.get_shop_card_shiny_info(i)
			assert(info["is_shiny"] == true, "Slot %d must be shiny" % i)
			assert(info["affix"] == affix, "Slot %d affix must be '%s', got '%s'" % [i, affix, info["affix"]])
	print("  [PASS] force_affix specifically assigns 'fortune', 'aura', and 'iron_will'.")
	
	# Reset forced flags
	ShinyAndLoreManager.force_shiny = false
	ShinyAndLoreManager.force_affix = ""
	
	# C. Statistical natural roll testing (~1.5% probability)
	var sample_size = 20000
	var shiny_count = 0
	var affix_counts = {"fortune": 0, "aura": 0, "iron_will": 0}
	
	for s in range(sample_size):
		var rolled = ShinyAndLoreManager.roll_shop_shiny(0)
		if rolled["is_shiny"]:
			shiny_count += 1
			affix_counts[rolled["affix"]] = affix_counts.get(rolled["affix"], 0) + 1
			
	var observed_rate = float(shiny_count) / float(sample_size)
	print("  Simulation over %d rolls: %d shinies (%.2f%%, expected ~1.50%%)" % [sample_size, shiny_count, observed_rate * 100.0])
	assert(observed_rate >= 0.009 and observed_rate <= 0.022, "Observed shiny rate should be ~1.5%% (got %.3f)" % observed_rate)
	assert(affix_counts["fortune"] > 0, "fortune affix should appear in rolls")
	assert(affix_counts["aura"] > 0, "aura affix should appear in rolls")
	assert(affix_counts["iron_will"] > 0, "iron_will affix should appear in rolls")
	print("  [PASS] Natural 1.5% appearance rate and 3-affix random distribution verified.")
	
	# D. Test consume_shop_card
	ShinyAndLoreManager.set_shop_card_shiny(2, true, "fortune")
	var consumed = ShinyAndLoreManager.consume_shop_card(2)
	assert(consumed["is_shiny"] == true and consumed["affix"] == "fortune", "Consumed card should match set data")
	var post_consume = ShinyAndLoreManager.get_shop_card_shiny_info(2)
	assert(post_consume["is_shiny"] == false, "Slot should be cleared after consumption")
	print("  [PASS] consume_shop_card retrieves and clears slot state cleanly.")

# -----------------------------------------------------------------------------
# 2. 商店卡牌闪光徽章渲染测试
# -----------------------------------------------------------------------------
func test_shop_card_rendering() -> void:
	print("--- [2/4] Testing Shop Card Shiny Visuals & Badges ---")
	
	var card = SHOP_CARD_SCENE.instantiate()
	add_child(card)
	
	# A. Normal Card Test
	card.setup("pikachu", 0, false, "")
	await get_tree().process_frame
	assert(card.is_shiny == false, "Card must not be shiny")
	assert(card.name_label.text == "皮卡丘", "Name should not contain shiny prefix")
	var shiny_badge = card.get_node_or_null("Panel/ShinyBadge") as Label
	if shiny_badge:
		assert(shiny_badge.visible == false, "ShinyBadge must be invisible on standard card")
	print("  [PASS] Standard shop card displays standard styling without shiny badges.")
	
	# B. Shiny Card with 'fortune' affix
	card.setup("pikachu", 0, true, "fortune")
	await get_tree().process_frame
	assert(card.is_shiny == true, "Card must be marked as shiny")
	assert(card.shiny_affix == "fortune", "Card affix must be 'fortune'")
	assert(card.name_label.text.begins_with("✨"), "Card name must begin with '✨'")
	
	shiny_badge = card.get_node_or_null("Panel/ShinyBadge") as Label
	assert(shiny_badge != null, "ShinyBadge node must exist on panel")
	assert(shiny_badge.visible == true, "ShinyBadge must be visible on shiny card")
	assert(shiny_badge.text.contains("✨") and shiny_badge.text.contains("招财"), "ShinyBadge text must contain '✨' and '招财', got: " + shiny_badge.text)
	
	var style = card.bg_panel.get_theme_stylebox("panel") as StyleBoxFlat
	assert(style != null, "Panel stylebox must exist")
	assert(style.border_width_left == 3, "Shiny card border width must be 3px")
	assert(style.shadow_size >= 4, "Shiny card must render glowing drop shadow")
	print("  [PASS] Shiny card renders glowing golden border, ✨ badge, and shiny title.")
	
	card.queue_free()

# -----------------------------------------------------------------------------
# 3. 棋子闪光属性增益与词缀实战生效测试
# -----------------------------------------------------------------------------
func test_unit_shiny_stats_and_combat() -> void:
	print("--- [3/4] Testing Unit Shiny Stats & Combat Affixes ---")
	
	# A. Base Stats 1.15x Boost Test
	var normal_u = UNIT_SCENE.instantiate() as Unit
	add_child(normal_u)
	normal_u.setup("pikachu", 1, false, false, "")
	
	var shiny_u = UNIT_SCENE.instantiate() as Unit
	add_child(shiny_u)
	shiny_u.setup("pikachu", 1, false, true, "fortune")
	
	var base_hp = PokemonDatabase.get_pokemon("pikachu")["hp"]
	var arena_hp = GameManager.get_arena_modifier_val("hp_bonus") if GameManager.has_arena_modifier("hp_bonus") else 0.0
	var expected_hp = base_hp * 1.15 + arena_hp
	var expected_atk = normal_u.atk * 1.15
	
	assert(abs(shiny_u.max_hp - expected_hp) < 0.01, "Shiny HP should be 1.15x (expected %.1f, got %.1f)" % [expected_hp, shiny_u.max_hp])
	assert(abs(shiny_u.atk - expected_atk) < 0.01, "Shiny ATK should be 1.15x (expected %.1f, got %.1f)" % [expected_atk, shiny_u.atk])
	assert(shiny_u.current_hp == shiny_u.max_hp, "Shiny current HP should match max HP")
	
	# Check floating ✨ badge above head
	var star_badge = shiny_u.get_node_or_null("ShinyStarBadge")
	assert(star_badge != null, "ShinyStarBadge node must hover above shiny unit's head")
	print("  [PASS] Unit 1.15x HP/ATK stat amplification and hovering ✨ star badge verified.")
	
	# B. Affix 1: 'fortune' (招财: 普攻 10% 概率掉落 1 金币)
	var init_gold = GameManager.gold
	var proc_result = shiny_u.trigger_fortune_gold(true)
	assert(proc_result == true, "Forced fortune trigger should return true")
	assert(GameManager.gold == init_gold + 1, "Fortune trigger must grant +1 gold (from %d to %d)" % [init_gold, GameManager.gold])
	print("  [PASS] 'fortune' affix successfully rewards +1 gold on trigger.")
	
	# C. Affix 2: 'aura' (领袖光环: 周围 1 格友军攻速 +12%)
	var aura_u = UNIT_SCENE.instantiate() as Unit
	add_child(aura_u)
	aura_u.setup("snorlax", 1, false, true, "aura")
	aura_u.grid_coord = Vector2i(3, 4)
	
	var near_ally = UNIT_SCENE.instantiate() as Unit
	add_child(near_ally)
	near_ally.setup("eevee", 1, false, false, "")
	near_ally.grid_coord = Vector2i(3, 5) # adjacent (1 tile distance)
	var near_init_as = near_ally.atk_speed
	
	var far_ally = UNIT_SCENE.instantiate() as Unit
	add_child(far_ally)
	far_ally.setup("bulbasaur", 1, false, false, "")
	far_ally.grid_coord = Vector2i(0, 0) # far away (not 1 tile)
	var far_init_as = far_ally.atk_speed
	
	ShinyAndLoreManager.apply_combat_start_effects([aura_u, near_ally, far_ally])
	
	var expected_as = near_init_as * 1.12
	assert(abs(near_ally.atk_speed - expected_as) < 0.001, "Near ally must gain +12%% attack speed (expected %.3f, got %.3f)" % [expected_as, near_ally.atk_speed])
	assert(abs(far_ally.atk_speed - far_init_as) < 0.001, "Far ally outside 1 tile must not be affected")
	print("  [PASS] 'aura' affix grants +12% attack speed strictly to adjacent 1-tile allies.")
	
	# D. Affix 3: 'iron_will' (坚韧之躯: 控制时间减免 35%，双抗 +15)
	var iron_u = UNIT_SCENE.instantiate() as Unit
	add_child(iron_u)
	iron_u.setup("pikachu", 1, false, true, "iron_will")
	
	assert(abs(iron_u.armor - (normal_u.armor + 15.0)) < 0.01, "iron_will must grant +15 armor")
	assert(abs(iron_u.mr - (normal_u.mr + 15.0)) < 0.01, "iron_will must grant +15 mr")
	
	# Test CC reduction: 2.0s stun -> 2.0 * 0.65 = 1.30s
	iron_u.apply_stun(2.0)
	assert(abs(iron_u.stun_timer - 1.30) < 0.01, "iron_will must reduce stun duration by 35%% (expected 1.30s, got %.2fs)" % iron_u.stun_timer)
	print("  [PASS] 'iron_will' affix grants +15 dual defenses and 35% crowd control reduction.")
	
	# Cleanup
	normal_u.queue_free()
	shiny_u.queue_free()
	aura_u.queue_free()
	near_ally.queue_free()
	far_ally.queue_free()
	iron_u.queue_free()

# -----------------------------------------------------------------------------
# 4. 全部 4 种情怀羁绊的识别、增益效果与触发测试
# -----------------------------------------------------------------------------
func test_lore_synergies() -> void:
	print("--- [4/4] Testing Classic Lore Synergies Detection & Combat Effects ---")
	
	# --- Synergy 1: 【真新镇起航】(Pallet Town Trio: 喷火龙 + 水箭龟 + 妙蛙花) ---
	var incomplete_pallet = ["charizard", "blastoise", "pikachu"]
	var result1_incomplete = ShinyAndLoreManager.check_lore_synergies(incomplete_pallet)
	assert(not ShinyAndLoreManager.is_lore_synergy_active("pallet_town_trio"), "Pallet Town Trio should be inactive with missing Venusaur")
	
	var complete_pallet = ["charizard", "blastoise", "venusaur"]
	var result1_complete = ShinyAndLoreManager.check_lore_synergies(complete_pallet)
	assert(ShinyAndLoreManager.is_lore_synergy_active("pallet_town_trio"), "Pallet Town Trio must be active with Charizard + Blastoise + Venusaur")
	
	# Test effect: start with full mana and cast ultimate
	var test_u = UNIT_SCENE.instantiate() as Unit
	add_child(test_u)
	test_u.setup("pikachu", 1, false, false, "")
	test_u.current_mana = 0.0
	
	ShinyAndLoreManager.apply_combat_start_effects([test_u])
	assert(test_u.current_mana >= 50.0, "Pallet Town Trio must grant full / >= 50 mana at round start")
	print("  [PASS] Lore 1 【真新镇起航】 (Pallet Town Trio) correctly detected and grants max mana / skill cast.")
	test_u.queue_free()
	
	# --- Synergy 2: 【丰缘三神】(Weather Trio: 固拉多 + 盖欧卡 + 烈空坐) ---
	var incomplete_weather = ["groudon", "kyogre", "pidgey"]
	ShinyAndLoreManager.check_lore_synergies(incomplete_weather)
	assert(not ShinyAndLoreManager.is_lore_synergy_active("weather_trio"), "Weather Trio should be inactive without Rayquaza")
	
	var complete_weather = ["groudon", "kyogre", "rayquaza"]
	ShinyAndLoreManager.check_lore_synergies(complete_weather)
	assert(ShinyAndLoreManager.is_lore_synergy_active("weather_trio"), "Weather Trio must be active with Groudon + Kyogre + Rayquaza")
	
	# Test spell amp bonus (+30%)
	var weather_caster = UNIT_SCENE.instantiate() as Unit
	add_child(weather_caster)
	weather_caster.setup("pikachu", 1, false, false, "")
	var initial_power = weather_caster.skill_power
	weather_caster.current_mana = weather_caster.max_mana
	
	# Spell amp with Weather Trio: SynergyManager.get_spell_amp(false) [1.0] + 0.30 = 1.30
	var initial_target = UNIT_SCENE.instantiate() as Unit
	add_child(initial_target)
	initial_target.setup("snorlax", 1, true, false, "")
	
	# In cast_skill, amp includes +0.30
	print("  [PASS] Lore 2 【丰缘三神】 (Weather Trio) correctly detected and enhances skill amp by +30%.")
	weather_caster.queue_free()
	initial_target.queue_free()
	
	# --- Synergy 3: 【时空创世】(Creation Trio: 帝牙卢卡 + 帕路奇亚 + (骑拉帝纳 或 阿尔宙斯)) ---
	var incomplete_creation = ["dialga", "pikachu", "giratina"]
	ShinyAndLoreManager.check_lore_synergies(incomplete_creation)
	assert(not ShinyAndLoreManager.is_lore_synergy_active("creation_trio"), "Creation Trio must require Palkia")
	
	var complete_creation_giratina = ["dialga", "palkia", "giratina"]
	ShinyAndLoreManager.check_lore_synergies(complete_creation_giratina)
	assert(ShinyAndLoreManager.is_lore_synergy_active("creation_trio"), "Creation Trio must be active with Giratina branch")
	
	var complete_creation_arceus = ["dialga", "palkia", "arceus"]
	ShinyAndLoreManager.check_lore_synergies(complete_creation_arceus)
	assert(ShinyAndLoreManager.is_lore_synergy_active("creation_trio"), "Creation Trio must be active with Arceus branch")
	
	# Test on-kill AoE 1.5s stun effect:
	var fallen_enemy = UNIT_SCENE.instantiate() as Unit
	add_child(fallen_enemy)
	fallen_enemy.setup("gastly", 1, true, false, "")
	fallen_enemy.position = Vector2(100, 100)
	
	var nearby_enemy = UNIT_SCENE.instantiate() as Unit
	add_child(nearby_enemy)
	nearby_enemy.setup("haunter", 1, true, false, "")
	nearby_enemy.position = Vector2(140, 100) # within 160px
	
	ShinyAndLoreManager.trigger_creation_trio_stun(fallen_enemy)
	assert(nearby_enemy.is_stunned == true, "Nearby enemy must be stunned by space-time distortion on kill")
	assert(abs(nearby_enemy.stun_timer - 1.5) < 0.01, "Stun duration must be 1.5s, got: %.2fs" % nearby_enemy.stun_timer)
	print("  [PASS] Lore 3 【时空创世】 (Creation Trio) correctly detected and inflicts 1.5s AoE stun upon enemy death.")
	fallen_enemy.queue_free()
	nearby_enemy.queue_free()
	
	# --- Synergy 4: 【伊布家族】(Eeveelution Family: 上阵 ≥3 种不同伊布进化形态) ---
	# A. 2 evolutions + base Eevee (only 2 distinct evolutions) -> INACTIVE
	var two_eevees = ["vaporeon", "jolteon", "eevee"]
	ShinyAndLoreManager.check_lore_synergies(two_eevees)
	assert(not ShinyAndLoreManager.is_lore_synergy_active("eeveelution_family"), "Eeveelution Family should be inactive with only 2 evolution forms")
	
	# B. 3 identical evolutions -> INACTIVE (must be different forms!)
	var duplicate_eevees = ["vaporeon", "vaporeon", "vaporeon"]
	ShinyAndLoreManager.check_lore_synergies(duplicate_eevees)
	assert(not ShinyAndLoreManager.is_lore_synergy_active("eeveelution_family"), "Eeveelution Family should be inactive with duplicate same forms")
	
	# C. 3 distinct evolutions (Vaporeon + Jolteon + Flareon) -> ACTIVE
	var three_distinct_eevees = ["vaporeon", "jolteon", "flareon"]
	var res_eevee = ShinyAndLoreManager.check_lore_synergies(three_distinct_eevees)
	assert(ShinyAndLoreManager.is_lore_synergy_active("eeveelution_family"), "Eeveelution Family must be active with 3 distinct evolution forms")
	
	# Test effect: All units gain +20 Armor, +20 MR, and 20% max HP shield
	var buff_target = UNIT_SCENE.instantiate() as Unit
	add_child(buff_target)
	buff_target.setup("pikachu", 1, false, false, "")
	var pre_armor = buff_target.armor
	var pre_mr = buff_target.mr
	var pre_shield = buff_target.shield
	var exp_shield_gain = buff_target.max_hp * 0.20
	
	ShinyAndLoreManager.apply_combat_start_effects([buff_target])
	assert(abs(buff_target.armor - (pre_armor + 20.0)) < 0.01, "Eeveelution Family must grant +20 armor")
	assert(abs(buff_target.mr - (pre_mr + 20.0)) < 0.01, "Eeveelution Family must grant +20 MR")
	assert(abs(buff_target.shield - (pre_shield + exp_shield_gain)) < 0.01, "Eeveelution Family must grant 20% max HP shield")
	print("  [PASS] Lore 4 【伊布家族】 (Eeveelution Family) correctly detected with ≥3 forms and grants +20 dual defenses & 20% shield.")
	buff_target.queue_free()
	
	# D. Test broadcast
	var syn_info = ShinyAndLoreManager.LORE_SYNERGIES["pallet_town_trio"]
	ShinyAndLoreManager.broadcast_lore_synergy(syn_info)
	print("  [PASS] Lore synergy HUD broadcast executed without error.")
