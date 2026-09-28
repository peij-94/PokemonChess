extends Node

func _ready() -> void:
	print("\n========================================================")
	print(">>> STARTING WEATHER & TERRAIN SYSTEM AUTOMATED TESTS <<<")
	print("========================================================")
	
	# --- Test 1: Weather State Transitions & Timers ---
	print("\n--- Test 1: Weather State Transitions & Timers ---")
	WeatherSystem.set_weather("sun", 15.0)
	assert(WeatherSystem.current_weather == "sun", "Weather should be 'sun'")
	assert(WeatherSystem.weather_timer == 15.0, "Weather timer should be 15.0")
	assert("大晴天" in WeatherSystem.get_weather_name(), "Weather name should contain '大晴天'")
	print("  [PASS] Sun weather state transition verified: %s" % WeatherSystem.get_weather_name())
	
	WeatherSystem.set_weather("rain", 20.0)
	assert(WeatherSystem.current_weather == "rain", "Weather should be 'rain'")
	print("  [PASS] Rain weather state transition verified: %s" % WeatherSystem.get_weather_name())
	
	WeatherSystem.set_weather("sandstorm", 10.0)
	assert(WeatherSystem.current_weather == "sandstorm", "Weather should be 'sandstorm'")
	print("  [PASS] Sandstorm weather state transition verified: %s" % WeatherSystem.get_weather_name())
	
	WeatherSystem.set_weather("snow", 12.0)
	assert(WeatherSystem.current_weather == "snow", "Weather should be 'snow'")
	print("  [PASS] Snow weather state transition verified: %s" % WeatherSystem.get_weather_name())
	
	# --- Test 2: Terrain State Transitions ---
	print("\n--- Test 2: Terrain State Transitions ---")
	WeatherSystem.set_terrain("electric", 18.0)
	assert(WeatherSystem.current_terrain == "electric", "Terrain should be 'electric'")
	print("  [PASS] Electric terrain state transition verified: %s" % WeatherSystem.get_terrain_name())
	
	WeatherSystem.set_terrain("grassy", 18.0)
	assert(WeatherSystem.current_terrain == "grassy", "Terrain should be 'grassy'")
	print("  [PASS] Grassy terrain state transition verified: %s" % WeatherSystem.get_terrain_name())
	
	# --- Test 3: Offensive Damage Multipliers ---
	print("\n--- Test 3: Offensive Damage Multipliers ---")
	# In Sun: Fire x1.35, Water x0.70
	WeatherSystem.set_weather("sun", 20.0)
	WeatherSystem.set_terrain("none", 0.0)
	var fire_mult = WeatherSystem.calculate_weather_terrain_multiplier(["Fire"], "Fire")
	var water_mult = WeatherSystem.calculate_weather_terrain_multiplier(["Water"], "Water")
	assert(is_equal_approx(fire_mult, 1.35), "Sun must boost Fire damage to 1.35x, got: %.2f" % fire_mult)
	assert(is_equal_approx(water_mult, 0.70), "Sun must reduce Water damage to 0.70x, got: %.2f" % water_mult)
	print("  [PASS] Sun damage multipliers verified: Fire=%.2fx, Water=%.2fx" % [fire_mult, water_mult])
	
	# In Rain: Water x1.35, Fire x0.70
	WeatherSystem.set_weather("rain", 20.0)
	var rain_water_mult = WeatherSystem.calculate_weather_terrain_multiplier(["Water"], "Water")
	var rain_fire_mult = WeatherSystem.calculate_weather_terrain_multiplier(["Fire"], "Fire")
	assert(is_equal_approx(rain_water_mult, 1.35), "Rain must boost Water damage to 1.35x")
	assert(is_equal_approx(rain_fire_mult, 0.70), "Rain must reduce Fire damage to 0.70x")
	print("  [PASS] Rain damage multipliers verified: Water=%.2fx, Fire=%.2fx" % [rain_water_mult, rain_fire_mult])
	
	# In Electric Terrain: Electric x1.30
	WeatherSystem.set_weather("none", 0.0)
	WeatherSystem.set_terrain("electric", 20.0)
	var elec_mult = WeatherSystem.calculate_weather_terrain_multiplier(["Electric"], "Electric")
	assert(is_equal_approx(elec_mult, 1.30), "Electric Terrain must boost Electric damage to 1.30x")
	print("  [PASS] Electric terrain multiplier verified: Electric=%.2fx" % elec_mult)
	
	# --- Test 4: Defense Multipliers ---
	print("\n--- Test 4: Defense Multipliers ---")
	WeatherSystem.set_weather("sandstorm", 20.0)
	var rock_def = WeatherSystem.calculate_defense_bonus(["Rock"])
	var fire_def = WeatherSystem.calculate_defense_bonus(["Fire"])
	assert(rock_def["armor_mult"] == 1.40, "Sandstorm must boost Rock armor to 1.40x")
	assert(rock_def["mr_mult"] == 1.40, "Sandstorm must boost Rock MR to 1.40x")
	assert(fire_def["armor_mult"] == 1.0, "Sandstorm should not boost Fire armor")
	print("  [PASS] Sandstorm defense bonuses verified: Rock Defenses=%.2fx, Normal=1.0x" % rock_def["armor_mult"])
	
	WeatherSystem.set_weather("snow", 20.0)
	var ice_def = WeatherSystem.calculate_defense_bonus(["Ice"])
	assert(ice_def["armor_mult"] == 1.50, "Snow must boost Ice armor to 1.50x")
	print("  [PASS] Snow defense bonus verified: Ice Armor=%.2fx" % ice_def["armor_mult"])
	
	# --- Test 5: Reset Environment ---
	print("\n--- Test 5: Reset Environment ---")
	WeatherSystem.reset_environment()
	assert(WeatherSystem.current_weather == "none", "Weather should be reset to 'none'")
	assert(WeatherSystem.current_terrain == "none", "Terrain should be reset to 'none'")
	print("  [PASS] Environment reset cleanly verified.")
	
	print("\n========================================================")
	print(">>> ALL WEATHER & TERRAIN SYSTEM TESTS PASSED (100%) <<<")
	print("========================================================\n")
	get_tree().quit(0)
