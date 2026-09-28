extends Node

# AbilityDatabase: Central repository for Pokémon passive abilities and species mappings

var abilities: Dictionary = {
	"static": {
		"id": "static",
		"name": "静电",
		"desc": "受近战攻击时25%几率使攻击者麻痹眩晕1.0秒。",
		"trigger": "on_hit_melee",
		"chance": 0.25,
		"stun_duration": 1.0
	},
	"blaze": {
		"id": "blaze",
		"name": "猛火",
		"desc": "生命低于40%时，火系技能威力+45%，攻速+25%。",
		"trigger": "low_hp",
		"hp_threshold": 0.40,
		"skill_power_boost": 0.45,
		"atk_speed_boost": 0.25
	},
	"torrent": {
		"id": "torrent",
		"name": "激流",
		"desc": "生命低于40%时，受到的伤害减免30%并每秒恢复3%生命。",
		"trigger": "low_hp",
		"hp_threshold": 0.40,
		"damage_reduction": 0.30,
		"regen_pct_per_sec": 0.03
	},
	"overgrow": {
		"id": "overgrow",
		"name": "茂盛",
		"desc": "生命低于40%时，技能伤害提升40%并将造成伤害的30%转化为治疗。",
		"trigger": "low_hp",
		"hp_threshold": 0.40,
		"skill_damage_boost": 0.40,
		"lifesteal_ratio": 0.30
	},
	"cursed_body": {
		"id": "cursed_body",
		"name": "诅咒之躯",
		"desc": "受到攻击时20%几率使攻击者无法普通攻击2秒。",
		"trigger": "on_hit_received",
		"chance": 0.20,
		"disarm_duration": 2.0
	},
	"thick_fat": {
		"id": "thick_fat",
		"name": "厚脂肪",
		"desc": "受到火属性和冰属性伤害降低40%。",
		"trigger": "on_damage_received",
		"damage_reduction": 0.40,
		"affected_types": ["Fire", "Ice"]
	},
	"pressure": {
		"id": "pressure",
		"name": "压迫感",
		"desc": "战斗开始令所有敌方单位初始法力值降低20点。",
		"trigger": "battle_start",
		"mana_reduction": 20.0
	},
	"multiscale": {
		"id": "multiscale",
		"name": "多重鳞片",
		"desc": "生命值为满值时，受到的首次伤害降低60%。",
		"trigger": "first_hit_full_hp",
		"damage_reduction": 0.60
	},
	"guts": {
		"id": "guts",
		"name": "毅力",
		"desc": "处于异常状态（灼烧/冰冻/眩晕）时攻击力提升50%。",
		"trigger": "passive_status_buff",
		"atk_boost": 0.50,
		"statuses": ["burn", "freeze", "stun"]
	},
	"magic_guard": {
		"id": "magic_guard",
		"name": "魔法防守",
		"desc": "完全免疫灼烧、中毒和场地伤害等持续扣血效果。",
		"trigger": "passive_immunity",
		"immune_dot": true
	},
	"intimidate": {
		"id": "intimidate",
		"name": "威吓",
		"desc": "登场时降低全体敌方单位15%攻击力。",
		"trigger": "on_battle_start",
		"enemy_atk_reduction": 0.15
	},
	"levitate": {
		"id": "levitate",
		"name": "飘浮",
		"desc": "完全免疫地面属性伤害与地面控制。",
		"trigger": "passive_immunity",
		"immune_ground": true
	},
	"adaptability": {
		"id": "adaptability",
		"name": "适应力",
		"desc": "自身技能和普攻伤害额外提升35%。",
		"trigger": "passive_damage_boost",
		"damage_boost": 0.35
	},
	"water_absorb": {
		"id": "water_absorb",
		"name": "蓄水",
		"desc": "受到水属性伤害时完全免疫并恢复20%最大生命值。",
		"trigger": "on_damage_received",
		"immune_type": "Water",
		"heal_pct": 0.20
	},
	"volt_absorb": {
		"id": "volt_absorb",
		"name": "蓄电",
		"desc": "受到电属性伤害时完全免疫并获得25点法力值。",
		"trigger": "on_damage_received",
		"immune_type": "Electric",
		"mana_gain": 25.0
	},
	"flash_fire": {
		"id": "flash_fire",
		"name": "引火",
		"desc": "受到火属性伤害时完全免疫，并使自身攻击力提升30%。",
		"trigger": "on_damage_received",
		"immune_type": "Fire",
		"atk_boost": 0.30
	},
	"sturdy": {
		"id": "sturdy",
		"name": "结实",
		"desc": "受到致命伤害时保留1点生命值并获得2秒无敌（每场战斗限1次）。",
		"trigger": "on_fatal_damage",
		"invulnerable_duration": 2.0
	},
	"technician": {
		"id": "technician",
		"name": "技术高手",
		"desc": "普通攻击与基础技能伤害提升40%。",
		"trigger": "passive_power_boost",
		"damage_boost": 0.40
	},
	"chlorophyll": {
		"id": "chlorophyll",
		"name": "叶绿素",
		"desc": "普攻攻速提升30%，每次普攻额外获得3点法力。",
		"trigger": "passive_speed_boost",
		"atk_speed_boost": 0.30,
		"extra_mana_on_hit": 3.0
	},
	"natural_cure": {
		"id": "natural_cure",
		"name": "自然回复",
		"desc": "每3秒清除自身所有异常状态并恢复5%最大生命值。",
		"trigger": "periodic",
		"interval": 3.0,
		"heal_pct": 0.05
	}
}

