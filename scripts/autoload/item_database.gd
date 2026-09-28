extends Node

## ItemDatabase: Central registry for Pokemon held items, component base stats, and recipes.

# Base components dictionary
var base_items: Dictionary = {
	"razor_claw": {
		"id": "razor_claw",
		"name": "锐利之爪",
		"en_name": "Razor Claw",
		"icon_path": "res://assets/items/razor_claw.png",
		"desc": "极锋利的爪套。提升物理攻击力与暴击率。",
		"stats": {
			"atk": 15.0,
			"crit": 0.15,
			"hp": 0.0,
			"hp_regen": 0.0,
			"armor": 0.0,
			"mr": 0.0,
			"atk_speed": 0.0,
			"start_mana": 0.0,
			"mana_per_hit": 0.0,
			"sp_atk": 0.0
		}
	},
	"scope_lens": {
		"id": "scope_lens",
		"name": "焦点镜",
		"en_name": "Scope Lens",
		"icon_path": "res://assets/items/scope_lens.png",
		"desc": "精密透镜。显著提高暴击率与弱点洞察。",
		"stats": {
			"atk": 0.0,
			"crit": 0.20,
			"hp": 0.0,
			"hp_regen": 0.0,
			"armor": 0.0,
			"mr": 0.0,
			"atk_speed": 0.0,
			"start_mana": 0.0,
			"mana_per_hit": 0.0,
			"sp_atk": 0.0
		}
	},
	"leftovers": {
		"id": "leftovers",
		"name": "吃剩的东西",
		"en_name": "Leftovers",
		"icon_path": "res://assets/items/leftovers.png",
		"desc": "美味的残羹。增加生命上限，每秒持续恢复生命。",
		"stats": {
			"atk": 0.0,
			"crit": 0.0,
			"hp": 150.0,
			"hp_regen": 15.0,
			"armor": 0.0,
			"mr": 0.0,
			"atk_speed": 0.0,
			"start_mana": 0.0,
			"mana_per_hit": 0.0,
			"sp_atk": 0.0
		}
	},
	"eviolite": {
		"id": "eviolite",
		"name": "进化奇石",
		"en_name": "Eviolite",
		"icon_path": "res://assets/items/eviolite.png",
		"desc": "蕴含进化潜能的宝石。大幅提升双抗护甲与特防。",
		"stats": {
			"atk": 0.0,
			"crit": 0.0,
			"hp": 0.0,
			"hp_regen": 0.0,
			"armor": 20.0,
			"mr": 20.0,
			"atk_speed": 0.0,
			"start_mana": 0.0,
			"mana_per_hit": 0.0,
			"sp_atk": 0.0
		}
	},
	"choice_scarf": {
		"id": "choice_scarf",
		"name": "讲究围巾",
		"en_name": "Choice Scarf",
		"icon_path": "res://assets/items/choice_scarf.png",
		"desc": "如风飘动的丝巾。极大提升普通攻击速度。",
		"stats": {
			"atk": 0.0,
			"crit": 0.0,
			"hp": 0.0,
			"hp_regen": 0.0,
			"armor": 0.0,
			"mr": 0.0,
			"atk_speed": 0.20,
			"start_mana": 0.0,
			"mana_per_hit": 0.0,
			"sp_atk": 0.0
		}
	},
	"exp_share": {
		"id": "exp_share",
		"name": "学习装置",
		"en_name": "Exp. Share",
		"icon_path": "res://assets/items/exp_share.png",
		"desc": "能量分配终端。提供开局法力值与每次普攻回蓝加成。",
		"stats": {
			"atk": 0.0,
			"crit": 0.0,
			"hp": 0.0,
			"hp_regen": 0.0,
			"armor": 0.0,
			"mr": 0.0,
			"atk_speed": 0.0,
			"start_mana": 20.0,
			"mana_per_hit": 5.0,
			"sp_atk": 0.0
		}
	},
	"charcoal": {
		"id": "charcoal",
		"name": "木炭",
		"en_name": "Charcoal",
		"icon_path": "res://assets/items/charcoal.png",
		"desc": "蕴藏火种的高能黑炭。提升特攻与技能威力。",
		"stats": {
			"atk": 0.0,
			"crit": 0.0,
			"hp": 0.0,
			"hp_regen": 0.0,
			"armor": 0.0,
			"mr": 0.0,
			"atk_speed": 0.0,
			"start_mana": 0.0,
			"mana_per_hit": 0.0,
			"sp_atk": 25.0
		}
	},
	"focus_sash": {
		"id": "focus_sash",
		"name": "气势披带",
		"en_name": "Focus Sash",
		"icon_path": "res://assets/items/focus_sash.png",
		"desc": "坚韧不拔的头带。增加生命上限与护甲。",
		"stats": {
			"atk": 0.0,
			"crit": 0.0,
			"hp": 100.0,
			"hp_regen": 0.0,
			"armor": 15.0,
			"mr": 0.0,
			"atk_speed": 0.0,
			"start_mana": 0.0,
			"mana_per_hit": 0.0,
			"sp_atk": 0.0
		}
	}
}

