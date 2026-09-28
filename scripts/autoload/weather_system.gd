extends Node

## WeatherSystem: Autoload managing active battle weathers and terrain fields
## Supported Weathers:
##   - "none": Clear weather
##   - "sun": 大晴天 (Harsh Sunlight) - Fire +35%, Water -30%, Grass AtkSpeed +30%, Fire freeze immunity
##   - "rain": 下雨 (Heavy Rain) - Water +35%, Fire -30%, Electric Crit +25% & accuracy, Water heals 15 HP/s
##   - "sandstorm": 沙暴 (Sandstorm) - Rock/Ground/Steel Defenses +40%, other types take 15 dot/s
##   - "snow": 降雪/冰雹 (Snow/Hail) - Ice Armor +50%, Ice skills have +20% freeze chance
##
## Supported Terrains:
##   - "none": Standard ground
##   - "electric": 电气场地 (Electric Terrain) - Electric +30%, sleep/stun immunity
##   - "grassy": 青草场地 (Grassy Terrain) - Ground/Grass heal 25 HP/s, Grass skills +30%
##   - "misty": 薄雾场地 (Misty Terrain) - Dragon skills -40%, negative status duration -50%
##   - "psychic": 精神场地 (Psychic Terrain) - Psychic skills +35%, melee burst dampening

signal weather_changed(new_weather: String, duration: float)
signal terrain_changed(new_terrain: String, duration: float)
signal weather_tick(weather: String, terrain: String)

var current_weather: String = "none"
var weather_timer: float = 0.0

var current_terrain: String = "none"
var terrain_timer: float = 0.0

var tick_accumulator: float = 0.0
const TICK_INTERVAL: float = 1.0

const WEATHER_NAMES: Dictionary = {
	"none": "常态",
	"sun": "大晴天 ☀️",
	"rain": "狂风暴雨 🌧️",
	"sandstorm": "狂暴沙暴 🌪️",
	"snow": "暴风雪 ❄️"
}

const WEATHER_DESCRIPTIONS: Dictionary = {
	"none": "风平浪静，各属性发挥正常水平。",
	"sun": "烈日当空！火系威力 +35%，水系威力 -30%，草系攻速 +30%，火系免疫冰冻。",
	"rain": "倾盆大雨！水系威力 +35%，火系威力 -30%，电系暴击率 +25%，水系每秒回血 15 点。",
	"sandstorm": "黄沙漫天！岩石/地面/钢系双抗 +40%，其他系每秒受到 15 点真实风沙伤害。",
	"snow": "寒风凛冽！冰系护甲 +50%，冰系技能命中附带 20% 几率绝对冰冻 1.5 秒。"
}

const TERRAIN_NAMES: Dictionary = {
	"none": "常规场地",
	"electric": "电气场地 ⚡",
	"grassy": "青草场地 🌿",
	"misty": "薄雾场地 🌫️",
	"psychic": "精神场地 🔮"
}

const TERRAIN_DESCRIPTIONS: Dictionary = {
	"none": "无特殊环境领域加持。",
	"electric": "地面流窜高压电流！电系伤害 +30%，全员免疫睡眠与麻痹眩晕控制。",
	"grassy": "生机盎然的青草地毯！地面单位每秒恢复 25 点生命，草系技能威力 +30%。",
	"misty": "神圣薄雾笼罩全场！龙系技能伤害降低 40%，全员所受负面状态减免 50%。",
	"psychic": "强大的念力空间！超能系技能伤害 +35%，近战先制爆发伤害受到压制。"
}

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func set_weather(w: String, duration: float = 20.0) -> void:
	var old = current_weather
	current_weather = w.to_lower().strip_edges()
	if not WEATHER_NAMES.has(current_weather):
		current_weather = "none"
	weather_timer = duration if current_weather != "none" else 0.0
	
	if old != current_weather or weather_timer > 0.0:
		weather_changed.emit(current_weather, weather_timer)

func set_terrain(t: String, duration: float = 20.0) -> void:
	var old = current_terrain
	current_terrain = t.to_lower().strip_edges()
	if not TERRAIN_NAMES.has(current_terrain):
		current_terrain = "none"
	terrain_timer = duration if current_terrain != "none" else 0.0
	
	if old != current_terrain or terrain_timer > 0.0:
		terrain_changed.emit(current_terrain, terrain_timer)

func reset_environment() -> void:
	set_weather("none", 0.0)
	set_terrain("none", 0.0)

