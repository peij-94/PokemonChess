extends Node

# GymRoadManager: Manages the 8 Gym Battle Road challenge stages, badge case, and star evaluation.

signal gym_cleared(gym_index: int, stars: int, hp_left: int)
signal badge_unlocked(gym_index: int, badge_name: String)
signal badges_updated()
signal gym_challenge_started(gym_index: int, gym_data: Dictionary)
signal gym_challenge_ended(gym_index: int, won: bool)

const SAVE_PATH: String = "user://gym_battle_road_save.json"

const GYM_STAGES: Array[Dictionary] = [
	{
		"index": 0,
		"id": "pewter_gym",
		"name": "深灰道馆·小刚",
		"leader": "小刚 (Brock)",
		"title": "岩石坚阵",
		"badge_id": "boulder_badge",
		"badge_name": "灰色徽章",
		"badge_icon": "🪨",
		"badge_color": Color(0.72, 0.70, 0.65),
		"type": "Rock",
		"type_name": "岩石",
		"desc": "深灰道馆馆主小刚拥有如磐石般的钢铁意志！岩石系阵型坚韧厚重，护盾防御固若金汤。",
		"ace_id": "onix",
		"ace_name": "大岩蛇",
		"arena_bg": "res://assets/backgrounds/arena_stadium.jpg",
		"player_start_level": 3,
		"player_start_gold": 26,
		"lineup": [
			{"id": "onix", "star": 2, "coord": Vector2i(3, 1), "is_boss": true},
			{"id": "geodude", "star": 2, "coord": Vector2i(2, 1)},
			{"id": "golem", "star": 1, "coord": Vector2i(4, 1)},
			{"id": "aerodactyl", "star": 1, "coord": Vector2i(5, 0)}
		]
	},
	{
		"index": 1,
		"id": "cerulean_gym",
		"name": "华蓝道馆·小霞",
		"leader": "小霞 (Misty)",
		"title": "水流疾速爆发",
		"badge_id": "cascade_badge",
		"badge_name": "蓝色徽章",
		"badge_icon": "💧",
		"badge_color": Color(0.25, 0.65, 0.95),
		"type": "Water",
		"type_name": "水",
		"desc": "俏皮的美人鱼小霞！水流疾速奔涌，水系狂潮与高额生命回复暗藏致命杀机。",
		"ace_id": "starmie",
		"ace_name": "宝石海星",
		"arena_bg": "res://assets/backgrounds/arena_glacier.jpg",
		"player_start_level": 4,
		"player_start_gold": 34,
		"lineup": [
			{"id": "starmie", "star": 2, "coord": Vector2i(4, 1), "is_boss": true},
			{"id": "gyarados", "star": 2, "coord": Vector2i(2, 1)},
			{"id": "golduck", "star": 2, "coord": Vector2i(5, 1)},
			{"id": "psyduck", "star": 2, "coord": Vector2i(3, 0)},
			{"id": "vaporeon", "star": 1, "coord": Vector2i(1, 0)}
		]
	},
	{
		"index": 2,
		"id": "vermilion_gym",
		"name": "枯叶道馆·马志士",
		"leader": "马志士 (Lt. Surge)",
		"title": "电气突击狂潮",
		"badge_id": "thunder_badge",
		"badge_name": "橙色徽章",
		"badge_icon": "⚡",
		"badge_color": Color(1.0, 0.78, 0.15),
		"type": "Electric",
		"type_name": "电",
		"desc": "闪电美国硬汉马志士！电气突击狂潮弹射麻痹，极速攻速与连环电弧令对手瞬间瓦解。",
		"ace_id": "raichu",
		"ace_name": "雷丘",
		"arena_bg": "res://assets/backgrounds/arena_stadium.jpg",
		"player_start_level": 5,
		"player_start_gold": 42,
		"lineup": [
			{"id": "raichu", "star": 2, "coord": Vector2i(3, 1), "is_boss": true},
			{"id": "magneton", "star": 2, "coord": Vector2i(2, 1)},
			{"id": "jolteon", "star": 2, "coord": Vector2i(4, 1)},
			{"id": "electabuzz", "star": 2, "coord": Vector2i(5, 0)},
			{"id": "electrode", "star": 2, "coord": Vector2i(1, 0)}
		]
	},
	{
		"index": 3,
		"id": "celadon_gym",
		"name": "彩虹道馆·莉佳",
		"leader": "莉佳 (Erika)",
		"title": "草木自然领域",
		"badge_id": "rainbow_badge",
		"badge_name": "彩虹徽章",
		"badge_icon": "🌿",
		"badge_color": Color(0.4, 0.85, 0.45),
		"type": "Grass",
		"type_name": "草",
		"desc": "彩虹道馆大小姐莉佳，崇尚自然花木之道！花香领域拥有超强生命汲取与坚韧自愈。",
		"ace_id": "vileplume",
		"ace_name": "霸王花",
		"arena_bg": "res://assets/backgrounds/arena_emerald.jpg",
		"player_start_level": 5,
		"player_start_gold": 50,
		"lineup": [
			{"id": "vileplume", "star": 2, "coord": Vector2i(3, 1), "is_boss": true},
			{"id": "victreebel", "star": 2, "coord": Vector2i(4, 1)},
			{"id": "tangrowth", "star": 2, "coord": Vector2i(2, 1)},
			{"id": "tangela", "star": 2, "coord": Vector2i(5, 0)},
			{"id": "gloom", "star": 2, "coord": Vector2i(1, 0)}
		]
	},
	{
		"index": 4,
		"id": "fuchsia_gym",
		"name": "浅红道馆·阿桔",
		"leader": "阿桔 (Koga)",
		"title": "剧毒陷阱与刺客突袭",
		"badge_id": "soul_badge",
		"badge_name": "粉红徽章",
		"badge_icon": "☠️",
		"badge_color": Color(0.85, 0.4, 0.8),
		"type": "Poison",
		"type_name": "毒",
		"desc": "浅红忍者道馆！阿桔施展剧毒陷阱与刺客暗袭，剧毒持续侵蚀，配合快攻突袭后排。",
		"ace_id": "weezing",
		"ace_name": "双弹瓦斯",
		"arena_bg": "res://assets/backgrounds/arena_astral.jpg",
		"player_start_level": 6,
		"player_start_gold": 58,
		"lineup": [
			{"id": "weezing", "star": 3, "coord": Vector2i(3, 1), "is_boss": true},
			{"id": "muk", "star": 2, "coord": Vector2i(2, 1)},
			{"id": "venomoth", "star": 2, "coord": Vector2i(5, 1)},
			{"id": "scyther", "star": 2, "coord": Vector2i(4, 0)}
		]
	},
	{
		"index": 5,
		"id": "saffron_gym",
		"name": "金黄道馆·娜姿",
		"leader": "娜姿 (Sabrina)",
		"title": "超能意念控场",
		"badge_id": "marsh_badge",
		"badge_name": "金黄徽章",
		"badge_icon": "🔮",
		"badge_color": Color(0.96, 0.55, 0.75),
		"type": "Psychic",
		"type_name": "超能",
		"desc": "超能力少女娜姿，意念扭曲空间！强力念力爆发、精神强念控场与高额法术增幅无可匹敌。",
		"ace_id": "alakazam",
		"ace_name": "胡地",
		"arena_bg": "res://assets/backgrounds/arena_astral.jpg",
		"player_start_level": 7,
		"player_start_gold": 68,
		"lineup": [
			{"id": "alakazam", "star": 3, "coord": Vector2i(4, 0), "is_boss": true},
			{"id": "mr-mime", "star": 2, "coord": Vector2i(2, 1)},
			{"id": "hypno", "star": 2, "coord": Vector2i(5, 1)},
			{"id": "kadabra", "star": 2, "coord": Vector2i(3, 1)},
			{"id": "espeon", "star": 2, "coord": Vector2i(1, 0)}
		]
	},
	{
		"index": 6,
		"id": "cinnabar_gym",
		"name": "红莲道馆·夏伯",
		"leader": "夏伯 (Blaine)",
		"title": "烈焰狂暴爆发",
		"badge_id": "volcano_badge",
		"badge_name": "深红徽章",
		"badge_icon": "🔥",
		"badge_color": Color(0.95, 0.4, 0.2),
		"type": "Fire",
		"type_name": "火",
		"desc": "热血解谜博士夏伯！火山熔岩地热翻滚，烈焰灼烧与狂暴爆发吞噬全场一切生灵。",
		"ace_id": "arcanine",
		"ace_name": "风速狗",
		"arena_bg": "res://assets/backgrounds/arena_volcano.jpg",
		"player_start_level": 8,
		"player_start_gold": 80,
		"lineup": [
			{"id": "arcanine", "star": 3, "coord": Vector2i(3, 1), "is_boss": true},
			{"id": "magmar", "star": 3, "coord": Vector2i(4, 1)},
			{"id": "rapidash", "star": 2, "coord": Vector2i(2, 1)},
			{"id": "ninetales", "star": 2, "coord": Vector2i(5, 0)}
		]
	},
	{
		"index": 7,
		"id": "sinnoh_league",
		"name": "神奥联盟·竹兰",
		"leader": "竹兰 (Cynthia)",
		"title": "冠军级巅峰试炼",
		"badge_id": "champion_badge",
		"badge_name": "联盟冠军徽章",
		"badge_icon": "👑",
		"badge_color": Color(1.0, 0.84, 0.25),
		"type": "Dragon",
		"type_name": "神奥全能",
		"desc": "神奥联盟神话级冠军竹兰！全能巅峰王者阵容，烈咬陆鲨领衔的至高荣耀试炼！",
		"ace_id": "garchomp",
		"ace_name": "烈咬陆鲨",
		"arena_bg": "res://assets/backgrounds/arena_emerald.jpg",
		"player_start_level": 9,
		"player_start_gold": 95,
		"lineup": [
			{"id": "garchomp", "star": 3, "coord": Vector2i(3, 1), "is_boss": true},
			{"id": "lucario", "star": 3, "coord": Vector2i(4, 1)},
			{"id": "togekiss", "star": 3, "coord": Vector2i(5, 0)},
			{"id": "spiritomb", "star": 3, "coord": Vector2i(2, 0)},
			{"id": "milotic", "star": 3, "coord": Vector2i(1, 1)},
			{"id": "roserade", "star": 2, "coord": Vector2i(6, 1)}
		]
	}
]