# Advanced items dictionary
var advanced_items: Dictionary = {
	"mega_bracelet": {
		"id": "mega_bracelet",
		"name": "超级手环",
		"en_name": "Mega Bracelet",
		"icon_path": "res://assets/items/mega_bracelet.png",
		"desc": "蕴含键石力量的羁绊手环。携带者若是满3星特定宝可梦，战斗中觉醒终极 Mega 进化！全属性+25%。",
		"recipe": ["razor_claw", "eviolite"],
		"stats": {
			"atk": 25.0,
			"crit": 0.15,
			"hp": 200.0,
			"hp_regen": 10.0,
			"armor": 25.0,
			"mr": 25.0,
			"atk_speed": 0.15,
			"start_mana": 20.0,
			"mana_per_hit": 5.0,
			"sp_atk": 25.0
		},
		"special_effect": {
			"type": "mega_awaken",
			"value": 0.25,
			"desc": "满3星特定宝可梦在战斗中激发超级进化，全属性与大招极度升华！"
		}
	},
	"infinity_blade": {
		"id": "infinity_blade",
		"name": "无尽之刃",
		"en_name": "Infinity Blade",
		"icon_path": "res://assets/items/infinity_blade.png",
		"desc": "汇聚毁灭力量的锋刃。暴击伤害提升至220%，技能也可触发暴击。",
		"recipe": ["razor_claw", "scope_lens"],
		"stats": {
			"atk": 35.0,
			"crit": 0.35,
			"hp": 0.0,
			"hp_regen": 0.0,
			"armor": 0.0,
			"mr": 0.0,
			"atk_speed": 0.0,
			"start_mana": 0.0,
			"mana_per_hit": 0.0,
			"sp_atk": 0.0
		},
		"special_effect": {
			"type": "crit_amp",
			"value": 0.45,
			"desc": "暴击伤害提升至220%，技能亦可暴击"
		}
	},
	"expert_belt": {
		"id": "expert_belt",
		"name": "达人带",
		"en_name": "Expert Belt",
		"icon_path": "res://assets/items/expert_belt.png",
		"desc": "武术宗师的黑腰带。对生命值高于60%的强敌造成25%额外真实伤害。",
		"recipe": ["razor_claw", "charcoal"],
		"stats": {
			"atk": 25.0,
			"crit": 0.0,
			"hp": 0.0,
			"hp_regen": 0.0,
			"armor": 0.0,
			"mr": 0.0,
			"atk_speed": 0.0,
			"start_mana": 0.0,
			"mana_per_hit": 0.0,
			"sp_atk": 35.0
		},
		"special_effect": {
			"type": "giant_slayer",
			"value": 0.25,
			"desc": "对当前生命高于60%的敌人造成额外25%伤害"
		}
	},
	"life_orb": {
		"id": "life_orb",
		"name": "生命宝珠",
		"en_name": "Life Orb",
		"icon_path": "res://assets/items/life_orb.png",
		"desc": "鲜血共鸣的禁断之球。技能伤害提升40%，但施法时扣除5%当前生命。",
		"recipe": ["scope_lens", "charcoal"],
		"stats": {
			"atk": 0.0,
			"crit": 0.15,
			"hp": 0.0,
			"hp_regen": 0.0,
			"armor": 0.0,
			"mr": 0.0,
			"atk_speed": 0.0,
			"start_mana": 0.0,
			"mana_per_hit": 0.0,
			"sp_atk": 45.0
		},
		"special_effect": {
			"type": "skill_amp_recoil",
			"value": 0.40,
			"cost_pct": 0.05,
			"desc": "+40%技能伤害，但施法时消耗5%当前生命"
		}
	},
	"assault_vest": {
		"id": "assault_vest",
		"name": "突击背心",
		"en_name": "Assault Vest",
		"icon_path": "res://assets/items/assault_vest.png",
		"desc": "坚韧的防弹重装甲。战斗开始时获得相当于40%最大生命值的护盾。",
		"recipe": ["leftovers", "eviolite"],
		"stats": {
			"atk": 0.0,
			"crit": 0.0,
			"hp": 250.0,
			"hp_regen": 20.0,
			"armor": 35.0,
			"mr": 35.0,
			"atk_speed": 0.0,
			"start_mana": 0.0,
			"mana_per_hit": 0.0,
			"sp_atk": 0.0
		},
		"special_effect": {
			"type": "start_shield",
			"value": 0.40,
			"desc": "战斗开始时获得相当于40%最大生命值的护盾"
		}
	},
	"hard_stone": {
		"id": "hard_stone",
		"name": "硬石头",
		"en_name": "Hard Stone",
		"icon_path": "res://assets/items/hard_stone.png",
		"desc": "远古磐石核心。使携带者受到的所有物理与魔法伤害永久减免20%。",
		"recipe": ["eviolite", "focus_sash"],
		"stats": {
			"atk": 0.0,
			"crit": 0.0,
			"hp": 200.0,
			"hp_regen": 0.0,
			"armor": 45.0,
			"mr": 30.0,
			"atk_speed": 0.0,
			"start_mana": 0.0,
			"mana_per_hit": 0.0,
			"sp_atk": 0.0
		},
		"special_effect": {
			"type": "damage_reduction",
			"value": 0.20,
			"desc": "受到的所有伤害减少20%"
		}
	},
	"choice_specs": {
		"id": "choice_specs",
		"name": "讲究眼镜",
		"en_name": "Choice Specs",
		"icon_path": "res://assets/items/choice_specs.png",
		"desc": "极度专注的特制眼镜。战斗开始时拥有100点满额法力值，开场立即释放技能！",
		"recipe": ["scope_lens", "exp_share"],
		"stats": {
			"atk": 0.0,
			"crit": 0.15,
			"hp": 0.0,
			"hp_regen": 0.0,
			"armor": 0.0,
			"mr": 0.0,
			"atk_speed": 0.0,
			"start_mana": 100.0,
			"mana_per_hit": 10.0,
			"sp_atk": 30.0
		},
		"special_effect": {
			"type": "instant_mana",
			"value": 100.0,
			"desc": "开局拥有100点初始法力值，立即释放技能"
		}
	},
	"battery": {
		"id": "battery",
		"name": "充电池",
		"en_name": "Battery",
		"icon_path": "res://assets/items/battery.png",
		"desc": "超高容量动力电池。提供高额攻速，每次普通攻击额外恢复10点法力值。",
		"recipe": ["choice_scarf", "exp_share"],
		"stats": {
			"atk": 0.0,
			"crit": 0.0,
			"hp": 0.0,
			"hp_regen": 0.0,
			"armor": 0.0,
			"mr": 0.0,
			"atk_speed": 0.30,
			"start_mana": 30.0,
			"mana_per_hit": 12.0,
			"sp_atk": 0.0
		},
		"special_effect": {
			"type": "extra_mana_on_hit",
			"value": 10.0,
			"desc": "每次普通攻击额外恢复10点法力值"
		}
	},
	"tailwind_feather": {
		"id": "tailwind_feather",
		"name": "顺风羽毛",
		"en_name": "Tailwind Feather",
		"icon_path": "res://assets/items/tailwind_feather.png",
		"desc": "呼唤疾风的轻羽。大幅提升攻速与攻击，普攻有25%概率触发瞬间连击。",
		"recipe": ["choice_scarf", "razor_claw"],
		"stats": {
			"atk": 25.0,
			"crit": 0.10,
			"hp": 0.0,
			"hp_regen": 0.0,
			"armor": 0.0,
			"mr": 0.0,
			"atk_speed": 0.40,
			"start_mana": 0.0,
			"mana_per_hit": 0.0,
			"sp_atk": 0.0
		},
		"special_effect": {
			"type": "double_strike",
			"value": 0.25,
			"desc": "普通攻击有25%概率立刻连击一次"
		}
	},
	"weakness_policy": {
		"id": "weakness_policy",
		"name": "弱点保险",
		"en_name": "Weakness Policy",
		"icon_path": "res://assets/items/weakness_policy.png",
		"desc": "逆境反扑的军令徽章。生命值低于50%时，攻击力与特攻激增50%。",
		"recipe": ["razor_claw", "focus_sash"],
		"stats": {
			"atk": 20.0,
			"crit": 0.0,
			"hp": 200.0,
			"hp_regen": 0.0,
			"armor": 25.0,
			"mr": 0.0,
			"atk_speed": 0.0,
			"start_mana": 0.0,
			"mana_per_hit": 0.0,
			"sp_atk": 20.0
		},
		"special_effect": {
			"type": "emergency_burst",
			"threshold": 0.50,
			"buff_val": 0.50,
			"desc": "生命值低于50%时爆发：攻击与特攻提升50%"
		}
	},
	"rocky_helmet": {
		"id": "rocky_helmet",
		"name": "凸凸头盔",
		"en_name": "Rocky Helmet",
		"icon_path": "res://assets/items/rocky_helmet.png",
		"desc": "带刺的岩石硬盔。受到物理攻击时，反弹30%伤害给近战/远程攻击者。",
		"recipe": ["leftovers", "focus_sash"],
		"stats": {
			"atk": 0.0,
			"crit": 0.0,
			"hp": 300.0,
			"hp_regen": 15.0,
			"armor": 40.0,
			"mr": 0.0,
			"atk_speed": 0.0,
			"start_mana": 0.0,
			"mana_per_hit": 0.0,
			"sp_atk": 0.0
		},
		"special_effect": {
			"type": "thorns_reflect",
			"value": 0.30,
			"desc": "受到物理攻击时反弹30%伤害给攻击者"
		}
	},
	"mystic_water": {
		"id": "mystic_water",
		"name": "神秘水滴",
		"en_name": "Mystic Water",
		"icon_path": "res://assets/items/mystic_water.png",
		"desc": "纯净的生命之水。每秒持续恢复3%最大生命值，且强化技能威能。",
		"recipe": ["leftovers", "charcoal"],
		"stats": {
			"atk": 0.0,
			"crit": 0.0,
			"hp": 250.0,
			"hp_regen": 30.0,
			"armor": 0.0,
			"mr": 15.0,
			"atk_speed": 0.0,
			"start_mana": 15.0,
			"mana_per_hit": 0.0,
			"sp_atk": 35.0
		},
		"special_effect": {
			"type": "regen_pct",
			"value": 0.03,
			"desc": "每秒恢复3%最大生命值"
		}
	},
	"magnet": {
		"id": "magnet",
		"name": "磁铁",
		"en_name": "Magnet",
		"icon_path": "res://assets/items/magnet.png",
		"desc": "高能电磁发生器。攻击削弱目标25%护甲与魔抗，持续5秒。",
		"recipe": ["choice_scarf", "eviolite"],
		"stats": {
			"atk": 0.0,
			"crit": 0.0,
			"hp": 0.0,
			"hp_regen": 0.0,
			"armor": 20.0,
			"mr": 30.0,
			"atk_speed": 0.30,
			"start_mana": 0.0,
			"mana_per_hit": 0.0,
			"sp_atk": 20.0
		},
		"special_effect": {
			"type": "resistance_shred",
			"value": 0.25,
			"desc": "攻击削减目标25%护甲与魔抗"
		}
	}
}

