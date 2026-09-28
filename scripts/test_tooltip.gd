extends Node

func _ready() -> void:
	print("\n========================================================")
	print(">>> RUNNING TOOLTIP FLICKER-FREE VERIFICATION TEST <<<")
	print("========================================================")
	
	var bench_scene = load("res://scenes/item_bench.tscn")
	var bench = bench_scene.instantiate() as ItemBench
	add_child(bench)
	bench.position = Vector2(1090, 265)
	await get_tree().process_frame
	
	bench.add_item("razor_claw")
	var slot0 = bench.slot_buttons[0]
	
	# 1. Trigger mouse enter on slot 0
	bench._on_slot_mouse_entered(0)
	assert(bench.tooltip_panel.visible, "Tooltip must be visible on mouse enter")
	assert(bench.tooltip_panel.top_level, "Tooltip must be top_level = true so container layout cannot jump it")
	assert(bench.tooltip_panel.mouse_filter == Control.MOUSE_FILTER_IGNORE, "Tooltip mouse filter must be IGNORE")
	
	# Verify all recursive children have MOUSE_FILTER_IGNORE
	_verify_recursive_mouse_ignore(bench.tooltip_panel)
	print("  [PASS] All tooltip nodes have MOUSE_FILTER_IGNORE (no cursor stealing).")
	
	# 2. Check position stability across 10 frames
	var expected_pos = bench.tooltip_panel.global_position
	print("  Initial tooltip position: ", expected_pos)
	assert(expected_pos.x < bench.global_position.x, "Tooltip must expand to the left of the item bench")
	assert(expected_pos.x + bench.tooltip_panel.size.x <= bench.global_position.x, "Tooltip must not overlap the item bench itself")
	
	for f in range(10):
		await get_tree().process_frame
		var cur_pos = bench.tooltip_panel.global_position
		assert(cur_pos == expected_pos, "Frame %d: Tooltip position must remain stable (expected %s, got %s)" % [f, expected_pos, cur_pos])
		assert(bench.tooltip_panel.visible, "Frame %d: Tooltip must stay visible continuously without flickering!" % f)
	
	print("  [PASS] 10-frame continuous hover stability verified (zero position jumping, zero flicker).")
	
	# 3. Test exit from another slot should NOT hide tooltip if slot 0 is active
	bench._on_slot_mouse_exited(1)
	assert(bench.tooltip_panel.visible, "Tooltip must NOT hide on exit from another slot")
	
	# 4. Test exit from active slot properly hides tooltip
	bench._on_slot_mouse_exited(0)
	assert(not bench.tooltip_panel.visible, "Tooltip must hide on exiting active slot")
	print("  [PASS] Slot mouse exit logic cleanly handled.")
	
	bench.queue_free()
	print("\n========================================================")
	print(">>> ALL TOOLTIP FLICKER-FREE TESTS PASSED 100%! <<<")
	print("========================================================")
	get_tree().quit(0)

func _verify_recursive_mouse_ignore(node: Node) -> void:
	if node is Control:
		assert(node.mouse_filter == Control.MOUSE_FILTER_IGNORE, "Child %s (%s) must have mouse_filter == IGNORE" % [node.name, node.get_class()])
	for child in node.get_children():
		_verify_recursive_mouse_ignore(child)
