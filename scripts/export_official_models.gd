extends SceneTree

func _init():
	print("Exporting Clean Official Pokemon GLB Models...")
	export_pikachu()
	export_charmander()
	export_squirtle()
	export_bulbasaur()
	print("All 4 Official Models Exported Successfully!")
	quit()

func save_to_glb(node: Node3D, dest_path: String) -> bool:
	var gltf = GLTFDocument.new()
	var state = GLTFState.new()
	var err = gltf.append_from_scene(node, state)
	if err != OK:
		print("Error appending scene to GLTF for ", dest_path, ": ", err)
		return false
	var write_err = gltf.write_to_filesystem(state, dest_path)
	if write_err != OK:
		print("Error writing GLTF to ", dest_path, ": ", write_err)
		return false
	print("Saved GLB: ", dest_path)
	return true

func export_pikachu():
	var scene = load("res://assets/models/official/pikachu/Pikachu.fbx")
	var inst = scene.instantiate()
	var mi: MeshInstance3D = inst.find_child("PikachuF", true, false)
	if mi:
		var tex_paths = [
			"res://assets/models/official/pikachu/Pikachu_0.png",
			"res://assets/models/official/pikachu/Pikachu_1.png",
			"res://assets/models/official/pikachu/Pikachu_2.png",
			"res://assets/models/official/pikachu/Pikachu_3.png"
		]
		for s in range(min(4, mi.mesh.get_surface_count())):
			var mat = mi.get_active_material(s)
			if mat == null:
				mat = StandardMaterial3D.new()
			else:
				mat = mat.duplicate()
			if ResourceLoader.exists(tex_paths[s]):
				mat.albedo_texture = load(tex_paths[s])
			mat.roughness = 0.55
			mat.metallic = 0.05
			mi.set_surface_override_material(s, mat)
			
	save_to_glb(inst, "res://assets/models/pikachu.glb")
	inst.free()

func export_charmander():
	var scene = load("res://assets/models/official/charmander/Charmander.fbx")
	var inst = scene.instantiate()
	var mi: MeshInstance3D = inst.find_child("Charmander", true, false)
	if mi:
		# surf 0: Body, surf 1: Eye, surf 2: Tail Flame
		var mat0 = mi.get_active_material(0)
		if mat0:
			mat0 = mat0.duplicate()
			mat0.roughness = 0.55
			mi.set_surface_override_material(0, mat0)
			
		var mat1 = mi.get_active_material(1)
		if mat1:
			mat1 = mat1.duplicate()
			mat1.roughness = 0.3
			mi.set_surface_override_material(1, mat1)
			
		# Tail Flame Material
		var flame_mat = StandardMaterial3D.new()
		flame_mat.resource_name = "TailFlame"
		var flame_tex = load("res://assets/models/official/charmander/tex/pm0004_00_FireCoreA1.png")
		flame_mat.albedo_texture = flame_tex
		flame_mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
		flame_mat.cull_mode = BaseMaterial3D.CULL_DISABLED
		flame_mat.emission_enabled = true
		flame_mat.emission = Color(1.0, 0.55, 0.12)
		flame_mat.emission_energy_multiplier = 2.0
		flame_mat.emission_texture = flame_tex
		mi.set_surface_override_material(2, flame_mat)
		
	save_to_glb(inst, "res://assets/models/charmander.glb")
	inst.free()

func export_squirtle():
	var scene = load("res://assets/models/official/squirtle/Squirtle.fbx")
	var inst = scene.instantiate()
	var mi: MeshInstance3D = inst.find_child("Squirtle", true, false)
	if mi:
		for s in range(mi.mesh.get_surface_count()):
			var mat = mi.get_active_material(s)
			if mat:
				mat = mat.duplicate()
				mat.roughness = 0.5
				mi.set_surface_override_material(s, mat)
				
	save_to_glb(inst, "res://assets/models/squirtle.glb")
	inst.free()

func export_bulbasaur():
	var scene = load("res://assets/models/official/bulbasaur/Bulbasaur_split.fbx")
	var inst = scene.instantiate()
	for c in inst.find_children("*", "MeshInstance3D", true, false):
		var mi = c as MeshInstance3D
		if mi:
			for s in range(mi.mesh.get_surface_count()):
				var mat = mi.get_active_material(s)
				if mat:
					mat = mat.duplicate()
					mat.roughness = 0.55
					mi.set_surface_override_material(s, mat)
					
	save_to_glb(inst, "res://assets/models/bulbasaur.glb")
	inst.free()