func _process(delta: float) -> void:
	if GameManager.current_phase != GameManager.Phase.COMBAT:
		return
		
	# Weather timer decay
	if weather_timer > 0.0:
		weather_timer -= delta
		if weather_timer <= 0.0:
			set_weather("none", 0.0)
			
	# Terrain timer decay
	if terrain_timer > 0.0:
		terrain_timer -= delta
		if terrain_timer <= 0.0:
			set_terrain("none", 0.0)
			
	# Periodic ticks (healing & environmental DoT)
	tick_accumulator += delta
	if tick_accumulator >= TICK_INTERVAL:
		tick_accumulator -= TICK_INTERVAL
		_on_environment_tick()

func _on_environment_tick() -> void:
	weather_tick.emit(current_weather, current_terrain)
	
	var units = get_tree().get_nodes_in_group("units")
	for node in units:
		var u = node as Unit
		if u == null or not is_instance_valid(u) or u.is_dead or u.is_on_bench:
			continue
			
		var data = PokemonDatabase.get_pokemon(u.pokemon_id) if PokemonDatabase else {}
		var types: Array = data.get("types", [])
		
		# Weather Effects Tick
		match current_weather:
			"rain":
				# Water types heal 15 HP/sec (Rain Dish)
				if "Water" in types:
					u.heal(15.0)
			"sandstorm":
				# Rock, Ground, Steel are immune; others take 15 dot damage
				var is_immune = ("Rock" in types) or ("Ground" in types) or ("Steel" in types)
				# Magic Guard ability also grants immunity
				if AbilityDatabase and AbilityDatabase.has_ability(u.pokemon_id, "magic_guard"):
					is_immune = true
				if not is_immune:
					u.take_damage(15.0, false, false, true, null)
					
		# Terrain Effects Tick
		match current_terrain:
			"grassy":
				# Grounded/Grass units heal 25 HP/sec
				var is_flying = ("Flying" in types) or (AbilityDatabase and AbilityDatabase.has_ability(u.pokemon_id, "levitate"))
				if not is_flying:
					u.heal(25.0)

## Modifies outgoing skill/attack damage based on active weather and terrain
func calculate_weather_terrain_multiplier(attacker_types: Array, move_type: String) -> float:
	var mult = 1.0
	
	# Weather Multipliers
	match current_weather:
		"sun":
			if move_type == "Fire" or "Fire" in attacker_types:
				mult *= 1.35
			elif move_type == "Water":
				mult *= 0.70
		"rain":
			if move_type == "Water" or "Water" in attacker_types:
				mult *= 1.35
			elif move_type == "Fire":
				mult *= 0.70
		"snow":
			if move_type == "Ice" or "Ice" in attacker_types:
				mult *= 1.25
				
	# Terrain Multipliers
	match current_terrain:
		"electric":
			if move_type == "Electric" or "Electric" in attacker_types:
				mult *= 1.30
		"grassy":
			if move_type == "Grass" or "Grass" in attacker_types:
				mult *= 1.30
		"misty":
			if move_type == "Dragon":
				mult *= 0.60
		"psychic":
			if move_type == "Psychic" or "Psychic" in attacker_types:
				mult *= 1.35
				
	return mult

## Modifies defender's resistance / armor based on active weather
func calculate_defense_bonus(defender_types: Array) -> Dictionary:
	var bonus = {"armor_mult": 1.0, "mr_mult": 1.0}
	match current_weather:
		"sandstorm":
			if ("Rock" in defender_types) or ("Ground" in defender_types) or ("Steel" in defender_types):
				bonus["armor_mult"] = 1.40
				bonus["mr_mult"] = 1.40
		"snow":
			if "Ice" in defender_types:
				bonus["armor_mult"] = 1.50
	return bonus

func get_weather_name(w: String = "") -> String:
	var key = w if w != "" else current_weather
	return WEATHER_NAMES.get(key, "未知天气")

func get_terrain_name(t: String = "") -> String:
	var key = t if t != "" else current_terrain
	return TERRAIN_NAMES.get(key, "未知场地")

func get_weather_desc(w: String = "") -> String:
	var key = w if w != "" else current_weather
	return WEATHER_DESCRIPTIONS.get(key, "")

func get_terrain_desc(t: String = "") -> String:
	var key = t if t != "" else current_terrain
	return TERRAIN_DESCRIPTIONS.get(key, "")
