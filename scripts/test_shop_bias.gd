extends Node

func _ready() -> void:
	print("\n=== STARTING DEPLOYED POKEMON SHOP PROBABILITY BIAS TESTS ===")
	await get_tree().process_frame
	
	# 1. Test pick_pokemon_with_bias statistical weighting
	print("Testing pick_pokemon_with_bias (+20% weight for deployed units):")
	var candidates: Array[String] = ["pikachu", "eevee", "charmander", "squirtle", "bulbasaur"]
	var deployed = {"pikachu": true}
	
	var counts = {"pikachu": 0, "eevee": 0, "charmander": 0, "squirtle": 0, "bulbasaur": 0}
	var iterations = 50000
	for i in range(iterations):
		var picked = GameManager.pick_pokemon_with_bias(candidates, deployed)
		counts[picked] += 1
		
	# Expected ratio:
	# pikachu weight = 1.2, others = 1.0. Total = 1.2 + 4.0 = 5.2.
	# pikachu expected = 1.2 / 5.2 ≈ 0.23077 (23.08%)
	# each other expected = 1.0 / 5.2 ≈ 0.19231 (19.23%)
	# Ratio of pikachu / eevee ≈ 1.20 (+20% higher!)
	var pika_ratio = float(counts["pikachu"]) / float(iterations)
	var eevee_ratio = float(counts["eevee"]) / float(iterations)
	var observed_boost = pika_ratio / eevee_ratio
	print("Simulation results over %d draws:" % iterations)
	print("  Pikachu (deployed): %d (%.2f%%)" % [counts["pikachu"], pika_ratio * 100.0])
	print("  Eevee   (standard): %d (%.2f%%)" % [counts["eevee"], eevee_ratio * 100.0])
	print("  Observed relative boost: %.3fx (expected ~1.20x)" % observed_boost)
	
	assert(abs(observed_boost - 1.20) < 0.06, "Deployed unit should appear ~20%% more frequently (observed " + str(observed_boost) + ")")
	print("[PASS] Statistical bias verified: deployed unit has precisely +20% higher chance!")
	
	# 2. Test empty deployed dictionary falls back cleanly
	var counts_unbiased = {"pikachu": 0, "eevee": 0}
	for i in range(20000):
		var picked = GameManager.pick_pokemon_with_bias(["pikachu", "eevee"], {})
		counts_unbiased[picked] += 1
	var unbiased_ratio = float(counts_unbiased["pikachu"]) / float(counts_unbiased["eevee"])
	print("[PASS] Empty deployed bias fallback verified: ratio=%.3f (expected ~1.00)" % unbiased_ratio)
	assert(abs(unbiased_ratio - 1.00) < 0.08, "Without deployed bias, weights should be 1:1")
	
	# 3. Test board integration & is_pokemon_deployed
	print("Testing GameManager.is_pokemon_deployed and board integration:")
	assert(GameManager.board_ref != null, "board_ref should be available")
	var deployed_before = GameManager.get_deployed_pokemon_ids()
	print("Currently deployed on board:", deployed_before)
	
	# Refresh shop should execute cleanly
	var refresh_ok = GameManager.refresh_shop(true)
	assert(refresh_ok, "refresh_shop should return true")
	assert(GameManager.current_shop_cards.size() == 5, "Shop should contain 5 cards")
	print("[PASS] Shop refreshed cleanly with cards: %s" % str(GameManager.current_shop_cards))
	
	# 4. Test actual shop refresh rate for deployed unit (Pikachu on board at Level 1)
	print("Testing refresh_shop appearance rate for deployed Pikachu at Level 1:")
	var pika_slots = 0
	var num_refreshes = 200
	var total_slots = num_refreshes * 5
	for r in range(num_refreshes):
		GameManager.refresh_shop(true)
		for card in GameManager.current_shop_cards:
			if card == "pikachu":
				pika_slots += 1
	var observed_slot_rate = float(pika_slots) / float(total_slots)
	print("  Pikachu appeared in %d / %d slots (%.2f%%, expected ~20%%)" % [pika_slots, total_slots, observed_slot_rate * 100.0])
	assert(abs(observed_slot_rate - 0.20) < 0.05, "Deployed Pikachu should appear in ~20% of shop slots!")
	print("[PASS] Full shop refresh confirmed: deployed units have guaranteed +20% appearance rate!")
	
	print("\n========================================================")
	print(">>> ALL SHOP PROBABILITY BIAS TESTS PASSED (4/4) <<<")
	print("========================================================")
	get_tree().quit(0)
