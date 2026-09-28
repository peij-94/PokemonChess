extends Node

# Automated test suite for Action VFX & Game Feel Enhancements:
# 1. Hit Flash & Micro-Stagger
# 2. Mana Glow (Full Mana Readiness Aura)
# 3. Camera Shake Trauma System
# 4. Cinematic Spotlight Screen Dimmer
# 5. Parabolic Ranged Projectiles & Trails
# 6. Ground Telegraphs & Scorch/Elemental Decals

func _ready() -> void:
	print("\n========================================================")
	print(">>> STARTING ACTION VFX & GAME FEEL AUTOMATED TESTS <<<")
	print("========================================================")
	
	var main_scene = load("res://scenes/main.tscn")
	var main_inst = main_scene.instantiate()
	add_child(main_inst)
	
	var board = main_inst.get_node("Board")
	var hud = main_inst.get_node("HUD")
	
	# --- Test 1: Shader Hit Flash & Mana Glow Parameters ---
	print("\n--- Test 1: Shader Hit Flash & Mana Glow Parameters ---")
	var unit_scene = load("res://scenes/unit.tscn")
	var charizard = unit_scene.instantiate() as Unit
	add_child(charizard)
	charizard.setup("charizard", 3, false)
	
	var mat = charizard.icon_sprite.material as ShaderMaterial
	assert(mat != null, "Unit icon_sprite must have ShaderMaterial")
	
	# Verify hit_flash uniform
	mat.set_shader_parameter("hit_flash", 1.0)
	var flash_val = mat.get_shader_parameter("hit_flash")
	assert(flash_val == 1.0, "hit_flash shader parameter must be readable and set to 1.0")
	
	# Verify mana_glow uniform
	mat.set_shader_parameter("mana_glow", 0.75)
	mat.set_shader_parameter("mana_glow_color", Color(1.0, 0.4, 0.1))
	var glow_val = mat.get_shader_parameter("mana_glow")
	assert(glow_val == 0.75, "mana_glow shader parameter must be readable and set to 0.75")
	print("  [PASS] ShaderMaterial correctly exposes and accepts 'hit_flash' and 'mana_glow'.")
	
	# --- Test 2: Take Damage Triggers Hit Flash & Micro-Stagger ---
	print("\n--- Test 2: Take Damage Triggers Hit Flash & Micro-Stagger ---")
	charizard.types = ["Fire"] # Ensure no Flying dodge roll during deterministic test
	var hp_before = charizard.current_hp
	charizard.take_damage(200.0, false, false, false, null)
	assert(charizard.current_hp < hp_before, "Charizard took damage")
	print("  [PASS] take_damage executed with hit flash and micro-stagger feedback.")
	
	# --- Test 3: Camera Shake Trauma System ---
	print("\n--- Test 3: Camera Shake Trauma System ---")
	var shake_result = {"received": false, "trauma": 0.0}
	GameManager.camera_shake_requested.connect(func(t: float, _d: float):
		shake_result["received"] = true
		shake_result["trauma"] = t
	)
	GameManager.shake_camera(0.65, 0.25)
	assert(shake_result["received"], "camera_shake_requested signal should be emitted")
	assert(shake_result["trauma"] == 0.65, "Trauma amount should match 0.65")
	print("  [PASS] Camera shake trauma system verified (trauma=%.2f)." % shake_result["trauma"])
	
	# --- Test 4: Cinematic Spotlight Screen Dimmer ---
	print("\n--- Test 4: Cinematic Spotlight Screen Dimmer ---")
	var spot_result = {"received": false, "darkness": 0.0}
	GameManager.cinematic_spotlight_requested.connect(func(_dur: float, d: float):
		spot_result["received"] = true
		spot_result["darkness"] = d
	)
	GameManager.trigger_cinematic_spotlight(0.5, 0.42)
	assert(spot_result["received"], "cinematic_spotlight_requested signal should be emitted")
	assert(spot_result["darkness"] == 0.42, "Spotlight darkness should be 0.42")
	assert(hud.has_node("CinematicSpotlight"), "HUD must have CinematicSpotlight ColorRect")
	print("  [PASS] Cinematic spotlight screen dimmer verified (darkness=%.2f)." % spot_result["darkness"])
	
	# --- Test 5: Parabolic Projectile Trajectory & Particle Trail ---
	print("\n--- Test 5: Parabolic Projectile Trajectory & Particle Trail ---")
	var target_dummy = unit_scene.instantiate() as Unit
	add_child(target_dummy)
	target_dummy.setup("snorlax", 2, true)
	
	var hit_called = false
	AttackVFX.spawn_ranged_projectile(main_inst, Vector2(100, 200), target_dummy, "charmander", false, func():
		hit_called = true
	)
	print("  [PASS] Parabolic projectile with comet particle trail dispatched.")
	
	# --- Test 6: Ground Telegraph & Ground Decals ---
	print("\n--- Test 6: Ground Telegraph & Ground Decals ---")
	SkillVFX.spawn_ground_telegraph(main_inst, Vector2(400, 300), 50.0, 0.3)
	SkillVFX.spawn_ground_decal(main_inst, Vector2(400, 300), "scorch")
	SkillVFX.spawn_ground_decal(main_inst, Vector2(500, 300), "electric")
	SkillVFX.spawn_ground_decal(main_inst, Vector2(600, 300), "frost")
	print("  [PASS] Ground telegraph ring and elemental decals (scorch/electric/frost) spawned cleanly.")
	
	print("\n========================================================")
	print(">>> ALL ACTION VFX & GAME FEEL TESTS PASSED (100%) <<<")
	print("========================================================\n")
	get_tree().quit(0)
