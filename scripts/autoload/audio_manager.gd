extends Node

# AudioManager singleton for playing synthesized and procedural SFX

var sound_streams: Dictionary = {}
var player_pool: Array[AudioStreamPlayer] = []
const POOL_SIZE = 8

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	# Create player pool for polyphonic SFX
	for i in range(POOL_SIZE):
		var p = AudioStreamPlayer.new()
		p.bus = "Master"
		add_child(p)
		player_pool.append(p)
	
	load_sounds()

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

func play_sfx(sname: String, pitch_scale: float = 1.0, volume_db: float = 0.0) -> void:
	if not sound_streams.has(sname):
		return
	var stream = sound_streams[sname]
	# Find available player
	for p in player_pool:
		if not p.playing:
			p.stream = stream
			p.pitch_scale = pitch_scale + randf_range(-0.05, 0.05)
			p.volume_db = volume_db
			p.play()
			return
	# If all busy, steal the first one
	var p = player_pool[0]
	p.stream = stream
	p.pitch_scale = pitch_scale
	p.volume_db = volume_db
	p.play()
