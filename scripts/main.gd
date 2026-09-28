extends Node2D

# Main controller scene for Pokemon Auto-Chess

@onready var board: Node2D = $Board
@onready var hud: CanvasLayer = $HUD
@onready var battle_bg_texture: TextureRect = $Background/BattleBgTexture

var main_camera: Camera2D = null
var current_trauma: float = 0.0

func _ready() -> void:
	if not GameManager.background_changed.is_connected(_on_background_changed):
		GameManager.background_changed.connect(_on_background_changed)
	if not GameManager.camera_shake_requested.is_connected(_on_camera_shake_requested):
		GameManager.camera_shake_requested.connect(_on_camera_shake_requested)
	
	main_camera = Camera2D.new()
	main_camera.name = "MainCamera"
	main_camera.anchor_mode = Camera2D.ANCHOR_MODE_FIXED_TOP_LEFT
	add_child(main_camera)
	
	# Start game loop (picks a random arena background)
	GameManager.start_new_game()
	
	if battle_bg_texture and battle_bg_texture.texture == null and GameManager.current_background_path != "":
		_apply_background_texture(GameManager.current_background_path)

func _process(delta: float) -> void:
	if current_trauma > 0.0 and main_camera:
		var shake_amount = pow(current_trauma, 1.8) * 12.0
		var ox = randf_range(-1.0, 1.0) * shake_amount
		var oy = randf_range(-1.0, 1.0) * shake_amount
		main_camera.offset = Vector2(ox, oy)
		current_trauma = max(0.0, current_trauma - delta * 3.5)
		if current_trauma <= 0.0:
			main_camera.offset = Vector2.ZERO

func _on_camera_shake_requested(trauma: float, _duration: float) -> void:
	current_trauma = clamp(current_trauma + trauma, 0.0, 1.0)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_B:
			GameManager.cycle_background()

func _on_background_changed(bg_path: String, _arena_info: Dictionary = {}) -> void:
	_apply_background_texture(bg_path)

func _apply_background_texture(bg_path: String) -> void:
	if not battle_bg_texture or not ResourceLoader.exists(bg_path):
		return
	var tex = load(bg_path)
	if tex:
		battle_bg_texture.modulate.a = 0.0
		battle_bg_texture.texture = tex
		var tw = create_tween()
		tw.tween_property(battle_bg_texture, "modulate:a", 1.0, 0.35)
