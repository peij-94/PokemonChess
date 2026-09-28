extends Node

func _ready() -> void:
	print("\n=== STARTING 3-STAR EVOLUTION & CHARACTER INFO POPUP TESTS ===")
	await get_tree().process_frame
	
	var main_scene = load("res://scenes/main.tscn")
	assert(main_scene != null, "main.tscn must load")
	var main_node = main_scene.instantiate()
	add_child(main_node)
	await get_tree().process_frame
	
	var board = GameManager.board_ref
	assert(board != null, "Board reference must be set")
	var hud = main_node.get_node("HUD")
	assert(hud != null, "HUD reference must be set")
	
	# Clear any starter units
	for u in board.get_deployed_player_units():
		board.board_grid[u.grid_coord.x][u.grid_coord.y] = null
		u.queue_free()
	for i in range(board.bench_slots.size()):
		if board.bench_slots[i] != null:
			board.bench_slots[i].queue_free()
			board.bench_slots[i] = null
	await get_tree().process_frame
	
	# --- Test 1: ★1 -> ★2 Synthesis Does NOT Evolve (Only 3-Star Can Evolve) ---
	print("\n--- Test 1: 3x ★1 Synthesis Stays Same Species at ★2 (No Evolution Yet) ---")
	var u1 = board.add_pokemon_to_bench("charmander", 1)
	var u2 = board.add_pokemon_to_bench("charmander", 1)
	var u3 = board.add_pokemon_to_bench("charmander", 1)
	
	board.check_and_execute_evolutions()
	await get_tree().process_frame
	await get_tree().process_frame
	
	var star2_unit: Unit = null
	for b_u in board.bench_slots:
		if b_u != null and is_instance_valid(b_u):
			star2_unit = b_u
			break
	assert(star2_unit != null, "Should have 1 synthesized unit on bench")
	assert(star2_unit.pokemon_id == "charmander", "3x ★1 Charmander must merge to Charmander ★2 (NOT evolve yet), got: %s" % star2_unit.pokemon_id)
	assert(star2_unit.star_level == 2, "Unit star_level must be 2")
	print("  [PASS] 3x Charmander ★1 merged into: %s ★%d!" % [star2_unit.pokemon_id, star2_unit.star_level])
	
	# Verify that Star 2 skill choice was requested for Charmander
	var skill_modal: SkillChoiceModal = hud.skill_choice_modal
	assert(skill_modal != null, "SkillChoiceModal must exist")
	skill_modal.open_for_unit(star2_unit, 2)
	assert(skill_modal.current_pokemon_id == "charmander", "Modal should load charmander")
	assert(skill_modal.current_star_level == 2, "Modal star level should be 2")
	assert(skill_modal.available_choices.size() > 0, "Should have star 2 skill choices")
	print("  [PASS] Star 2 skill choice verified for Charmander ★2: %s" % skill_modal.available_choices[0].get("name", ""))
	skill_modal.close()
	
	# --- Test 2: ★2 -> ★3 Synthesis Reaches Max Star and Triggers Evolution Choice ---
	print("\n--- Test 2: 3x ★2 Synthesis Reaches ★3 and Triggers Evolution Choice ---")
	# Add 2 more Charmander ★2 to bench
	var u4 = board.add_pokemon_to_bench("charmander", 2)
	var u5 = board.add_pokemon_to_bench("charmander", 2)
	
	board.check_and_execute_evolutions()
	await get_tree().process_frame
	await get_tree().process_frame
	
	var star3_unit: Unit = null
	for b_u in board.bench_slots:
		if b_u != null and is_instance_valid(b_u):
			star3_unit = b_u
			break
	assert(star3_unit != null, "Should have 1 synthesized unit on bench")
	assert(star3_unit.star_level == 3, "Unit should now be ★3, got: %d" % star3_unit.star_level)
	print("  [PASS] 3x Charmander ★2 merged into ★3 max-star unit!")
	
	# Verify evolution choice modal
	var evo_modal = hud.evolution_choice_modal
	assert(evo_modal != null, "EvolutionChoiceModal must exist in HUD")
	assert(evo_modal.visible, "EvolutionChoiceModal should pop up automatically upon reaching ★3")
	print("  [PASS] EvolutionChoiceModal automatically popped up for ★3 unit!")
	
	# --- Test 3: Player Chooses Evolution Form -> Charizard ★3 -> Opens 3-Star Skill Choice ---
	print("\n--- Test 3: Choosing Evolved Form (Charizard ★3) & Selecting 3-Star Skill ---")
	# Player selects Charizard form
	evo_modal._on_form_chosen("charizard", true)
	await get_tree().process_frame
	
	assert(star3_unit.pokemon_id == "charizard", "Unit should have evolved to charizard, got: %s" % star3_unit.pokemon_id)
	assert(star3_unit.star_level == 3, "Unit should remain ★3")
	assert(not evo_modal.visible, "EvolutionChoiceModal should close after selection")
	assert(skill_modal.visible, "SkillChoiceModal should immediately open for 3-star skills!")
	assert(skill_modal.current_pokemon_id == "charizard", "Skill choices should be for charizard")
	assert(skill_modal.current_star_level == 3, "Skill choices should be at 3-star power")
	assert(skill_modal.available_choices[0].get("power", 0) >= 500, "3-Star skills should have ultimate power")
	print("  [PASS] Successfully evolved to Charizard ★3 and loaded 3-Star skills: %s (Power: %d)" % [
		skill_modal.available_choices[0].get("name", ""),
		int(skill_modal.available_choices[0].get("power", 0))
	])
	
	# Player selects skill 0
	var chosen_skill_name = skill_modal.available_choices[0].get("name", "")
	skill_modal._on_skill_selected(0)
	assert(star3_unit.skill_name == chosen_skill_name, "Unit should equip selected 3-star skill")
	print("  [PASS] Equipped 3-star skill confirmed: %s" % star3_unit.skill_name)
	
	# --- Test 4: Can Also Choose NOT To Evolve (Keep Form at ★3) ---
	print("\n--- Test 4: Can Choose NOT to Evolve (Keep Base Form at ★3) ---")
	var pika1 = board.add_pokemon_to_bench("pikachu", 2)
	var pika2 = board.add_pokemon_to_bench("pikachu", 2)
	var pika3 = board.add_pokemon_to_bench("pikachu", 2)
	
	board.check_and_execute_evolutions()
	await get_tree().process_frame
	await get_tree().process_frame
	
	var star3_pika: Unit = null
	for b_u in board.bench_slots:
		if b_u != null and is_instance_valid(b_u) and b_u != star3_unit:
			star3_pika = b_u
			break
	assert(star3_pika != null, "Should have 3-star Pikachu")
	assert(evo_modal.visible, "EvolutionChoiceModal should open for Pikachu ★3")
	
	# Player clicks "保持形态 (不进化)"
	evo_modal._on_form_chosen(star3_pika.pokemon_id, false)
	await get_tree().process_frame
	
	assert(star3_pika.pokemon_id == "pikachu", "Unit must remain Pikachu (not evolve)")
	assert(star3_pika.star_level == 3, "Pikachu must be ★3")
	assert(skill_modal.visible, "SkillChoiceModal should open for Pikachu ★3")
	assert(skill_modal.current_pokemon_id == "pikachu", "Skill choices must be for Pikachu")
	assert(skill_modal.current_star_level == 3, "Skill choices must be 3-star power")
	print("  [PASS] Pikachu kept base form at ★3 and loaded Pikachu 3-star skills: %s" % skill_modal.available_choices[0].get("name", ""))
	skill_modal.close()
	
	# --- Test 5: Single Clicking Character Pops Up Detailed Character Info ---
	print("\n--- Test 5: Single Clicking Character Pops Up UnitDetailModal ---")
	var detail_modal = hud.unit_detail_modal
	assert(detail_modal != null, "UnitDetailModal must exist in HUD")
	assert(not detail_modal.visible, "Detail modal should be closed initially")
	
	# Simulate left-clicking star3_unit (Charizard ★3)
	board._on_unit_clicked(star3_unit)
	await get_tree().process_frame
	
	assert(detail_modal.visible, "UnitDetailModal must be visible after clicking unit!")
	assert(detail_modal.name_label.text.contains("喷火龙"), "Detail modal should show Charizard name")
	assert(detail_modal.name_label.text.contains("★★★"), "Detail modal should show 3 stars")
	assert(detail_modal.hp_label.text.contains("生命:"), "HP label must be populated")
	assert(detail_modal.mp_label.text.contains("法力:"), "MP label must be populated")
	assert(detail_modal.skill_title_lbl.text.contains(star3_unit.skill_name), "Skill title must show equipped skill name")
	assert(detail_modal.skill_detail_lbl.text != "", "Skill detail description must not be empty!")
	assert(detail_modal.switch_form_btn.visible, "Switch form button must be visible for ★3 unit with evolution chain")
	assert(detail_modal.switch_skill_btn.visible, "Switch skill button must be visible for ★3 unit")
	print("  [PASS] UnitDetailModal successfully popped up with full attributes and skill description:")
	print("    Name: %s" % detail_modal.name_label.text)
	print("    Skill: %s" % detail_modal.skill_title_lbl.text)
	print("    Detail: %s" % detail_modal.skill_detail_lbl.text)
	
	# Test clicking enemy unit in combat phase
	print("\n--- Test 6: Clicking Enemy Unit Pops Up Enemy Info ---")
	GameManager.force_start_combat()
	await get_tree().process_frame
	await get_tree().process_frame
	
	var enemy_unit: Unit = null
	for c in board.units_container.get_children():
		if c is Unit and c.is_enemy:
			enemy_unit = c
			break
	assert(enemy_unit != null, "Enemy unit should exist in combat phase")
	
	board._on_unit_clicked(enemy_unit)
	await get_tree().process_frame
	
	assert(detail_modal.visible, "Detail modal should open when clicking enemy unit")
	var enemy_data = PokemonDatabase.get_pokemon(enemy_unit.pokemon_id)
	assert(detail_modal.name_label.text.contains(enemy_data["name"]), "Modal should show enemy name")
	assert(detail_modal.actions_hbox.visible == false, "Action buttons (sell/swap) must be hidden for enemy units")
	print("  [PASS] Enemy inspection verified: %s (Actions properly hidden)" % detail_modal.name_label.text)
	
	# Clean up and conclude
	main_node.queue_free()
	
	print("\n=======================================================")
	print(">>> ALL 3-STAR EVOLUTION & CHARACTER POPUP TESTS PASSED! <<<")
	print("=======================================================")
	get_tree().quit(0)
