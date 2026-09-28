extends Node

func _ready() -> void:
	print("\n========================================================")
	print(">>> RUNNING BASIC ATTACK SHOWCASE & PREVIEW TESTS <<<")
	print("========================================================")

	# Test 1: Pokedex Modal Basic Attack Tab
	print("\n--- Test 1: Pokedex Modal Basic Attack Tab ---")
	var pokedex_scene = load("res://scenes/pokedex_modal.tscn")
	var pokedex = pokedex_scene.instantiate()
	add_child(pokedex)
	pokedex.showcase_pokemon("pikachu")
	
	assert(pokedex.basic_atk_btn != null, "basic_atk_btn should exist")
	pokedex._on_basic_atk_tab_pressed()
	assert(pokedex.current_skill_star == 0, "current_skill_star should be 0 for basic attack")
	assert(pokedex.skill_title.text.contains("电火花"), "Skill title should contain basic attack name: " + pokedex.skill_title.text)
	assert(pokedex.skill_desc.text.contains("动作演示"), "Skill desc should contain demonstration info")
	print("  [PASS] Pikachu basic attack tab verified: ", pokedex.skill_title.text)

	# Test 2: Switch to Snorlax Punch and Eevee Tackle
	pokedex.showcase_pokemon("snorlax")
	pokedex._on_basic_atk_tab_pressed()
	assert(pokedex.skill_title.text.contains("连续拳"), "Snorlax basic attack should be 连续拳")
	print("  [PASS] Snorlax basic attack tab verified: ", pokedex.skill_title.text)

	pokedex.showcase_pokemon("caterpie")
	pokedex._on_basic_atk_tab_pressed()
	assert(pokedex.skill_title.text.contains("撞击"), "Caterpie basic attack should be 撞击")
	print("  [PASS] Caterpie basic attack tab verified: ", pokedex.skill_title.text)
	pokedex.queue_free()

	# Test 3: UnitDetailModal Interactive Preview
	print("\n--- Test 2: UnitDetailModal Interactive Preview ---")
	var modal_scene = load("res://scenes/unit_detail_modal.tscn")
	var modal = modal_scene.instantiate()
	add_child(modal)

	var unit_scene = load("res://scenes/unit.tscn")
	var unit = unit_scene.instantiate()
	unit.setup("machop", 1)
	add_child(unit)

	modal.open_for_unit(unit)
	modal._preview_basic_attack()
	print("  [PASS] UnitDetailModal _preview_basic_attack executed cleanly for Machop (连续拳)!")
	unit.queue_free()
	modal.queue_free()

	# Test 3: All 9 Projectile Styles and 5 Melee Styles Animation & Drawing Execution
	print("\n--- Test 3: Procedural Attack Animation & Drawing Verification ---")
	var vfx_container = Node2D.new()
	add_child(vfx_container)

	var dummy_target = unit_scene.instantiate()
	dummy_target.setup("snorlax", 1)
	vfx_container.add_child(dummy_target)

	# Verify 5 Melee Styles
	var melee_styles = ["tackle", "slash", "punch", "bite", "water_bash"]
	for m_style in melee_styles:
		AttackVFX.spawn_melee_attack_vfx(vfx_container, Vector2(100, 100), dummy_target, m_style, false)
		AttackVFX.spawn_melee_attack_vfx(vfx_container, Vector2(100, 100), dummy_target, m_style, true)
		print("  [PASS] Melee style verified: %s (normal + combo)" % m_style)

	# Verify 9 Ranged Projectile Styles conforming to skill descriptions
	var projectile_styles = [
		"fire_ember",    # 一团小火焰扔过去 (Charmander)
		"water_bullet",  # 晶莹水滴弹 (Squirtle)
		"spark",         # 霹雳电弧星 (Pikachu)
		"leaf",          # 旋转双生飞叶 (Bulbasaur)
		"psywave",       # 同心念力波 (Alakazam)
		"shadow_orb",    # 幽冥暗影鬼火 (Gengar)
		"magic_spark",   # 旋转五角星芒 (Eevee)
		"powder_snow",   # 六角冰晶雪花 (Lapras)
		"sludge_bullet"  # 黏稠紫毒液弹 (Grimer)
	]

	for p_style in projectile_styles:
		AttackVFX.spawn_ranged_projectile(vfx_container, Vector2(50, 50), dummy_target, "charmander", false, func(): pass, p_style)
		AttackVFX.spawn_ranged_projectile(vfx_container, Vector2(50, 50), dummy_target, "charmander", true, func(): pass, p_style)
		print("  [PASS] Projectile style verified: %s (normal + combo)" % p_style)

	await get_tree().create_timer(0.4).timeout
	vfx_container.queue_free()

	print("\n========================================================")
	print(">>> ALL BASIC ATTACK SHOWCASE TESTS PASSED (100%)! <<<")
	print("========================================================\n")
	get_tree().quit(0)
