extends Node

# TypeSystem: Complete 18-type effectiveness chart and calculation engine for Pokémon Auto-Chess
# Multipliers:
# - Super Effective: 1.35x
# - Not Very Effective: 0.75x
# - Ineffective / Immune: 0.50x
# - Neutral: 1.00x

const MULT_SUPER: float = 1.35
const MULT_NOT_VERY: float = 0.75
const MULT_IMMUNE: float = 0.50
const MULT_NEUTRAL: float = 1.00

# Complete list of 18 types
const ALL_TYPES: Array[String] = [
	"Normal", "Fire", "Water", "Grass", "Electric", "Ice",
	"Fighting", "Poison", "Ground", "Flying", "Psychic", "Bug",
	"Rock", "Ghost", "Dragon", "Steel", "Fairy", "Dark"
]

# Chinese localized names for types
const TYPE_NAMES_ZH: Dictionary = {
	"Normal": "一般",
	"Fire": "火",
	"Water": "水",
	"Grass": "草",
	"Electric": "电",
	"Ice": "冰",
	"Fighting": "格斗",
	"Poison": "毒",
	"Ground": "地面",
	"Flying": "飞行",
	"Psychic": "超能",
	"Bug": "虫",
	"Rock": "岩石",
	"Ghost": "幽灵",
	"Dragon": "龙",
	"Steel": "钢",
	"Fairy": "妖精",
	"Dark": "恶"
}

# Thematic UI colors for types
const TYPE_COLORS: Dictionary = {
	"Normal": Color(0.68, 0.68, 0.62),
	"Fire": Color(0.98, 0.42, 0.18),
	"Water": Color(0.24, 0.58, 0.94),
	"Grass": Color(0.36, 0.82, 0.38),
	"Electric": Color(0.98, 0.82, 0.20),
	"Ice": Color(0.42, 0.84, 0.84),
	"Fighting": Color(0.82, 0.26, 0.20),
	"Poison": Color(0.68, 0.28, 0.68),
	"Ground": Color(0.86, 0.74, 0.42),
	"Flying": Color(0.62, 0.58, 0.94),
	"Psychic": Color(0.98, 0.34, 0.58),
	"Bug": Color(0.64, 0.74, 0.20),
	"Rock": Color(0.72, 0.64, 0.32),
	"Ghost": Color(0.46, 0.36, 0.62),
	"Dragon": Color(0.44, 0.32, 0.94),
	"Steel": Color(0.70, 0.70, 0.80),
	"Fairy": Color(0.94, 0.58, 0.72),
	"Dark": Color(0.42, 0.34, 0.28)
}

# Full 18-type effectiveness data
# Format: Attacking Type -> { super: [...], weak: [...], immune: [...] }
const CHART_DATA: Dictionary = {
	"Normal": {
		"super": [],
		"weak": ["Rock", "Steel"],
		"immune": ["Ghost"]
	},
	"Fire": {
		"super": ["Grass", "Ice", "Bug", "Steel"],
		"weak": ["Fire", "Water", "Rock", "Dragon"],
		"immune": []
	},
	"Water": {
		"super": ["Fire", "Ground", "Rock"],
		"weak": ["Water", "Grass", "Dragon"],
		"immune": []
	},
	"Grass": {
		"super": ["Water", "Ground", "Rock"],
		"weak": ["Fire", "Grass", "Poison", "Flying", "Bug", "Dragon", "Steel"],
		"immune": []
	},
	"Electric": {
		"super": ["Water", "Flying"],
		"weak": ["Electric", "Grass", "Dragon"],
		"immune": ["Ground"]
	},
	"Ice": {
		"super": ["Grass", "Ground", "Flying", "Dragon"],
		"weak": ["Fire", "Water", "Ice", "Steel"],
		"immune": []
	},
	"Fighting": {
		"super": ["Normal", "Ice", "Rock", "Dark", "Steel"],
		"weak": ["Poison", "Flying", "Psychic", "Bug", "Fairy"],
		"immune": ["Ghost"]
	},
	"Poison": {
		"super": ["Grass", "Fairy"],
		"weak": ["Poison", "Ground", "Rock", "Ghost"],
		"immune": ["Steel"]
	},
	"Ground": {
		"super": ["Fire", "Electric", "Poison", "Rock", "Steel"],
		"weak": ["Grass", "Bug"],
		"immune": ["Flying"]
	},
	"Flying": {
		"super": ["Grass", "Fighting", "Bug"],
		"weak": ["Electric", "Rock", "Steel"],
		"immune": []
	},
	"Psychic": {
		"super": ["Fighting", "Poison"],
		"weak": ["Psychic", "Steel"],
		"immune": ["Dark"]
	},
	"Bug": {
		"super": ["Grass", "Psychic", "Dark"],
		"weak": ["Fire", "Fighting", "Poison", "Flying", "Ghost", "Steel", "Fairy"],
		"immune": []
	},
	"Rock": {
		"super": ["Fire", "Ice", "Flying", "Bug"],
		"weak": ["Fighting", "Ground", "Steel"],
		"immune": []
	},
	"Ghost": {
		"super": ["Psychic", "Ghost"],
		"weak": ["Dark"],
		"immune": ["Normal"]
	},
	"Dragon": {
		"super": ["Dragon"],
		"weak": ["Steel"],
		"immune": ["Fairy"]
	},
	"Steel": {
		"super": ["Ice", "Rock", "Fairy"],
		"weak": ["Fire", "Water", "Electric", "Steel"],
		"immune": []
	},
	"Fairy": {
		"super": ["Fighting", "Dragon", "Dark"],
		"weak": ["Fire", "Poison", "Steel"],
		"immune": []
	},
	"Dark": {
		"super": ["Psychic", "Ghost"],
		"weak": ["Fighting", "Dark", "Fairy"],
		"immune": []
	}
}

