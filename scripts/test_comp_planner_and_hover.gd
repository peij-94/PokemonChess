extends Node

func _ready() -> void:
	print("\n========================================================")
	print(">>> STARTING TEAM PLANNER & HOVER TREE TESTS <<<")
	print("========================================================")
	
	# --- Test 1: Team Comp Planner Presets & Selection ---
	print("\n--- Test 1: Team Comp Planner Presets & Selection ---")
	const TeamCompPlannerScript = preload("res://scripts/team_comp_planner.gd")
	var planner_scene = load("res://scenes/team_comp_planner.tscn")
	var planner = planner_scene.instantiate()
	add_child(planner)
	
	assert(TeamCompPlannerScript.PRESET_COMPS.size() >= 6, "Must provide at least 6 authentic meta compositions")
	var deep_sea = TeamCompPlannerScript.PRESET_COMPS[0]
	assert("深海风暴流" in deep_sea["name"], "First preset should be Deep Sea Storm")
	
	# Select Deep Sea Storm as target comp
	planner._select_comp(deep_sea)
	assert(GameManager.target_team_comp["id"] == "deep_sea", "Target comp in GameManager should be 'deep_sea'")
	assert(GameManager.is_target_pokemon("squirtle"), "Squirtle should be target pokemon in Deep Sea comp")
	assert(GameManager.is_target_pokemon("gyarados"), "Gyarados should be target pokemon in Deep Sea comp")
	assert(not GameManager.is_target_pokemon("charmander"), "Charmander should NOT be in Deep Sea comp")
	print("  [PASS] Target composition '深海风暴流' set and target check verified.")
	
	# --- Test 2: Shop Card Highlight with Target Badge ---
	print("\n--- Test 2: Shop Card Highlight with Target Badge ---")
	var card_scene = load("res://scenes/shop_card.tscn")
	var card_target = card_scene.instantiate()
	add_child(card_target)
	card_target.setup("squirtle", 0)
	
	var badge = card_target.get_node("Panel/TargetBadge") as Label
	assert(badge != null, "TargetBadge should exist on shop card")
	assert(badge.visible, "TargetBadge should be visible for target comp unit")
	assert("⭐阵容所需" in badge.text, "TargetBadge text should contain '⭐阵容所需'")
	print("  [PASS] Shop Card properly displays golden highlight badge '⭐阵容所需' for target unit.")
	
	var card_other = card_scene.instantiate()
	add_child(card_other)
	card_other.setup("charmander", 1)
	var other_badge = card_other.get_node("Panel/TargetBadge") as Label
	assert(not other_badge.visible, "TargetBadge should be hidden for non-target unit")
	print("  [PASS] TargetBadge properly hidden for non-target unit.")
	
	# --- Test 3: Shop Card 2-Star Critical Upgrade Badge ---
	print("\n--- Test 3: Shop Card 2-Star Critical Upgrade Badge ---")
	# Temporarily clear target comp
	GameManager.set_target_team_comp({})
	
	# Mock board owning 2 Charmanders
	var main_scene = load("res://scenes/main.tscn")
	var main_inst = main_scene.instantiate()
	add_child(main_inst)
	var board = main_inst.get_node("Board")
	board.spawn_unit_at_coord("charmander", Vector2i(1, 3), 1, false)
	board.spawn_unit_at_coord("charmander", Vector2i(2, 3), 1, false)
	
	var card_char = card_scene.instantiate()
	add_child(card_char)
	card_char.setup("charmander", 2)
	var char_badge = card_char.get_node("Panel/TargetBadge") as Label
	assert(char_badge.visible, "Badge should be visible when player owns 2 copies")
	assert("🔥升星关键" in char_badge.text, "Badge should say '🔥升星关键' when player owns 2 copies")
	print("  [PASS] Shop Card properly displays critical upgrade badge '🔥升星关键' when owning 2 copies.")
	
	# --- Test 4: Item Bench Live Crafting Matrix in Tooltip ---
	print("\n--- Test 4: Item Bench Live Crafting Matrix in Tooltip ---")
	var bench = main_inst.get_node("HUD/ItemBench")
	assert(bench != null, "ItemBench should be present in HUD")
	bench.clear_all()
	
	# Add Razor Claw and Scope Lens to bench
	bench.add_item("razor_claw")
	bench.add_item("scope_lens")
	
	# Inspect Razor Claw tooltip
	var slot0 = bench.slot_buttons[0]
	bench._show_tooltip_for_item("razor_claw", slot0)
	assert(bench.tooltip_panel.visible, "Tooltip should be visible")
	
	var tt_vbox = bench.tooltip_panel.get_node("VBox")
	var found_live_crafting = false
	for child in tt_vbox.get_children():
		var lbl = child as Label
		if lbl and "即刻可合" in lbl.text:
			found_live_crafting = true
			break
			
	assert(found_live_crafting, "Tooltip must include '即刻可合' live crafting matrix header!")
	print("  [PASS] Item Bench tooltip dynamically generates live crafting matrix with currently held inventory!")
	
	print("\n========================================================")
	print(">>> ALL TEAM PLANNER & HOVER TREE TESTS PASSED (100%) <<<")
	print("========================================================\n")
	get_tree().quit(0)
