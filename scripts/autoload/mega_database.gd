extends Node

## MegaDatabase: Central registry for Mega Evolution forms, mega abilities, and Dynamax mechanics.

signal mega_evolved(unit: Node, mega_form_id: String)
signal dynamax_activated(unit: Node)
signal dynamax_deactivated()
signal dynamax_energy_changed(current: int, max_val: int)

const MEGA_FORMS: Dictionary = {
	"charizard": {
		"mega_id": "mega_charizard_x",
		"name": "超级喷火龙 X",
		"types": ["Fire", "Dragon"],
		"stat_multipliers": {"hp": 1.25, "atk": 1.45, "armor": 1.30, "mr": 1.25, "atk_speed": 1.20},
		"ability": {
			"id": "tough_claws",
			"name": "硬爪",
			"desc": "接触类普攻与技能威力提升 40%。"
		},
		"mega_skill": {
			"name": "超级爆炸烈焰",
			"power": 750,
			"target_count": 3,
			"stun_duration": 1.0,
			"type": "special",
			"desc": "汇聚青蓝苍炎引发大范围爆碎冲击波，对3体目标造成毁灭性巨额伤害并灼烧。"
		}
	},
	"blastoise": {
		"mega_id": "mega_blastoise",
		"name": "超级水箭龟",
		"types": ["Water"],
		"stat_multipliers": {"hp": 1.30, "atk": 1.35, "armor": 1.45, "mr": 1.40, "atk_speed": 1.15},
		"ability": {
			"id": "mega_launcher",
			"name": "超级发射器",
			"desc": "背部主炮蓄力射击，技能伤害额外提升 50%。"
		},
		"mega_skill": {
			"name": "超级加农水炮",
			"power": 680,
			"target_count": 4,
			"stun_duration": 1.2,
			"type": "special",
			"desc": "三连重装水炮狂暴轰击前方大片区域，击退敌方并附加深度潮湿与眩晕。"
		}
	},
	"venusaur": {
		"mega_id": "mega_venusaur",
		"name": "超级妙蛙花",
		"types": ["Grass", "Poison"],
		"stat_multipliers": {"hp": 1.45, "atk": 1.30, "armor": 1.50, "mr": 1.50, "atk_speed": 1.10},
		"ability": {
			"id": "thick_fat_mega",
			"name": "厚脂肪",
			"desc": "受到的火系与冰系伤害减免 50%（消除原本属性弱点）。"
		},
		"mega_skill": {
			"name": "超级疯狂植物",
			"power": 550,
			"target_count": 5,
			"stun_duration": 1.5,
			"type": "special",
			"desc": "召唤古老荆棘巨木横扫全场，造成大范围草系魔法伤害并吸取 35% 伤害转化为全队护盾。"
		}
	},
	"gengar": {
		"mega_id": "mega_gengar",
		"name": "超级耿鬼",
		"types": ["Ghost", "Poison"],
		"stat_multipliers": {"hp": 1.20, "atk": 1.55, "armor": 1.20, "mr": 1.30, "atk_speed": 1.30},
		"ability": {
			"id": "shadow_tag",
			"name": "踩影",
			"desc": "潜入地面影子，令所有敌方攻速降低 25% 且无法换位。"
		},
		"mega_skill": {
			"name": "超级暗影死神弹",
			"power": 720,
			"target_count": 2,
			"stun_duration": 1.5,
			"type": "special",
			"desc": "打开异次元暗黑裂缝轰出死神巨弹，对当前目标及其身旁敌人造成致命斩杀级幽灵伤害。"
		}
	},
	"mewtwo": {
		"mega_id": "mega_mewtwo_y",
		"name": "超级超梦 Y",
		"types": ["Psychic"],
		"stat_multipliers": {"hp": 1.35, "atk": 1.65, "armor": 1.25, "mr": 1.45, "atk_speed": 1.35},
		"ability": {
			"id": "insomnia_burst",
			"name": "精神主宰",
			"desc": "超绝精神念力全开，施法法力消耗降低 20，并无视敌方 35% 魔抗。"
		},
		"mega_skill": {
			"name": "超级精神击破",
			"power": 900,
			"target_count": 6,
			"stun_duration": 1.8,
			"type": "special",
			"desc": "实体化凝聚无上念力神波轰击全屏，对全场所有敌军造成真实特攻神圣伤害。"
		}
	},
	"gyarados": {
		"mega_id": "mega_gyarados",
		"name": "超级暴鲤龙",
		"types": ["Water", "Dark"],
		"stat_multipliers": {"hp": 1.35, "atk": 1.50, "armor": 1.40, "mr": 1.40, "atk_speed": 1.25},
		"ability": {
			"id": "mold_breaker",
			"name": "破格",
			"desc": "不可阻挡之怒：攻击完全无视目标拥有的减伤护甲与护盾特性！"
		},
		"mega_skill": {
			"name": "超级深渊海啸",
			"power": 650,
			"target_count": 3,
			"stun_duration": 1.2,
			"type": "physical",
			"desc": "狂暴卷起深海黑涡击碎敌军防线，造成物理与恶系混合裂解伤害。"
		}
	},
	"alakazam": {
		"mega_id": "mega_alakazam",
		"name": "超级胡地",
		"types": ["Psychic"],
		"stat_multipliers": {"hp": 1.15, "atk": 1.60, "armor": 1.20, "mr": 1.40, "atk_speed": 1.40},
		"ability": {
			"id": "trace_mega",
			"name": "心电复制",
			"desc": "开局复制全场攻击力最高敌人的 30% 属性强化自身。"
		},
		"mega_skill": {
			"name": "超级五匙念力风暴",
			"power": 700,
			"target_count": 4,
			"stun_duration": 1.0,
			"type": "special",
			"desc": "悬浮五柄银匙形成光之矩阵，连环释放多段念力光束贯穿敌阵。"
		}
	}
}

