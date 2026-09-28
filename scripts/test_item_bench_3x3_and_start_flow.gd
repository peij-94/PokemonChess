extends Node

func _ready() -> void:
	print("\n========================================================")
	print(">>> RUNNING ITEM BENCH 3X3 & START FLOW VERIFICATION <<<")
	print("========================================================")
	
	test_3x3_structure()
	await test_main_scene_layout_and_start_flow()
	
	print("\n========================================================")
	print(">>> ALL ITEM BENCH 3X3 & START FLOW CHECKS PASSED! <<<")
	print("========================================================")
	get_tree().quit(0)

func test_3x3_structure() -> void:
	print("\n--- Test 1: Item Bench 3x3 Grid Structure & Capacity ---")
	var bench_scene = load("res://scenes/item_bench.tscn")
	assert(bench_scene != null, "scenes/item_bench.tscn must exist")
	var bench = bench_scene.instantiate() as ItemBench
	add_child(bench)
	await get_tree().process_frame
	
	assert(bench.MAX_SLOTS == 9, "ItemBench must have 9 slots for 3x3 grid")
	assert(bench.slots.size() == 9, "slots array must contain 9 slots")
	assert(bench.slots_container is GridContainer, "slots_container must be a GridContainer")
	var grid = bench.slots_container as GridContainer
	assert(grid.columns == 3, "GridContainer columns must be 3")
	assert(bench.slot_buttons.size() == 9, "Must have 9 slot buttons created")
	assert(bench.count_label.text == "(0/9)", "Count label should display (0/9), got: %s" % bench.count_label.text)
	assert("3x3" in bench.title_label.text, "Title label should mention 3x3")
	
	print("  [PASS] ItemBench verified as 3x3 GridContainer with 9 slots.")
	bench.queue_free()

func test_main_scene_layout_and_start_flow() -> void:
	print("\n--- Test 2: Main Scene Initial Start Menu State ---")
	var main_scene = load("res://scenes/main.tscn")
	assert(main_scene != null, "scenes/main.tscn must exist")
	var main_node = main_scene.instantiate()
	add_child(main_node)
	await get_tree().process_frame
	
	var hud = main_node.get_node("HUD")
	var item_bench = hud.get_node_or_null("ItemBench") as ItemBench
	assert(item_bench != null, "ItemBench must exist under HUD")
	var start_menu = hud.get_node_or_null("StartMenuModal") as Panel
	assert(start_menu != null, "StartMenuModal must exist under HUD")
	var shop_panel = hud.get_node_or_null("ShopPanel") as Panel
	assert(shop_panel != null, "ShopPanel must exist under HUD")
	var unit_info = hud.get_node_or_null("BottomActions/UnitInfoPanel") as Panel
	var bench_mat = main_node.get_node_or_null("Background/BenchMat") as ColorRect
	
	# Step A: Game not started yet
	assert(start_menu.visible, "StartMenuModal must be visible initially")
	assert(not item_bench.visible, "ItemBench must be HIDDEN before game starts!")
	assert(not GameManager.is_game_started, "GameManager.is_game_started must be false while on start menu")
	print("  [PASS] ItemBench is properly hidden before game starts.")
	
	# Verify position of ItemBench on screen (Right side)
	print("\n--- Test 3: Item Bench Right-Side Placement & No Overlaps ---")
	var bench_x = item_bench.offset_left
	var bench_y = item_bench.offset_top
	var bench_right = item_bench.offset_right
	var bench_bottom = item_bench.offset_bottom
	
	print("ItemBench rect: [left: %.1f, top: %.1f, right: %.1f, bottom: %.1f]" % [bench_x, bench_y, bench_right, bench_bottom])
	assert(bench_x >= 1000.0, "ItemBench must be positioned on the right side (x >= 1000), got: %.1f" % bench_x)
	assert(bench_right <= 1275.0, "ItemBench must stay within screen bounds (right <= 1275), got: %.1f" % bench_right)
	assert(bench_bottom < shop_panel.offset_top, "ItemBench (bottom: %.1f) must not overlap ShopPanel (top: %.1f)" % [bench_bottom, shop_panel.offset_top])
	
	if unit_info:
		print("UnitInfoPanel rect: [left: %.1f, right: %.1f, top: %.1f, bottom: %.1f]" % [unit_info.offset_left, unit_info.offset_right, unit_info.offset_top, unit_info.offset_bottom])
		assert(unit_info.offset_right < bench_x, "ItemBench must not overlap UnitInfoPanel")
	
	if bench_mat:
		print("BenchMat rect: [left: %.1f, right: %.1f, top: %.1f, bottom: %.1f]" % [bench_mat.offset_left, bench_mat.offset_right, bench_mat.offset_top, bench_mat.offset_bottom])
		assert(bench_mat.offset_right < bench_x, "ItemBench must not overlap BenchMat")
	
	print("  [PASS] ItemBench is on the right side with 0 overlaps with Shop, BenchMat, or UnitInfoPanel.")
	
	# Step B: Start Game Transition
	print("\n--- Test 4: Game Start Transition ---")
	var play_btn = start_menu.get_node("Dialog/VBox/BtnRow/PlayGameBtn") as Button
	assert(play_btn != null, "PlayGameBtn must exist")
	hud._on_play_game_pressed()
	await get_tree().process_frame
	
	assert(item_bench.visible, "ItemBench must be VISIBLE after clicking play game!")
	assert(GameManager.is_game_started, "GameManager.is_game_started must be true after clicking play game")
	assert(GameManager.phase_timer >= 19.5, "Timer should reset to full 20s preparation time (got %.2f)" % GameManager.phase_timer)
	print("  [PASS] Clicking PlayGame smoothly unveils ItemBench and begins 20s preparation phase.")
	
	main_node.queue_free()