# Pre-compiled lookup matrix: matrix[attacker][defender] -> float
var _matrix: Dictionary = {}

func _ready() -> void:
	_build_matrix()

func _build_matrix() -> void:
	_matrix.clear()
	for atk in ALL_TYPES:
		_matrix[atk] = {}
		var data = CHART_DATA.get(atk, {})
		var super_types: Array = data.get("super", [])
		var weak_types: Array = data.get("weak", [])
		var immune_types: Array = data.get("immune", [])
		
		for def in ALL_TYPES:
			if immune_types.has(def):
				_matrix[atk][def] = MULT_IMMUNE
			elif super_types.has(def):
				_matrix[atk][def] = MULT_SUPER
			elif weak_types.has(def):
				_matrix[atk][def] = MULT_NOT_VERY
			else:
				_matrix[atk][def] = MULT_NEUTRAL

## Helper to normalize type strings (e.g. "fire" -> "Fire")
func normalize_type(t: String) -> String:
	var trimmed = t.strip_edges()
	if trimmed.is_empty():
		return ""
	return trimmed.capitalize()

## Calculates single attacking type vs single defending type multiplier
func get_single_type_multiplier(attacker_type: String, defender_type: String) -> float:
	var atk = normalize_type(attacker_type)
	var def = normalize_type(defender_type)
	
	if _matrix.is_empty():
		_build_matrix()
		
	if _matrix.has(atk) and _matrix[atk].has(def):
		return _matrix[atk][def]
	return MULT_NEUTRAL

## Calculates effectiveness multiplier of attacker types against defender types.
## Accepts Array of types or single String.
## For multiple attacker types, the attacker attacks with its optimal offensive typing (highest multiplier).
## For multiple defender types, the damage factors against each defender type compound multiplicatively.
func get_type_multiplier(attacker_types: Variant, defender_types: Variant) -> float:
	var atks: Array = []
	if attacker_types is Array:
		atks = attacker_types
	elif attacker_types is String and attacker_types != "":
		atks = [attacker_types]
		
	var defs: Array = []
	if defender_types is Array:
		defs = defender_types
	elif defender_types is String and defender_types != "":
		defs = [defender_types]
		
	if atks.is_empty() or defs.is_empty():
		return MULT_NEUTRAL
		
	var best_mult: float = -1.0
	for atk in atks:
		var current_mult: float = 1.0
		for def in defs:
			current_mult *= get_single_type_multiplier(str(atk), str(def))
		if best_mult < 0.0 or current_mult > best_mult:
			best_mult = current_mult
			
	return best_mult if best_mult >= 0.0 else MULT_NEUTRAL

## Returns UI label info corresponding to the damage multiplier:
## - super effective (>= 1.2): { "tag": "super", "text": "效果绝佳！", "color": Color(...) }
## - weak / ineffective (<= 0.85): { "tag": "weak", "text": "效果不理想", "color": Color(...) }
## - normal (between 0.85 and 1.2): { "tag": "normal", "text": "", "color": Color(...) }
func get_effectiveness_label(multiplier: float) -> Dictionary:
	if multiplier >= 1.2:
		return {
			"tag": "super",
			"text": "效果绝佳！",
			"color": Color(1.0, 0.40, 0.15)
		}
	elif multiplier <= 0.85:
		return {
			"tag": "weak",
			"text": "效果不理想",
			"color": Color(0.65, 0.65, 0.75)
		}
	else:
		return {
			"tag": "normal",
			"text": "",
			"color": Color(1.0, 1.0, 1.0)
		}

## Helper to get localized Chinese name for a type
func get_type_name_zh(type_name: String) -> String:
	var t = normalize_type(type_name)
	return TYPE_NAMES_ZH.get(t, type_name)

## Helper to get display color for a type
func get_type_color(type_name: String) -> Color:
	var t = normalize_type(type_name)
	return TYPE_COLORS.get(t, Color.WHITE)