# Badge Case Record State
# Key: gym_index (0..7) -> Dictionary
var badge_records: Dictionary = {}

# Active challenge state
var is_active: bool = false
var current_gym_index: int = -1

func _init() -> void:
	_init_default_records()

func _ready() -> void:
	load_progress()

func _init_default_records() -> void:
	badge_records.clear()
	for i in range(GYM_STAGES.size()):
		badge_records[i] = {
			"gym_index": i,
			"unlocked": false,
			"stars": 0,
			"best_stars": 0,
			"cleared_count": 0,
			"best_hp": 0,
			"last_cleared_time": ""
		}

# Calculates star rating:
# ★1: > 0 HP
# ★2: >= 50 HP
# ★3: >= 80 HP
static func calculate_stars(player_remaining_hp: int) -> int:
	if player_remaining_hp >= 80:
		return 3
	elif player_remaining_hp >= 50:
		return 2
	elif player_remaining_hp > 0:
		return 1
	return 0

static func get_star_string(stars: int) -> String:
	match stars:
		3: return "★★★"
		2: return "★★☆"
		1: return "★☆☆"
		_: return "☆☆☆"

func get_gym_count() -> int:
	return GYM_STAGES.size()

func get_gym_data(index: int) -> Dictionary:
	if index >= 0 and index < GYM_STAGES.size():
		return GYM_STAGES[index]
	return {}

