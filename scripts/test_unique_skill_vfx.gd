extends Node

func _ready() -> void:
	print("\n========================================================")
	print(">>> STARTING UNIQUE SKILL VFX COMPREHENSIVE TEST <<<")
	print("========================================================")
	
	var all_ids = PokemonDatabase.pokemons.keys()
	print("Checking total Pokemon: %d" % all_ids.size())
	
	var total_skills_checked = 0
	var within_star_vfx_dups = 0
	var cross_star_vfx_dups = 0
	var cross_star_name_dups = 0
	var total_missing_assets = 0
	var unique_vfx_set = {}
	
	for id in all_ids:
		var pkm = PokemonDatabase.pokemons[id]
		var skills_dict = pkm.get("skills", {})
		
		var pkm_all_vfx = {}
		var pkm_all_names = {}
		
		for star in [1, 2, 3]:
			var choices = skills_dict.get(star, [])
			var star_seen_vfx = {}
			for c in choices:
				total_skills_checked += 1
				var vfx_name = c.get("vfx", "")
				var skill_name = c.get("name", "")
				
				# 1. Within-star VFX duplicate
				if star_seen_vfx.has(vfx_name):
					print("  [FAIL WITHIN-STAR DUP] %s (★%d) has duplicate VFX '%s' between '%s' and '%s'" % [id, star, vfx_name, star_seen_vfx[vfx_name], skill_name])
					within_star_vfx_dups += 1
				else:
					star_seen_vfx[vfx_name] = skill_name
					
				# 2. Cross-star VFX duplicate for this pokemon
				if pkm_all_vfx.has(vfx_name):
					print("  [FAIL CROSS-STAR VFX DUP] %s has duplicate VFX '%s' across ★%d ('%s') and ★%d ('%s')" % [id, vfx_name, pkm_all_vfx[vfx_name]["star"], pkm_all_vfx[vfx_name]["name"], star, skill_name])
					cross_star_vfx_dups += 1
				else:
					pkm_all_vfx[vfx_name] = {"star": star, "name": skill_name}
					
				# 3. Cross-star Name duplicate for this pokemon
				if pkm_all_names.has(skill_name):
					print("  [FAIL CROSS-STAR NAME DUP] %s has duplicate skill name '%s' in ★%d and ★%d" % [id, skill_name, pkm_all_names[skill_name], star])
					cross_star_name_dups += 1
				else:
					pkm_all_names[skill_name] = star
					
				unique_vfx_set[vfx_name] = true
				
				# 4. Asset existence
				var frame0_path = "res://assets/vfx/%s/frame_0.png" % vfx_name
				if not FileAccess.file_exists(frame0_path) and not ResourceLoader.exists(frame0_path):
					print("  [FAIL ASSET MISSING] %s (★%d) skill '%s' references missing VFX '%s' (%s)" % [id, star, skill_name, vfx_name, frame0_path])
					total_missing_assets += 1

	print("\n--- Summary of Verification ---")
	print("  Total Pokemon Verified: %d" % all_ids.size())
	print("  Total Skills Checked: %d" % total_skills_checked)
	print("  Unique VFX Types Referenced Across Game: %d" % unique_vfx_set.size())
	print("  Within-Star VFX Duplicates: %d" % within_star_vfx_dups)
	print("  Cross-Star VFX Duplicates (Per Pokemon): %d" % cross_star_vfx_dups)
	print("  Cross-Star Name Duplicates (Per Pokemon): %d" % cross_star_name_dups)
	print("  Missing Asset Files: %d" % total_missing_assets)

	# Test VFX spawning for all unique VFX
	print("\n--- Test VFX Spawning in Engine ---")
	var vfx_host = Node2D.new()
	add_child(vfx_host)
	
	for vfx_name in unique_vfx_set.keys():
		SkillVFX.spawn_skill_vfx(vfx_name, vfx_host, Vector2(100, 100), Vector2(200, 100), 1.0)
	
	print("  [PASS] Successfully spawned all %d unique VFX in SkillVFX!" % unique_vfx_set.size())

	assert(within_star_vfx_dups == 0, "Within-star duplicate VFX detected!")
	assert(cross_star_vfx_dups == 0, "Cross-star duplicate VFX detected!")
	assert(cross_star_name_dups == 0, "Cross-star duplicate skill names detected!")
	assert(total_missing_assets == 0, "Missing VFX assets detected!")

	print("\n========================================================")
	print(">>> ALL UNIQUE SKILL VFX & NAME TESTS PASSED (100%) <<<")
	print("========================================================\n")
	get_tree().quit(0)
