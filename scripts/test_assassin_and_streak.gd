extends Node

func _ready() -> void:
	print("\n=======================================================")
	print(">>> STARTING ASSASSIN LEAP & STREAK BADGE TESTS <<<")
	print("=======================================================")
	
	await get_tree().process_frame
	await get_tree().process_frame

	var main_scene = load("res://scenes/main.tscn")
	var main_inst = main_scene.instantiate()
	get_parent().add_child(main_inst)
	
	await get_tree().process_frame
	await get_tree().process_frame

	var unit_scene = preload("res://scenes/unit.tscn")

	# -----------------------------------------------------------------
	# Test 1: Assassin Detection across species
	# -----------------------------------------------------------------
	print("\n--- Test 1: Assassin Detection ---")
	var assassin_candidates = ["scyther", "weavile", "drapion", "pinsir", "heracross", "sneasel", "absol"]
	for pid in assassin_candidates:
		var u = unit_scene.instantiate() as Unit
		main_inst.add_child(u)
		u.setup(pid, 1, false)
		assert(u.is_assassin() == true, "%s should be identified as Assassin!" % pid)
		u.queue_free()
	print("[PASS] Known assassin units correctly identified!")

	var non_assassin_candidates = ["machop", "snorlax", "pikachu", "alakazam", "charizard"]
	for pid in non_assassin_candidates:
		var u = unit_scene.instantiate() as Unit
		main_inst.add_child(u)
		u.setup(pid, 1, false)
		assert(u.is_assassin() == false, "%s should NOT be identified as Assassin!" % pid)
		u.queue_free()
	print("[PASS] Non-assassin units correctly rejected!")

	# -----------------------------------------------------------------
	# Test 2: Assassin Sneak Leap Execution
	# -----------------------------------------------------------------
	print("\n--- Test 2: Assassin Sneak Leap to Backline ---")
	# Create player assassin at bottom
	var assassin = unit_scene.instantiate() as Unit
	main_inst.add_child(assassin)
	assassin.setup("weavile", 1, false)
	assassin.position = Vector2(400, 500) # Player back/midline

	# Create enemy frontline tank at y=320
	var enemy_front = unit_scene.instantiate() as Unit
	main_inst.add_child(enemy_front)
	enemy_front.setup("snorlax", 1, true)
	enemy_front.position = Vector2(400, 320) # Enemy frontline

	# Create enemy backline squishy carry at y=120
	var enemy_back = unit_scene.instantiate() as Unit
	main_inst.add_child(enemy_back)
	enemy_back.setup("alakazam", 1, true)
	enemy_back.position = Vector2(400, 120) # Deep enemy backline

	await get_tree().process_frame

	# Check target calculation
	var backline_found = assassin.find_backline_target()
	assert(backline_found == enemy_back, "Assassin must target backline carry (Alakazam), got: %s" % (backline_found.pokemon_id if backline_found else "null"))
	print("[PASS] Backline enemy target prioritized over frontline tank!")

	# Trigger leap
	assassin.is_in_combat = true
	assassin.run_combat_ai(0.016)
	assert(assassin.has_leaped_backline == true, "Assassin must have initiated backline leap!")
	assert(assassin.is_assassin_leaping == true, "Assassin leap state should be active!")

	# Wait for leap tween to complete (~0.4s)
	await get_tree().create_timer(0.45).timeout

	assert(assassin.is_assassin_leaping == false, "Leap state should finish after tween!")
	# Assassin should have landed near enemy_back (y around 120 - 48 = 72..120)
	var leap_dist_to_back = assassin.position.distance_to(enemy_back.position)
	assert(leap_dist_to_back < 80.0, "Assassin should have landed within striking distance of backline enemy (distance: %f)" % leap_dist_to_back)
	print("[PASS] Assassin successfully leapt over frontline to strike enemy backline!")

	assassin.queue_free()
	enemy_front.queue_free()
	enemy_back.queue_free()
	await get_tree().process_frame

	# -----------------------------------------------------------------
	# Test 3: Streak Visual Badge Indicator in HUD
	# -----------------------------------------------------------------
	print("\n--- Test 3: Streak Visual Badge Indicator in HUD ---")
	var hud = main_inst.get_node("HUD")
	assert(hud != null, "HUD must be valid")
	assert(hud.streak_badge != null, "StreakBadge must be present in HUD")
	
	# Win streak tests
	GameManager.win_streak = 3
	GameManager.loss_streak = 0
	hud.update_streak_badge()
	assert(hud.streak_badge.visible == true, "Streak badge should be visible at 3 wins")
	assert(hud.streak_badge_label.text.contains("3连胜"), "Streak badge text should display 3连胜, got: %s" % hud.streak_badge_label.text)
	assert(hud.streak_badge_label.text.contains("+2G"), "Streak badge text should show +2G bonus, got: %s" % hud.streak_badge_label.text)

	# 5+ win streak test
	GameManager.win_streak = 6
	hud.update_streak_badge()
	assert(hud.streak_badge_label.text.contains("6连胜"), "Streak badge text should display 6连胜")
	assert(hud.streak_badge_label.text.contains("+3G"), "Streak badge text should show +3G bonus")

	# Loss streak tests
	GameManager.win_streak = 0
	GameManager.loss_streak = 4
	hud.update_streak_badge()
	assert(hud.streak_badge.visible == true, "Streak badge should be visible at 4 losses")
	assert(hud.streak_badge_label.text.contains("4连败"), "Streak badge text should display 4连败, got: %s" % hud.streak_badge_label.text)
	assert(hud.streak_badge_label.text.contains("+2G"), "Streak badge text should show +2G bonus")

	# Reset / Low streak (< 2) test
	GameManager.win_streak = 1
	GameManager.loss_streak = 0
	hud.update_streak_badge()
	assert(hud.streak_badge.visible == false, "Streak badge should be hidden when streak < 2")
	print("[PASS] Win/loss streak fire/ice badges and bonus calculations verified!")

	print("\n=======================================================")
	print(">>> ALL ASSASSIN & STREAK TESTS PASSED SUCCESSFULLY! <<<")
	print("=======================================================\n")
	get_tree().quit(0)
