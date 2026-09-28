extends Node

func _ready() -> void:
	print("\n=== STARTING POKEDEX EVOLUTION & BRANCH SKILLS TEST ===")
	await get_tree().process_frame
	
	var p_scene = load("res://scenes/pokedex_modal.tscn")
	assert(p_scene != null, "pokedex_modal.tscn should load")
	var pokedex = p_scene.instantiate()
	add_child(pokedex)
	await get_tree().process_frame
	
	# Test 1: Evolution chain resolution
	print("\n--- Test 1: Evolution Chain Resolution ---")
	var chain_cm = pokedex.get_evolution_chain("charmander")
	assert(chain_cm == ["charmander", "charmeleon", "charizard"], "Charmander chain should be charmander -> charmeleon -> charizard")
	print("  [PASS] Charmander chain: ", chain_cm)
	
	var chain_pika = pokedex.get_evolution_chain("pikachu")
	assert(chain_pika == ["pikachu", "raichu"], "Pikachu chain should be pikachu -> raichu")
	print("  [PASS] Pikachu chain: ", chain_pika)
	
	var chain_sn = pokedex.get_evolution_chain("snorlax")
	assert(chain_sn == ["snorlax"], "Snorlax chain should be [snorlax]")
	print("  [PASS] Snorlax chain: ", chain_sn)
	
	# Test 2: Showcase Charmander and verify star tabs labels
	print("\n--- Test 2: Showcase Charmander & Star Tabs ---")
	pokedex.showcase_pokemon("charmander", 1, 0, false)
	assert(pokedex.name_label.text == "小火龙", "Name should be 小火龙")
	assert(pokedex.star1_btn.text == "★1 基础技能", "Star 1 tab should be ★1 基础技能")
	assert(pokedex.star2_btn.text == "★2 进阶技能", "Star 2 tab should be ★2 进阶技能")
	assert(pokedex.star3_btn.text == "★3 终极技能", "Star 3 tab should be ★3 终极技能")
	assert(pokedex.basic_atk_btn.text == "💥 普通攻击", "Basic attack tab should be 💥 普通攻击")
	assert(pokedex.skill_title.text.contains("火花"), "Star 1 Charmander skill should be 火花")
	assert(pokedex.skill_desc.text.contains("火花"), "Desc should contain 火花")
	assert(pokedex.skill_desc.text.contains("可选招式一览"), "Desc should contain 3-skill overview")
	print("  [PASS] Charmander Star 1 skill verified: %s" % pokedex.skill_title.text)
	
	# Test 3: Switch to Star 2 (should stay Charmander and display Charmander's Star 2 skills)
	print("\n--- Test 3: Switch to Star 2 (Stay Charmander, 3 Star 2 skills) ---")
	pokedex._on_star_tab_pressed(2)
	assert(pokedex.selected_id == "charmander", "Selected ID should stay charmander")
	assert(pokedex.name_label.text == "小火龙", "Name should stay 小火龙")
	assert(pokedex.current_skill_star == 2, "Current star should be 2")
	assert(pokedex.skill_title.text.contains("火焰旋涡"), "Star 2 Charmander skill should be 火焰旋涡, got: %s" % pokedex.skill_title.text)
	assert(pokedex.branch1_btn.text.contains("火焰旋涡"), "Branch 1 should be 火焰旋涡")
	assert(pokedex.branch2_btn.text.contains("乱抓"), "Branch 2 should be 乱抓")
	assert(pokedex.branch3_btn.text.contains("喷射火焰"), "Branch 3 should be 喷射火焰")
	assert(pokedex.skill_desc.text.contains("火焰旋涡"), "Desc should introduce 火焰旋涡")
	assert(pokedex.skill_desc.text.contains("乱抓"), "Desc should introduce 乱抓")
	assert(pokedex.skill_desc.text.contains("喷射火焰"), "Desc should introduce 喷射火焰")
	print("  [PASS] Star 2 Charmander 3 skills verified: %s" % pokedex.skill_title.text)
	
	# Test 4: Switch to Star 3 (should stay Charmander and display Charmander's Star 3 skills)
	print("\n--- Test 4: Switch to Star 3 (Stay Charmander, 3 Star 3 skills) ---")
	pokedex._on_star_tab_pressed(3)
	assert(pokedex.selected_id == "charmander", "Selected ID should stay charmander")
	assert(pokedex.name_label.text == "小火龙", "Name should stay 小火龙")
	assert(pokedex.current_skill_star == 3, "Current star should be 3")
	assert(pokedex.skill_title.text.contains("炼狱"), "Star 3 Charmander skill should be 炼狱, got: %s" % pokedex.skill_title.text)
	assert(pokedex.branch1_btn.text.contains("炼狱"), "Branch 1 should be 炼狱")
	assert(pokedex.branch2_btn.text.contains("闪焰冲锋"), "Branch 2 should be 闪焰冲锋")
	assert(pokedex.branch3_btn.text.contains("爆炸烈焰"), "Branch 3 should be 爆炸烈焰")
	assert(pokedex.skill_desc.text.contains("炼狱"), "Desc should introduce 炼狱")
	assert(pokedex.skill_desc.text.contains("爆炸烈焰"), "Desc should introduce 爆炸烈焰")
	print("  [PASS] Star 3 Charmander 3 skills verified: %s" % pokedex.skill_title.text)
	
	# Test 5: Branching Skills Switching on Charmander Star 3
	print("\n--- Test 5: Branching Skills Switching on Charmander Star 3 ---")
	# Click Branch 2 (闪焰冲锋)
	pokedex._on_branch_btn_pressed(1)
	assert(pokedex.current_branch_idx == 1, "Branch index should be 1")
	assert(pokedex.skill_title.text.contains("闪焰冲锋"), "Title should update to 闪焰冲锋")
	assert(pokedex.skill_desc.text.contains("闪焰冲锋"), "Desc should update to 闪焰冲锋")
	print("  [PASS] Branch 2 switch verified: %s" % pokedex.skill_title.text)
	
	# Click Branch 3 (爆炸烈焰)
	pokedex._on_branch_btn_pressed(2)
	assert(pokedex.current_branch_idx == 2, "Branch index should be 2")
	assert(pokedex.skill_title.text.contains("爆炸烈焰"), "Title should update to 爆炸烈焰")
	print("  [PASS] Branch 3 switch verified: %s" % pokedex.skill_title.text)
	
	# Test 6: Evolution chain navigation via header
	print("\n--- Test 6: Evolution Chain Header Navigation ---")
	# Navigating to Charmeleon explicitly through evolution chain header
	pokedex.showcase_pokemon("charmeleon", 1, 0, false)
	assert(pokedex.selected_id == "charmeleon", "Selected ID should now be charmeleon")
	assert(pokedex.name_label.text == "火恐龙", "Name should be 火恐龙")
	pokedex._on_star_tab_pressed(2)
	assert(pokedex.selected_id == "charmeleon", "Selected ID should stay charmeleon")
	assert(pokedex.skill_title.text.contains("喷射火焰"), "Charmeleon star 2 skill should be 喷射火焰")
	print("  [PASS] Evolution chain navigation to Charmeleon verified!")
	
	# Test 7: Single-stage Pokémon (Snorlax)
	print("\n--- Test 7: Single-stage Pokémon (Snorlax) ---")
	pokedex.showcase_pokemon("snorlax", 1, 0, false)
	assert(pokedex.name_label.text == "卡比兽", "Name should be 卡比兽")
	assert(pokedex.cost_label.text.contains("单阶段"), "Cost label should indicate single-stage")
	assert(pokedex.star1_btn.text == "★1 基础技能", "Star 1 should say ★1 基础技能")
	assert(pokedex.star2_btn.text == "★2 进阶技能", "Star 2 should say ★2 进阶技能")
	assert(pokedex.star3_btn.text == "★3 终极技能", "Star 3 should say ★3 终极技能")
	pokedex._on_star_tab_pressed(2)
	assert(pokedex.selected_id == "snorlax", "Should remain snorlax at star 2")
	assert(pokedex.current_skill_star == 2, "Star should be 2")
	print("  [PASS] Snorlax single-stage behavior verified!")
	
	# Test 8: Equipped Badge check
	print("\n--- Test 8: Equipped Badge on Unit ---")
	# Fake a unit in GameManager.board_ref
	var dummy_board = Node2D.new()
	var unit_scene = load("res://scenes/unit.tscn")
	var dummy_unit = unit_scene.instantiate()
	add_child(dummy_unit)
	dummy_unit.setup("charizard", 3, false)
	var charizard_choices = PokemonDatabase.get_skill_choices("charizard", 3)
	dummy_unit.selected_skill = charizard_choices[2] # 炼狱 (index 2 in charizard star 3)
	dummy_unit.skill_name = "炼狱"
	
	dummy_board.set_script(load("res://scripts/board.gd"))
	dummy_board.selected_unit = dummy_unit
	GameManager.board_ref = dummy_board
	
	# Showcase Charizard Star 3 Branch 2 (炼狱)
	pokedex.showcase_pokemon("charizard", 3, 2, false)
	assert(pokedex.equipped_badge.visible, "Equipped badge should be visible when viewing equipped skill")
	assert(pokedex.equipped_badge.text.contains("已装备"), "Equipped badge text should contain 已装备")
	print("  [PASS] Equipped badge is visible on equipped skill (炼狱)!")
	
	# Switch to Branch 0 (爆炸烈焰) -> should NOT be equipped
	pokedex._on_branch_btn_pressed(0)
	assert(not pokedex.equipped_badge.visible, "Equipped badge should NOT be visible on unequipped skill")
	print("  [PASS] Equipped badge is hidden on unequipped skill (爆炸烈焰)!")
	
	# Cleanup
	pokedex.queue_free()
	dummy_unit.queue_free()
	dummy_board.queue_free()
	GameManager.board_ref = null
	
	print("\n==================================================")
	print(">>> ALL POKEDEX SKILLS & EVOLUTION TESTS PASSED! <<<")
	print("==================================================")
	get_tree().quit(0)
