extends Node

func _ready() -> void:
	print("\n=== INSPECTING POKEDEX SKILLS & EVOLUTION CHAINS ===")
	await get_tree().process_frame
	
	# Check 1: What does get_skill_data return for charmander, charmeleon, charizard?
	print("\n--- Check 1: Raw Database Skills ---")
	for star in [1, 2, 3]:
		var s_cm = PokemonDatabase.get_skill_data("charmander", star)
		print("Charmander Star %d: %s (choices: %d)" % [star, s_cm.get("name"), PokemonDatabase.get_skill_choices("charmander", star).size()])
	
	for star in [1, 2, 3]:
		var s_cl = PokemonDatabase.get_skill_data("charmeleon", star)
		print("Charmeleon Star %d: %s (choices: %d)" % [star, s_cl.get("name"), PokemonDatabase.get_skill_choices("charmeleon", star).size()])
		
	for star in [1, 2, 3]:
		var s_cz = PokemonDatabase.get_skill_data("charizard", star)
		print("Charizard Star %d: %s (choices: %d)" % [star, s_cz.get("name"), PokemonDatabase.get_skill_choices("charizard", star).size()])

	# Check 2: Instantiate PokedexModal and see what it displays for charmander
	print("\n--- Check 2: PokedexModal UI State for Charmander ---")
	var p_scene = load("res://scenes/pokedex_modal.tscn")
	var p_inst = p_scene.instantiate()
	get_parent().add_child(p_inst)
	await get_tree().process_frame
	
	p_inst.showcase_pokemon("charmander")
	print("Selected: ", p_inst.selected_id)
	print("Star 1 Title: ", p_inst.skill_title.text)
	
	p_inst.update_skill_card("charmander", 2, false)
	print("Star 2 Title: ", p_inst.skill_title.text)
	print("Star 2 Desc:\n", p_inst.skill_desc.text)
	
	p_inst.update_skill_card("charmander", 3, false)
	print("Star 3 Title: ", p_inst.skill_title.text)
	print("Star 3 Desc:\n", p_inst.skill_desc.text)

	# Check 3: Does Pokédex list Charmeleon and Charizard as separate cards in list?
	print("\n--- Check 3: Cards in Pokedex list ---")
	print("Total cards in Pokédex: ", p_inst.pokemon_cards.size())
	print("Has charmander in cards: ", p_inst.pokemon_cards.has("charmander"))
	print("Has charmeleon in cards: ", p_inst.pokemon_cards.has("charmeleon"))
	print("Has charizard in cards: ", p_inst.pokemon_cards.has("charizard"))
	
	# Check 4: Check if any Pokémon has missing skills or empty names
	print("\n--- Check 4: Sanity check all 152 Pokemon skills ---")
	var issues = 0
	for pid in PokemonDatabase.pokemons:
		for star in [1, 2, 3]:
			var s = PokemonDatabase.get_skill_data(pid, star)
			if s.get("name", "") == "":
				print("WARNING: Empty skill name for %s star %d" % [pid, star])
				issues += 1
	print("Issues found across all 152 Pokemon: ", issues)

	p_inst.queue_free()
	get_tree().quit(0)
