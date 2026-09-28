extends Node

# Verification test for TopBar layout and button non-overlapping

func _ready() -> void:
	print("\n=== STARTING TOPBAR BUTTON LAYOUT VERIFICATION ===")
	await get_tree().process_frame
	await get_tree().process_frame
	
	var main_scene = load("res://scenes/main.tscn")
	var main_inst = main_scene.instantiate()
	get_parent().add_child(main_inst)
	
	await get_tree().process_frame
	await get_tree().process_frame
	
	var hud = main_inst.get_node("HUD")
	var topbar = hud.get_node("TopBar")
	var player_info = topbar.get_node("PlayerInfo") as Control
	var round_info = topbar.get_node("RoundInfo") as Control
	var round_label = round_info.get_node("RoundLabel") as Control
	var phase_label = round_info.get_node("PhaseLabel") as Control
	var timer_label = round_info.get_node("TimerLabel") as Control
	var start_battle_btn = round_info.get_node("StartBattleBtn") as Button
	
	var action_buttons = topbar.get_node("ActionButtons") if topbar.has_node("ActionButtons") else null
	var arena_bg_btn = topbar.get_node("ActionButtons/ArenaBgBtn") if topbar.has_node("ActionButtons/ArenaBgBtn") else (topbar.get_node("ArenaBgBtn") as Button)
	var pokedex_btn = topbar.get_node("ActionButtons/PokedexBtn") if topbar.has_node("ActionButtons/PokedexBtn") else (topbar.get_node("PokedexBtn") as Button)
	var team_comp_btn = topbar.get_node("ActionButtons/TeamCompBtn") if topbar.has_node("ActionButtons/TeamCompBtn") else (hud.get_node_or_null("TeamCompBtn") as Button)
	var dynamax_btn = topbar.get_node("ActionButtons/DynamaxBtn") if topbar.has_node("ActionButtons/DynamaxBtn") else (hud.get_node_or_null("DynamaxBtn") as Button)
	var level_info = topbar.get_node("LevelInfo") as Control
	
	var environment_bar = hud.get_node_or_null("EnvironmentBar") as Control
	var arena_banner = (environment_bar.get_node("ArenaBanner") if environment_bar and environment_bar.has_node("ArenaBanner") else hud.get_node_or_null("ArenaBanner")) as Button
	var weather_banner = (environment_bar.get_node("WeatherBanner") if environment_bar and environment_bar.has_node("WeatherBanner") else hud.get_node_or_null("WeatherBanner")) as Control

	# Set arena to stadium with 3 modifiers active (as in user screenshot)
	GameManager.current_arena_index = 0
	GameManager.current_round = 8
	GameManager.emit_arena_modifiers_updated()
	await get_tree().process_frame
	await get_tree().process_frame

	print("\n--- Test 1: Layout Verification in PREPARATION Phase ---")
	GameManager.current_phase = GameManager.Phase.PREPARATION
	hud._process(0.016)
	await get_tree().process_frame
	await get_tree().process_frame

	print("PlayerInfo:     [x: %.1f, right: %.1f]" % [player_info.global_position.x, player_info.global_position.x + player_info.size.x])
	print("RoundInfo:      [x: %.1f, right: %.1f]" % [round_info.global_position.x, round_info.global_position.x + round_info.size.x])
	print("StartBattleBtn: [x: %.1f, right: %.1f]" % [start_battle_btn.global_position.x, start_battle_btn.global_position.x + start_battle_btn.size.x])
	print("ArenaBgBtn:     [x: %.1f, right: %.1f, text: '%s']" % [arena_bg_btn.global_position.x, arena_bg_btn.global_position.x + arena_bg_btn.size.x, arena_bg_btn.text])
	print("PokedexBtn:     [x: %.1f, right: %.1f, text: '%s']" % [pokedex_btn.global_position.x, pokedex_btn.global_position.x + pokedex_btn.size.x, pokedex_btn.text])
	if team_comp_btn:
		print("TeamCompBtn:    [x: %.1f, right: %.1f, text: '%s']" % [team_comp_btn.global_position.x, team_comp_btn.global_position.x + team_comp_btn.size.x, team_comp_btn.text])
	if dynamax_btn:
		print("DynamaxBtn:     [x: %.1f, right: %.1f, text: '%s']" % [dynamax_btn.global_position.x, dynamax_btn.global_position.x + dynamax_btn.size.x, dynamax_btn.text])
	print("LevelInfo:      [x: %.1f, right: %.1f]" % [level_info.global_position.x, level_info.global_position.x + level_info.size.x])
	if weather_banner:
		print("WeatherBanner:  [x: %.1f, y: %.1f, right: %.1f, bottom: %.1f]" % [weather_banner.global_position.x, weather_banner.global_position.y, weather_banner.global_position.x + weather_banner.size.x, weather_banner.global_position.y + weather_banner.size.y])

	# 1. PlayerInfo < RoundInfo
	assert(player_info.global_position.x + player_info.size.x < round_info.global_position.x, "PlayerInfo must not overlap RoundInfo")
	# 2. StartBattleBtn < ArenaBgBtn
	assert(start_battle_btn.global_position.x + start_battle_btn.size.x < arena_bg_btn.global_position.x, "StartBattleBtn must not overlap ArenaBgBtn")
	var gap_prep = arena_bg_btn.global_position.x - (start_battle_btn.global_position.x + start_battle_btn.size.x)
	print("  [PASS] Gap between StartBattleBtn and ArenaBgBtn: %.1f px" % gap_prep)
	assert(gap_prep >= 8.0, "Must have gap between StartBattleBtn and ArenaBgBtn")

	# 3. ArenaBgBtn < PokedexBtn
	assert(arena_bg_btn.global_position.x + arena_bg_btn.size.x < pokedex_btn.global_position.x, "ArenaBgBtn must not overlap PokedexBtn")
	var gap_arena_pokedex = pokedex_btn.global_position.x - (arena_bg_btn.global_position.x + arena_bg_btn.size.x)
	print("  [PASS] Gap between ArenaBgBtn and PokedexBtn: %.1f px" % gap_arena_pokedex)
	assert(gap_arena_pokedex >= 4.0, "Must have gap between ArenaBgBtn and PokedexBtn")

	# 4. PokedexBtn < TeamCompBtn
	if team_comp_btn:
		assert(pokedex_btn.global_position.x + pokedex_btn.size.x < team_comp_btn.global_position.x, "PokedexBtn must not overlap TeamCompBtn")
		var gap_pokedex_tc = team_comp_btn.global_position.x - (pokedex_btn.global_position.x + pokedex_btn.size.x)
		print("  [PASS] Gap between PokedexBtn and TeamCompBtn: %.1f px" % gap_pokedex_tc)
		assert(gap_pokedex_tc >= 4.0, "Must have gap between PokedexBtn and TeamCompBtn")

		# 5. TeamCompBtn < DynamaxBtn
		if dynamax_btn:
			assert(team_comp_btn.global_position.x + team_comp_btn.size.x < dynamax_btn.global_position.x, "TeamCompBtn must not overlap DynamaxBtn")
			var gap_tc_dynamax = dynamax_btn.global_position.x - (team_comp_btn.global_position.x + team_comp_btn.size.x)
			print("  [PASS] Gap between TeamCompBtn and DynamaxBtn: %.1f px" % gap_tc_dynamax)
			assert(gap_tc_dynamax >= 4.0, "Must have gap between TeamCompBtn and DynamaxBtn")

			# 6. DynamaxBtn < LevelInfo
			assert(dynamax_btn.global_position.x + dynamax_btn.size.x < level_info.global_position.x, "DynamaxBtn must not overlap LevelInfo")
			var gap_dynamax_level = level_info.global_position.x - (dynamax_btn.global_position.x + dynamax_btn.size.x)
			print("  [PASS] Gap between DynamaxBtn and LevelInfo: %.1f px" % gap_dynamax_level)
			assert(gap_dynamax_level >= 6.0, "Must have gap between DynamaxBtn and LevelInfo")
	else:
		assert(pokedex_btn.global_position.x + pokedex_btn.size.x < level_info.global_position.x, "PokedexBtn must not overlap LevelInfo")

	# 7. WeatherBanner must NOT overlap TopBar buttons (strictly on Row 2 at y >= 56)
	if weather_banner:
		var topbar_bottom = topbar.global_position.y + topbar.size.y
		assert(weather_banner.global_position.y >= topbar_bottom, "WeatherBanner must be strictly below TopBar (y >= %.1f), got y=%.1f" % [topbar_bottom, weather_banner.global_position.y])
		print("  [PASS] WeatherBanner is cleanly located on Row 2 (y=%.1f >= TopBar bottom %.1f)" % [weather_banner.global_position.y, topbar_bottom])

	print("\n--- Test 2: Layout Verification in COMBAT Phase ---")
	GameManager.current_phase = GameManager.Phase.COMBAT
	hud._process(0.016)
	await get_tree().process_frame
	await get_tree().process_frame

	print("TimerLabel: [x: %.1f, right: %.1f, text: '%s']" % [timer_label.global_position.x, timer_label.global_position.x + timer_label.size.x, timer_label.text])
	print("ArenaBgBtn: [x: %.1f, right: %.1f]" % [arena_bg_btn.global_position.x, arena_bg_btn.global_position.x + arena_bg_btn.size.x])

	assert(not start_battle_btn.visible, "StartBattleBtn should be hidden during combat")
	assert(timer_label.global_position.x + timer_label.size.x < arena_bg_btn.global_position.x, "TimerLabel must not overlap ArenaBgBtn")
	var gap_combat = arena_bg_btn.global_position.x - (timer_label.global_position.x + timer_label.size.x)
	print("  [PASS] Gap between TimerLabel and ArenaBgBtn in Combat: %.1f px" % gap_combat)
	assert(gap_combat >= 20.0, "Must have generous gap between TimerLabel and ArenaBgBtn in combat")

	main_inst.queue_free()

	print("\n========================================================")
	print(">>> ALL TOPBAR & ENVIRONMENT BAR LAYOUT CHECKS PASSED (100% ZERO OVERLAPS)! <<<")
	print("========================================================\n")
	get_tree().quit(0)