# Dynamax Max Moves Configuration
const DYNAMAX_MOVES: Dictionary = {
	"Fire": {"name": "极巨火球 ☄️", "power": 600, "effect": "大晴天 ☀️"},
	"Water": {"name": "极巨水流 🌊", "power": 600, "effect": "下雨 🌧️"},
	"Electric": {"name": "极巨闪电 ⚡", "power": 600, "effect": "电气场地 ⚡"},
	"Grass": {"name": "极巨草原 🌿", "power": 600, "effect": "青草场地 🌿"},
	"Ice": {"name": "极巨寒冰 ❄️", "power": 600, "effect": "降雪 ❄️"},
	"Rock": {"name": "极巨岩崩 🪨", "power": 600, "effect": "沙暴 🌪️"},
	"Ground": {"name": "极巨大地 🏜️", "power": 600, "effect": "沙暴 🌪️"},
	"Psychic": {"name": "极巨超能 🔮", "power": 600, "effect": "精神场地 🔮"},
	"Dragon": {"name": "极巨龙骑 🐉", "power": 650, "effect": "敌方全员攻击力 -15%"},
	"Ghost": {"name": "极巨幽魂 👻", "power": 600, "effect": "敌方全员护甲 -25%"},
	"Fighting": {"name": "极巨拳霸 🥊", "power": 600, "effect": "我方全员攻击力 +20%"},
	"Normal": {"name": "极巨攻击 💥", "power": 550, "effect": "敌方全员移速攻速 -20%"}
}

var current_dynamax_unit_ref: WeakRef = null
var is_dynamax_available: bool = true

var current_dynamax_target: Node:
	get:
		if current_dynamax_unit_ref:
			var u = current_dynamax_unit_ref.get_ref()
			if u != null and is_instance_valid(u):
				return u
		return null
	set(val):
		set_dynamax_target(val)

# Dynamax Energy System: 100 Energy required to activate for a single round
const MAX_DYNAMAX_ENERGY: int = 100
var dynamax_energy: int = 0
var is_dynamax_active_this_round: bool = false

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func is_mega_eligible(pokemon_id: String) -> bool:
	return MEGA_FORMS.has(pokemon_id.to_lower())

func get_mega_form(pokemon_id: String) -> Dictionary:
	return MEGA_FORMS.get(pokemon_id.to_lower(), {})

func add_dynamax_energy(amount: int) -> void:
	var old = dynamax_energy
	dynamax_energy = clamp(dynamax_energy + amount, 0, MAX_DYNAMAX_ENERGY)
	if dynamax_energy != old:
		dynamax_energy_changed.emit(dynamax_energy, MAX_DYNAMAX_ENERGY)

func get_energy_percentage() -> int:
	return int((float(dynamax_energy) / float(MAX_DYNAMAX_ENERGY)) * 100.0)

func is_energy_full() -> bool:
	return dynamax_energy >= MAX_DYNAMAX_ENERGY

func consume_energy() -> void:
	dynamax_energy = 0
	is_dynamax_active_this_round = false
	dynamax_energy_changed.emit(dynamax_energy, MAX_DYNAMAX_ENERGY)

func refund_energy() -> void:
	dynamax_energy = MAX_DYNAMAX_ENERGY
	is_dynamax_active_this_round = false
	dynamax_energy_changed.emit(dynamax_energy, MAX_DYNAMAX_ENERGY)

func reset_energy() -> void:
	dynamax_energy = 0
	is_dynamax_active_this_round = false
	dynamax_energy_changed.emit(dynamax_energy, MAX_DYNAMAX_ENERGY)

func set_dynamax_target(unit: Node) -> void:
	if unit == null or not is_instance_valid(unit):
		clear_dynamax()
		return
		
	# If switching from a different unit, deactivate the previous one cleanly
	var prev = get_dynamax_target()
	if prev != null and prev != unit and is_instance_valid(prev) and prev.has_method("deactivate_dynamax"):
		prev.deactivate_dynamax()
		
	current_dynamax_unit_ref = weakref(unit)
	is_dynamax_active_this_round = true
	dynamax_activated.emit(unit)

func get_dynamax_target() -> Node:
	if current_dynamax_unit_ref:
		var u = current_dynamax_unit_ref.get_ref()
		if u != null and is_instance_valid(u):
			return u
	return null

func clear_dynamax() -> void:
	var old_u = get_dynamax_target()
	if old_u != null and is_instance_valid(old_u) and old_u.has_method("deactivate_dynamax"):
		old_u.deactivate_dynamax()
	current_dynamax_unit_ref = null
	is_dynamax_active_this_round = false
	dynamax_deactivated.emit()

func get_dynamax_move(type_name: String) -> Dictionary:
	return DYNAMAX_MOVES.get(type_name, DYNAMAX_MOVES["Normal"])