# Recipe matrix mapping [item_a, item_b] -> advanced item id
# We normalize keys so order does not matter: ["a", "b"] -> "a+b" (sorted)
var recipes: Dictionary = {}

func _ready() -> void:
	_init_recipes()

func _make_key(a: String, b: String) -> String:
	return "%s+%s" % [a, b] if a < b else "%s+%s" % [b, a]

func _init_recipes() -> void:
	recipes.clear()
	# Register primary recipes from advanced items
	for adv_id in advanced_items:
		var recipe = advanced_items[adv_id].get("recipe", [])
		if recipe.size() == 2:
			recipes[_make_key(recipe[0], recipe[1])] = adv_id
	
	# Complete pairing table so all 36 combinations of the 8 base items have a recipe!
	# The 8 base components:
	# razor_claw, scope_lens, leftovers, eviolite, choice_scarf, exp_share, charcoal, focus_sash
	var pairings: Array = [
		# razor_claw pairings
		["razor_claw", "razor_claw", "infinity_blade"],
		["razor_claw", "scope_lens", "infinity_blade"],
		["razor_claw", "leftovers", "weakness_policy"],
		["razor_claw", "eviolite", "assault_vest"],
		["razor_claw", "choice_scarf", "tailwind_feather"],
		["razor_claw", "exp_share", "battery"],
		["razor_claw", "charcoal", "expert_belt"],
		["razor_claw", "focus_sash", "weakness_policy"],

		# scope_lens pairings
		["scope_lens", "scope_lens", "infinity_blade"],
		["scope_lens", "leftovers", "mystic_water"],
		["scope_lens", "eviolite", "assault_vest"],
		["scope_lens", "choice_scarf", "tailwind_feather"],
		["scope_lens", "exp_share", "choice_specs"],
		["scope_lens", "charcoal", "life_orb"],
		["scope_lens", "focus_sash", "weakness_policy"],

		# leftovers pairings
		["leftovers", "leftovers", "rocky_helmet"],
		["leftovers", "eviolite", "assault_vest"],
		["leftovers", "choice_scarf", "battery"],
		["leftovers", "exp_share", "mystic_water"],
		["leftovers", "charcoal", "mystic_water"],
		["leftovers", "focus_sash", "rocky_helmet"],

		# eviolite pairings
		["eviolite", "eviolite", "assault_vest"],
		["eviolite", "choice_scarf", "magnet"],
		["eviolite", "exp_share", "choice_specs"],
		["eviolite", "charcoal", "expert_belt"],
		["eviolite", "focus_sash", "hard_stone"],

		# choice_scarf pairings
		["choice_scarf", "choice_scarf", "tailwind_feather"],
		["choice_scarf", "exp_share", "battery"],
		["choice_scarf", "charcoal", "magnet"],
		["choice_scarf", "focus_sash", "tailwind_feather"],

		# exp_share pairings
		["exp_share", "exp_share", "choice_specs"],
		["exp_share", "charcoal", "choice_specs"],
		["exp_share", "focus_sash", "battery"],

		# charcoal pairings
		["charcoal", "charcoal", "life_orb"],
		["charcoal", "focus_sash", "expert_belt"],

		# focus_sash pairings
		["focus_sash", "focus_sash", "hard_stone"]
	]

	for entry in pairings:
		recipes[_make_key(entry[0], entry[1])] = entry[2]

