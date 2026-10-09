class_name FloatingTextPool
extends RefCounted

# High-efficiency object pool for damage, combo, healing, and floating combat text
# Prevents thousands of scene instantiations and GC deallocations per battle

static var _pool: Array[Node2D] = []
static var _active: Array[Node2D] = []
const MAX_POOL_SIZE: int = 40
static var _scene: PackedScene = preload("res://scenes/floating_text.tscn")

static func spawn(parent: Node, pos: Vector2, text: String, color: Color, is_crit: bool = false, custom_scale: float = -1.0) -> Node2D:
	if not is_instance_valid(parent):
		return null
		
	var ft: Node2D = null
	while not _pool.is_empty():
		var candidate = _pool.pop_back()
		if is_instance_valid(candidate):
			ft = candidate
			break
			
	if ft == null:
		ft = _scene.instantiate()
		ft.set("is_pooled", true)
	
	if ft.get_parent() != parent:
		if ft.get_parent() != null:
			ft.get_parent().remove_child(ft)
		parent.add_child(ft)
	
	ft.position = pos
	ft.visible = true
	ft.modulate = Color.WHITE
	if ft.has_method("setup"):
		ft.setup(text, color, is_crit, custom_scale)
		
	if not _active.has(ft):
		_active.append(ft)
	return ft

static func recycle(ft: Node2D) -> void:
	var idx = _active.find(ft)
	if idx != -1:
		_active.remove_at(idx)
	if _pool.size() < MAX_POOL_SIZE and is_instance_valid(ft):
		ft.visible = false
		_pool.append(ft)
	elif is_instance_valid(ft):
		ft.queue_free()

static func clear_pool() -> void:
	for ft in _pool:
		if is_instance_valid(ft):
			ft.queue_free()
	_pool.clear()
	_active.clear()

static func get_pool_stats() -> Dictionary:
	return {
		"pool_size": _pool.size(),
		"active_count": _active.size(),
		"max_capacity": MAX_POOL_SIZE
	}
