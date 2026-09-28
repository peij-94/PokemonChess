extends Node

# AugmentDatabase: Central registry for Trainer Augments (Runes)
# Classified into Silver, Gold, and Prismatic tiers across Economy, Synergy, and Combat categories.

signal augment_activated(augment_data: Dictionary)
signal augments_cleared()

# Tier constants
const TIER_SILVER = "silver"
const TIER_GOLD = "gold"
const TIER_PRISMATIC = "prismatic"

const TIER_NAMES: Dictionary = {
	TIER_SILVER: "白银符文",
	TIER_GOLD: "黄金符文",
	TIER_PRISMATIC: "棱彩符文"
}

const TIER_COLORS: Dictionary = {
	TIER_SILVER: Color(0.78, 0.85, 0.94, 1.0),    # Polished Silver / Steel Blue
	TIER_GOLD: Color(1.0, 0.84, 0.22, 1.0),      # Radiant Champion Gold
	TIER_PRISMATIC: Color(0.88, 0.48, 1.0, 1.0)  # Prismatic Arcane Magenta / Iridescent
}

const TIER_BG_COLORS: Dictionary = {
	TIER_SILVER: Color(0.10, 0.13, 0.18, 0.96),
	TIER_GOLD: Color(0.16, 0.13, 0.08, 0.96),
	TIER_PRISMATIC: Color(0.15, 0.09, 0.20, 0.96)
}

const CATEGORY_NAMES: Dictionary = {
	"economy": "经济收益",
	"synergy": "属性羁绊",
	"combat": "战斗强化"
}

const CATEGORY_ICONS: Dictionary = {
	"economy": "💰",
	"synergy": "🔮",
	"combat": "⚔️"
}

