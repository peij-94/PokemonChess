extends Node

# AudioManager singleton for playing synthesized and procedural SFX & BGM

var sound_streams: Dictionary = {}
var player_pool: Array[AudioStreamPlayer] = []
const POOL_SIZE = 8

# BGM Management
var bgm_streams: Dictionary = {}
var bgm_player: AudioStreamPlayer = null
var current_bgm_track: String = ""
var bgm_volume: float = 0.7  # 0.0 ~ 1.0 linear
var sfx_volume: float = 0.8  # 0.0 ~ 1.0 linear
var is_muted: bool = false
var bgm_tween: Tween = null

signal mute_toggled(is_muted: bool)
signal bgm_track_changed(track_name: String)

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	# Create player pool for polyphonic SFX
	for i in range(POOL_SIZE):
		var p = AudioStreamPlayer.new()
		p.bus = "Master"
		add_child(p)
		player_pool.append(p)
	
	# Create dedicated BGM player
	bgm_player = AudioStreamPlayer.new()
	bgm_player.bus = "Master"
	add_child(bgm_player)
	bgm_player.finished.connect(_on_bgm_finished)
	
	load_sounds()
	load_bgm()

func load_sounds() -> void:
	var sfx_names = [
		"click", "buy", "sell", "evolve", "attack",
		"slash", "punch", "spark",
		"thunder", "fire", "water", "skill", "victory",
		"defeat", "round_start", "swift", "blizzard",
		"discharge", "aura_sphere"
	]
	for sname in sfx_names:
		var path = "res://assets/audio/sfx_%s.wav" % sname
		if ResourceLoader.exists(path):
			var stream = load(path)
			sound_streams[sname] = stream
		else:
			print("Audio stream not found at: ", path)

func load_bgm() -> void:
	var bgm_names = ["shop", "battle", "boss", "victory", "defeat"]
	for bname in bgm_names:
		var path = "res://assets/audio/bgm_%s.wav" % bname
		if ResourceLoader.exists(path):
			var stream = load(path)
			bgm_streams[bname] = stream
		else:
			print("BGM stream not found at: ", path)

func play_sfx(sname: String, pitch_scale: float = 1.0, volume_db: float = 0.0) -> void:
	if is_muted:
		return
	if not sound_streams.has(sname):
		return
	var stream = sound_streams[sname]
	var effective_db = linear_to_db(sfx_volume) + volume_db
	
	# Find available player
	for p in player_pool:
		if not p.playing:
			p.stream = stream
			p.pitch_scale = pitch_scale + randf_range(-0.05, 0.05)
			p.volume_db = effective_db
			p.play()
			return
	# If all busy, steal the first one
	var p = player_pool[0]
	p.stream = stream
	p.pitch_scale = pitch_scale
	p.volume_db = effective_db
	p.play()

func play_bgm(track_name: String, fade_duration: float = 0.4) -> void:
	if current_bgm_track == track_name and bgm_player.playing:
		return
	if not bgm_streams.has(track_name):
		return
	
	current_bgm_track = track_name
	bgm_track_changed.emit(track_name)
	
	var target_db = -80.0 if is_muted else linear_to_db(bgm_volume)
	var new_stream = bgm_streams[track_name]
	
	if bgm_tween:
		bgm_tween.kill()
	
	if bgm_player.playing:
		# Smooth crossfade
		bgm_tween = create_tween()
		bgm_tween.tween_property(bgm_player, "volume_db", -80.0, fade_duration * 0.5)
		bgm_tween.tween_callback(func():
			bgm_player.stream = new_stream
			bgm_player.play()
		)
		bgm_tween.tween_property(bgm_player, "volume_db", target_db, fade_duration * 0.5)
	else:
		bgm_player.stream = new_stream
		bgm_player.volume_db = target_db
		bgm_player.play()

func _on_bgm_finished() -> void:
	# Loop continuous tracks
	if current_bgm_track in ["shop", "battle", "boss"]:
		bgm_player.play()
	elif current_bgm_track in ["victory", "defeat"]:
		# Return to shop music after victory / defeat jingle completes
		if GameManager and GameManager.current_phase == GameManager.Phase.PREPARATION:
			play_bgm("shop", 0.5)

func stop_bgm(fade_duration: float = 0.4) -> void:
	current_bgm_track = ""
	if bgm_tween:
		bgm_tween.kill()
	bgm_tween = create_tween()
	bgm_tween.tween_property(bgm_player, "volume_db", -80.0, fade_duration)
	bgm_tween.tween_callback(func():
		bgm_player.stop()
	)

func set_bgm_volume(val: float) -> void:
	bgm_volume = clampf(val, 0.0, 1.0)
	if not is_muted and bgm_player.playing:
		bgm_player.volume_db = linear_to_db(bgm_volume)

func set_sfx_volume(val: float) -> void:
	sfx_volume = clampf(val, 0.0, 1.0)

func toggle_mute() -> bool:
	is_muted = not is_muted
	if is_muted:
		if bgm_player:
			bgm_player.volume_db = -80.0
	else:
		if bgm_player and bgm_player.playing:
			bgm_player.volume_db = linear_to_db(bgm_volume)
	mute_toggled.emit(is_muted)
	return is_muted
