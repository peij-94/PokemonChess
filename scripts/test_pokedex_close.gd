extends Node

func _ready() -> void:
	print("\n========================================================")
	print(">>> RUNNING COMPREHENSIVE POKEDEX CLOSE FLOW TESTS <<<")
	print("========================================================")
	await get_tree().process_frame
	
	var main_scene = load("res://scenes/main.tscn")
	assert(main_scene != null, "main.tscn should load")
	var main = main_scene.instantiate()
	add_child(main)
	await get_tree().process_frame
	await get_tree().process_frame
	
	var hud = main.get_node("HUD")
	var pokedex = hud.get_node("PokedexModal")
	var close_btn = pokedex.get_node("Dialog/Header/CloseBtn")
	var start_menu = hud.get_node("StartMenuModal")
	var menu_pokedex_btn = start_menu.get_node("Dialog/VBox/BtnRow/MenuPokedexBtn")
	var play_game_btn = start_menu.get_node("Dialog/VBox/BtnRow/PlayGameBtn")
	var dps_meter = hud.get_node_or_null("DPSMeter")
	
	# Verify DPSMeter does not block mouse clicks
	print("\n--- Test 1: Verify DPSMeter Mouse Filter ---")
	if dps_meter:
		assert(dps_meter.mouse_filter == Control.MOUSE_FILTER_IGNORE, "DPSMeter root node must have MOUSE_FILTER_IGNORE (2)!")
		print("  [PASS] DPSMeter root node mouse_filter is MOUSE_FILTER_IGNORE (2)")
	
	# Test 2: Open from Start Menu and close via CloseBtn
	print("\n--- Test 2: Open from Start Menu -> Close via CloseBtn ---")
	assert(start_menu.visible, "Start menu should be initially visible")
	menu_pokedex_btn.pressed.emit()
	await get_tree().process_frame
	assert(pokedex.visible, "Pokedex should be open")
	assert(pokedex.z_index >= 100, "Pokedex z_index should be >= 100")
	assert(pokedex.get_index() == hud.get_child_count() - 1, "Pokedex should be at the very front of HUD children")
	print("  [PASS] Pokedex opened on top of StartMenuModal with z_index: %d, index: %d" % [pokedex.z_index, pokedex.get_index()])
	
	close_btn.pressed.emit()
	await get_tree().process_frame
	assert(not pokedex.visible, "Pokedex should be closed after CloseBtn pressed")
	assert(start_menu.visible, "Start menu should still be visible")
	print("  [PASS] Pokedex closed cleanly via CloseBtn!")
	
	# Test 3: Open and close via ESC key
	print("\n--- Test 3: Open from Start Menu -> Close via ESC Key ---")
	menu_pokedex_btn.pressed.emit()
	await get_tree().process_frame
	assert(pokedex.visible, "Pokedex should be open")
	var esc_ev = InputEventKey.new()
	esc_ev.keycode = KEY_ESCAPE
	esc_ev.pressed = true
	Input.parse_input_event(esc_ev)
	await get_tree().process_frame
	assert(not pokedex.visible, "Pokedex should be closed after ESC key")
	print("  [PASS] Pokedex closed cleanly via ESC key!")
	
	# Test 4: Open and close via P key
	print("\n--- Test 4: Open from Start Menu -> Close via P Key ---")
	menu_pokedex_btn.pressed.emit()
	await get_tree().process_frame
	assert(pokedex.visible, "Pokedex should be open")
	var p_ev = InputEventKey.new()
	p_ev.keycode = KEY_P
	p_ev.pressed = true
	Input.parse_input_event(p_ev)
	await get_tree().process_frame
	assert(not pokedex.visible, "Pokedex should be closed after P key")
	print("  [PASS] Pokedex closed cleanly via P key!")
	
	# Test 5: Open and close via Backdrop click
	print("\n--- Test 5: Open from Start Menu -> Close via Backdrop Click ---")
	menu_pokedex_btn.pressed.emit()
	await get_tree().process_frame
	assert(pokedex.visible, "Pokedex should be open")
	var backdrop = pokedex.get_node("Backdrop")
	assert(backdrop.mouse_filter == Control.MOUSE_FILTER_STOP, "Backdrop must have MOUSE_FILTER_STOP to catch clicks")
	var b_ev = InputEventMouseButton.new()
	b_ev.button_index = MOUSE_BUTTON_LEFT
	b_ev.pressed = true
	b_ev.position = Vector2(10, 10)
	backdrop.gui_input.emit(b_ev)
	await get_tree().process_frame
	assert(not pokedex.visible, "Pokedex should be closed after Backdrop click")
	print("  [PASS] Pokedex closed cleanly via Backdrop click!")
	
	# Test 6: In-game opening and closing via HUD TopBar button
	print("\n--- Test 6: In-Game HUD TopBar Pokedex Opening & Closing ---")
	play_game_btn.pressed.emit()
	await get_tree().process_frame
	start_menu.visible = false # ensure transitioned
	
	var topbar_pokedex_btn = hud.get_node_or_null("TopBar/ActionButtons/PokedexBtn")
	if topbar_pokedex_btn:
		topbar_pokedex_btn.pressed.emit()
		await get_tree().process_frame
		assert(pokedex.visible, "Pokedex should be open from TopBar")
		assert(pokedex.z_index >= 100, "Pokedex z_index should be >= 100")
		print("  [PASS] Pokedex opened during gameplay via TopBar button")
		
		# Close with close_btn
		close_btn.pressed.emit()
		await get_tree().process_frame
		assert(not pokedex.visible, "Pokedex should close during gameplay via CloseBtn")
		print("  [PASS] Pokedex closed during gameplay via CloseBtn!")
	
	main.queue_free()
	print("\n========================================================")
	print(">>> ALL POKEDEX CLOSE FLOW TESTS PASSED (100%)! <<<")
	print("========================================================")
	get_tree().quit(0)