# ==============================================================================
# HELPER API METHODS
# ==============================================================================

## Returns the result of combining item_a and item_b, or "" if invalid
func get_recipe(item_a: String, item_b: String) -> String:
	if recipes.is_empty():
		_init_recipes()
	var key = _make_key(item_a, item_b)
	return recipes.get(key, "")

## Returns full item dictionary given an item ID (checks both base and advanced)
func get_item(id: String) -> Dictionary:
	if base_items.has(id):
		return base_items[id].duplicate(true)
	if advanced_items.has(id):
		return advanced_items[id].duplicate(true)
	return {}

## Checks if an item is a basic component
func is_base_item(id: String) -> bool:
	return base_items.has(id)

## Checks if an item is an advanced completed item
func is_advanced_item(id: String) -> bool:
	return advanced_items.has(id)

## Returns list of all base item definitions
func get_all_base_items() -> Array[Dictionary]:
	var list: Array[Dictionary] = []
	for id in base_items:
		list.append(base_items[id].duplicate(true))
	return list

## Returns list of all advanced item definitions
func get_all_advanced_items() -> Array[Dictionary]:
	var list: Array[Dictionary] = []
	for id in advanced_items:
		list.append(advanced_items[id].duplicate(true))
	return list

## Returns list of all base item IDs
func get_all_base_item_ids() -> Array[String]:
	var ids: Array[String] = []
	for k in base_items.keys():
		ids.append(str(k))
	return ids

## Returns list of all advanced item IDs
func get_all_advanced_item_ids() -> Array[String]:
	var ids: Array[String] = []
	for k in advanced_items.keys():
		ids.append(str(k))
	return ids

## Returns all recipes craftable using a given base item: Array of { "with_item": id, "result": id }
func get_craftable_recipes(base_id: String) -> Array[Dictionary]:
	var results: Array[Dictionary] = []
	if not is_base_item(base_id):
		return results
	for other_id in base_items:
		var res = get_recipe(base_id, other_id)
		if res != "":
			results.append({
				"component_a": base_id,
				"component_b": other_id,
				"result": res
			})
	return results