# Mapping: pokemon_id -> ability_id
var pokemon_abilities: Dictionary = {
	# Starter Grass line
	"bulbasaur": "overgrow",
	"ivysaur": "overgrow",
	"venusaur": "overgrow",

	# Starter Fire line
	"charmander": "blaze",
	"charmeleon": "blaze",
	"charizard": "blaze",

	# Starter Water line
	"squirtle": "torrent",
	"wartortle": "torrent",
	"blastoise": "torrent",

	# Pikachu line
	"pikachu": "static",
	"raichu": "static",

	# Ghost line
	"gastly": "cursed_body",
	"haunter": "cursed_body",
	"gengar": "cursed_body",

	# Snorlax
	"snorlax": "thick_fat",

	# Legendary Psionics
	"mewtwo": "pressure",
	"mew": "pressure",

	# Dragon line
	"dratini": "multiscale",
	"dragonair": "multiscale",
	"dragonite": "multiscale",

	# Fighting line
	"machop": "guts",
	"machoke": "guts",
	"machamp": "guts",

	# Psychic line
	"abra": "magic_guard",
	"kadabra": "magic_guard",
	"alakazam": "magic_guard",

	# Intimidate users
	"growlithe": "intimidate",
	"arcanine": "intimidate",
	"gyarados": "intimidate",

	# Levitate users
	"koffing": "levitate",
	"weezing": "levitate",

	# Eeveelutions
	"eevee": "adaptability",
	"vaporeon": "water_absorb",
	"jolteon": "volt_absorb",
	"flareon": "flash_fire",

	# Sturdy rock/ground
	"geodude": "sturdy",
	"graveler": "sturdy",
	"golem": "sturdy",
	"onix": "sturdy",

	# Others
	"lapras": "water_absorb",
	"scyther": "technician",
	"chansey": "natural_cure",
	"vulpix": "flash_fire",
	"ninetales": "flash_fire",
	"bellsprout": "chlorophyll",
	"weepinbell": "chlorophyll",
	"victreebel": "chlorophyll",
	"oddish": "chlorophyll",
	"gloom": "chlorophyll",
	"vileplume": "chlorophyll",
	"rattata": "guts",
	"raticate": "guts",
	"articuno": "pressure",
	"zapdos": "pressure",
	"moltres": "pressure"
}

## Returns the ability data dictionary for the given pokemon_id.
## Returns an empty Dictionary if the pokemon has no registered ability.
func get_ability_for_pokemon(pokemon_id: String) -> Dictionary:
	var key = pokemon_id.to_lower()
	if pokemon_abilities.has(key):
		var ability_id = pokemon_abilities[key]
		return get_ability(ability_id)
	return {}

## Returns the ability definition dictionary for a specific ability_id.
## Returns an empty Dictionary if the ability_id does not exist.
func get_ability(ability_id: String) -> Dictionary:
	var key = ability_id.to_lower()
	if abilities.has(key):
		return abilities[key]
	return {}

## Returns the ability ID for a given pokemon_id, or empty string.
func get_ability_id_for_pokemon(pokemon_id: String) -> String:
	return pokemon_abilities.get(pokemon_id.to_lower(), "")

## Checks if a pokemon has a specific ability.
func has_ability(pokemon_id: String, ability_id: String) -> bool:
	return pokemon_abilities.get(pokemon_id.to_lower(), "") == ability_id.to_lower()

## Returns all abilities dictionary.
func get_all_abilities() -> Dictionary:
	return abilities

## Returns all pokemon to ability mappings dictionary.
func get_all_pokemon_abilities() -> Dictionary:
	return pokemon_abilities