func get_all_gyms() -> Array[Dictionary]:
	return GYM_STAGES

func get_badge_record(index: int) -> Dictionary:
	if badge_records.has(index):
		return badge_records[index]
	return {
		"gym_index": index,
		"unlocked": false,
		"stars": 0,
		"best_stars": 0,
		"cleared_count": 0,
		"best_hp": 0,
		"last_cleared_time": ""
	}

func get_total_unlocked_badges() -> int:
	var count = 0
	for i in badge_records.keys():
		if badge_records[i].get("unlocked", false):
			count += 1
	return count

func get_total_stars() -> int:
	var total = 0
	for i in badge_records.keys():
		total += int(badge_records[i].get("best_stars", 0))
	return total

func start_gym_challenge(gym_idx: int) -> bool:
	if gym_idx < 0 or gym_idx >= GYM_STAGES.size():
		return false
	is_active = true
	current_gym_index = gym_idx
	var gym_data = GYM_STAGES[gym_idx]
	gym_challenge_started.emit(gym_idx, gym_data)
	return true

func end_gym_challenge() -> void:
	is_active = false
	current_gym_index = -1

func is_gym_battle_active() -> bool:
	return is_active and current_gym_index >= 0 and current_gym_index < GYM_STAGES.size()

func get_current_gym_data() -> Dictionary:
	if is_gym_battle_active():
		return GYM_STAGES[current_gym_index]
	return {}

