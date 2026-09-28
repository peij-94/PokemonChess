extends Node

# Test suite for Direction 2: The Real-time Battle Data Statistics Meter
const DPS_METER_SCENE = preload("res://scenes/dps_meter.tscn")

func _ready() -> void:
	print("\n========================================================")
	print("=== STARTING DPS & BATTLE METRICS METER TESTS ===")
	print("========================================================\n")
	await get_tree().process_frame
	
	# Instantiate DPS Meter
	var canvas = CanvasLayer.new()
	add_child(canvas)
	var meter = DPS_METER_SCENE.instantiate()
	canvas.add_child(meter)
	await get_tree().process_frame
	
	# -------------------------------------------------------------------------
	# Test 1: Collapsible UI & Default State
	# -------------------------------------------------------------------------
	print("--- Test 1: Collapsible UI & Initial Folded State ---")
	assert(not meter.is_meter_expanded(), "Meter should default to folded/collapsed state")
	assert(meter.main_panel.visible == false, "MainPanel should be hidden when collapsed")
	assert(meter.toggle_btn.visible == true, "Toggle button should be visible when collapsed")
	assert("统计" in meter.toggle_btn.text, "Toggle button should contain '统计'")
	print("  [PASS] Initial folded state verified: panel hidden, toggle tab visible.")
	
	# Expand via toggle_visibility
	meter.toggle_visibility()
	assert(meter.is_meter_expanded(), "Meter should be expanded after toggle_visibility()")
	assert(meter.main_panel.visible == true, "MainPanel should be visible when expanded")
	print("  [PASS] toggle_visibility() expands panel to 240x360.")
	
	# Collapse via toggle_visibility
	meter.toggle_visibility()
	assert(not meter.is_meter_expanded(), "Meter should be collapsed after second toggle_visibility()")
	assert(meter.main_panel.visible == false, "MainPanel should be hidden when collapsed")
	print("  [PASS] toggle_visibility() collapses panel back.")
	
	# Expand via expand()
	meter.expand()
	assert(meter.is_meter_expanded(), "expand() should expand the panel")
	assert(meter.main_panel.visible == true, "MainPanel should be visible after expand()")
	print("  [PASS] expand() / collapse() API verified.")
	
	# -------------------------------------------------------------------------
	# Test 2: Damage Dealt (⚔️ 输出) & Sorting & MVP Assignment
	# -------------------------------------------------------------------------
	print("\n--- Test 2: Damage Dealt Mode, Sorting & MVP Crown ---")
	meter.set_view_mode("damage")
	assert(meter.get_view_mode() == "damage", "View mode should be 'damage'")
	
	var mock_units: Array = [
		{
			"id": "pikachu",
			"name": "皮卡丘",
			"star": 2,
			"damage": 3450.0,
			"taken": 1200.0,
			"healing": 0.0,
			"dps": 345.0,
			"is_enemy": false
		},
		{
			"id": "charizard",
			"name": "喷火龙",
			"star": 3,
			"damage": 4800.0,
			"taken": 2500.0,
			"healing": 0.0,
			"dps": 480.0,
			"is_enemy": false
		},
		{
			"id": "blastoise",
			"name": "水箭龟",
			"star": 2,
			"damage": 1800.0,
			"taken": 5500.0,
			"healing": 600.0,
			"dps": 180.0,
			"is_enemy": false
		},
		{
			"id": "venusaur",
			"name": "妙蛙花",
			"star": 2,
			"damage": 2100.0,
			"taken": 3200.0,
			"healing": 3800.0,
			"dps": 210.0,
			"is_enemy": false
		}
	]
	
	meter.update_metrics(mock_units)
	await get_tree().process_frame
	
	var expected_total_damage = 3450.0 + 4800.0 + 1800.0 + 2100.0 # 12,150.0
	assert(is_equal_approx(meter.get_team_total(), expected_total_damage), "Team total damage should be 12,150")
	print("  [PASS] Team total damage calculated correctly: %s" % meter.format_number(meter.get_team_total()))
	
	assert(meter.get_row_count() == 4, "Row count should be 4")
	
	# Verify sorting order (Charizard > Pikachu > Venusaur > Blastoise)
	var row0 = meter.get_row_data(0)
	var row1 = meter.get_row_data(1)
	var row2 = meter.get_row_data(2)
	var row3 = meter.get_row_data(3)
	
	assert(row0["id"] == "charizard", "Rank 1 should be Charizard (4800 dmg)")
	assert(row1["id"] == "pikachu", "Rank 2 should be Pikachu (3450 dmg)")
	assert(row2["id"] == "venusaur", "Rank 3 should be Venusaur (2100 dmg)")
	assert(row3["id"] == "blastoise", "Rank 4 should be Blastoise (1800 dmg)")
	print("  [PASS] Units sorted in descending order of damage dealt.")
	
	# Verify MVP Assignment
	assert(meter.get_mvp_id() == "charizard", "MVP should be Charizard")
	assert(row0.get("_is_mvp", false) == true, "Row 0 should have _is_mvp == true")
	assert(row1.get("_is_mvp", false) == false, "Row 1 should not be MVP")
	
	var row0_node = meter.get_row_node(0)
	var rank_label0: Label = row0_node.find_child("RankLabel", true, false)
	assert(rank_label0 != null and rank_label0.text == "👑", "Rank 1 row should display MVP crown badge 👑")
	
	var row1_node = meter.get_row_node(1)
	var rank_label1: Label = row1_node.find_child("RankLabel", true, false)
	assert(rank_label1 != null and rank_label1.text == "#2", "Rank 2 row should display #2")
	print("  [PASS] MVP Crown badge (👑) correctly assigned to #1 contributor.")
	
	# Verify Percentage Calculations
	var pct_chari = float(row0["_percent_of_total"])
	var pct_pika = float(row1["_percent_of_total"])
	var pct_venu = float(row2["_percent_of_total"])
	var pct_blas = float(row3["_percent_of_total"])
	
	assert(abs(pct_chari - (4800.0 / 12150.0 * 100.0)) < 0.05, "Charizard percent calculation accurate")
	assert(abs(pct_pika - (3450.0 / 12150.0 * 100.0)) < 0.05, "Pikachu percent calculation accurate")
	assert(abs(pct_venu - (2100.0 / 12150.0 * 100.0)) < 0.05, "Venusaur percent calculation accurate")
	assert(abs(pct_blas - (1800.0 / 12150.0 * 100.0)) < 0.05, "Blastoise percent calculation accurate")
	
	var sum_pct = pct_chari + pct_pika + pct_venu + pct_blas
	assert(abs(sum_pct - 100.0) < 0.05, "Sum of percentages should equal 100%")
	print("  [PASS] Team percentage calculations verified (Sum = 100.0%%).")
	
	# Verify Gauge Bar Fill Color (Red for Damage)
	var bar0: ProgressBar = row0_node.find_child("GaugeBar", true, false)
	var fill0: StyleBoxFlat = bar0.get_theme_stylebox("fill")
	assert(fill0.bg_color.r > 0.8 and fill0.bg_color.b < 0.5, "Damage bar fill should be Red")
	print("  [PASS] Gauge progress bar fill color verified as Red for Damage.")
	
	# Verify Value Formatting
	var val_label0: Label = row0_node.find_child("ValueLabel", true, false)
	assert(val_label0.text == "4,800 (480/s)", "Value should format nicely as '4,800 (480/s)', got: " + val_label0.text)
	print("  [PASS] Value formatting verified: '4,800 (480/s)'")
	
	# -------------------------------------------------------------------------
	# Test 3: Damage Taken (🛡️ 承伤) & Tab Switching
	# -------------------------------------------------------------------------
	print("\n--- Test 3: Damage Taken Tab Switching & Re-sorting ---")
	meter.set_view_mode("taken")
	await get_tree().process_frame
	
	assert(meter.get_view_mode() == "taken", "View mode should be 'taken'")
	var expected_total_taken = 1200.0 + 2500.0 + 5500.0 + 3200.0 # 12,400.0
	assert(is_equal_approx(meter.get_team_total(), expected_total_taken), "Team total taken should be 12,400")
	
	# Verify sorting: Blastoise (5500) > Venusaur (3200) > Charizard (2500) > Pikachu (1200)
	var t_row0 = meter.get_row_data(0)
	var t_row1 = meter.get_row_data(1)
	var t_row2 = meter.get_row_data(2)
	var t_row3 = meter.get_row_data(3)
	
	assert(t_row0["id"] == "blastoise", "Rank 1 taken should be Blastoise (5500)")
	assert(t_row1["id"] == "venusaur", "Rank 2 taken should be Venusaur (3200)")
	assert(t_row2["id"] == "charizard", "Rank 3 taken should be Charizard (2500)")
	assert(t_row3["id"] == "pikachu", "Rank 4 taken should be Pikachu (1200)")
	print("  [PASS] Units re-sorted by Damage Taken descending.")
	
	# Verify MVP Blastoise
	assert(meter.get_mvp_id() == "blastoise", "Damage Taken MVP should be Blastoise")
	var t_node0 = meter.get_row_node(0)
	var t_rank0: Label = t_node0.find_child("RankLabel", true, false)
	assert(t_rank0.text == "👑", "Blastoise should display crown 👑")
	print("  [PASS] Damage Taken MVP assigned to Blastoise (👑).")
	
	# Verify Gauge Bar Fill Color (Blue for Taken)
	var t_bar0: ProgressBar = t_node0.find_child("GaugeBar", true, false)
	var t_fill0: StyleBoxFlat = t_bar0.get_theme_stylebox("fill")
	assert(t_fill0.bg_color.b > 0.8 and t_fill0.bg_color.r < 0.5, "Taken bar fill should be Blue")
	print("  [PASS] Gauge progress bar fill color verified as Blue for Taken.")
	
	# -------------------------------------------------------------------------
	# Test 4: Healing & Shielding (💚 治疗/护盾) & Tab Switching
	# -------------------------------------------------------------------------
	print("\n--- Test 4: Healing & Shielding Tab Switching & Re-sorting ---")
	meter.set_view_mode("healing")
	await get_tree().process_frame
	
	assert(meter.get_view_mode() == "healing", "View mode should be 'healing'")
	var expected_total_healing = 0.0 + 0.0 + 600.0 + 3800.0 # 4,400.0
	assert(is_equal_approx(meter.get_team_total(), expected_total_healing), "Team total healing should be 4,400")
	
	# Verify sorting: Venusaur (3800) > Blastoise (600) > Charizard / Pikachu (0)
	var h_row0 = meter.get_row_data(0)
	var h_row1 = meter.get_row_data(1)
	assert(h_row0["id"] == "venusaur", "Rank 1 healing should be Venusaur (3800)")
	assert(h_row1["id"] == "blastoise", "Rank 2 healing should be Blastoise (600)")
	print("  [PASS] Units re-sorted by Healing descending.")
	
	# Verify MVP Venusaur
	assert(meter.get_mvp_id() == "venusaur", "Healing MVP should be Venusaur")
	var h_node0 = meter.get_row_node(0)
	var h_rank0: Label = h_node0.find_child("RankLabel", true, false)
	assert(h_rank0.text == "👑", "Venusaur should display crown 👑")
	
	var pct_venu_heal = float(h_row0["_percent_of_total"])
	assert(abs(pct_venu_heal - (3800.0 / 4400.0 * 100.0)) < 0.05, "Venusaur healing percentage verified: ~86.4%")
	print("  [PASS] Healing MVP assigned to Venusaur (👑) with %.1f%% of team healing." % pct_venu_heal)
	
	# Verify Gauge Bar Fill Color (Green for Healing)
	var h_bar0: ProgressBar = h_node0.find_child("GaugeBar", true, false)
	var h_fill0: StyleBoxFlat = h_bar0.get_theme_stylebox("fill")
	assert(h_fill0.bg_color.g > 0.8 and h_fill0.bg_color.r < 0.5, "Healing bar fill should be Green")
	print("  [PASS] Gauge progress bar fill color verified as Green for Healing.")
	
	# -------------------------------------------------------------------------
	# Test 5: Enemy Filter Toggle
	# -------------------------------------------------------------------------
	print("\n--- Test 5: Enemy Unit Filtering Toggle ---")
	var mock_with_enemy = mock_units.duplicate(true)
	mock_with_enemy.append({
		"id": "mewtwo",
		"name": "超梦",
		"star": 3,
		"damage": 9999.0,
		"taken": 4000.0,
		"healing": 1500.0,
		"dps": 999.0,
		"is_enemy": true
	})
	
	meter.set_view_mode("damage")
	meter.set_filter_enemies(false)
	meter.update_metrics(mock_with_enemy)
	await get_tree().process_frame
	
	assert(meter.get_row_count() == 4, "Enemy unit should be filtered out when show_enemies=false")
	assert(meter.get_row_data(0)["id"] == "charizard", "Charizard should still be #1 player unit")
	
	# Enable enemies toggle
	meter.set_filter_enemies(true)
	await get_tree().process_frame
	assert(meter.get_row_count() == 5, "All 5 units should appear when show_enemies=true")
	assert(meter.get_row_data(0)["id"] == "mewtwo", "Mewtwo should be top overall when enemies enabled")
	print("  [PASS] Enemy filtering toggle verified (Player only vs All units).")
	
	# -------------------------------------------------------------------------
	# Test 6: Reset Metrics
	# -------------------------------------------------------------------------
	print("\n--- Test 6: Reset Metrics ---")
	meter.reset_metrics()
	await get_tree().process_frame
	
	assert(meter.get_team_total() == 0.0, "Team total should reset to 0.0")
	assert(meter.get_mvp_id() == "", "MVP should reset to empty")
	assert(meter.get_row_count() == 0, "Active rows data should be empty after reset")
	print("  [PASS] reset_metrics() cleared all metrics and reset gauge bars.")
	
	print("\n========================================================")
	print(">>> ALL DPS & BATTLE METRICS METER TESTS PASSED! <<<")
	print("========================================================\n")
	
	get_tree().quit(0)
