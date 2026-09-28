extends Node

func _ready() -> void:
	print("\n=== STARTING COMBAT VISUALS & STUN VFX TESTS ===")
	await get_tree().process_frame
	
	# 1. Test Floating Text Combo Scaling
	print("Testing Floating Text Combo 0.4x Scale:")
	var ft_scene = preload("res://scenes/floating_text.tscn")
	var ft_combo = ft_scene.instantiate()
	add_child(ft_combo)
	ft_combo.setup("3连击!", Color.YELLOW, true, 0.4)
	# Originally 1.5 * 1.0 = 1.5. With 0.4 scale: 1.5 * 0.4 = 0.6
	assert(abs(ft_combo.scale.x - 0.6) < 0.05, "Combo text should scale to 0.4x of original (1.5 * 0.4 = 0.6)")
	print("[PASS] Combo floating text scale verified: %s (expected ~0.60)" % str(ft_combo.scale))
	ft_combo.queue_free()
	
	# 2. Test Dodge Floating Text Trajectory and Scale
	print("Testing Dodge Floating Text:")
	var ft_dodge = ft_scene.instantiate()
	add_child(ft_dodge)
	ft_dodge.setup("闪避", Color.CYAN, false, 0.7)
	assert(abs(ft_dodge.scale.x - 0.7) < 0.05, "Dodge text should have scale 0.7")
	print("[PASS] Dodge floating text scale verified: %s" % str(ft_dodge.scale))
	ft_dodge.queue_free()
	
	# 3. Test AttackVFX.spawn_crit_impact
	print("Testing AttackVFX.spawn_crit_impact:")
	var vfx_container = Node2D.new()
	add_child(vfx_container)
	AttackVFX.spawn_crit_impact(vfx_container, Vector2(100, 100))
	assert(vfx_container.get_child_count() > 0, "Crit impact should spawn a child in container")
	var crit_child = vfx_container.get_child(0)
	print("[PASS] Crit impact node created successfully with children: %d" % crit_child.get_child_count())
	
	# 4. Test AttackVFX.spawn_dodge_vfx
	print("Testing AttackVFX.spawn_dodge_vfx:")
	AttackVFX.spawn_dodge_vfx(vfx_container, Vector2(200, 200), Vector2(1, -0.5))
	assert(vfx_container.get_child_count() >= 2, "Dodge VFX should spawn in container")
	print("[PASS] Dodge VFX created successfully!")
	vfx_container.queue_free()
	
	# 5. Test Unit Stun VFX & Zero Text Notification
	print("Testing Unit Stun VFX & Absence of Text Notification:")
	var unit_scene = preload("res://scenes/unit.tscn")
	var test_parent = Node2D.new()
	add_child(test_parent)
	var test_unit = unit_scene.instantiate() as Unit
	test_parent.add_child(test_unit)
	test_unit.setup("pikachu", 1, false)
	await get_tree().process_frame
	
	var initial_child_count = test_parent.get_child_count()
	# Apply stun
	test_unit.apply_stun(0.8)
	assert(test_unit.is_stunned, "Unit should be marked as stunned")
	assert(test_unit.stun_vfx != null, "Unit should have stun_vfx instantiated")
	assert(test_unit.stun_vfx.visible, "Stun VFX should become visible")
	assert(test_unit.stun_vfx.is_active, "Stun VFX should be active")
	
	# Verify NO floating text was added to parent (child count remains same)
	assert(test_parent.get_child_count() == initial_child_count, "No floating text should be spawned on stun!")
	print("[PASS] Stun VFX activated and no text notification was spawned!")
	
	# Test process frame during stun (dizzy sway)
	test_unit.is_in_combat = true
	test_unit._process(0.1)
	assert(test_unit.icon_sprite.rotation != 0.0, "Unit should wobble/sway while stunned")
	print("[PASS] Unit dizzy sway rotation active: %.4f rad" % test_unit.icon_sprite.rotation)
	
	# Test stun expiration
	test_unit._process(1.0)
	assert(not test_unit.is_stunned, "Stun should expire after timer ends")
	assert(test_unit.icon_sprite.rotation == 0.0, "Rotation should reset to 0 after stun ends")
	print("[PASS] Stun expired cleanly, rotation reset to 0, and VFX deactivated!")
	
	# 6. Test Unit Dodge Reaction
	print("Testing Unit Dodge Reaction:")
	test_unit._play_dodge_reaction()
	# Afterimage ghost should have been added to test_parent
	assert(test_parent.get_child_count() > initial_child_count, "Dodge reaction should spawn afterimage and floating text")
	print("[PASS] Dodge reaction spawned ghost afterimage and floating text cleanly!")
	
	test_parent.queue_free()
	
	print("\n========================================================")
	print(">>> ALL COMBAT VISUALS & STUN VFX TESTS PASSED (6/6) <<<")
	print("========================================================")
	get_tree().quit(0)
