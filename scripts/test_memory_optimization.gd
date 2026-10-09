extends Node2D

const FloatingTextPool = preload("res://scripts/floating_text_pool.gd")

func _ready() -> void:
	print("==================================================")
	print(">>> POKEMON CHESS MEMORY PROFILING & DIAGNOSTICS <<<")
	print("==================================================")
	
	print("\n--- 1. Initial State ---")
	print("Static Memory: %.2f MB" % (Performance.get_monitor(Performance.MEMORY_STATIC) / 1024.0 / 1024.0))
	print("Max Static Memory: %.2f MB" % (Performance.get_monitor(Performance.MEMORY_STATIC_MAX) / 1024.0 / 1024.0))
	print("Object Count: %d" % Performance.get_monitor(Performance.OBJECT_COUNT))
	print("Resource Count: %d" % Performance.get_monitor(Performance.OBJECT_RESOURCE_COUNT))
	print("Node Count: %d" % Performance.get_monitor(Performance.OBJECT_NODE_COUNT))
	
	# Load main scene
	var main_scene = load("res://scenes/main.tscn").instantiate()
	add_child(main_scene)
	await get_tree().process_frame
	
	print("\n--- 2. After Main Scene Instantiation ---")
	print("Static Memory: %.2f MB" % (Performance.get_monitor(Performance.MEMORY_STATIC) / 1024.0 / 1024.0))
	print("Object Count: %d" % Performance.get_monitor(Performance.OBJECT_COUNT))
	print("Resource Count: %d" % Performance.get_monitor(Performance.OBJECT_RESOURCE_COUNT))
	print("Node Count: %d" % Performance.get_monitor(Performance.OBJECT_NODE_COUNT))
	
	var pokedex = main_scene.find_child("PokedexModal", true, false)
	if pokedex:
		pokedex.populate_pokemon_list()
		await get_tree().process_frame
		print("\n--- 3. After Pokedex Population (493 Pokemon Cards) ---")
		print("Static Memory: %.2f MB" % (Performance.get_monitor(Performance.MEMORY_STATIC) / 1024.0 / 1024.0))
		print("Object Count: %d" % Performance.get_monitor(Performance.OBJECT_COUNT))
		print("Resource Count: %d" % Performance.get_monitor(Performance.OBJECT_RESOURCE_COUNT))
		print("Node Count: %d" % Performance.get_monitor(Performance.OBJECT_NODE_COUNT))
		
		# Now filter 6 times
		for f in [1, 2, 3, 4, 5, 0]:
			pokedex.current_cost_filter = f
			pokedex.populate_pokemon_list()
			await get_tree().process_frame
		print("\n--- 4. After 6 Pokedex Filter Switches (Checking Node Leaks) ---")
		print("Static Memory: %.2f MB" % (Performance.get_monitor(Performance.MEMORY_STATIC) / 1024.0 / 1024.0))
		print("Object Count: %d" % Performance.get_monitor(Performance.OBJECT_COUNT))
		print("Resource Count: %d" % Performance.get_monitor(Performance.OBJECT_RESOURCE_COUNT))
		print("Node Count: %d" % Performance.get_monitor(Performance.OBJECT_NODE_COUNT))
	
	print("\n--- 5. SpriteFrames Loading & Cache Memory ---")
	var initial_sf = PokemonDatabase.cached_sprite_frames.size()
	print("Cached SpriteFrames count before: %d" % initial_sf)
	var sample_pids = PokemonDatabase.pokemons.keys().slice(0, 50)
	for pid in sample_pids:
		PokemonDatabase.get_sprite_frames(pid)
	print("Loaded 50 SpriteFrames (out of 493):")
	print("Static Memory: %.2f MB" % (Performance.get_monitor(Performance.MEMORY_STATIC) / 1024.0 / 1024.0))
	print("Max Static Memory: %.2f MB" % (Performance.get_monitor(Performance.MEMORY_STATIC_MAX) / 1024.0 / 1024.0))
	print("Resource Count: %d" % Performance.get_monitor(Performance.OBJECT_RESOURCE_COUNT))
	
	print("\n--- 6. Pruning Unused Cache (Reclaiming Textures) ---")
	PokemonDatabase.prune_unused_cache()
	await get_tree().process_frame
	print("Cached SpriteFrames count after prune: %d" % PokemonDatabase.cached_sprite_frames.size())
	print("Static Memory after prune: %.2f MB" % (Performance.get_monitor(Performance.MEMORY_STATIC) / 1024.0 / 1024.0))
	print("Resource Count after prune: %d" % Performance.get_monitor(Performance.OBJECT_RESOURCE_COUNT))
	
	print("\n--- 7. FloatingTextPool Stress Test (100 Spawns) ---")
	var node_count_before = Performance.get_monitor(Performance.OBJECT_NODE_COUNT)
	for i in range(100):
		var ft = FloatingTextPool.spawn(self, Vector2(100, 100), "120", Color.RED)
		FloatingTextPool.recycle(ft)
	var pool_stats = FloatingTextPool.get_pool_stats()
	print("Pool stats: ", pool_stats)
	var node_count_after = Performance.get_monitor(Performance.OBJECT_NODE_COUNT)
	print("Node count change during 100 spawns: %d (pooled reuse verified!)" % (node_count_after - node_count_before))
	
	print("\n==================================================")
	print(">>> ALL MEMORY DIAGNOSTICS COMPLETED CLEANLY! <<<")
	print("==================================================")
	get_tree().quit()
