# Gen 1 Pokemon: 091 - 120
POKEMON_CHUNK_4 = {
	"cloyster": {
		"num": 91, "id": "cloyster", "name": "刺甲贝", "title": "双壳贝宝可梦", "cost": 4,
		"types": ["Water", "Ice"], "hp": 1100, "atk": 90, "armor": 75, "mr": 45, "range": 2, "atk_speed": 0.70, "max_mana": 85,
		"desc": "贝壳极其坚硬，即使是用炸药也无法在上面留下一点裂痕。遇到强敌时会连续发射坚硬锐利的黑色尖刺进行反击！",
		"skill_name": "破壳·万刺冰枪", "skill_desc": "破壳爆发暴风骤雨般的冰刺，造成560点伤害并削弱护甲50%。",
		"skill_detail": "消耗85能量，贝壳猛烈开启释放体内冰核神力，连续射出暴风骤雨般的极寒冰刺，造成560点物理伤害并粉碎50%护甲持续3秒。",
		"skill_power": 560,
		"skills": {
			1: {"name": "冰锥连射", "desc": "连续发射冰锥造成320点物理伤害。", "detail": "消耗85能量，连续射出尖锐冰锥造成320点伤害。", "power": 320, "vfx": "ice_beam", "sfx": "skill", "scale": 0.40},
			2: {"name": "破壳·万刺冰枪", "desc": "破壳爆发造成560点伤害并削弱50%护甲。", "detail": "消耗85能量，发射冰枪造成560点伤害并粉碎50%防御。", "power": 560, "vfx": "stone_edge", "sfx": "skill", "scale": 0.52},
			3: {"name": "黑曜神甲·绝对零度天劫刺", "desc": "刺甲狂舞撕裂虚空，造成1250点毁灭真实伤害并全图冻结2秒！", "detail": "消耗85能量，激活太古黑曜冰晶，漫天玄冰尖刺横贯全场，造成1250点真实伤害并冻结全图2秒！", "power": 1250, "vfx": "blizzard", "sfx": "skill", "scale": 0.70}
		},
		"visual": {"primary": (120, 85, 160), "secondary": (25, 25, 35), "accent": (230, 235, 245), "eye": (230, 230, 235), "archetype": "shell", "features": ["horns", "shell"]}
	},
	"gastly": {
		"num": 92, "id": "gastly", "name": "鬼斯", "title": "幽灵宝可梦", "cost": 1,
		"types": ["Ghost", "Poison"], "hp": 480, "atk": 45, "armor": 18, "mr": 30, "range": 2, "atk_speed": 0.72, "max_mana": 70,
		"desc": "身体的95%都是由气体组成的幽灵，只要被其充满毒气的瓦斯身体包裹住，不管多强壮的生物都会顷刻窒息倒下。",
		"skill_name": "舌舔·奇异之光", "skill_desc": "伸出幽灵大舌头舔舐目标，造成160点伤害并麻痹敌人。",
		"skill_detail": "消耗70能量，穿梭虚空伸出紫色长舌舔舐目标灵魂，造成160点幽灵法术伤害并使其陷入麻痹与恐惧，持续1.5秒。",
		"skill_power": 160,
		"skills": {
			1: {"name": "舌舔", "desc": "长舌舔舐造成160点伤害并麻痹1.5秒。", "detail": "消耗70能量，伸舌造成160点伤害并麻痹1.5秒。", "power": 160, "vfx": "shadow_ball", "sfx": "skill", "scale": 0.32},
			2: {"name": "暗影夜袭", "desc": "黑雾潜行袭击造成300点伤害并恐惧1秒。", "detail": "消耗70能量，黑夜潜行造成300点伤害并恐惧1秒。", "power": 300, "vfx": "shadow_punch", "sfx": "skill", "scale": 0.42},
			3: {"name": "百鬼夜行·幽冥噬魂风暴", "desc": "引爆冥界幽鬼之风，造成600点穿透伤害并全员禁锢1.5秒。", "detail": "消耗70能量，释放幽冥鬼气席卷半场，造成600点穿透真实伤害并禁锢敌军1.5秒。", "power": 600, "vfx": "hyper_beam", "sfx": "skill", "scale": 0.54}
		},
		"visual": {"primary": (130, 70, 160), "secondary": (30, 20, 40), "accent": (240, 240, 245), "eye": (240, 240, 245), "archetype": "orb", "features": ["floating"]}
	},
	"haunter": {
		"num": 93, "id": "haunter", "name": "鬼斯通", "title": "气体宝可梦", "cost": 2,
		"types": ["Ghost", "Poison"], "hp": 660, "atk": 62, "armor": 25, "mr": 35, "range": 2, "atk_speed": 0.75, "max_mana": 75,
		"desc": "身体可以随意穿透墙壁，喜欢潜伏在黑暗阴影中悄悄靠近猎物，用悬浮的两只手掌拍击目标肩膀惊吓对手。",
		"skill_name": "暗影拳·黑夜魔影", "skill_desc": "悬浮鬼手破空轰击，造成270点幽灵伤害并偷取能量。",
		"skill_detail": "消耗75能量，两只脱离身躯的悬浮鬼爪瞬间拍碎虚空轰击目标，造成270点幽灵法术伤害并偷取目标25点当前能量。",
		"skill_power": 270,
		"skills": {
			1: {"name": "阴影爪", "desc": "鬼爪撕裂造成190点伤害并偷取15能量。", "detail": "消耗75能量，鬼爪撕裂造成190点伤害并偷取15点能量。", "power": 190, "vfx": "shadow_punch", "sfx": "skill", "scale": 0.38},
			2: {"name": "暗影拳·黑夜魔影", "desc": "鬼手破空造成270点伤害并偷取25能量。", "detail": "消耗75能量，鬼拳出击造成270点伤害并偷取25点能量。", "power": 270, "vfx": "shadow_ball", "sfx": "skill", "scale": 0.48},
			3: {"name": "幽冥鬼狱·万魂锁魄大葬", "desc": "撕开黄泉之门，对敌阵造成680点范围伤害并沉默2秒！", "detail": "消耗75能量，召唤冥界幽魂撕扯全场敌阵，造成680点法术伤害并施加沉默2秒！", "power": 680, "vfx": "hyper_beam", "sfx": "skill", "scale": 0.60}
		},
		"visual": {"primary": (120, 60, 150), "secondary": (25, 15, 35), "accent": (245, 245, 250), "eye": (245, 245, 250), "archetype": "biped", "features": ["floating", "hands"]}
	},
	"gengar": {
		"num": 94, "id": "gengar", "name": "耿鬼", "title": "影子宝可梦", "cost": 4,
		"types": ["Ghost", "Poison"], "hp": 1050, "atk": 90, "armor": 45, "mr": 50, "range": 2, "atk_speed": 0.80, "max_mana": 80,
		"desc": "在满月的夜晚，如果影子自己在傻笑并移动，那就是耿鬼潜伏在其中。嘴角常常挂着令人不寒而栗的坏笑！",
		"skill_name": "暗影球·恶梦噬魂", "skill_desc": "凝聚黑紫色幽影球轰击，造成520点法术伤害并陷入恐惧恶梦。",
		"skill_detail": "消耗80能量，在双掌间凝聚极度浓缩的深渊暗影球轰向目标区域，造成520点范围法术伤害并让所有被命中者陷入恐惧恶梦2秒。",
		"skill_power": 520,
		"skills": {
			1: {"name": "暗影球", "desc": "凝聚暗影球造成300点法术伤害。", "detail": "消耗80能量，掷出暗影球造成300点幽灵伤害。", "power": 300, "vfx": "shadow_ball", "sfx": "skill", "scale": 0.42},
			2: {"name": "暗影球·恶梦噬魂", "desc": "暗影球爆发造成520点伤害并恐惧2秒。", "detail": "消耗80能量，轰出深渊暗影球造成520点范围伤害并恐惧2秒。", "power": 520, "vfx": "shadow_punch", "sfx": "skill", "scale": 0.54},
			3: {"name": "九幽炼狱·百鬼夜行无间杀", "desc": "唤醒太古冥皇真身吞噬全场，造成1250点真实伤害并永久诅咒！", "detail": "消耗80能量，张开通往九幽地狱的血盆巨口吞噬天地，对全图所有敌人造成1250点真实幽灵伤害并施加永久噬魂诅咒！", "power": 1250, "vfx": "hyper_beam", "sfx": "skill", "scale": 0.70}
		},
		"visual": {"primary": (110, 55, 140), "secondary": (230, 40, 60), "accent": (240, 240, 245), "eye": (230, 40, 60), "archetype": "biped", "features": ["ears"]}
	},
	"onix": {
		"num": 95, "id": "onix", "name": "大岩蛇", "title": "岩蛇宝可梦", "cost": 2,
		"types": ["Rock", "Ground"], "hp": 900, "atk": 58, "armor": 65, "mr": 25, "range": 1, "atk_speed": 0.60, "max_mana": 85,
		"desc": "在地下以时速80公里的速度高速挖掘前进，巨大的身躯由许多巨型坚岩串联而成，挖掘隧道时会发出轰隆巨响！",
		"skill_name": "落石·地龙缠绕", "skill_desc": "巨岩蛇躯卷住目标造成260点伤害并禁锢2秒。",
		"skill_detail": "消耗85能量，庞大的岩石蛇身盘旋缠绕死死绞紧目标，造成260点物理伤害并使目标禁锢2秒无法移动或普攻。",
		"skill_power": 260,
		"skills": {
			1: {"name": "岩石摔打", "desc": "巨尾抽打造成180点物理伤害。", "detail": "消耗85能量，蛇躯重击造成180点伤害并击退1格。", "power": 180, "vfx": "rock_slide", "sfx": "skill", "scale": 0.38},
			2: {"name": "落石·地龙缠绕", "desc": "蛇躯绞杀造成260点伤害并禁锢2秒。", "detail": "消耗85能量，岩石蛇躯绞杀目标造成260点伤害并禁锢2秒。", "power": 260, "vfx": "stone_edge", "sfx": "skill", "scale": 0.48},
			3: {"name": "万丈地龙·撼天裂地大崩塌", "desc": "破土冲天狂暴撞击，造成680点巨额伤害并全屏击飞1.5秒！", "detail": "消耗85能量，钻入地核深处破土狂暴冲天而起，对全屏敌军造成680点真实物理伤害并全员击飞1.5秒！", "power": 680, "vfx": "earthquake", "sfx": "skill", "scale": 0.62}
		},
		"visual": {"primary": (155, 150, 145), "secondary": (110, 105, 100), "accent": (60, 55, 50), "eye": (20, 20, 20), "archetype": "serpentine", "features": ["horns"]}
	},
	"drowzee": {
		"num": 96, "id": "drowzee", "name": "催眠貘", "title": "催眠宝可梦", "cost": 1,
		"types": ["Psychic"], "hp": 600, "atk": 46, "armor": 25, "mr": 35, "range": 2, "atk_speed": 0.65, "max_mana": 75,
		"desc": "传说中食梦貘的后裔，最喜欢吞食人们快乐美妙的梦境，动动长长的鼻子就能知晓对方正在做什么样的梦。",
		"skill_name": "催眠术·食梦", "skill_desc": "晃动身躯催眠敌人2秒，并吞食其梦境恢复生命。",
		"skill_detail": "消耗75能量，摆动双臂释放强烈的催眠声波使目标陷入沉睡2秒，并吞食其梦境造成170点伤害，自身回复170点生命。",
		"skill_power": 170,
		"skills": {
			1: {"name": "催眠术", "desc": "催眠目标2秒并吸取170点生命。", "detail": "消耗75能量，催眠沉睡2秒造成170点伤害并回血170点。", "power": 170, "vfx": "hypnosis", "sfx": "skill", "scale": 0.32},
			2: {"name": "食梦光波", "desc": "吞噬梦境造成300点伤害并回血200点。", "detail": "消耗75能量，食梦光波造成300点伤害并回复200点生命。", "power": 300, "vfx": "dream_eater", "sfx": "skill", "scale": 0.42},
			3: {"name": "万物入眠·千古幻梦寂灭咒", "desc": "让半场敌军全体沉睡2.5秒，造成600点穿透超能伤害！", "detail": "消耗75能量，释放范围极大的食梦结界，使范围内所有敌人沉睡2.5秒并造成600点穿透超能伤害！", "power": 600, "vfx": "psychic", "sfx": "skill", "scale": 0.54}
		},
		"visual": {"primary": (235, 195, 55), "secondary": (115, 70, 50), "accent": (30, 25, 20), "eye": (20, 20, 20), "archetype": "biped", "features": ["ears", "nose"]}
	},
	"hypno": {
		"num": 97, "id": "hypno", "name": "引梦貘人", "title": "催眠宝可梦", "cost": 3,
		"types": ["Psychic"], "hp": 900, "atk": 72, "armor": 38, "mr": 55, "range": 2, "atk_speed": 0.70, "max_mana": 80,
		"desc": "手里总是悬挂着一枚钟摆般的发光银色圆环，只要目光注视着圆环三秒钟，就会陷入绝对无法醒来的深度催眠。",
		"skill_name": "绝对催眠·钟摆之牢", "skill_desc": "摆动银环催眠2.5秒，造成420点伤害并偷取能量。",
		"skill_detail": "消耗80能量，摇晃手中引梦圆环释放迷幻波动，使目标陷入深度催眠2.5秒，造成420点法术伤害并偷取其35点能量。",
		"skill_power": 420,
		"skills": {
			1: {"name": "意念钟摆", "desc": "钟摆晃动造成240点伤害并催眠1.5秒。", "detail": "消耗80能量，钟摆催眠造成240点伤害并沉睡1.5秒。", "power": 240, "vfx": "hypnosis", "sfx": "skill", "scale": 0.38},
			2: {"name": "绝对催眠·钟摆之牢", "desc": "深度催眠2.5秒造成420点伤害并偷能量。", "detail": "消耗80能量，深度催眠2.5秒造成420点伤害并偷取35点能量。", "power": 420, "vfx": "dream_eater", "sfx": "skill", "scale": 0.50},
			3: {"name": "无量永眠·庄周梦蝶万古劫", "desc": "全图催眠3秒，造成980点毁灭真实伤害并让敌人自相残杀！", "detail": "消耗80能量，摇动钟摆震荡虚空，使全场敌人陷入无法醒来的永眠梦境3秒，造成980点真实伤害并强制其混乱自相残杀！", "power": 980, "vfx": "future_sight", "sfx": "skill", "scale": 0.68}
		},
		"visual": {"primary": (235, 190, 45), "secondary": (245, 245, 250), "accent": (190, 190, 205), "eye": (20, 20, 20), "archetype": "biped", "features": ["ears", "nose"]}
	},
	"krabby": {
		"num": 98, "id": "krabby", "name": "大钳蟹", "title": "水蟹宝可梦", "cost": 1,
		"types": ["Water"], "hp": 540, "atk": 62, "armor": 38, "mr": 20, "range": 1, "atk_speed": 0.70, "max_mana": 70,
		"desc": "在沙滩上挖掘洞穴居住，如果钳子在战斗中折断了也能迅速重新长出，巨大的蟹钳拥有轻易夹断木桩的惊人力量。",
		"skill_name": "夹住·泡沫喷射", "skill_desc": "巨钳死死夹住敌人造成190点伤害并眩晕0.8秒。",
		"skill_detail": "消耗70能量，举起重型蟹钳猛烈合拢夹击目标，造成190点水系物理伤害并附带0.8秒眩晕。",
		"skill_power": 190,
		"skills": {
			1: {"name": "夹住", "desc": "巨钳夹击造成190点物理伤害并眩晕0.8秒。", "detail": "消耗70能量，巨钳夹击造成190点伤害并眩晕0.8秒。", "power": 190, "vfx": "water_gun", "sfx": "water", "scale": 0.32},
			2: {"name": "泥巴射击·蟹钳锤", "desc": "重钳重砸造成310点伤害并降低35%移速。", "detail": "消耗70能量，蟹钳猛锤造成310点伤害并降低35%移速与攻速。", "power": 310, "vfx": "crabhammer", "sfx": "water", "scale": 0.44},
			3: {"name": "狂澜金刚钳·断头碎海斩", "desc": "重锤粉碎大地造成620点巨额物理伤害与碎甲50%！", "detail": "消耗70能量，双钳蓄力轰然砸裂地面，对直线敌人造成620点物理伤害并粉碎50%护甲持续3秒！", "power": 620, "vfx": "dynamic_punch", "sfx": "water", "scale": 0.56}
		},
		"visual": {"primary": (235, 90, 50), "secondary": (245, 235, 205), "accent": (180, 50, 20), "eye": (20, 20, 20), "archetype": "quadruped", "features": ["claws"]}
	},
	"kingler": {
		"num": 99, "id": "kingler", "name": "巨钳蟹", "title": "剪刀宝可梦", "cost": 3,
		"types": ["Water"], "hp": 880, "atk": 94, "armor": 55, "mr": 30, "range": 1, "atk_speed": 0.75, "max_mana": 75,
		"desc": "巨大的左钳重达一万马力，威力大得惊人，虽然由于过重行动有些笨拙，但只要挥舞起来就能粉碎坚固的钢铁战舰！",
		"skill_name": "蟹钳锤·万马力重击", "skill_desc": "一万马力铁钳轰然砸下，造成480点伤害并破甲60%。",
		"skill_detail": "消耗75能量，高高举起巨大蟹钳爆发出万马力神力怒砸目标，造成480点暴击物理伤害并撕裂其60%护甲，持续3秒。",
		"skill_power": 480,
		"skills": {
			1: {"name": "硬化重钳", "desc": "铁钳砸击造成260点物理伤害并碎甲30%。", "detail": "消耗75能量，挥动重钳造成260点伤害并削弱30%护甲。", "power": 260, "vfx": "water_gun", "sfx": "water", "scale": 0.38},
			2: {"name": "蟹钳锤·万马力重击", "desc": "万马力重击造成480点伤害并破甲60%。", "detail": "消耗75能量，巨钳怒砸造成480点伤害并撕裂60%护甲。", "power": 480, "vfx": "crabhammer", "sfx": "water", "scale": 0.50},
			3: {"name": "霸王断首·开山裂海神皇斩", "desc": "巨钳斩碎苍穹造成1080点真实暴击物理伤害与斩杀！", "detail": "消耗75能量，霸皇巨钳化作断岳神锋横扫敌阵，对扇形全体敌人造成1080点真实物理伤害，生命低于25%直接斩杀！", "power": 1080, "vfx": "dynamic_punch", "sfx": "water", "scale": 0.68}
		},
		"visual": {"primary": (230, 80, 45), "secondary": (245, 230, 195), "accent": (175, 45, 15), "eye": (20, 20, 20), "archetype": "quadruped", "features": ["claws"]}
	},
	"voltorb": {
		"num": 100, "id": "voltorb", "name": "霹雳电球", "title": "球宝可梦", "cost": 1,
		"types": ["Electric"], "hp": 520, "atk": 50, "armor": 25, "mr": 25, "range": 2, "atk_speed": 0.78, "max_mana": 70,
		"desc": "外形极其酷似红白精灵球，真实身份成谜。只要受到极小的刺激或惊吓，就会毫不犹豫地在瞬间引发强力自爆！",
		"skill_name": "自爆·闪电火花", "skill_desc": "冲向敌人引爆体内高压电球，造成200点范围伤害并击退。",
		"skill_detail": "消耗70能量，高速滚向目标引爆外壳高压电荷，对目标及周围敌军造成200点雷电法术伤害并击退1格。",
		"skill_power": 200,
		"skills": {
			1: {"name": "电击爆裂", "desc": "引爆火花造成200点范围伤害并击退。", "detail": "消耗70能量，引爆电火花造成200点伤害并击退1格。", "power": 200, "vfx": "thunderbolt", "sfx": "electric", "scale": 0.32},
			2: {"name": "自爆·电流脉冲", "desc": "释放脉冲造成320点伤害并麻痹1.5秒。", "detail": "消耗70能量，脉冲轰击造成320点伤害并使敌人麻痹1.5秒。", "power": 320, "vfx": "thunder", "sfx": "electric", "scale": 0.42},
			3: {"name": "核能电涌·究极万伏大爆炸", "desc": "引发核爆级闪电风暴，造成650点真实雷伤并震飞全场！", "detail": "消耗70能量，引爆球体内部所有高压电能，对大范围所有敌人造成650点真实雷电伤害并击飞1.5秒！", "power": 650, "vfx": "hyper_beam", "sfx": "electric", "scale": 0.54}
		},
		"visual": {"primary": (220, 45, 45), "secondary": (245, 245, 250), "accent": (30, 30, 30), "eye": (20, 20, 20), "archetype": "orb", "features": ["ball"]}
	},
	"electrode": {
		"num": 101, "id": "electrode", "name": "顽皮雷弹", "title": "球宝可梦", "cost": 3,
		"types": ["Electric"], "hp": 850, "atk": 74, "armor": 38, "mr": 38, "range": 2, "atk_speed": 0.90, "max_mana": 75,
		"desc": "吃下的电能越多奔跑速度就越快。体内储存了过于庞大的暴烈电流，稍有不慎甚至吹过一阵强风都会导致轰然大爆炸！",
		"skill_name": "大爆炸·万钧雷霆核爆", "skill_desc": "引爆体内全部狂暴雷能，造成480点大范围伤害并全员眩晕。",
		"skill_detail": "消耗75能量，瞬间释放体内储存的亿万伏特电力引发惊天核爆，对周围大范围敌人造成480点雷电伤害并眩晕1.2秒。",
		"skill_power": 480,
		"skills": {
			1: {"name": "十万伏特爆裂", "desc": "雷电轰鸣造成260点伤害并麻痹1.5秒。", "detail": "消耗75能量，雷暴炸裂造成260点伤害并麻痹1.5秒。", "power": 260, "vfx": "thunderbolt", "sfx": "electric", "scale": 0.38},
			2: {"name": "大爆炸·万钧雷霆核爆", "desc": "亿万伏特核爆造成480点范围伤害并眩晕1.2秒。", "detail": "消耗75能量，闪电核爆造成480点范围伤害并眩晕1.2秒。", "power": 480, "vfx": "thunder", "sfx": "electric", "scale": 0.50},
			3: {"name": "超新星天劫·灭世雷神大自爆", "desc": "化身闪电超新星引爆全屏，造成1100点毁灭真实雷伤！", "detail": "消耗75能量，将体内电力压缩至奇点后引爆超新星天劫，对全图所有敌人造成1100点真实雷电伤害并瘫痪3秒！", "power": 1100, "vfx": "hyper_beam", "sfx": "electric", "scale": 0.68}
		},
		"visual": {"primary": (245, 245, 250), "secondary": (220, 45, 45), "accent": (30, 30, 30), "eye": (20, 20, 20), "archetype": "orb", "features": ["ball"]}
	},
	"exeggcute": {
		"num": 102, "id": "exeggcute", "name": "蛋蛋", "title": "蛋宝可梦", "cost": 1,
		"types": ["Grass", "Psychic"], "hp": 560, "atk": 44, "armor": 35, "mr": 30, "range": 2, "atk_speed": 0.62, "max_mana": 75,
		"desc": "由六只蛋紧紧聚在一起组成的心灵共同体，通过彼此的心灵感应互相沟通，哪怕偶尔有一只分开了也能很快找到归队。",
		"skill_name": "精神冲击·催眠孢子", "skill_desc": "六蛋齐射心灵念力与孢子，造成170点伤害并催眠1秒。",
		"skill_detail": "消耗75能量，六颗蛋同时释放精神念波并伴随睡眠粉末，对目标造成170点草/超混合伤害并催眠1秒。",
		"skill_power": 170,
		"skills": {
			1: {"name": "念力孢子", "desc": "射出念力孢子造成170点伤害并催眠1秒。", "detail": "消耗75能量，念力孢子造成170点伤害并催眠1秒。", "power": 170, "vfx": "confusion", "sfx": "skill", "scale": 0.32},
			2: {"name": "炸弹飞投·寄生种子", "desc": "投掷蛋炸弹造成300点伤害并每秒回血60点。", "detail": "消耗75能量，投掷炸弹造成300点伤害并寄生回血持续3秒。", "power": 300, "vfx": "leech_seed", "sfx": "skill", "scale": 0.42},
			3: {"name": "六合玄灵·大千森罗神念网", "desc": "六核共鸣天网缠绕敌阵，造成620点穿透伤害并禁锢全员2秒！", "detail": "消耗75能量，六颗蛋引动森罗万象念力大阵，对敌方全阵造成620点法术伤害并禁锢全员2秒！", "power": 620, "vfx": "frenzy_plant", "sfx": "skill", "scale": 0.54}
		},
		"visual": {"primary": (245, 215, 210), "secondary": (195, 145, 135), "accent": (40, 30, 20), "eye": (20, 20, 20), "archetype": "orb", "features": ["eggs"]}
	},
	"exeggutor": {
		"num": 103, "id": "exeggutor", "name": "椰蛋树", "title": "椰子宝可梦", "cost": 4,
		"types": ["Grass", "Psychic"], "hp": 1150, "atk": 88, "armor": 50, "mr": 48, "range": 2, "atk_speed": 0.68, "max_mana": 85,
		"desc": "三个椰子脑袋各自拥有独立思考的大脑，阳光越充足三个头就笑得越欢，被称为行走的热带雨林之神！",
		"skill_name": "飞叶风暴·精神强念轰顶", "skill_desc": "召唤遮天飞叶与精神风暴，造成520点巨额范围伤害。",
		"skill_detail": "消耗85能量，树冠剧烈摇晃刮起漫天飞叶龙卷风，同时三颗脑袋释放强大精神强念轰击目标，造成520点范围草/超能伤害并降低35%魔抗。",
		"skill_power": 520,
		"skills": {
			1: {"name": "飞叶快刀·念力", "desc": "飞叶念力造成300点伤害并减速30%。", "detail": "消耗85能量，飞叶与念力造成300点混合伤害并减速30%。", "power": 300, "vfx": "razor_leaf", "sfx": "skill", "scale": 0.42},
			2: {"name": "飞叶风暴·精神强念轰顶", "desc": "风暴轰顶造成520点范围伤害并削弱35%魔抗。", "detail": "消耗85能量，召唤飞叶精神风暴造成520点范围伤害并碎抗。", "power": 520, "vfx": "psychic", "sfx": "skill", "scale": 0.54},
			3: {"name": "热带神木·通天神树落星辰", "desc": "唤醒万年神木神力砸落天外巨星，造成1250点真实伤害并全员眩晕2秒！", "detail": "消耗85能量，唤醒太古建木神威，苍穹降下巨型流星椰果轰击全场，造成1250点真实伤害并全图眩晕2秒！", "power": 1250, "vfx": "frenzy_plant", "sfx": "skill", "scale": 0.70}
		},
		"visual": {"primary": (175, 125, 75), "secondary": (60, 160, 60), "accent": (235, 195, 55), "eye": (20, 20, 20), "archetype": "plant", "features": ["leaves", "horns"]}
	},
	"cubone": {
		"num": 104, "id": "cubone", "name": "卡拉卡拉", "title": "孤独宝可梦", "cost": 1,
		"types": ["Ground"], "hp": 580, "atk": 54, "armor": 35, "mr": 25, "range": 1, "atk_speed": 0.68, "max_mana": 75,
		"desc": "头戴着死去的母亲留下的头骨，感到孤独悲伤时会在夜里对着月亮哭泣，手中握着的骨头棒是唯一的寄托与武器。",
		"skill_name": "骨头棒·回力镖", "skill_desc": "投掷骨头回力镖来回穿透，造成190点穿透伤害。",
		"skill_detail": "消耗75能量，将骨头棒当成回力标掷出，飞去与飞回两次贯穿目标直线，各造成95点物理伤害（共190点穿透物理伤害）。",
		"skill_power": 190,
		"skills": {
			1: {"name": "骨头棒", "desc": "投掷骨头回力镖造成190点穿透物理伤害。", "detail": "消耗75能量，骨头回力镖穿透造成190点物理伤害。", "power": 190, "vfx": "bonemerang", "sfx": "skill", "scale": 0.32},
			2: {"name": "骨棒乱打", "desc": "挥舞骨棒连续敲击造成310点伤害并眩晕0.8秒。", "detail": "消耗75能量，连续敲击造成310点伤害并眩晕0.8秒。", "power": 310, "vfx": "bone_rush", "sfx": "skill", "scale": 0.42},
			3: {"name": "母爱羁绊·万古幽魂守护击", "desc": "唤醒母爱英魂附体怒击，造成620点巨额伤害并获得300点骨甲护盾！", "detail": "消耗75能量，母亲英魂化作金光守护，向前劈出万钧骨刃，造成620点物理伤害并获得300点骨甲护盾！", "power": 620, "vfx": "earthquake", "sfx": "skill", "scale": 0.54}
		},
		"visual": {"primary": (175, 125, 75), "secondary": (245, 240, 230), "accent": (230, 225, 215), "eye": (20, 20, 20), "archetype": "biped", "features": ["skull", "tail", "bone"]}
	},
	"marowak": {
		"num": 105, "id": "marowak", "name": "嘎啦嘎啦", "title": "骨头宝可梦", "cost": 3,
		"types": ["Ground"], "hp": 920, "atk": 82, "armor": 52, "mr": 38, "range": 1, "atk_speed": 0.74, "max_mana": 80,
		"desc": "克服了丧母之痛进化后的勇猛战士，手中的骨头经过千锤百炼变得坚硬胜过金刚石，舞动起来如行云流水般致命！",
		"skill_name": "骨棒乱打·流星飞旋", "skill_desc": "骨棒狂舞化作破空旋风，造成450点物理伤害并全员破甲。",
		"skill_detail": "消耗80能量，双手翻飞舞动骨棒化作密不透风的白骨风暴，对周围敌人造成450点物理伤害，并撕裂目标40%护甲持续3秒。",
		"skill_power": 450,
		"skills": {
			1: {"name": "骨头回力镖", "desc": "极速回力镖穿透造成250点物理伤害。", "detail": "消耗80能量，极速骨头飞镖穿透造成250点物理伤害。", "power": 250, "vfx": "bonemerang", "sfx": "skill", "scale": 0.38},
			2: {"name": "骨棒乱打·流星飞旋", "desc": "白骨风暴造成450点范围伤害并碎甲40%。", "detail": "消耗80能量，骨棒风暴造成450点范围物理伤害并碎甲40%。", "power": 450, "vfx": "bone_rush", "sfx": "skill", "scale": 0.50},
			3: {"name": "修罗战狂·九天白骨诛仙阵", "desc": "白骨神芒破天狂砸，造成1020点真实物理伤害并全图击退！", "detail": "消耗80能量，战狂意志觉醒，白骨化作九天神矛劈碎虚空，对全图所有敌人造成1020点真实物理伤害并强力击退2格！", "power": 1020, "vfx": "earthquake", "sfx": "skill", "scale": 0.68}
		},
		"visual": {"primary": (165, 115, 65), "secondary": (245, 240, 230), "accent": (230, 225, 215), "eye": (20, 20, 20), "archetype": "biped", "features": ["skull", "tail", "bone"]}
	},
	"hitmonlee": {
		"num": 106, "id": "hitmonlee", "name": "飞腿郎", "title": "踢腿宝可梦", "cost": 3,
		"types": ["Fighting"], "hp": 860, "atk": 90, "armor": 38, "mr": 35, "range": 1, "atk_speed": 0.82, "max_mana": 75,
		"desc": "拥有弹簧般自由伸缩的修长强健双腿，能从意想不到的极远距离发动狂暴飞踢，任何坚固的盾牌在其踢击下都会粉碎！",
		"skill_name": "飞膝踢·疾风连影腿", "skill_desc": "凌空飞跃施展狂暴飞膝踢，造成480点高额物理伤害并击飞。",
		"skill_detail": "消耗75能量，双腿如弹簧般压缩后凌空跃起，以雷霆万钧之势施展致命飞膝踢，造成480点巨额物理伤害并将目标击飞1.2秒。",
		"skill_power": 480,
		"skills": {
			1: {"name": "二连踢", "desc": "连续飞踢造成250点物理伤害。", "detail": "消耗75能量，迅猛双踢造成250点格斗物理伤害。", "power": 250, "vfx": "cross_chop", "sfx": "skill", "scale": 0.38},
			2: {"name": "飞膝踢·疾风连影腿", "desc": "飞膝猛踢造成480点伤害并击飞1.2秒。", "detail": "消耗75能量，凌空飞膝踢造成480点伤害并击飞1.2秒。", "power": 480, "vfx": "close_combat", "sfx": "skill", "scale": 0.50},
			3: {"name": "腿王神威·断岳破空万影踏", "desc": "漫天残影狂踢全屏敌阵，造成1050点毁灭真实伤害！", "detail": "消耗75能量，化作万千踢影撕裂虚空穿梭敌阵，对全图所有敌人造成1050点毁灭真实物理伤害并强制击倒2秒！", "power": 1050, "vfx": "dynamic_punch", "sfx": "skill", "scale": 0.68}
		},
		"visual": {"primary": (175, 125, 75), "secondary": (245, 235, 220), "accent": (30, 30, 30), "eye": (20, 20, 20), "archetype": "biped", "features": ["legs"]}
	},
	"hitmonchan": {
		"num": 107, "id": "hitmonchan", "name": "快拳郎", "title": "拳击宝可梦", "cost": 3,
		"types": ["Fighting"], "hp": 860, "atk": 88, "armor": 42, "mr": 38, "range": 1, "atk_speed": 0.85, "max_mana": 75,
		"desc": "拥有世界拳击冠军般的坚毅意志，双拳能挥出肉眼无法捕捉的音速刺拳，甚至能一边旋转拳头一边击穿坚硬的混凝土壁！",
		"skill_name": "音速三色神拳", "skill_desc": "连续轰出火焰拳、冷冻拳、雷电拳，造成480点三重元素伤害。",
		"skill_detail": "消耗75能量，双拳瞬间燃起烈焰、极寒与狂雷，以音速连续轰出三重神拳，造成480点混合伤害并附加灼烧、减速与麻痹。",
		"skill_power": 480,
		"skills": {
			1: {"name": "音速刺拳", "desc": "音速刺拳造成250点物理伤害。", "detail": "消耗75能量，音速出拳造成250点格斗伤害。", "power": 250, "vfx": "cross_chop", "sfx": "skill", "scale": 0.38},
			2: {"name": "音速三色神拳", "desc": "三色神拳造成480点元素物理伤害并附带三重异常。", "detail": "消耗75能量，火冰雷三拳连轰造成480点伤害并附带三重异常。", "power": 480, "vfx": "close_combat", "sfx": "skill", "scale": 0.50},
			3: {"name": "拳皇绝顶·百烈瞬影灭神击", "desc": "一秒轰出一百记重拳，造成1050点真实暴击伤害与全屏击退！", "detail": "消耗75能量，双拳突破音障化作漫天拳芒风暴，对扇形全场敌人造成1050点毁灭真实物理伤害，并必定暴击击飞！", "power": 1050, "vfx": "dynamic_punch", "sfx": "skill", "scale": 0.68}
		},
		"visual": {"primary": (180, 130, 80), "secondary": (80, 85, 145), "accent": (215, 50, 50), "eye": (20, 20, 20), "archetype": "biped", "features": ["gloves"]}
	},
	"lickitung": {
		"num": 108, "id": "lickitung", "name": "大舌头", "title": "舔舐宝可梦", "cost": 2,
		"types": ["Normal"], "hp": 850, "atk": 62, "armor": 40, "mr": 40, "range": 1, "atk_speed": 0.65, "max_mana": 80,
		"desc": "拥有一条超过身体两倍长的巨型大舌头，舌头上的唾液极度黏腻，能够灵巧地卷起任何远处的物体并吞入腹中。",
		"skill_name": "强力长舌·麻痹舔舐", "skill_desc": "长舌缠绕抽打敌人，造成270点伤害并麻痹2秒。",
		"skill_detail": "消耗80能量，猛然甩出两米长的巨舌将目标死死缠住并抽打，造成270点普通物理伤害，并使其陷入重度麻痹2秒。",
		"skill_power": 270,
		"skills": {
			1: {"name": "舌舔抽打", "desc": "长舌抽打造成190点伤害并麻痹1秒。", "detail": "消耗80能量，甩出长舌造成190点伤害并麻痹1秒。", "power": 190, "vfx": "slash", "sfx": "skill", "scale": 0.36},
			2: {"name": "强力长舌·麻痹舔舐", "desc": "长舌缠绕抽打造成270点伤害并麻痹2秒。", "detail": "消耗80能量，长舌绞杀造成270点伤害并麻痹2秒。", "power": 270, "vfx": "sludge_bomb", "sfx": "skill", "scale": 0.46},
			3: {"name": "巨舌扫荡·万象吞吐大陀螺", "desc": "大舌化作旋风横扫全场，造成680点伤害并吸血400点！", "detail": "消耗80能量，舌头伸展化作狂暴陀螺扫荡全场，对所有敌人造成680点物理伤害并为自身回复400点生命！", "power": 680, "vfx": "hyper_beam", "sfx": "skill", "scale": 0.58}
		},
		"visual": {"primary": (245, 140, 160), "secondary": (245, 225, 180), "accent": (230, 80, 110), "eye": (20, 20, 20), "archetype": "biped", "features": ["tongue", "tail"]}
	},
	"koffing": {
		"num": 109, "id": "koffing", "name": "瓦斯弹", "title": "毒气宝可梦", "cost": 1,
		"types": ["Poison"], "hp": 550, "atk": 48, "armor": 35, "mr": 25, "range": 2, "atk_speed": 0.65, "max_mana": 70,
		"desc": "薄薄的球状身体内部充斥着高度易燃易爆的剧毒瓦斯，周身的小孔不断向外喷发呛人的毒雾，靠近时极其危险。",
		"skill_name": "浊雾·毒瓦斯喷射", "skill_desc": "喷发剧毒瓦斯云雾，造成170点范围伤害并中毒3秒。",
		"skill_detail": "消耗70能量，周身小孔同时喷射出刺鼻的深紫色毒瓦斯，对目标及周围敌军造成170点毒系伤害，并附加持续3秒的中毒效果。",
		"skill_power": 170,
		"skills": {
			1: {"name": "毒瓦斯", "desc": "喷发毒雾造成170点伤害并中毒3秒。", "detail": "消耗70能量，喷出毒雾造成170点伤害并中毒3秒。", "power": 170, "vfx": "sludge_bomb", "sfx": "skill", "scale": 0.32},
			2: {"name": "自爆·毒瓦斯引爆", "desc": "引爆瓦斯造成310点范围伤害并致盲2秒。", "detail": "消耗70能量，瓦斯爆裂造成310点范围伤害并致盲2秒。", "power": 310, "vfx": "acid_armor", "sfx": "skill", "scale": 0.42},
			3: {"name": "黑死冥雾·万劫毒烟大崩解", "desc": "释放漫天浓缩毒烟，造成620点巨额范围伤害并全员剧毒腐蚀！", "detail": "消耗70能量，引爆体内剧毒核心，向四周喷涌遮天蔽日的黑紫毒雾，造成620点真实伤害并削弱35%防御持续4秒！", "power": 620, "vfx": "gunk_shot", "sfx": "skill", "scale": 0.54}
		},
		"visual": {"primary": (135, 100, 155), "secondary": (230, 225, 195), "accent": (90, 60, 110), "eye": (20, 20, 20), "archetype": "orb", "features": ["floating", "gas"]}
	},
	"weezing": {
		"num": 110, "id": "weezing", "name": "双弹瓦斯", "title": "毒气宝可梦", "cost": 3,
		"types": ["Poison"], "hp": 900, "atk": 74, "armor": 50, "mr": 40, "range": 2, "atk_speed": 0.70, "max_mana": 80,
		"desc": "由两个大小不同的瓦斯弹融合而成，双头交替吸入垃圾腐烂的气体并在体内进行混合，能制造出毒性翻倍的致命恶毒之雾！",
		"skill_name": "污泥炸弹·双重瓦斯风暴", "skill_desc": "双头喷射剧毒泥弹与浓雾，造成440点伤害并削弱40%魔抗。",
		"skill_detail": "消耗80能量，两个头颅同步喷发高压剧毒污泥与浓烟风暴，对大范围所有敌人造成440点毒系伤害，并削弱其40%魔抗，持续3秒。",
		"skill_power": 440,
		"skills": {
			1: {"name": "污泥喷射", "desc": "喷射毒泥造成250点伤害并中毒3秒。", "detail": "消耗80能量，毒泥爆发造成250点伤害并中毒3秒。", "power": 250, "vfx": "sludge_bomb", "sfx": "skill", "scale": 0.38},
			2: {"name": "污泥炸弹·双重瓦斯风暴", "desc": "双重毒雾造成440点伤害并削弱40%魔抗。", "detail": "消耗80能量，双头喷毒造成440点范围伤害并削弱40%魔抗。", "power": 440, "vfx": "gunk_shot", "sfx": "skill", "scale": 0.50},
			3: {"name": "万毒归宗·末日生化大核爆", "desc": "双核引发毁灭生化大爆炸，造成1050点真实伤害并全图瘫痪！", "detail": "消耗80能量，双头内部化学物质猛烈反应引发末日生化核爆，对全场所有敌人造成1050点毁灭真实伤害并瘫痪其普攻2.5秒！", "power": 1050, "vfx": "acid_armor", "sfx": "skill", "scale": 0.68}
		},
		"visual": {"primary": (130, 95, 150), "secondary": (225, 220, 190), "accent": (85, 55, 105), "eye": (20, 20, 20), "archetype": "orb", "features": ["floating", "gas"]}
	},
	"rhyhorn": {
		"num": 111, "id": "rhyhorn", "name": "独角犀牛", "title": "尖角宝可梦", "cost": 2,
		"types": ["Ground", "Rock"], "hp": 850, "atk": 68, "armor": 55, "mr": 25, "range": 1, "atk_speed": 0.62, "max_mana": 85,
		"desc": "脑筋非常简单，一旦开始直线狂奔就很难停下来，即使一头撞上坚固的钢筋混凝土大楼也能将其撞个粉碎！",
		"skill_name": "猛撞·角撞破阵", "skill_desc": "狂奔冲撞撞飞直线目标，造成280点物理伤害并击退。",
		"skill_detail": "消耗85能量，低头亮出坚锐巨角向前野蛮冲撞，击穿直线所有阻挡的敌人，造成280点地面物理伤害并将目标强力击退1.5格。",
		"skill_power": 280,
		"skills": {
			1: {"name": "角撞", "desc": "坚角突刺造成190点物理伤害并击退。", "detail": "消耗85能量，尖角撞击造成190点伤害并击退1格。", "power": 190, "vfx": "rock_slide", "sfx": "skill", "scale": 0.36},
			2: {"name": "猛撞·角撞破阵", "desc": "野蛮狂冲造成280点直线穿透伤害并击退。", "detail": "消耗85能量，直线猛冲造成280点穿透物理伤害并强力击退。", "power": 280, "vfx": "stone_edge", "sfx": "skill", "scale": 0.46},
			3: {"name": "狂暴战车·山崩地裂踏岳击", "desc": "巨足践踏震碎地脉，造成700点巨额物理伤害与全员击飞！", "detail": "消耗85能量，狂暴践踏引发山崩地裂，对周围所有敌人造成700点真实物理伤害并全员击飞1.2秒！", "power": 700, "vfx": "earthquake", "sfx": "skill", "scale": 0.58}
		},
		"visual": {"primary": (150, 155, 160), "secondary": (110, 115, 120), "accent": (60, 65, 70), "eye": (20, 20, 20), "archetype": "quadruped", "features": ["horns", "tail"]}
	},
	"rhydon": {
		"num": 112, "id": "rhydon", "name": "钻角犀兽", "title": "钻锥宝可梦", "cost": 4,
		"types": ["Ground", "Rock"], "hp": 1250, "atk": 98, "armor": 68, "mr": 35, "range": 1, "atk_speed": 0.68, "max_mana": 90,
		"desc": "后肢站立行走的重装战士，头顶的利角能像金刚石钻头一样高速旋转，轻而易举便能钻透坚硬的花岗岩山峰！",
		"skill_name": "角钻·天崩巨岩裂", "skill_desc": "金刚角钻高速旋转钻击，造成580点穿甲伤害并眩晕1.5秒。",
		"skill_detail": "消耗90能量，头顶巨角化作超高速旋转的金刚石破岩钻头，猛烈钻透目标身躯，造成580点巨额物理伤害，粉碎50%护甲并眩晕1.5秒。",
		"skill_power": 580,
		"skills": {
			1: {"name": "旋转角撞", "desc": "高速角撞造成320点伤害并碎甲25%。", "detail": "消耗90能量，高速角钻造成320点伤害并削弱25%护甲。", "power": 320, "vfx": "rock_slide", "sfx": "skill", "scale": 0.42},
			2: {"name": "角钻·天崩巨岩裂", "desc": "金刚角钻钻击造成580点伤害并眩晕1.5秒。", "detail": "消耗90能量，破岩角钻造成580点伤害并眩晕1.5秒。", "power": 580, "vfx": "stone_edge", "sfx": "skill", "scale": 0.54},
			3: {"name": "撼天裂地·金刚钻角弑神破", "desc": "角钻引爆地心岩浆喷发，造成1300点真实伤害并震毁全场！", "detail": "消耗90能量，角钻直插地底引爆太古地热岩浆风暴，对全图所有敌人造成1300点毁灭真实伤害并全图眩晕2秒！", "power": 1300, "vfx": "earthquake", "sfx": "skill", "scale": 0.72}
		},
		"visual": {"primary": (145, 150, 155), "secondary": (105, 110, 115), "accent": (55, 60, 65), "eye": (20, 20, 20), "archetype": "biped", "features": ["horns", "tail"]}
	},
	"chansey": {
		"num": 113, "id": "chansey", "name": "吉利蛋", "title": "蛋宝可梦", "cost": 3,
		"types": ["Normal"], "hp": 1400, "atk": 40, "armor": 30, "mr": 60, "range": 2, "atk_speed": 0.65, "max_mana": 85,
		"desc": "每天都会下一颗营养极其丰富的美味幸福蛋，会把蛋分享给受伤的宝可梦和人类，心地极度温柔纯洁。",
		"skill_name": "生蛋·天使守护光", "skill_desc": "为生命最低的友军回血500点，并为全队施加250点护盾。",
		"skill_detail": "消耗85能量，捧出充满神圣生命力的幸福蛋，为当前生命百分比最低的友军恢复500点生命值，同时为全体友军提供250点天使护盾，持续4秒。",
		"skill_power": 500,
		"skills": {
			1: {"name": "治愈波动", "desc": "恢复友军300点生命值。", "detail": "消耗85能量，治愈之光为虚弱友军回复300点生命。", "power": 300, "vfx": "softboiled", "sfx": "heal", "scale": 0.40},
			2: {"name": "生蛋·天使守护光", "desc": "回血500点并为全队加250点护盾。", "detail": "消耗85能量，强力治愈回血500点并为全队施加250护盾。", "power": 500, "vfx": "heal_pulse", "sfx": "heal", "scale": 0.52},
			3: {"name": "大爱无疆·万物生辉甘霖劫", "desc": "降下神圣生命甘霖，全体友军回复800生命并净化一切异常！", "detail": "消耗85能量，引动天地至纯至善之灵，降下笼罩全屏的生命神圣甘霖，全体友军恢复800点生命并清除所有负面状态！", "power": 800, "vfx": "hyper_beam", "sfx": "heal", "scale": 0.70}
		},
		"visual": {"primary": (245, 185, 200), "secondary": (245, 240, 235), "accent": (235, 130, 155), "eye": (20, 20, 20), "archetype": "orb", "features": ["ears", "egg"]}
	},
	"tangela": {
		"num": 114, "id": "tangela", "name": "蔓藤怪", "title": "藤蔓宝可梦", "cost": 2,
		"types": ["Grass"], "hp": 780, "atk": 56, "armor": 45, "mr": 35, "range": 2, "atk_speed": 0.65, "max_mana": 75,
		"desc": "全身被无数蓝色粗藤蔓紧紧包裹，真实的面貌至今无人见过，受到攻击时藤蔓会迅速再生并缠绕反制敌人。",
		"skill_name": "强力藤鞭·寄生吸取", "skill_desc": "深蓝藤蔓狂舞抽打，造成260点伤害并将70%转化为自身生命。",
		"skill_detail": "消耗75能量，从蓝色藤蔓球中爆发出数条粗壮强力的藤鞭狠狠抽打目标，造成260点草系伤害，并将造成的70%伤害转化为自身治疗。",
		"skill_power": 260,
		"skills": {
			1: {"name": "藤鞭抽击", "desc": "藤鞭抽打造成180点伤害并吸血50%。", "detail": "消耗75能量，藤鞭抽打造成180点伤害并吸血50%。", "power": 180, "vfx": "leech_seed", "sfx": "skill", "scale": 0.36},
			2: {"name": "强力藤鞭·寄生吸取", "desc": "藤鞭狂舞造成260点伤害并吸血70%。", "detail": "消耗75能量，藤鞭绞击造成260点伤害并吸血70%。", "power": 260, "vfx": "razor_leaf", "sfx": "skill", "scale": 0.46},
			3: {"name": "森罗万象·万丈天罗碧藤牢", "desc": "无数深蓝巨藤破地绞杀，造成680点伤害并缠绕禁锢全场2秒！", "detail": "消耗75能量，万丈幽蓝古藤破地而起笼罩全场，对所有敌人造成680点草系伤害并禁锢全员2秒！", "power": 680, "vfx": "frenzy_plant", "sfx": "skill", "scale": 0.60}
		},
		"visual": {"primary": (45, 90, 195), "secondary": (220, 50, 50), "accent": (30, 30, 30), "eye": (240, 240, 245), "archetype": "orb", "features": ["vines"]}
	},
	"kangaskhan": {
		"num": 115, "id": "kangaskhan", "name": "袋兽", "title": "亲子宝可梦", "cost": 4,
		"types": ["Normal"], "hp": 1200, "atk": 95, "armor": 50, "mr": 45, "range": 1, "atk_speed": 0.78, "max_mana": 85,
		"desc": "腹部的育儿袋中抚养着幼崽，为了保护宝宝即使面对再强大的敌人也绝不后退，母子合体攻击默契无间！",
		"skill_name": "亲子爱·双重重拳", "skill_desc": "母子同步挥拳狂暴连击，造成560点伤害并眩晕1.2秒。",
		"skill_detail": "消耗85能量，母亲与幼崽心意相通同时挥出重拳，母亲轰出暴烈破甲重拳，幼崽紧随其后追加一击，共造成560点物理伤害并眩晕1.2秒。",
		"skill_power": 560,
		"skills": {
			1: {"name": "连续重拳", "desc": "双重拳击造成320点物理伤害。", "detail": "消耗85能量，母子连续出拳造成320点物理伤害。", "power": 320, "vfx": "cross_chop", "sfx": "skill", "scale": 0.42},
			2: {"name": "亲子爱·双重重拳", "desc": "母子合击造成560点伤害并眩晕1.2秒。", "detail": "消耗85能量，亲子双拳合击造成560点物理伤害并眩晕1.2秒。", "power": 560, "vfx": "close_combat", "sfx": "skill", "scale": 0.54},
			3: {"name": "母爱暴怒·山崩海啸破灭霸皇击", "desc": "护崽狂怒爆发，造成1280点真实暴击伤害并获得600巨盾！", "detail": "消耗85能量，护子狂暴彻底激发远古母系战意，粉碎前方一切阻碍，造成1280点真实暴击物理伤害并获得600点霸体护盾！", "power": 1280, "vfx": "dynamic_punch", "sfx": "skill", "scale": 0.72}
		},
		"visual": {"primary": (155, 125, 95), "secondary": (235, 215, 175), "accent": (50, 45, 40), "eye": (20, 20, 20), "archetype": "biped", "features": ["pouch", "tail", "ears"]}
	},
	"horsea": {
		"num": 116, "id": "horsea", "name": "墨海马", "title": "龙宝可梦", "cost": 1,
		"types": ["Water"], "hp": 500, "atk": 46, "armor": 25, "mr": 25, "range": 2, "atk_speed": 0.72, "max_mana": 70,
		"desc": "在珊瑚丛的阴影中建立巢穴，感知到危险时会从口中猛烈喷射出乌黑的墨汁逃之夭夭，拥有龙族的远古血脉潜能。",
		"skill_name": "烟幕·高压水枪", "skill_desc": "喷吐黑墨水使目标致盲，紧接着喷射水流造成170点伤害。",
		"skill_detail": "消耗70能量，从管状嘴中瞬间喷射浓黑墨汁致盲目标2秒（攻击落空率50%），并追加高压水枪造成170点水系伤害。",
		"skill_power": 170,
		"skills": {
			1: {"name": "水枪喷墨", "desc": "喷墨致盲并造成170点水系伤害。", "detail": "消耗70能量，喷射水流造成170点伤害并致盲2秒。", "power": 170, "vfx": "water_gun", "sfx": "water", "scale": 0.32},
			2: {"name": "泡沫光线·龙息", "desc": "喷射龙息水泡造成300点伤害并减速40%。", "detail": "消耗70能量，龙息水泡造成300点伤害并减速40%。", "power": 300, "vfx": "dragon_breath", "sfx": "water", "scale": 0.42},
			3: {"name": "逆鳞跃龙门·真龙惊涛破", "desc": "觉醒远古真龙潜能，造成620点穿透伤害并全员击退！", "detail": "消耗70能量，唤醒体内潜藏的太古龙威，激荡起翻江倒海的水龙波，造成620点法术伤害并击退整排敌人！", "power": 620, "vfx": "hydro_pump", "sfx": "water", "scale": 0.54}
		},
		"visual": {"primary": (90, 175, 230), "secondary": (245, 240, 210), "accent": (40, 110, 180), "eye": (210, 40, 40), "archetype": "floating", "features": ["tail", "fins"]}
	},
	"seadra": {
		"num": 117, "id": "seadra", "name": "海刺龙", "title": "龙宝可梦", "cost": 3,
		"types": ["Water"], "hp": 850, "atk": 75, "armor": 45, "mr": 40, "range": 2, "atk_speed": 0.78, "max_mana": 75,
		"desc": "周身覆盖着锐利的毒刺，能在急流旋涡中安然睡眠，从嘴里喷射出的水流拥有连大岩石都能穿透的惊人破坏力！",
		"skill_name": "水炮·龙之波动", "skill_desc": "射出贯穿直线的强力龙流水炮，造成440点穿透法术伤害。",
		"skill_detail": "消耗75能量，周身尖刺竖起激荡起狂暴水龙波，向前激射一道水龙冲击波，贯穿直线所有敌军造成440点水/龙法术伤害。",
		"skill_power": 440,
		"skills": {
			1: {"name": "龙息激流", "desc": "喷射龙息激流造成250点伤害并减速。", "detail": "消耗75能量，龙息喷射造成250点伤害并减速35%。", "power": 250, "vfx": "dragon_breath", "sfx": "water", "scale": 0.38},
			2: {"name": "水炮·龙之波动", "desc": "直线龙流水炮贯穿造成440点伤害。", "detail": "消耗75能量，贯穿直线发射水龙炮造成440点法术伤害。", "power": 440, "vfx": "hydro_pump", "sfx": "water", "scale": 0.50},
			3: {"name": "沧海龙皇·怒海翻江天怒劫", "desc": "引动苍茫深海龙皇威压，造成1020点真实伤害并全图击飞！", "detail": "消耗75能量，苍穹聚起深海巨龙虚影俯冲轰炸全场，对所有敌人造成1020点真实伤害并全图击飞1.5秒！", "power": 1020, "vfx": "hydro_cannon", "sfx": "water", "scale": 0.68}
		},
		"visual": {"primary": (80, 165, 220), "secondary": (240, 235, 205), "accent": (35, 100, 170), "eye": (210, 40, 40), "archetype": "floating", "features": ["tail", "fins", "horns"]}
	},
	"goldeen": {
		"num": 118, "id": "goldeen", "name": "角金鱼", "title": "金鱼宝可梦", "cost": 1,
		"types": ["Water"], "hp": 520, "atk": 52, "armor": 22, "mr": 22, "range": 1, "atk_speed": 0.72, "max_mana": 70,
		"desc": "头顶长有一支锋利的尖角，在水中游泳的姿态如同身披华丽丝绸的舞者般优雅，被称为水中的水中皇后。",
		"skill_name": "啄钻·独角突刺", "skill_desc": "尖角高速旋转冲撞，造成180点穿刺伤害并破甲20%。",
		"skill_detail": "消耗70能量，头顶玉角如电钻般极速旋转化作利矛突刺目标，造成180点水系物理伤害并撕开其20%护甲持续2.5秒。",
		"skill_power": 180,
		"skills": {
			1: {"name": "角撞", "desc": "尖角突刺造成180点伤害并破甲20%。", "detail": "消耗70能量，尖角撞击造成180点伤害并削弱20%护甲。", "power": 180, "vfx": "water_gun", "sfx": "water", "scale": 0.32},
			2: {"name": "高速角钻", "desc": "旋转钻击造成300点伤害并碎甲35%。", "detail": "消耗70能量，角钻造成300点伤害并削弱35%护甲。", "power": 300, "vfx": "drill_peck", "sfx": "water", "scale": 0.42},
			3: {"name": "惊鸿照影·千波碧水断天刺", "desc": "凌波微步破空突刺，造成620点穿透暴击伤害！", "detail": "消耗70能量，化作七彩锦鲤在水波中破空穿梭，对直线所有敌军造成620点物理伤害并必定暴击！", "power": 620, "vfx": "hydro_pump", "sfx": "water", "scale": 0.54}
		},
		"visual": {"primary": (245, 110, 60), "secondary": (245, 245, 250), "accent": (230, 40, 40), "eye": (30, 50, 160), "archetype": "fish", "features": ["fins", "tail", "horns"]}
	},
	"seaking": {
		"num": 119, "id": "seaking", "name": "金鱼王", "title": "金鱼宝可梦", "cost": 3,
		"types": ["Water"], "hp": 880, "atk": 82, "armor": 40, "mr": 38, "range": 1, "atk_speed": 0.78, "max_mana": 75,
		"desc": "在秋天的繁殖季节，全身会染上艳丽斑斓的红白色彩，雄性会用额头那支坚固的尖角在河底岩石上凿洞筑巢。",
		"skill_name": "超级角击·破山金刚角", "skill_desc": "金刚角狂暴破阵突刺，造成460点伤害并粉碎50%防御。",
		"skill_detail": "消耗75能量，额头巨角凝聚全身怪力与翻涌激流，以摧枯拉朽之势轰碎目标，造成460点巨额物理伤害并粉碎50%护甲持续3秒。",
		"skill_power": 460,
		"skills": {
			1: {"name": "角撞破甲", "desc": "角撞造成250点伤害并碎甲25%。", "detail": "消耗75能量，尖角撞击造成250点物理伤害并削弱25%护甲。", "power": 250, "vfx": "water_gun", "sfx": "water", "scale": 0.38},
			2: {"name": "超级角击·破山金刚角", "desc": "金刚角突刺造成460点伤害并粉碎50%防御。", "detail": "消耗75能量，超级角击造成460点伤害并碎甲50%。", "power": 460, "vfx": "drill_peck", "sfx": "water", "scale": 0.50},
			3: {"name": "海王龙角·碧海潮生破灭刺", "desc": "角裂苍穹引爆惊天海啸，造成1020点真实伤害并全员穿透！", "detail": "消耗75能量，额头玉角引动天地海潮神力，化身海王战神贯穿全场，对所有敌人造成1020点真实伤害并击退2格！", "power": 1020, "vfx": "hydro_cannon", "sfx": "water", "scale": 0.68}
		},
		"visual": {"primary": (240, 95, 45), "secondary": (245, 245, 250), "accent": (30, 30, 30), "eye": (30, 50, 160), "archetype": "fish", "features": ["fins", "tail", "horns"]}
	},
	"staryu": {
		"num": 120, "id": "staryu", "name": "海星星", "title": "星形宝可梦", "cost": 1,
		"types": ["Water"], "hp": 520, "atk": 48, "armor": 28, "mr": 30, "range": 2, "atk_speed": 0.72, "max_mana": 70,
		"desc": "身体中央有一颗红色的发光核心，在夜里会随着天空中闪烁的星辰一同闪耀，即使身体残破也能迅速自我再生。",
		"skill_name": "高速星星·红核闪光", "skill_desc": "从红宝石核心发射星光，造成170点伤害并必定命中。",
		"skill_detail": "消耗70能量，胸口发光核心剧烈共振，向目标发射漫天闪耀的金色光芒星弹，造成170点超能/水混合法术伤害，且绝不落空。",
		"skill_power": 170,
		"skills": {
			1: {"name": "高速星星", "desc": "发射金星造成170点伤害且必定命中。", "detail": "消耗70能量，射出星弹造成170点伤害并必定命中。", "power": 170, "vfx": "swift", "sfx": "skill", "scale": 0.32},
			2: {"name": "精神光线·水之波动", "desc": "红核激射光束造成300点伤害并减速。", "detail": "消耗70能量，光束扫射造成300点伤害并使敌人减速35%。", "power": 300, "vfx": "psybeam", "sfx": "skill", "scale": 0.42},
			3: {"name": "天星引力·星辉洗礼净化劫", "desc": "召唤天外群星坠地，造成620点范围伤害并全员致盲2秒！", "detail": "消耗70能量，红核沟通苍穹星辰降下漫天璀璨星雨，造成620点法术伤害并致盲所有敌人2秒！", "power": 620, "vfx": "hyper_beam", "sfx": "skill", "scale": 0.54}
		},
		"visual": {"primary": (195, 150, 95), "secondary": (225, 45, 45), "accent": (215, 195, 55), "eye": (225, 45, 45), "archetype": "star", "features": ["gem"]}
	}
}
