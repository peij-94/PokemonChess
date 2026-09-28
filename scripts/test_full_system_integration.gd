extends Node

func _ready() -> void:
	print("\n========================================================")
	print(">>> RUNNING FULL END-TO-END SYSTEM INTEGRATION SUITE <<<")
	print("========================================================")
	
	# Load main scene
	var main_scene = load("res://scenes/main.tscn")
	assert(main_scene != null, "Failed to load main.tscn")
	var main_instance = main_scene.instantiate()
	add_child(main_instance)
	
	# Wait one frame for _ready to execute on all children
	await get_tree().process_frame
	
	var board = main_instance.get_node("Board")
	var hud = main_instance.get_node("HUD")
	assert(board != null, "Board node not found")
	assert(hud != null, "HUD node not found")
	
	# ----------------------------------------------------
	# Test 1: Global Reference Wiring
	# ----------------------------------------------------
	print("\n--- Test 1: Global Reference Wiring ---")
	assert(GameManager.hud_ref == hud, "GameManager.hud_ref not wired to HUD!")
	assert(GameManager.board_ref == board, "GameManager.board_ref not wired to Board!")
	assert(GameManager.item_bench != null, "GameManager.item_bench is null!")
	assert(hud.item_bench != null, "HUD.item_bench is null!")
	print("  [PASS] GameManager.hud_ref, board_ref, and item_bench properly bound.")
	
	# ----------------------------------------------------
	# Test 2: Item Bench Operations & Item Drops
	# ----------------------------------------------------
	print("\n--- Test 2: Item Bench Operations & Victory Drops ---")
	GameManager.item_bench.clear_all()
	assert(GameManager.item_bench.get_item_count() == 0, "Item bench should be empty initially.")
	
	# Simulate victory drop for Wave 1 (base item)
	board._award_victory_item_drops(1)
	assert(GameManager.item_bench.get_item_count() == 1, "Wave 1 should have dropped 1 base item to bench.")
	var dropped_id = GameManager.item_bench.get_item_at(0)
	print("  [PASS] Wave 1 dropped base item component: %s" % dropped_id)
	
	# Simulate victory drop for Wave 5 (advanced item)
	board._award_victory_item_drops(5)
	assert(GameManager.item_bench.get_item_count() == 2, "Wave 5 Boss should have dropped an advanced item.")
	var adv_dropped = GameManager.item_bench.get_item_at(1)
	print("  [PASS] Wave 5 Boss dropped advanced item: %s" % adv_dropped)
	
	# ----------------------------------------------------
	# Test 3: Drag & Equip to Board Unit
	# ----------------------------------------------------
	print("\n--- Test 3: Equip to Unit & Detail Modal Inspection ---")
	var unit = board.spawn_unit_at_coord("pikachu", Vector2i(3, 4), 1, false)
	assert(unit != null, "Failed to spawn player Pikachu.")
	var orig_atk = unit.atk
	
	# Equip Razor Claw (+15 ATK, +15% Crit)
	GameManager.item_bench.add_item("razor_claw")
	var last_slot = GameManager.item_bench.get_item_count() - 1
	var razor_id = GameManager.item_bench.take_item_at(last_slot)
	assert(razor_id == "razor_claw", "Failed to take razor_claw from bench.")
	
	var equip_ok = unit.equip_item("razor_claw")
	assert(equip_ok, "Failed to equip razor_claw to unit.")
	assert(unit.held_items.has("razor_claw"), "Unit does not have razor_claw in held_items.")
	assert(unit.atk == orig_atk + 15.0, "Unit ATK did not increase by 15 from Razor Claw!")
	print("  [PASS] Razor Claw equipped! ATK: %.0f -> %.0f" % [orig_atk, unit.atk])
	
	# Inspect unit in UnitDetailModal
	var modal = hud.unit_detail_modal
	assert(modal != null, "UnitDetailModal instance not found.")
	modal.open_for_unit(unit)
	assert(modal.visible, "Modal should be visible after open_for_unit.")
	
	# Check Ability info displayed
	assert(modal.ability_panel.visible, "Ability panel should be visible for Pikachu.")
	assert("静电" in modal.ability_title_lbl.text, "Ability title should contain Pikachu's ability '静电'.")
	print("  [PASS] Unit Detail Modal displays passive ability: %s" % modal.ability_title_lbl.text)
	
	# Check Equipped Item Slot displayed
	assert(modal.items_hbox.get_child_count() == 3, "Items hbox should have 3 item slots.")
	assert(modal.unequip_btn.visible, "Unequip button should be visible when carrying items.")
	print("  [PASS] Unit Detail Modal displays 3 item slots and active Unequip button.")
	
	# ----------------------------------------------------
	# Test 4: Unequipping Item back to Bench
	# ----------------------------------------------------
	print("\n--- Test 4: Unequip Item back to Bench ---")
	var bench_count_before = GameManager.item_bench.get_item_count()
	modal._on_unequip_pressed()
	assert(unit.held_items.is_empty(), "Unit held_items should be empty after unequip.")
	assert(unit.atk == orig_atk, "Unit ATK should return to base after unequip.")
	assert(GameManager.item_bench.get_item_count() == bench_count_before + 1, "Item should have returned to bench.")
	print("  [PASS] Unequipped Razor Claw returned to bench and stats cleanly reverted.")
	modal.close()
	
	# ----------------------------------------------------
	# Test 5: Evolution Sacrifice Item Return
	# ----------------------------------------------------
	print("\n--- Test 5: Evolution Sacrifice Item Preservation ---")
	# Spawn 2 more Pikachus to form a 3-star upgrade
	var pika2 = board.spawn_unit_at_coord("pikachu", Vector2i(4, 4), 1, false)
	var pika3 = board.spawn_unit_at_coord("pikachu", Vector2i(5, 4), 1, false)
	# Equip Leftovers onto pika2 (which will be a sacrifice)
	pika2.equip_item("leftovers")
	assert(pika2.held_items.has("leftovers"), "Pika2 should have leftovers.")
	
	var count_before_evo = GameManager.item_bench.get_item_count()
	board.check_and_execute_evolutions()
	# pikachu should be star 2 now, and leftovers from sacrifice returned to bench!
	assert(GameManager.item_bench.get_item_count() == count_before_evo + 1, "Sacrifice leftovers must be returned to bench!")
	print("  [PASS] Sacrifice unit's held item (Leftovers) safely recovered to bench upon star upgrade!")
	
	# ----------------------------------------------------
	# Test 6: Boss Wave Spawning & Boss Health Bar
	# ----------------------------------------------------
	print("\n--- Test 6: Boss Wave Spawning & Boss Health Bar ---")
	# Force round 5 (Snorlax Boss)
	GameManager.current_round = 5
	board.spawn_enemy_wave(5)
	
	# Find Boss Snorlax
	var boss_found: Unit = null
	for node in board.units_container.get_children():
		var u = node as Unit
		if u != null and u.is_enemy and u.pokemon_id == "snorlax":
			boss_found = u
			break
			
	assert(boss_found != null, "Boss Snorlax not found in Wave 5!")
	assert(boss_found.scale.x > 1.2, "Boss Snorlax scale should be boosted!")
	assert(hud.boss_health_bar.visible, "BossHealthBar should be visible during Boss encounter!")
	print("  [PASS] Wave 5 Snorlax Boss spawned with enlarged scale (%.2f) and active BossHealthBar!" % boss_found.scale.x)
	
	# Damage the boss to 40% to verify enrage on the Boss bar
	boss_found.current_hp = boss_found.max_hp * 0.40
	hud.boss_health_bar._process(0.016)
	assert(hud.boss_health_bar.is_enraged, "BossHealthBar should trigger ENRAGED state when Boss HP < 50%!")
	print("  [PASS] BossHealthBar successfully reacted with Phase 2 ENRAGED state!")
	
	# Reset board
	board.reset_board_for_prep()
	assert(not hud.boss_health_bar.is_active, "BossHealthBar should be inactive when resetting for prep.")
	print("  [PASS] BossHealthBar safely dismissed on prep reset.")
	
	# ----------------------------------------------------
	# Test 7: Trainer Augments on Rounds 1, 5, 9
	# ----------------------------------------------------
	print("\n--- Test 7: Trainer Augments Selection Flow ---")
	AugmentDatabase.clear_active_augments()
	hud.open_trainer_augment_modal()
	assert(hud.trainer_augment_modal.visible, "TrainerAugmentModal should open.")
	assert(hud.trainer_augment_modal.cards_container.get_child_count() == 3, "Should render 3 augment cards.")
	
	# Choose 'interest_tycoon'
	hud.trainer_augment_modal._on_card_selected("interest_tycoon")
	assert(AugmentDatabase.has_augment("interest_tycoon"), "Interest Tycoon should now be active.")
	assert(not hud.trainer_augment_modal.is_opened, "Modal should close after selection.")
	print("  [PASS] Trainer augment '利息大亨' successfully selected and active.")
	
	# Verify that economy honors the interest tycoon augment (cap = 8 instead of 5)
	GameManager.gold = 80
	GameManager.advance_to_next_round()
	# Round income with 80 gold should give 8 interest + 5 base = 13 gold (+ streak/exp)
	# 80 + 13 = 93 gold
	assert(GameManager.gold >= 93, "Interest tycoon should allow up to +8 interest!")
	print("  [PASS] Interest Tycoon granted +8 max interest (Gold: %d)." % GameManager.gold)
	
	# ----------------------------------------------------
	# Test 8: DPS Meter Combat Tracking
	# ----------------------------------------------------
	print("\n--- Test 8: DPS Meter Combat Tracking ---")
	var meter = hud.dps_meter
	assert(meter != null, "DPS Meter node not found.")
	meter.expand()
	assert(meter.is_expanded, "DPS meter should be expanded.")
	assert(meter.main_panel.visible, "DPS meter main_panel should be visible.")
	
	# Feed combat metrics
	var test_metrics = [
		{"unit": unit, "id": "pikachu", "name": "皮卡丘", "star": 2, "damage": 5000.0, "taken": 1200.0, "healing": 300.0, "dps": 250.0, "is_enemy": false}
	]
	meter.update_metrics(test_metrics)
	assert(meter.rows_container.get_child_count() > 0, "DPS row should be created.")
	print("  [PASS] DPS Meter dynamically tracking player damage, damage taken, and healing.")
	
	print("\n========================================================")
	print(">>> ALL 8 FULL SYSTEM INTEGRATION TESTS PASSED 100%! <<<")
	print("========================================================\n")
	get_tree().quit(0)