# The Master Augment Catalog (18 Augments)
const AUGMENT_CATALOG: Array[Dictionary] = [
	# ----------------- ECONOMY -----------------
	{
		"id": "interest_tycoon",
		"name": "利息大亨",
		"tier": TIER_GOLD,
		"category": "economy",
		"icon": "💰",
		"desc": "利息上限由 5G 提高至 8G。",
		"detail": "大幅度拓展你的理财空间。当金币积累至 80G 时，每回合可获得高达 8G 的丰厚利息收入，助你建立压倒性经济优势。",
		"max_interest": 8
	},
	{
		"id": "free_reroll",
		"name": "每日特惠",
		"tier": TIER_SILVER,
		"category": "economy",
		"icon": "🏷️",
		"desc": "每回合开始时获得 1 次免费刷新商店。",
		"detail": "每天都有新惊喜！每个整备回合开始时，第一次刷新商店不消耗任何金币（价值 2G/回合），加速阵容核心升星成型。",
		"free_rerolls_per_round": 1
	},
	{
		"id": "jackpot",
		"name": "头奖彩票",
		"tier": TIER_PRISMATIC,
		"category": "economy",
		"icon": "🎰",
		"desc": "立即获得 18 金币，且每回合额外获得 +1 金币。",
		"detail": "天降横财！立即注入 18G 现金启动资金，并在此后每回合固定获得 +1G 的额外被动收入，瞬间盘活全盘运营节奏。",
		"instant_gold": 18,
		"round_gold": 1
	},
	{
		"id": "hyper_roll",
		"name": "急速理财",
		"tier": TIER_SILVER,
		"category": "economy",
		"icon": "⚡",
		"desc": "升到新等级时立即返还 4 金币。",
		"detail": "高周转冲级战术！每当你的训练家等级提升时，联盟立即为你发放 4G 升级补贴金，实现等级与经济的良性循环。",
		"level_up_refund": 4
	},
	{
		"id": "golden_egg",
		"name": "神秘金蛋",
		"tier": TIER_PRISMATIC,
		"category": "economy",
		"icon": "🥚",
		"desc": "获得一枚金蛋，在存活 5 回合后孵化出 40 金币与强力补给。",
		"detail": "耐心孕育的至尊宝藏。金蛋在整备期静静孵化，经历 5 场对局后破壳而出，为你带来难以估量的战略财富与扭转乾坤之力。",
		"hatch_rounds": 5,
		"reward_gold": 40
	},
	{
		"id": "rich_get_richer",
		"name": "利滚利",
		"tier": TIER_GOLD,
		"category": "economy",
		"icon": "📈",
		"desc": "战斗获胜额外获得 +2 金币，失败时获得 +1 金币抚恤金。",
		"detail": "稳健的资本运作之道。不论对战胜负皆有金币兜底，保持源源不断的经济流水，连胜与连败收益同步放大。",
		"win_gold": 2,
		"lose_gold": 1
	},

	# ----------------- SYNERGY & TEAM -----------------
	{
		"id": "nature_alliance",
		"name": "自然同盟",
		"tier": TIER_GOLD,
		"category": "synergy",
		"icon": "🌿",
		"desc": "队伍始终额外计入 1 个草系羁绊。",
		"detail": "大自然在守护你的队伍。在计算羁绊计数时，草属性羁绊人数永远 +1（无需上阵草系宝可梦也能直接激活）。",
		"synergy_type": "Grass",
		"synergy_bonus": 1
	},
	{
		"id": "blazing_soul",
		"name": "炽热之魂",
		"tier": TIER_GOLD,
		"category": "synergy",
		"icon": "🔥",
		"desc": "火系角色阵亡时对全体敌方造成 150 点火焰真实伤害。",
		"detail": "烈火不熄，壮烈殉爆！当任何火属性友军倒下时，引爆体内积蓄的全部熔岩热量，对场上所有存活敌人造成 150 点无视双抗的真实伤害。",
		"death_damage": 150.0
	},
	{
		"id": "thunder_overload",
		"name": "雷霆过载",
		"tier": TIER_GOLD,
		"category": "synergy",
		"icon": "⚡",
		"desc": "电系角色造成暴击时，在目标身上召唤一道连锁闪电。",
		"detail": "高压电荷连锁传导！电系角色打出暴击伤害时，迸发一道连锁闪电弹射至最多 3 名敌方目标，造成 120 点魔法伤害。",
		"chain_damage": 120.0,
		"chain_targets": 3
	},
	{
		"id": "dragon_heritage",
		"name": "龙之血脉",
		"tier": TIER_PRISMATIC,
		"category": "synergy",
		"icon": "🐉",
		"desc": "龙系角色获得 25% 全能吸血与 15% 攻击力。",
		"detail": "远古巨龙的崇高血统复苏。所有龙属性友军造成的任何伤害（包括普攻与终极技能）均可恢复 25% 生命值，并获得 15% 基础攻击力加成。",
		"omnivamp": 0.25,
		"atk_bonus": 0.15
	},
	{
		"id": "aqua_surge",
		"name": "潮汐涌动",
		"tier": TIER_SILVER,
		"category": "synergy",
		"icon": "🌊",
		"desc": "水系角色生命回复翻倍，且战斗开始时获得 150 点护盾。",
		"detail": "汹涌洋流滋养身躯。水系宝可梦自带的生命泉涌回复效果翻倍，并在战斗打响时自带一层能抵御 150 点伤害的波导水盾。",
		"shield_val": 150.0,
		"regen_mult": 2.0
	},
	{
		"id": "elemental_mastery",
		"name": "元素大师",
		"tier": TIER_PRISMATIC,
		"category": "synergy",
		"icon": "🔮",
		"desc": "队伍中所有已激活属性羁绊的数值效果额外提升 25%。",
		"detail": "贯通十八种属性的宗师奥义。无论是火系的烈焰增幅、水系生命泉涌、草系持续恢复还是超能爆发，均获得全方位的额外放大。",
		"synergy_amp": 0.25
	},

	# ----------------- COMBAT & BATTLE -----------------
	{
		"id": "destiny_bond",
		"name": "同命之绊",
		"tier": TIER_SILVER,
		"category": "combat",
		"icon": "🔗",
		"desc": "友方角色阵亡时，将其 35% 攻击力传递给最近的存活友军。",
		"detail": "战友的遗志由你继承！阵亡伙伴的炽烈斗志转移给身旁最亲密的友军，永久提升其相当于阵亡者 35% 的物理攻击力（可累积传递）。",
		"inherit_ratio": 0.35
	},
	{
		"id": "gigantamax_potion",
		"name": "极巨化药剂",
		"tier": TIER_GOLD,
		"category": "combat",
		"icon": "🧪",
		"desc": "最前排角色生命值 +450，体型增大 20%。",
		"detail": "注入强力极巨化能量！战斗开始时，处于友方防线最前排的棋子获得 450 点额外生命值上限，并体型放大 20%，成为坚不可摧的移动要塞。",
		"hp_bonus": 450.0,
		"scale_bonus": 1.20
	},
	{
		"id": "quick_draw",
		"name": "先发制人",
		"tier": TIER_SILVER,
		"category": "combat",
		"icon": "🎯",
		"desc": "战斗开始时全队立即获得 30 点初始法力值。",
		"detail": "快速装填，出其不意！战斗号角吹响瞬间，所有友方棋子立即充能 30 点初始法力值，大幅提前首轮大招施放时机，形成压制态势。",
		"start_mana": 30.0
	},
	{
		"id": "battle_frenzy",
		"name": "愈战愈勇",
		"tier": TIER_SILVER,
		"category": "combat",
		"icon": "⚔️",
		"desc": "全队每次击杀敌人，永久提升该战斗中 5% 攻速（可叠加）。",
		"detail": "杀意汹涌，势不可挡！战场上每击溃一名敌人，全体存活友军攻击速度提升 5%，在整场战斗中持续叠加且无上限限制。",
		"atk_speed_per_kill": 0.05
	},
	{
		"id": "mystic_barrier",
		"name": "神秘守护",
		"tier": TIER_GOLD,
		"category": "combat",
		"icon": "🛡️",
		"desc": "战斗开始时全队免疫控制效果，持续 6 秒。",
		"detail": "古老纯净的光环笼罩战场。开局 6 秒内友方全员不受任何冰冻、麻痹、击晕或击飞的负面效果影响，肆意倾泻火力。",
		"cc_immunity_sec": 6.0
	},
	{
		"id": "prismatic_radiance",
		"name": "极光庇护",
		"tier": TIER_PRISMATIC,
		"category": "combat",
		"icon": "✨",
		"desc": "全体友军受到的伤害降低 18%，且首位倒下的友军将以 50% 生命复活。",
		"detail": "极光降临，神圣庇佑！全队获得恒定 18% 伤害减免；并且战斗中第一只倒下的宝可梦会沐浴圣光立即以 50% 生命值重生！",
		"damage_reduction": 0.18,
		"revive_hp_pct": 0.50
	}
]

