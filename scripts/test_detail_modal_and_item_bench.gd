extends Node2D

func _ready() -> void:
	print("=======================================================")
	print(">>> TESTING UNIT DETAIL MODAL & ITEM BENCH LAYOUT <<<")
	print("=======================================================")
	
	var main_scene = load("res://scenes/main.tscn")
	assert(main_scene != null, "main.tscn must load")
	var main_node = main_scene.instantiate()
	add_child(main_node)
	await get_tree().process_frame
	await get_tree().process_frame
	
	var hud = main_node.get_node("HUD")
	var board = main_node.get_node("Board")
	var item_bench = hud.get_node_or_null("ItemBench")
	assert(item_bench != null, "ItemBench must exist under HUD")
	var unit_detail_modal = hud.get_node_or_null("UnitDetailModal")
	assert(unit_detail_modal != null, "UnitDetailModal must exist under HUD")
	var start_menu = hud.get_node_or_null("StartMenuModal")
	
	# Start game
	var play_btn = start_menu.get_node("Dialog/VBox/BtnRow/PlayGameBtn") as Button
	play_btn.emit_signal("pressed")
	await get_tree().process_frame
	await get_tree().process_frame
	
	print("\n--- Test 1: Item Bench Position ---")
	assert(item_bench.visible, "ItemBench should be visible after starting game")
	print("ItemBench rect: [left: %.1f, top: %.1f, right: %.1f, bottom: %.1f]" % [
		item_bench.offset_left, item_bench.offset_top, item_bench.offset_right, item_bench.offset_bottom
	])
	assert(item_bench.offset_left >= 1000.0, "ItemBench should be on right side (x >= 1000)")
	assert(item_bench.offset_right <= 1275.0, "ItemBench should stay within bounds")
	
	print("\n--- Test 2: Unit Detail Modal Opening & Non-overlapping ---")
	var starter = board.get_board_units(false)[0]
	assert(starter != null, "Starter pokemon should exist on board")
	
	# Simulate inspecting starter pokemon
	board._on_unit_clicked(starter)
	await get_tree().process_frame
	await get_tree().process_frame
	
	assert(unit_detail_modal.visible, "UnitDetailModal must be visible after inspecting unit")
	
	var modal_left = unit_detail_modal.global_position.x
	var modal_right = modal_left + unit_detail_modal.size.x
	var modal_top = unit_detail_modal.global_position.y
	var modal_bottom = modal_top + unit_detail_modal.size.y
	
	var bench_left = item_bench.global_position.x
	var bench_right = bench_left + item_bench.size.x
	var bench_top = item_bench.global_position.y
	var bench_bottom = bench_top + item_bench.size.y
	
	print("UnitDetailModal bounds: [left: %.1f, right: %.1f, top: %.1f, bottom: %.1f]" % [
		modal_left, modal_right, modal_top, modal_bottom
	])
	print("ItemBench bounds:       [left: %.1f, right: %.1f, top: %.1f, bottom: %.1f]" % [
		bench_left, bench_right, bench_top, bench_bottom
	])
	
	var gap = bench_left - modal_right
	print("Horizontal Gap between Modal and ItemBench: %.1f px" % gap)
	assert(gap >= 0.0, "UnitDetailModal (right: %.1f) must NOT overlap ItemBench (left: %.1f)! Gap: %.1f" % [modal_right, bench_left, gap])
	print("  [PASS] 0% Overlap! UnitDetailModal is completely clear of ItemBench.")
	
	print("\n--- Test 3: Equip and Unequip Interaction ---")
	# Add item to starter and test unequip
	starter.equip_item("razor_claw")
	unit_detail_modal.open_for_unit(starter)
	await get_tree().process_frame
	assert(starter.held_items.has("razor_claw"), "Starter should hold razor_claw")
	assert(unit_detail_modal.unequip_btn.visible, "Unequip button must be visible when unit has items")
	
	var count_before = item_bench.get_occupied_slot_count()
	unit_detail_modal._on_unequip_pressed()
	await get_tree().process_frame
	assert(starter.held_items.is_empty(), "Items should be unequipped")
	assert(item_bench.get_occupied_slot_count() == count_before + 1, "Item should transfer to ItemBench")
	print("  [PASS] Unequip button successfully transfers items to ItemBench while modal is open!")
	
	print("\n--- Test 4: Modal Close ---")
	unit_detail_modal.close()
	await get_tree().process_frame
	assert(not unit_detail_modal.visible, "Modal should be closed cleanly")
	print("  [PASS] UnitDetailModal closed cleanly.")
	
	print("\n=======================================================")
	print(">>> ALL MODAL & ITEM BENCH LAYOUT TESTS PASSED (100%) <<<")
	print("=======================================================")
	get_tree().quit(0)