func get_current_gym_wave_definition() -> Array:
	if is_gym_battle_active():
		return GYM_STAGES[current_gym_index].get("lineup", [])
	return []

func settle_gym_battle(gym_idx: int, player_won: bool, remaining_hp: int) -> Dictionary:
	if gym_idx < 0 or gym_idx >= GYM_STAGES.size():
		return {"won": false, "stars": 0}
		
	var gym_data = GYM_STAGES[gym_idx]
	var rec = badge_records.get(gym_idx, {
		"gym_index": gym_idx,
		"unlocked": false,
		"stars": 0,
		"best_stars": 0,
		"cleared_count": 0,
		"best_hp": 0,
		"last_cleared_time": ""
	})
	
	var stars = 0
	var newly_unlocked = false
	
	if player_won:
		stars = calculate_stars(remaining_hp)
		if not rec.get("unlocked", false):
			newly_unlocked = true
			rec["unlocked"] = true
			badge_unlocked.emit(gym_idx, gym_data.get("badge_name", ""))
			
		rec["stars"] = stars
		rec["best_stars"] = max(rec.get("best_stars", 0), stars)
		rec["best_hp"] = max(rec.get("best_hp", 0), remaining_hp)
		rec["cleared_count"] = int(rec.get("cleared_count", 0)) + 1
		rec["last_cleared_time"] = Time.get_datetime_string_from_system()
		badge_records[gym_idx] = rec
		
		save_progress()
		gym_cleared.emit(gym_idx, stars, remaining_hp)
		badges_updated.emit()
	
	gym_challenge_ended.emit(gym_idx, player_won)
	
	return {
		"won": player_won,
		"gym_index": gym_idx,
		"gym_name": gym_data.get("name", ""),
		"stars": stars,
		"best_stars": rec.get("best_stars", 0),
		"remaining_hp": remaining_hp,
		"newly_unlocked": newly_unlocked
	}

func unlock_badge_manually(gym_idx: int, stars: int = 3, hp: int = 100) -> void:
	if gym_idx >= 0 and gym_idx < GYM_STAGES.size():
		var rec = badge_records[gym_idx]
		rec["unlocked"] = true
		rec["stars"] = stars
		rec["best_stars"] = max(rec.get("best_stars", 0), stars)
		rec["best_hp"] = max(rec.get("best_hp", 0), hp)
		rec["cleared_count"] = int(rec.get("cleared_count", 0)) + 1
		badge_records[gym_idx] = rec
		save_progress()
		badges_updated.emit()

func reset_progress() -> void:
	_init_default_records()
	save_progress()
	badges_updated.emit()

func save_progress() -> void:
	var save_dict: Dictionary = {}
	for k in badge_records.keys():
		save_dict[str(k)] = badge_records[k]
	var json_str = JSON.stringify(save_dict, "\t")
	var f = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if f:
		f.store_string(json_str)
		f.close()

func load_progress() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		return
	var f = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if not f:
		return
	var content = f.get_as_text()
	f.close()
	if content.strip_edges().is_empty():
		return
		
	var json = JSON.new()
	var err = json.parse(content)
	if err == OK and json.data is Dictionary:
		for k_str in json.data.keys():
			var idx = int(k_str)
			if idx >= 0 and idx < GYM_STAGES.size():
				var data = json.data[k_str]
				if data is Dictionary:
					badge_records[idx] = data
		badges_updated.emit()