# Currently selected/active augments in current run
var active_augments: Array[Dictionary] = []

# Map of augment ID to Dictionary for fast lookup
var _catalog_by_id: Dictionary = {}

func _init() -> void:
	_build_catalog_cache()

func _ready() -> void:
	_build_catalog_cache()

func _build_catalog_cache() -> void:
	_catalog_by_id.clear()
	for aug in AUGMENT_CATALOG:
		var aug_id = aug.get("id", "")
		if aug_id != "":
			_catalog_by_id[aug_id] = aug

# Returns a copy of the augment dictionary by ID, or empty dict if not found
func get_augment(id: String) -> Dictionary:
	if _catalog_by_id.has(id):
		return _catalog_by_id[id].duplicate(true)
	# Fallback scan in case cache wasn't initialized
	for aug in AUGMENT_CATALOG:
		if aug.get("id", "") == id:
			return aug.duplicate(true)
	return {}

# Returns all augments in the catalog
func get_all_augments() -> Array[Dictionary]:
	var result: Array[Dictionary] = []
	for aug in AUGMENT_CATALOG:
		result.append(aug.duplicate(true))
	return result

# Returns all augments matching a specific tier (case-insensitive)
func get_augments_by_tier(tier: String) -> Array[Dictionary]:
	var t_lower = tier.to_lower().strip_edges()
	var result: Array[Dictionary] = []
	for aug in AUGMENT_CATALOG:
		if aug.get("tier", "").to_lower() == t_lower:
			result.append(aug.duplicate(true))
	return result

