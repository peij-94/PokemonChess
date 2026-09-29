extends Node3D

@onready var turntable: Node3D = $Turntable
@onready var info_label: Label = $CanvasLayer/InfoLabel

var model_paths = {
	"pikachu": "res://assets/models/pikachu.glb",
	"charmander": "res://assets/models/charmander.glb",
	"squirtle": "res://assets/models/squirtle.glb"
}

func _ready() -> void:
	load_and_setup_models()

func load_and_setup_models() -> void:
	var slots = {
		"pikachu": $Turntable/PikachuSlot,
		"charmander": $Turntable/CharmanderSlot,
		"squirtle": $Turntable/SquirtleSlot
	}
	
	for key in model_paths.keys():
		var path = model_paths[key]
		var slot = slots.get(key)
		if slot == null or not FileAccess.file_exists(path):
			continue
			
		var gltf = GLTFDocument.new()
		var state = GLTFState.new()
		var err = gltf.append_from_file(path, state)
		if err != OK:
			print("Failed to load GLTF: ", path)
			continue
			
		var model = gltf.generate_scene(state)
		if model == null:
			continue
			
		var pivot = Node3D.new()
		pivot.name = key + "_Pivot"
		pivot.position = Vector3(0, 0.08, 0)
		slot.add_child(pivot)
		pivot.add_child(model)
		
		# Normalize model scale to fit tabletop pedestal (~1.0m to 1.15m)
		var aabb = _calculate_model_aabb(model)
		var max_dim = max(aabb.size.x, max(aabb.size.y, aabb.size.z))
		if max_dim > 0.001:
			var target_sz = 1.15
			var s = target_sz / max_dim
			model.scale = Vector3(s, s, s)
			# Center horizontally and position feet on pedestal surface
			model.position.y = -aabb.position.y * s
			model.position.x = -(aabb.position.x + aabb.size.x * 0.5) * s
			model.position.z = -(aabb.position.z + aabb.size.z * 0.5) * s
		
		# Play animations if available
		var anim_player: AnimationPlayer = model.find_child("AnimationPlayer", true, false)
		if anim_player:
			var anims = anim_player.get_animation_list()
			if not anims.is_empty():
				anim_player.play(anims[0])

func _calculate_model_aabb(node: Node) -> AABB:
	var total_aabb = AABB()
	var first = true
	var stack = [node]
	while not stack.is_empty():
		var curr = stack.pop_back()
		if curr is MeshInstance3D and curr.mesh:
			var maabb = curr.get_aabb()
			if first:
				total_aabb = maabb
				first = false
			else:
				total_aabb = total_aabb.merge(maabb)
		for c in curr.get_children():
			stack.push_back(c)
	if first:
		return AABB(Vector3(-0.5, 0, -0.5), Vector3(1, 1, 1))
	return total_aabb

func _process(delta: float) -> void:
	if turntable:
		turntable.rotation.y += delta * 0.35