# Helper method: Picks random distinct augments.
# - count: number of augments to pick (typically 3)
# - tier: optional filter by tier ("silver", "gold", "prismatic"). If empty, selects across all tiers.
func get_random_augments(count: int, tier: String = "") -> Array[Dictionary]:
	var pool: Array[Dictionary] = []
	if tier != "":
		pool = get_augments_by_tier(tier)
	else:
		pool = get_all_augments()

	# Don't offer already owned augments if possible
	var candidate_pool: Array[Dictionary] = []
	for item in pool:
		if not has_augment(item.get("id", "")):
			candidate_pool.append(item)

	# If candidate pool is too small, fallback to full pool
	if candidate_pool.size() < count:
		candidate_pool = pool.duplicate()

	candidate_pool.shuffle()
	var take_count = clampi(count, 0, candidate_pool.size())
	var selected: Array[Dictionary] = []
	for i in range(take_count):
		selected.append(candidate_pool[i].duplicate(true))
	return selected

# Adds an augment to active list by ID or dict
func add_augment(augment_id_or_data) -> bool:
	var data: Dictionary = {}
	if augment_id_or_data is String:
		data = get_augment(augment_id_or_data)
	elif augment_id_or_data is Dictionary:
		data = augment_id_or_data
	
	if data.is_empty():
		push_warning("AugmentDatabase: Cannot add empty augment")
		return false

	var aug_id = data.get("id", "")
	if has_augment(aug_id):
		return false # Already active
		
	active_augments.append(data)
	augment_activated.emit(data)
	_apply_instant_augment_effects(data)
	return true

# Checks if player currently has this augment active
func has_augment(id: String) -> bool:
	for item in active_augments:
		if item.get("id", "") == id:
			return true
	return false

# Removes an augment
func remove_augment(id: String) -> bool:
	for i in range(active_augments.size() - 1, -1, -1):
		if active_augments[i].get("id", "") == id:
			active_augments.remove_at(i)
			return true
	return false

# Clears all active augments (e.g. for new game or testing)
func clear_augments() -> void:
	active_augments.clear()
	augments_cleared.emit()

func clear_active_augments() -> void:
	clear_augments()

# Returns active augments array
func get_active_augments() -> Array[Dictionary]:
	return active_augments.duplicate(true)

# Color accessor for styling
func get_tier_color(tier: String) -> Color:
	var t = tier.to_lower().strip_edges()
	return TIER_COLORS.get(t, Color.WHITE)

# Background color accessor for card panels
func get_tier_bg_color(tier: String) -> Color:
	var t = tier.to_lower().strip_edges()
	return TIER_BG_COLORS.get(t, Color(0.08, 0.10, 0.14, 0.95))

# Localized tier name
func get_tier_name(tier: String) -> String:
	var t = tier.to_lower().strip_edges()
	return TIER_NAMES.get(t, "强化符文")

# Localized category name
func get_category_name(category: String) -> String:
	var c = category.to_lower().strip_edges()
	return CATEGORY_NAMES.get(c, "通用强化")

# Localized category icon
func get_category_icon(category: String) -> String:
	var c = category.to_lower().strip_edges()
	return CATEGORY_ICONS.get(c, "✨")

# Instant trigger effects upon picking
func _apply_instant_augment_effects(data: Dictionary) -> void:
	var aug_id = data.get("id", "")
	match aug_id:
		"jackpot":
			if GameManager:
				GameManager.gold += int(data.get("instant_gold", 18))
				GameManager.gold_changed.emit(GameManager.gold, int(data.get("instant_gold", 18)))
