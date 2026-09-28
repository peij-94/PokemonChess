extends Node

# PokemonDatabase: Central repository of all Pokemon stats, skills, and synergy definitions

var pokemons: Dictionary = {
	"charmander": {
		"id": "charmander",
		"name": "小火龙",
		"title": "蜥蜴宝可梦",
		"cost": 1,
		"types": ["Fire"],
		"hp": 550,
		"atk": 52,
		"armor": 20,
		"mr": 20,
		"range": 2,
		"atk_speed": 0.70,
		"max_mana": 100,
		"skill_name": "火花",
		"skill_desc": "向对手发射小型火焰进行攻击。有时会让对手陷入灼伤状态。",
		"skill_detail": "消耗100能量，使出【火花】。向对手发射小型火焰进行攻击。有时会让对手陷入灼伤状态。 对目标造成182点伤害。",
		"skill_power": 182,
		"basic_attack": {
			"type": "special",
			"name": "火花",
			"style": "fire_ember",
			"sfx": "fire"
		},
						"skills": {
			1: [
				{
					"name": "火花",
					"desc": "向对手发射小型火焰进行攻击。有时会让对手陷入灼伤状态。",
					"detail": "消耗100能量，使出【火花】。向对手发射小型火焰进行攻击。有时会让对手陷入灼伤状态。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "ember",
					"sfx": "fire",
					"scale": 0.82
				},
				{
					"name": "抓",
					"desc": "用坚硬且无比锋利的爪子抓对手进行攻击。",
					"detail": "消耗100能量，使出【抓】。用坚硬且无比锋利的爪子抓对手进行攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "slash",
					"sfx": "slash",
					"scale": 0.82
				},
				{
					"name": "龙之怒",
					"desc": "将愤怒的冲击波撞向对手进行攻击。必定会给予40的伤害。",
					"detail": "消耗100能量，使出【龙之怒】。将愤怒的冲击波撞向对手进行攻击。必定会给予40的伤害。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "dragon_breath",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "火焰旋涡",
					"desc": "将对手困在激烈的火焰旋涡中，在４～５回合内进行攻击。",
					"detail": "消耗100能量，爆发【火焰旋涡】！将对手困在激烈的火焰旋涡中，在４～５回合内进行攻击。 对范围内最多3名敌人造成225点伤害，并施加战术压制。",
					"power": 225,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "fire_spin",
					"sfx": "fire",
					"scale": 1.10
				},
				{
					"name": "乱抓",
					"desc": "用爪子或镰刀等抓对手进行攻击。连续攻击２～５次。",
					"detail": "消耗100能量，爆发【乱抓】！用爪子或镰刀等抓对手进行攻击。连续攻击２～５次。 对范围内最多2名敌人造成174点伤害，并施加战术压制。",
					"power": 174,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "headbutt",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "喷射火焰",
					"desc": "向对手发射烈焰进行攻击。有时会让对手陷入灼伤状态。",
					"detail": "消耗100能量，爆发【喷射火焰】！向对手发射烈焰进行攻击。有时会让对手陷入灼伤状态。 对范围内最多3名敌人造成390点伤害，并施加战术压制。",
					"power": 390,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "flamethrower",
					"sfx": "fire",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "炼狱",
					"desc": "用烈焰包裹住对手进行攻击。让对手陷入灼伤状态。",
					"detail": "消耗100能量，释放终极奥义【炼狱】！用烈焰包裹住对手进行攻击。让对手陷入灼伤状态。 席卷战场对最多6名敌人造成680点巨额伤害与强力击破！",
					"power": 680,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "inferno",
					"sfx": "fire",
					"scale": 1.55
				},
				{
					"name": "闪焰冲锋",
					"desc": "让火焰覆盖全身猛撞向对手。自己也会受到不小的伤害。有时会让对手陷入灼伤状态。",
					"detail": "消耗100能量，释放终极奥义【闪焰冲锋】！让火焰覆盖全身猛撞向对手。自己也会受到不小的伤害。有时会让对手陷入灼伤状态。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "flare_blitz",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "爆炸烈焰",
					"desc": "用爆炸的火焰烧尽对手进行攻击。下一回合自己将无法动弹。",
					"detail": "消耗100能量，释放终极奥义【爆炸烈焰】！用爆炸的火焰烧尽对手进行攻击。下一回合自己将无法动弹。 席卷战场对最多6名敌人造成930点巨额伤害与强力击破！",
					"power": 930,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "blast_burn",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/charmander.png"
	},
	"squirtle": {
		"id": "squirtle",
		"name": "杰尼龟",
		"title": "小龟宝可梦",
		"cost": 1,
		"types": ["Water"],
		"hp": 650,
		"atk": 45,
		"armor": 35,
		"mr": 25,
		"range": 1,
		"atk_speed": 0.65,
		"max_mana": 100,
		"skill_name": "水枪",
		"skill_desc": "向对手猛烈地喷射水流进行攻击。",
		"skill_detail": "消耗100能量，使出【水枪】。向对手猛烈地喷射水流进行攻击。 对目标造成182点伤害。",
		"skill_power": 182,
		"basic_attack": {
			"type": "special",
			"name": "水滴弹",
			"style": "water_bullet",
			"sfx": "water"
		},
						"skills": {
			1: [
				{
					"name": "水枪",
					"desc": "向对手猛烈地喷射水流进行攻击。",
					"detail": "消耗100能量，使出【水枪】。向对手猛烈地喷射水流进行攻击。 对目标造成182点伤害。",
					"power": 182,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "water_gun",
					"sfx": "water",
					"scale": 0.28
				},
				{
					"name": "撞击",
					"desc": "用整个身体撞向对手进行攻击。",
					"detail": "消耗100能量，使出【撞击】。用整个身体撞向对手进行攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "tackle",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "泡沫",
					"desc": "向对手用力吹起无数泡泡进行攻击。有时会降低对手的速度。",
					"detail": "消耗100能量，使出【泡沫】。向对手用力吹起无数泡泡进行攻击。有时会降低对手的速度。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "bubble_beam",
					"sfx": "water",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "水之波动",
					"desc": "用水的震动攻击对手。有时会使对手混乱。",
					"detail": "消耗100能量，爆发【水之波动】。用水的震动攻击对手。有时会使对手混乱。 对范围内最多3名敌人造成320点伤害，并施加战术压制。",
					"power": 320,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "water_pulse",
					"sfx": "water",
					"scale": 0.36
				},
				{
					"name": "水流尾",
					"desc": "如惊涛骇浪般挥动大尾巴攻击对手。",
					"detail": "消耗100能量，爆发【水流尾】！如惊涛骇浪般挥动大尾巴攻击对手。 对范围内最多2名敌人造成390点伤害，并施加战术压制。",
					"power": 390,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "aqua_tail",
					"sfx": "water",
					"scale": 1.10
				},
				{
					"name": "咬住",
					"desc": "用尖锐的牙咬住对手进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，爆发【咬住】！用尖锐的牙咬住对手进行攻击。有时会使对手畏缩。 对范围内最多2名敌人造成300点伤害，并施加战术压制。",
					"power": 300,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "bite",
					"sfx": "bite",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "加农水炮",
					"desc": "向对手喷射水炮进行攻击。下一回合自己将无法动弹。",
					"detail": "消耗100能量，释放终极奥义【加农水炮】！向对手喷射水炮进行攻击。下一回合自己将无法动弹。 席卷战场对最多6名敌人造成745点巨额伤害与强力击破！",
					"power": 745,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "hydro_cannon",
					"sfx": "water",
					"scale": 0.48
				},
				{
					"name": "水炮",
					"desc": "向对手猛烈地喷射大量水流进行攻击。",
					"detail": "消耗100能量，释放终极奥义【水炮】！向对手猛烈地喷射大量水流进行攻击。 席卷战场对最多6名敌人造成730点巨额伤害与强力击破！",
					"power": 730,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "hydro_pump",
					"sfx": "water",
					"scale": 1.55
				},
				{
					"name": "百万吨重拳",
					"desc": "用充满力量的拳头攻击对手。",
					"detail": "消耗100能量，释放终极奥义【百万吨重拳】！用充满力量的拳头攻击对手。 席卷战场对最多4名敌人造成580点巨额伤害与强力击破！",
					"power": 580,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "mega_punch",
					"sfx": "punch",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/squirtle.png"
	},
	"bulbasaur": {
		"id": "bulbasaur",
		"name": "妙蛙种子",
		"title": "种子宝可梦",
		"cost": 1,
		"types": ["Grass"],
		"hp": 600,
		"atk": 48,
		"armor": 30,
		"mr": 30,
		"range": 2,
		"atk_speed": 0.65,
		"max_mana": 100,
		"skill_name": "寄生种子",
		"skill_desc": "植入寄生种子后，将在每回合一点一点吸取对手的ＨＰ，从而用来回复自己的ＨＰ。",
		"skill_detail": "消耗100能量，使出【寄生种子】。植入寄生种子后，将在每回合一点一点吸取对手的ＨＰ，从而用来回复自己的ＨＰ。 对目标造成160点伤害。",
		"skill_power": 160,
		"basic_attack": {
			"type": "special",
			"name": "飞叶",
			"style": "leaf",
			"sfx": "swift"
		},
						"skills": {
			1: [
				{
					"name": "寄生种子",
					"desc": "植入寄生种子后，将在每回合一点一点吸取对手的ＨＰ，从而用来回复自己的ＨＰ。",
					"detail": "消耗100能量，使出【寄生种子】。植入寄生种子后，将在每回合一点一点吸取对手的ＨＰ，从而用来回复自己的ＨＰ。 对目标造成160点伤害。",
					"power": 160,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "leech_seed",
					"sfx": "skill",
					"scale": 0.28
				},
				{
					"name": "撞击",
					"desc": "用整个身体撞向对手进行攻击。",
					"detail": "消耗100能量，使出【撞击】。用整个身体撞向对手进行攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "tackle",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "种子炸弹",
					"desc": "将外壳坚硬的大种子，从上方砸下攻击对手。",
					"detail": "消耗100能量，使出【种子炸弹】。将外壳坚硬的大种子，从上方砸下攻击对手。 对目标造成260点伤害。",
					"power": 260,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "seed_bomb",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "飞叶快刀",
					"desc": "飞出叶片，切斩对手进行攻击。容易击中要害。",
					"detail": "消耗100能量，爆发【飞叶快刀】。飞出叶片，切斩对手进行攻击。容易击中要害。 对范围内最多3名敌人造成315点伤害，并施加战术压制。",
					"power": 315,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "razor_leaf",
					"sfx": "slash",
					"scale": 0.36
				},
				{
					"name": "藤鞭",
					"desc": "用如同鞭子般弯曲而细长的藤蔓摔打对手进行攻击。",
					"detail": "消耗100能量，爆发【藤鞭】！用如同鞭子般弯曲而细长的藤蔓摔打对手进行攻击。 对范围内最多2名敌人造成255点伤害，并施加战术压制。",
					"power": 255,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "vine_whip",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "日光束",
					"desc": "第１回合收集满满的日光，第２回合发射光束进行攻击。",
					"detail": "消耗100能量，爆发【日光束】！第１回合收集满满的日光，第２回合发射光束进行攻击。 对范围内最多3名敌人造成480点伤害，并施加战术压制。",
					"power": 480,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "solar_beam",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "疯狂植物",
					"desc": "用大树摔打对手进行攻击。下一回合自己将无法动弹。",
					"detail": "消耗100能量，释放终极奥义【疯狂植物】！用大树摔打对手进行攻击。下一回合自己将无法动弹。 席卷战场对最多6名敌人造成745点巨额伤害与强力击破！",
					"power": 745,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "frenzy_plant",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "强力鞭打",
					"desc": "激烈地挥舞青藤或触手摔打对手进行攻击。",
					"detail": "消耗100能量，释放终极奥义【强力鞭打】！激烈地挥舞青藤或触手摔打对手进行攻击。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "power_whip",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "泰山压顶",
					"desc": "用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，释放终极奥义【泰山压顶】！用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。 席卷战场对最多4名敌人造成605点巨额伤害与强力击破！",
					"power": 605,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/bulbasaur.png"
	},
	"machop": {
		"id": "machop",
		"name": "腕力",
		"title": "怪力宝可梦",
		"cost": 1,
		"types": ["Fighting"],
		"hp": 620,
		"atk": 58,
		"armor": 25,
		"mr": 15,
		"range": 1,
		"atk_speed": 0.75,
		"max_mana": 100,
		"skill_name": "踢倒",
		"skill_desc": "用力踢对手的脚，使其摔倒进行攻击。对手越重，威力越大。",
		"skill_detail": "消耗100能量，使出【踢倒】。用力踢对手的脚，使其摔倒进行攻击。对手越重，威力越大。 对目标造成160点伤害。",
		"skill_power": 160,
		"basic_attack": {
			"type": "physical",
			"name": "连续拳",
			"style": "punch",
			"sfx": "punch"
		},
						"skills": {
			1: [
				{
					"name": "踢倒",
					"desc": "用力踢对手的脚，使其摔倒进行攻击。对手越重，威力越大。",
					"detail": "消耗100能量，使出【踢倒】。用力踢对手的脚，使其摔倒进行攻击。对手越重，威力越大。 对目标造成160点伤害。",
					"power": 160,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "low_kick",
					"sfx": "punch",
					"scale": 0.28
				},
				{
					"name": "地球上投",
					"desc": "利用引力将对手甩飞出去。给予对手和自己等级相同的伤害。",
					"detail": "消耗100能量，使出【地球上投】。利用引力将对手甩飞出去。给予对手和自己等级相同的伤害。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "mega_punch",
					"sfx": "punch",
					"scale": 0.82
				},
				{
					"name": "音速拳",
					"desc": "以迅雷不及掩耳之势出拳。必定能够先制攻击。",
					"detail": "消耗100能量，使出【音速拳】。以迅雷不及掩耳之势出拳。必定能够先制攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "mach_punch",
					"sfx": "punch",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "空手劈",
					"desc": "用锋利的手刀劈向对手进行攻击。容易击中要害。",
					"detail": "消耗100能量，爆发【空手劈】。用锋利的手刀劈向对手进行攻击。容易击中要害。 对范围内最多3名敌人造成310点伤害，并施加战术压制。",
					"power": 310,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "cross_chop",
					"sfx": "punch",
					"scale": 0.36
				},
				{
					"name": "二连击",
					"desc": "使用尾巴等拍打对手进行攻击。连续２次给予伤害。",
					"detail": "消耗100能量，爆发【二连击】！使用尾巴等拍打对手进行攻击。连续２次给予伤害。 对范围内最多2名敌人造成225点伤害，并施加战术压制。",
					"power": 225,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "地狱翻滚",
					"desc": "将对手连同自己一起摔向地面进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，爆发【地狱翻滚】！将对手连同自己一起摔向地面进行攻击。自己也会受到少许伤害。 对范围内最多2名敌人造成360点伤害，并施加战术压制。",
					"power": 360,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "mega_kick",
					"sfx": "punch",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "近身战",
					"desc": "放弃守护，向对手的怀里突击。自己的防御和特防会降低。",
					"detail": "消耗100能量，释放终极奥义【近身战】！放弃守护，向对手的怀里突击。自己的防御和特防会降低。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "close_combat",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "舍身冲撞",
					"desc": "拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。",
					"detail": "消耗100能量，释放终极奥义【舍身冲撞】！拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "double_edge",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "爆裂拳",
					"desc": "使出浑身力气出拳进行攻击。必定会使对手混乱。",
					"detail": "消耗100能量，释放终极奥义【爆裂拳】！使出浑身力气出拳进行攻击。必定会使对手混乱。 席卷战场对最多4名敌人造成680点巨额伤害与强力击破！",
					"power": 680,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "dynamic_punch",
					"sfx": "punch",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/machop.png"
	},
	"pikachu": {
		"id": "pikachu",
		"name": "皮卡丘",
		"title": "鼠宝可梦",
		"cost": 2,
		"types": ["Electric"],
		"hp": 580,
		"atk": 60,
		"armor": 20,
		"mr": 25,
		"range": 3,
		"atk_speed": 0.80,
		"max_mana": 100,
		"skill_name": "电击",
		"skill_desc": "发出电流刺激对手进行攻击。有时会让对手陷入麻痹状态。",
		"skill_detail": "消耗100能量，使出【电击】。发出电流刺激对手进行攻击。有时会让对手陷入麻痹状态。 对目标造成182点伤害。",
		"skill_power": 182,
		"basic_attack": {
			"type": "special",
			"name": "电火花",
			"style": "spark",
			"sfx": "spark"
		},
						"skills": {
			1: [
				{
					"name": "电击",
					"desc": "发出电流刺激对手进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，使出【电击】。发出电流刺激对手进行攻击。有时会让对手陷入麻痹状态。 对目标造成182点伤害。",
					"power": 182,
					"target_count": 1,
					"stun_duration": 0.5,
					"vfx": "thundershock",
					"sfx": "spark",
					"scale": 0.28
				},
				{
					"name": "电光一闪",
					"desc": "以迅雷不及掩耳之势扑向对手。必定能够先制攻击。",
					"detail": "消耗100能量，使出【电光一闪】。以迅雷不及掩耳之势扑向对手。必定能够先制攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "高速星星",
					"desc": "发射星形的光攻击对手。攻击必定会命中。",
					"detail": "消耗100能量，使出【高速星星】。发射星形的光攻击对手。攻击必定会命中。 对目标造成220点伤害。",
					"power": 220,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "swift",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "十万伏特",
					"desc": "向对手发出强力电击进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，爆发【十万伏特】。向对手发出强力电击进行攻击。有时会让对手陷入麻痹状态。 对范围内最多3名敌人造成350点伤害，并施加战术压制。",
					"power": 350,
					"target_count": 3,
					"stun_duration": 0.8,
					"vfx": "thunderbolt",
					"sfx": "thunder",
					"scale": 0.36
				},
				{
					"name": "打雷",
					"desc": "向对手劈下暴雷进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，爆发【打雷】！向对手劈下暴雷进行攻击。有时会让对手陷入麻痹状态。 对范围内最多3名敌人造成450点伤害，并施加战术压制。",
					"power": 450,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "thunder",
					"sfx": "thunder",
					"scale": 1.10
				},
				{
					"name": "放电",
					"desc": "用耀眼的电击攻击自己周围所有的宝可梦。有时会陷入麻痹状态。",
					"detail": "消耗100能量，爆发【放电】！用耀眼的电击攻击自己周围所有的宝可梦。有时会陷入麻痹状态。 对范围内最多3名敌人造成360点伤害，并施加战术压制。",
					"power": 360,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "discharge",
					"sfx": "thunder",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "千万伏特",
					"desc": "戴着帽子的皮卡丘将通过Ｚ力量增强的电击全力释放给对手。容易击中要害。",
					"detail": "消耗100能量，释放终极奥义【千万伏特】！戴着帽子的皮卡丘将通过Ｚ力量增强的电击全力释放给对手。容易击中要害。 席卷战场对最多6名敌人造成812点巨额伤害与强力击破！",
					"power": 812,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "volt_catastrophe",
					"sfx": "thunder",
					"scale": 0.48
				},
				{
					"name": "百万吨重拳",
					"desc": "用充满力量的拳头攻击对手。",
					"detail": "消耗100能量，释放终极奥义【百万吨重拳】！用充满力量的拳头攻击对手。 席卷战场对最多4名敌人造成580点巨额伤害与强力击破！",
					"power": 580,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "mega_punch",
					"sfx": "punch",
					"scale": 1.55
				},
				{
					"name": "疯狂伏特",
					"desc": "让电流覆盖全身，撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，释放终极奥义【疯狂伏特】！让电流覆盖全身，撞向对手进行攻击。自己也会受到少许伤害。 席卷战场对最多4名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "spark",
					"sfx": "thunder",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/pikachu.png"
	},
	"gengar": {
		"id": "gengar",
		"name": "耿鬼",
		"title": "影子宝可梦",
		"cost": 3,
		"types": ["Ghost", "Psychic"],
		"hp": 700,
		"atk": 65,
		"armor": 25,
		"mr": 35,
		"range": 3,
		"atk_speed": 0.75,
		"max_mana": 100,
		"skill_name": "暗影拳",
		"skill_desc": "使出混影之拳。攻击必定会命中。",
		"skill_detail": "消耗100能量，使出【暗影拳】。使出混影之拳。攻击必定会命中。 对目标造成198点伤害。",
		"skill_power": 198,
		"basic_attack": {
			"type": "special",
			"name": "暗影弹",
			"style": "shadow_orb",
			"sfx": "swift"
		},
						"skills": {
			1: [
				{
					"name": "暗影拳",
					"desc": "使出混影之拳。攻击必定会命中。",
					"detail": "消耗100能量，使出【暗影拳】。使出混影之拳。攻击必定会命中。 对目标造成198点伤害。",
					"power": 198,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "shadow_punch",
					"sfx": "punch",
					"scale": 0.28
				},
				{
					"name": "黑夜魔影",
					"desc": "显示恐怖幻影，只给予对手和自己等级相同的伤害。",
					"detail": "消耗100能量，使出【黑夜魔影】。显示恐怖幻影，只给予对手和自己等级相同的伤害。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "night_shade",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "突袭",
					"desc": "可以比对手先攻击。对手使出的招式如果不是攻击招式则会失败。",
					"detail": "消耗100能量，使出【突袭】。可以比对手先攻击。对手使出的招式如果不是攻击招式则会失败。 对目标造成240点伤害。",
					"power": 240,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "mach_punch",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "暗影球",
					"desc": "投掷一团黑影进行攻击。有时会降低对手的特防。",
					"detail": "消耗100能量，爆发【暗影球】。投掷一团黑影进行攻击。有时会降低对手的特防。 对范围内最多3名敌人造成340点伤害，并施加战术压制。",
					"power": 340,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "shadow_ball",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "毒液冲击",
					"desc": "将特殊的毒液泼向对手。对处于中毒状态的对手，威力会变成２倍。",
					"detail": "消耗100能量，爆发【毒液冲击】！将特殊的毒液泼向对手。对处于中毒状态的对手，威力会变成２倍。 对范围内最多3名敌人造成315点伤害，并施加战术压制。",
					"power": 315,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "poison_sting",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "恶之波动",
					"desc": "从体内发出充满恶意的恐怖气场。有时会使对手畏缩。",
					"detail": "消耗100能量，爆发【恶之波动】！从体内发出充满恶意的恐怖气场。有时会使对手畏缩。 对范围内最多3名敌人造成360点伤害，并施加战术压制。",
					"power": 360,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "dark_pulse",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "祸不单行",
					"desc": "接二连三地进行攻击。对处于异常状态的对手给予较大的伤害。",
					"detail": "消耗100能量，释放终极奥义【祸不单行】！接二连三地进行攻击。对处于异常状态的对手给予较大的伤害。 席卷战场对最多6名敌人造成617点巨额伤害与强力击破！",
					"power": 617,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "hex_nightmare",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "催眠术",
					"desc": "施以诱导睡意的暗示，让对手陷入睡眠状态。",
					"detail": "消耗100能量，释放终极奥义【催眠术】！施以诱导睡意的暗示，让对手陷入睡眠状态。 席卷战场对最多6名敌人造成680点巨额伤害与强力击破！",
					"power": 680,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "hypnosis",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "同命",
					"desc": "使出招式后，当受到对手攻击陷入濒死时，对手也会一同濒死。连续使出则会失败。",
					"detail": "消耗100能量，释放终极奥义【同命】！使出招式后，当受到对手攻击陷入濒死时，对手也会一同濒死。连续使出则会失败。 席卷战场对最多6名敌人造成680点巨额伤害与强力击破！",
					"power": 680,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "lick",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/gengar.png"
	},
	"snorlax": {
		"id": "snorlax",
		"name": "卡比兽",
		"title": "嗜睡宝可梦",
		"cost": 3,
		"types": ["Normal"],
		"hp": 1100,
		"atk": 62,
		"armor": 45,
		"mr": 40,
		"range": 1,
		"atk_speed": 0.55,
		"max_mana": 100,
		"skill_name": "舌舔",
		"skill_desc": "用长长的舌头，舔遍对手进行攻击。有时会让对手陷入麻痹状态。",
		"skill_detail": "消耗100能量，使出【舌舔】。用长长的舌头，舔遍对手进行攻击。有时会让对手陷入麻痹状态。 对目标造成174点伤害。",
		"skill_power": 174,
		"basic_attack": {
			"type": "physical",
			"name": "连续拳",
			"style": "punch",
			"sfx": "punch"
		},
						"skills": {
			1: [
				{
					"name": "舌舔",
					"desc": "用长长的舌头，舔遍对手进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，使出【舌舔】。用长长的舌头，舔遍对手进行攻击。有时会让对手陷入麻痹状态。 对目标造成174点伤害。",
					"power": 174,
					"target_count": 1,
					"stun_duration": 0.5,
					"vfx": "lick",
					"sfx": "skill",
					"scale": 0.28
				},
				{
					"name": "头锤",
					"desc": "将头伸出，笔直地扑向对手进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，使出【头锤】。将头伸出，笔直地扑向对手进行攻击。有时会使对手畏缩。 对目标造成240点伤害。",
					"power": 240,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "headbutt",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "打鼾",
					"desc": "在自己睡觉时，发出噪音进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，使出【打鼾】。在自己睡觉时，发出噪音进行攻击。有时会使对手畏缩。 对目标造成200点伤害。",
					"power": 200,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "tackle",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "泰山压顶",
					"desc": "用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，爆发【泰山压顶】。用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。 对范围内最多3名敌人造成345点伤害，并施加战术压制。",
					"power": 345,
					"target_count": 3,
					"stun_duration": 0.8,
					"vfx": "body_slam",
					"sfx": "attack",
					"scale": 0.36
				},
				{
					"name": "瞬间失忆",
					"desc": "将头脑清空，瞬间忘记某事，从而大幅提高自己的特防。",
					"detail": "消耗100能量，爆发【瞬间失忆】！将头脑清空，瞬间忘记某事，从而大幅提高自己的特防。 对范围内最多3名敌人造成320点伤害，并施加战术压制。",
					"power": 320,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "rest",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "十万马力",
					"desc": "使出全身力量，猛攻对手。",
					"detail": "消耗100能量，爆发【十万马力】！使出全身力量，猛攻对手。 对范围内最多2名敌人造成405点伤害，并施加战术压制。",
					"power": 405,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "earthquake",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "终极冲击",
					"desc": "使出自己浑身力量突击对手。下一回合自己将无法动弹。",
					"detail": "消耗100能量，释放终极奥义【终极冲击】！使出自己浑身力量突击对手。下一回合自己将无法动弹。 席卷战场对最多6名敌人造成745点巨额伤害与强力击破！",
					"power": 745,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "giga_impact",
					"sfx": "attack",
					"scale": 0.48
				},
				{
					"name": "舍身冲撞",
					"desc": "拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。",
					"detail": "消耗100能量，释放终极奥义【舍身冲撞】！拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "double_edge",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "蛮力",
					"desc": "发挥惊人的力量攻击对手。自己的攻击和防御会降低。",
					"detail": "消耗100能量，释放终极奥义【蛮力】！发挥惊人的力量攻击对手。自己的攻击和防御会降低。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "mega_punch",
					"sfx": "punch",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/snorlax.png"
	},
	"alakazam": {
		"id": "alakazam",
		"name": "胡地",
		"title": "念力宝可梦",
		"cost": 4,
		"types": ["Psychic"],
		"hp": 680,
		"atk": 75,
		"armor": 20,
		"mr": 50,
		"range": 4,
		"atk_speed": 0.80,
		"max_mana": 100,
		"skill_name": "精神利刃",
		"skill_desc": "用实体化的心之利刃劈开对手。容易击中要害。",
		"skill_detail": "消耗100能量，使出【精神利刃】。用实体化的心之利刃劈开对手。容易击中要害。 对目标造成206点伤害。",
		"skill_power": 206,
		"basic_attack": {
			"type": "special",
			"name": "念力波",
			"style": "psywave",
			"sfx": "swift"
		},
						"skills": {
			1: [
				{
					"name": "精神利刃",
					"desc": "用实体化的心之利刃劈开对手。容易击中要害。",
					"detail": "消耗100能量，使出【精神利刃】。用实体化的心之利刃劈开对手。容易击中要害。 对目标造成206点伤害。",
					"power": 206,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "psycho_cut",
					"sfx": "slash",
					"scale": 0.28
				},
				{
					"name": "念力",
					"desc": "向对手发送微弱的念力进行攻击。有时会使对手混乱。",
					"detail": "消耗100能量，使出【念力】。向对手发送微弱的念力进行攻击。有时会使对手混乱。 对目标造成200点伤害。",
					"power": 200,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "confusion",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "黑夜魔影",
					"desc": "显示恐怖幻影，只给予对手和自己等级相同的伤害。",
					"detail": "消耗100能量，使出【黑夜魔影】。显示恐怖幻影，只给予对手和自己等级相同的伤害。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "night_shade",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "精神强念",
					"desc": "向对手发送强大的念力进行攻击。有时会降低对手的特防。",
					"detail": "消耗100能量，爆发【精神强念】。向对手发送强大的念力进行攻击。有时会降低对手的特防。 对范围内最多3名敌人造成350点伤害，并施加战术压制。",
					"power": 350,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "psychic",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "百万吨重拳",
					"desc": "用充满力量的拳头攻击对手。",
					"detail": "消耗100能量，爆发【百万吨重拳】！用充满力量的拳头攻击对手。 对范围内最多2名敌人造成360点伤害，并施加战术压制。",
					"power": 360,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "mega_punch",
					"sfx": "punch",
					"scale": 1.10
				},
				{
					"name": "精神冲击",
					"desc": "将神奇的念波实体化攻击对手。给予物理伤害。",
					"detail": "消耗100能量，爆发【精神冲击】！将神奇的念波实体化攻击对手。给予物理伤害。 对范围内最多3名敌人造成360点伤害，并施加战术压制。",
					"power": 360,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "psystrike",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "预知未来",
					"desc": "在使用招式２回合后，向对手发送一团念力进行攻击。",
					"detail": "消耗100能量，释放终极奥义【预知未来】！在使用招式２回合后，向对手发送一团念力进行攻击。 席卷战场对最多6名敌人造成700点巨额伤害与强力击破！",
					"power": 700,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "future_sight",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "百万吨重踢",
					"desc": "使出力大无穷的重踢踢飞对手进行攻击。",
					"detail": "消耗100能量，释放终极奥义【百万吨重踢】！使出力大无穷的重踢踢飞对手进行攻击。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "mega_kick",
					"sfx": "punch",
					"scale": 1.55
				},
				{
					"name": "泰山压顶",
					"desc": "用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，释放终极奥义【泰山压顶】！用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。 席卷战场对最多4名敌人造成605点巨额伤害与强力击破！",
					"power": 605,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/alakazam.png"
	},
	"charizard": {
		"id": "charizard",
		"name": "喷火龙",
		"title": "火焰宝可梦",
		"cost": 4,
		"types": ["Fire", "Dragon"],
		"hp": 900,
		"atk": 82,
		"armor": 35,
		"mr": 35,
		"range": 2,
		"atk_speed": 0.75,
		"max_mana": 100,
		"skill_name": "喷射火焰",
		"skill_desc": "向对手发射烈焰进行攻击。有时会让对手陷入灼伤状态。",
		"skill_detail": "消耗100能量，使出【喷射火焰】。向对手发射烈焰进行攻击。有时会让对手陷入灼伤状态。 对目标造成222点伤害。",
		"skill_power": 222,
		"basic_attack": {
			"type": "special",
			"name": "火花",
			"style": "fire_ember",
			"sfx": "fire"
		},
						"skills": {
			1: [
				{
					"name": "喷射火焰",
					"desc": "向对手发射烈焰进行攻击。有时会让对手陷入灼伤状态。",
					"detail": "消耗100能量，使出【喷射火焰】。向对手发射烈焰进行攻击。有时会让对手陷入灼伤状态。 对目标造成222点伤害。",
					"power": 222,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "flamethrower",
					"sfx": "fire",
					"scale": 0.28
				},
				{
					"name": "翅膀攻击",
					"desc": "大大地展开美丽的翅膀，将其撞向对手进行攻击。",
					"detail": "消耗100能量，使出【翅膀攻击】。大大地展开美丽的翅膀，将其撞向对手进行攻击。 对目标造成220点伤害。",
					"power": 220,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "wing_attack",
					"sfx": "slash",
					"scale": 0.82
				},
				{
					"name": "乱抓",
					"desc": "用爪子或镰刀等抓对手进行攻击。连续攻击２～５次。",
					"detail": "消耗100能量，使出【乱抓】。用爪子或镰刀等抓对手进行攻击。连续攻击２～５次。 对目标造成136点伤害。",
					"power": 136,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "slash",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "大字爆炎",
					"desc": "用大字形状的火焰烧尽对手。有时会让对手陷入灼伤状态。",
					"detail": "消耗100能量，爆发【大字爆炎】。用大字形状的火焰烧尽对手。有时会让对手陷入灼伤状态。 对范围内最多3名敌人造成370点伤害，并施加战术压制。",
					"power": 370,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "fire_blast",
					"sfx": "fire",
					"scale": 0.36
				},
				{
					"name": "火焰牙",
					"desc": "用覆盖着火焰的牙齿咬住对手。有时会使对手畏缩或陷入灼伤状态。",
					"detail": "消耗100能量，爆发【火焰牙】！用覆盖着火焰的牙齿咬住对手。有时会使对手畏缩或陷入灼伤状态。 对范围内最多2名敌人造成315点伤害，并施加战术压制。",
					"power": 315,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "fire_fang",
					"sfx": "fire",
					"scale": 1.10
				},
				{
					"name": "火焰旋涡",
					"desc": "将对手困在激烈的火焰旋涡中，在４～５回合内进行攻击。",
					"detail": "消耗100能量，爆发【火焰旋涡】！将对手困在激烈的火焰旋涡中，在４～５回合内进行攻击。 对范围内最多3名敌人造成225点伤害，并施加战术压制。",
					"power": 225,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "fire_spin",
					"sfx": "fire",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "爆炸烈焰",
					"desc": "用爆炸的火焰烧尽对手进行攻击。下一回合自己将无法动弹。",
					"detail": "消耗100能量，释放终极奥义【爆炸烈焰】！用爆炸的火焰烧尽对手进行攻击。下一回合自己将无法动弹。 席卷战场对最多6名敌人造成745点巨额伤害与强力击破！",
					"power": 745,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "blast_burn",
					"sfx": "fire",
					"scale": 0.48
				},
				{
					"name": "烈焰溅射",
					"desc": "如果击中，爆裂的火焰会攻击到对手。爆裂出的火焰还会飞溅到旁边的对手。",
					"detail": "消耗100能量，释放终极奥义【烈焰溅射】！如果击中，爆裂的火焰会攻击到对手。爆裂出的火焰还会飞溅到旁边的对手。 席卷战场对最多6名敌人造成530点巨额伤害与强力击破！",
					"power": 530,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "ember",
					"sfx": "fire",
					"scale": 1.55
				},
				{
					"name": "炼狱",
					"desc": "用烈焰包裹住对手进行攻击。让对手陷入灼伤状态。",
					"detail": "消耗100能量，释放终极奥义【炼狱】！用烈焰包裹住对手进行攻击。让对手陷入灼伤状态。 席卷战场对最多6名敌人造成680点巨额伤害与强力击破！",
					"power": 680,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "inferno",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/charizard.png"
	},
	"gyarados": {
		"id": "gyarados",
		"name": "暴鲤龙",
		"title": "凶恶宝可梦",
		"cost": 4,
		"types": ["Water", "Dragon"],
		"hp": 980,
		"atk": 85,
		"armor": 40,
		"mr": 35,
		"range": 1,
		"atk_speed": 0.70,
		"max_mana": 100,
		"skill_name": "咬住",
		"skill_desc": "用尖锐的牙咬住对手进行攻击。有时会使对手畏缩。",
		"skill_detail": "消耗100能量，使出【咬住】。用尖锐的牙咬住对手进行攻击。有时会使对手畏缩。 对目标造成198点伤害。",
		"skill_power": 198,
		"basic_attack": {
			"type": "physical",
			"name": "咬住",
			"style": "bite",
			"sfx": "bite"
		},
						"skills": {
			1: [
				{
					"name": "咬住",
					"desc": "用尖锐的牙咬住对手进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，使出【咬住】。用尖锐的牙咬住对手进行攻击。有时会使对手畏缩。 对目标造成198点伤害。",
					"power": 198,
					"target_count": 1,
					"stun_duration": 0.5,
					"vfx": "bite",
					"sfx": "bite",
					"scale": 0.28
				},
				{
					"name": "水之波动",
					"desc": "用水的震动攻击对手。有时会使对手混乱。",
					"detail": "消耗100能量，使出【水之波动】。用水的震动攻击对手。有时会使对手混乱。 对目标造成220点伤害。",
					"power": 220,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "water_pulse",
					"sfx": "water",
					"scale": 0.82
				},
				{
					"name": "咬碎",
					"desc": "用利牙咬碎对手进行攻击。有时会降低对手的防御。",
					"detail": "消耗100能量，使出【咬碎】。用利牙咬碎对手进行攻击。有时会降低对手的防御。 对目标造成260点伤害。",
					"power": 260,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "crunch",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "攀瀑",
					"desc": "以惊人的气势扑向对手。有时会使对手畏缩。",
					"detail": "消耗100能量，爆发【攀瀑】。以惊人的气势扑向对手。有时会使对手畏缩。 对范围内最多3名敌人造成340点伤害，并施加战术压制。",
					"power": 340,
					"target_count": 3,
					"stun_duration": 0.8,
					"vfx": "aqua_tail",
					"sfx": "water",
					"scale": 0.36
				},
				{
					"name": "愤怒",
					"desc": "如果在使出招式后受到攻击的话，会因愤怒的力量而提高攻击。",
					"detail": "消耗100能量，爆发【愤怒】！如果在使出招式后受到攻击的话，会因愤怒的力量而提高攻击。 对范围内最多2名敌人造成180点伤害，并施加战术压制。",
					"power": 180,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "暴风",
					"desc": "用强烈的风席卷对手进行攻击。有时会使对手混乱。",
					"detail": "消耗100能量，爆发【暴风】！用强烈的风席卷对手进行攻击。有时会使对手混乱。 对范围内最多3名敌人造成450点伤害，并施加战术压制。",
					"power": 450,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "twister",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "破坏光线",
					"desc": "向对手发射强烈的光线进行攻击。下一回合自己将无法动弹。",
					"detail": "消耗100能量，释放终极奥义【破坏光线】！向对手发射强烈的光线进行攻击。下一回合自己将无法动弹。 席卷战场对最多6名敌人造成745点巨额伤害与强力击破！",
					"power": 745,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "hyper_beam",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "水炮",
					"desc": "向对手猛烈地喷射大量水流进行攻击。",
					"detail": "消耗100能量，释放终极奥义【水炮】！向对手猛烈地喷射大量水流进行攻击。 席卷战场对最多6名敌人造成730点巨额伤害与强力击破！",
					"power": 730,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "hydro_pump",
					"sfx": "water",
					"scale": 1.55
				},
				{
					"name": "逆鳞",
					"desc": "在２～３回合内，乱打一气地进行攻击。大闹一番后自己会陷入混乱。",
					"detail": "消耗100能量，释放终极奥义【逆鳞】！在２～３回合内，乱打一气地进行攻击。大闹一番后自己会陷入混乱。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "dragon_apocalypse",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/gyarados.png"
	},
	"dragonite": {
		"id": "dragonite",
		"name": "快龙",
		"title": "龙宝可梦",
		"cost": 5,
		"types": ["Dragon"],
		"hp": 1150,
		"atk": 95,
		"armor": 45,
		"mr": 45,
		"range": 2,
		"atk_speed": 0.80,
		"max_mana": 100,
		"skill_name": "龙爪",
		"skill_desc": "用尖锐的巨爪劈开对手进行攻击。",
		"skill_detail": "消耗100能量，使出【龙爪】。用尖锐的巨爪劈开对手进行攻击。 对目标造成214点伤害。",
		"skill_power": 214,
		"basic_attack": {
			"type": "physical",
			"name": "撞击",
			"style": "tackle",
			"sfx": "attack"
		},
						"skills": {
			1: [
				{
					"name": "龙爪",
					"desc": "用尖锐的巨爪劈开对手进行攻击。",
					"detail": "消耗100能量，使出【龙爪】。用尖锐的巨爪劈开对手进行攻击。 对目标造成214点伤害。",
					"power": 214,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "dragon_claw",
					"sfx": "slash",
					"scale": 0.28
				},
				{
					"name": "翅膀攻击",
					"desc": "大大地展开美丽的翅膀，将其撞向对手进行攻击。",
					"detail": "消耗100能量，使出【翅膀攻击】。大大地展开美丽的翅膀，将其撞向对手进行攻击。 对目标造成220点伤害。",
					"power": 220,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "wing_attack",
					"sfx": "slash",
					"scale": 0.82
				},
				{
					"name": "摔打",
					"desc": "使用长长的尾巴或藤蔓等摔打对手进行攻击。",
					"detail": "消耗100能量，使出【摔打】。使用长长的尾巴或藤蔓等摔打对手进行攻击。 对目标造成260点伤害。",
					"power": 260,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "龙之波动",
					"desc": "从大大的口中掀起冲击波攻击对手。",
					"detail": "消耗100能量，爆发【龙之波动】。从大大的口中掀起冲击波攻击对手。 对范围内最多3名敌人造成345点伤害，并施加战术压制。",
					"power": 345,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "dragon_pulse",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "龙之怒",
					"desc": "将愤怒的冲击波撞向对手进行攻击。必定会给予40的伤害。",
					"detail": "消耗100能量，爆发【龙之怒】！将愤怒的冲击波撞向对手进行攻击。必定会给予40的伤害。 对范围内最多3名敌人造成320点伤害，并施加战术压制。",
					"power": 320,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "dragon_breath",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "破坏光线",
					"desc": "向对手发射强烈的光线进行攻击。下一回合自己将无法动弹。",
					"detail": "消耗100能量，爆发【破坏光线】！向对手发射强烈的光线进行攻击。下一回合自己将无法动弹。 对范围内最多3名敌人造成570点伤害，并施加战术压制。",
					"power": 570,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "hyper_beam",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "流星群",
					"desc": "从天空中向对手落下陨石。使用之后因为反作用力，自己的特攻会大幅降低。",
					"detail": "消耗100能量，释放终极奥义【流星群】！从天空中向对手落下陨石。使用之后因为反作用力，自己的特攻会大幅降低。 席卷战场对最多6名敌人造成715点巨额伤害与强力击破！",
					"power": 715,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "draco_meteor",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "水流尾",
					"desc": "如惊涛骇浪般挥动大尾巴攻击对手。",
					"detail": "消耗100能量，释放终极奥义【水流尾】！如惊涛骇浪般挥动大尾巴攻击对手。 席卷战场对最多4名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "aqua_tail",
					"sfx": "water",
					"scale": 1.55
				},
				{
					"name": "泰山压顶",
					"desc": "用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，释放终极奥义【泰山压顶】！用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。 席卷战场对最多4名敌人造成605点巨额伤害与强力击破！",
					"power": 605,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/dragonite.png"
	},
	"mewtwo": {
		"id": "mewtwo",
		"name": "超梦",
		"title": "基因宝可梦",
		"cost": 5,
		"types": ["Psychic"],
		"hp": 1050,
		"atk": 100,
		"armor": 35,
		"mr": 50,
		"range": 3,
		"atk_speed": 0.85,
		"max_mana": 100,
		"skill_name": "念力",
		"skill_desc": "向对手发送微弱的念力进行攻击。有时会使对手混乱。",
		"skill_detail": "消耗100能量，使出【念力】。向对手发送微弱的念力进行攻击。有时会使对手混乱。 对目标造成190点伤害。",
		"skill_power": 190,
		"basic_attack": {
			"type": "special",
			"name": "念力波",
			"style": "psywave",
			"sfx": "swift"
		},
						"skills": {
			1: [
				{
					"name": "念力",
					"desc": "向对手发送微弱的念力进行攻击。有时会使对手混乱。",
					"detail": "消耗100能量，使出【念力】。向对手发送微弱的念力进行攻击。有时会使对手混乱。 对目标造成190点伤害。",
					"power": 190,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "confusion",
					"sfx": "skill",
					"scale": 0.28
				},
				{
					"name": "高速星星",
					"desc": "发射星形的光攻击对手。攻击必定会命中。",
					"detail": "消耗100能量，使出【高速星星】。发射星形的光攻击对手。攻击必定会命中。 对目标造成220点伤害。",
					"power": 220,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "swift",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "幻象光线",
					"desc": "向对手发射神奇的光线进行攻击。有时会使对手混乱。",
					"detail": "消耗100能量，使出【幻象光线】。向对手发射神奇的光线进行攻击。有时会使对手混乱。 对目标造成230点伤害。",
					"power": 230,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "psybeam",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "精神强念",
					"desc": "向对手发送强大的念力进行攻击。有时会降低对手的特防。",
					"detail": "消耗100能量，爆发【精神强念】。向对手发送强大的念力进行攻击。有时会降低对手的特防。 对范围内最多3名敌人造成350点伤害，并施加战术压制。",
					"power": 350,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "psychic",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "瞬间失忆",
					"desc": "将头脑清空，瞬间忘记某事，从而大幅提高自己的特防。",
					"detail": "消耗100能量，爆发【瞬间失忆】！将头脑清空，瞬间忘记某事，从而大幅提高自己的特防。 对范围内最多3名敌人造成320点伤害，并施加战术压制。",
					"power": 320,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "rest",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "波导弹",
					"desc": "从体内产生出波导之力，然后向对手发出。攻击必定会命中。",
					"detail": "消耗100能量，爆发【波导弹】！从体内产生出波导之力，然后向对手发出。攻击必定会命中。 对范围内最多3名敌人造成360点伤害，并施加战术压制。",
					"power": 360,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "aura_sphere",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "精神击破",
					"desc": "将神奇的念波实体化攻击对手。给予物理伤害。",
					"detail": "消耗100能量，释放终极奥义【精神击破】！将神奇的念波实体化攻击对手。给予物理伤害。 席卷战场对最多6名敌人造成670点巨额伤害与强力击破！",
					"power": 670,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "psystrike",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "百万吨重拳",
					"desc": "用充满力量的拳头攻击对手。",
					"detail": "消耗100能量，释放终极奥义【百万吨重拳】！用充满力量的拳头攻击对手。 席卷战场对最多4名敌人造成580点巨额伤害与强力击破！",
					"power": 580,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "mega_punch",
					"sfx": "punch",
					"scale": 1.55
				},
				{
					"name": "预知未来",
					"desc": "在使用招式２回合后，向对手发送一团念力进行攻击。",
					"detail": "消耗100能量，释放终极奥义【预知未来】！在使用招式２回合后，向对手发送一团念力进行攻击。 席卷战场对最多6名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "future_sight",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/mewtwo.png"
	},
	"eevee": {
		"id": "eevee",
		"name": "伊布",
		"title": "进化宝可梦",
		"cost": 2,
		"types": ["Normal"],
		"hp": 600,
		"atk": 58,
		"armor": 25,
		"mr": 25,
		"range": 3,
		"atk_speed": 0.78,
		"max_mana": 90,
		"skill_name": "高速星星",
		"skill_desc": "发射星形的光攻击对手。攻击必定会命中。",
		"skill_detail": "消耗100能量，使出【高速星星】。发射星形的光攻击对手。攻击必定会命中。 对目标造成198点伤害。",
		"skill_power": 198,
		"basic_attack": {
			"type": "special",
			"name": "魔法弹",
			"style": "spark",
			"sfx": "swift"
		},
						"skills": {
			1: [
				{
					"name": "高速星星",
					"desc": "发射星形的光攻击对手。攻击必定会命中。",
					"detail": "消耗100能量，使出【高速星星】。发射星形的光攻击对手。攻击必定会命中。 对目标造成198点伤害。",
					"power": 198,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "swift",
					"sfx": "swift",
					"scale": 0.28
				},
				{
					"name": "撞击",
					"desc": "用整个身体撞向对手进行攻击。",
					"detail": "消耗100能量，使出【撞击】。用整个身体撞向对手进行攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "tackle",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "咬住",
					"desc": "用尖锐的牙咬住对手进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，使出【咬住】。用尖锐的牙咬住对手进行攻击。有时会使对手畏缩。 对目标造成220点伤害。",
					"power": 220,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "bite",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，爆发【猛撞】。以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 对范围内最多3名敌人造成350点伤害，并施加战术压制。",
					"power": 350,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "take_down",
					"sfx": "attack",
					"scale": 0.36
				},
				{
					"name": "舍身冲撞",
					"desc": "拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。",
					"detail": "消耗100能量，爆发【舍身冲撞】！拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。 对范围内最多2名敌人造成480点伤害，并施加战术压制。",
					"power": 480,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "double_edge",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "电光一闪",
					"desc": "以迅雷不及掩耳之势扑向对手。必定能够先制攻击。",
					"detail": "消耗100能量，爆发【电光一闪】！以迅雷不及掩耳之势扑向对手。必定能够先制攻击。 对范围内最多2名敌人造成240点伤害，并施加战术压制。",
					"power": 240,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "九彩升华齐聚顶",
					"desc": "得到Ｚ力量的伊布将借助进化后伙伴们的力量，大幅提高能力。",
					"detail": "消耗100能量，释放终极奥义【九彩升华齐聚顶】！得到Ｚ力量的伊布将借助进化后伙伴们的力量，大幅提高能力。 席卷战场对最多6名敌人造成600点巨额伤害与强力击破！",
					"power": 600,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "extreme_evoboost",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "珍藏",
					"desc": "当战斗中已学会的招式全部使用过后，才能开始使出珍藏的招式。",
					"detail": "消耗100能量，释放终极奥义【珍藏】！当战斗中已学会的招式全部使用过后，才能开始使出珍藏的招式。 席卷战场对最多4名敌人造成880点巨额伤害与强力击破！",
					"power": 880,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "giga_impact",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "泰山压顶",
					"desc": "用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，释放终极奥义【泰山压顶】！用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。 席卷战场对最多4名敌人造成605点巨额伤害与强力击破！",
					"power": 605,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/eevee.png"
	},
	"growlithe": {
		"id": "growlithe",
		"name": "卡蒂狗",
		"title": "小狗宝可梦",
		"cost": 2,
		"types": ["Fire"],
		"hp": 700,
		"atk": 62,
		"armor": 30,
		"mr": 20,
		"range": 1,
		"atk_speed": 0.75,
		"max_mana": 100,
		"skill_name": "火花",
		"skill_desc": "向对手发射小型火焰进行攻击。有时会让对手陷入灼伤状态。",
		"skill_detail": "消耗100能量，使出【火花】。向对手发射小型火焰进行攻击。有时会让对手陷入灼伤状态。 对目标造成182点伤害。",
		"skill_power": 182,
		"basic_attack": {
			"type": "physical",
			"name": "咬住",
			"style": "bite",
			"sfx": "bite"
		},
						"skills": {
			1: [
				{
					"name": "火花",
					"desc": "向对手发射小型火焰进行攻击。有时会让对手陷入灼伤状态。",
					"detail": "消耗100能量，使出【火花】。向对手发射小型火焰进行攻击。有时会让对手陷入灼伤状态。 对目标造成182点伤害。",
					"power": 182,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "ember",
					"sfx": "fire",
					"scale": 0.28
				},
				{
					"name": "咬住",
					"desc": "用尖锐的牙咬住对手进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，使出【咬住】。用尖锐的牙咬住对手进行攻击。有时会使对手畏缩。 对目标造成220点伤害。",
					"power": 220,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "bite",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "火焰牙",
					"desc": "用覆盖着火焰的牙齿咬住对手。有时会使对手畏缩或陷入灼伤状态。",
					"detail": "消耗100能量，使出【火焰牙】。用覆盖着火焰的牙齿咬住对手。有时会使对手畏缩或陷入灼伤状态。 对目标造成230点伤害。",
					"power": 230,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "fire_fang",
					"sfx": "fire",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "火焰轮",
					"desc": "让火焰覆盖全身，猛撞向对手进行攻击。有时会让对手陷入灼伤状态。",
					"detail": "消耗100能量，爆发【火焰轮】。让火焰覆盖全身，猛撞向对手进行攻击。有时会让对手陷入灼伤状态。 对范围内最多3名敌人造成320点伤害，并施加战术压制。",
					"power": 320,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "flame_wheel",
					"sfx": "fire",
					"scale": 0.36
				},
				{
					"name": "起死回生",
					"desc": "竭尽全力进行攻击。自己的ＨＰ越少，招式的威力越大。",
					"detail": "消耗100能量，爆发【起死回生】！竭尽全力进行攻击。自己的ＨＰ越少，招式的威力越大。 对范围内最多2名敌人造成320点伤害，并施加战术压制。",
					"power": 320,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "low_kick",
					"sfx": "punch",
					"scale": 1.10
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，爆发【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 对范围内最多2名敌人造成390点伤害，并施加战术压制。",
					"power": 390,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "闪焰冲锋",
					"desc": "让火焰覆盖全身猛撞向对手。自己也会受到不小的伤害。有时会让对手陷入灼伤状态。",
					"detail": "消耗100能量，释放终极奥义【闪焰冲锋】！让火焰覆盖全身猛撞向对手。自己也会受到不小的伤害。有时会让对手陷入灼伤状态。 席卷战场对最多6名敌人造成700点巨额伤害与强力击破！",
					"power": 700,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "flare_blitz",
					"sfx": "fire",
					"scale": 0.48
				},
				{
					"name": "嬉闹",
					"desc": "与对手嬉闹并攻击。有时会降低对手的攻击。",
					"detail": "消耗100能量，释放终极奥义【嬉闹】！与对手嬉闹并攻击。有时会降低对手的攻击。 席卷战场对最多4名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "爆炸烈焰",
					"desc": "用爆炸的火焰烧尽对手进行攻击。下一回合自己将无法动弹。",
					"detail": "消耗100能量，释放终极奥义【爆炸烈焰】！用爆炸的火焰烧尽对手进行攻击。下一回合自己将无法动弹。 席卷战场对最多6名敌人造成930点巨额伤害与强力击破！",
					"power": 930,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "blast_burn",
					"sfx": "fire",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/growlithe.png"
	},
	"psyduck": {
		"id": "psyduck",
		"name": "可达鸭",
		"title": "鸭宝可梦",
		"cost": 2,
		"types": ["Water", "Psychic"],
		"hp": 680,
		"atk": 50,
		"armor": 25,
		"mr": 35,
		"range": 2,
		"atk_speed": 0.70,
		"max_mana": 90,
		"skill_name": "水枪",
		"skill_desc": "向对手猛烈地喷射水流进行攻击。",
		"skill_detail": "消耗100能量，使出【水枪】。向对手猛烈地喷射水流进行攻击。 对目标造成182点伤害。",
		"skill_power": 182,
		"basic_attack": {
			"type": "special",
			"name": "水滴弹",
			"style": "water_bullet",
			"sfx": "water"
		},
						"skills": {
			1: [
				{
					"name": "水枪",
					"desc": "向对手猛烈地喷射水流进行攻击。",
					"detail": "消耗100能量，使出【水枪】。向对手猛烈地喷射水流进行攻击。 对目标造成182点伤害。",
					"power": 182,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "water_gun",
					"sfx": "water",
					"scale": 0.28
				},
				{
					"name": "抓",
					"desc": "用坚硬且无比锋利的爪子抓对手进行攻击。",
					"detail": "消耗100能量，使出【抓】。用坚硬且无比锋利的爪子抓对手进行攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "slash",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "意念头锤",
					"desc": "将思念的力量集中在前额进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，使出【意念头锤】。将思念的力量集中在前额进行攻击。有时会使对手畏缩。 对目标造成260点伤害。",
					"power": 260,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "zen_headbutt",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "水之波动",
					"desc": "用水的震动攻击对手。有时会使对手混乱。",
					"detail": "消耗100能量，爆发【水之波动】。用水的震动攻击对手。有时会使对手混乱。 对范围内最多3名敌人造成320点伤害，并施加战术压制。",
					"power": 320,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "water_pulse",
					"sfx": "water",
					"scale": 0.36
				},
				{
					"name": "念力",
					"desc": "向对手发送微弱的念力进行攻击。有时会使对手混乱。",
					"detail": "消耗100能量，爆发【念力】！向对手发送微弱的念力进行攻击。有时会使对手混乱。 对范围内最多3名敌人造成270点伤害，并施加战术压制。",
					"power": 270,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "confusion",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "水炮",
					"desc": "向对手猛烈地喷射大量水流进行攻击。",
					"detail": "消耗100能量，爆发【水炮】！向对手猛烈地喷射大量水流进行攻击。 对范围内最多3名敌人造成450点伤害，并施加战术压制。",
					"power": 450,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "hydro_pump",
					"sfx": "water",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "精神强念",
					"desc": "向对手发送强大的念力进行攻击。有时会降低对手的特防。",
					"detail": "消耗100能量，释放终极奥义【精神强念】！向对手发送强大的念力进行攻击。有时会降低对手的特防。 席卷战场对最多6名敌人造成655点巨额伤害与强力击破！",
					"power": 655,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "psychic",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "冲浪",
					"desc": "利用大浪攻击自己周围所有的宝可梦。",
					"detail": "消耗100能量，释放终极奥义【冲浪】！利用大浪攻击自己周围所有的宝可梦。 席卷战场对最多6名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "surf",
					"sfx": "water",
					"scale": 1.55
				},
				{
					"name": "乱抓",
					"desc": "用爪子或镰刀等抓对手进行攻击。连续攻击２～５次。",
					"detail": "消耗100能量，释放终极奥义【乱抓】！用爪子或镰刀等抓对手进行攻击。连续攻击２～５次。 席卷战场对最多4名敌人造成270点巨额伤害与强力击破！",
					"power": 270,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "headbutt",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/psyduck.png"
	},
	"electabuzz": {
		"id": "electabuzz",
		"name": "电击兽",
		"title": "电击宝可梦",
		"cost": 3,
		"types": ["Electric"],
		"hp": 780,
		"atk": 72,
		"armor": 28,
		"mr": 30,
		"range": 1,
		"atk_speed": 0.82,
		"max_mana": 100,
		"skill_name": "电击",
		"skill_desc": "发出电流刺激对手进行攻击。有时会让对手陷入麻痹状态。",
		"skill_detail": "消耗100能量，使出【电击】。发出电流刺激对手进行攻击。有时会让对手陷入麻痹状态。 对目标造成182点伤害。",
		"skill_power": 182,
		"basic_attack": {
			"type": "physical",
			"name": "连续拳",
			"style": "punch",
			"sfx": "punch"
		},
						"skills": {
			1: [
				{
					"name": "电击",
					"desc": "发出电流刺激对手进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，使出【电击】。发出电流刺激对手进行攻击。有时会让对手陷入麻痹状态。 对目标造成182点伤害。",
					"power": 182,
					"target_count": 1,
					"stun_duration": 0.5,
					"vfx": "thundershock",
					"sfx": "spark",
					"scale": 0.28
				},
				{
					"name": "电光一闪",
					"desc": "以迅雷不及掩耳之势扑向对手。必定能够先制攻击。",
					"detail": "消耗100能量，使出【电光一闪】。以迅雷不及掩耳之势扑向对手。必定能够先制攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "电球",
					"desc": "用电气团撞向对手。自己比对手速度越快，威力越大。",
					"detail": "消耗100能量，使出【电球】。用电气团撞向对手。自己比对手速度越快，威力越大。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "electro_ball",
					"sfx": "thunder",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "雷电拳",
					"desc": "用充满电流的拳头攻击对手。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，爆发【雷电拳】。用充满电流的拳头攻击对手。有时会让对手陷入麻痹状态。 对范围内最多3名敌人造成335点伤害，并施加战术压制。",
					"power": 335,
					"target_count": 3,
					"stun_duration": 0.8,
					"vfx": "thunder_punch",
					"sfx": "thunder",
					"scale": 0.36
				},
				{
					"name": "光墙",
					"desc": "利用神奇的墙壁，在５回合内减弱从对手那里受到的特殊攻击的伤害。",
					"detail": "消耗100能量，爆发【光墙】！利用神奇的墙壁，在５回合内减弱从对手那里受到的特殊攻击的伤害。 对范围内最多3名敌人造成320点伤害，并施加战术压制。",
					"power": 320,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "light_screen",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "十万伏特",
					"desc": "向对手发出强力电击进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，爆发【十万伏特】！向对手发出强力电击进行攻击。有时会让对手陷入麻痹状态。 对范围内最多3名敌人造成390点伤害，并施加战术压制。",
					"power": 390,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "thunderbolt",
					"sfx": "thunder",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "打雷",
					"desc": "向对手劈下暴雷进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，释放终极奥义【打雷】！向对手劈下暴雷进行攻击。有时会让对手陷入麻痹状态。 席卷战场对最多6名敌人造成685点巨额伤害与强力击破！",
					"power": 685,
					"target_count": 6,
					"stun_duration": 1.2,
					"vfx": "thunder",
					"sfx": "thunder",
					"scale": 0.48
				},
				{
					"name": "放电",
					"desc": "用耀眼的电击攻击自己周围所有的宝可梦。有时会陷入麻痹状态。",
					"detail": "消耗100能量，释放终极奥义【放电】！用耀眼的电击攻击自己周围所有的宝可梦。有时会陷入麻痹状态。 席卷战场对最多6名敌人造成580点巨额伤害与强力击破！",
					"power": 580,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "discharge",
					"sfx": "thunder",
					"scale": 1.55
				},
				{
					"name": "终极冲击",
					"desc": "使出自己浑身力量突击对手。下一回合自己将无法动弹。",
					"detail": "消耗100能量，释放终极奥义【终极冲击】！使出自己浑身力量突击对手。下一回合自己将无法动弹。 席卷战场对最多4名敌人造成930点巨额伤害与强力击破！",
					"power": 930,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "giga_impact",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/electabuzz.png"
	},
	"lapras": {
		"id": "lapras",
		"name": "拉普拉斯",
		"title": "乘龙宝可梦",
		"cost": 3,
		"types": ["Water"],
		"hp": 950,
		"atk": 55,
		"armor": 40,
		"mr": 45,
		"range": 2,
		"atk_speed": 0.65,
		"max_mana": 100,
		"skill_name": "水之波动",
		"skill_desc": "用水的震动攻击对手。有时会使对手混乱。",
		"skill_detail": "消耗100能量，使出【水之波动】。用水的震动攻击对手。有时会使对手混乱。 对目标造成198点伤害。",
		"skill_power": 198,
		"basic_attack": {
			"type": "special",
			"name": "水滴弹",
			"style": "water_bullet",
			"sfx": "water"
		},
						"skills": {
			1: [
				{
					"name": "水之波动",
					"desc": "用水的震动攻击对手。有时会使对手混乱。",
					"detail": "消耗100能量，使出【水之波动】。用水的震动攻击对手。有时会使对手混乱。 对目标造成198点伤害。",
					"power": 198,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "water_pulse",
					"sfx": "water",
					"scale": 0.28
				},
				{
					"name": "水枪",
					"desc": "向对手猛烈地喷射水流进行攻击。",
					"detail": "消耗100能量，使出【水枪】。向对手猛烈地喷射水流进行攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "water_gun",
					"sfx": "water",
					"scale": 0.82
				},
				{
					"name": "泰山压顶",
					"desc": "用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，使出【泰山压顶】。用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。 对目标造成270点伤害。",
					"power": 270,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "冰冻光束",
					"desc": "向对手发射冰冻光束进行攻击。有时会让对手陷入冰冻状态。",
					"detail": "消耗100能量，爆发【冰冻光束】。向对手发射冰冻光束进行攻击。有时会让对手陷入冰冻状态。 对范围内最多3名敌人造成350点伤害，并施加战术压制。",
					"power": 350,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "ice_beam",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "水炮",
					"desc": "向对手猛烈地喷射大量水流进行攻击。",
					"detail": "消耗100能量，爆发【水炮】！向对手猛烈地喷射大量水流进行攻击。 对范围内最多3名敌人造成450点伤害，并施加战术压制。",
					"power": 450,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "hydro_pump",
					"sfx": "water",
					"scale": 1.10
				},
				{
					"name": "蟹钳锤",
					"desc": "用大钳子敲打对手进行攻击。容易击中要害。",
					"detail": "消耗100能量，爆发【蟹钳锤】！用大钳子敲打对手进行攻击。容易击中要害。 对范围内最多2名敌人造成420点伤害，并施加战术压制。",
					"power": 420,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "crabhammer",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "绝对零度",
					"desc": "给对手一击濒死。如果是冰属性以外的宝可梦使用，就会难以打中。",
					"detail": "消耗100能量，释放终极奥义【绝对零度】！给对手一击濒死。如果是冰属性以外的宝可梦使用，就会难以打中。 席卷战场对最多6名敌人造成600点巨额伤害与强力击破！",
					"power": 600,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "sheer_cold",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，释放终极奥义【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 席卷战场对最多4名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "暴风雪",
					"desc": "将猛烈的暴风雪刮向对手进行攻击。有时会让对手陷入冰冻状态。",
					"detail": "消耗100能量，释放终极奥义【暴风雪】！将猛烈的暴风雪刮向对手进行攻击。有时会让对手陷入冰冻状态。 席卷战场对最多6名敌人造成730点巨额伤害与强力击破！",
					"power": 730,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "blizzard",
					"sfx": "water",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/lapras.png"
	},
	"lucario": {
		"id": "lucario",
		"name": "路卡利欧",
		"title": "波导宝可梦",
		"cost": 4,
		"types": ["Fighting"],
		"hp": 920,
		"atk": 88,
		"armor": 35,
		"mr": 35,
		"range": 1,
		"atk_speed": 0.85,
		"max_mana": 100,
		"skill_name": "发劲",
		"skill_desc": "向对手的身体发出冲击波进行攻击。有时会让对手陷入麻痹状态。",
		"skill_detail": "消耗100能量，使出【发劲】。向对手的身体发出冲击波进行攻击。有时会让对手陷入麻痹状态。 对目标造成198点伤害。",
		"skill_power": 198,
		"basic_attack": {
			"type": "physical",
			"name": "连续拳",
			"style": "punch",
			"sfx": "punch"
		},
						"skills": {
			1: [
				{
					"name": "发劲",
					"desc": "向对手的身体发出冲击波进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，使出【发劲】。向对手的身体发出冲击波进行攻击。有时会让对手陷入麻痹状态。 对目标造成198点伤害。",
					"power": 198,
					"target_count": 1,
					"stun_duration": 0.5,
					"vfx": "force_palm",
					"sfx": "punch",
					"scale": 0.28
				},
				{
					"name": "电光一闪",
					"desc": "以迅雷不及掩耳之势扑向对手。必定能够先制攻击。",
					"detail": "消耗100能量，使出【电光一闪】。以迅雷不及掩耳之势扑向对手。必定能够先制攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "音速拳",
					"desc": "以迅雷不及掩耳之势出拳。必定能够先制攻击。",
					"detail": "消耗100能量，使出【音速拳】。以迅雷不及掩耳之势出拳。必定能够先制攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "mach_punch",
					"sfx": "punch",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "波导弹",
					"desc": "从体内产生出波导之力，然后向对手发出。攻击必定会命中。",
					"detail": "消耗100能量，爆发【波导弹】。从体内产生出波导之力，然后向对手发出。攻击必定会命中。 对范围内最多3名敌人造成340点伤害，并施加战术压制。",
					"power": 340,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "aura_sphere",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "骨棒乱打",
					"desc": "用坚硬的骨头殴打对手进行攻击。连续攻击２～５次。",
					"detail": "消耗100能量，爆发【骨棒乱打】！用坚硬的骨头殴打对手进行攻击。连续攻击２～５次。 对范围内最多2名敌人造成195点伤害，并施加战术压制。",
					"power": 195,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "bone_rush",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "咬碎",
					"desc": "用利牙咬碎对手进行攻击。有时会降低对手的防御。",
					"detail": "消耗100能量，爆发【咬碎】！用利牙咬碎对手进行攻击。有时会降低对手的防御。 对范围内最多2名敌人造成360点伤害，并施加战术压制。",
					"power": 360,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "crunch",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "近身战",
					"desc": "放弃守护，向对手的怀里突击。自己的防御和特防会降低。",
					"detail": "消耗100能量，释放终极奥义【近身战】！放弃守护，向对手的怀里突击。自己的防御和特防会降低。 席卷战场对最多6名敌人造成700点巨额伤害与强力击破！",
					"power": 700,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "close_combat",
					"sfx": "punch",
					"scale": 0.48
				},
				{
					"name": "彗星拳",
					"desc": "使出彗星般的拳头攻击对手。有时会提高自己的攻击。",
					"detail": "消耗100能量，释放终极奥义【彗星拳】！使出彗星般的拳头攻击对手。有时会提高自己的攻击。 席卷战场对最多4名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "蛮力",
					"desc": "发挥惊人的力量攻击对手。自己的攻击和防御会降低。",
					"detail": "消耗100能量，释放终极奥义【蛮力】！发挥惊人的力量攻击对手。自己的攻击和防御会降低。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "mega_punch",
					"sfx": "punch",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/lucario.png"
	},
	"ivysaur": {
		"id": "ivysaur",
		"name": "妙蛙草",
		"title": "种子宝可梦",
		"cost": 2,
		"types": ["Grass", "Poison"],
		"hp": 750,
		"atk": 62,
		"armor": 35,
		"mr": 35,
		"range": 2,
		"atk_speed": 0.68,
		"max_mana": 100,
		"desc": "背上的花苞正在吸收阳光积蓄力量，盛开前会散发出清甜的香气，能挥舞强力藤鞭抽打并束缚敌人。",
		"skill_name": "藤鞭",
		"skill_desc": "用如同鞭子般弯曲而细长的藤蔓摔打对手进行攻击。",
		"skill_detail": "消耗100能量，使出【藤鞭】。用如同鞭子般弯曲而细长的藤蔓摔打对手进行攻击。 对目标造成186点伤害。",
		"skill_power": 186,
		"basic_attack": {
			"type": "special",
			"name": "飞叶",
			"style": "leaf",
			"sfx": "swift"
		},
						"skills": {
			1: [
				{
					"name": "藤鞭",
					"desc": "用如同鞭子般弯曲而细长的藤蔓摔打对手进行攻击。",
					"detail": "消耗100能量，使出【藤鞭】。用如同鞭子般弯曲而细长的藤蔓摔打对手进行攻击。 对目标造成186点伤害。",
					"power": 186,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "vine_whip",
					"sfx": "slash",
					"scale": 0.28
				},
				{
					"name": "撞击",
					"desc": "用整个身体撞向对手进行攻击。",
					"detail": "消耗100能量，使出【撞击】。用整个身体撞向对手进行攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "tackle",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "种子炸弹",
					"desc": "将外壳坚硬的大种子，从上方砸下攻击对手。",
					"detail": "消耗100能量，使出【种子炸弹】。将外壳坚硬的大种子，从上方砸下攻击对手。 对目标造成260点伤害。",
					"power": 260,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "seed_bomb",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "污泥炸弹",
					"desc": "用污泥投掷对手进行攻击。有时会让对手陷入中毒状态。",
					"detail": "消耗100能量，爆发【污泥炸弹】。用污泥投掷对手进行攻击。有时会让对手陷入中毒状态。 对范围内最多3名敌人造成350点伤害，并施加战术压制。",
					"power": 350,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "sludge_bomb",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "寄生种子",
					"desc": "植入寄生种子后，将在每回合一点一点吸取对手的ＨＰ，从而用来回复自己的ＨＰ。",
					"detail": "消耗100能量，爆发【寄生种子】！植入寄生种子后，将在每回合一点一点吸取对手的ＨＰ，从而用来回复自己的ＨＰ。 对范围内最多3名敌人造成320点伤害，并施加战术压制。",
					"power": 320,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "leech_seed",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "舍身冲撞",
					"desc": "拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。",
					"detail": "消耗100能量，爆发【舍身冲撞】！拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。 对范围内最多2名敌人造成480点伤害，并施加战术压制。",
					"power": 480,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "double_edge",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "疯狂植物",
					"desc": "用大树摔打对手进行攻击。下一回合自己将无法动弹。",
					"detail": "消耗100能量，释放终极奥义【疯狂植物】！用大树摔打对手进行攻击。下一回合自己将无法动弹。 席卷战场对最多6名敌人造成745点巨额伤害与强力击破！",
					"power": 745,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "frenzy_plant",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "日光束",
					"desc": "第１回合收集满满的日光，第２回合发射光束进行攻击。",
					"detail": "消耗100能量，释放终极奥义【日光束】！第１回合收集满满的日光，第２回合发射光束进行攻击。 席卷战场对最多6名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "solar_beam",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "强力鞭打",
					"desc": "激烈地挥舞青藤或触手摔打对手进行攻击。",
					"detail": "消耗100能量，释放终极奥义【强力鞭打】！激烈地挥舞青藤或触手摔打对手进行攻击。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "power_whip",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/ivysaur.png"
	},
	"venusaur": {
		"id": "venusaur",
		"name": "妙蛙花",
		"title": "种子宝可梦",
		"cost": 4,
		"types": ["Grass", "Poison"],
		"hp": 1100,
		"atk": 85,
		"armor": 50,
		"mr": 50,
		"range": 3,
		"atk_speed": 0.7,
		"max_mana": 100,
		"desc": "背上盛开着巨大的花朵，能吸收太阳光能将其转化为强大的自然毁灭之力，挥动粗壮巨木根须压制战场！",
		"skill_name": "飞叶快刀",
		"skill_desc": "飞出叶片，切斩对手进行攻击。容易击中要害。",
		"skill_detail": "消耗100能量，使出【飞叶快刀】。飞出叶片，切斩对手进行攻击。容易击中要害。 对目标造成194点伤害。",
		"skill_power": 194,
		"basic_attack": {
			"type": "special",
			"name": "飞叶",
			"style": "leaf",
			"sfx": "swift"
		},
						"skills": {
			1: [
				{
					"name": "飞叶快刀",
					"desc": "飞出叶片，切斩对手进行攻击。容易击中要害。",
					"detail": "消耗100能量，使出【飞叶快刀】。飞出叶片，切斩对手进行攻击。容易击中要害。 对目标造成194点伤害。",
					"power": 194,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "razor_leaf",
					"sfx": "slash",
					"scale": 0.28
				},
				{
					"name": "花瓣舞",
					"desc": "在２～３回合内，散落花瓣攻击对手。之后自己会陷入混乱。",
					"detail": "消耗100能量，使出【花瓣舞】。在２～３回合内，散落花瓣攻击对手。之后自己会陷入混乱。 对目标造成340点伤害。",
					"power": 340,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "petal_dance",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "种子炸弹",
					"desc": "将外壳坚硬的大种子，从上方砸下攻击对手。",
					"detail": "消耗100能量，使出【种子炸弹】。将外壳坚硬的大种子，从上方砸下攻击对手。 对目标造成260点伤害。",
					"power": 260,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "seed_bomb",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "污泥炸弹",
					"desc": "用污泥投掷对手进行攻击。有时会让对手陷入中毒状态。",
					"detail": "消耗100能量，爆发【污泥炸弹】。用污泥投掷对手进行攻击。有时会让对手陷入中毒状态。 对范围内最多3名敌人造成350点伤害，并施加战术压制。",
					"power": 350,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "sludge_bomb",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "撞击",
					"desc": "用整个身体撞向对手进行攻击。",
					"detail": "消耗100能量，爆发【撞击】！用整个身体撞向对手进行攻击。 对范围内最多2名敌人造成240点伤害，并施加战术压制。",
					"power": 240,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "tackle",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "舍身冲撞",
					"desc": "拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。",
					"detail": "消耗100能量，爆发【舍身冲撞】！拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。 对范围内最多2名敌人造成480点伤害，并施加战术压制。",
					"power": 480,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "double_edge",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "疯狂植物",
					"desc": "用大树摔打对手进行攻击。下一回合自己将无法动弹。",
					"detail": "消耗100能量，释放终极奥义【疯狂植物】！用大树摔打对手进行攻击。下一回合自己将无法动弹。 席卷战场对最多6名敌人造成745点巨额伤害与强力击破！",
					"power": 745,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "frenzy_plant",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "日光束",
					"desc": "第１回合收集满满的日光，第２回合发射光束进行攻击。",
					"detail": "消耗100能量，释放终极奥义【日光束】！第１回合收集满满的日光，第２回合发射光束进行攻击。 席卷战场对最多6名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "solar_beam",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "泰山压顶",
					"desc": "用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，释放终极奥义【泰山压顶】！用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。 席卷战场对最多4名敌人造成605点巨额伤害与强力击破！",
					"power": 605,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/venusaur.png"
	},
	"charmeleon": {
		"id": "charmeleon",
		"name": "火恐龙",
		"title": "火焰宝可梦",
		"cost": 2,
		"types": ["Fire"],
		"hp": 720,
		"atk": 68,
		"armor": 30,
		"mr": 30,
		"range": 2,
		"atk_speed": 0.72,
		"max_mana": 100,
		"desc": "性格粗暴好战，遇到强敌时尾巴上的火焰会化作青白色，挥动锋利双爪撕裂猎物并喷射熊熊烈焰！",
		"skill_name": "火花",
		"skill_desc": "向对手发射小型火焰进行攻击。有时会让对手陷入灼伤状态。",
		"skill_detail": "消耗100能量，使出【火花】。向对手发射小型火焰进行攻击。有时会让对手陷入灼伤状态。 对目标造成182点伤害。",
		"skill_power": 182,
		"basic_attack": {
			"type": "special",
			"name": "火花",
			"style": "fire_ember",
			"sfx": "fire"
		},
						"skills": {
			1: [
				{
					"name": "火花",
					"desc": "向对手发射小型火焰进行攻击。有时会让对手陷入灼伤状态。",
					"detail": "消耗100能量，使出【火花】。向对手发射小型火焰进行攻击。有时会让对手陷入灼伤状态。 对目标造成182点伤害。",
					"power": 182,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "ember",
					"sfx": "fire",
					"scale": 0.28
				},
				{
					"name": "抓",
					"desc": "用坚硬且无比锋利的爪子抓对手进行攻击。",
					"detail": "消耗100能量，使出【抓】。用坚硬且无比锋利的爪子抓对手进行攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "slash",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "乱抓",
					"desc": "用爪子或镰刀等抓对手进行攻击。连续攻击２～５次。",
					"detail": "消耗100能量，使出【乱抓】。用爪子或镰刀等抓对手进行攻击。连续攻击２～５次。 对目标造成136点伤害。",
					"power": 136,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "fire_spin",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "喷射火焰",
					"desc": "向对手发射烈焰进行攻击。有时会让对手陷入灼伤状态。",
					"detail": "消耗100能量，爆发【喷射火焰】。向对手发射烈焰进行攻击。有时会让对手陷入灼伤状态。 对范围内最多3名敌人造成350点伤害，并施加战术压制。",
					"power": 350,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "flamethrower",
					"sfx": "fire",
					"scale": 0.36
				},
				{
					"name": "火焰牙",
					"desc": "用覆盖着火焰的牙齿咬住对手。有时会使对手畏缩或陷入灼伤状态。",
					"detail": "消耗100能量，爆发【火焰牙】！用覆盖着火焰的牙齿咬住对手。有时会使对手畏缩或陷入灼伤状态。 对范围内最多2名敌人造成315点伤害，并施加战术压制。",
					"power": 315,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "fire_fang",
					"sfx": "fire",
					"scale": 1.10
				},
				{
					"name": "百万吨重拳",
					"desc": "用充满力量的拳头攻击对手。",
					"detail": "消耗100能量，爆发【百万吨重拳】！用充满力量的拳头攻击对手。 对范围内最多2名敌人造成360点伤害，并施加战术压制。",
					"power": 360,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "mega_punch",
					"sfx": "punch",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "大字爆炎",
					"desc": "用大字形状的火焰烧尽对手。有时会让对手陷入灼伤状态。",
					"detail": "消耗100能量，释放终极奥义【大字爆炎】！用大字形状的火焰烧尽对手。有时会让对手陷入灼伤状态。 席卷战场对最多6名敌人造成685点巨额伤害与强力击破！",
					"power": 685,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "fire_blast",
					"sfx": "fire",
					"scale": 0.48
				},
				{
					"name": "百万吨重踢",
					"desc": "使出力大无穷的重踢踢飞对手进行攻击。",
					"detail": "消耗100能量，释放终极奥义【百万吨重踢】！使出力大无穷的重踢踢飞对手进行攻击。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "mega_kick",
					"sfx": "punch",
					"scale": 1.55
				},
				{
					"name": "闪焰冲锋",
					"desc": "让火焰覆盖全身猛撞向对手。自己也会受到不小的伤害。有时会让对手陷入灼伤状态。",
					"detail": "消耗100能量，释放终极奥义【闪焰冲锋】！让火焰覆盖全身猛撞向对手。自己也会受到不小的伤害。有时会让对手陷入灼伤状态。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "flare_blitz",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/charmeleon.png"
	},
	"wartortle": {
		"id": "wartortle",
		"name": "卡咪龟",
		"title": "龟宝可梦",
		"cost": 2,
		"types": ["Water"],
		"hp": 780,
		"atk": 58,
		"armor": 42,
		"mr": 42,
		"range": 2,
		"atk_speed": 0.67,
		"max_mana": 100,
		"desc": "长着蓬松毛茸茸的耳朵与尾巴，是长寿与祥瑞的象征，坚硬甲壳上带有战痕，擅长掀起旋涡水流冲散敌人。",
		"skill_name": "水枪",
		"skill_desc": "向对手猛烈地喷射水流进行攻击。",
		"skill_detail": "消耗100能量，使出【水枪】。向对手猛烈地喷射水流进行攻击。 对目标造成182点伤害。",
		"skill_power": 182,
		"basic_attack": {
			"type": "special",
			"name": "水滴弹",
			"style": "water_bullet",
			"sfx": "water"
		},
						"skills": {
			1: [
				{
					"name": "水枪",
					"desc": "向对手猛烈地喷射水流进行攻击。",
					"detail": "消耗100能量，使出【水枪】。向对手猛烈地喷射水流进行攻击。 对目标造成182点伤害。",
					"power": 182,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "water_gun",
					"sfx": "water",
					"scale": 0.28
				},
				{
					"name": "撞击",
					"desc": "用整个身体撞向对手进行攻击。",
					"detail": "消耗100能量，使出【撞击】。用整个身体撞向对手进行攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "tackle",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "水之波动",
					"desc": "用水的震动攻击对手。有时会使对手混乱。",
					"detail": "消耗100能量，使出【水之波动】。用水的震动攻击对手。有时会使对手混乱。 对目标造成220点伤害。",
					"power": 220,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "water_pulse",
					"sfx": "water",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "水炮",
					"desc": "向对手猛烈地喷射大量水流进行攻击。",
					"detail": "消耗100能量，爆发【水炮】。向对手猛烈地喷射大量水流进行攻击。 对范围内最多3名敌人造成370点伤害，并施加战术压制。",
					"power": 370,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "hydro_pump",
					"sfx": "water",
					"scale": 0.36
				},
				{
					"name": "水流尾",
					"desc": "如惊涛骇浪般挥动大尾巴攻击对手。",
					"detail": "消耗100能量，爆发【水流尾】！如惊涛骇浪般挥动大尾巴攻击对手。 对范围内最多2名敌人造成390点伤害，并施加战术压制。",
					"power": 390,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "aqua_tail",
					"sfx": "water",
					"scale": 1.10
				},
				{
					"name": "火箭头锤",
					"desc": "第１回合把头缩进去，从而提高防御。第２回合攻击对手。",
					"detail": "消耗100能量，爆发【火箭头锤】！第１回合把头缩进去，从而提高防御。第２回合攻击对手。 对范围内最多2名敌人造成510点伤害，并施加战术压制。",
					"power": 510,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "加农水炮",
					"desc": "向对手喷射水炮进行攻击。下一回合自己将无法动弹。",
					"detail": "消耗100能量，释放终极奥义【加农水炮】！向对手喷射水炮进行攻击。下一回合自己将无法动弹。 席卷战场对最多6名敌人造成745点巨额伤害与强力击破！",
					"power": 745,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "hydro_cannon",
					"sfx": "water",
					"scale": 0.48
				},
				{
					"name": "泡沫光线",
					"desc": "向对手猛烈地喷射泡沫进行攻击。有时会降低对手的速度。",
					"detail": "消耗100能量，释放终极奥义【泡沫光线】！向对手猛烈地喷射泡沫进行攻击。有时会降低对手的速度。 席卷战场对最多6名敌人造成505点巨额伤害与强力击破！",
					"power": 505,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "bubble_beam",
					"sfx": "water",
					"scale": 1.55
				},
				{
					"name": "百万吨重拳",
					"desc": "用充满力量的拳头攻击对手。",
					"detail": "消耗100能量，释放终极奥义【百万吨重拳】！用充满力量的拳头攻击对手。 席卷战场对最多4名敌人造成580点巨额伤害与强力击破！",
					"power": 580,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "mega_punch",
					"sfx": "punch",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/wartortle.png"
	},
	"blastoise": {
		"id": "blastoise",
		"name": "水箭龟",
		"title": "甲壳宝可梦",
		"cost": 4,
		"types": ["Water"],
		"hp": 1200,
		"atk": 80,
		"armor": 60,
		"mr": 60,
		"range": 3,
		"atk_speed": 0.65,
		"max_mana": 100,
		"desc": "甲壳上伸出两门粗壮有力的钢铁水炮，能以穿透厚厚钢板的恐怖水压轰击敌方防线，如同战场重装堡垒！",
		"skill_name": "水枪",
		"skill_desc": "向对手猛烈地喷射水流进行攻击。",
		"skill_detail": "消耗100能量，使出【水枪】。向对手猛烈地喷射水流进行攻击。 对目标造成182点伤害。",
		"skill_power": 182,
		"basic_attack": {
			"type": "special",
			"name": "水滴弹",
			"style": "water_bullet",
			"sfx": "water"
		},
						"skills": {
			1: [
				{
					"name": "水枪",
					"desc": "向对手猛烈地喷射水流进行攻击。",
					"detail": "消耗100能量，使出【水枪】。向对手猛烈地喷射水流进行攻击。 对目标造成182点伤害。",
					"power": 182,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "water_gun",
					"sfx": "water",
					"scale": 0.28
				},
				{
					"name": "加农光炮",
					"desc": "将身体的光芒聚集在一点释放出去。有时会降低对手的特防。",
					"detail": "消耗100能量，使出【加农光炮】。将身体的光芒聚集在一点释放出去。有时会降低对手的特防。 对目标造成260点伤害。",
					"power": 260,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "水之波动",
					"desc": "用水的震动攻击对手。有时会使对手混乱。",
					"detail": "消耗100能量，使出【水之波动】。用水的震动攻击对手。有时会使对手混乱。 对目标造成220点伤害。",
					"power": 220,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "water_pulse",
					"sfx": "water",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "水炮",
					"desc": "向对手猛烈地喷射大量水流进行攻击。",
					"detail": "消耗100能量，爆发【水炮】。向对手猛烈地喷射大量水流进行攻击。 对范围内最多3名敌人造成370点伤害，并施加战术压制。",
					"power": 370,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "hydro_pump",
					"sfx": "water",
					"scale": 0.36
				},
				{
					"name": "水流尾",
					"desc": "如惊涛骇浪般挥动大尾巴攻击对手。",
					"detail": "消耗100能量，爆发【水流尾】！如惊涛骇浪般挥动大尾巴攻击对手。 对范围内最多2名敌人造成390点伤害，并施加战术压制。",
					"power": 390,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "aqua_tail",
					"sfx": "water",
					"scale": 1.10
				},
				{
					"name": "火箭头锤",
					"desc": "第１回合把头缩进去，从而提高防御。第２回合攻击对手。",
					"detail": "消耗100能量，爆发【火箭头锤】！第１回合把头缩进去，从而提高防御。第２回合攻击对手。 对范围内最多2名敌人造成510点伤害，并施加战术压制。",
					"power": 510,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "加农水炮",
					"desc": "向对手喷射水炮进行攻击。下一回合自己将无法动弹。",
					"detail": "消耗100能量，释放终极奥义【加农水炮】！向对手喷射水炮进行攻击。下一回合自己将无法动弹。 席卷战场对最多6名敌人造成745点巨额伤害与强力击破！",
					"power": 745,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "hydro_cannon",
					"sfx": "water",
					"scale": 0.48
				},
				{
					"name": "泡沫光线",
					"desc": "向对手猛烈地喷射泡沫进行攻击。有时会降低对手的速度。",
					"detail": "消耗100能量，释放终极奥义【泡沫光线】！向对手猛烈地喷射泡沫进行攻击。有时会降低对手的速度。 席卷战场对最多6名敌人造成505点巨额伤害与强力击破！",
					"power": 505,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "bubble_beam",
					"sfx": "water",
					"scale": 1.55
				},
				{
					"name": "百万吨重拳",
					"desc": "用充满力量的拳头攻击对手。",
					"detail": "消耗100能量，释放终极奥义【百万吨重拳】！用充满力量的拳头攻击对手。 席卷战场对最多4名敌人造成580点巨额伤害与强力击破！",
					"power": 580,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "mega_punch",
					"sfx": "punch",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/blastoise.png"
	},
	"caterpie": {
		"id": "caterpie",
		"name": "绿毛虫",
		"title": "虫宝宝宝可梦",
		"cost": 1,
		"types": ["Bug"],
		"hp": 500,
		"atk": 42,
		"armor": 20,
		"mr": 20,
		"range": 1,
		"atk_speed": 0.75,
		"max_mana": 80,
		"desc": "头上的红色触角能释放出强烈的臭气驱逐敌人，口中能喷射出坚韧黏稠的白色蚕丝缠绕束缚猎物。",
		"skill_name": "虫咬",
		"skill_desc": "咬住进行攻击。当对手携带树果时，可以食用并获得其效果。",
		"skill_detail": "消耗100能量，使出【虫咬】。咬住进行攻击。当对手携带树果时，可以食用并获得其效果。 对目标造成198点伤害。",
		"skill_power": 198,
		"basic_attack": {
			"type": "physical",
			"name": "撞击",
			"style": "tackle",
			"sfx": "attack"
		},
						"skills": {
			1: [
				{
					"name": "虫咬",
					"desc": "咬住进行攻击。当对手携带树果时，可以食用并获得其效果。",
					"detail": "消耗100能量，使出【虫咬】。咬住进行攻击。当对手携带树果时，可以食用并获得其效果。 对目标造成198点伤害。",
					"power": 198,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "leech_life",
					"sfx": "slash",
					"scale": 0.28
				},
				{
					"name": "撞击",
					"desc": "用整个身体撞向对手进行攻击。",
					"detail": "消耗100能量，使出【撞击】。用整个身体撞向对手进行攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "tackle",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "打鼾",
					"desc": "在自己睡觉时，发出噪音进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，使出【打鼾】。在自己睡觉时，发出噪音进行攻击。有时会使对手畏缩。 对目标造成200点伤害。",
					"power": 200,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "吐丝",
					"desc": "用口中吐出的丝缠绕对手，从而大幅降低对手的速度。",
					"detail": "消耗100能量，爆发【吐丝】。用口中吐出的丝缠绕对手，从而大幅降低对手的速度。 对范围内最多3名敌人造成300点伤害，并施加战术压制。",
					"power": 300,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "string_shot",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "十字剪",
					"desc": "将镰刀或爪子像剪刀般地交叉，顺势劈开对手。",
					"detail": "消耗100能量，爆发【十字剪】！将镰刀或爪子像剪刀般地交叉，顺势劈开对手。 对范围内最多2名敌人造成360点伤害，并施加战术压制。",
					"power": 360,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "x_scissor",
					"sfx": "slash",
					"scale": 1.10
				},
				{
					"name": "信号光束",
					"desc": "发射神奇的光线进行攻击。有时会使对手混乱。",
					"detail": "消耗100能量，爆发【信号光束】！发射神奇的光线进行攻击。有时会使对手混乱。 对范围内最多3名敌人造成345点伤害，并施加战术压制。",
					"power": 345,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "psybeam",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "电网",
					"desc": "用电网捉住对手进行攻击。降低对手的速度。",
					"detail": "消耗100能量，释放终极奥义【电网】！用电网捉住对手进行攻击。降低对手的速度。 席卷战场对最多6名敌人造成602点巨额伤害与强力击破！",
					"power": 602,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "electroweb",
					"sfx": "spark",
					"scale": 0.48
				},
				{
					"name": "虫鸣",
					"desc": "利用振动发出音波进行攻击。有时会降低对手的特防。",
					"detail": "消耗100能量，释放终极奥义【虫鸣】！利用振动发出音波进行攻击。有时会降低对手的特防。 席卷战场对最多6名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "bug_buzz",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "蝶舞",
					"desc": "轻巧地跳起神秘而又美丽的舞蹈。提高自己的特攻、特防和速度。",
					"detail": "消耗100能量，释放终极奥义【蝶舞】！轻巧地跳起神秘而又美丽的舞蹈。提高自己的特攻、特防和速度。 席卷战场对最多6名敌人造成680点巨额伤害与强力击破！",
					"power": 680,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "extreme_evoboost",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/caterpie.png"
	},
	"metapod": {
		"id": "metapod",
		"name": "铁甲蛹",
		"title": "蛹宝可梦",
		"cost": 2,
		"types": ["Bug"],
		"hp": 850,
		"atk": 35,
		"armor": 65,
		"mr": 50,
		"range": 1,
		"atk_speed": 0.55,
		"max_mana": 80,
		"desc": "外壳坚硬如钢铁，体内正在进行着剧烈的重构与蜕变。能通过极限硬化反弹一切物理冲击！",
		"skill_name": "变硬",
		"skill_desc": "全身使劲，让身体变硬，从而提高自己的防御。",
		"skill_detail": "消耗100能量，使出【变硬】。全身使劲，让身体变硬，从而提高自己的防御。 对目标造成160点伤害。",
		"skill_power": 160,
		"basic_attack": {
			"type": "physical",
			"name": "撞击",
			"style": "tackle",
			"sfx": "attack"
		},
						"skills": {
			1: [
				{
					"name": "变硬",
					"desc": "全身使劲，让身体变硬，从而提高自己的防御。",
					"detail": "消耗100能量，使出【变硬】。全身使劲，让身体变硬，从而提高自己的防御。 对目标造成160点伤害。",
					"power": 160,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "reflect",
					"sfx": "skill",
					"scale": 0.28
				},
				{
					"name": "虫咬",
					"desc": "咬住进行攻击。当对手携带树果时，可以食用并获得其效果。",
					"detail": "消耗100能量，使出【虫咬】。咬住进行攻击。当对手携带树果时，可以食用并获得其效果。 对目标造成220点伤害。",
					"power": 220,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "leech_life",
					"sfx": "slash",
					"scale": 0.82
				},
				{
					"name": "撞击",
					"desc": "用整个身体撞向对手进行攻击。",
					"detail": "消耗100能量，使出【撞击】。用整个身体撞向对手进行攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "tackle",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "铁壁",
					"desc": "将皮肤变得坚硬如铁，从而大幅提高自己的防御。",
					"detail": "消耗100能量，爆发【铁壁】。将皮肤变得坚硬如铁，从而大幅提高自己的防御。 对范围内最多3名敌人造成300点伤害，并施加战术压制。",
					"power": 300,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "十字剪",
					"desc": "将镰刀或爪子像剪刀般地交叉，顺势劈开对手。",
					"detail": "消耗100能量，爆发【十字剪】！将镰刀或爪子像剪刀般地交叉，顺势劈开对手。 对范围内最多2名敌人造成360点伤害，并施加战术压制。",
					"power": 360,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "x_scissor",
					"sfx": "slash",
					"scale": 1.10
				},
				{
					"name": "信号光束",
					"desc": "发射神奇的光线进行攻击。有时会使对手混乱。",
					"detail": "消耗100能量，爆发【信号光束】！发射神奇的光线进行攻击。有时会使对手混乱。 对范围内最多3名敌人造成345点伤害，并施加战术压制。",
					"power": 345,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "psybeam",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "虫鸣",
					"desc": "利用振动发出音波进行攻击。有时会降低对手的特防。",
					"detail": "消耗100能量，释放终极奥义【虫鸣】！利用振动发出音波进行攻击。有时会降低对手的特防。 席卷战场对最多6名敌人造成655点巨额伤害与强力击破！",
					"power": 655,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "bug_buzz",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "超级角击",
					"desc": "用坚硬且华丽的角狠狠地刺入对手进行攻击。",
					"detail": "消耗100能量，释放终极奥义【超级角击】！用坚硬且华丽的角狠狠地刺入对手进行攻击。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "giga_impact",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "蝶舞",
					"desc": "轻巧地跳起神秘而又美丽的舞蹈。提高自己的特攻、特防和速度。",
					"detail": "消耗100能量，释放终极奥义【蝶舞】！轻巧地跳起神秘而又美丽的舞蹈。提高自己的特攻、特防和速度。 席卷战场对最多6名敌人造成680点巨额伤害与强力击破！",
					"power": 680,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "extreme_evoboost",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/metapod.png"
	},
	"butterfree": {
		"id": "butterfree",
		"name": "巴大蝶",
		"title": "蝴蝶宝可梦",
		"cost": 3,
		"types": ["Bug", "Flying"],
		"hp": 720,
		"atk": 65,
		"armor": 30,
		"mr": 45,
		"range": 3,
		"atk_speed": 0.72,
		"max_mana": 90,
		"desc": "翅膀上覆盖着防水的剧毒鳞粉，翩翩起舞时能散播出致眠粉、麻痹粉与混乱烈风，轻灵戏耍敌人。",
		"skill_name": "念力",
		"skill_desc": "向对手发送微弱的念力进行攻击。有时会使对手混乱。",
		"skill_detail": "消耗100能量，使出【念力】。向对手发送微弱的念力进行攻击。有时会使对手混乱。 对目标造成190点伤害。",
		"skill_power": 190,
		"basic_attack": {
			"type": "special",
			"name": "魔法弹",
			"style": "spark",
			"sfx": "swift"
		},
						"skills": {
			1: [
				{
					"name": "念力",
					"desc": "向对手发送微弱的念力进行攻击。有时会使对手混乱。",
					"detail": "消耗100能量，使出【念力】。向对手发送微弱的念力进行攻击。有时会使对手混乱。 对目标造成190点伤害。",
					"power": 190,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "confusion",
					"sfx": "skill",
					"scale": 0.28
				},
				{
					"name": "起风",
					"desc": "用翅膀将刮起的狂风袭向对手进行攻击。",
					"detail": "消耗100能量，使出【起风】。用翅膀将刮起的狂风袭向对手进行攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "gust",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "银色旋风",
					"desc": "在风中掺入鳞粉攻击对手。有时会提高自己的全部能力。",
					"detail": "消耗100能量，使出【银色旋风】。在风中掺入鳞粉攻击对手。有时会提高自己的全部能力。 对目标造成220点伤害。",
					"power": 220,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "silver_wind",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "幻象光线",
					"desc": "向对手发射神奇的光线进行攻击。有时会使对手混乱。",
					"detail": "消耗100能量，爆发【幻象光线】。向对手发射神奇的光线进行攻击。有时会使对手混乱。 对范围内最多3名敌人造成325点伤害，并施加战术压制。",
					"power": 325,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "psybeam",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "撞击",
					"desc": "用整个身体撞向对手进行攻击。",
					"detail": "消耗100能量，爆发【撞击】！用整个身体撞向对手进行攻击。 对范围内最多2名敌人造成240点伤害，并施加战术压制。",
					"power": 240,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "tackle",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "吐丝",
					"desc": "用口中吐出的丝缠绕对手，从而大幅降低对手的速度。",
					"detail": "消耗100能量，爆发【吐丝】！用口中吐出的丝缠绕对手，从而大幅降低对手的速度。 对范围内最多3名敌人造成320点伤害，并施加战术压制。",
					"power": 320,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "string_shot",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "虫鸣",
					"desc": "利用振动发出音波进行攻击。有时会降低对手的特防。",
					"detail": "消耗100能量，释放终极奥义【虫鸣】！利用振动发出音波进行攻击。有时会降低对手的特防。 席卷战场对最多6名敌人造成655点巨额伤害与强力击破！",
					"power": 655,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "bug_buzz",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "超级角击",
					"desc": "用坚硬且华丽的角狠狠地刺入对手进行攻击。",
					"detail": "消耗100能量，释放终极奥义【超级角击】！用坚硬且华丽的角狠狠地刺入对手进行攻击。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "giga_impact",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "蝶舞",
					"desc": "轻巧地跳起神秘而又美丽的舞蹈。提高自己的特攻、特防和速度。",
					"detail": "消耗100能量，释放终极奥义【蝶舞】！轻巧地跳起神秘而又美丽的舞蹈。提高自己的特攻、特防和速度。 席卷战场对最多6名敌人造成680点巨额伤害与强力击破！",
					"power": 680,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "extreme_evoboost",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/butterfree.png"
	},
	"weedle": {
		"id": "weedle",
		"name": "独角虫",
		"title": "毛毛虫宝可梦",
		"cost": 1,
		"types": ["Bug", "Poison"],
		"hp": 520,
		"atk": 46,
		"armor": 22,
		"mr": 22,
		"range": 1,
		"atk_speed": 0.72,
		"max_mana": 80,
		"desc": "头顶长着非常尖锐且含有剧毒的利角，遇到威胁时会使用毒针猛刺对手，将神经毒素注入敌人体内。",
		"skill_name": "毒针",
		"skill_desc": "将有毒的针刺入对手进行攻击。有时会让对手陷入中毒状态。",
		"skill_detail": "消耗100能量，使出【毒针】。将有毒的针刺入对手进行攻击。有时会让对手陷入中毒状态。 对目标造成162点伤害。",
		"skill_power": 162,
		"basic_attack": {
			"type": "physical",
			"name": "撞击",
			"style": "tackle",
			"sfx": "attack"
		},
						"skills": {
			1: [
				{
					"name": "毒针",
					"desc": "将有毒的针刺入对手进行攻击。有时会让对手陷入中毒状态。",
					"detail": "消耗100能量，使出【毒针】。将有毒的针刺入对手进行攻击。有时会让对手陷入中毒状态。 对目标造成162点伤害。",
					"power": 162,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "poison_sting",
					"sfx": "slash",
					"scale": 0.28
				},
				{
					"name": "电网",
					"desc": "用电网捉住对手进行攻击。降低对手的速度。",
					"detail": "消耗100能量，使出【电网】。用电网捉住对手进行攻击。降低对手的速度。 对目标造成210点伤害。",
					"power": 210,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "electroweb",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "飞弹针",
					"desc": "向对手发射锐针进行攻击。连续攻击２～５次。",
					"detail": "消耗100能量，使出【飞弹针】。向对手发射锐针进行攻击。连续攻击２～５次。 对目标造成150点伤害。",
					"power": 150,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "pin_missile",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "吐丝",
					"desc": "用口中吐出的丝缠绕对手，从而大幅降低对手的速度。",
					"detail": "消耗100能量，爆发【吐丝】。用口中吐出的丝缠绕对手，从而大幅降低对手的速度。 对范围内最多3名敌人造成300点伤害，并施加战术压制。",
					"power": 300,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "string_shot",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "十字剪",
					"desc": "将镰刀或爪子像剪刀般地交叉，顺势劈开对手。",
					"detail": "消耗100能量，爆发【十字剪】！将镰刀或爪子像剪刀般地交叉，顺势劈开对手。 对范围内最多2名敌人造成360点伤害，并施加战术压制。",
					"power": 360,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "x_scissor",
					"sfx": "slash",
					"scale": 1.10
				},
				{
					"name": "信号光束",
					"desc": "发射神奇的光线进行攻击。有时会使对手混乱。",
					"detail": "消耗100能量，爆发【信号光束】！发射神奇的光线进行攻击。有时会使对手混乱。 对范围内最多3名敌人造成345点伤害，并施加战术压制。",
					"power": 345,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "psybeam",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "虫咬",
					"desc": "咬住进行攻击。当对手携带树果时，可以食用并获得其效果。",
					"detail": "消耗100能量，释放终极奥义【虫咬】！咬住进行攻击。当对手携带树果时，可以食用并获得其效果。 席卷战场对最多6名敌人造成610点巨额伤害与强力击破！",
					"power": 610,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "leech_life",
					"sfx": "slash",
					"scale": 0.48
				},
				{
					"name": "虫鸣",
					"desc": "利用振动发出音波进行攻击。有时会降低对手的特防。",
					"detail": "消耗100能量，释放终极奥义【虫鸣】！利用振动发出音波进行攻击。有时会降低对手的特防。 席卷战场对最多6名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "bug_buzz",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "蝶舞",
					"desc": "轻巧地跳起神秘而又美丽的舞蹈。提高自己的特攻、特防和速度。",
					"detail": "消耗100能量，释放终极奥义【蝶舞】！轻巧地跳起神秘而又美丽的舞蹈。提高自己的特攻、特防和速度。 席卷战场对最多6名敌人造成680点巨额伤害与强力击破！",
					"power": 680,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "extreme_evoboost",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/weedle.png"
	},
	"kakuna": {
		"id": "kakuna",
		"name": "铁壳蛹",
		"title": "蛹宝可梦",
		"cost": 2,
		"types": ["Bug", "Poison"],
		"hp": 820,
		"atk": 38,
		"armor": 60,
		"mr": 50,
		"range": 1,
		"atk_speed": 0.58,
		"max_mana": 80,
		"desc": "身体几乎一动不动，但坚硬的金黄色外壳之下毒素正在高度压缩浓缩，受到撞击时会反弹毒液尖刺。",
		"skill_name": "变硬",
		"skill_desc": "全身使劲，让身体变硬，从而提高自己的防御。",
		"skill_detail": "消耗100能量，使出【变硬】。全身使劲，让身体变硬，从而提高自己的防御。 对目标造成160点伤害。",
		"skill_power": 160,
		"basic_attack": {
			"type": "physical",
			"name": "撞击",
			"style": "tackle",
			"sfx": "attack"
		},
						"skills": {
			1: [
				{
					"name": "变硬",
					"desc": "全身使劲，让身体变硬，从而提高自己的防御。",
					"detail": "消耗100能量，使出【变硬】。全身使劲，让身体变硬，从而提高自己的防御。 对目标造成160点伤害。",
					"power": 160,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "reflect",
					"sfx": "skill",
					"scale": 0.28
				},
				{
					"name": "虫咬",
					"desc": "咬住进行攻击。当对手携带树果时，可以食用并获得其效果。",
					"detail": "消耗100能量，使出【虫咬】。咬住进行攻击。当对手携带树果时，可以食用并获得其效果。 对目标造成220点伤害。",
					"power": 220,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "leech_life",
					"sfx": "slash",
					"scale": 0.82
				},
				{
					"name": "虫之抵抗",
					"desc": "抵抗并攻击对手。降低对手的特攻。",
					"detail": "消耗100能量，使出【虫之抵抗】。抵抗并攻击对手。降低对手的特攻。 对目标造成200点伤害。",
					"power": 200,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "bug_buzz",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "铁壁",
					"desc": "将皮肤变得坚硬如铁，从而大幅提高自己的防御。",
					"detail": "消耗100能量，爆发【铁壁】。将皮肤变得坚硬如铁，从而大幅提高自己的防御。 对范围内最多3名敌人造成300点伤害，并施加战术压制。",
					"power": 300,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "十字剪",
					"desc": "将镰刀或爪子像剪刀般地交叉，顺势劈开对手。",
					"detail": "消耗100能量，爆发【十字剪】！将镰刀或爪子像剪刀般地交叉，顺势劈开对手。 对范围内最多2名敌人造成360点伤害，并施加战术压制。",
					"power": 360,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "x_scissor",
					"sfx": "slash",
					"scale": 1.10
				},
				{
					"name": "信号光束",
					"desc": "发射神奇的光线进行攻击。有时会使对手混乱。",
					"detail": "消耗100能量，爆发【信号光束】！发射神奇的光线进行攻击。有时会使对手混乱。 对范围内最多3名敌人造成345点伤害，并施加战术压制。",
					"power": 345,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "psybeam",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "毒针",
					"desc": "将有毒的针刺入对手进行攻击。有时会让对手陷入中毒状态。",
					"detail": "消耗100能量，释放终极奥义【毒针】！将有毒的针刺入对手进行攻击。有时会让对手陷入中毒状态。 席卷战场对最多6名敌人造成542点巨额伤害与强力击破！",
					"power": 542,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "poison_sting",
					"sfx": "slash",
					"scale": 0.48
				},
				{
					"name": "飞弹针",
					"desc": "向对手发射锐针进行攻击。连续攻击２～５次。",
					"detail": "消耗100能量，释放终极奥义【飞弹针】！向对手发射锐针进行攻击。连续攻击２～５次。 席卷战场对最多4名敌人造成305点巨额伤害与强力击破！",
					"power": 305,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "pin_missile",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "蝶舞",
					"desc": "轻巧地跳起神秘而又美丽的舞蹈。提高自己的特攻、特防和速度。",
					"detail": "消耗100能量，释放终极奥义【蝶舞】！轻巧地跳起神秘而又美丽的舞蹈。提高自己的特攻、特防和速度。 席卷战场对最多6名敌人造成680点巨额伤害与强力击破！",
					"power": 680,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "extreme_evoboost",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/kakuna.png"
	},
	"beedrill": {
		"id": "beedrill",
		"name": "大针蜂",
		"title": "毒蜂宝可梦",
		"cost": 3,
		"types": ["Bug", "Poison"],
		"hp": 760,
		"atk": 82,
		"armor": 35,
		"mr": 35,
		"range": 1,
		"atk_speed": 0.85,
		"max_mana": 75,
		"desc": "以极高速在敌阵穿梭突刺，双手与尾部的三枚剧毒长枪能以每秒十连击的频率撕碎目标的致命弱点！",
		"skill_name": "乱击",
		"skill_desc": "用角或喙刺向对手进行攻击。连续攻击２～５次。",
		"skill_detail": "消耗100能量，使出【乱击】。用角或喙刺向对手进行攻击。连续攻击２～５次。 对目标造成162点伤害。",
		"skill_power": 162,
		"basic_attack": {
			"type": "physical",
			"name": "撞击",
			"style": "tackle",
			"sfx": "attack"
		},
						"skills": {
			1: [
				{
					"name": "乱击",
					"desc": "用角或喙刺向对手进行攻击。连续攻击２～５次。",
					"detail": "消耗100能量，使出【乱击】。用角或喙刺向对手进行攻击。连续攻击２～５次。 对目标造成162点伤害。",
					"power": 162,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "slash",
					"sfx": "slash",
					"scale": 0.28
				},
				{
					"name": "双针",
					"desc": "将２根针刺入对手，连续２次给予伤害。有时会让对手陷入中毒状态。",
					"detail": "消耗100能量，使出【双针】。将２根针刺入对手，连续２次给予伤害。有时会让对手陷入中毒状态。 对目标造成150点伤害。",
					"power": 150,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "毒针",
					"desc": "将有毒的针刺入对手进行攻击。有时会让对手陷入中毒状态。",
					"detail": "消耗100能量，使出【毒针】。将有毒的针刺入对手进行攻击。有时会让对手陷入中毒状态。 对目标造成130点伤害。",
					"power": 130,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "poison_sting",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "飞弹针",
					"desc": "向对手发射锐针进行攻击。连续攻击２～５次。",
					"detail": "消耗100能量，爆发【飞弹针】。向对手发射锐针进行攻击。连续攻击２～５次。 对范围内最多3名敌人造成285点伤害，并施加战术压制。",
					"power": 285,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "pin_missile",
					"sfx": "slash",
					"scale": 0.36
				},
				{
					"name": "吐丝",
					"desc": "用口中吐出的丝缠绕对手，从而大幅降低对手的速度。",
					"detail": "消耗100能量，爆发【吐丝】！用口中吐出的丝缠绕对手，从而大幅降低对手的速度。 对范围内最多3名敌人造成320点伤害，并施加战术压制。",
					"power": 320,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "string_shot",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "蛮干",
					"desc": "给予伤害，使对手的ＨＰ变得和自己的ＨＰ一样。",
					"detail": "消耗100能量，爆发【蛮干】！给予伤害，使对手的ＨＰ变得和自己的ＨＰ一样。 对范围内最多2名敌人造成320点伤害，并施加战术压制。",
					"power": 320,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "十字毒刃",
					"desc": "用毒刃劈开对手。有时会让对手陷入中毒状态，也容易击中要害。",
					"detail": "消耗100能量，释放终极奥义【十字毒刃】！用毒刃劈开对手。有时会让对手陷入中毒状态，也容易击中要害。 席卷战场对最多6名敌人造成625点巨额伤害与强力击破！",
					"power": 625,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "poison_jab",
					"sfx": "slash",
					"scale": 0.48
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，释放终极奥义【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 席卷战场对最多4名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "舍身冲撞",
					"desc": "拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。",
					"detail": "消耗100能量，释放终极奥义【舍身冲撞】！拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "double_edge",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/beedrill.png"
	},
	"pidgey": {
		"id": "pidgey",
		"name": "波波",
		"title": "小鸟宝可梦",
		"cost": 1,
		"types": ["Normal", "Flying"],
		"hp": 540,
		"atk": 48,
		"armor": 25,
		"mr": 25,
		"range": 3,
		"atk_speed": 0.72,
		"max_mana": 80,
		"desc": "性格温顺不喜欢争斗，但受到攻击时会猛烈拍打翅膀卷起沙尘与狂风迷住敌人的双眼并迅速拉开距离。",
		"skill_name": "起风",
		"skill_desc": "用翅膀将刮起的狂风袭向对手进行攻击。",
		"skill_detail": "消耗100能量，使出【起风】。用翅膀将刮起的狂风袭向对手进行攻击。 对目标造成182点伤害。",
		"skill_power": 182,
		"basic_attack": {
			"type": "special",
			"name": "魔法弹",
			"style": "spark",
			"sfx": "swift"
		},
						"skills": {
			1: [
				{
					"name": "起风",
					"desc": "用翅膀将刮起的狂风袭向对手进行攻击。",
					"detail": "消耗100能量，使出【起风】。用翅膀将刮起的狂风袭向对手进行攻击。 对目标造成182点伤害。",
					"power": 182,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "gust",
					"sfx": "swift",
					"scale": 0.28
				},
				{
					"name": "撞击",
					"desc": "用整个身体撞向对手进行攻击。",
					"detail": "消耗100能量，使出【撞击】。用整个身体撞向对手进行攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "tackle",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "龙卷风",
					"desc": "兴起龙卷风，将对手卷入进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，使出【龙卷风】。兴起龙卷风，将对手卷入进行攻击。有时会使对手畏缩。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "twister",
					"sfx": "slash",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "电光一闪",
					"desc": "以迅雷不及掩耳之势扑向对手。必定能够先制攻击。",
					"detail": "消耗100能量，爆发【电光一闪】。以迅雷不及掩耳之势扑向对手。必定能够先制攻击。 对范围内最多3名敌人造成300点伤害，并施加战术压制。",
					"power": 300,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "quick_attack",
					"sfx": "swift",
					"scale": 0.36
				},
				{
					"name": "翅膀攻击",
					"desc": "大大地展开美丽的翅膀，将其撞向对手进行攻击。",
					"detail": "消耗100能量，爆发【翅膀攻击】！大大地展开美丽的翅膀，将其撞向对手进行攻击。 对范围内最多2名敌人造成300点伤害，并施加战术压制。",
					"power": 300,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "wing_attack",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "飞翔",
					"desc": "第１回合飞上天空，第２回合攻击对手。",
					"detail": "消耗100能量，爆发【飞翔】！第１回合飞上天空，第２回合攻击对手。 对范围内最多2名敌人造成390点伤害，并施加战术压制。",
					"power": 390,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "brave_bird",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "空气斩",
					"desc": "用连天空也能劈开的空气之刃进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，释放终极奥义【空气斩】！用连天空也能劈开的空气之刃进行攻击。有时会使对手畏缩。 席卷战场对最多6名敌人造成632点巨额伤害与强力击破！",
					"power": 632,
					"target_count": 6,
					"stun_duration": 1.2,
					"vfx": "air_slash",
					"sfx": "slash",
					"scale": 0.48
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，释放终极奥义【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 席卷战场对最多4名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "舍身冲撞",
					"desc": "拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。",
					"detail": "消耗100能量，释放终极奥义【舍身冲撞】！拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "double_edge",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/pidgey.png"
	},
	"pidgeotto": {
		"id": "pidgeotto",
		"name": "比比鸟",
		"title": "鸟宝可梦",
		"cost": 2,
		"types": ["Normal", "Flying"],
		"hp": 740,
		"atk": 64,
		"armor": 32,
		"mr": 32,
		"range": 3,
		"atk_speed": 0.75,
		"max_mana": 80,
		"desc": "拥有极佳的视力与锐利的弯爪，在宽广领地上空巡视，俯冲时能以音速切开空气并精准猎杀敌人。",
		"skill_name": "起风",
		"skill_desc": "用翅膀将刮起的狂风袭向对手进行攻击。",
		"skill_detail": "消耗100能量，使出【起风】。用翅膀将刮起的狂风袭向对手进行攻击。 对目标造成182点伤害。",
		"skill_power": 182,
		"basic_attack": {
			"type": "special",
			"name": "魔法弹",
			"style": "spark",
			"sfx": "swift"
		},
						"skills": {
			1: [
				{
					"name": "起风",
					"desc": "用翅膀将刮起的狂风袭向对手进行攻击。",
					"detail": "消耗100能量，使出【起风】。用翅膀将刮起的狂风袭向对手进行攻击。 对目标造成182点伤害。",
					"power": 182,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "gust",
					"sfx": "swift",
					"scale": 0.28
				},
				{
					"name": "撞击",
					"desc": "用整个身体撞向对手进行攻击。",
					"detail": "消耗100能量，使出【撞击】。用整个身体撞向对手进行攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "tackle",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "龙卷风",
					"desc": "兴起龙卷风，将对手卷入进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，使出【龙卷风】。兴起龙卷风，将对手卷入进行攻击。有时会使对手畏缩。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "twister",
					"sfx": "slash",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "翅膀攻击",
					"desc": "大大地展开美丽的翅膀，将其撞向对手进行攻击。",
					"detail": "消耗100能量，爆发【翅膀攻击】。大大地展开美丽的翅膀，将其撞向对手进行攻击。 对范围内最多3名敌人造成320点伤害，并施加战术压制。",
					"power": 320,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "wing_attack",
					"sfx": "slash",
					"scale": 0.36
				},
				{
					"name": "电光一闪",
					"desc": "以迅雷不及掩耳之势扑向对手。必定能够先制攻击。",
					"detail": "消耗100能量，爆发【电光一闪】！以迅雷不及掩耳之势扑向对手。必定能够先制攻击。 对范围内最多2名敌人造成240点伤害，并施加战术压制。",
					"power": 240,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "空气斩",
					"desc": "用连天空也能劈开的空气之刃进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，爆发【空气斩】！用连天空也能劈开的空气之刃进行攻击。有时会使对手畏缩。 对范围内最多3名敌人造成345点伤害，并施加战术压制。",
					"power": 345,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "air_slash",
					"sfx": "slash",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "勇鸟猛攻",
					"desc": "收拢翅膀，通过低空飞行突击对手。自己也会受到不小的伤害。",
					"detail": "消耗100能量，释放终极奥义【勇鸟猛攻】！收拢翅膀，通过低空飞行突击对手。自己也会受到不小的伤害。 席卷战场对最多6名敌人造成700点巨额伤害与强力击破！",
					"power": 700,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "brave_bird",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，释放终极奥义【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 席卷战场对最多4名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "舍身冲撞",
					"desc": "拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。",
					"detail": "消耗100能量，释放终极奥义【舍身冲撞】！拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "double_edge",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/pidgeotto.png"
	},
	"pidgeot": {
		"id": "pidgeot",
		"name": "大比鸟",
		"title": "鸟宝可梦",
		"cost": 3,
		"types": ["Normal", "Flying"],
		"hp": 920,
		"atk": 82,
		"armor": 40,
		"mr": 40,
		"range": 3,
		"atk_speed": 0.8,
		"max_mana": 80,
		"desc": "胸肌极其发达，能以2马赫的速度在天空翱翔，巨大双翼只需轻轻拍动就能制造连拔起大树的超级飓风！",
		"skill_name": "空气斩",
		"skill_desc": "用连天空也能劈开的空气之刃进行攻击。有时会使对手畏缩。",
		"skill_detail": "消耗100能量，使出【空气斩】。用连天空也能劈开的空气之刃进行攻击。有时会使对手畏缩。 对目标造成210点伤害。",
		"skill_power": 210,
		"basic_attack": {
			"type": "special",
			"name": "魔法弹",
			"style": "spark",
			"sfx": "swift"
		},
						"skills": {
			1: [
				{
					"name": "空气斩",
					"desc": "用连天空也能劈开的空气之刃进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，使出【空气斩】。用连天空也能劈开的空气之刃进行攻击。有时会使对手畏缩。 对目标造成210点伤害。",
					"power": 210,
					"target_count": 1,
					"stun_duration": 0.5,
					"vfx": "air_slash",
					"sfx": "slash",
					"scale": 0.28
				},
				{
					"name": "起风",
					"desc": "用翅膀将刮起的狂风袭向对手进行攻击。",
					"detail": "消耗100能量，使出【起风】。用翅膀将刮起的狂风袭向对手进行攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "gust",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "电光一闪",
					"desc": "以迅雷不及掩耳之势扑向对手。必定能够先制攻击。",
					"detail": "消耗100能量，使出【电光一闪】。以迅雷不及掩耳之势扑向对手。必定能够先制攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "暴风",
					"desc": "用强烈的风席卷对手进行攻击。有时会使对手混乱。",
					"detail": "消耗100能量，爆发【暴风】。用强烈的风席卷对手进行攻击。有时会使对手混乱。 对范围内最多3名敌人造成370点伤害，并施加战术压制。",
					"power": 370,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "twister",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "龙卷风",
					"desc": "兴起龙卷风，将对手卷入进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，爆发【龙卷风】！兴起龙卷风，将对手卷入进行攻击。有时会使对手畏缩。 对范围内最多3名敌人造成240点伤害，并施加战术压制。",
					"power": 240,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "tackle",
					"sfx": "slash",
					"scale": 1.10
				},
				{
					"name": "高速星星",
					"desc": "发射星形的光攻击对手。攻击必定会命中。",
					"detail": "消耗100能量，爆发【高速星星】！发射星形的光攻击对手。攻击必定会命中。 对范围内最多3名敌人造成300点伤害，并施加战术压制。",
					"power": 300,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "swift",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "勇鸟猛攻",
					"desc": "收拢翅膀，通过低空飞行突击对手。自己也会受到不小的伤害。",
					"detail": "消耗100能量，释放终极奥义【勇鸟猛攻】！收拢翅膀，通过低空飞行突击对手。自己也会受到不小的伤害。 席卷战场对最多6名敌人造成700点巨额伤害与强力击破！",
					"power": 700,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "brave_bird",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "翅膀攻击",
					"desc": "大大地展开美丽的翅膀，将其撞向对手进行攻击。",
					"detail": "消耗100能量，释放终极奥义【翅膀攻击】！大大地展开美丽的翅膀，将其撞向对手进行攻击。 席卷战场对最多4名敌人造成480点巨额伤害与强力击破！",
					"power": 480,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "wing_attack",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，释放终极奥义【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 席卷战场对最多4名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/pidgeot.png"
	},
	"rattata": {
		"id": "rattata",
		"name": "小拉达",
		"title": "鼠宝可梦",
		"cost": 1,
		"types": ["Normal"],
		"hp": 500,
		"atk": 54,
		"armor": 20,
		"mr": 20,
		"range": 1,
		"atk_speed": 0.78,
		"max_mana": 75,
		"desc": "生命力极强的小型啮齿动物，长有一对终生生长的大门牙，无论什么坚硬的东西都能咬碎嚼烂。",
		"skill_name": "撞击",
		"skill_desc": "用整个身体撞向对手进行攻击。",
		"skill_detail": "消耗100能量，使出【撞击】。用整个身体撞向对手进行攻击。 对目标造成182点伤害。",
		"skill_power": 182,
		"basic_attack": {
			"type": "physical",
			"name": "撞击",
			"style": "tackle",
			"sfx": "attack"
		},
						"skills": {
			1: [
				{
					"name": "撞击",
					"desc": "用整个身体撞向对手进行攻击。",
					"detail": "消耗100能量，使出【撞击】。用整个身体撞向对手进行攻击。 对目标造成182点伤害。",
					"power": 182,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "tackle",
					"sfx": "attack",
					"scale": 0.28
				},
				{
					"name": "电光一闪",
					"desc": "以迅雷不及掩耳之势扑向对手。必定能够先制攻击。",
					"detail": "消耗100能量，使出【电光一闪】。以迅雷不及掩耳之势扑向对手。必定能够先制攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "恶意追击",
					"desc": "如果此回合内对手已经受到伤害的话，招式威力会变成２倍。",
					"detail": "消耗100能量，使出【恶意追击】。如果此回合内对手已经受到伤害的话，招式威力会变成２倍。 对目标造成220点伤害。",
					"power": 220,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "必杀门牙",
					"desc": "用锋利的门牙牢牢地咬住对手进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，爆发【必杀门牙】。用锋利的门牙牢牢地咬住对手进行攻击。有时会使对手畏缩。 对范围内最多3名敌人造成340点伤害，并施加战术压制。",
					"power": 340,
					"target_count": 3,
					"stun_duration": 0.8,
					"vfx": "headbutt",
					"sfx": "bite",
					"scale": 0.36
				},
				{
					"name": "咬碎",
					"desc": "用利牙咬碎对手进行攻击。有时会降低对手的防御。",
					"detail": "消耗100能量，爆发【咬碎】！用利牙咬碎对手进行攻击。有时会降低对手的防御。 对范围内最多2名敌人造成360点伤害，并施加战术压制。",
					"power": 360,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "crunch",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，爆发【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 对范围内最多2名敌人造成390点伤害，并施加战术压制。",
					"power": 390,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "舍身冲撞",
					"desc": "拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。",
					"detail": "消耗100能量，释放终极奥义【舍身冲撞】！拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "double_edge",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "暴风雪",
					"desc": "将猛烈的暴风雪刮向对手进行攻击。有时会让对手陷入冰冻状态。",
					"detail": "消耗100能量，释放终极奥义【暴风雪】！将猛烈的暴风雪刮向对手进行攻击。有时会让对手陷入冰冻状态。 席卷战场对最多6名敌人造成730点巨额伤害与强力击破！",
					"power": 730,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "blizzard",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "十万伏特",
					"desc": "向对手发出强力电击进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，释放终极奥义【十万伏特】！向对手发出强力电击进行攻击。有时会让对手陷入麻痹状态。 席卷战场对最多6名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "thunderbolt",
					"sfx": "thunder",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/rattata.png"
	},
	"raticate": {
		"id": "raticate",
		"name": "拉达",
		"title": "鼠宝可梦",
		"cost": 2,
		"types": ["Normal"],
		"hp": 760,
		"atk": 72,
		"armor": 32,
		"mr": 32,
		"range": 1,
		"atk_speed": 0.8,
		"max_mana": 75,
		"desc": "胡须用来保持平衡，坚硬的大门牙能咬穿坚实的水泥墙壁，战斗时凭借凶恶的面容恐吓对手并猛烈啃咬！",
		"skill_name": "电光一闪",
		"skill_desc": "以迅雷不及掩耳之势扑向对手。必定能够先制攻击。",
		"skill_detail": "消耗100能量，使出【电光一闪】。以迅雷不及掩耳之势扑向对手。必定能够先制攻击。 对目标造成182点伤害。",
		"skill_power": 182,
		"basic_attack": {
			"type": "physical",
			"name": "撞击",
			"style": "tackle",
			"sfx": "attack"
		},
						"skills": {
			1: [
				{
					"name": "电光一闪",
					"desc": "以迅雷不及掩耳之势扑向对手。必定能够先制攻击。",
					"detail": "消耗100能量，使出【电光一闪】。以迅雷不及掩耳之势扑向对手。必定能够先制攻击。 对目标造成182点伤害。",
					"power": 182,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "quick_attack",
					"sfx": "swift",
					"scale": 0.28
				},
				{
					"name": "撞击",
					"desc": "用整个身体撞向对手进行攻击。",
					"detail": "消耗100能量，使出【撞击】。用整个身体撞向对手进行攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "tackle",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "恶意追击",
					"desc": "如果此回合内对手已经受到伤害的话，招式威力会变成２倍。",
					"detail": "消耗100能量，使出【恶意追击】。如果此回合内对手已经受到伤害的话，招式威力会变成２倍。 对目标造成220点伤害。",
					"power": 220,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "必杀门牙",
					"desc": "用锋利的门牙牢牢地咬住对手进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，爆发【必杀门牙】。用锋利的门牙牢牢地咬住对手进行攻击。有时会使对手畏缩。 对范围内最多3名敌人造成340点伤害，并施加战术压制。",
					"power": 340,
					"target_count": 3,
					"stun_duration": 0.8,
					"vfx": "headbutt",
					"sfx": "bite",
					"scale": 0.36
				},
				{
					"name": "咬碎",
					"desc": "用利牙咬碎对手进行攻击。有时会降低对手的防御。",
					"detail": "消耗100能量，爆发【咬碎】！用利牙咬碎对手进行攻击。有时会降低对手的防御。 对范围内最多2名敌人造成360点伤害，并施加战术压制。",
					"power": 360,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "crunch",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，爆发【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 对范围内最多2名敌人造成390点伤害，并施加战术压制。",
					"power": 390,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "舍身冲撞",
					"desc": "拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。",
					"detail": "消耗100能量，释放终极奥义【舍身冲撞】！拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "double_edge",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "暴风雪",
					"desc": "将猛烈的暴风雪刮向对手进行攻击。有时会让对手陷入冰冻状态。",
					"detail": "消耗100能量，释放终极奥义【暴风雪】！将猛烈的暴风雪刮向对手进行攻击。有时会让对手陷入冰冻状态。 席卷战场对最多6名敌人造成730点巨额伤害与强力击破！",
					"power": 730,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "blizzard",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "十万伏特",
					"desc": "向对手发出强力电击进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，释放终极奥义【十万伏特】！向对手发出强力电击进行攻击。有时会让对手陷入麻痹状态。 席卷战场对最多6名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "thunderbolt",
					"sfx": "thunder",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/raticate.png"
	},
	"spearow": {
		"id": "spearow",
		"name": "烈雀",
		"title": "小鸟宝可梦",
		"cost": 1,
		"types": ["Normal", "Flying"],
		"hp": 520,
		"atk": 52,
		"armor": 22,
		"mr": 22,
		"range": 2,
		"atk_speed": 0.75,
		"max_mana": 75,
		"desc": "脾气极其暴躁，领地意识极强，发出高亢尖叫呼唤同伴，短小双翼以极高频率扇动，俯冲啄击敌人。",
		"skill_name": "啄",
		"skill_desc": "用尖锐的喙或角刺向对手进行攻击。",
		"skill_detail": "消耗100能量，使出【啄】。用尖锐的喙或角刺向对手进行攻击。 对目标造成178点伤害。",
		"skill_power": 178,
		"basic_attack": {
			"type": "special",
			"name": "魔法弹",
			"style": "spark",
			"sfx": "swift"
		},
						"skills": {
			1: [
				{
					"name": "啄",
					"desc": "用尖锐的喙或角刺向对手进行攻击。",
					"detail": "消耗100能量，使出【啄】。用尖锐的喙或角刺向对手进行攻击。 对目标造成178点伤害。",
					"power": 178,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "drill_peck",
					"sfx": "slash",
					"scale": 0.28
				},
				{
					"name": "追打",
					"desc": "当对手替换宝可梦上场时使出此招式的话，能够以２倍的威力进行攻击。",
					"detail": "消耗100能量，使出【追打】。当对手替换宝可梦上场时使出此招式的话，能够以２倍的威力进行攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "tackle",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，使出【猛撞】。以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 对目标造成280点伤害。",
					"power": 280,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "乱击",
					"desc": "用角或喙刺向对手进行攻击。连续攻击２～５次。",
					"detail": "消耗100能量，爆发【乱击】。用角或喙刺向对手进行攻击。连续攻击２～５次。 对范围内最多3名敌人造成275点伤害，并施加战术压制。",
					"power": 275,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "air_slash",
					"sfx": "slash",
					"scale": 0.36
				},
				{
					"name": "翅膀攻击",
					"desc": "大大地展开美丽的翅膀，将其撞向对手进行攻击。",
					"detail": "消耗100能量，爆发【翅膀攻击】！大大地展开美丽的翅膀，将其撞向对手进行攻击。 对范围内最多2名敌人造成300点伤害，并施加战术压制。",
					"power": 300,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "wing_attack",
					"sfx": "slash",
					"scale": 1.10
				},
				{
					"name": "飞翔",
					"desc": "第１回合飞上天空，第２回合攻击对手。",
					"detail": "消耗100能量，爆发【飞翔】！第１回合飞上天空，第２回合攻击对手。 对范围内最多2名敌人造成390点伤害，并施加战术压制。",
					"power": 390,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "brave_bird",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "舍身冲撞",
					"desc": "拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。",
					"detail": "消耗100能量，释放终极奥义【舍身冲撞】！拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "double_edge",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "破坏光线",
					"desc": "向对手发射强烈的光线进行攻击。下一回合自己将无法动弹。",
					"detail": "消耗100能量，释放终极奥义【破坏光线】！向对手发射强烈的光线进行攻击。下一回合自己将无法动弹。 席卷战场对最多6名敌人造成930点巨额伤害与强力击破！",
					"power": 930,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "hyper_beam",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "三重攻击",
					"desc": "用３种光线进行攻击。有时会让对手陷入麻痹、灼伤或冰冻的状态。",
					"detail": "消耗100能量，释放终极奥义【三重攻击】！用３种光线进行攻击。有时会让对手陷入麻痹、灼伤或冰冻的状态。 席卷战场对最多6名敌人造成580点巨额伤害与强力击破！",
					"power": 580,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "tri_attack",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/spearow.png"
	},
	"fearow": {
		"id": "fearow",
		"name": "大嘴雀",
		"title": "鸟宝可梦",
		"cost": 2,
		"types": ["Normal", "Flying"],
		"hp": 760,
		"atk": 74,
		"armor": 32,
		"mr": 32,
		"range": 2,
		"atk_speed": 0.78,
		"max_mana": 80,
		"desc": "长有长而尖锐的巨喙与宽大有力的翅膀，耐力惊人能整天不着地飞翔，锁定猎物后以音速钻刺轰杀目标！",
		"skill_name": "燕返",
		"skill_desc": "以敏捷的动作戏弄对手后进行切斩。攻击必定会命中。",
		"skill_detail": "消耗100能量，使出【燕返】。以敏捷的动作戏弄对手后进行切斩。攻击必定会命中。 对目标造成198点伤害。",
		"skill_power": 198,
		"basic_attack": {
			"type": "special",
			"name": "魔法弹",
			"style": "spark",
			"sfx": "swift"
		},
						"skills": {
			1: [
				{
					"name": "燕返",
					"desc": "以敏捷的动作戏弄对手后进行切斩。攻击必定会命中。",
					"detail": "消耗100能量，使出【燕返】。以敏捷的动作戏弄对手后进行切斩。攻击必定会命中。 对目标造成198点伤害。",
					"power": 198,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "air_slash",
					"sfx": "slash",
					"scale": 0.28
				},
				{
					"name": "剧毒",
					"desc": "让对手陷入剧毒状态。随着回合的推进，中毒伤害会增加。",
					"detail": "消耗100能量，使出【剧毒】。让对手陷入剧毒状态。随着回合的推进，中毒伤害会增加。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "toxic",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "翅膀攻击",
					"desc": "大大地展开美丽的翅膀，将其撞向对手进行攻击。",
					"detail": "消耗100能量，使出【翅膀攻击】。大大地展开美丽的翅膀，将其撞向对手进行攻击。 对目标造成220点伤害。",
					"power": 220,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "wing_attack",
					"sfx": "slash",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "啄钻",
					"desc": "一边旋转，一边将尖喙刺入对手进行攻击。",
					"detail": "消耗100能量，爆发【啄钻】。一边旋转，一边将尖喙刺入对手进行攻击。 对范围内最多3名敌人造成340点伤害，并施加战术压制。",
					"power": 340,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "drill_peck",
					"sfx": "slash",
					"scale": 0.36
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，爆发【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 对范围内最多2名敌人造成390点伤害，并施加战术压制。",
					"power": 390,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "舍身冲撞",
					"desc": "拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。",
					"detail": "消耗100能量，爆发【舍身冲撞】！拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。 对范围内最多2名敌人造成480点伤害，并施加战术压制。",
					"power": 480,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "double_edge",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "勇鸟猛攻",
					"desc": "收拢翅膀，通过低空飞行突击对手。自己也会受到不小的伤害。",
					"detail": "消耗100能量，释放终极奥义【勇鸟猛攻】！收拢翅膀，通过低空飞行突击对手。自己也会受到不小的伤害。 席卷战场对最多6名敌人造成700点巨额伤害与强力击破！",
					"power": 700,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "brave_bird",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "追打",
					"desc": "当对手替换宝可梦上场时使出此招式的话，能够以２倍的威力进行攻击。",
					"detail": "消耗100能量，释放终极奥义【追打】！当对手替换宝可梦上场时使出此招式的话，能够以２倍的威力进行攻击。 席卷战场对最多4名敌人造成380点巨额伤害与强力击破！",
					"power": 380,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "tackle",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "三重攻击",
					"desc": "用３种光线进行攻击。有时会让对手陷入麻痹、灼伤或冰冻的状态。",
					"detail": "消耗100能量，释放终极奥义【三重攻击】！用３种光线进行攻击。有时会让对手陷入麻痹、灼伤或冰冻的状态。 席卷战场对最多6名敌人造成580点巨额伤害与强力击破！",
					"power": 580,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "tri_attack",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/fearow.png"
	},
	"ekans": {
		"id": "ekans",
		"name": "阿柏蛇",
		"title": "蛇宝可梦",
		"cost": 1,
		"types": ["Poison"],
		"hp": 560,
		"atk": 50,
		"armor": 28,
		"mr": 28,
		"range": 1,
		"atk_speed": 0.7,
		"max_mana": 80,
		"desc": "无声无息地在草丛中潜行，下颚能完全脱臼吞下庞大的猎物，蛇信微颤能探测空气中的体温与气味。",
		"skill_name": "毒针",
		"skill_desc": "将有毒的针刺入对手进行攻击。有时会让对手陷入中毒状态。",
		"skill_detail": "消耗100能量，使出【毒针】。将有毒的针刺入对手进行攻击。有时会让对手陷入中毒状态。 对目标造成162点伤害。",
		"skill_power": 162,
		"basic_attack": {
			"type": "physical",
			"name": "咬住",
			"style": "bite",
			"sfx": "bite"
		},
						"skills": {
			1: [
				{
					"name": "毒针",
					"desc": "将有毒的针刺入对手进行攻击。有时会让对手陷入中毒状态。",
					"detail": "消耗100能量，使出【毒针】。将有毒的针刺入对手进行攻击。有时会让对手陷入中毒状态。 对目标造成162点伤害。",
					"power": 162,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "poison_sting",
					"sfx": "slash",
					"scale": 0.28
				},
				{
					"name": "紧束",
					"desc": "使用长长的身体或藤蔓等，在４～５回合内紧束对手进行攻击。",
					"detail": "消耗100能量，使出【紧束】。使用长长的身体或藤蔓等，在４～５回合内紧束对手进行攻击。 对目标造成130点伤害。",
					"power": 130,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "泰山压顶",
					"desc": "用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，使出【泰山压顶】。用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。 对目标造成270点伤害。",
					"power": 270,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "咬住",
					"desc": "用尖锐的牙咬住对手进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，爆发【咬住】。用尖锐的牙咬住对手进行攻击。有时会使对手畏缩。 对范围内最多3名敌人造成320点伤害，并施加战术压制。",
					"power": 320,
					"target_count": 3,
					"stun_duration": 0.8,
					"vfx": "bite",
					"sfx": "bite",
					"scale": 0.36
				},
				{
					"name": "毒击",
					"desc": "用带毒的触手或手臂刺入对手。有时会让对手陷入中毒状态。",
					"detail": "消耗100能量，爆发【毒击】！用带毒的触手或手臂刺入对手。有时会让对手陷入中毒状态。 对范围内最多2名敌人造成360点伤害，并施加战术压制。",
					"power": 360,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "poison_jab",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，爆发【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 对范围内最多2名敌人造成390点伤害，并施加战术压制。",
					"power": 390,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "溶解液",
					"desc": "将强酸泼向对手进行攻击。有时会降低对手的特防。",
					"detail": "消耗100能量，释放终极奥义【溶解液】！将强酸泼向对手进行攻击。有时会降低对手的特防。 席卷战场对最多6名敌人造成580点巨额伤害与强力击破！",
					"power": 580,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "sludge_bomb",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "舍身冲撞",
					"desc": "拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。",
					"detail": "消耗100能量，释放终极奥义【舍身冲撞】！拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "double_edge",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "垃圾射击",
					"desc": "用肮脏的垃圾撞向对手进行攻击。有时会让对手陷入中毒状态。",
					"detail": "消耗100能量，释放终极奥义【垃圾射击】！用肮脏的垃圾撞向对手进行攻击。有时会让对手陷入中毒状态。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "gunk_shot",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/ekans.png"
	},
	"arbok": {
		"id": "arbok",
		"name": "阿柏怪",
		"title": "眼镜蛇宝可梦",
		"cost": 3,
		"types": ["Poison"],
		"hp": 880,
		"atk": 78,
		"armor": 42,
		"mr": 42,
		"range": 1,
		"atk_speed": 0.75,
		"max_mana": 80,
		"desc": "胸腹部的恐怖花纹能恐吓并石化猎物，拥有足以压扁钢铁油桶的惊人绞杀力量，毒牙含致命剧毒。",
		"skill_name": "剧毒牙",
		"skill_desc": "用有毒的牙齿咬住对手进行攻击。有时会使对手中剧毒。",
		"skill_detail": "消耗100能量，使出【剧毒牙】。用有毒的牙齿咬住对手进行攻击。有时会使对手中剧毒。 对目标造成190点伤害。",
		"skill_power": 190,
		"basic_attack": {
			"type": "physical",
			"name": "咬住",
			"style": "bite",
			"sfx": "bite"
		},
						"skills": {
			1: [
				{
					"name": "剧毒牙",
					"desc": "用有毒的牙齿咬住对手进行攻击。有时会使对手中剧毒。",
					"detail": "消耗100能量，使出【剧毒牙】。用有毒的牙齿咬住对手进行攻击。有时会使对手中剧毒。 对目标造成190点伤害。",
					"power": 190,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "poison_sting",
					"sfx": "bite",
					"scale": 0.28
				},
				{
					"name": "咬碎",
					"desc": "用利牙咬碎对手进行攻击。有时会降低对手的防御。",
					"detail": "消耗100能量，使出【咬碎】。用利牙咬碎对手进行攻击。有时会降低对手的防御。 对目标造成260点伤害。",
					"power": 260,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "crunch",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "突袭",
					"desc": "可以比对手先攻击。对手使出的招式如果不是攻击招式则会失败。",
					"detail": "消耗100能量，使出【突袭】。可以比对手先攻击。对手使出的招式如果不是攻击招式则会失败。 对目标造成240点伤害。",
					"power": 240,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "mach_punch",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "污泥炸弹",
					"desc": "用污泥投掷对手进行攻击。有时会让对手陷入中毒状态。",
					"detail": "消耗100能量，爆发【污泥炸弹】。用污泥投掷对手进行攻击。有时会让对手陷入中毒状态。 对范围内最多3名敌人造成350点伤害，并施加战术压制。",
					"power": 350,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "sludge_bomb",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "喷出",
					"desc": "将积蓄的力量撞向对手进行攻击。积蓄得越多，威力越大。",
					"detail": "消耗100能量，爆发【喷出】！将积蓄的力量撞向对手进行攻击。积蓄得越多，威力越大。 对范围内最多3名敌人造成320点伤害，并施加战术压制。",
					"power": 320,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "咬住",
					"desc": "用尖锐的牙咬住对手进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，爆发【咬住】！用尖锐的牙咬住对手进行攻击。有时会使对手畏缩。 对范围内最多2名敌人造成300点伤害，并施加战术压制。",
					"power": 300,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "bite",
					"sfx": "bite",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "垃圾射击",
					"desc": "用肮脏的垃圾撞向对手进行攻击。有时会让对手陷入中毒状态。",
					"detail": "消耗100能量，释放终极奥义【垃圾射击】！用肮脏的垃圾撞向对手进行攻击。有时会让对手陷入中毒状态。 席卷战场对最多6名敌人造成700点巨额伤害与强力击破！",
					"power": 700,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "gunk_shot",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "泰山压顶",
					"desc": "用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，释放终极奥义【泰山压顶】！用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。 席卷战场对最多4名敌人造成605点巨额伤害与强力击破！",
					"power": 605,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，释放终极奥义【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 席卷战场对最多4名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/arbok.png"
	},
	"raichu": {
		"id": "raichu",
		"name": "雷丘",
		"title": "鼠宝可梦",
		"cost": 3,
		"types": ["Electric"],
		"hp": 820,
		"atk": 75,
		"armor": 35,
		"mr": 35,
		"range": 3,
		"atk_speed": 0.82,
		"max_mana": 90,
		"desc": "长长的尾巴像避雷针一样保护自己，体内储存着超过十万伏特的超高电压，战斗时周身空气都散发着蓝白色电芒！",
		"skill_name": "电光",
		"skill_desc": "让电流覆盖全身，猛撞向对手进行攻击。有时会让对手陷入麻痹状态。",
		"skill_detail": "消耗100能量，使出【电光】。让电流覆盖全身，猛撞向对手进行攻击。有时会让对手陷入麻痹状态。 对目标造成202点伤害。",
		"skill_power": 202,
		"basic_attack": {
			"type": "special",
			"name": "电火花",
			"style": "spark",
			"sfx": "spark"
		},
						"skills": {
			1: [
				{
					"name": "电光",
					"desc": "让电流覆盖全身，猛撞向对手进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，使出【电光】。让电流覆盖全身，猛撞向对手进行攻击。有时会让对手陷入麻痹状态。 对目标造成202点伤害。",
					"power": 202,
					"target_count": 1,
					"stun_duration": 0.5,
					"vfx": "spark",
					"sfx": "spark",
					"scale": 0.28
				},
				{
					"name": "雷电拳",
					"desc": "用充满电流的拳头攻击对手。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，使出【雷电拳】。用充满电流的拳头攻击对手。有时会让对手陷入麻痹状态。 对目标造成250点伤害。",
					"power": 250,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "thunder_punch",
					"sfx": "thunder",
					"scale": 0.82
				},
				{
					"name": "高速星星",
					"desc": "发射星形的光攻击对手。攻击必定会命中。",
					"detail": "消耗100能量，使出【高速星星】。发射星形的光攻击对手。攻击必定会命中。 对目标造成220点伤害。",
					"power": 220,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "swift",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "放电",
					"desc": "用耀眼的电击攻击自己周围所有的宝可梦。有时会陷入麻痹状态。",
					"detail": "消耗100能量，爆发【放电】。用耀眼的电击攻击自己周围所有的宝可梦。有时会陷入麻痹状态。 对范围内最多3名敌人造成340点伤害，并施加战术压制。",
					"power": 340,
					"target_count": 3,
					"stun_duration": 0.8,
					"vfx": "discharge",
					"sfx": "thunder",
					"scale": 0.36
				},
				{
					"name": "十万伏特",
					"desc": "向对手发出强力电击进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，爆发【十万伏特】！向对手发出强力电击进行攻击。有时会让对手陷入麻痹状态。 对范围内最多3名敌人造成390点伤害，并施加战术压制。",
					"power": 390,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "thunderbolt",
					"sfx": "thunder",
					"scale": 1.10
				},
				{
					"name": "电击",
					"desc": "发出电流刺激对手进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，爆发【电击】！发出电流刺激对手进行攻击。有时会让对手陷入麻痹状态。 对范围内最多3名敌人造成240点伤害，并施加战术压制。",
					"power": 240,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "thundershock",
					"sfx": "thunder",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "打雷",
					"desc": "向对手劈下暴雷进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，释放终极奥义【打雷】！向对手劈下暴雷进行攻击。有时会让对手陷入麻痹状态。 席卷战场对最多6名敌人造成685点巨额伤害与强力击破！",
					"power": 685,
					"target_count": 6,
					"stun_duration": 1.2,
					"vfx": "thunder",
					"sfx": "thunder",
					"scale": 0.48
				},
				{
					"name": "千万伏特",
					"desc": "戴着帽子的皮卡丘将通过Ｚ力量增强的电击全力释放给对手。容易击中要害。",
					"detail": "消耗100能量，释放终极奥义【千万伏特】！戴着帽子的皮卡丘将通过Ｚ力量增强的电击全力释放给对手。容易击中要害。 席卷战场对最多6名敌人造成1155点巨额伤害与强力击破！",
					"power": 1155,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "volt_catastrophe",
					"sfx": "thunder",
					"scale": 1.55
				},
				{
					"name": "终极冲击",
					"desc": "使出自己浑身力量突击对手。下一回合自己将无法动弹。",
					"detail": "消耗100能量，释放终极奥义【终极冲击】！使出自己浑身力量突击对手。下一回合自己将无法动弹。 席卷战场对最多4名敌人造成930点巨额伤害与强力击破！",
					"power": 930,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "giga_impact",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/raichu.png"
	},
	"sandshrew": {
		"id": "sandshrew",
		"name": "穿山鼠",
		"title": "鼠宝可梦",
		"cost": 1,
		"types": ["Ground"],
		"hp": 620,
		"atk": 50,
		"armor": 40,
		"mr": 25,
		"range": 1,
		"atk_speed": 0.68,
		"max_mana": 80,
		"desc": "生活在干燥干燥的沙漠深处，遇到攻击时瞬间卷成坚硬带刺的肉球，锋利双爪擅长在坚固地底挖掘穿行。",
		"skill_name": "抓",
		"skill_desc": "用坚硬且无比锋利的爪子抓对手进行攻击。",
		"skill_detail": "消耗100能量，使出【抓】。用坚硬且无比锋利的爪子抓对手进行攻击。 对目标造成182点伤害。",
		"skill_power": 182,
		"basic_attack": {
			"type": "physical",
			"name": "撞击",
			"style": "tackle",
			"sfx": "attack"
		},
						"skills": {
			1: [
				{
					"name": "抓",
					"desc": "用坚硬且无比锋利的爪子抓对手进行攻击。",
					"detail": "消耗100能量，使出【抓】。用坚硬且无比锋利的爪子抓对手进行攻击。 对目标造成182点伤害。",
					"power": 182,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "slash",
					"sfx": "slash",
					"scale": 0.28
				},
				{
					"name": "毒针",
					"desc": "将有毒的针刺入对手进行攻击。有时会让对手陷入中毒状态。",
					"detail": "消耗100能量，使出【毒针】。将有毒的针刺入对手进行攻击。有时会让对手陷入中毒状态。 对目标造成130点伤害。",
					"power": 130,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "poison_sting",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "高速星星",
					"desc": "发射星形的光攻击对手。攻击必定会命中。",
					"detail": "消耗100能量，使出【高速星星】。发射星形的光攻击对手。攻击必定会命中。 对目标造成220点伤害。",
					"power": 220,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "swift",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "滚动",
					"desc": "在５回合内连续滚动攻击对手。招式每次击中，威力就会提高。",
					"detail": "消耗100能量，爆发【滚动】。在５回合内连续滚动攻击对手。招式每次击中，威力就会提高。 对范围内最多3名敌人造成290点伤害，并施加战术压制。",
					"power": 290,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "rock_slide",
					"sfx": "attack",
					"scale": 0.36
				},
				{
					"name": "乱抓",
					"desc": "用爪子或镰刀等抓对手进行攻击。连续攻击２～５次。",
					"detail": "消耗100能量，爆发【乱抓】！用爪子或镰刀等抓对手进行攻击。连续攻击２～５次。 对范围内最多2名敌人造成174点伤害，并施加战术压制。",
					"power": 174,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "headbutt",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "地震",
					"desc": "利用地震的冲击，攻击自己周围所有的宝可梦。",
					"detail": "消耗100能量，爆发【地震】！利用地震的冲击，攻击自己周围所有的宝可梦。 对范围内最多2名敌人造成420点伤害，并施加战术压制。",
					"power": 420,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "mud_slap",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "挖洞",
					"desc": "第１回合钻入，第２回合攻击对手。",
					"detail": "消耗100能量，释放终极奥义【挖洞】！第１回合钻入，第２回合攻击对手。 席卷战场对最多6名敌人造成640点巨额伤害与强力击破！",
					"power": 640,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "earthquake",
					"sfx": "attack",
					"scale": 0.48
				},
				{
					"name": "陀螺球",
					"desc": "让身体高速旋转并撞击对手。速度比对手越慢，威力越大。",
					"detail": "消耗100能量，释放终极奥义【陀螺球】！让身体高速旋转并撞击对手。速度比对手越慢，威力越大。 席卷战场对最多4名敌人造成680点巨额伤害与强力击破！",
					"power": 680,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，释放终极奥义【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 席卷战场对最多4名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/sandshrew.png"
	},
	"sandslash": {
		"id": "sandslash",
		"name": "穿山王",
		"title": "鼠宝可梦",
		"cost": 3,
		"types": ["Ground"],
		"hp": 880,
		"atk": 80,
		"armor": 55,
		"mr": 35,
		"range": 1,
		"atk_speed": 0.75,
		"max_mana": 80,
		"desc": "背部长满坚硬锋利的尖刺，能以极高速度蜷缩成旋转刺轮碾碎一切障碍物，锋利钢铁巨爪一击切裂岩壁！",
		"skill_name": "劈开",
		"skill_desc": "用爪子或镰刀等劈开对手进行攻击。容易击中要害。",
		"skill_detail": "消耗100能量，使出【劈开】。用爪子或镰刀等劈开对手进行攻击。容易击中要害。 对目标造成206点伤害。",
		"skill_power": 206,
		"basic_attack": {
			"type": "physical",
			"name": "抓击",
			"style": "slash",
			"sfx": "slash"
		},
						"skills": {
			1: [
				{
					"name": "劈开",
					"desc": "用爪子或镰刀等劈开对手进行攻击。容易击中要害。",
					"detail": "消耗100能量，使出【劈开】。用爪子或镰刀等劈开对手进行攻击。容易击中要害。 对目标造成206点伤害。",
					"power": 206,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "slash",
					"sfx": "slash",
					"scale": 0.28
				},
				{
					"name": "撕裂爪",
					"desc": "用坚硬的锐爪劈开对手进行攻击。有时会降低对手的防御。",
					"detail": "消耗100能量，使出【撕裂爪】。用坚硬的锐爪劈开对手进行攻击。有时会降低对手的防御。 对目标造成250点伤害。",
					"power": 250,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "毒针",
					"desc": "将有毒的针刺入对手进行攻击。有时会让对手陷入中毒状态。",
					"detail": "消耗100能量，使出【毒针】。将有毒的针刺入对手进行攻击。有时会让对手陷入中毒状态。 对目标造成130点伤害。",
					"power": 130,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "poison_sting",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "岩崩",
					"desc": "将大岩石猛烈地撞向对手进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，爆发【岩崩】。将大岩石猛烈地撞向对手进行攻击。有时会使对手畏缩。 对范围内最多3名敌人造成335点伤害，并施加战术压制。",
					"power": 335,
					"target_count": 3,
					"stun_duration": 0.8,
					"vfx": "rock_slide",
					"sfx": "attack",
					"scale": 0.36
				},
				{
					"name": "高速星星",
					"desc": "发射星形的光攻击对手。攻击必定会命中。",
					"detail": "消耗100能量，爆发【高速星星】！发射星形的光攻击对手。攻击必定会命中。 对范围内最多3名敌人造成300点伤害，并施加战术压制。",
					"power": 300,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "swift",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "陀螺球",
					"desc": "让身体高速旋转并撞击对手。速度比对手越慢，威力越大。",
					"detail": "消耗100能量，爆发【陀螺球】！让身体高速旋转并撞击对手。速度比对手越慢，威力越大。 对范围内最多2名敌人造成320点伤害，并施加战术压制。",
					"power": 320,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "地震",
					"desc": "利用地震的冲击，攻击自己周围所有的宝可梦。",
					"detail": "消耗100能量，释放终极奥义【地震】！利用地震的冲击，攻击自己周围所有的宝可梦。 席卷战场对最多6名敌人造成670点巨额伤害与强力击破！",
					"power": 670,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "earthquake",
					"sfx": "attack",
					"scale": 0.48
				},
				{
					"name": "乱抓",
					"desc": "用爪子或镰刀等抓对手进行攻击。连续攻击２～５次。",
					"detail": "消耗100能量，释放终极奥义【乱抓】！用爪子或镰刀等抓对手进行攻击。连续攻击２～５次。 席卷战场对最多4名敌人造成270点巨额伤害与强力击破！",
					"power": 270,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "headbutt",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "尖石攻击",
					"desc": "用尖尖的岩石刺入对手进行攻击。容易击中要害。",
					"detail": "消耗100能量，释放终极奥义【尖石攻击】！用尖尖的岩石刺入对手进行攻击。容易击中要害。 席卷战场对最多4名敌人造成680点巨额伤害与强力击破！",
					"power": 680,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "stone_edge",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/sandslash.png"
	},
	"nidoran_f": {
		"id": "nidoran_f",
		"name": "尼多兰",
		"title": "毒针宝可梦",
		"cost": 1,
		"types": ["Poison"],
		"hp": 580,
		"atk": 46,
		"armor": 30,
		"mr": 30,
		"range": 1,
		"atk_speed": 0.7,
		"max_mana": 80,
		"desc": "温顺害羞但绝不可轻视，背部隐藏着致命的剧毒尖刺，受到惊吓时会用头上的毒角反击敌人。",
		"skill_name": "抓",
		"skill_desc": "用坚硬且无比锋利的爪子抓对手进行攻击。",
		"skill_detail": "消耗100能量，使出【抓】。用坚硬且无比锋利的爪子抓对手进行攻击。 对目标造成182点伤害。",
		"skill_power": 182,
		"basic_attack": {
			"type": "physical",
			"name": "撞击",
			"style": "tackle",
			"sfx": "attack"
		},
						"skills": {
			1: [
				{
					"name": "抓",
					"desc": "用坚硬且无比锋利的爪子抓对手进行攻击。",
					"detail": "消耗100能量，使出【抓】。用坚硬且无比锋利的爪子抓对手进行攻击。 对目标造成182点伤害。",
					"power": 182,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "slash",
					"sfx": "slash",
					"scale": 0.28
				},
				{
					"name": "撞击",
					"desc": "用整个身体撞向对手进行攻击。",
					"detail": "消耗100能量，使出【撞击】。用整个身体撞向对手进行攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "tackle",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "咬住",
					"desc": "用尖锐的牙咬住对手进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，使出【咬住】。用尖锐的牙咬住对手进行攻击。有时会使对手畏缩。 对目标造成220点伤害。",
					"power": 220,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "bite",
					"sfx": "bite",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "毒针",
					"desc": "将有毒的针刺入对手进行攻击。有时会让对手陷入中毒状态。",
					"detail": "消耗100能量，爆发【毒针】。将有毒的针刺入对手进行攻击。有时会让对手陷入中毒状态。 对范围内最多3名敌人造成275点伤害，并施加战术压制。",
					"power": 275,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "poison_sting",
					"sfx": "slash",
					"scale": 0.36
				},
				{
					"name": "咬碎",
					"desc": "用利牙咬碎对手进行攻击。有时会降低对手的防御。",
					"detail": "消耗100能量，爆发【咬碎】！用利牙咬碎对手进行攻击。有时会降低对手的防御。 对范围内最多2名敌人造成360点伤害，并施加战术压制。",
					"power": 360,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "crunch",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "愤怒门牙",
					"desc": "用锋利的门牙猛烈地咬住对手进行攻击。对手的ＨＰ减半。",
					"detail": "消耗100能量，爆发【愤怒门牙】！用锋利的门牙猛烈地咬住对手进行攻击。对手的ＨＰ减半。 对范围内最多2名敌人造成320点伤害，并施加战术压制。",
					"power": 320,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "headbutt",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "污泥炸弹",
					"desc": "用污泥投掷对手进行攻击。有时会让对手陷入中毒状态。",
					"detail": "消耗100能量，释放终极奥义【污泥炸弹】！用污泥投掷对手进行攻击。有时会让对手陷入中毒状态。 席卷战场对最多6名敌人造成655点巨额伤害与强力击破！",
					"power": 655,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "sludge_bomb",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "泰山压顶",
					"desc": "用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，释放终极奥义【泰山压顶】！用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。 席卷战场对最多4名敌人造成605点巨额伤害与强力击破！",
					"power": 605,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "大地之力",
					"desc": "向对手脚下释放出大地之力。有时会降低对手的特防。",
					"detail": "消耗100能量，释放终极奥义【大地之力】！向对手脚下释放出大地之力。有时会降低对手的特防。 席卷战场对最多6名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "earthquake",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/nidoran_f.png"
	},
	"nidorina": {
		"id": "nidorina",
		"name": "尼多娜",
		"title": "毒针宝可梦",
		"cost": 2,
		"types": ["Poison"],
		"hp": 780,
		"atk": 62,
		"armor": 38,
		"mr": 38,
		"range": 1,
		"atk_speed": 0.72,
		"max_mana": 80,
		"desc": "性情温和，但在保护幼崽或遇到强敌时背刺会瞬间竖起，毒角硬化能轻易穿透钢板并注入高浓度毒素。",
		"skill_name": "毒针",
		"skill_desc": "将有毒的针刺入对手进行攻击。有时会让对手陷入中毒状态。",
		"skill_detail": "消耗100能量，使出【毒针】。将有毒的针刺入对手进行攻击。有时会让对手陷入中毒状态。 对目标造成162点伤害。",
		"skill_power": 162,
		"basic_attack": {
			"type": "physical",
			"name": "撞击",
			"style": "tackle",
			"sfx": "attack"
		},
						"skills": {
			1: [
				{
					"name": "毒针",
					"desc": "将有毒的针刺入对手进行攻击。有时会让对手陷入中毒状态。",
					"detail": "消耗100能量，使出【毒针】。将有毒的针刺入对手进行攻击。有时会让对手陷入中毒状态。 对目标造成162点伤害。",
					"power": 162,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "poison_sting",
					"sfx": "slash",
					"scale": 0.28
				},
				{
					"name": "抓",
					"desc": "用坚硬且无比锋利的爪子抓对手进行攻击。",
					"detail": "消耗100能量，使出【抓】。用坚硬且无比锋利的爪子抓对手进行攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "slash",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "撞击",
					"desc": "用整个身体撞向对手进行攻击。",
					"detail": "消耗100能量，使出【撞击】。用整个身体撞向对手进行攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "tackle",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "咬住",
					"desc": "用尖锐的牙咬住对手进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，爆发【咬住】。用尖锐的牙咬住对手进行攻击。有时会使对手畏缩。 对范围内最多3名敌人造成320点伤害，并施加战术压制。",
					"power": 320,
					"target_count": 3,
					"stun_duration": 0.8,
					"vfx": "bite",
					"sfx": "bite",
					"scale": 0.36
				},
				{
					"name": "咬碎",
					"desc": "用利牙咬碎对手进行攻击。有时会降低对手的防御。",
					"detail": "消耗100能量，爆发【咬碎】！用利牙咬碎对手进行攻击。有时会降低对手的防御。 对范围内最多2名敌人造成360点伤害，并施加战术压制。",
					"power": 360,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "crunch",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "十字毒刃",
					"desc": "用毒刃劈开对手。有时会让对手陷入中毒状态，也容易击中要害。",
					"detail": "消耗100能量，爆发【十字毒刃】！用毒刃劈开对手。有时会让对手陷入中毒状态，也容易击中要害。 对范围内最多2名敌人造成330点伤害，并施加战术压制。",
					"power": 330,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "poison_jab",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "污泥炸弹",
					"desc": "用污泥投掷对手进行攻击。有时会让对手陷入中毒状态。",
					"detail": "消耗100能量，释放终极奥义【污泥炸弹】！用污泥投掷对手进行攻击。有时会让对手陷入中毒状态。 席卷战场对最多6名敌人造成655点巨额伤害与强力击破！",
					"power": 655,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "sludge_bomb",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "乱抓",
					"desc": "用爪子或镰刀等抓对手进行攻击。连续攻击２～５次。",
					"detail": "消耗100能量，释放终极奥义【乱抓】！用爪子或镰刀等抓对手进行攻击。连续攻击２～５次。 席卷战场对最多4名敌人造成270点巨额伤害与强力击破！",
					"power": 270,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "headbutt",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "大地之力",
					"desc": "向对手脚下释放出大地之力。有时会降低对手的特防。",
					"detail": "消耗100能量，释放终极奥义【大地之力】！向对手脚下释放出大地之力。有时会降低对手的特防。 席卷战场对最多6名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "earthquake",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/nidorina.png"
	},
	"nidoqueen": {
		"id": "nidoqueen",
		"name": "尼多后",
		"title": "钻锥宝可梦",
		"cost": 4,
		"types": ["Poison", "Ground"],
		"hp": 1150,
		"atk": 82,
		"armor": 55,
		"mr": 55,
		"range": 1,
		"atk_speed": 0.7,
		"max_mana": 100,
		"desc": "身体覆盖着坚如磐石的针状鳞片，擅长用沉重的身躯撞倒敌人，并释放猛毒地壳裂变横扫战场！",
		"skill_name": "泰山压顶",
		"skill_desc": "用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。",
		"skill_detail": "消耗100能量，使出【泰山压顶】。用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。 对目标造成218点伤害。",
		"skill_power": 218,
		"basic_attack": {
			"type": "physical",
			"name": "撞击",
			"style": "tackle",
			"sfx": "attack"
		},
						"skills": {
			1: [
				{
					"name": "泰山压顶",
					"desc": "用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，使出【泰山压顶】。用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。 对目标造成218点伤害。",
					"power": 218,
					"target_count": 1,
					"stun_duration": 0.5,
					"vfx": "body_slam",
					"sfx": "attack",
					"scale": 0.28
				},
				{
					"name": "撞击",
					"desc": "用整个身体撞向对手进行攻击。",
					"detail": "消耗100能量，使出【撞击】。用整个身体撞向对手进行攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "tackle",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "污泥波",
					"desc": "用污泥波攻击自己周围所有的宝可梦。有时会陷入中毒状态。",
					"detail": "消耗100能量，使出【污泥波】。用污泥波攻击自己周围所有的宝可梦。有时会陷入中毒状态。 对目标造成290点伤害。",
					"power": 290,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "sludge_bomb",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "大地之力",
					"desc": "向对手脚下释放出大地之力。有时会降低对手的特防。",
					"detail": "消耗100能量，爆发【大地之力】。向对手脚下释放出大地之力。有时会降低对手的特防。 对范围内最多3名敌人造成350点伤害，并施加战术压制。",
					"power": 350,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "earthquake",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "逐步击破",
					"desc": "看准机会稳步攻击。无视对手的能力变化，直接给予伤害。",
					"detail": "消耗100能量，爆发【逐步击破】！看准机会稳步攻击。无视对手的能力变化，直接给予伤害。 对范围内最多2名敌人造成330点伤害，并施加战术压制。",
					"power": 330,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "十字毒刃",
					"desc": "用毒刃劈开对手。有时会让对手陷入中毒状态，也容易击中要害。",
					"detail": "消耗100能量，爆发【十字毒刃】！用毒刃劈开对手。有时会让对手陷入中毒状态，也容易击中要害。 对范围内最多2名敌人造成330点伤害，并施加战术压制。",
					"power": 330,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "poison_jab",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "蛮力",
					"desc": "发挥惊人的力量攻击对手。自己的攻击和防御会降低。",
					"detail": "消耗100能量，释放终极奥义【蛮力】！发挥惊人的力量攻击对手。自己的攻击和防御会降低。 席卷战场对最多6名敌人造成700点巨额伤害与强力击破！",
					"power": 700,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "mega_punch",
					"sfx": "punch",
					"scale": 0.48
				},
				{
					"name": "垃圾射击",
					"desc": "用肮脏的垃圾撞向对手进行攻击。有时会让对手陷入中毒状态。",
					"detail": "消耗100能量，释放终极奥义【垃圾射击】！用肮脏的垃圾撞向对手进行攻击。有时会让对手陷入中毒状态。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "gunk_shot",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "剧毒",
					"desc": "让对手陷入剧毒状态。随着回合的推进，中毒伤害会增加。",
					"detail": "消耗100能量，释放终极奥义【剧毒】！让对手陷入剧毒状态。随着回合的推进，中毒伤害会增加。 席卷战场对最多6名敌人造成680点巨额伤害与强力击破！",
					"power": 680,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "toxic",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/nidoqueen.png"
	},
	"nidoran_m": {
		"id": "nidoran_m",
		"name": "尼多朗",
		"title": "毒针宝可梦",
		"cost": 1,
		"types": ["Poison"],
		"hp": 560,
		"atk": 52,
		"armor": 28,
		"mr": 28,
		"range": 1,
		"atk_speed": 0.72,
		"max_mana": 80,
		"desc": "头顶长着比身体还大的毒角，时刻警惕地竖起双耳倾听四周动静，一旦感知到危险便会全速突刺！",
		"skill_name": "啄",
		"skill_desc": "用尖锐的喙或角刺向对手进行攻击。",
		"skill_detail": "消耗100能量，使出【啄】。用尖锐的喙或角刺向对手进行攻击。 对目标造成178点伤害。",
		"skill_power": 178,
		"basic_attack": {
			"type": "physical",
			"name": "撞击",
			"style": "tackle",
			"sfx": "attack"
		},
						"skills": {
			1: [
				{
					"name": "啄",
					"desc": "用尖锐的喙或角刺向对手进行攻击。",
					"detail": "消耗100能量，使出【啄】。用尖锐的喙或角刺向对手进行攻击。 对目标造成178点伤害。",
					"power": 178,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "drill_peck",
					"sfx": "slash",
					"scale": 0.28
				},
				{
					"name": "撞击",
					"desc": "用整个身体撞向对手进行攻击。",
					"detail": "消耗100能量，使出【撞击】。用整个身体撞向对手进行攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "tackle",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "乱击",
					"desc": "用角或喙刺向对手进行攻击。连续攻击２～５次。",
					"detail": "消耗100能量，使出【乱击】。用角或喙刺向对手进行攻击。连续攻击２～５次。 对目标造成130点伤害。",
					"power": 130,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "毒针",
					"desc": "将有毒的针刺入对手进行攻击。有时会让对手陷入中毒状态。",
					"detail": "消耗100能量，爆发【毒针】。将有毒的针刺入对手进行攻击。有时会让对手陷入中毒状态。 对范围内最多3名敌人造成275点伤害，并施加战术压制。",
					"power": 275,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "poison_sting",
					"sfx": "slash",
					"scale": 0.36
				},
				{
					"name": "毒击",
					"desc": "用带毒的触手或手臂刺入对手。有时会让对手陷入中毒状态。",
					"detail": "消耗100能量，爆发【毒击】！用带毒的触手或手臂刺入对手。有时会让对手陷入中毒状态。 对范围内最多2名敌人造成360点伤害，并施加战术压制。",
					"power": 360,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "poison_jab",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "角撞",
					"desc": "用尖锐的角攻击对手。",
					"detail": "消耗100能量，爆发【角撞】！用尖锐的角攻击对手。 对范围内最多2名敌人造成315点伤害，并施加战术压制。",
					"power": 315,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "headbutt",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "污泥炸弹",
					"desc": "用污泥投掷对手进行攻击。有时会让对手陷入中毒状态。",
					"detail": "消耗100能量，释放终极奥义【污泥炸弹】！用污泥投掷对手进行攻击。有时会让对手陷入中毒状态。 席卷战场对最多6名敌人造成655点巨额伤害与强力击破！",
					"power": 655,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "sludge_bomb",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "大地之力",
					"desc": "向对手脚下释放出大地之力。有时会降低对手的特防。",
					"detail": "消耗100能量，释放终极奥义【大地之力】！向对手脚下释放出大地之力。有时会降低对手的特防。 席卷战场对最多6名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "earthquake",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "剧毒",
					"desc": "让对手陷入剧毒状态。随着回合的推进，中毒伤害会增加。",
					"detail": "消耗100能量，释放终极奥义【剧毒】！让对手陷入剧毒状态。随着回合的推进，中毒伤害会增加。 席卷战场对最多6名敌人造成680点巨额伤害与强力击破！",
					"power": 680,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "toxic",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/nidoran_m.png"
	},
	"nidorino": {
		"id": "nidorino",
		"name": "尼多力诺",
		"title": "毒针宝可梦",
		"cost": 2,
		"types": ["Poison"],
		"hp": 760,
		"atk": 68,
		"armor": 35,
		"mr": 35,
		"range": 1,
		"atk_speed": 0.75,
		"max_mana": 80,
		"desc": "脾气极其凶暴，头顶钻石般坚硬的毒角含有烈性神经毒素，受到撞击时毒角会渗出强酸毒汁。",
		"skill_name": "角撞",
		"skill_desc": "用尖锐的角攻击对手。",
		"skill_detail": "消耗100能量，使出【角撞】。用尖锐的角攻击对手。 对目标造成202点伤害。",
		"skill_power": 202,
		"basic_attack": {
			"type": "physical",
			"name": "撞击",
			"style": "tackle",
			"sfx": "attack"
		},
						"skills": {
			1: [
				{
					"name": "角撞",
					"desc": "用尖锐的角攻击对手。",
					"detail": "消耗100能量，使出【角撞】。用尖锐的角攻击对手。 对目标造成202点伤害。",
					"power": 202,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "body_slam",
					"sfx": "attack",
					"scale": 0.28
				},
				{
					"name": "撞击",
					"desc": "用整个身体撞向对手进行攻击。",
					"detail": "消耗100能量，使出【撞击】。用整个身体撞向对手进行攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "tackle",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "乱击",
					"desc": "用角或喙刺向对手进行攻击。连续攻击２～５次。",
					"detail": "消耗100能量，使出【乱击】。用角或喙刺向对手进行攻击。连续攻击２～５次。 对目标造成130点伤害。",
					"power": 130,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "毒击",
					"desc": "用带毒的触手或手臂刺入对手。有时会让对手陷入中毒状态。",
					"detail": "消耗100能量，爆发【毒击】。用带毒的触手或手臂刺入对手。有时会让对手陷入中毒状态。 对范围内最多3名敌人造成340点伤害，并施加战术压制。",
					"power": 340,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "poison_jab",
					"sfx": "slash",
					"scale": 0.36
				},
				{
					"name": "污泥炸弹",
					"desc": "用污泥投掷对手进行攻击。有时会让对手陷入中毒状态。",
					"detail": "消耗100能量，爆发【污泥炸弹】！用污泥投掷对手进行攻击。有时会让对手陷入中毒状态。 对范围内最多3名敌人造成390点伤害，并施加战术压制。",
					"power": 390,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "sludge_bomb",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "十字毒刃",
					"desc": "用毒刃劈开对手。有时会让对手陷入中毒状态，也容易击中要害。",
					"detail": "消耗100能量，爆发【十字毒刃】！用毒刃劈开对手。有时会让对手陷入中毒状态，也容易击中要害。 对范围内最多2名敌人造成330点伤害，并施加战术压制。",
					"power": 330,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "poison_sting",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "地震",
					"desc": "利用地震的冲击，攻击自己周围所有的宝可梦。",
					"detail": "消耗100能量，释放终极奥义【地震】！利用地震的冲击，攻击自己周围所有的宝可梦。 席卷战场对最多6名敌人造成670点巨额伤害与强力击破！",
					"power": 670,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "earthquake",
					"sfx": "attack",
					"scale": 0.48
				},
				{
					"name": "角钻",
					"desc": "用旋转的角刺入对手进行攻击。只要命中就会一击濒死。",
					"detail": "消耗100能量，释放终极奥义【角钻】！用旋转的角刺入对手进行攻击。只要命中就会一击濒死。 席卷战场对最多4名敌人造成680点巨额伤害与强力击破！",
					"power": 680,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "drill_peck",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，释放终极奥义【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 席卷战场对最多4名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/nidorino.png"
	},
	"nidoking": {
		"id": "nidoking",
		"name": "尼多王",
		"title": "钻锥宝可梦",
		"cost": 4,
		"types": ["Poison", "Ground"],
		"hp": 1100,
		"atk": 95,
		"armor": 52,
		"mr": 52,
		"range": 1,
		"atk_speed": 0.72,
		"max_mana": 100,
		"desc": "坚硬外皮犹如钢铁重甲，粗壮的长尾一扫就能扫断电线杆，头顶的剧毒巨角是战场所有敌人的噩梦！",
		"skill_name": "毒击",
		"skill_desc": "用带毒的触手或手臂刺入对手。有时会让对手陷入中毒状态。",
		"skill_detail": "消耗100能量，使出【毒击】。用带毒的触手或手臂刺入对手。有时会让对手陷入中毒状态。 对目标造成214点伤害。",
		"skill_power": 214,
		"basic_attack": {
			"type": "physical",
			"name": "撞击",
			"style": "tackle",
			"sfx": "attack"
		},
						"skills": {
			1: [
				{
					"name": "毒击",
					"desc": "用带毒的触手或手臂刺入对手。有时会让对手陷入中毒状态。",
					"detail": "消耗100能量，使出【毒击】。用带毒的触手或手臂刺入对手。有时会让对手陷入中毒状态。 对目标造成214点伤害。",
					"power": 214,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "poison_jab",
					"sfx": "slash",
					"scale": 0.28
				},
				{
					"name": "大闹一番",
					"desc": "在２～３回合内，乱打一气地攻击对手。大闹一番后自己会陷入混乱。",
					"detail": "消耗100能量，使出【大闹一番】。在２～３回合内，乱打一气地攻击对手。大闹一番后自己会陷入混乱。 对目标造成340点伤害。",
					"power": 340,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "污泥波",
					"desc": "用污泥波攻击自己周围所有的宝可梦。有时会陷入中毒状态。",
					"detail": "消耗100能量，使出【污泥波】。用污泥波攻击自己周围所有的宝可梦。有时会陷入中毒状态。 对目标造成290点伤害。",
					"power": 290,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "sludge_bomb",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "大地之力",
					"desc": "向对手脚下释放出大地之力。有时会降低对手的特防。",
					"detail": "消耗100能量，爆发【大地之力】。向对手脚下释放出大地之力。有时会降低对手的特防。 对范围内最多3名敌人造成350点伤害，并施加战术压制。",
					"power": 350,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "earthquake",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "撞击",
					"desc": "用整个身体撞向对手进行攻击。",
					"detail": "消耗100能量，爆发【撞击】！用整个身体撞向对手进行攻击。 对范围内最多2名敌人造成240点伤害，并施加战术压制。",
					"power": 240,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "tackle",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "角撞",
					"desc": "用尖锐的角攻击对手。",
					"detail": "消耗100能量，爆发【角撞】！用尖锐的角攻击对手。 对范围内最多2名敌人造成315点伤害，并施加战术压制。",
					"power": 315,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "headbutt",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "超级角击",
					"desc": "用坚硬且华丽的角狠狠地刺入对手进行攻击。",
					"detail": "消耗100能量，释放终极奥义【超级角击】！用坚硬且华丽的角狠狠地刺入对手进行攻击。 席卷战场对最多6名敌人造成700点巨额伤害与强力击破！",
					"power": 700,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "giga_impact",
					"sfx": "attack",
					"scale": 0.48
				},
				{
					"name": "垃圾射击",
					"desc": "用肮脏的垃圾撞向对手进行攻击。有时会让对手陷入中毒状态。",
					"detail": "消耗100能量，释放终极奥义【垃圾射击】！用肮脏的垃圾撞向对手进行攻击。有时会让对手陷入中毒状态。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "gunk_shot",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "剧毒",
					"desc": "让对手陷入剧毒状态。随着回合的推进，中毒伤害会增加。",
					"detail": "消耗100能量，释放终极奥义【剧毒】！让对手陷入剧毒状态。随着回合的推进，中毒伤害会增加。 席卷战场对最多6名敌人造成680点巨额伤害与强力击破！",
					"power": 680,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "toxic",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/nidoking.png"
	},
	"clefairy": {
		"id": "clefairy",
		"name": "皮皮",
		"title": "妖精宝可梦",
		"cost": 2,
		"types": ["Normal"],
		"hp": 680,
		"atk": 48,
		"armor": 30,
		"mr": 45,
		"range": 3,
		"atk_speed": 0.68,
		"max_mana": 85,
		"desc": "在满月之夜会聚在深山跳起神秘的祈月之舞，小巧双翼储存月光，摇晃手指能引发不可思议的奇迹！",
		"skill_name": "拍击",
		"skill_desc": "使用长长的尾巴或手等拍打对手进行攻击。",
		"skill_detail": "消耗100能量，使出【拍击】。使用长长的尾巴或手等拍打对手进行攻击。 对目标造成182点伤害。",
		"skill_power": 182,
		"basic_attack": {
			"type": "special",
			"name": "魔法弹",
			"style": "spark",
			"sfx": "swift"
		},
						"skills": {
			1: [
				{
					"name": "拍击",
					"desc": "使用长长的尾巴或手等拍打对手进行攻击。",
					"detail": "消耗100能量，使出【拍击】。使用长长的尾巴或手等拍打对手进行攻击。 对目标造成182点伤害。",
					"power": 182,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "tackle",
					"sfx": "attack",
					"scale": 0.28
				},
				{
					"name": "变圆",
					"desc": "将身体蜷曲变圆，从而提高自己的防御。",
					"detail": "消耗100能量，使出【变圆】。将身体蜷曲变圆，从而提高自己的防御。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "唤醒巴掌",
					"desc": "给予睡眠状态下的对手较大的伤害。但相反对手会从睡眠中醒过来。",
					"detail": "消耗100能量，使出【唤醒巴掌】。给予睡眠状态下的对手较大的伤害。但相反对手会从睡眠中醒过来。 对目标造成240点伤害。",
					"power": 240,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "low_kick",
					"sfx": "punch",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "魅惑之声",
					"desc": "发出魅惑的叫声，给予对手精神上的伤害。攻击必定会命中。",
					"detail": "消耗100能量，爆发【魅惑之声】。发出魅惑的叫声，给予对手精神上的伤害。攻击必定会命中。 对范围内最多3名敌人造成300点伤害，并施加战术压制。",
					"power": 300,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "swift",
					"sfx": "swift",
					"scale": 0.36
				},
				{
					"name": "光墙",
					"desc": "利用神奇的墙壁，在５回合内减弱从对手那里受到的特殊攻击的伤害。",
					"detail": "消耗100能量，爆发【光墙】！利用神奇的墙壁，在５回合内减弱从对手那里受到的特殊攻击的伤害。 对范围内最多3名敌人造成320点伤害，并施加战术压制。",
					"power": 320,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "light_screen",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "百万吨重拳",
					"desc": "用充满力量的拳头攻击对手。",
					"detail": "消耗100能量，爆发【百万吨重拳】！用充满力量的拳头攻击对手。 对范围内最多2名敌人造成360点伤害，并施加战术压制。",
					"power": 360,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "mega_punch",
					"sfx": "punch",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "月亮之力",
					"desc": "借用月亮的力量攻击对手。有时会降低对手的特攻。",
					"detail": "消耗100能量，释放终极奥义【月亮之力】！借用月亮的力量攻击对手。有时会降低对手的特攻。 席卷战场对最多6名敌人造成662点巨额伤害与强力击破！",
					"power": 662,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "cosmic_singularity",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "百万吨重踢",
					"desc": "使出力大无穷的重踢踢飞对手进行攻击。",
					"detail": "消耗100能量，释放终极奥义【百万吨重踢】！使出力大无穷的重踢踢飞对手进行攻击。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "mega_kick",
					"sfx": "punch",
					"scale": 1.55
				},
				{
					"name": "舍身冲撞",
					"desc": "拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。",
					"detail": "消耗100能量，释放终极奥义【舍身冲撞】！拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "double_edge",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/clefairy.png"
	},
	"clefable": {
		"id": "clefable",
		"name": "皮可西",
		"title": "妖精宝可梦",
		"cost": 3,
		"types": ["Normal"],
		"hp": 880,
		"atk": 65,
		"armor": 38,
		"mr": 55,
		"range": 3,
		"atk_speed": 0.7,
		"max_mana": 90,
		"desc": "长着一对灵巧的羽翼，听觉敏锐到能听到一公里外掉落在地上的针声，踏月而行时如同漫步在水面上。",
		"skill_name": "吸取之吻",
		"skill_desc": "用一个吻吸取对手的ＨＰ。回复给予对手伤害的一半以上的ＨＰ。",
		"skill_detail": "消耗100能量，使出【吸取之吻】。用一个吻吸取对手的ＨＰ。回复给予对手伤害的一半以上的ＨＰ。 对目标造成190点伤害。",
		"skill_power": 190,
		"basic_attack": {
			"type": "special",
			"name": "魔法弹",
			"style": "spark",
			"sfx": "swift"
		},
						"skills": {
			1: [
				{
					"name": "吸取之吻",
					"desc": "用一个吻吸取对手的ＨＰ。回复给予对手伤害的一半以上的ＨＰ。",
					"detail": "消耗100能量，使出【吸取之吻】。用一个吻吸取对手的ＨＰ。回复给予对手伤害的一半以上的ＨＰ。 对目标造成190点伤害。",
					"power": 190,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "heal_pulse",
					"sfx": "skill",
					"scale": 0.28
				},
				{
					"name": "连环巴掌",
					"desc": "用连环巴掌拍打对手进行攻击。连续攻击２～５次。",
					"detail": "消耗100能量，使出【连环巴掌】。用连环巴掌拍打对手进行攻击。连续攻击２～５次。 对目标造成130点伤害。",
					"power": 130,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "妖精之风",
					"desc": "刮起妖精之风，吹向对手进行攻击。",
					"detail": "消耗100能量，使出【妖精之风】。刮起妖精之风，吹向对手进行攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "魔法闪耀",
					"desc": "向对手发射强光，并给予伤害。",
					"detail": "消耗100能量，爆发【魔法闪耀】。向对手发射强光，并给予伤害。 对范围内最多3名敌人造成340点伤害，并施加战术压制。",
					"power": 340,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "swift",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "精神强念",
					"desc": "向对手发送强大的念力进行攻击。有时会降低对手的特防。",
					"detail": "消耗100能量，爆发【精神强念】！向对手发送强大的念力进行攻击。有时会降低对手的特防。 对范围内最多3名敌人造成390点伤害，并施加战术压制。",
					"power": 390,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "psychic",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "高速星星",
					"desc": "发射星形的光攻击对手。攻击必定会命中。",
					"detail": "消耗100能量，爆发【高速星星】！发射星形的光攻击对手。攻击必定会命中。 对范围内最多3名敌人造成300点伤害，并施加战术压制。",
					"power": 300,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "tackle",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "月亮之力",
					"desc": "借用月亮的力量攻击对手。有时会降低对手的特攻。",
					"detail": "消耗100能量，释放终极奥义【月亮之力】！借用月亮的力量攻击对手。有时会降低对手的特攻。 席卷战场对最多6名敌人造成662点巨额伤害与强力击破！",
					"power": 662,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "cosmic_singularity",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "舍身冲撞",
					"desc": "拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。",
					"detail": "消耗100能量，释放终极奥义【舍身冲撞】！拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "double_edge",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "终极冲击",
					"desc": "使出自己浑身力量突击对手。下一回合自己将无法动弹。",
					"detail": "消耗100能量，释放终极奥义【终极冲击】！使出自己浑身力量突击对手。下一回合自己将无法动弹。 席卷战场对最多4名敌人造成930点巨额伤害与强力击破！",
					"power": 930,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "giga_impact",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/clefable.png"
	},
	"vulpix": {
		"id": "vulpix",
		"name": "六尾",
		"title": "狐狸宝可梦",
		"cost": 2,
		"types": ["Fire"],
		"hp": 620,
		"atk": 55,
		"armor": 28,
		"mr": 35,
		"range": 3,
		"atk_speed": 0.72,
		"max_mana": 80,
		"desc": "出生时只有一条白色尾巴，长大后分裂成六条美丽的卷曲长尾，口中能喷射出幽灵般幽幻的灼热狐火。",
		"skill_name": "火花",
		"skill_desc": "向对手发射小型火焰进行攻击。有时会让对手陷入灼伤状态。",
		"skill_detail": "消耗100能量，使出【火花】。向对手发射小型火焰进行攻击。有时会让对手陷入灼伤状态。 对目标造成182点伤害。",
		"skill_power": 182,
		"basic_attack": {
			"type": "special",
			"name": "火花",
			"style": "fire_ember",
			"sfx": "fire"
		},
						"skills": {
			1: [
				{
					"name": "火花",
					"desc": "向对手发射小型火焰进行攻击。有时会让对手陷入灼伤状态。",
					"detail": "消耗100能量，使出【火花】。向对手发射小型火焰进行攻击。有时会让对手陷入灼伤状态。 对目标造成182点伤害。",
					"power": 182,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "ember",
					"sfx": "fire",
					"scale": 0.28
				},
				{
					"name": "撞击",
					"desc": "用整个身体撞向对手进行攻击。",
					"detail": "消耗100能量，使出【撞击】。用整个身体撞向对手进行攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "tackle",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "祸不单行",
					"desc": "接二连三地进行攻击。对处于异常状态的对手给予较大的伤害。",
					"detail": "消耗100能量，使出【祸不单行】。接二连三地进行攻击。对处于异常状态的对手给予较大的伤害。 对目标造成230点伤害。",
					"power": 230,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "hex_nightmare",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "火焰轮",
					"desc": "让火焰覆盖全身，猛撞向对手进行攻击。有时会让对手陷入灼伤状态。",
					"detail": "消耗100能量，爆发【火焰轮】。让火焰覆盖全身，猛撞向对手进行攻击。有时会让对手陷入灼伤状态。 对范围内最多3名敌人造成320点伤害，并施加战术压制。",
					"power": 320,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "flame_wheel",
					"sfx": "fire",
					"scale": 0.36
				},
				{
					"name": "以牙还牙",
					"desc": "蓄力攻击。如果能在对手之后攻击，招式的威力会变成２倍。",
					"detail": "消耗100能量，爆发【以牙还牙】！蓄力攻击。如果能在对手之后攻击，招式的威力会变成２倍。 对范围内最多2名敌人造成270点伤害，并施加战术压制。",
					"power": 270,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "电光一闪",
					"desc": "以迅雷不及掩耳之势扑向对手。必定能够先制攻击。",
					"detail": "消耗100能量，爆发【电光一闪】！以迅雷不及掩耳之势扑向对手。必定能够先制攻击。 对范围内最多2名敌人造成240点伤害，并施加战术压制。",
					"power": 240,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "大字爆炎",
					"desc": "用大字形状的火焰烧尽对手。有时会让对手陷入灼伤状态。",
					"detail": "消耗100能量，释放终极奥义【大字爆炎】！用大字形状的火焰烧尽对手。有时会让对手陷入灼伤状态。 席卷战场对最多6名敌人造成685点巨额伤害与强力击破！",
					"power": 685,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "fire_blast",
					"sfx": "fire",
					"scale": 0.48
				},
				{
					"name": "炼狱",
					"desc": "用烈焰包裹住对手进行攻击。让对手陷入灼伤状态。",
					"detail": "消耗100能量，释放终极奥义【炼狱】！用烈焰包裹住对手进行攻击。让对手陷入灼伤状态。 席卷战场对最多6名敌人造成680点巨额伤害与强力击破！",
					"power": 680,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "inferno",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "爆炸烈焰",
					"desc": "用爆炸的火焰烧尽对手进行攻击。下一回合自己将无法动弹。",
					"detail": "消耗100能量，释放终极奥义【爆炸烈焰】！用爆炸的火焰烧尽对手进行攻击。下一回合自己将无法动弹。 席卷战场对最多6名敌人造成930点巨额伤害与强力击破！",
					"power": 930,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "blast_burn",
					"sfx": "fire",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/vulpix.png"
	},
	"ninetales": {
		"id": "ninetales",
		"name": "九尾",
		"title": "狐狸宝可梦",
		"cost": 3,
		"types": ["Fire"],
		"hp": 840,
		"atk": 75,
		"armor": 38,
		"mr": 48,
		"range": 3,
		"atk_speed": 0.78,
		"max_mana": 85,
		"desc": "拥有千年的超长寿命，九根金黄璀璨的长尾蕴含着神通广大的神秘灵力，双眼泛红能操纵敌人的心智！",
		"skill_name": "喷射火焰",
		"skill_desc": "向对手发射烈焰进行攻击。有时会让对手陷入灼伤状态。",
		"skill_detail": "消耗100能量，使出【喷射火焰】。向对手发射烈焰进行攻击。有时会让对手陷入灼伤状态。 对目标造成222点伤害。",
		"skill_power": 222,
		"basic_attack": {
			"type": "special",
			"name": "火花",
			"style": "fire_ember",
			"sfx": "fire"
		},
						"skills": {
			1: [
				{
					"name": "喷射火焰",
					"desc": "向对手发射烈焰进行攻击。有时会让对手陷入灼伤状态。",
					"detail": "消耗100能量，使出【喷射火焰】。向对手发射烈焰进行攻击。有时会让对手陷入灼伤状态。 对目标造成222点伤害。",
					"power": 222,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "flamethrower",
					"sfx": "fire",
					"scale": 0.28
				},
				{
					"name": "火花",
					"desc": "向对手发射小型火焰进行攻击。有时会让对手陷入灼伤状态。",
					"detail": "消耗100能量，使出【火花】。向对手发射小型火焰进行攻击。有时会让对手陷入灼伤状态。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "ember",
					"sfx": "fire",
					"scale": 0.82
				},
				{
					"name": "祸不单行",
					"desc": "接二连三地进行攻击。对处于异常状态的对手给予较大的伤害。",
					"detail": "消耗100能量，使出【祸不单行】。接二连三地进行攻击。对处于异常状态的对手给予较大的伤害。 对目标造成230点伤害。",
					"power": 230,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "hex_nightmare",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "热风",
					"desc": "将炎热的气息吹向对手进行攻击。有时会让对手陷入灼伤状态。",
					"detail": "消耗100能量，爆发【热风】。将炎热的气息吹向对手进行攻击。有时会让对手陷入灼伤状态。 对范围内最多3名敌人造成355点伤害，并施加战术压制。",
					"power": 355,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "heat_wave",
					"sfx": "fire",
					"scale": 0.36
				},
				{
					"name": "电光一闪",
					"desc": "以迅雷不及掩耳之势扑向对手。必定能够先制攻击。",
					"detail": "消耗100能量，爆发【电光一闪】！以迅雷不及掩耳之势扑向对手。必定能够先制攻击。 对范围内最多2名敌人造成240点伤害，并施加战术压制。",
					"power": 240,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "火焰拳",
					"desc": "用充满火焰的拳头攻击对手。有时会让对手陷入灼伤状态。",
					"detail": "消耗100能量，爆发【火焰拳】！用充满火焰的拳头攻击对手。有时会让对手陷入灼伤状态。 对范围内最多2名敌人造成345点伤害，并施加战术压制。",
					"power": 345,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "fire_punch",
					"sfx": "fire",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "大字爆炎",
					"desc": "用大字形状的火焰烧尽对手。有时会让对手陷入灼伤状态。",
					"detail": "消耗100能量，释放终极奥义【大字爆炎】！用大字形状的火焰烧尽对手。有时会让对手陷入灼伤状态。 席卷战场对最多6名敌人造成685点巨额伤害与强力击破！",
					"power": 685,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "fire_blast",
					"sfx": "fire",
					"scale": 0.48
				},
				{
					"name": "炼狱",
					"desc": "用烈焰包裹住对手进行攻击。让对手陷入灼伤状态。",
					"detail": "消耗100能量，释放终极奥义【炼狱】！用烈焰包裹住对手进行攻击。让对手陷入灼伤状态。 席卷战场对最多6名敌人造成680点巨额伤害与强力击破！",
					"power": 680,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "inferno",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "爆炸烈焰",
					"desc": "用爆炸的火焰烧尽对手进行攻击。下一回合自己将无法动弹。",
					"detail": "消耗100能量，释放终极奥义【爆炸烈焰】！用爆炸的火焰烧尽对手进行攻击。下一回合自己将无法动弹。 席卷战场对最多6名敌人造成930点巨额伤害与强力击破！",
					"power": 930,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "blast_burn",
					"sfx": "fire",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/ninetales.png"
	},
	"jigglypuff": {
		"id": "jigglypuff",
		"name": "胖丁",
		"title": "气球宝可梦",
		"cost": 2,
		"types": ["Normal"],
		"hp": 850,
		"atk": 45,
		"armor": 25,
		"mr": 35,
		"range": 2,
		"atk_speed": 0.65,
		"max_mana": 90,
		"desc": "圆滚滚的粉色身体像个大气球，能不受阻碍地不断调节声音波长，唱出让全场所有生命深陷沉睡的安眠曲。",
		"skill_name": "拍击",
		"skill_desc": "使用长长的尾巴或手等拍打对手进行攻击。",
		"skill_detail": "消耗100能量，使出【拍击】。使用长长的尾巴或手等拍打对手进行攻击。 对目标造成182点伤害。",
		"skill_power": 182,
		"basic_attack": {
			"type": "special",
			"name": "魔法弹",
			"style": "spark",
			"sfx": "swift"
		},
						"skills": {
			1: [
				{
					"name": "拍击",
					"desc": "使用长长的尾巴或手等拍打对手进行攻击。",
					"detail": "消耗100能量，使出【拍击】。使用长长的尾巴或手等拍打对手进行攻击。 对目标造成182点伤害。",
					"power": 182,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "tackle",
					"sfx": "attack",
					"scale": 0.28
				},
				{
					"name": "睡觉",
					"desc": "连续睡上２回合。回复自己的全部ＨＰ以及治愈所有异常状态。",
					"detail": "消耗100能量，使出【睡觉】。连续睡上２回合。回复自己的全部ＨＰ以及治愈所有异常状态。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "rest",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "泰山压顶",
					"desc": "用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，使出【泰山压顶】。用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。 对目标造成270点伤害。",
					"power": 270,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "轮唱",
					"desc": "用歌声攻击对手。同伴还可以接着使出轮唱招式，威力也会提高。",
					"detail": "消耗100能量，爆发【轮唱】。用歌声攻击对手。同伴还可以接着使出轮唱招式，威力也会提高。 对范围内最多3名敌人造成320点伤害，并施加战术压制。",
					"power": 320,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "swift",
					"sfx": "swift",
					"scale": 0.36
				},
				{
					"name": "舍身冲撞",
					"desc": "拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。",
					"detail": "消耗100能量，爆发【舍身冲撞】！拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。 对范围内最多2名敌人造成480点伤害，并施加战术压制。",
					"power": 480,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "double_edge",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "百万吨重拳",
					"desc": "用充满力量的拳头攻击对手。",
					"detail": "消耗100能量，爆发【百万吨重拳】！用充满力量的拳头攻击对手。 对范围内最多2名敌人造成360点伤害，并施加战术压制。",
					"power": 360,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "mega_punch",
					"sfx": "punch",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "巨声",
					"desc": "给予对手又吵又响的巨大震动进行攻击。",
					"detail": "消耗100能量，释放终极奥义【巨声】！给予对手又吵又响的巨大震动进行攻击。 席卷战场对最多6名敌人造成655点巨额伤害与强力击破！",
					"power": 655,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "百万吨重踢",
					"desc": "使出力大无穷的重踢踢飞对手进行攻击。",
					"detail": "消耗100能量，释放终极奥义【百万吨重踢】！使出力大无穷的重踢踢飞对手进行攻击。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "mega_kick",
					"sfx": "punch",
					"scale": 1.55
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，释放终极奥义【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 席卷战场对最多4名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/jigglypuff.png"
	},
	"wigglytuff": {
		"id": "wigglytuff",
		"name": "胖可丁",
		"title": "气球宝可梦",
		"cost": 3,
		"types": ["Normal"],
		"hp": 1100,
		"atk": 65,
		"armor": 35,
		"mr": 45,
		"range": 2,
		"atk_speed": 0.68,
		"max_mana": 90,
		"desc": "毛发质感细腻极致，身体弹性惊人能够无限充气变大，受到攻击时会弹走敌人并用连环耳光教训对手！",
		"skill_name": "连环巴掌",
		"skill_desc": "用连环巴掌拍打对手进行攻击。连续攻击２～５次。",
		"skill_detail": "消耗100能量，使出【连环巴掌】。用连环巴掌拍打对手进行攻击。连续攻击２～５次。 对目标造成162点伤害。",
		"skill_power": 162,
		"basic_attack": {
			"type": "special",
			"name": "魔法弹",
			"style": "spark",
			"sfx": "swift"
		},
						"skills": {
			1: [
				{
					"name": "连环巴掌",
					"desc": "用连环巴掌拍打对手进行攻击。连续攻击２～５次。",
					"detail": "消耗100能量，使出【连环巴掌】。用连环巴掌拍打对手进行攻击。连续攻击２～５次。 对目标造成162点伤害。",
					"power": 162,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "body_slam",
					"sfx": "attack",
					"scale": 0.28
				},
				{
					"name": "舍身冲撞",
					"desc": "拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。",
					"detail": "消耗100能量，使出【舍身冲撞】。拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。 对目标造成340点伤害。",
					"power": 340,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "double_edge",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "魅惑之声",
					"desc": "发出魅惑的叫声，给予对手精神上的伤害。攻击必定会命中。",
					"detail": "消耗100能量，使出【魅惑之声】。发出魅惑的叫声，给予对手精神上的伤害。攻击必定会命中。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "tackle",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "魔法闪耀",
					"desc": "向对手发射强光，并给予伤害。",
					"detail": "消耗100能量，爆发【魔法闪耀】。向对手发射强光，并给予伤害。 对范围内最多3名敌人造成340点伤害，并施加战术压制。",
					"power": 340,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "swift",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "劈开",
					"desc": "用爪子或镰刀等劈开对手进行攻击。容易击中要害。",
					"detail": "消耗100能量，爆发【劈开】！用爪子或镰刀等劈开对手进行攻击。容易击中要害。 对范围内最多2名敌人造成330点伤害，并施加战术压制。",
					"power": 330,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "slash",
					"sfx": "slash",
					"scale": 1.10
				},
				{
					"name": "睡觉",
					"desc": "连续睡上２回合。回复自己的全部ＨＰ以及治愈所有异常状态。",
					"detail": "消耗100能量，爆发【睡觉】！连续睡上２回合。回复自己的全部ＨＰ以及治愈所有异常状态。 对范围内最多3名敌人造成320点伤害，并施加战术压制。",
					"power": 320,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "rest",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "巨声",
					"desc": "给予对手又吵又响的巨大震动进行攻击。",
					"detail": "消耗100能量，释放终极奥义【巨声】！给予对手又吵又响的巨大震动进行攻击。 席卷战场对最多6名敌人造成655点巨额伤害与强力击破！",
					"power": 655,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "giga_impact",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "破坏光线",
					"desc": "向对手发射强烈的光线进行攻击。下一回合自己将无法动弹。",
					"detail": "消耗100能量，释放终极奥义【破坏光线】！向对手发射强烈的光线进行攻击。下一回合自己将无法动弹。 席卷战场对最多6名敌人造成930点巨额伤害与强力击破！",
					"power": 930,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "hyper_beam",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "百万吨重拳",
					"desc": "用充满力量的拳头攻击对手。",
					"detail": "消耗100能量，释放终极奥义【百万吨重拳】！用充满力量的拳头攻击对手。 席卷战场对最多4名敌人造成580点巨额伤害与强力击破！",
					"power": 580,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "mega_punch",
					"sfx": "punch",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/wigglytuff.png"
	},
	"zubat": {
		"id": "zubat",
		"name": "超音蝠",
		"title": "蝙蝠宝可梦",
		"cost": 1,
		"types": ["Poison", "Flying"],
		"hp": 500,
		"atk": 46,
		"armor": 20,
		"mr": 25,
		"range": 1,
		"atk_speed": 0.8,
		"max_mana": 75,
		"desc": "没有眼睛，依靠从口中发出的超音波来感知障碍物与猎物，双翼极其灵巧，擅长在黑暗中吸血突袭。",
		"skill_name": "吸血",
		"skill_desc": "吸取血液攻击对手。可以回复给予对手伤害的一半ＨＰ。",
		"skill_detail": "消耗100能量，使出【吸血】。吸取血液攻击对手。可以回复给予对手伤害的一半ＨＰ。 对目标造成214点伤害。",
		"skill_power": 214,
		"basic_attack": {
			"type": "physical",
			"name": "咬住",
			"style": "bite",
			"sfx": "bite"
		},
						"skills": {
			1: [
				{
					"name": "吸血",
					"desc": "吸取血液攻击对手。可以回复给予对手伤害的一半ＨＰ。",
					"detail": "消耗100能量，使出【吸血】。吸取血液攻击对手。可以回复给予对手伤害的一半ＨＰ。 对目标造成214点伤害。",
					"power": 214,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "leech_life",
					"sfx": "bite",
					"scale": 0.28
				},
				{
					"name": "吸取",
					"desc": "吸取对手的养分进行攻击。可以回复给予对手伤害的一半ＨＰ。",
					"detail": "消耗100能量，使出【吸取】。吸取对手的养分进行攻击。可以回复给予对手伤害的一半ＨＰ。 对目标造成140点伤害。",
					"power": 140,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "leech_seed",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "咬住",
					"desc": "用尖锐的牙咬住对手进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，使出【咬住】。用尖锐的牙咬住对手进行攻击。有时会使对手畏缩。 对目标造成220点伤害。",
					"power": 220,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "bite",
					"sfx": "bite",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "空气利刃",
					"desc": "用锐利的风切斩对手进行攻击。容易击中要害。",
					"detail": "消耗100能量，爆发【空气利刃】。用锐利的风切斩对手进行攻击。容易击中要害。 对范围内最多3名敌人造成320点伤害，并施加战术压制。",
					"power": 320,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "air_slash",
					"sfx": "slash",
					"scale": 0.36
				},
				{
					"name": "十字毒刃",
					"desc": "用毒刃劈开对手。有时会让对手陷入中毒状态，也容易击中要害。",
					"detail": "消耗100能量，爆发【十字毒刃】！用毒刃劈开对手。有时会让对手陷入中毒状态，也容易击中要害。 对范围内最多2名敌人造成330点伤害，并施加战术压制。",
					"power": 330,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "poison_jab",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "翅膀攻击",
					"desc": "大大地展开美丽的翅膀，将其撞向对手进行攻击。",
					"detail": "消耗100能量，爆发【翅膀攻击】！大大地展开美丽的翅膀，将其撞向对手进行攻击。 对范围内最多2名敌人造成300点伤害，并施加战术压制。",
					"power": 300,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "wing_attack",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "剧毒牙",
					"desc": "用有毒的牙齿咬住对手进行攻击。有时会使对手中剧毒。",
					"detail": "消耗100能量，释放终极奥义【剧毒牙】！用有毒的牙齿咬住对手进行攻击。有时会使对手中剧毒。 席卷战场对最多6名敌人造成595点巨额伤害与强力击破！",
					"power": 595,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "poison_sting",
					"sfx": "bite",
					"scale": 0.48
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，释放终极奥义【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 席卷战场对最多4名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "毒液冲击",
					"desc": "将特殊的毒液泼向对手。对处于中毒状态的对手，威力会变成２倍。",
					"detail": "消耗100能量，释放终极奥义【毒液冲击】！将特殊的毒液泼向对手。对处于中毒状态的对手，威力会变成２倍。 席卷战场对最多6名敌人造成505点巨额伤害与强力击破！",
					"power": 505,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "sludge_bomb",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/zubat.png"
	},
	"golbat": {
		"id": "golbat",
		"name": "大嘴蝠",
		"title": "蝙蝠宝可梦",
		"cost": 2,
		"types": ["Poison", "Flying"],
		"hp": 740,
		"atk": 66,
		"armor": 30,
		"mr": 35,
		"range": 1,
		"atk_speed": 0.82,
		"max_mana": 75,
		"desc": "拥有一张巨大且永远大张的恐怖巨嘴，四个锋利獠牙能瞬间刺破粗糙兽皮，一次能吸食超过300毫升鲜血！",
		"skill_name": "空气利刃",
		"skill_desc": "用锐利的风切斩对手进行攻击。容易击中要害。",
		"skill_detail": "消耗100能量，使出【空气利刃】。用锐利的风切斩对手进行攻击。容易击中要害。 对目标造成198点伤害。",
		"skill_power": 198,
		"basic_attack": {
			"type": "physical",
			"name": "咬住",
			"style": "bite",
			"sfx": "bite"
		},
						"skills": {
			1: [
				{
					"name": "空气利刃",
					"desc": "用锐利的风切斩对手进行攻击。容易击中要害。",
					"detail": "消耗100能量，使出【空气利刃】。用锐利的风切斩对手进行攻击。容易击中要害。 对目标造成198点伤害。",
					"power": 198,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "air_slash",
					"sfx": "slash",
					"scale": 0.28
				},
				{
					"name": "咬碎",
					"desc": "用利牙咬碎对手进行攻击。有时会降低对手的防御。",
					"detail": "消耗100能量，使出【咬碎】。用利牙咬碎对手进行攻击。有时会降低对手的防御。 对目标造成260点伤害。",
					"power": 260,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "crunch",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "剧毒牙",
					"desc": "用有毒的牙齿咬住对手进行攻击。有时会使对手中剧毒。",
					"detail": "消耗100能量，使出【剧毒牙】。用有毒的牙齿咬住对手进行攻击。有时会使对手中剧毒。 对目标造成200点伤害。",
					"power": 200,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "poison_sting",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "毒液冲击",
					"desc": "将特殊的毒液泼向对手。对处于中毒状态的对手，威力会变成２倍。",
					"detail": "消耗100能量，爆发【毒液冲击】。将特殊的毒液泼向对手。对处于中毒状态的对手，威力会变成２倍。 对范围内最多3名敌人造成325点伤害，并施加战术压制。",
					"power": 325,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "sludge_bomb",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "吸血",
					"desc": "吸取血液攻击对手。可以回复给予对手伤害的一半ＨＰ。",
					"detail": "消耗100能量，爆发【吸血】！吸取血液攻击对手。可以回复给予对手伤害的一半ＨＰ。 对范围内最多2名敌人造成360点伤害，并施加战术压制。",
					"power": 360,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "leech_life",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "咬住",
					"desc": "用尖锐的牙咬住对手进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，爆发【咬住】！用尖锐的牙咬住对手进行攻击。有时会使对手畏缩。 对范围内最多2名敌人造成300点伤害，并施加战术压制。",
					"power": 300,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "bite",
					"sfx": "bite",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "勇鸟猛攻",
					"desc": "收拢翅膀，通过低空飞行突击对手。自己也会受到不小的伤害。",
					"detail": "消耗100能量，释放终极奥义【勇鸟猛攻】！收拢翅膀，通过低空飞行突击对手。自己也会受到不小的伤害。 席卷战场对最多6名敌人造成700点巨额伤害与强力击破！",
					"power": 700,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "brave_bird",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "翅膀攻击",
					"desc": "大大地展开美丽的翅膀，将其撞向对手进行攻击。",
					"detail": "消耗100能量，释放终极奥义【翅膀攻击】！大大地展开美丽的翅膀，将其撞向对手进行攻击。 席卷战场对最多4名敌人造成480点巨额伤害与强力击破！",
					"power": 480,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "wing_attack",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，释放终极奥义【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 席卷战场对最多4名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/golbat.png"
	},
	"oddish": {
		"id": "oddish",
		"name": "走路草",
		"title": "杂草宝可梦",
		"cost": 1,
		"types": ["Grass", "Poison"],
		"hp": 540,
		"atk": 45,
		"armor": 25,
		"mr": 30,
		"range": 2,
		"atk_speed": 0.65,
		"max_mana": 80,
		"desc": "白天把身体埋在冰凉土壤里只露出头顶绿叶吸收养分，晚上在月光下拔出双脚到处漫步播撒种子。",
		"skill_name": "吸取",
		"skill_desc": "吸取对手的养分进行攻击。可以回复给予对手伤害的一半ＨＰ。",
		"skill_detail": "消耗100能量，使出【吸取】。吸取对手的养分进行攻击。可以回复给予对手伤害的一半ＨＰ。 对目标造成166点伤害。",
		"skill_power": 166,
		"basic_attack": {
			"type": "special",
			"name": "飞叶",
			"style": "leaf",
			"sfx": "swift"
		},
						"skills": {
			1: [
				{
					"name": "吸取",
					"desc": "吸取对手的养分进行攻击。可以回复给予对手伤害的一半ＨＰ。",
					"detail": "消耗100能量，使出【吸取】。吸取对手的养分进行攻击。可以回复给予对手伤害的一半ＨＰ。 对目标造成166点伤害。",
					"power": 166,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "leech_seed",
					"sfx": "skill",
					"scale": 0.28
				},
				{
					"name": "居合斩",
					"desc": "用镰刀或爪子等切斩对手进行攻击。",
					"detail": "消耗100能量，使出【居合斩】。用镰刀或爪子等切斩对手进行攻击。 对目标造成200点伤害。",
					"power": 200,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "slash",
					"sfx": "slash",
					"scale": 0.82
				},
				{
					"name": "终极吸取",
					"desc": "吸取对手的养分进行攻击。可以回复给予对手伤害的一半ＨＰ。",
					"detail": "消耗100能量，使出【终极吸取】。吸取对手的养分进行攻击。可以回复给予对手伤害的一半ＨＰ。 对目标造成250点伤害。",
					"power": 250,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "seed_bomb",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "溶解液",
					"desc": "将强酸泼向对手进行攻击。有时会降低对手的特防。",
					"detail": "消耗100能量，爆发【溶解液】。将强酸泼向对手进行攻击。有时会降低对手的特防。 对范围内最多3名敌人造成300点伤害，并施加战术压制。",
					"power": 300,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "sludge_bomb",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "飞叶快刀",
					"desc": "飞出叶片，切斩对手进行攻击。容易击中要害。",
					"detail": "消耗100能量，爆发【飞叶快刀】！飞出叶片，切斩对手进行攻击。容易击中要害。 对范围内最多2名敌人造成285点伤害，并施加战术压制。",
					"power": 285,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "razor_leaf",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "花瓣舞",
					"desc": "在２～３回合内，散落花瓣攻击对手。之后自己会陷入混乱。",
					"detail": "消耗100能量，爆发【花瓣舞】！在２～３回合内，散落花瓣攻击对手。之后自己会陷入混乱。 对范围内最多3名敌人造成480点伤害，并施加战术压制。",
					"power": 480,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "petal_dance",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "强力鞭打",
					"desc": "激烈地挥舞青藤或触手摔打对手进行攻击。",
					"detail": "消耗100能量，释放终极奥义【强力鞭打】！激烈地挥舞青藤或触手摔打对手进行攻击。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "power_whip",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "日光束",
					"desc": "第１回合收集满满的日光，第２回合发射光束进行攻击。",
					"detail": "消耗100能量，释放终极奥义【日光束】！第１回合收集满满的日光，第２回合发射光束进行攻击。 席卷战场对最多6名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "solar_beam",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，释放终极奥义【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 席卷战场对最多4名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/oddish.png"
	},
	"gloom": {
		"id": "gloom",
		"name": "臭臭花",
		"title": "杂草宝可梦",
		"cost": 2,
		"types": ["Grass", "Poison"],
		"hp": 750,
		"atk": 58,
		"armor": 32,
		"mr": 38,
		"range": 2,
		"atk_speed": 0.67,
		"max_mana": 85,
		"desc": "花瓣散发出极其浓烈的恶臭气味，能让2公里外的人瞬间昏厥，口中流出的甜腻花蜜含有强力神经毒素。",
		"skill_name": "溶解液",
		"skill_desc": "将强酸泼向对手进行攻击。有时会降低对手的特防。",
		"skill_detail": "消耗100能量，使出【溶解液】。将强酸泼向对手进行攻击。有时会降低对手的特防。 对目标造成182点伤害。",
		"skill_power": 182,
		"basic_attack": {
			"type": "special",
			"name": "飞叶",
			"style": "leaf",
			"sfx": "swift"
		},
						"skills": {
			1: [
				{
					"name": "溶解液",
					"desc": "将强酸泼向对手进行攻击。有时会降低对手的特防。",
					"detail": "消耗100能量，使出【溶解液】。将强酸泼向对手进行攻击。有时会降低对手的特防。 对目标造成182点伤害。",
					"power": 182,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "poison_sting",
					"sfx": "skill",
					"scale": 0.28
				},
				{
					"name": "居合斩",
					"desc": "用镰刀或爪子等切斩对手进行攻击。",
					"detail": "消耗100能量，使出【居合斩】。用镰刀或爪子等切斩对手进行攻击。 对目标造成200点伤害。",
					"power": 200,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "slash",
					"sfx": "slash",
					"scale": 0.82
				},
				{
					"name": "剧毒",
					"desc": "让对手陷入剧毒状态。随着回合的推进，中毒伤害会增加。",
					"detail": "消耗100能量，使出【剧毒】。让对手陷入剧毒状态。随着回合的推进，中毒伤害会增加。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "toxic",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "终极吸取",
					"desc": "吸取对手的养分进行攻击。可以回复给予对手伤害的一半ＨＰ。",
					"detail": "消耗100能量，爆发【终极吸取】。吸取对手的养分进行攻击。可以回复给予对手伤害的一半ＨＰ。 对范围内最多3名敌人造成335点伤害，并施加战术压制。",
					"power": 335,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "leech_seed",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "飞叶快刀",
					"desc": "飞出叶片，切斩对手进行攻击。容易击中要害。",
					"detail": "消耗100能量，爆发【飞叶快刀】！飞出叶片，切斩对手进行攻击。容易击中要害。 对范围内最多2名敌人造成285点伤害，并施加战术压制。",
					"power": 285,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "razor_leaf",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "花瓣舞",
					"desc": "在２～３回合内，散落花瓣攻击对手。之后自己会陷入混乱。",
					"detail": "消耗100能量，爆发【花瓣舞】！在２～３回合内，散落花瓣攻击对手。之后自己会陷入混乱。 对范围内最多3名敌人造成480点伤害，并施加战术压制。",
					"power": 480,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "petal_dance",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "污泥炸弹",
					"desc": "用污泥投掷对手进行攻击。有时会让对手陷入中毒状态。",
					"detail": "消耗100能量，释放终极奥义【污泥炸弹】！用污泥投掷对手进行攻击。有时会让对手陷入中毒状态。 席卷战场对最多6名敌人造成655点巨额伤害与强力击破！",
					"power": 655,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "sludge_bomb",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "月亮之力",
					"desc": "借用月亮的力量攻击对手。有时会降低对手的特攻。",
					"detail": "消耗100能量，释放终极奥义【月亮之力】！借用月亮的力量攻击对手。有时会降低对手的特攻。 席卷战场对最多6名敌人造成655点巨额伤害与强力击破！",
					"power": 655,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "cosmic_singularity",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "日光束",
					"desc": "第１回合收集满满的日光，第２回合发射光束进行攻击。",
					"detail": "消耗100能量，释放终极奥义【日光束】！第１回合收集满满的日光，第２回合发射光束进行攻击。 席卷战场对最多6名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "solar_beam",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/gloom.png"
	},
	"vileplume": {
		"id": "vileplume",
		"name": "霸王花",
		"title": "花宝可梦",
		"cost": 3,
		"types": ["Grass", "Poison"],
		"hp": 920,
		"atk": 78,
		"armor": 42,
		"mr": 48,
		"range": 3,
		"atk_speed": 0.7,
		"max_mana": 90,
		"desc": "拥有世界上最巨大的深红带白点花瓣，剧毒花粉随风飘散遮蔽天日，战斗时展开霸王花域压制全场敌军！",
		"skill_name": "终极吸取",
		"skill_desc": "吸取对手的养分进行攻击。可以回复给予对手伤害的一半ＨＰ。",
		"skill_detail": "消耗100能量，使出【终极吸取】。吸取对手的养分进行攻击。可以回复给予对手伤害的一半ＨＰ。 对目标造成210点伤害。",
		"skill_power": 210,
		"basic_attack": {
			"type": "special",
			"name": "飞叶",
			"style": "leaf",
			"sfx": "swift"
		},
						"skills": {
			1: [
				{
					"name": "终极吸取",
					"desc": "吸取对手的养分进行攻击。可以回复给予对手伤害的一半ＨＰ。",
					"detail": "消耗100能量，使出【终极吸取】。吸取对手的养分进行攻击。可以回复给予对手伤害的一半ＨＰ。 对目标造成210点伤害。",
					"power": 210,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "leech_seed",
					"sfx": "skill",
					"scale": 0.28
				},
				{
					"name": "落英缤纷",
					"desc": "猛烈地刮起飞雪般的落花，攻击周围所有的宝可梦，并给予伤害。",
					"detail": "消耗100能量，使出【落英缤纷】。猛烈地刮起飞雪般的落花，攻击周围所有的宝可梦，并给予伤害。 对目标造成280点伤害。",
					"power": 280,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "seed_bomb",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "月亮之力",
					"desc": "借用月亮的力量攻击对手。有时会降低对手的特攻。",
					"detail": "消耗100能量，使出【月亮之力】。借用月亮的力量攻击对手。有时会降低对手的特攻。 对目标造成290点伤害。",
					"power": 290,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "cosmic_singularity",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "污泥炸弹",
					"desc": "用污泥投掷对手进行攻击。有时会让对手陷入中毒状态。",
					"detail": "消耗100能量，爆发【污泥炸弹】。用污泥投掷对手进行攻击。有时会让对手陷入中毒状态。 对范围内最多3名敌人造成350点伤害，并施加战术压制。",
					"power": 350,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "sludge_bomb",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "飞叶快刀",
					"desc": "飞出叶片，切斩对手进行攻击。容易击中要害。",
					"detail": "消耗100能量，爆发【飞叶快刀】！飞出叶片，切斩对手进行攻击。容易击中要害。 对范围内最多2名敌人造成285点伤害，并施加战术压制。",
					"power": 285,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "razor_leaf",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "日光束",
					"desc": "第１回合收集满满的日光，第２回合发射光束进行攻击。",
					"detail": "消耗100能量，爆发【日光束】！第１回合收集满满的日光，第２回合发射光束进行攻击。 对范围内最多3名敌人造成480点伤害，并施加战术压制。",
					"power": 480,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "solar_beam",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "花瓣舞",
					"desc": "在２～３回合内，散落花瓣攻击对手。之后自己会陷入混乱。",
					"detail": "消耗100能量，释放终极奥义【花瓣舞】！在２～３回合内，散落花瓣攻击对手。之后自己会陷入混乱。 席卷战场对最多6名敌人造成700点巨额伤害与强力击破！",
					"power": 700,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "petal_dance",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "疯狂植物",
					"desc": "用大树摔打对手进行攻击。下一回合自己将无法动弹。",
					"detail": "消耗100能量，释放终极奥义【疯狂植物】！用大树摔打对手进行攻击。下一回合自己将无法动弹。 席卷战场对最多6名敌人造成930点巨额伤害与强力击破！",
					"power": 930,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "frenzy_plant",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，释放终极奥义【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 席卷战场对最多4名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/vileplume.png"
	},
	"paras": {
		"id": "paras",
		"name": "派拉斯",
		"title": "蘑菇宝可梦",
		"cost": 1,
		"types": ["Bug", "Grass"],
		"hp": 540,
		"atk": 52,
		"armor": 28,
		"mr": 28,
		"range": 1,
		"atk_speed": 0.7,
		"max_mana": 80,
		"desc": "背上寄生着两朵名为冬虫夏草的红色蘑菇，蘑菇会指挥本体吸收树木养分，双爪能挥舞十字剪切开敌人。",
		"skill_name": "抓",
		"skill_desc": "用坚硬且无比锋利的爪子抓对手进行攻击。",
		"skill_detail": "消耗100能量，使出【抓】。用坚硬且无比锋利的爪子抓对手进行攻击。 对目标造成182点伤害。",
		"skill_power": 182,
		"basic_attack": {
			"type": "physical",
			"name": "抓击",
			"style": "slash",
			"sfx": "slash"
		},
						"skills": {
			1: [
				{
					"name": "抓",
					"desc": "用坚硬且无比锋利的爪子抓对手进行攻击。",
					"detail": "消耗100能量，使出【抓】。用坚硬且无比锋利的爪子抓对手进行攻击。 对目标造成182点伤害。",
					"power": 182,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "slash",
					"sfx": "slash",
					"scale": 0.28
				},
				{
					"name": "吸血",
					"desc": "吸取血液攻击对手。可以回复给予对手伤害的一半ＨＰ。",
					"detail": "消耗100能量，使出【吸血】。吸取血液攻击对手。可以回复给予对手伤害的一半ＨＰ。 对目标造成260点伤害。",
					"power": 260,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "leech_life",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "泰山压顶",
					"desc": "用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，使出【泰山压顶】。用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。 对目标造成270点伤害。",
					"power": 270,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "蘑菇孢子",
					"desc": "沙沙沙地撒满具有催眠效果的孢子，从而让对手陷入睡眠状态。",
					"detail": "消耗100能量，爆发【蘑菇孢子】。沙沙沙地撒满具有催眠效果的孢子，从而让对手陷入睡眠状态。 对范围内最多3名敌人造成300点伤害，并施加战术压制。",
					"power": 300,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "leech_seed",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，爆发【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 对范围内最多2名敌人造成390点伤害，并施加战术压制。",
					"power": 390,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "舍身冲撞",
					"desc": "拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。",
					"detail": "消耗100能量，爆发【舍身冲撞】！拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。 对范围内最多2名敌人造成480点伤害，并施加战术压制。",
					"power": 480,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "double_edge",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "十字剪",
					"desc": "将镰刀或爪子像剪刀般地交叉，顺势劈开对手。",
					"detail": "消耗100能量，释放终极奥义【十字剪】！将镰刀或爪子像剪刀般地交叉，顺势劈开对手。 席卷战场对最多6名敌人造成640点巨额伤害与强力击破！",
					"power": 640,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "x_scissor",
					"sfx": "slash",
					"scale": 0.48
				},
				{
					"name": "日光束",
					"desc": "第１回合收集满满的日光，第２回合发射光束进行攻击。",
					"detail": "消耗100能量，释放终极奥义【日光束】！第１回合收集满满的日光，第２回合发射光束进行攻击。 席卷战场对最多6名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "solar_beam",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "能量球",
					"desc": "发射从自然收集的生命力量。有时会降低对手的特防。",
					"detail": "消耗100能量，释放终极奥义【能量球】！发射从自然收集的生命力量。有时会降低对手的特防。 席卷战场对最多6名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "seed_bomb",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/paras.png"
	},
	"parasect": {
		"id": "parasect",
		"name": "派拉斯特",
		"title": "蘑菇宝可梦",
		"cost": 3,
		"types": ["Bug", "Grass"],
		"hp": 860,
		"atk": 80,
		"armor": 45,
		"mr": 45,
		"range": 1,
		"atk_speed": 0.72,
		"max_mana": 85,
		"desc": "虫体已被背上巨大的冬虫夏草完全操纵，白色的死寂双眼不会眨动，能从伞盖下喷洒出让一切陷入昏厥的强力孢子！",
		"skill_name": "吸血",
		"skill_desc": "吸取血液攻击对手。可以回复给予对手伤害的一半ＨＰ。",
		"skill_detail": "消耗100能量，使出【吸血】。吸取血液攻击对手。可以回复给予对手伤害的一半ＨＰ。 对目标造成214点伤害。",
		"skill_power": 214,
		"basic_attack": {
			"type": "physical",
			"name": "抓击",
			"style": "slash",
			"sfx": "slash"
		},
						"skills": {
			1: [
				{
					"name": "吸血",
					"desc": "吸取血液攻击对手。可以回复给予对手伤害的一半ＨＰ。",
					"detail": "消耗100能量，使出【吸血】。吸取血液攻击对手。可以回复给予对手伤害的一半ＨＰ。 对目标造成214点伤害。",
					"power": 214,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "leech_life",
					"sfx": "slash",
					"scale": 0.28
				},
				{
					"name": "抓",
					"desc": "用坚硬且无比锋利的爪子抓对手进行攻击。",
					"detail": "消耗100能量，使出【抓】。用坚硬且无比锋利的爪子抓对手进行攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "slash",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "劈开",
					"desc": "用爪子或镰刀等劈开对手进行攻击。容易击中要害。",
					"detail": "消耗100能量，使出【劈开】。用爪子或镰刀等劈开对手进行攻击。容易击中要害。 对目标造成240点伤害。",
					"power": 240,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "pin_missile",
					"sfx": "slash",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "蘑菇孢子",
					"desc": "沙沙沙地撒满具有催眠效果的孢子，从而让对手陷入睡眠状态。",
					"detail": "消耗100能量，爆发【蘑菇孢子】。沙沙沙地撒满具有催眠效果的孢子，从而让对手陷入睡眠状态。 对范围内最多3名敌人造成300点伤害，并施加战术压制。",
					"power": 300,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "leech_seed",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "泰山压顶",
					"desc": "用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，爆发【泰山压顶】！用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。 对范围内最多2名敌人造成375点伤害，并施加战术压制。",
					"power": 375,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，爆发【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 对范围内最多2名敌人造成390点伤害，并施加战术压制。",
					"power": 390,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "十字剪",
					"desc": "将镰刀或爪子像剪刀般地交叉，顺势劈开对手。",
					"detail": "消耗100能量，释放终极奥义【十字剪】！将镰刀或爪子像剪刀般地交叉，顺势劈开对手。 席卷战场对最多6名敌人造成640点巨额伤害与强力击破！",
					"power": 640,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "x_scissor",
					"sfx": "slash",
					"scale": 0.48
				},
				{
					"name": "舍身冲撞",
					"desc": "拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。",
					"detail": "消耗100能量，释放终极奥义【舍身冲撞】！拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "double_edge",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "能量球",
					"desc": "发射从自然收集的生命力量。有时会降低对手的特防。",
					"detail": "消耗100能量，释放终极奥义【能量球】！发射从自然收集的生命力量。有时会降低对手的特防。 席卷战场对最多6名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "seed_bomb",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/parasect.png"
	},
	"venonat": {
		"id": "venonat",
		"name": "毛球",
		"title": "昆虫宝可梦",
		"cost": 1,
		"types": ["Bug", "Poison"],
		"hp": 540,
		"atk": 46,
		"armor": 25,
		"mr": 28,
		"range": 2,
		"atk_speed": 0.7,
		"max_mana": 80,
		"desc": "全身覆盖着软绵绵的紫黑色毒毛，一双巨大的复眼具有红外雷达功能，在漆黑夜晚中也能看清一厘米的小虫。",
		"skill_name": "撞击",
		"skill_desc": "用整个身体撞向对手进行攻击。",
		"skill_detail": "消耗100能量，使出【撞击】。用整个身体撞向对手进行攻击。 对目标造成182点伤害。",
		"skill_power": 182,
		"basic_attack": {
			"type": "special",
			"name": "魔法弹",
			"style": "spark",
			"sfx": "swift"
		},
						"skills": {
			1: [
				{
					"name": "撞击",
					"desc": "用整个身体撞向对手进行攻击。",
					"detail": "消耗100能量，使出【撞击】。用整个身体撞向对手进行攻击。 对目标造成182点伤害。",
					"power": 182,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "tackle",
					"sfx": "attack",
					"scale": 0.28
				},
				{
					"name": "虫之抵抗",
					"desc": "抵抗并攻击对手。降低对手的特攻。",
					"detail": "消耗100能量，使出【虫之抵抗】。抵抗并攻击对手。降低对手的特攻。 对目标造成200点伤害。",
					"power": 200,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "bug_buzz",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "吸血",
					"desc": "吸取血液攻击对手。可以回复给予对手伤害的一半ＨＰ。",
					"detail": "消耗100能量，使出【吸血】。吸取血液攻击对手。可以回复给予对手伤害的一半ＨＰ。 对目标造成260点伤害。",
					"power": 260,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "leech_life",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "念力",
					"desc": "向对手发送微弱的念力进行攻击。有时会使对手混乱。",
					"detail": "消耗100能量，爆发【念力】。向对手发送微弱的念力进行攻击。有时会使对手混乱。 对范围内最多3名敌人造成310点伤害，并施加战术压制。",
					"power": 310,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "confusion",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "精神强念",
					"desc": "向对手发送强大的念力进行攻击。有时会降低对手的特防。",
					"detail": "消耗100能量，爆发【精神强念】！向对手发送强大的念力进行攻击。有时会降低对手的特防。 对范围内最多3名敌人造成390点伤害，并施加战术压制。",
					"power": 390,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "psychic",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "意念头锤",
					"desc": "将思念的力量集中在前额进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，爆发【意念头锤】！将思念的力量集中在前额进行攻击。有时会使对手畏缩。 对范围内最多2名敌人造成360点伤害，并施加战术压制。",
					"power": 360,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "zen_headbutt",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "幻象光线",
					"desc": "向对手发射神奇的光线进行攻击。有时会使对手混乱。",
					"detail": "消耗100能量，释放终极奥义【幻象光线】！向对手发射神奇的光线进行攻击。有时会使对手混乱。 席卷战场对最多6名敌人造成617点巨额伤害与强力击破！",
					"power": 617,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "psybeam",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，释放终极奥义【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 席卷战场对最多4名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "剧毒牙",
					"desc": "用有毒的牙齿咬住对手进行攻击。有时会使对手中剧毒。",
					"detail": "消耗100能量，释放终极奥义【剧毒牙】！用有毒的牙齿咬住对手进行攻击。有时会使对手中剧毒。 席卷战场对最多4名敌人造成430点巨额伤害与强力击破！",
					"power": 430,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "poison_sting",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/venonat.png"
	},
	"venomoth": {
		"id": "venomoth",
		"name": "摩鲁蛾",
		"title": "毒蛾宝可梦",
		"cost": 3,
		"types": ["Bug", "Poison"],
		"hp": 780,
		"atk": 72,
		"armor": 35,
		"mr": 45,
		"range": 3,
		"atk_speed": 0.75,
		"max_mana": 85,
		"desc": "翅膀上覆盖着细微的磷粉，不同颜色的磷粉代表着不同的剧毒，拍动双翅时磷粉如雨落下腐蚀一切！",
		"skill_name": "幻象光线",
		"skill_desc": "向对手发射神奇的光线进行攻击。有时会使对手混乱。",
		"skill_detail": "消耗100能量，使出【幻象光线】。向对手发射神奇的光线进行攻击。有时会使对手混乱。 对目标造成202点伤害。",
		"skill_power": 202,
		"basic_attack": {
			"type": "special",
			"name": "魔法弹",
			"style": "spark",
			"sfx": "swift"
		},
						"skills": {
			1: [
				{
					"name": "幻象光线",
					"desc": "向对手发射神奇的光线进行攻击。有时会使对手混乱。",
					"detail": "消耗100能量，使出【幻象光线】。向对手发射神奇的光线进行攻击。有时会使对手混乱。 对目标造成202点伤害。",
					"power": 202,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "psybeam",
					"sfx": "skill",
					"scale": 0.28
				},
				{
					"name": "起风",
					"desc": "用翅膀将刮起的狂风袭向对手进行攻击。",
					"detail": "消耗100能量，使出【起风】。用翅膀将刮起的狂风袭向对手进行攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "gust",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "撞击",
					"desc": "用整个身体撞向对手进行攻击。",
					"detail": "消耗100能量，使出【撞击】。用整个身体撞向对手进行攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "tackle",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "污泥炸弹",
					"desc": "用污泥投掷对手进行攻击。有时会让对手陷入中毒状态。",
					"detail": "消耗100能量，爆发【污泥炸弹】。用污泥投掷对手进行攻击。有时会让对手陷入中毒状态。 对范围内最多3名敌人造成350点伤害，并施加战术压制。",
					"power": 350,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "sludge_bomb",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "吸血",
					"desc": "吸取血液攻击对手。可以回复给予对手伤害的一半ＨＰ。",
					"detail": "消耗100能量，爆发【吸血】！吸取血液攻击对手。可以回复给予对手伤害的一半ＨＰ。 对范围内最多2名敌人造成360点伤害，并施加战术压制。",
					"power": 360,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "leech_life",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "精神强念",
					"desc": "向对手发送强大的念力进行攻击。有时会降低对手的特防。",
					"detail": "消耗100能量，爆发【精神强念】！向对手发送强大的念力进行攻击。有时会降低对手的特防。 对范围内最多3名敌人造成390点伤害，并施加战术压制。",
					"power": 390,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "psychic",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "虫鸣",
					"desc": "利用振动发出音波进行攻击。有时会降低对手的特防。",
					"detail": "消耗100能量，释放终极奥义【虫鸣】！利用振动发出音波进行攻击。有时会降低对手的特防。 席卷战场对最多6名敌人造成655点巨额伤害与强力击破！",
					"power": 655,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "bug_buzz",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，释放终极奥义【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 席卷战场对最多4名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "剧毒牙",
					"desc": "用有毒的牙齿咬住对手进行攻击。有时会使对手中剧毒。",
					"detail": "消耗100能量，释放终极奥义【剧毒牙】！用有毒的牙齿咬住对手进行攻击。有时会使对手中剧毒。 席卷战场对最多4名敌人造成430点巨额伤害与强力击破！",
					"power": 430,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "poison_sting",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/venomoth.png"
	},
	"diglett": {
		"id": "diglett",
		"name": "地鼠",
		"title": "鼹鼠宝可梦",
		"cost": 1,
		"types": ["Ground"],
		"hp": 480,
		"atk": 55,
		"armor": 25,
		"mr": 25,
		"range": 1,
		"atk_speed": 0.85,
		"max_mana": 70,
		"desc": "生活在地下一米深处的松软土壤里，以植物根茎为食，在地底以极高速度穿梭，只露出一颗圆圆的脑袋。",
		"skill_name": "抓",
		"skill_desc": "用坚硬且无比锋利的爪子抓对手进行攻击。",
		"skill_detail": "消耗100能量，使出【抓】。用坚硬且无比锋利的爪子抓对手进行攻击。 对目标造成182点伤害。",
		"skill_power": 182,
		"basic_attack": {
			"type": "physical",
			"name": "撞击",
			"style": "tackle",
			"sfx": "attack"
		},
						"skills": {
			1: [
				{
					"name": "抓",
					"desc": "用坚硬且无比锋利的爪子抓对手进行攻击。",
					"detail": "消耗100能量，使出【抓】。用坚硬且无比锋利的爪子抓对手进行攻击。 对目标造成182点伤害。",
					"power": 182,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "slash",
					"sfx": "slash",
					"scale": 0.28
				},
				{
					"name": "惊吓",
					"desc": "用尖叫声等突然惊吓对手进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，使出【惊吓】。用尖叫声等突然惊吓对手进行攻击。有时会使对手畏缩。 对目标造成160点伤害。",
					"power": 160,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "night_shade",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "泰山压顶",
					"desc": "用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，使出【泰山压顶】。用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。 对目标造成270点伤害。",
					"power": 270,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "掷泥",
					"desc": "向对手的脸等投掷泥块进行攻击。会降低对手的命中率。",
					"detail": "消耗100能量，爆发【掷泥】。向对手的脸等投掷泥块进行攻击。会降低对手的命中率。 对范围内最多3名敌人造成280点伤害，并施加战术压制。",
					"power": 280,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "mud_slap",
					"sfx": "attack",
					"scale": 0.36
				},
				{
					"name": "突袭",
					"desc": "可以比对手先攻击。对手使出的招式如果不是攻击招式则会失败。",
					"detail": "消耗100能量，爆发【突袭】！可以比对手先攻击。对手使出的招式如果不是攻击招式则会失败。 对范围内最多2名敌人造成330点伤害，并施加战术压制。",
					"power": 330,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "mach_punch",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，爆发【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 对范围内最多2名敌人造成390点伤害，并施加战术压制。",
					"power": 390,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "重踏",
					"desc": "用力踩踏地面并攻击自己周围所有的宝可梦。降低对方的速度。",
					"detail": "消耗100能量，释放终极奥义【重踏】！用力踩踏地面并攻击自己周围所有的宝可梦。降低对方的速度。 席卷战场对最多6名敌人造成610点巨额伤害与强力击破！",
					"power": 610,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "earthquake",
					"sfx": "attack",
					"scale": 0.48
				},
				{
					"name": "舍身冲撞",
					"desc": "拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。",
					"detail": "消耗100能量，释放终极奥义【舍身冲撞】！拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "double_edge",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "尖石攻击",
					"desc": "用尖尖的岩石刺入对手进行攻击。容易击中要害。",
					"detail": "消耗100能量，释放终极奥义【尖石攻击】！用尖尖的岩石刺入对手进行攻击。容易击中要害。 席卷战场对最多4名敌人造成680点巨额伤害与强力击破！",
					"power": 680,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "stone_edge",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/diglett.png"
	},
	"dugtrio": {
		"id": "dugtrio",
		"name": "三地鼠",
		"title": "鼹鼠宝可梦",
		"cost": 2,
		"types": ["Ground"],
		"hp": 720,
		"atk": 75,
		"armor": 35,
		"mr": 35,
		"range": 1,
		"atk_speed": 0.88,
		"max_mana": 75,
		"desc": "三个脑袋齐心协力地在地下高速挖掘，能以超过100公里的时速挖掘地底隧道，引发大范围局部地震！",
		"skill_name": "掷泥",
		"skill_desc": "向对手的脸等投掷泥块进行攻击。会降低对手的命中率。",
		"skill_detail": "消耗100能量，使出【掷泥】。向对手的脸等投掷泥块进行攻击。会降低对手的命中率。 对目标造成166点伤害。",
		"skill_power": 166,
		"basic_attack": {
			"type": "physical",
			"name": "撞击",
			"style": "tackle",
			"sfx": "attack"
		},
						"skills": {
			1: [
				{
					"name": "掷泥",
					"desc": "向对手的脸等投掷泥块进行攻击。会降低对手的命中率。",
					"detail": "消耗100能量，使出【掷泥】。向对手的脸等投掷泥块进行攻击。会降低对手的命中率。 对目标造成166点伤害。",
					"power": 166,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "mud_slap",
					"sfx": "attack",
					"scale": 0.28
				},
				{
					"name": "抓",
					"desc": "用坚硬且无比锋利的爪子抓对手进行攻击。",
					"detail": "消耗100能量，使出【抓】。用坚硬且无比锋利的爪子抓对手进行攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "slash",
					"sfx": "slash",
					"scale": 0.82
				},
				{
					"name": "泰山压顶",
					"desc": "用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，使出【泰山压顶】。用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。 对目标造成270点伤害。",
					"power": 270,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "岩崩",
					"desc": "将大岩石猛烈地撞向对手进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，爆发【岩崩】。将大岩石猛烈地撞向对手进行攻击。有时会使对手畏缩。 对范围内最多3名敌人造成335点伤害，并施加战术压制。",
					"power": 335,
					"target_count": 3,
					"stun_duration": 0.8,
					"vfx": "rock_slide",
					"sfx": "attack",
					"scale": 0.36
				},
				{
					"name": "突袭",
					"desc": "可以比对手先攻击。对手使出的招式如果不是攻击招式则会失败。",
					"detail": "消耗100能量，爆发【突袭】！可以比对手先攻击。对手使出的招式如果不是攻击招式则会失败。 对范围内最多2名敌人造成330点伤害，并施加战术压制。",
					"power": 330,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "mach_punch",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，爆发【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 对范围内最多2名敌人造成390点伤害，并施加战术压制。",
					"power": 390,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "地震",
					"desc": "利用地震的冲击，攻击自己周围所有的宝可梦。",
					"detail": "消耗100能量，释放终极奥义【地震】！利用地震的冲击，攻击自己周围所有的宝可梦。 席卷战场对最多6名敌人造成670点巨额伤害与强力击破！",
					"power": 670,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "earthquake",
					"sfx": "attack",
					"scale": 0.48
				},
				{
					"name": "舍身冲撞",
					"desc": "拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。",
					"detail": "消耗100能量，释放终极奥义【舍身冲撞】！拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "double_edge",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "尖石攻击",
					"desc": "用尖尖的岩石刺入对手进行攻击。容易击中要害。",
					"detail": "消耗100能量，释放终极奥义【尖石攻击】！用尖尖的岩石刺入对手进行攻击。容易击中要害。 席卷战场对最多4名敌人造成680点巨额伤害与强力击破！",
					"power": 680,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "stone_edge",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/dugtrio.png"
	},
	"meowth": {
		"id": "meowth",
		"name": "喵喵",
		"title": "妖怪猫宝可梦",
		"cost": 1,
		"types": ["Normal"],
		"hp": 520,
		"atk": 54,
		"armor": 22,
		"mr": 22,
		"range": 1,
		"atk_speed": 0.8,
		"max_mana": 75,
		"desc": "额头镶嵌着一枚金灿灿的大金币，非常喜欢闪闪发光的东西，动作敏捷轻盈，爪子里隐藏着锋利的刀刃。",
		"skill_name": "抓",
		"skill_desc": "用坚硬且无比锋利的爪子抓对手进行攻击。",
		"skill_detail": "消耗100能量，使出【抓】。用坚硬且无比锋利的爪子抓对手进行攻击。 对目标造成182点伤害。",
		"skill_power": 182,
		"basic_attack": {
			"type": "physical",
			"name": "抓击",
			"style": "slash",
			"sfx": "slash"
		},
						"skills": {
			1: [
				{
					"name": "抓",
					"desc": "用坚硬且无比锋利的爪子抓对手进行攻击。",
					"detail": "消耗100能量，使出【抓】。用坚硬且无比锋利的爪子抓对手进行攻击。 对目标造成182点伤害。",
					"power": 182,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "slash",
					"sfx": "slash",
					"scale": 0.28
				},
				{
					"name": "咬住",
					"desc": "用尖锐的牙咬住对手进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，使出【咬住】。用尖锐的牙咬住对手进行攻击。有时会使对手畏缩。 对目标造成220点伤害。",
					"power": 220,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "bite",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "出奇一击",
					"desc": "悄悄地靠近对手，趁其不备进行殴打。攻击必定会命中。",
					"detail": "消耗100能量，使出【出奇一击】。悄悄地靠近对手，趁其不备进行殴打。攻击必定会命中。 对目标造成220点伤害。",
					"power": 220,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "聚宝功",
					"desc": "向对手的身体投掷小金币进行攻击。战斗后可以拿到钱。",
					"detail": "消耗100能量，爆发【聚宝功】。向对手的身体投掷小金币进行攻击。战斗后可以拿到钱。 对范围内最多3名敌人造成300点伤害，并施加战术压制。",
					"power": 300,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "swift",
					"sfx": "swift",
					"scale": 0.36
				},
				{
					"name": "乱抓",
					"desc": "用爪子或镰刀等抓对手进行攻击。连续攻击２～５次。",
					"detail": "消耗100能量，爆发【乱抓】！用爪子或镰刀等抓对手进行攻击。连续攻击２～５次。 对范围内最多2名敌人造成174点伤害，并施加战术压制。",
					"power": 174,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "headbutt",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "嬉闹",
					"desc": "与对手嬉闹并攻击。有时会降低对手的攻击。",
					"detail": "消耗100能量，爆发【嬉闹】！与对手嬉闹并攻击。有时会降低对手的攻击。 对范围内最多2名敌人造成390点伤害，并施加战术压制。",
					"power": 390,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "tackle",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "舍身冲撞",
					"desc": "拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。",
					"detail": "消耗100能量，释放终极奥义【舍身冲撞】！拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "double_edge",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，释放终极奥义【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 席卷战场对最多4名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "十万伏特",
					"desc": "向对手发出强力电击进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，释放终极奥义【十万伏特】！向对手发出强力电击进行攻击。有时会让对手陷入麻痹状态。 席卷战场对最多6名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "thunderbolt",
					"sfx": "thunder",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/meowth.png"
	},
	"persian": {
		"id": "persian",
		"name": "猫老大",
		"title": "暹罗猫宝可梦",
		"cost": 3,
		"types": ["Normal"],
		"hp": 780,
		"atk": 85,
		"armor": 35,
		"mr": 35,
		"range": 1,
		"atk_speed": 0.85,
		"max_mana": 75,
		"desc": "举止高贵优雅，额头镶嵌着璀璨红宝石，奔跑时脚步轻灵无声无息，性情极其暴戾好战，瞬间撕碎猎物咽喉！",
		"skill_name": "咬住",
		"skill_desc": "用尖锐的牙咬住对手进行攻击。有时会使对手畏缩。",
		"skill_detail": "消耗100能量，使出【咬住】。用尖锐的牙咬住对手进行攻击。有时会使对手畏缩。 对目标造成198点伤害。",
		"skill_power": 198,
		"basic_attack": {
			"type": "physical",
			"name": "抓击",
			"style": "slash",
			"sfx": "slash"
		},
						"skills": {
			1: [
				{
					"name": "咬住",
					"desc": "用尖锐的牙咬住对手进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，使出【咬住】。用尖锐的牙咬住对手进行攻击。有时会使对手畏缩。 对目标造成198点伤害。",
					"power": 198,
					"target_count": 1,
					"stun_duration": 0.5,
					"vfx": "bite",
					"sfx": "bite",
					"scale": 0.28
				},
				{
					"name": "高速星星",
					"desc": "发射星形的光攻击对手。攻击必定会命中。",
					"detail": "消耗100能量，使出【高速星星】。发射星形的光攻击对手。攻击必定会命中。 对目标造成220点伤害。",
					"power": 220,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "swift",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "聚宝功",
					"desc": "向对手的身体投掷小金币进行攻击。战斗后可以拿到钱。",
					"detail": "消耗100能量，使出【聚宝功】。向对手的身体投掷小金币进行攻击。战斗后可以拿到钱。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "ancient_power",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "劈开",
					"desc": "用爪子或镰刀等劈开对手进行攻击。容易击中要害。",
					"detail": "消耗100能量，爆发【劈开】。用爪子或镰刀等劈开对手进行攻击。容易击中要害。 对范围内最多3名敌人造成330点伤害，并施加战术压制。",
					"power": 330,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "slash",
					"sfx": "slash",
					"scale": 0.36
				},
				{
					"name": "乱抓",
					"desc": "用爪子或镰刀等抓对手进行攻击。连续攻击２～５次。",
					"detail": "消耗100能量，爆发【乱抓】！用爪子或镰刀等抓对手进行攻击。连续攻击２～５次。 对范围内最多2名敌人造成174点伤害，并施加战术压制。",
					"power": 174,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "headbutt",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "恶意追击",
					"desc": "如果此回合内对手已经受到伤害的话，招式威力会变成２倍。",
					"detail": "消耗100能量，爆发【恶意追击】！如果此回合内对手已经受到伤害的话，招式威力会变成２倍。 对范围内最多2名敌人造成300点伤害，并施加战术压制。",
					"power": 300,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "tackle",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "嬉闹",
					"desc": "与对手嬉闹并攻击。有时会降低对手的攻击。",
					"detail": "消耗100能量，释放终极奥义【嬉闹】！与对手嬉闹并攻击。有时会降低对手的攻击。 席卷战场对最多6名敌人造成655点巨额伤害与强力击破！",
					"power": 655,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "body_slam",
					"sfx": "attack",
					"scale": 0.48
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，释放终极奥义【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 席卷战场对最多4名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "舍身冲撞",
					"desc": "拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。",
					"detail": "消耗100能量，释放终极奥义【舍身冲撞】！拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "double_edge",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/persian.png"
	},
	"golduck": {
		"id": "golduck",
		"name": "哥达鸭",
		"title": "鸭宝可梦",
		"cost": 3,
		"types": ["Water", "Psychic"],
		"hp": 860,
		"atk": 78,
		"armor": 38,
		"mr": 48,
		"range": 2,
		"atk_speed": 0.78,
		"max_mana": 90,
		"desc": "额头上的红色宝石在释放念力时会发出耀眼光芒，游泳速度堪比金牌运动员，擅长以高压水流配合精神念力制霸水陆！",
		"skill_name": "水枪",
		"skill_desc": "向对手猛烈地喷射水流进行攻击。",
		"skill_detail": "消耗100能量，使出【水枪】。向对手猛烈地喷射水流进行攻击。 对目标造成182点伤害。",
		"skill_power": 182,
		"basic_attack": {
			"type": "special",
			"name": "水滴弹",
			"style": "water_bullet",
			"sfx": "water"
		},
						"skills": {
			1: [
				{
					"name": "水枪",
					"desc": "向对手猛烈地喷射水流进行攻击。",
					"detail": "消耗100能量，使出【水枪】。向对手猛烈地喷射水流进行攻击。 对目标造成182点伤害。",
					"power": 182,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "water_gun",
					"sfx": "water",
					"scale": 0.28
				},
				{
					"name": "抓",
					"desc": "用坚硬且无比锋利的爪子抓对手进行攻击。",
					"detail": "消耗100能量，使出【抓】。用坚硬且无比锋利的爪子抓对手进行攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "slash",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "意念头锤",
					"desc": "将思念的力量集中在前额进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，使出【意念头锤】。将思念的力量集中在前额进行攻击。有时会使对手畏缩。 对目标造成260点伤害。",
					"power": 260,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "zen_headbutt",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "精神强念",
					"desc": "向对手发送强大的念力进行攻击。有时会降低对手的特防。",
					"detail": "消耗100能量，爆发【精神强念】。向对手发送强大的念力进行攻击。有时会降低对手的特防。 对范围内最多3名敌人造成350点伤害，并施加战术压制。",
					"power": 350,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "psychic",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "念力",
					"desc": "向对手发送微弱的念力进行攻击。有时会使对手混乱。",
					"detail": "消耗100能量，爆发【念力】！向对手发送微弱的念力进行攻击。有时会使对手混乱。 对范围内最多3名敌人造成270点伤害，并施加战术压制。",
					"power": 270,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "confusion",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "乱抓",
					"desc": "用爪子或镰刀等抓对手进行攻击。连续攻击２～５次。",
					"detail": "消耗100能量，爆发【乱抓】！用爪子或镰刀等抓对手进行攻击。连续攻击２～５次。 对范围内最多2名敌人造成174点伤害，并施加战术压制。",
					"power": 174,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "headbutt",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "水炮",
					"desc": "向对手猛烈地喷射大量水流进行攻击。",
					"detail": "消耗100能量，释放终极奥义【水炮】！向对手猛烈地喷射大量水流进行攻击。 席卷战场对最多6名敌人造成685点巨额伤害与强力击破！",
					"power": 685,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "hydro_pump",
					"sfx": "water",
					"scale": 0.48
				},
				{
					"name": "冲浪",
					"desc": "利用大浪攻击自己周围所有的宝可梦。",
					"detail": "消耗100能量，释放终极奥义【冲浪】！利用大浪攻击自己周围所有的宝可梦。 席卷战场对最多6名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "surf",
					"sfx": "water",
					"scale": 1.55
				},
				{
					"name": "根源波动",
					"desc": "用无数青白色且闪耀的光线攻击对手。",
					"detail": "消耗100能量，释放终极奥义【根源波动】！用无数青白色且闪耀的光线攻击对手。 席卷战场对最多6名敌人造成730点巨额伤害与强力击破！",
					"power": 730,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "hydro_cannon",
					"sfx": "water",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/golduck.png"
	},
	"mankey": {
		"id": "mankey",
		"name": "猴怪",
		"title": "猪猴宝可梦",
		"cost": 1,
		"types": ["Fighting"],
		"hp": 540,
		"atk": 56,
		"armor": 24,
		"mr": 24,
		"range": 1,
		"atk_speed": 0.78,
		"max_mana": 75,
		"desc": "脾气极其暴躁，一秒内就会暴怒狂化，发怒时血液流动加速肌肉隆起，挥舞狂暴拳头不死不休地揍扁敌人！",
		"skill_name": "踢倒",
		"skill_desc": "用力踢对手的脚，使其摔倒进行攻击。对手越重，威力越大。",
		"skill_detail": "消耗100能量，使出【踢倒】。用力踢对手的脚，使其摔倒进行攻击。对手越重，威力越大。 对目标造成160点伤害。",
		"skill_power": 160,
		"basic_attack": {
			"type": "physical",
			"name": "连续拳",
			"style": "punch",
			"sfx": "punch"
		},
						"skills": {
			1: [
				{
					"name": "踢倒",
					"desc": "用力踢对手的脚，使其摔倒进行攻击。对手越重，威力越大。",
					"detail": "消耗100能量，使出【踢倒】。用力踢对手的脚，使其摔倒进行攻击。对手越重，威力越大。 对目标造成160点伤害。",
					"power": 160,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "low_kick",
					"sfx": "punch",
					"scale": 0.28
				},
				{
					"name": "抓",
					"desc": "用坚硬且无比锋利的爪子抓对手进行攻击。",
					"detail": "消耗100能量，使出【抓】。用坚硬且无比锋利的爪子抓对手进行攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "slash",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "乱抓",
					"desc": "用爪子或镰刀等抓对手进行攻击。连续攻击２～５次。",
					"detail": "消耗100能量，使出【乱抓】。用爪子或镰刀等抓对手进行攻击。连续攻击２～５次。 对目标造成136点伤害。",
					"power": 136,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "headbutt",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "空手劈",
					"desc": "用锋利的手刀劈向对手进行攻击。容易击中要害。",
					"detail": "消耗100能量，爆发【空手劈】。用锋利的手刀劈向对手进行攻击。容易击中要害。 对范围内最多3名敌人造成310点伤害，并施加战术压制。",
					"power": 310,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "cross_chop",
					"sfx": "punch",
					"scale": 0.36
				},
				{
					"name": "地球上投",
					"desc": "利用引力将对手甩飞出去。给予对手和自己等级相同的伤害。",
					"detail": "消耗100能量，爆发【地球上投】！利用引力将对手甩飞出去。给予对手和自己等级相同的伤害。 对范围内最多2名敌人造成320点伤害，并施加战术压制。",
					"power": 320,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "mega_punch",
					"sfx": "punch",
					"scale": 1.10
				},
				{
					"name": "跺脚",
					"desc": "化悔恨为力量进行攻击。如果上一回合招式没有打中，威力就会翻倍。",
					"detail": "消耗100能量，爆发【跺脚】！化悔恨为力量进行攻击。如果上一回合招式没有打中，威力就会翻倍。 对范围内最多2名敌人造成345点伤害，并施加战术压制。",
					"power": 345,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "earthquake",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "近身战",
					"desc": "放弃守护，向对手的怀里突击。自己的防御和特防会降低。",
					"detail": "消耗100能量，释放终极奥义【近身战】！放弃守护，向对手的怀里突击。自己的防御和特防会降低。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "close_combat",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "大闹一番",
					"desc": "在２～３回合内，乱打一气地攻击对手。大闹一番后自己会陷入混乱。",
					"detail": "消耗100能量，释放终极奥义【大闹一番】！在２～３回合内，乱打一气地攻击对手。大闹一番后自己会陷入混乱。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "double_edge",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "百万吨重踢",
					"desc": "使出力大无穷的重踢踢飞对手进行攻击。",
					"detail": "消耗100能量，释放终极奥义【百万吨重踢】！使出力大无穷的重踢踢飞对手进行攻击。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "mega_kick",
					"sfx": "punch",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/mankey.png"
	},
	"primeape": {
		"id": "primeape",
		"name": "火暴猴",
		"title": "猪猴宝可梦",
		"cost": 3,
		"types": ["Fighting"],
		"hp": 820,
		"atk": 85,
		"armor": 38,
		"mr": 38,
		"range": 1,
		"atk_speed": 0.82,
		"max_mana": 75,
		"desc": "无时无刻不在发怒，眼中只有战斗与狂暴，即使睡觉时也会因愤怒突然暴起，拳力之大能击碎一切钢铁要塞！",
		"skill_name": "踢倒",
		"skill_desc": "用力踢对手的脚，使其摔倒进行攻击。对手越重，威力越大。",
		"skill_detail": "消耗100能量，使出【踢倒】。用力踢对手的脚，使其摔倒进行攻击。对手越重，威力越大。 对目标造成160点伤害。",
		"skill_power": 160,
		"basic_attack": {
			"type": "physical",
			"name": "连续拳",
			"style": "punch",
			"sfx": "punch"
		},
						"skills": {
			1: [
				{
					"name": "踢倒",
					"desc": "用力踢对手的脚，使其摔倒进行攻击。对手越重，威力越大。",
					"detail": "消耗100能量，使出【踢倒】。用力踢对手的脚，使其摔倒进行攻击。对手越重，威力越大。 对目标造成160点伤害。",
					"power": 160,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "low_kick",
					"sfx": "punch",
					"scale": 0.28
				},
				{
					"name": "愤怒",
					"desc": "如果在使出招式后受到攻击的话，会因愤怒的力量而提高攻击。",
					"detail": "消耗100能量，使出【愤怒】。如果在使出招式后受到攻击的话，会因愤怒的力量而提高攻击。 对目标造成140点伤害。",
					"power": 140,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "抓",
					"desc": "用坚硬且无比锋利的爪子抓对手进行攻击。",
					"detail": "消耗100能量，使出【抓】。用坚硬且无比锋利的爪子抓对手进行攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "slash",
					"sfx": "slash",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "十字劈",
					"desc": "用两手呈十字劈打对手进行攻击。容易击中要害。",
					"detail": "消耗100能量，爆发【十字劈】。用两手呈十字劈打对手进行攻击。容易击中要害。 对范围内最多3名敌人造成360点伤害，并施加战术压制。",
					"power": 360,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "cross_chop",
					"sfx": "punch",
					"scale": 0.36
				},
				{
					"name": "恶意追击",
					"desc": "如果此回合内对手已经受到伤害的话，招式威力会变成２倍。",
					"detail": "消耗100能量，爆发【恶意追击】！如果此回合内对手已经受到伤害的话，招式威力会变成２倍。 对范围内最多2名敌人造成300点伤害，并施加战术压制。",
					"power": 300,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "乱抓",
					"desc": "用爪子或镰刀等抓对手进行攻击。连续攻击２～５次。",
					"detail": "消耗100能量，爆发【乱抓】！用爪子或镰刀等抓对手进行攻击。连续攻击２～５次。 对范围内最多2名敌人造成174点伤害，并施加战术压制。",
					"power": 174,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "headbutt",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "近身战",
					"desc": "放弃守护，向对手的怀里突击。自己的防御和特防会降低。",
					"detail": "消耗100能量，释放终极奥义【近身战】！放弃守护，向对手的怀里突击。自己的防御和特防会降低。 席卷战场对最多6名敌人造成700点巨额伤害与强力击破！",
					"power": 700,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "close_combat",
					"sfx": "punch",
					"scale": 0.48
				},
				{
					"name": "地球上投",
					"desc": "利用引力将对手甩飞出去。给予对手和自己等级相同的伤害。",
					"detail": "消耗100能量，释放终极奥义【地球上投】！利用引力将对手甩飞出去。给予对手和自己等级相同的伤害。 席卷战场对最多4名敌人造成680点巨额伤害与强力击破！",
					"power": 680,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "mega_punch",
					"sfx": "punch",
					"scale": 1.55
				},
				{
					"name": "逆鳞",
					"desc": "在２～３回合内，乱打一气地进行攻击。大闹一番后自己会陷入混乱。",
					"detail": "消耗100能量，释放终极奥义【逆鳞】！在２～３回合内，乱打一气地进行攻击。大闹一番后自己会陷入混乱。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "dragon_apocalypse",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/primeape.png"
	},
	"arcanine": {
		"id": "arcanine",
		"name": "风速狗",
		"title": "传说宝可梦",
		"cost": 4,
		"types": ["Fire"],
		"hp": 1050,
		"atk": 92,
		"armor": 48,
		"mr": 48,
		"range": 1,
		"atk_speed": 0.8,
		"max_mana": 90,
		"desc": "自古以来就被誉为传说中的神兽，能以如乘风般不可思议的速度奔跑，体内燃烧着永不熄灭的正义烈火！",
		"skill_name": "喷射火焰",
		"skill_desc": "向对手发射烈焰进行攻击。有时会让对手陷入灼伤状态。",
		"skill_detail": "消耗100能量，使出【喷射火焰】。向对手发射烈焰进行攻击。有时会让对手陷入灼伤状态。 对目标造成222点伤害。",
		"skill_power": 222,
		"basic_attack": {
			"type": "physical",
			"name": "咬住",
			"style": "bite",
			"sfx": "bite"
		},
						"skills": {
			1: [
				{
					"name": "喷射火焰",
					"desc": "向对手发射烈焰进行攻击。有时会让对手陷入灼伤状态。",
					"detail": "消耗100能量，使出【喷射火焰】。向对手发射烈焰进行攻击。有时会让对手陷入灼伤状态。 对目标造成222点伤害。",
					"power": 222,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "flamethrower",
					"sfx": "fire",
					"scale": 0.28
				},
				{
					"name": "咬住",
					"desc": "用尖锐的牙咬住对手进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，使出【咬住】。用尖锐的牙咬住对手进行攻击。有时会使对手畏缩。 对目标造成220点伤害。",
					"power": 220,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "bite",
					"sfx": "bite",
					"scale": 0.82
				},
				{
					"name": "燃尽",
					"desc": "将自己全身燃烧起火焰来，给予对手大大的伤害。自己的火属性将会消失。",
					"detail": "消耗100能量，使出【燃尽】。将自己全身燃烧起火焰来，给予对手大大的伤害。自己的火属性将会消失。 对目标造成360点伤害。",
					"power": 360,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "ember",
					"sfx": "fire",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "神速",
					"desc": "以迅雷不及掩耳之势猛撞向对手进行攻击。必定能够先制攻击。",
					"detail": "消耗100能量，爆发【神速】。以迅雷不及掩耳之势猛撞向对手进行攻击。必定能够先制攻击。 对范围内最多3名敌人造成340点伤害，并施加战术压制。",
					"power": 340,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "quick_attack",
					"sfx": "swift",
					"scale": 0.36
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，爆发【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 对范围内最多2名敌人造成390点伤害，并施加战术压制。",
					"power": 390,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "热风",
					"desc": "将炎热的气息吹向对手进行攻击。有时会让对手陷入灼伤状态。",
					"detail": "消耗100能量，爆发【热风】！将炎热的气息吹向对手进行攻击。有时会让对手陷入灼伤状态。 对范围内最多3名敌人造成405点伤害，并施加战术压制。",
					"power": 405,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "heat_wave",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "大字爆炎",
					"desc": "用大字形状的火焰烧尽对手。有时会让对手陷入灼伤状态。",
					"detail": "消耗100能量，释放终极奥义【大字爆炎】！用大字形状的火焰烧尽对手。有时会让对手陷入灼伤状态。 席卷战场对最多6名敌人造成685点巨额伤害与强力击破！",
					"power": 685,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "fire_blast",
					"sfx": "fire",
					"scale": 0.48
				},
				{
					"name": "炼狱",
					"desc": "用烈焰包裹住对手进行攻击。让对手陷入灼伤状态。",
					"detail": "消耗100能量，释放终极奥义【炼狱】！用烈焰包裹住对手进行攻击。让对手陷入灼伤状态。 席卷战场对最多6名敌人造成680点巨额伤害与强力击破！",
					"power": 680,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "inferno",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "爆炸烈焰",
					"desc": "用爆炸的火焰烧尽对手进行攻击。下一回合自己将无法动弹。",
					"detail": "消耗100能量，释放终极奥义【爆炸烈焰】！用爆炸的火焰烧尽对手进行攻击。下一回合自己将无法动弹。 席卷战场对最多6名敌人造成930点巨额伤害与强力击破！",
					"power": 930,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "blast_burn",
					"sfx": "fire",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/arcanine.png"
	},
	"poliwag": {
		"id": "poliwag",
		"name": "蚊香蝌蚪",
		"title": "蝌蚪宝可梦",
		"cost": 1,
		"types": ["Water"],
		"hp": 540,
		"atk": 46,
		"armor": 25,
		"mr": 25,
		"range": 2,
		"atk_speed": 0.72,
		"max_mana": 80,
		"desc": "腹部拥有清晰可见的同心圆旋涡花纹，皮肤湿润光滑，尾鳍极其柔软，在急流中能像螺旋桨一样飞速前进。",
		"skill_name": "水枪",
		"skill_desc": "向对手猛烈地喷射水流进行攻击。",
		"skill_detail": "消耗100能量，使出【水枪】。向对手猛烈地喷射水流进行攻击。 对目标造成182点伤害。",
		"skill_power": 182,
		"basic_attack": {
			"type": "special",
			"name": "水滴弹",
			"style": "water_bullet",
			"sfx": "water"
		},
						"skills": {
			1: [
				{
					"name": "水枪",
					"desc": "向对手猛烈地喷射水流进行攻击。",
					"detail": "消耗100能量，使出【水枪】。向对手猛烈地喷射水流进行攻击。 对目标造成182点伤害。",
					"power": 182,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "water_gun",
					"sfx": "water",
					"scale": 0.28
				},
				{
					"name": "催眠术",
					"desc": "施以诱导睡意的暗示，让对手陷入睡眠状态。",
					"detail": "消耗100能量，使出【催眠术】。施以诱导睡意的暗示，让对手陷入睡眠状态。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "hypnosis",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "泰山压顶",
					"desc": "用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，使出【泰山压顶】。用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。 对目标造成270点伤害。",
					"power": 270,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "泡沫光线",
					"desc": "向对手猛烈地喷射泡沫进行攻击。有时会降低对手的速度。",
					"detail": "消耗100能量，爆发【泡沫光线】。向对手猛烈地喷射泡沫进行攻击。有时会降低对手的速度。 对范围内最多3名敌人造成325点伤害，并施加战术压制。",
					"power": 325,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "bubble_beam",
					"sfx": "water",
					"scale": 0.36
				},
				{
					"name": "瞬间失忆",
					"desc": "将头脑清空，瞬间忘记某事，从而大幅提高自己的特防。",
					"detail": "消耗100能量，爆发【瞬间失忆】！将头脑清空，瞬间忘记某事，从而大幅提高自己的特防。 对范围内最多3名敌人造成320点伤害，并施加战术压制。",
					"power": 320,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "rest",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "大地之力",
					"desc": "向对手脚下释放出大地之力。有时会降低对手的特防。",
					"detail": "消耗100能量，爆发【大地之力】！向对手脚下释放出大地之力。有时会降低对手的特防。 对范围内最多3名敌人造成390点伤害，并施加战术压制。",
					"power": 390,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "earthquake",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "水炮",
					"desc": "向对手猛烈地喷射大量水流进行攻击。",
					"detail": "消耗100能量，释放终极奥义【水炮】！向对手猛烈地喷射大量水流进行攻击。 席卷战场对最多6名敌人造成685点巨额伤害与强力击破！",
					"power": 685,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "hydro_pump",
					"sfx": "water",
					"scale": 0.48
				},
				{
					"name": "唤醒巴掌",
					"desc": "给予睡眠状态下的对手较大的伤害。但相反对手会从睡眠中醒过来。",
					"detail": "消耗100能量，释放终极奥义【唤醒巴掌】！给予睡眠状态下的对手较大的伤害。但相反对手会从睡眠中醒过来。 席卷战场对最多4名敌人造成530点巨额伤害与强力击破！",
					"power": 530,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "low_kick",
					"sfx": "punch",
					"scale": 1.55
				},
				{
					"name": "舍身冲撞",
					"desc": "拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。",
					"detail": "消耗100能量，释放终极奥义【舍身冲撞】！拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "double_edge",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/poliwag.png"
	},
	"poliwhirl": {
		"id": "poliwhirl",
		"name": "蚊香君",
		"title": "蝌蚪宝可梦",
		"cost": 2,
		"types": ["Water"],
		"hp": 740,
		"atk": 65,
		"armor": 35,
		"mr": 30,
		"range": 1,
		"atk_speed": 0.7,
		"max_mana": 85,
		"desc": "两只脚健步如飞，在陆地上也能敏捷行动。身体表面总是被一层滑溜溜的液体所包裹，不易被抓到。",
		"skill_name": "泡沫光线",
		"skill_desc": "向对手猛烈地喷射泡沫进行攻击。有时会降低对手的速度。",
		"skill_detail": "消耗100能量，使出【泡沫光线】。向对手猛烈地喷射泡沫进行攻击。有时会降低对手的速度。 对目标造成202点伤害。",
		"skill_power": 202,
		"basic_attack": {
			"type": "physical",
			"name": "撞击",
			"style": "tackle",
			"sfx": "attack"
		},
						"skills": {
			1: [
				{
					"name": "泡沫光线",
					"desc": "向对手猛烈地喷射泡沫进行攻击。有时会降低对手的速度。",
					"detail": "消耗100能量，使出【泡沫光线】。向对手猛烈地喷射泡沫进行攻击。有时会降低对手的速度。 对目标造成202点伤害。",
					"power": 202,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "bubble_beam",
					"sfx": "water",
					"scale": 0.28
				},
				{
					"name": "水枪",
					"desc": "向对手猛烈地喷射水流进行攻击。",
					"detail": "消耗100能量，使出【水枪】。向对手猛烈地喷射水流进行攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "water_gun",
					"sfx": "water",
					"scale": 0.82
				},
				{
					"name": "催眠术",
					"desc": "施以诱导睡意的暗示，让对手陷入睡眠状态。",
					"detail": "消耗100能量，使出【催眠术】。施以诱导睡意的暗示，让对手陷入睡眠状态。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "hypnosis",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "泰山压顶",
					"desc": "用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，爆发【泰山压顶】。用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。 对范围内最多3名敌人造成345点伤害，并施加战术压制。",
					"power": 345,
					"target_count": 3,
					"stun_duration": 0.8,
					"vfx": "body_slam",
					"sfx": "attack",
					"scale": 0.36
				},
				{
					"name": "瞬间失忆",
					"desc": "将头脑清空，瞬间忘记某事，从而大幅提高自己的特防。",
					"detail": "消耗100能量，爆发【瞬间失忆】！将头脑清空，瞬间忘记某事，从而大幅提高自己的特防。 对范围内最多3名敌人造成320点伤害，并施加战术压制。",
					"power": 320,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "rest",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "大地之力",
					"desc": "向对手脚下释放出大地之力。有时会降低对手的特防。",
					"detail": "消耗100能量，爆发【大地之力】！向对手脚下释放出大地之力。有时会降低对手的特防。 对范围内最多3名敌人造成390点伤害，并施加战术压制。",
					"power": 390,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "earthquake",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "水炮",
					"desc": "向对手猛烈地喷射大量水流进行攻击。",
					"detail": "消耗100能量，释放终极奥义【水炮】！向对手猛烈地喷射大量水流进行攻击。 席卷战场对最多6名敌人造成685点巨额伤害与强力击破！",
					"power": 685,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "hydro_pump",
					"sfx": "water",
					"scale": 0.48
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，释放终极奥义【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 席卷战场对最多4名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "舍身冲撞",
					"desc": "拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。",
					"detail": "消耗100能量，释放终极奥义【舍身冲撞】！拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "double_edge",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/poliwhirl.png"
	},
	"poliwrath": {
		"id": "poliwrath",
		"name": "蚊香泳士",
		"title": "蝌蚪宝可梦",
		"cost": 4,
		"types": ["Water", "Fighting"],
		"hp": 1150,
		"atk": 95,
		"armor": 52,
		"mr": 48,
		"range": 1,
		"atk_speed": 0.75,
		"max_mana": 90,
		"desc": "拥有无比强健的肌肉，即使在狂风巨浪的大海中也能逆流畅游，双拳重击甚至能击碎坚固的花岗岩！",
		"skill_name": "爆裂拳",
		"skill_desc": "使出浑身力气出拳进行攻击。必定会使对手混乱。",
		"skill_detail": "消耗100能量，使出【爆裂拳】。使出浑身力气出拳进行攻击。必定会使对手混乱。 对目标造成230点伤害。",
		"skill_power": 230,
		"basic_attack": {
			"type": "physical",
			"name": "撞击",
			"style": "tackle",
			"sfx": "attack"
		},
						"skills": {
			1: [
				{
					"name": "爆裂拳",
					"desc": "使出浑身力气出拳进行攻击。必定会使对手混乱。",
					"detail": "消耗100能量，使出【爆裂拳】。使出浑身力气出拳进行攻击。必定会使对手混乱。 对目标造成230点伤害。",
					"power": 230,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "dynamic_punch",
					"sfx": "punch",
					"scale": 0.28
				},
				{
					"name": "地狱翻滚",
					"desc": "将对手连同自己一起摔向地面进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，使出【地狱翻滚】。将对手连同自己一起摔向地面进行攻击。自己也会受到少许伤害。 对目标造成260点伤害。",
					"power": 260,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "low_kick",
					"sfx": "punch",
					"scale": 0.82
				},
				{
					"name": "大地之力",
					"desc": "向对手脚下释放出大地之力。有时会降低对手的特防。",
					"detail": "消耗100能量，使出【大地之力】。向对手脚下释放出大地之力。有时会降低对手的特防。 对目标造成280点伤害。",
					"power": 280,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "earthquake",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "攀瀑",
					"desc": "以惊人的气势扑向对手。有时会使对手畏缩。",
					"detail": "消耗100能量，爆发【攀瀑】。以惊人的气势扑向对手。有时会使对手畏缩。 对范围内最多3名敌人造成340点伤害，并施加战术压制。",
					"power": 340,
					"target_count": 3,
					"stun_duration": 0.8,
					"vfx": "aqua_tail",
					"sfx": "water",
					"scale": 0.36
				},
				{
					"name": "水炮",
					"desc": "向对手猛烈地喷射大量水流进行攻击。",
					"detail": "消耗100能量，爆发【水炮】！向对手猛烈地喷射大量水流进行攻击。 对范围内最多3名敌人造成450点伤害，并施加战术压制。",
					"power": 450,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "hydro_pump",
					"sfx": "water",
					"scale": 1.10
				},
				{
					"name": "蟹钳锤",
					"desc": "用大钳子敲打对手进行攻击。容易击中要害。",
					"detail": "消耗100能量，爆发【蟹钳锤】！用大钳子敲打对手进行攻击。容易击中要害。 对范围内最多2名敌人造成420点伤害，并施加战术压制。",
					"power": 420,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "crabhammer",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "加农水炮",
					"desc": "向对手喷射水炮进行攻击。下一回合自己将无法动弹。",
					"detail": "消耗100能量，释放终极奥义【加农水炮】！向对手喷射水炮进行攻击。下一回合自己将无法动弹。 席卷战场对最多6名敌人造成745点巨额伤害与强力击破！",
					"power": 745,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "hydro_cannon",
					"sfx": "water",
					"scale": 0.48
				},
				{
					"name": "蛮力",
					"desc": "发挥惊人的力量攻击对手。自己的攻击和防御会降低。",
					"detail": "消耗100能量，释放终极奥义【蛮力】！发挥惊人的力量攻击对手。自己的攻击和防御会降低。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "mega_punch",
					"sfx": "punch",
					"scale": 1.55
				},
				{
					"name": "根源波动",
					"desc": "用无数青白色且闪耀的光线攻击对手。",
					"detail": "消耗100能量，释放终极奥义【根源波动】！用无数青白色且闪耀的光线攻击对手。 席卷战场对最多6名敌人造成730点巨额伤害与强力击破！",
					"power": 730,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "water_gun",
					"sfx": "water",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/poliwrath.png"
	},
	"abra": {
		"id": "abra",
		"name": "凯西",
		"title": "念力宝可梦",
		"cost": 1,
		"types": ["Psychic"],
		"hp": 480,
		"atk": 42,
		"armor": 18,
		"mr": 35,
		"range": 3,
		"atk_speed": 0.65,
		"max_mana": 70,
		"desc": "每天必须睡上18个小时。在睡梦中也能感知周围的危险，一旦感觉到危险就会通过瞬间移动逃离。",
		"skill_name": "念力",
		"skill_desc": "向对手发送微弱的念力进行攻击。有时会使对手混乱。",
		"skill_detail": "消耗100能量，使出【念力】。向对手发送微弱的念力进行攻击。有时会使对手混乱。 对目标造成190点伤害。",
		"skill_power": 190,
		"basic_attack": {
			"type": "special",
			"name": "念力波",
			"style": "psywave",
			"sfx": "swift"
		},
						"skills": {
			1: [
				{
					"name": "念力",
					"desc": "向对手发送微弱的念力进行攻击。有时会使对手混乱。",
					"detail": "消耗100能量，使出【念力】。向对手发送微弱的念力进行攻击。有时会使对手混乱。 对目标造成190点伤害。",
					"power": 190,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "confusion",
					"sfx": "skill",
					"scale": 0.28
				},
				{
					"name": "瞬间移动",
					"desc": "当有后备宝可梦在时，如果使用就可以进行替换。野生的宝可梦会逃走。",
					"detail": "消耗100能量，使出【瞬间移动】。当有后备宝可梦在时，如果使用就可以进行替换。野生的宝可梦会逃走。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "hypnosis",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "百万吨重拳",
					"desc": "用充满力量的拳头攻击对手。",
					"detail": "消耗100能量，使出【百万吨重拳】。用充满力量的拳头攻击对手。 对目标造成260点伤害。",
					"power": 260,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "mega_punch",
					"sfx": "punch",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "幻象光线",
					"desc": "向对手发射神奇的光线进行攻击。有时会使对手混乱。",
					"detail": "消耗100能量，爆发【幻象光线】。向对手发射神奇的光线进行攻击。有时会使对手混乱。 对范围内最多3名敌人造成325点伤害，并施加战术压制。",
					"power": 325,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "psybeam",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "百万吨重踢",
					"desc": "使出力大无穷的重踢踢飞对手进行攻击。",
					"detail": "消耗100能量，爆发【百万吨重踢】！使出力大无穷的重踢踢飞对手进行攻击。 对范围内最多2名敌人造成480点伤害，并施加战术压制。",
					"power": 480,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "mega_kick",
					"sfx": "punch",
					"scale": 1.10
				},
				{
					"name": "意念头锤",
					"desc": "将思念的力量集中在前额进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，爆发【意念头锤】！将思念的力量集中在前额进行攻击。有时会使对手畏缩。 对范围内最多2名敌人造成360点伤害，并施加战术压制。",
					"power": 360,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "zen_headbutt",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "精神强念",
					"desc": "向对手发送强大的念力进行攻击。有时会降低对手的特防。",
					"detail": "消耗100能量，释放终极奥义【精神强念】！向对手发送强大的念力进行攻击。有时会降低对手的特防。 席卷战场对最多6名敌人造成655点巨额伤害与强力击破！",
					"power": 655,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "psychic",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "精神击破",
					"desc": "将神奇的念波实体化攻击对手。给予物理伤害。",
					"detail": "消耗100能量，释放终极奥义【精神击破】！将神奇的念波实体化攻击对手。给予物理伤害。 席卷战场对最多6名敌人造成680点巨额伤害与强力击破！",
					"power": 680,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "psystrike",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "预知未来",
					"desc": "在使用招式２回合后，向对手发送一团念力进行攻击。",
					"detail": "消耗100能量，释放终极奥义【预知未来】！在使用招式２回合后，向对手发送一团念力进行攻击。 席卷战场对最多6名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "future_sight",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/abra.png"
	},
	"kadabra": {
		"id": "kadabra",
		"name": "勇基拉",
		"title": "念力宝可梦",
		"cost": 2,
		"types": ["Psychic"],
		"hp": 650,
		"atk": 58,
		"armor": 25,
		"mr": 45,
		"range": 3,
		"atk_speed": 0.7,
		"max_mana": 80,
		"desc": "手中握着银勺以集中和放大精神力量。身体会向四周释放强烈的特殊阿尔法波，导致身旁的精密仪器彻底失灵。",
		"skill_name": "幻象光线",
		"skill_desc": "向对手发射神奇的光线进行攻击。有时会使对手混乱。",
		"skill_detail": "消耗100能量，使出【幻象光线】。向对手发射神奇的光线进行攻击。有时会使对手混乱。 对目标造成202点伤害。",
		"skill_power": 202,
		"basic_attack": {
			"type": "special",
			"name": "念力波",
			"style": "psywave",
			"sfx": "swift"
		},
						"skills": {
			1: [
				{
					"name": "幻象光线",
					"desc": "向对手发射神奇的光线进行攻击。有时会使对手混乱。",
					"detail": "消耗100能量，使出【幻象光线】。向对手发射神奇的光线进行攻击。有时会使对手混乱。 对目标造成202点伤害。",
					"power": 202,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "psybeam",
					"sfx": "skill",
					"scale": 0.28
				},
				{
					"name": "念力",
					"desc": "向对手发送微弱的念力进行攻击。有时会使对手混乱。",
					"detail": "消耗100能量，使出【念力】。向对手发送微弱的念力进行攻击。有时会使对手混乱。 对目标造成200点伤害。",
					"power": 200,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "confusion",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "黑夜魔影",
					"desc": "显示恐怖幻影，只给予对手和自己等级相同的伤害。",
					"detail": "消耗100能量，使出【黑夜魔影】。显示恐怖幻影，只给予对手和自己等级相同的伤害。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "night_shade",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "精神利刃",
					"desc": "用实体化的心之利刃劈开对手。容易击中要害。",
					"detail": "消耗100能量，爆发【精神利刃】。用实体化的心之利刃劈开对手。容易击中要害。 对范围内最多3名敌人造成330点伤害，并施加战术压制。",
					"power": 330,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "psycho_cut",
					"sfx": "slash",
					"scale": 0.36
				},
				{
					"name": "百万吨重拳",
					"desc": "用充满力量的拳头攻击对手。",
					"detail": "消耗100能量，爆发【百万吨重拳】！用充满力量的拳头攻击对手。 对范围内最多2名敌人造成360点伤害，并施加战术压制。",
					"power": 360,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "mega_punch",
					"sfx": "punch",
					"scale": 1.10
				},
				{
					"name": "百万吨重踢",
					"desc": "使出力大无穷的重踢踢飞对手进行攻击。",
					"detail": "消耗100能量，爆发【百万吨重踢】！使出力大无穷的重踢踢飞对手进行攻击。 对范围内最多2名敌人造成480点伤害，并施加战术压制。",
					"power": 480,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "mega_kick",
					"sfx": "punch",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "精神强念",
					"desc": "向对手发送强大的念力进行攻击。有时会降低对手的特防。",
					"detail": "消耗100能量，释放终极奥义【精神强念】！向对手发送强大的念力进行攻击。有时会降低对手的特防。 席卷战场对最多6名敌人造成655点巨额伤害与强力击破！",
					"power": 655,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "psychic",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "精神击破",
					"desc": "将神奇的念波实体化攻击对手。给予物理伤害。",
					"detail": "消耗100能量，释放终极奥义【精神击破】！将神奇的念波实体化攻击对手。给予物理伤害。 席卷战场对最多6名敌人造成680点巨额伤害与强力击破！",
					"power": 680,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "psystrike",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "预知未来",
					"desc": "在使用招式２回合后，向对手发送一团念力进行攻击。",
					"detail": "消耗100能量，释放终极奥义【预知未来】！在使用招式２回合后，向对手发送一团念力进行攻击。 席卷战场对最多6名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "future_sight",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/kadabra.png"
	},
	"machoke": {
		"id": "machoke",
		"name": "豪力",
		"title": "怪力宝可梦",
		"cost": 2,
		"types": ["Fighting"],
		"hp": 850,
		"atk": 74,
		"armor": 38,
		"mr": 25,
		"range": 1,
		"atk_speed": 0.7,
		"max_mana": 85,
		"desc": "腰间佩戴着金色的力量限制腰带，以此来抑制自身过于膨胀的毁灭怪力，即使背着沉重大卡车也能健步如飞。",
		"skill_name": "空手劈",
		"skill_desc": "用锋利的手刀劈向对手进行攻击。容易击中要害。",
		"skill_detail": "消耗100能量，使出【空手劈】。用锋利的手刀劈向对手进行攻击。容易击中要害。 对目标造成190点伤害。",
		"skill_power": 190,
		"basic_attack": {
			"type": "physical",
			"name": "连续拳",
			"style": "punch",
			"sfx": "punch"
		},
						"skills": {
			1: [
				{
					"name": "空手劈",
					"desc": "用锋利的手刀劈向对手进行攻击。容易击中要害。",
					"detail": "消耗100能量，使出【空手劈】。用锋利的手刀劈向对手进行攻击。容易击中要害。 对目标造成190点伤害。",
					"power": 190,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "cross_chop",
					"sfx": "punch",
					"scale": 0.28
				},
				{
					"name": "踢倒",
					"desc": "用力踢对手的脚，使其摔倒进行攻击。对手越重，威力越大。",
					"detail": "消耗100能量，使出【踢倒】。用力踢对手的脚，使其摔倒进行攻击。对手越重，威力越大。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "low_kick",
					"sfx": "punch",
					"scale": 0.82
				},
				{
					"name": "音速拳",
					"desc": "以迅雷不及掩耳之势出拳。必定能够先制攻击。",
					"detail": "消耗100能量，使出【音速拳】。以迅雷不及掩耳之势出拳。必定能够先制攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "mach_punch",
					"sfx": "punch",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "借力摔",
					"desc": "会在对手之后进行攻击。但是自己的攻击必定会命中。",
					"detail": "消耗100能量，爆发【借力摔】。会在对手之后进行攻击。但是自己的攻击必定会命中。 对范围内最多3名敌人造成330点伤害，并施加战术压制。",
					"power": 330,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "mega_punch",
					"sfx": "punch",
					"scale": 0.36
				},
				{
					"name": "二连击",
					"desc": "使用尾巴等拍打对手进行攻击。连续２次给予伤害。",
					"detail": "消耗100能量，爆发【二连击】！使用尾巴等拍打对手进行攻击。连续２次给予伤害。 对范围内最多2名敌人造成225点伤害，并施加战术压制。",
					"power": 225,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "地狱翻滚",
					"desc": "将对手连同自己一起摔向地面进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，爆发【地狱翻滚】！将对手连同自己一起摔向地面进行攻击。自己也会受到少许伤害。 对范围内最多2名敌人造成360点伤害，并施加战术压制。",
					"power": 360,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "mega_kick",
					"sfx": "punch",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "近身战",
					"desc": "放弃守护，向对手的怀里突击。自己的防御和特防会降低。",
					"detail": "消耗100能量，释放终极奥义【近身战】！放弃守护，向对手的怀里突击。自己的防御和特防会降低。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "close_combat",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "二连劈",
					"desc": "用身体坚硬的部分拍打对手进行攻击。连续２次给予伤害。",
					"detail": "消耗100能量，释放终极奥义【二连劈】！用身体坚硬的部分拍打对手进行攻击。连续２次给予伤害。 席卷战场对最多4名敌人造成380点巨额伤害与强力击破！",
					"power": 380,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "dragon_claw",
					"sfx": "slash",
					"scale": 1.55
				},
				{
					"name": "爆裂拳",
					"desc": "使出浑身力气出拳进行攻击。必定会使对手混乱。",
					"detail": "消耗100能量，释放终极奥义【爆裂拳】！使出浑身力气出拳进行攻击。必定会使对手混乱。 席卷战场对最多4名敌人造成680点巨额伤害与强力击破！",
					"power": 680,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "dynamic_punch",
					"sfx": "punch",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/machoke.png"
	},
	"machamp": {
		"id": "machamp",
		"name": "怪力",
		"title": "怪力宝可梦",
		"cost": 4,
		"types": ["Fighting"],
		"hp": 1200,
		"atk": 105,
		"armor": 55,
		"mr": 40,
		"range": 1,
		"atk_speed": 0.8,
		"max_mana": 85,
		"desc": "拥有四只极其强壮的手臂，能在两秒内轰出整整一千记重拳！四手同时攻击能彻底压制并击溃任何防御！",
		"skill_name": "十字劈",
		"skill_desc": "用两手呈十字劈打对手进行攻击。容易击中要害。",
		"skill_detail": "消耗100能量，使出【十字劈】。用两手呈十字劈打对手进行攻击。容易击中要害。 对目标造成230点伤害。",
		"skill_power": 230,
		"basic_attack": {
			"type": "physical",
			"name": "连续拳",
			"style": "punch",
			"sfx": "punch"
		},
						"skills": {
			1: [
				{
					"name": "十字劈",
					"desc": "用两手呈十字劈打对手进行攻击。容易击中要害。",
					"detail": "消耗100能量，使出【十字劈】。用两手呈十字劈打对手进行攻击。容易击中要害。 对目标造成230点伤害。",
					"power": 230,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "cross_chop",
					"sfx": "punch",
					"scale": 0.28
				},
				{
					"name": "怪力",
					"desc": "使出浑身力气殴打对手进行攻击。",
					"detail": "消耗100能量，使出【怪力】。使出浑身力气殴打对手进行攻击。 对目标造成260点伤害。",
					"power": 260,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "音速拳",
					"desc": "以迅雷不及掩耳之势出拳。必定能够先制攻击。",
					"detail": "消耗100能量，使出【音速拳】。以迅雷不及掩耳之势出拳。必定能够先制攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "mach_punch",
					"sfx": "punch",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "爆裂拳",
					"desc": "使出浑身力气出拳进行攻击。必定会使对手混乱。",
					"detail": "消耗100能量，爆发【爆裂拳】。使出浑身力气出拳进行攻击。必定会使对手混乱。 对范围内最多3名敌人造成360点伤害，并施加战术压制。",
					"power": 360,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "dynamic_punch",
					"sfx": "punch",
					"scale": 0.36
				},
				{
					"name": "踢倒",
					"desc": "用力踢对手的脚，使其摔倒进行攻击。对手越重，威力越大。",
					"detail": "消耗100能量，爆发【踢倒】！用力踢对手的脚，使其摔倒进行攻击。对手越重，威力越大。 对范围内最多2名敌人造成320点伤害，并施加战术压制。",
					"power": 320,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "low_kick",
					"sfx": "punch",
					"scale": 1.10
				},
				{
					"name": "地球上投",
					"desc": "利用引力将对手甩飞出去。给予对手和自己等级相同的伤害。",
					"detail": "消耗100能量，爆发【地球上投】！利用引力将对手甩飞出去。给予对手和自己等级相同的伤害。 对范围内最多2名敌人造成320点伤害，并施加战术压制。",
					"power": 320,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "mega_punch",
					"sfx": "punch",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "近身战",
					"desc": "放弃守护，向对手的怀里突击。自己的防御和特防会降低。",
					"detail": "消耗100能量，释放终极奥义【近身战】！放弃守护，向对手的怀里突击。自己的防御和特防会降低。 席卷战场对最多6名敌人造成700点巨额伤害与强力击破！",
					"power": 700,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "close_combat",
					"sfx": "punch",
					"scale": 0.48
				},
				{
					"name": "二连劈",
					"desc": "用身体坚硬的部分拍打对手进行攻击。连续２次给予伤害。",
					"detail": "消耗100能量，释放终极奥义【二连劈】！用身体坚硬的部分拍打对手进行攻击。连续２次给予伤害。 席卷战场对最多4名敌人造成380点巨额伤害与强力击破！",
					"power": 380,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "dragon_claw",
					"sfx": "slash",
					"scale": 1.55
				},
				{
					"name": "地狱翻滚",
					"desc": "将对手连同自己一起摔向地面进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，释放终极奥义【地狱翻滚】！将对手连同自己一起摔向地面进行攻击。自己也会受到少许伤害。 席卷战场对最多4名敌人造成580点巨额伤害与强力击破！",
					"power": 580,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "mega_kick",
					"sfx": "punch",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/machamp.png"
	},
	"bellsprout": {
		"id": "bellsprout",
		"name": "喇叭芽",
		"title": "捕蝇宝可梦",
		"cost": 1,
		"types": ["Grass", "Poison"],
		"hp": 520,
		"atk": 50,
		"armor": 20,
		"mr": 25,
		"range": 2,
		"atk_speed": 0.68,
		"max_mana": 75,
		"desc": "喜欢潮湿温热的地方，身体细长柔软，即使受到猛烈的攻击也能像水草一样摇曳化解，擅长从口中喷吐强腐蚀胃液。",
		"skill_name": "藤鞭",
		"skill_desc": "用如同鞭子般弯曲而细长的藤蔓摔打对手进行攻击。",
		"skill_detail": "消耗100能量，使出【藤鞭】。用如同鞭子般弯曲而细长的藤蔓摔打对手进行攻击。 对目标造成186点伤害。",
		"skill_power": 186,
		"basic_attack": {
			"type": "special",
			"name": "飞叶",
			"style": "leaf",
			"sfx": "swift"
		},
						"skills": {
			1: [
				{
					"name": "藤鞭",
					"desc": "用如同鞭子般弯曲而细长的藤蔓摔打对手进行攻击。",
					"detail": "消耗100能量，使出【藤鞭】。用如同鞭子般弯曲而细长的藤蔓摔打对手进行攻击。 对目标造成186点伤害。",
					"power": 186,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "vine_whip",
					"sfx": "slash",
					"scale": 0.28
				},
				{
					"name": "紧束",
					"desc": "使用长长的身体或藤蔓等，在４～５回合内紧束对手进行攻击。",
					"detail": "消耗100能量，使出【紧束】。使用长长的身体或藤蔓等，在４～５回合内紧束对手进行攻击。 对目标造成130点伤害。",
					"power": 130,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "居合斩",
					"desc": "用镰刀或爪子等切斩对手进行攻击。",
					"detail": "消耗100能量，使出【居合斩】。用镰刀或爪子等切斩对手进行攻击。 对目标造成200点伤害。",
					"power": 200,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "slash",
					"sfx": "slash",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "溶解液",
					"desc": "将强酸泼向对手进行攻击。有时会降低对手的特防。",
					"detail": "消耗100能量，爆发【溶解液】。将强酸泼向对手进行攻击。有时会降低对手的特防。 对范围内最多3名敌人造成300点伤害，并施加战术压制。",
					"power": 300,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "sludge_bomb",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，爆发【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 对范围内最多2名敌人造成390点伤害，并施加战术压制。",
					"power": 390,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "舍身冲撞",
					"desc": "拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。",
					"detail": "消耗100能量，爆发【舍身冲撞】！拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。 对范围内最多2名敌人造成480点伤害，并施加战术压制。",
					"power": 480,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "double_edge",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "飞叶快刀",
					"desc": "飞出叶片，切斩对手进行攻击。容易击中要害。",
					"detail": "消耗100能量，释放终极奥义【飞叶快刀】！飞出叶片，切斩对手进行攻击。容易击中要害。 席卷战场对最多6名敌人造成602点巨额伤害与强力击破！",
					"power": 602,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "razor_leaf",
					"sfx": "slash",
					"scale": 0.48
				},
				{
					"name": "日光束",
					"desc": "第１回合收集满满的日光，第２回合发射光束进行攻击。",
					"detail": "消耗100能量，释放终极奥义【日光束】！第１回合收集满满的日光，第２回合发射光束进行攻击。 席卷战场对最多6名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "solar_beam",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "强力鞭打",
					"desc": "激烈地挥舞青藤或触手摔打对手进行攻击。",
					"detail": "消耗100能量，释放终极奥义【强力鞭打】！激烈地挥舞青藤或触手摔打对手进行攻击。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "power_whip",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/bellsprout.png"
	},
	"weepinbell": {
		"id": "weepinbell",
		"name": "口呆花",
		"title": "捕蝇宝可梦",
		"cost": 2,
		"types": ["Grass", "Poison"],
		"hp": 680,
		"atk": 66,
		"armor": 28,
		"mr": 30,
		"range": 2,
		"atk_speed": 0.7,
		"max_mana": 80,
		"desc": "肚子饿的时候会大口吞食眼前的一切活物，体内强酸无论什么都能融化，甚至连坚硬的钢铁都能溶成一滩液体。",
		"skill_name": "藤鞭",
		"skill_desc": "用如同鞭子般弯曲而细长的藤蔓摔打对手进行攻击。",
		"skill_detail": "消耗100能量，使出【藤鞭】。用如同鞭子般弯曲而细长的藤蔓摔打对手进行攻击。 对目标造成186点伤害。",
		"skill_power": 186,
		"basic_attack": {
			"type": "special",
			"name": "飞叶",
			"style": "leaf",
			"sfx": "swift"
		},
						"skills": {
			1: [
				{
					"name": "藤鞭",
					"desc": "用如同鞭子般弯曲而细长的藤蔓摔打对手进行攻击。",
					"detail": "消耗100能量，使出【藤鞭】。用如同鞭子般弯曲而细长的藤蔓摔打对手进行攻击。 对目标造成186点伤害。",
					"power": 186,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "vine_whip",
					"sfx": "slash",
					"scale": 0.28
				},
				{
					"name": "紧束",
					"desc": "使用长长的身体或藤蔓等，在４～５回合内紧束对手进行攻击。",
					"detail": "消耗100能量，使出【紧束】。使用长长的身体或藤蔓等，在４～５回合内紧束对手进行攻击。 对目标造成130点伤害。",
					"power": 130,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "飞叶快刀",
					"desc": "飞出叶片，切斩对手进行攻击。容易击中要害。",
					"detail": "消耗100能量，使出【飞叶快刀】。飞出叶片，切斩对手进行攻击。容易击中要害。 对目标造成210点伤害。",
					"power": 210,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "razor_leaf",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "污泥炸弹",
					"desc": "用污泥投掷对手进行攻击。有时会让对手陷入中毒状态。",
					"detail": "消耗100能量，爆发【污泥炸弹】。用污泥投掷对手进行攻击。有时会让对手陷入中毒状态。 对范围内最多3名敌人造成350点伤害，并施加战术压制。",
					"power": 350,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "sludge_bomb",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "拍落",
					"desc": "拍落对手的持有物，直到战斗结束都不能使用。对手携带道具时会增加伤害。",
					"detail": "消耗100能量，爆发【拍落】！拍落对手的持有物，直到战斗结束都不能使用。对手携带道具时会增加伤害。 对范围内最多2名敌人造成315点伤害，并施加战术压制。",
					"power": 315,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "毒击",
					"desc": "用带毒的触手或手臂刺入对手。有时会让对手陷入中毒状态。",
					"detail": "消耗100能量，爆发【毒击】！用带毒的触手或手臂刺入对手。有时会让对手陷入中毒状态。 对范围内最多2名敌人造成360点伤害，并施加战术压制。",
					"power": 360,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "poison_jab",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "飞叶风暴",
					"desc": "用尖尖的叶片向对手卷起风暴。使用之后因为反作用力自己的特攻会大幅降低。",
					"detail": "消耗100能量，释放终极奥义【飞叶风暴】！用尖尖的叶片向对手卷起风暴。使用之后因为反作用力自己的特攻会大幅降低。 席卷战场对最多6名敌人造成715点巨额伤害与强力击破！",
					"power": 715,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "petal_dance",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，释放终极奥义【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 席卷战场对最多4名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "强力鞭打",
					"desc": "激烈地挥舞青藤或触手摔打对手进行攻击。",
					"detail": "消耗100能量，释放终极奥义【强力鞭打】！激烈地挥舞青藤或触手摔打对手进行攻击。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "power_whip",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/weepinbell.png"
	},
	"victreebel": {
		"id": "victreebel",
		"name": "大食花",
		"title": "蝇捕宝可梦",
		"cost": 4,
		"types": ["Grass", "Poison"],
		"hp": 1050,
		"atk": 90,
		"armor": 45,
		"mr": 45,
		"range": 2,
		"atk_speed": 0.72,
		"max_mana": 85,
		"desc": "在深山密林深处建立自己的领地，散发出甜美如同蜂蜜般的香气诱捕猎物，一旦掉入口中就会被顷刻溶解消化。",
		"skill_name": "飞叶快刀",
		"skill_desc": "飞出叶片，切斩对手进行攻击。容易击中要害。",
		"skill_detail": "消耗100能量，使出【飞叶快刀】。飞出叶片，切斩对手进行攻击。容易击中要害。 对目标造成194点伤害。",
		"skill_power": 194,
		"basic_attack": {
			"type": "special",
			"name": "飞叶",
			"style": "leaf",
			"sfx": "swift"
		},
						"skills": {
			1: [
				{
					"name": "飞叶快刀",
					"desc": "飞出叶片，切斩对手进行攻击。容易击中要害。",
					"detail": "消耗100能量，使出【飞叶快刀】。飞出叶片，切斩对手进行攻击。容易击中要害。 对目标造成194点伤害。",
					"power": 194,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "razor_leaf",
					"sfx": "slash",
					"scale": 0.28
				},
				{
					"name": "青草搅拌器",
					"desc": "用锋利的叶片包裹住对手进行攻击。有时会降低对手的命中率。",
					"detail": "消耗100能量，使出【青草搅拌器】。用锋利的叶片包裹住对手进行攻击。有时会降低对手的命中率。 对目标造成230点伤害。",
					"power": 230,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "leech_seed",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "摔打",
					"desc": "使用长长的尾巴或藤蔓等摔打对手进行攻击。",
					"detail": "消耗100能量，使出【摔打】。使用长长的尾巴或藤蔓等摔打对手进行攻击。 对目标造成260点伤害。",
					"power": 260,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "污泥炸弹",
					"desc": "用污泥投掷对手进行攻击。有时会让对手陷入中毒状态。",
					"detail": "消耗100能量，爆发【污泥炸弹】。用污泥投掷对手进行攻击。有时会让对手陷入中毒状态。 对范围内最多3名敌人造成350点伤害，并施加战术压制。",
					"power": 350,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "sludge_bomb",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "藤鞭",
					"desc": "用如同鞭子般弯曲而细长的藤蔓摔打对手进行攻击。",
					"detail": "消耗100能量，爆发【藤鞭】！用如同鞭子般弯曲而细长的藤蔓摔打对手进行攻击。 对范围内最多2名敌人造成255点伤害，并施加战术压制。",
					"power": 255,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "vine_whip",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "居合斩",
					"desc": "用镰刀或爪子等切斩对手进行攻击。",
					"detail": "消耗100能量，爆发【居合斩】！用镰刀或爪子等切斩对手进行攻击。 对范围内最多2名敌人造成270点伤害，并施加战术压制。",
					"power": 270,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "slash",
					"sfx": "slash",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "飞叶风暴",
					"desc": "用尖尖的叶片向对手卷起风暴。使用之后因为反作用力自己的特攻会大幅降低。",
					"detail": "消耗100能量，释放终极奥义【飞叶风暴】！用尖尖的叶片向对手卷起风暴。使用之后因为反作用力自己的特攻会大幅降低。 席卷战场对最多6名敌人造成715点巨额伤害与强力击破！",
					"power": 715,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "petal_dance",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "叶刃",
					"desc": "像用剑一般操纵叶片切斩对手进行攻击。容易击中要害。",
					"detail": "消耗100能量，释放终极奥义【叶刃】！像用剑一般操纵叶片切斩对手进行攻击。容易击中要害。 席卷战场对最多4名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "leaf_blade",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "日光束",
					"desc": "第１回合收集满满的日光，第２回合发射光束进行攻击。",
					"detail": "消耗100能量，释放终极奥义【日光束】！第１回合收集满满的日光，第２回合发射光束进行攻击。 席卷战场对最多6名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "solar_beam",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/victreebel.png"
	},
	"tentacool": {
		"id": "tentacool",
		"name": "玛瑙水母",
		"title": "水母宝可梦",
		"cost": 1,
		"types": ["Water", "Poison"],
		"hp": 550,
		"atk": 44,
		"armor": 22,
		"mr": 45,
		"range": 2,
		"atk_speed": 0.65,
		"max_mana": 80,
		"desc": "身体的99%都是由水组成的，在海水里漂浮时几乎透明不可见。两只红色的透明发光水晶能发射神秘的光线。",
		"skill_name": "毒针",
		"skill_desc": "将有毒的针刺入对手进行攻击。有时会让对手陷入中毒状态。",
		"skill_detail": "消耗100能量，使出【毒针】。将有毒的针刺入对手进行攻击。有时会让对手陷入中毒状态。 对目标造成162点伤害。",
		"skill_power": 162,
		"basic_attack": {
			"type": "special",
			"name": "水滴弹",
			"style": "water_bullet",
			"sfx": "water"
		},
						"skills": {
			1: [
				{
					"name": "毒针",
					"desc": "将有毒的针刺入对手进行攻击。有时会让对手陷入中毒状态。",
					"detail": "消耗100能量，使出【毒针】。将有毒的针刺入对手进行攻击。有时会让对手陷入中毒状态。 对目标造成162点伤害。",
					"power": 162,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "poison_sting",
					"sfx": "slash",
					"scale": 0.28
				},
				{
					"name": "水枪",
					"desc": "向对手猛烈地喷射水流进行攻击。",
					"detail": "消耗100能量，使出【水枪】。向对手猛烈地喷射水流进行攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "water_gun",
					"sfx": "water",
					"scale": 0.82
				},
				{
					"name": "居合斩",
					"desc": "用镰刀或爪子等切斩对手进行攻击。",
					"detail": "消耗100能量，使出【居合斩】。用镰刀或爪子等切斩对手进行攻击。 对目标造成200点伤害。",
					"power": 200,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "slash",
					"sfx": "slash",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "水之波动",
					"desc": "用水的震动攻击对手。有时会使对手混乱。",
					"detail": "消耗100能量，爆发【水之波动】。用水的震动攻击对手。有时会使对手混乱。 对范围内最多3名敌人造成320点伤害，并施加战术压制。",
					"power": 320,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "water_pulse",
					"sfx": "water",
					"scale": 0.36
				},
				{
					"name": "泡沫光线",
					"desc": "向对手猛烈地喷射泡沫进行攻击。有时会降低对手的速度。",
					"detail": "消耗100能量，爆发【泡沫光线】！向对手猛烈地喷射泡沫进行攻击。有时会降低对手的速度。 对范围内最多3名敌人造成315点伤害，并施加战术压制。",
					"power": 315,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "bubble_beam",
					"sfx": "water",
					"scale": 1.10
				},
				{
					"name": "水炮",
					"desc": "向对手猛烈地喷射大量水流进行攻击。",
					"detail": "消耗100能量，爆发【水炮】！向对手猛烈地喷射大量水流进行攻击。 对范围内最多3名敌人造成450点伤害，并施加战术压制。",
					"power": 450,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "hydro_pump",
					"sfx": "water",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "污泥炸弹",
					"desc": "用污泥投掷对手进行攻击。有时会让对手陷入中毒状态。",
					"detail": "消耗100能量，释放终极奥义【污泥炸弹】！用污泥投掷对手进行攻击。有时会让对手陷入中毒状态。 席卷战场对最多6名敌人造成655点巨额伤害与强力击破！",
					"power": 655,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "sludge_bomb",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，释放终极奥义【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 席卷战场对最多4名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "舍身冲撞",
					"desc": "拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。",
					"detail": "消耗100能量，释放终极奥义【舍身冲撞】！拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "double_edge",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/tentacool.png"
	},
	"tentacruel": {
		"id": "tentacruel",
		"name": "毒刺水母",
		"title": "水母宝可梦",
		"cost": 3,
		"types": ["Water", "Poison"],
		"hp": 950,
		"atk": 70,
		"armor": 42,
		"mr": 65,
		"range": 2,
		"atk_speed": 0.7,
		"max_mana": 85,
		"desc": "拥有整整80条能够自由伸缩的致命触须，头顶红色宝珠会闪耀刺目光芒发出超声波，被称为深海暴徒！",
		"skill_name": "酸液炸弹",
		"skill_desc": "喷出能溶化对手的液体进行攻击。大幅降低对手的特防。",
		"skill_detail": "消耗100能量，使出【酸液炸弹】。喷出能溶化对手的液体进行攻击。大幅降低对手的特防。 对目标造成182点伤害。",
		"skill_power": 182,
		"basic_attack": {
			"type": "special",
			"name": "水滴弹",
			"style": "water_bullet",
			"sfx": "water"
		},
						"skills": {
			1: [
				{
					"name": "酸液炸弹",
					"desc": "喷出能溶化对手的液体进行攻击。大幅降低对手的特防。",
					"detail": "消耗100能量，使出【酸液炸弹】。喷出能溶化对手的液体进行攻击。大幅降低对手的特防。 对目标造成182点伤害。",
					"power": 182,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "poison_sting",
					"sfx": "skill",
					"scale": 0.28
				},
				{
					"name": "紧束",
					"desc": "使用长长的身体或藤蔓等，在４～５回合内紧束对手进行攻击。",
					"detail": "消耗100能量，使出【紧束】。使用长长的身体或藤蔓等，在４～５回合内紧束对手进行攻击。 对目标造成130点伤害。",
					"power": 130,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "祸不单行",
					"desc": "接二连三地进行攻击。对处于异常状态的对手给予较大的伤害。",
					"detail": "消耗100能量，使出【祸不单行】。接二连三地进行攻击。对处于异常状态的对手给予较大的伤害。 对目标造成230点伤害。",
					"power": 230,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "hex_nightmare",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "污泥波",
					"desc": "用污泥波攻击自己周围所有的宝可梦。有时会陷入中毒状态。",
					"detail": "消耗100能量，爆发【污泥波】。用污泥波攻击自己周围所有的宝可梦。有时会陷入中毒状态。 对范围内最多3名敌人造成355点伤害，并施加战术压制。",
					"power": 355,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "sludge_bomb",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "泡沫光线",
					"desc": "向对手猛烈地喷射泡沫进行攻击。有时会降低对手的速度。",
					"detail": "消耗100能量，爆发【泡沫光线】！向对手猛烈地喷射泡沫进行攻击。有时会降低对手的速度。 对范围内最多3名敌人造成315点伤害，并施加战术压制。",
					"power": 315,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "bubble_beam",
					"sfx": "water",
					"scale": 1.10
				},
				{
					"name": "盐水",
					"desc": "当对手的ＨＰ负伤到一半左右时，招式威力会变成２倍。",
					"detail": "消耗100能量，爆发【盐水】！当对手的ＨＰ负伤到一半左右时，招式威力会变成２倍。 对范围内最多3名敌人造成315点伤害，并施加战术压制。",
					"power": 315,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "water_pulse",
					"sfx": "water",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "水炮",
					"desc": "向对手猛烈地喷射大量水流进行攻击。",
					"detail": "消耗100能量，释放终极奥义【水炮】！向对手猛烈地喷射大量水流进行攻击。 席卷战场对最多6名敌人造成685点巨额伤害与强力击破！",
					"power": 685,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "hydro_pump",
					"sfx": "water",
					"scale": 0.48
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，释放终极奥义【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 席卷战场对最多4名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "舍身冲撞",
					"desc": "拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。",
					"detail": "消耗100能量，释放终极奥义【舍身冲撞】！拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "double_edge",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/tentacruel.png"
	},
	"geodude": {
		"id": "geodude",
		"name": "小拳石",
		"title": "岩石宝可梦",
		"cost": 1,
		"types": ["Rock", "Ground"],
		"hp": 680,
		"atk": 56,
		"armor": 45,
		"mr": 20,
		"range": 1,
		"atk_speed": 0.6,
		"max_mana": 85,
		"desc": "坚硬无比的圆滚滚身体看起来就像一块普通石头，擅长用两条粗壮的手臂攀爬险峻的山崖，并挥拳猛击！",
		"skill_name": "撞击",
		"skill_desc": "用整个身体撞向对手进行攻击。",
		"skill_detail": "消耗100能量，使出【撞击】。用整个身体撞向对手进行攻击。 对目标造成182点伤害。",
		"skill_power": 182,
		"basic_attack": {
			"type": "physical",
			"name": "撞击",
			"style": "tackle",
			"sfx": "attack"
		},
						"skills": {
			1: [
				{
					"name": "撞击",
					"desc": "用整个身体撞向对手进行攻击。",
					"detail": "消耗100能量，使出【撞击】。用整个身体撞向对手进行攻击。 对目标造成182点伤害。",
					"power": 182,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "tackle",
					"sfx": "attack",
					"scale": 0.28
				},
				{
					"name": "变圆",
					"desc": "将身体蜷曲变圆，从而提高自己的防御。",
					"detail": "消耗100能量，使出【变圆】。将身体蜷曲变圆，从而提高自己的防御。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "百万吨重拳",
					"desc": "用充满力量的拳头攻击对手。",
					"detail": "消耗100能量，使出【百万吨重拳】。用充满力量的拳头攻击对手。 对目标造成260点伤害。",
					"power": 260,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "mega_punch",
					"sfx": "punch",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "落石",
					"desc": "拿起小岩石，投掷对手进行攻击。",
					"detail": "消耗100能量，爆发【落石】。拿起小岩石，投掷对手进行攻击。 对范围内最多3名敌人造成310点伤害，并施加战术压制。",
					"power": 310,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "rock_throw",
					"sfx": "attack",
					"scale": 0.36
				},
				{
					"name": "自爆",
					"desc": "引发爆炸，攻击自己周围所有的宝可梦。使用后陷入濒死。",
					"detail": "消耗100能量，爆发【自爆】！引发爆炸，攻击自己周围所有的宝可梦。使用后陷入濒死。 对范围内最多2名敌人造成720点伤害，并施加战术压制。",
					"power": 720,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "fire_blast",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "尖石攻击",
					"desc": "用尖尖的岩石刺入对手进行攻击。容易击中要害。",
					"detail": "消耗100能量，爆发【尖石攻击】！用尖尖的岩石刺入对手进行攻击。容易击中要害。 对范围内最多2名敌人造成420点伤害，并施加战术压制。",
					"power": 420,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "stone_edge",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "岩崩",
					"desc": "将大岩石猛烈地撞向对手进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，释放终极奥义【岩崩】！将大岩石猛烈地撞向对手进行攻击。有时会使对手畏缩。 席卷战场对最多6名敌人造成632点巨额伤害与强力击破！",
					"power": 632,
					"target_count": 6,
					"stun_duration": 1.2,
					"vfx": "rock_slide",
					"sfx": "attack",
					"scale": 0.48
				},
				{
					"name": "地震",
					"desc": "利用地震的冲击，攻击自己周围所有的宝可梦。",
					"detail": "消耗100能量，释放终极奥义【地震】！利用地震的冲击，攻击自己周围所有的宝可梦。 席卷战场对最多4名敌人造成680点巨额伤害与强力击破！",
					"power": 680,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "earthquake",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，释放终极奥义【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 席卷战场对最多4名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/geodude.png"
	},
	"graveler": {
		"id": "graveler",
		"name": "隆隆石",
		"title": "岩石宝可梦",
		"cost": 2,
		"types": ["Rock", "Ground"],
		"hp": 880,
		"atk": 72,
		"armor": 55,
		"mr": 25,
		"range": 1,
		"atk_speed": 0.65,
		"max_mana": 90,
		"desc": "在险峻的山道上以惊人的速度滚落前行，无论遇到什么障碍物都会毫不犹豫地一路碾压碾碎过去。",
		"skill_name": "落石",
		"skill_desc": "拿起小岩石，投掷对手进行攻击。",
		"skill_detail": "消耗100能量，使出【落石】。拿起小岩石，投掷对手进行攻击。 对目标造成190点伤害。",
		"skill_power": 190,
		"basic_attack": {
			"type": "physical",
			"name": "撞击",
			"style": "tackle",
			"sfx": "attack"
		},
						"skills": {
			1: [
				{
					"name": "落石",
					"desc": "拿起小岩石，投掷对手进行攻击。",
					"detail": "消耗100能量，使出【落石】。拿起小岩石，投掷对手进行攻击。 对目标造成190点伤害。",
					"power": 190,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "rock_throw",
					"sfx": "attack",
					"scale": 0.28
				},
				{
					"name": "撞击",
					"desc": "用整个身体撞向对手进行攻击。",
					"detail": "消耗100能量，使出【撞击】。用整个身体撞向对手进行攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "tackle",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "变圆",
					"desc": "将身体蜷曲变圆，从而提高自己的防御。",
					"detail": "消耗100能量，使出【变圆】。将身体蜷曲变圆，从而提高自己的防御。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "岩崩",
					"desc": "将大岩石猛烈地撞向对手进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，爆发【岩崩】。将大岩石猛烈地撞向对手进行攻击。有时会使对手畏缩。 对范围内最多3名敌人造成335点伤害，并施加战术压制。",
					"power": 335,
					"target_count": 3,
					"stun_duration": 0.8,
					"vfx": "rock_slide",
					"sfx": "attack",
					"scale": 0.36
				},
				{
					"name": "自爆",
					"desc": "引发爆炸，攻击自己周围所有的宝可梦。使用后陷入濒死。",
					"detail": "消耗100能量，爆发【自爆】！引发爆炸，攻击自己周围所有的宝可梦。使用后陷入濒死。 对范围内最多2名敌人造成720点伤害，并施加战术压制。",
					"power": 720,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "fire_blast",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "百万吨重拳",
					"desc": "用充满力量的拳头攻击对手。",
					"detail": "消耗100能量，爆发【百万吨重拳】！用充满力量的拳头攻击对手。 对范围内最多2名敌人造成360点伤害，并施加战术压制。",
					"power": 360,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "mega_punch",
					"sfx": "punch",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "地震",
					"desc": "利用地震的冲击，攻击自己周围所有的宝可梦。",
					"detail": "消耗100能量，释放终极奥义【地震】！利用地震的冲击，攻击自己周围所有的宝可梦。 席卷战场对最多6名敌人造成670点巨额伤害与强力击破！",
					"power": 670,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "earthquake",
					"sfx": "attack",
					"scale": 0.48
				},
				{
					"name": "舍身冲撞",
					"desc": "拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。",
					"detail": "消耗100能量，释放终极奥义【舍身冲撞】！拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "double_edge",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "尖石攻击",
					"desc": "用尖尖的岩石刺入对手进行攻击。容易击中要害。",
					"detail": "消耗100能量，释放终极奥义【尖石攻击】！用尖尖的岩石刺入对手进行攻击。容易击中要害。 席卷战场对最多4名敌人造成680点巨额伤害与强力击破！",
					"power": 680,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "stone_edge",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/graveler.png"
	},
	"golem": {
		"id": "golem",
		"name": "隆隆岩",
		"title": "重量级宝可梦",
		"cost": 4,
		"types": ["Rock", "Ground"],
		"hp": 1300,
		"atk": 98,
		"armor": 70,
		"mr": 35,
		"range": 1,
		"atk_speed": 0.65,
		"max_mana": 90,
		"desc": "外壳坚硬胜过钻石，甚至连炸药也无法在上面留下丝毫痕迹。在火山爆发时会像炮弹一样从山顶轰鸣滚落！",
		"skill_name": "岩崩",
		"skill_desc": "将大岩石猛烈地撞向对手进行攻击。有时会使对手畏缩。",
		"skill_detail": "消耗100能量，使出【岩崩】。将大岩石猛烈地撞向对手进行攻击。有时会使对手畏缩。 对目标造成210点伤害。",
		"skill_power": 210,
		"basic_attack": {
			"type": "physical",
			"name": "撞击",
			"style": "tackle",
			"sfx": "attack"
		},
						"skills": {
			1: [
				{
					"name": "岩崩",
					"desc": "将大岩石猛烈地撞向对手进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，使出【岩崩】。将大岩石猛烈地撞向对手进行攻击。有时会使对手畏缩。 对目标造成210点伤害。",
					"power": 210,
					"target_count": 1,
					"stun_duration": 0.5,
					"vfx": "rock_slide",
					"sfx": "attack",
					"scale": 0.28
				},
				{
					"name": "撞击",
					"desc": "用整个身体撞向对手进行攻击。",
					"detail": "消耗100能量，使出【撞击】。用整个身体撞向对手进行攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "tackle",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "变圆",
					"desc": "将身体蜷曲变圆，从而提高自己的防御。",
					"detail": "消耗100能量，使出【变圆】。将身体蜷曲变圆，从而提高自己的防御。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "尖石攻击",
					"desc": "用尖尖的岩石刺入对手进行攻击。容易击中要害。",
					"detail": "消耗100能量，爆发【尖石攻击】。用尖尖的岩石刺入对手进行攻击。容易击中要害。 对范围内最多3名敌人造成360点伤害，并施加战术压制。",
					"power": 360,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "stone_edge",
					"sfx": "attack",
					"scale": 0.36
				},
				{
					"name": "自爆",
					"desc": "引发爆炸，攻击自己周围所有的宝可梦。使用后陷入濒死。",
					"detail": "消耗100能量，爆发【自爆】！引发爆炸，攻击自己周围所有的宝可梦。使用后陷入濒死。 对范围内最多2名敌人造成720点伤害，并施加战术压制。",
					"power": 720,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "fire_blast",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "大爆炸",
					"desc": "引发大爆炸，攻击自己周围所有的宝可梦。使用后自己会陷入濒死。",
					"detail": "消耗100能量，爆发【大爆炸】！引发大爆炸，攻击自己周围所有的宝可梦。使用后自己会陷入濒死。 对范围内最多2名敌人造成870点伤害，并施加战术压制。",
					"power": 870,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "rock_throw",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "地震",
					"desc": "利用地震的冲击，攻击自己周围所有的宝可梦。",
					"detail": "消耗100能量，释放终极奥义【地震】！利用地震的冲击，攻击自己周围所有的宝可梦。 席卷战场对最多6名敌人造成670点巨额伤害与强力击破！",
					"power": 670,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "earthquake",
					"sfx": "attack",
					"scale": 0.48
				},
				{
					"name": "舍身冲撞",
					"desc": "拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。",
					"detail": "消耗100能量，释放终极奥义【舍身冲撞】！拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "double_edge",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "百万吨重拳",
					"desc": "用充满力量的拳头攻击对手。",
					"detail": "消耗100能量，释放终极奥义【百万吨重拳】！用充满力量的拳头攻击对手。 席卷战场对最多4名敌人造成580点巨额伤害与强力击破！",
					"power": 580,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "mega_punch",
					"sfx": "punch",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/golem.png"
	},
	"ponyta": {
		"id": "ponyta",
		"name": "小火马",
		"title": "火马宝可梦",
		"cost": 1,
		"types": ["Fire"],
		"hp": 560,
		"atk": 54,
		"armor": 24,
		"mr": 24,
		"range": 1,
		"atk_speed": 0.75,
		"max_mana": 80,
		"desc": "刚出生时几乎站不稳，但在追赶父母的过程中锻炼出了惊人的脚力，鬃毛和尾巴燃烧着美丽炽热的烈火。",
		"skill_name": "火花",
		"skill_desc": "向对手发射小型火焰进行攻击。有时会让对手陷入灼伤状态。",
		"skill_detail": "消耗100能量，使出【火花】。向对手发射小型火焰进行攻击。有时会让对手陷入灼伤状态。 对目标造成182点伤害。",
		"skill_power": 182,
		"basic_attack": {
			"type": "physical",
			"name": "撞击",
			"style": "tackle",
			"sfx": "attack"
		},
						"skills": {
			1: [
				{
					"name": "火花",
					"desc": "向对手发射小型火焰进行攻击。有时会让对手陷入灼伤状态。",
					"detail": "消耗100能量，使出【火花】。向对手发射小型火焰进行攻击。有时会让对手陷入灼伤状态。 对目标造成182点伤害。",
					"power": 182,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "ember",
					"sfx": "fire",
					"scale": 0.28
				},
				{
					"name": "撞击",
					"desc": "用整个身体撞向对手进行攻击。",
					"detail": "消耗100能量，使出【撞击】。用整个身体撞向对手进行攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "tackle",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "踩踏",
					"desc": "用大脚踩踏对手进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，使出【踩踏】。用大脚踩踏对手进行攻击。有时会使对手畏缩。 对目标造成230点伤害。",
					"power": 230,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "火焰轮",
					"desc": "让火焰覆盖全身，猛撞向对手进行攻击。有时会让对手陷入灼伤状态。",
					"detail": "消耗100能量，爆发【火焰轮】。让火焰覆盖全身，猛撞向对手进行攻击。有时会让对手陷入灼伤状态。 对范围内最多3名敌人造成320点伤害，并施加战术压制。",
					"power": 320,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "flame_wheel",
					"sfx": "fire",
					"scale": 0.36
				},
				{
					"name": "火焰旋涡",
					"desc": "将对手困在激烈的火焰旋涡中，在４～５回合内进行攻击。",
					"detail": "消耗100能量，爆发【火焰旋涡】！将对手困在激烈的火焰旋涡中，在４～５回合内进行攻击。 对范围内最多3名敌人造成225点伤害，并施加战术压制。",
					"power": 225,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "fire_spin",
					"sfx": "fire",
					"scale": 1.10
				},
				{
					"name": "舍身冲撞",
					"desc": "拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。",
					"detail": "消耗100能量，爆发【舍身冲撞】！拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。 对范围内最多2名敌人造成480点伤害，并施加战术压制。",
					"power": 480,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "double_edge",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "大字爆炎",
					"desc": "用大字形状的火焰烧尽对手。有时会让对手陷入灼伤状态。",
					"detail": "消耗100能量，释放终极奥义【大字爆炎】！用大字形状的火焰烧尽对手。有时会让对手陷入灼伤状态。 席卷战场对最多6名敌人造成685点巨额伤害与强力击破！",
					"power": 685,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "fire_blast",
					"sfx": "fire",
					"scale": 0.48
				},
				{
					"name": "炼狱",
					"desc": "用烈焰包裹住对手进行攻击。让对手陷入灼伤状态。",
					"detail": "消耗100能量，释放终极奥义【炼狱】！用烈焰包裹住对手进行攻击。让对手陷入灼伤状态。 席卷战场对最多6名敌人造成680点巨额伤害与强力击破！",
					"power": 680,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "inferno",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "闪焰冲锋",
					"desc": "让火焰覆盖全身猛撞向对手。自己也会受到不小的伤害。有时会让对手陷入灼伤状态。",
					"detail": "消耗100能量，释放终极奥义【闪焰冲锋】！让火焰覆盖全身猛撞向对手。自己也会受到不小的伤害。有时会让对手陷入灼伤状态。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "flare_blitz",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/ponyta.png"
	},
	"rapidash": {
		"id": "rapidash",
		"name": "烈焰马",
		"title": "火马宝可梦",
		"cost": 3,
		"types": ["Fire"],
		"hp": 880,
		"atk": 78,
		"armor": 38,
		"mr": 35,
		"range": 1,
		"atk_speed": 0.85,
		"max_mana": 85,
		"desc": "最高时速可达240公里，奔跑起来就如同一道掠过草原的赤红火流星，马鬃上翻滚的烈火甚至能照亮夜空！",
		"skill_name": "火焰轮",
		"skill_desc": "让火焰覆盖全身，猛撞向对手进行攻击。有时会让对手陷入灼伤状态。",
		"skill_detail": "消耗100能量，使出【火焰轮】。让火焰覆盖全身，猛撞向对手进行攻击。有时会让对手陷入灼伤状态。 对目标造成198点伤害。",
		"skill_power": 198,
		"basic_attack": {
			"type": "physical",
			"name": "撞击",
			"style": "tackle",
			"sfx": "attack"
		},
						"skills": {
			1: [
				{
					"name": "火焰轮",
					"desc": "让火焰覆盖全身，猛撞向对手进行攻击。有时会让对手陷入灼伤状态。",
					"detail": "消耗100能量，使出【火焰轮】。让火焰覆盖全身，猛撞向对手进行攻击。有时会让对手陷入灼伤状态。 对目标造成198点伤害。",
					"power": 198,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "flame_wheel",
					"sfx": "fire",
					"scale": 0.28
				},
				{
					"name": "乱击",
					"desc": "用角或喙刺向对手进行攻击。连续攻击２～５次。",
					"detail": "消耗100能量，使出【乱击】。用角或喙刺向对手进行攻击。连续攻击２～５次。 对目标造成130点伤害。",
					"power": 130,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "蓄能焰袭",
					"desc": "让火焰覆盖全身，攻击对手。积蓄力量并提高自己的速度。",
					"detail": "消耗100能量，使出【蓄能焰袭】。让火焰覆盖全身，攻击对手。积蓄力量并提高自己的速度。 对目标造成200点伤害。",
					"power": 200,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "ember",
					"sfx": "fire",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "超级角击",
					"desc": "用坚硬且华丽的角狠狠地刺入对手进行攻击。",
					"detail": "消耗100能量，爆发【超级角击】。用坚硬且华丽的角狠狠地刺入对手进行攻击。 对范围内最多3名敌人造成380点伤害，并施加战术压制。",
					"power": 380,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "giga_impact",
					"sfx": "attack",
					"scale": 0.36
				},
				{
					"name": "火焰旋涡",
					"desc": "将对手困在激烈的火焰旋涡中，在４～５回合内进行攻击。",
					"detail": "消耗100能量，爆发【火焰旋涡】！将对手困在激烈的火焰旋涡中，在４～５回合内进行攻击。 对范围内最多3名敌人造成225点伤害，并施加战术压制。",
					"power": 225,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "fire_spin",
					"sfx": "fire",
					"scale": 1.10
				},
				{
					"name": "舍身冲撞",
					"desc": "拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。",
					"detail": "消耗100能量，爆发【舍身冲撞】！拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。 对范围内最多2名敌人造成480点伤害，并施加战术压制。",
					"power": 480,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "double_edge",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "闪焰冲锋",
					"desc": "让火焰覆盖全身猛撞向对手。自己也会受到不小的伤害。有时会让对手陷入灼伤状态。",
					"detail": "消耗100能量，释放终极奥义【闪焰冲锋】！让火焰覆盖全身猛撞向对手。自己也会受到不小的伤害。有时会让对手陷入灼伤状态。 席卷战场对最多6名敌人造成700点巨额伤害与强力击破！",
					"power": 700,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "flare_blitz",
					"sfx": "fire",
					"scale": 0.48
				},
				{
					"name": "炼狱",
					"desc": "用烈焰包裹住对手进行攻击。让对手陷入灼伤状态。",
					"detail": "消耗100能量，释放终极奥义【炼狱】！用烈焰包裹住对手进行攻击。让对手陷入灼伤状态。 席卷战场对最多6名敌人造成680点巨额伤害与强力击破！",
					"power": 680,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "inferno",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "弹跳",
					"desc": "弹跳到高高的空中，第２回合攻击对手。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，释放终极奥义【弹跳】！弹跳到高高的空中，第２回合攻击对手。有时会让对手陷入麻痹状态。 席卷战场对最多4名敌人造成605点巨额伤害与强力击破！",
					"power": 605,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "air_slash",
					"sfx": "slash",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/rapidash.png"
	},
	"slowpoke": {
		"id": "slowpoke",
		"name": "呆呆兽",
		"title": "憨憨宝可梦",
		"cost": 1,
		"types": ["Water", "Psychic"],
		"hp": 720,
		"atk": 45,
		"armor": 35,
		"mr": 35,
		"range": 1,
		"atk_speed": 0.55,
		"max_mana": 85,
		"desc": "总是呆呆地把尾巴垂进水里钓鱼。就算尾巴被咬住了，也要过整整一天才能感觉到疼痛，反应极度迟钝。",
		"skill_name": "水枪",
		"skill_desc": "向对手猛烈地喷射水流进行攻击。",
		"skill_detail": "消耗100能量，使出【水枪】。向对手猛烈地喷射水流进行攻击。 对目标造成182点伤害。",
		"skill_power": 182,
		"basic_attack": {
			"type": "physical",
			"name": "撞击",
			"style": "tackle",
			"sfx": "attack"
		},
						"skills": {
			1: [
				{
					"name": "水枪",
					"desc": "向对手猛烈地喷射水流进行攻击。",
					"detail": "消耗100能量，使出【水枪】。向对手猛烈地喷射水流进行攻击。 对目标造成182点伤害。",
					"power": 182,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "water_gun",
					"sfx": "water",
					"scale": 0.28
				},
				{
					"name": "头锤",
					"desc": "将头伸出，笔直地扑向对手进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，使出【头锤】。将头伸出，笔直地扑向对手进行攻击。有时会使对手畏缩。 对目标造成240点伤害。",
					"power": 240,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "headbutt",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "瞬间失忆",
					"desc": "将头脑清空，瞬间忘记某事，从而大幅提高自己的特防。",
					"detail": "消耗100能量，使出【瞬间失忆】。将头脑清空，瞬间忘记某事，从而大幅提高自己的特防。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "rest",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "念力",
					"desc": "向对手发送微弱的念力进行攻击。有时会使对手混乱。",
					"detail": "消耗100能量，爆发【念力】。向对手发送微弱的念力进行攻击。有时会使对手混乱。 对范围内最多3名敌人造成310点伤害，并施加战术压制。",
					"power": 310,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "confusion",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "水之波动",
					"desc": "用水的震动攻击对手。有时会使对手混乱。",
					"detail": "消耗100能量，爆发【水之波动】！用水的震动攻击对手。有时会使对手混乱。 对范围内最多3名敌人造成300点伤害，并施加战术压制。",
					"power": 300,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "water_pulse",
					"sfx": "water",
					"scale": 1.10
				},
				{
					"name": "精神强念",
					"desc": "向对手发送强大的念力进行攻击。有时会降低对手的特防。",
					"detail": "消耗100能量，爆发【精神强念】！向对手发送强大的念力进行攻击。有时会降低对手的特防。 对范围内最多3名敌人造成390点伤害，并施加战术压制。",
					"power": 390,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "psychic",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "冲浪",
					"desc": "利用大浪攻击自己周围所有的宝可梦。",
					"detail": "消耗100能量，释放终极奥义【冲浪】！利用大浪攻击自己周围所有的宝可梦。 席卷战场对最多6名敌人造成655点巨额伤害与强力击破！",
					"power": 655,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "surf",
					"sfx": "water",
					"scale": 0.48
				},
				{
					"name": "泰山压顶",
					"desc": "用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，释放终极奥义【泰山压顶】！用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。 席卷战场对最多4名敌人造成605点巨额伤害与强力击破！",
					"power": 605,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "根源波动",
					"desc": "用无数青白色且闪耀的光线攻击对手。",
					"detail": "消耗100能量，释放终极奥义【根源波动】！用无数青白色且闪耀的光线攻击对手。 席卷战场对最多6名敌人造成730点巨额伤害与强力击破！",
					"power": 730,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "hydro_cannon",
					"sfx": "water",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/slowpoke.png"
	},
	"slowbro": {
		"id": "slowbro",
		"name": "呆壳兽",
		"title": "寄居蟹宝可梦",
		"cost": 3,
		"types": ["Water", "Psychic"],
		"hp": 1100,
		"atk": 68,
		"armor": 55,
		"mr": 50,
		"range": 1,
		"atk_speed": 0.6,
		"max_mana": 90,
		"desc": "尾巴被大舌贝咬住后发生了合体进化。大舌贝的毒素刺激了它的大脑，使其觉醒了不可思议的强大超能力！",
		"skill_name": "水之波动",
		"skill_desc": "用水的震动攻击对手。有时会使对手混乱。",
		"skill_detail": "消耗100能量，使出【水之波动】。用水的震动攻击对手。有时会使对手混乱。 对目标造成198点伤害。",
		"skill_power": 198,
		"basic_attack": {
			"type": "physical",
			"name": "撞击",
			"style": "tackle",
			"sfx": "attack"
		},
						"skills": {
			1: [
				{
					"name": "水之波动",
					"desc": "用水的震动攻击对手。有时会使对手混乱。",
					"detail": "消耗100能量，使出【水之波动】。用水的震动攻击对手。有时会使对手混乱。 对目标造成198点伤害。",
					"power": 198,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "water_pulse",
					"sfx": "water",
					"scale": 0.28
				},
				{
					"name": "头锤",
					"desc": "将头伸出，笔直地扑向对手进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，使出【头锤】。将头伸出，笔直地扑向对手进行攻击。有时会使对手畏缩。 对目标造成240点伤害。",
					"power": 240,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "headbutt",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "踩踏",
					"desc": "用大脚踩踏对手进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，使出【踩踏】。用大脚踩踏对手进行攻击。有时会使对手畏缩。 对目标造成230点伤害。",
					"power": 230,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "精神强念",
					"desc": "向对手发送强大的念力进行攻击。有时会降低对手的特防。",
					"detail": "消耗100能量，爆发【精神强念】。向对手发送强大的念力进行攻击。有时会降低对手的特防。 对范围内最多3名敌人造成350点伤害，并施加战术压制。",
					"power": 350,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "psychic",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "念力",
					"desc": "向对手发送微弱的念力进行攻击。有时会使对手混乱。",
					"detail": "消耗100能量，爆发【念力】！向对手发送微弱的念力进行攻击。有时会使对手混乱。 对范围内最多3名敌人造成270点伤害，并施加战术压制。",
					"power": 270,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "confusion",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "水枪",
					"desc": "向对手猛烈地喷射水流进行攻击。",
					"detail": "消耗100能量，爆发【水枪】！向对手猛烈地喷射水流进行攻击。 对范围内最多3名敌人造成240点伤害，并施加战术压制。",
					"power": 240,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "water_gun",
					"sfx": "water",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "冲浪",
					"desc": "利用大浪攻击自己周围所有的宝可梦。",
					"detail": "消耗100能量，释放终极奥义【冲浪】！利用大浪攻击自己周围所有的宝可梦。 席卷战场对最多6名敌人造成655点巨额伤害与强力击破！",
					"power": 655,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "surf",
					"sfx": "water",
					"scale": 0.48
				},
				{
					"name": "瞬间失忆",
					"desc": "将头脑清空，瞬间忘记某事，从而大幅提高自己的特防。",
					"detail": "消耗100能量，释放终极奥义【瞬间失忆】！将头脑清空，瞬间忘记某事，从而大幅提高自己的特防。 席卷战场对最多6名敌人造成680点巨额伤害与强力击破！",
					"power": 680,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "rest",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "根源波动",
					"desc": "用无数青白色且闪耀的光线攻击对手。",
					"detail": "消耗100能量，释放终极奥义【根源波动】！用无数青白色且闪耀的光线攻击对手。 席卷战场对最多6名敌人造成730点巨额伤害与强力击破！",
					"power": 730,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "hydro_cannon",
					"sfx": "water",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/slowbro.png"
	},
	"magnemite": {
		"id": "magnemite",
		"name": "小磁怪",
		"title": "磁铁宝可梦",
		"cost": 1,
		"types": ["Electric"],
		"hp": 500,
		"atk": 52,
		"armor": 35,
		"mr": 30,
		"range": 3,
		"atk_speed": 0.68,
		"max_mana": 75,
		"desc": "身体两侧的U形磁铁能释放强烈的电磁波，使自己始终漂浮在空中，靠近发电厂和电线杆时会被强大的电磁吸引。",
		"skill_name": "电击",
		"skill_desc": "发出电流刺激对手进行攻击。有时会让对手陷入麻痹状态。",
		"skill_detail": "消耗100能量，使出【电击】。发出电流刺激对手进行攻击。有时会让对手陷入麻痹状态。 对目标造成182点伤害。",
		"skill_power": 182,
		"basic_attack": {
			"type": "special",
			"name": "电火花",
			"style": "spark",
			"sfx": "spark"
		},
						"skills": {
			1: [
				{
					"name": "电击",
					"desc": "发出电流刺激对手进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，使出【电击】。发出电流刺激对手进行攻击。有时会让对手陷入麻痹状态。 对目标造成182点伤害。",
					"power": 182,
					"target_count": 1,
					"stun_duration": 0.5,
					"vfx": "thundershock",
					"sfx": "spark",
					"scale": 0.28
				},
				{
					"name": "撞击",
					"desc": "用整个身体撞向对手进行攻击。",
					"detail": "消耗100能量，使出【撞击】。用整个身体撞向对手进行攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "tackle",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "高速星星",
					"desc": "发射星形的光攻击对手。攻击必定会命中。",
					"detail": "消耗100能量，使出【高速星星】。发射星形的光攻击对手。攻击必定会命中。 对目标造成220点伤害。",
					"power": 220,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "swift",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "电光",
					"desc": "让电流覆盖全身，猛撞向对手进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，爆发【电光】。让电流覆盖全身，猛撞向对手进行攻击。有时会让对手陷入麻痹状态。 对范围内最多3名敌人造成325点伤害，并施加战术压制。",
					"power": 325,
					"target_count": 3,
					"stun_duration": 0.8,
					"vfx": "spark",
					"sfx": "spark",
					"scale": 0.36
				},
				{
					"name": "镜光射击",
					"desc": "抛光自己的身体，向对手释放出闪光之力。有时会降低对手的命中率。",
					"detail": "消耗100能量，爆发【镜光射击】！抛光自己的身体，向对手释放出闪光之力。有时会降低对手的命中率。 对范围内最多3名敌人造成315点伤害，并施加战术压制。",
					"power": 315,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "放电",
					"desc": "用耀眼的电击攻击自己周围所有的宝可梦。有时会陷入麻痹状态。",
					"detail": "消耗100能量，爆发【放电】！用耀眼的电击攻击自己周围所有的宝可梦。有时会陷入麻痹状态。 对范围内最多3名敌人造成360点伤害，并施加战术压制。",
					"power": 360,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "discharge",
					"sfx": "thunder",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "十万伏特",
					"desc": "向对手发出强力电击进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，释放终极奥义【十万伏特】！向对手发出强力电击进行攻击。有时会让对手陷入麻痹状态。 席卷战场对最多6名敌人造成655点巨额伤害与强力击破！",
					"power": 655,
					"target_count": 6,
					"stun_duration": 1.2,
					"vfx": "thunderbolt",
					"sfx": "thunder",
					"scale": 0.48
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，释放终极奥义【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 席卷战场对最多4名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "电磁炮",
					"desc": "发射大炮一样的电流进行攻击。让对手陷入麻痹状态。",
					"detail": "消耗100能量，释放终极奥义【电磁炮】！发射大炮一样的电流进行攻击。让对手陷入麻痹状态。 席卷战场对最多6名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "electro_ball",
					"sfx": "thunder",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/magnemite.png"
	},
	"magneton": {
		"id": "magneton",
		"name": "三合一磁怪",
		"title": "磁铁宝可梦",
		"cost": 3,
		"types": ["Electric"],
		"hp": 850,
		"atk": 82,
		"armor": 48,
		"mr": 42,
		"range": 3,
		"atk_speed": 0.72,
		"max_mana": 80,
		"desc": "由三只小磁怪通过强大的电磁力紧密连接在一起，释放出的强劲磁力甚至能将周围半径一公里内的水分全部蒸发！",
		"skill_name": "电光",
		"skill_desc": "让电流覆盖全身，猛撞向对手进行攻击。有时会让对手陷入麻痹状态。",
		"skill_detail": "消耗100能量，使出【电光】。让电流覆盖全身，猛撞向对手进行攻击。有时会让对手陷入麻痹状态。 对目标造成202点伤害。",
		"skill_power": 202,
		"basic_attack": {
			"type": "special",
			"name": "电火花",
			"style": "spark",
			"sfx": "spark"
		},
						"skills": {
			1: [
				{
					"name": "电光",
					"desc": "让电流覆盖全身，猛撞向对手进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，使出【电光】。让电流覆盖全身，猛撞向对手进行攻击。有时会让对手陷入麻痹状态。 对目标造成202点伤害。",
					"power": 202,
					"target_count": 1,
					"stun_duration": 0.5,
					"vfx": "spark",
					"sfx": "spark",
					"scale": 0.28
				},
				{
					"name": "撞击",
					"desc": "用整个身体撞向对手进行攻击。",
					"detail": "消耗100能量，使出【撞击】。用整个身体撞向对手进行攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "tackle",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "陀螺球",
					"desc": "让身体高速旋转并撞击对手。速度比对手越慢，威力越大。",
					"detail": "消耗100能量，使出【陀螺球】。让身体高速旋转并撞击对手。速度比对手越慢，威力越大。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "三重攻击",
					"desc": "用３种光线进行攻击。有时会让对手陷入麻痹、灼伤或冰冻的状态。",
					"detail": "消耗100能量，爆发【三重攻击】。用３种光线进行攻击。有时会让对手陷入麻痹、灼伤或冰冻的状态。 对范围内最多3名敌人造成340点伤害，并施加战术压制。",
					"power": 340,
					"target_count": 3,
					"stun_duration": 0.8,
					"vfx": "tri_attack",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "电击",
					"desc": "发出电流刺激对手进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，爆发【电击】！发出电流刺激对手进行攻击。有时会让对手陷入麻痹状态。 对范围内最多3名敌人造成240点伤害，并施加战术压制。",
					"power": 240,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "thundershock",
					"sfx": "thunder",
					"scale": 1.10
				},
				{
					"name": "放电",
					"desc": "用耀眼的电击攻击自己周围所有的宝可梦。有时会陷入麻痹状态。",
					"detail": "消耗100能量，爆发【放电】！用耀眼的电击攻击自己周围所有的宝可梦。有时会陷入麻痹状态。 对范围内最多3名敌人造成360点伤害，并施加战术压制。",
					"power": 360,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "discharge",
					"sfx": "thunder",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "电磁炮",
					"desc": "发射大炮一样的电流进行攻击。让对手陷入麻痹状态。",
					"detail": "消耗100能量，释放终极奥义【电磁炮】！发射大炮一样的电流进行攻击。让对手陷入麻痹状态。 席卷战场对最多6名敌人造成700点巨额伤害与强力击破！",
					"power": 700,
					"target_count": 6,
					"stun_duration": 1.2,
					"vfx": "electro_ball",
					"sfx": "thunder",
					"scale": 0.48
				},
				{
					"name": "高速星星",
					"desc": "发射星形的光攻击对手。攻击必定会命中。",
					"detail": "消耗100能量，释放终极奥义【高速星星】！发射星形的光攻击对手。攻击必定会命中。 席卷战场对最多6名敌人造成480点巨额伤害与强力击破！",
					"power": 480,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "swift",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "打雷",
					"desc": "向对手劈下暴雷进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，释放终极奥义【打雷】！向对手劈下暴雷进行攻击。有时会让对手陷入麻痹状态。 席卷战场对最多6名敌人造成730点巨额伤害与强力击破！",
					"power": 730,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "thunder",
					"sfx": "thunder",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/magneton.png"
	},
	"farfetchd": {
		"id": "farfetchd",
		"name": "大葱鸭",
		"title": "大葱宝可梦",
		"cost": 2,
		"types": ["Normal", "Flying"],
		"hp": 680,
		"atk": 70,
		"armor": 30,
		"mr": 30,
		"range": 1,
		"atk_speed": 0.78,
		"max_mana": 75,
		"desc": "总是随身携带一根品质上乘的大葱，把大葱当作武器如同真正的剑客一般舞动，如果大葱损坏了就会陷入恐慌。",
		"skill_name": "啄",
		"skill_desc": "用尖锐的喙或角刺向对手进行攻击。",
		"skill_detail": "消耗100能量，使出【啄】。用尖锐的喙或角刺向对手进行攻击。 对目标造成178点伤害。",
		"skill_power": 178,
		"basic_attack": {
			"type": "physical",
			"name": "抓击",
			"style": "slash",
			"sfx": "slash"
		},
						"skills": {
			1: [
				{
					"name": "啄",
					"desc": "用尖锐的喙或角刺向对手进行攻击。",
					"detail": "消耗100能量，使出【啄】。用尖锐的喙或角刺向对手进行攻击。 对目标造成178点伤害。",
					"power": 178,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "drill_peck",
					"sfx": "slash",
					"scale": 0.28
				},
				{
					"name": "旋风刀",
					"desc": "制造风之刃，于第２回合攻击对手。容易击中要害。",
					"detail": "消耗100能量，使出【旋风刀】。制造风之刃，于第２回合攻击对手。容易击中要害。 对目标造成260点伤害。",
					"power": 260,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "air_slash",
					"sfx": "slash",
					"scale": 0.82
				},
				{
					"name": "泰山压顶",
					"desc": "用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，使出【泰山压顶】。用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。 对目标造成270点伤害。",
					"power": 270,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "劈开",
					"desc": "用爪子或镰刀等劈开对手进行攻击。容易击中要害。",
					"detail": "消耗100能量，爆发【劈开】。用爪子或镰刀等劈开对手进行攻击。容易击中要害。 对范围内最多3名敌人造成330点伤害，并施加战术压制。",
					"power": 330,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "slash",
					"sfx": "slash",
					"scale": 0.36
				},
				{
					"name": "飞翔",
					"desc": "第１回合飞上天空，第２回合攻击对手。",
					"detail": "消耗100能量，爆发【飞翔】！第１回合飞上天空，第２回合攻击对手。 对范围内最多2名敌人造成390点伤害，并施加战术压制。",
					"power": 390,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "brave_bird",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "神鸟猛击",
					"desc": "第２回合攻击对手。偶尔使对手畏缩。也容易击中要害。",
					"detail": "消耗100能量，爆发【神鸟猛击】！第２回合攻击对手。偶尔使对手畏缩。也容易击中要害。 对范围内最多2名敌人造成540点伤害，并施加战术压制。",
					"power": 540,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "tackle",
					"sfx": "slash",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "叶刃",
					"desc": "像用剑一般操纵叶片切斩对手进行攻击。容易击中要害。",
					"detail": "消耗100能量，释放终极奥义【叶刃】！像用剑一般操纵叶片切斩对手进行攻击。容易击中要害。 席卷战场对最多6名敌人造成655点巨额伤害与强力击破！",
					"power": 655,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "leaf_blade",
					"sfx": "slash",
					"scale": 0.48
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，释放终极奥义【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 席卷战场对最多4名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "舍身冲撞",
					"desc": "拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。",
					"detail": "消耗100能量，释放终极奥义【舍身冲撞】！拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "double_edge",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/farfetchd.png"
	},
	"doduo": {
		"id": "doduo",
		"name": "嘟嘟",
		"title": "双头鸟宝可梦",
		"cost": 1,
		"types": ["Normal", "Flying"],
		"hp": 550,
		"atk": 58,
		"armor": 22,
		"mr": 20,
		"range": 1,
		"atk_speed": 0.8,
		"max_mana": 70,
		"desc": "长有两个脑袋，两只脑袋的大脑通过心灵感应彼此相通。虽然翅膀退化无法飞翔，但双腿奔跑速度可达时速100公里！",
		"skill_name": "啄",
		"skill_desc": "用尖锐的喙或角刺向对手进行攻击。",
		"skill_detail": "消耗100能量，使出【啄】。用尖锐的喙或角刺向对手进行攻击。 对目标造成178点伤害。",
		"skill_power": 178,
		"basic_attack": {
			"type": "physical",
			"name": "撞击",
			"style": "tackle",
			"sfx": "attack"
		},
						"skills": {
			1: [
				{
					"name": "啄",
					"desc": "用尖锐的喙或角刺向对手进行攻击。",
					"detail": "消耗100能量，使出【啄】。用尖锐的喙或角刺向对手进行攻击。 对目标造成178点伤害。",
					"power": 178,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "drill_peck",
					"sfx": "slash",
					"scale": 0.28
				},
				{
					"name": "电光一闪",
					"desc": "以迅雷不及掩耳之势扑向对手。必定能够先制攻击。",
					"detail": "消耗100能量，使出【电光一闪】。以迅雷不及掩耳之势扑向对手。必定能够先制攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "三重攻击",
					"desc": "用３种光线进行攻击。有时会让对手陷入麻痹、灼伤或冰冻的状态。",
					"detail": "消耗100能量，使出【三重攻击】。用３种光线进行攻击。有时会让对手陷入麻痹、灼伤或冰冻的状态。 对目标造成260点伤害。",
					"power": 260,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "tri_attack",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "乱击",
					"desc": "用角或喙刺向对手进行攻击。连续攻击２～５次。",
					"detail": "消耗100能量，爆发【乱击】。用角或喙刺向对手进行攻击。连续攻击２～５次。 对范围内最多3名敌人造成275点伤害，并施加战术压制。",
					"power": 275,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "slash",
					"sfx": "slash",
					"scale": 0.36
				},
				{
					"name": "飞翔",
					"desc": "第１回合飞上天空，第２回合攻击对手。",
					"detail": "消耗100能量，爆发【飞翔】！第１回合飞上天空，第２回合攻击对手。 对范围内最多2名敌人造成390点伤害，并施加战术压制。",
					"power": 390,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "brave_bird",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "猛扑",
					"desc": "全力猛扑对手进行攻击。从而降低对手的攻击。",
					"detail": "消耗100能量，爆发【猛扑】！全力猛扑对手进行攻击。从而降低对手的攻击。 对范围内最多2名敌人造成360点伤害，并施加战术压制。",
					"power": 360,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "舍身冲撞",
					"desc": "拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。",
					"detail": "消耗100能量，释放终极奥义【舍身冲撞】！拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "double_edge",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "飞踢",
					"desc": "使出高高的腾空踢攻击对手。如果踢偏则自己会受到伤害。",
					"detail": "消耗100能量，释放终极奥义【飞踢】！使出高高的腾空踢攻击对手。如果踢偏则自己会受到伤害。 席卷战场对最多4名敌人造成680点巨额伤害与强力击破！",
					"power": 680,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "low_kick",
					"sfx": "punch",
					"scale": 1.55
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，释放终极奥义【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 席卷战场对最多4名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/doduo.png"
	},
	"dodrio": {
		"id": "dodrio",
		"name": "嘟嘟利",
		"title": "三头鸟宝可梦",
		"cost": 3,
		"types": ["Normal", "Flying"],
		"hp": 860,
		"atk": 85,
		"armor": 35,
		"mr": 30,
		"range": 1,
		"atk_speed": 0.9,
		"max_mana": 75,
		"desc": "三个脑袋分别代表喜悦、悲伤与愤怒。三个头交替巡视敌情从不入睡，奔跑在广阔草原上时宛如贴地狂飙的战车！",
		"skill_name": "乱击",
		"skill_desc": "用角或喙刺向对手进行攻击。连续攻击２～５次。",
		"skill_detail": "消耗100能量，使出【乱击】。用角或喙刺向对手进行攻击。连续攻击２～５次。 对目标造成162点伤害。",
		"skill_power": 162,
		"basic_attack": {
			"type": "physical",
			"name": "撞击",
			"style": "tackle",
			"sfx": "attack"
		},
						"skills": {
			1: [
				{
					"name": "乱击",
					"desc": "用角或喙刺向对手进行攻击。连续攻击２～５次。",
					"detail": "消耗100能量，使出【乱击】。用角或喙刺向对手进行攻击。连续攻击２～５次。 对目标造成162点伤害。",
					"power": 162,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "slash",
					"sfx": "slash",
					"scale": 0.28
				},
				{
					"name": "泰山压顶",
					"desc": "用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，使出【泰山压顶】。用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。 对目标造成270点伤害。",
					"power": 270,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "二连击",
					"desc": "使用尾巴等拍打对手进行攻击。连续２次给予伤害。",
					"detail": "消耗100能量，使出【二连击】。使用尾巴等拍打对手进行攻击。连续２次给予伤害。 对目标造成170点伤害。",
					"power": 170,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "三重攻击",
					"desc": "用３种光线进行攻击。有时会让对手陷入麻痹、灼伤或冰冻的状态。",
					"detail": "消耗100能量，爆发【三重攻击】。用３种光线进行攻击。有时会让对手陷入麻痹、灼伤或冰冻的状态。 对范围内最多3名敌人造成340点伤害，并施加战术压制。",
					"power": 340,
					"target_count": 3,
					"stun_duration": 0.8,
					"vfx": "tri_attack",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "飞翔",
					"desc": "第１回合飞上天空，第２回合攻击对手。",
					"detail": "消耗100能量，爆发【飞翔】！第１回合飞上天空，第２回合攻击对手。 对范围内最多2名敌人造成390点伤害，并施加战术压制。",
					"power": 390,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "brave_bird",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，爆发【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 对范围内最多2名敌人造成390点伤害，并施加战术压制。",
					"power": 390,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "啄钻",
					"desc": "一边旋转，一边将尖喙刺入对手进行攻击。",
					"detail": "消耗100能量，释放终极奥义【啄钻】！一边旋转，一边将尖喙刺入对手进行攻击。 席卷战场对最多6名敌人造成640点巨额伤害与强力击破！",
					"power": 640,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "drill_peck",
					"sfx": "slash",
					"scale": 0.48
				},
				{
					"name": "飞踢",
					"desc": "使出高高的腾空踢攻击对手。如果踢偏则自己会受到伤害。",
					"detail": "消耗100能量，释放终极奥义【飞踢】！使出高高的腾空踢攻击对手。如果踢偏则自己会受到伤害。 席卷战场对最多4名敌人造成680点巨额伤害与强力击破！",
					"power": 680,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "low_kick",
					"sfx": "punch",
					"scale": 1.55
				},
				{
					"name": "舍身冲撞",
					"desc": "拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。",
					"detail": "消耗100能量，释放终极奥义【舍身冲撞】！拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "double_edge",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/dodrio.png"
	},
	"seel": {
		"id": "seel",
		"name": "小海狮",
		"title": "海狮宝可梦",
		"cost": 1,
		"types": ["Water"],
		"hp": 620,
		"atk": 48,
		"armor": 30,
		"mr": 35,
		"range": 2,
		"atk_speed": 0.65,
		"max_mana": 80,
		"desc": "覆盖着纯白厚实毛皮的小海狮不怕严寒，头顶突出的尖角极其坚硬，能轻松撞碎厚重的极地浮冰捕食海鱼。",
		"skill_name": "水枪",
		"skill_desc": "向对手猛烈地喷射水流进行攻击。",
		"skill_detail": "消耗100能量，使出【水枪】。向对手猛烈地喷射水流进行攻击。 对目标造成182点伤害。",
		"skill_power": 182,
		"basic_attack": {
			"type": "special",
			"name": "水滴弹",
			"style": "water_bullet",
			"sfx": "water"
		},
						"skills": {
			1: [
				{
					"name": "水枪",
					"desc": "向对手猛烈地喷射水流进行攻击。",
					"detail": "消耗100能量，使出【水枪】。向对手猛烈地喷射水流进行攻击。 对目标造成182点伤害。",
					"power": 182,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "water_gun",
					"sfx": "water",
					"scale": 0.28
				},
				{
					"name": "头锤",
					"desc": "将头伸出，笔直地扑向对手进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，使出【头锤】。将头伸出，笔直地扑向对手进行攻击。有时会使对手畏缩。 对目标造成240点伤害。",
					"power": 240,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "headbutt",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "冰砾",
					"desc": "瞬间制作冰块，快速地扔向对手。必定能够先制攻击。",
					"detail": "消耗100能量，使出【冰砾】。瞬间制作冰块，快速地扔向对手。必定能够先制攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "ice_shard",
					"sfx": "water",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "极光束",
					"desc": "向对手发射虹色光束进行攻击。有时会降低对手的攻击。",
					"detail": "消耗100能量，爆发【极光束】。向对手发射虹色光束进行攻击。有时会降低对手的攻击。 对范围内最多3名敌人造成325点伤害，并施加战术压制。",
					"power": 325,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "aurora_beam",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，爆发【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 对范围内最多2名敌人造成390点伤害，并施加战术压制。",
					"power": 390,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "睡觉",
					"desc": "连续睡上２回合。回复自己的全部ＨＰ以及治愈所有异常状态。",
					"detail": "消耗100能量，爆发【睡觉】！连续睡上２回合。回复自己的全部ＨＰ以及治愈所有异常状态。 对范围内最多3名敌人造成320点伤害，并施加战术压制。",
					"power": 320,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "rest",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "冰冻光束",
					"desc": "向对手发射冰冻光束进行攻击。有时会让对手陷入冰冻状态。",
					"detail": "消耗100能量，释放终极奥义【冰冻光束】！向对手发射冰冻光束进行攻击。有时会让对手陷入冰冻状态。 席卷战场对最多6名敌人造成655点巨额伤害与强力击破！",
					"power": 655,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "ice_beam",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "泰山压顶",
					"desc": "用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，释放终极奥义【泰山压顶】！用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。 席卷战场对最多4名敌人造成605点巨额伤害与强力击破！",
					"power": 605,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "舍身冲撞",
					"desc": "拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。",
					"detail": "消耗100能量，释放终极奥义【舍身冲撞】！拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "double_edge",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/seel.png"
	},
	"dewgong": {
		"id": "dewgong",
		"name": "白海狮",
		"title": "海狮宝可梦",
		"cost": 3,
		"types": ["Water", "Ice"],
		"hp": 980,
		"atk": 70,
		"armor": 45,
		"mr": 55,
		"range": 2,
		"atk_speed": 0.7,
		"max_mana": 85,
		"desc": "全身雪白流线型的身躯在冰冷的海水中优雅游弋，白天在冰山上晒太阳储存热量，夜晚则能在冰海中高速狩猎！",
		"skill_name": "极光束",
		"skill_desc": "向对手发射虹色光束进行攻击。有时会降低对手的攻击。",
		"skill_detail": "消耗100能量，使出【极光束】。向对手发射虹色光束进行攻击。有时会降低对手的攻击。 对目标造成202点伤害。",
		"skill_power": 202,
		"basic_attack": {
			"type": "special",
			"name": "水滴弹",
			"style": "water_bullet",
			"sfx": "water"
		},
						"skills": {
			1: [
				{
					"name": "极光束",
					"desc": "向对手发射虹色光束进行攻击。有时会降低对手的攻击。",
					"detail": "消耗100能量，使出【极光束】。向对手发射虹色光束进行攻击。有时会降低对手的攻击。 对目标造成202点伤害。",
					"power": 202,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "aurora_beam",
					"sfx": "skill",
					"scale": 0.28
				},
				{
					"name": "绝对零度",
					"desc": "给对手一击濒死。如果是冰属性以外的宝可梦使用，就会难以打中。",
					"detail": "消耗100能量，使出【绝对零度】。给对手一击濒死。如果是冰属性以外的宝可梦使用，就会难以打中。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "sheer_cold",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "冰砾",
					"desc": "瞬间制作冰块，快速地扔向对手。必定能够先制攻击。",
					"detail": "消耗100能量，使出【冰砾】。瞬间制作冰块，快速地扔向对手。必定能够先制攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "ice_shard",
					"sfx": "water",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "冰冻光束",
					"desc": "向对手发射冰冻光束进行攻击。有时会让对手陷入冰冻状态。",
					"detail": "消耗100能量，爆发【冰冻光束】。向对手发射冰冻光束进行攻击。有时会让对手陷入冰冻状态。 对范围内最多3名敌人造成350点伤害，并施加战术压制。",
					"power": 350,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "ice_beam",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，爆发【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 对范围内最多2名敌人造成390点伤害，并施加战术压制。",
					"power": 390,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "盐水",
					"desc": "当对手的ＨＰ负伤到一半左右时，招式威力会变成２倍。",
					"detail": "消耗100能量，爆发【盐水】！当对手的ＨＰ负伤到一半左右时，招式威力会变成２倍。 对范围内最多3名敌人造成315点伤害，并施加战术压制。",
					"power": 315,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "water_pulse",
					"sfx": "water",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "暴风雪",
					"desc": "将猛烈的暴风雪刮向对手进行攻击。有时会让对手陷入冰冻状态。",
					"detail": "消耗100能量，释放终极奥义【暴风雪】！将猛烈的暴风雪刮向对手进行攻击。有时会让对手陷入冰冻状态。 席卷战场对最多6名敌人造成685点巨额伤害与强力击破！",
					"power": 685,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "blizzard",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "头锤",
					"desc": "将头伸出，笔直地扑向对手进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，释放终极奥义【头锤】！将头伸出，笔直地扑向对手进行攻击。有时会使对手畏缩。 席卷战场对最多4名敌人造成530点巨额伤害与强力击破！",
					"power": 530,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "headbutt",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "舍身冲撞",
					"desc": "拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。",
					"detail": "消耗100能量，释放终极奥义【舍身冲撞】！拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "double_edge",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/dewgong.png"
	},
	"grimer": {
		"id": "grimer",
		"name": "臭泥",
		"title": "污泥宝可梦",
		"cost": 1,
		"types": ["Poison"],
		"hp": 680,
		"atk": 52,
		"armor": 30,
		"mr": 30,
		"range": 1,
		"atk_speed": 0.6,
		"max_mana": 80,
		"desc": "诞生于受到工厂污水严重污染的烂泥中，喜欢以充满恶臭的垃圾和毒性废液为食，身体黏滑无论穿过什么都会留下毒渍。",
		"skill_name": "拍击",
		"skill_desc": "使用长长的尾巴或手等拍打对手进行攻击。",
		"skill_detail": "消耗100能量，使出【拍击】。使用长长的尾巴或手等拍打对手进行攻击。 对目标造成182点伤害。",
		"skill_power": 182,
		"basic_attack": {
			"type": "physical",
			"name": "撞击",
			"style": "tackle",
			"sfx": "attack"
		},
						"skills": {
			1: [
				{
					"name": "拍击",
					"desc": "使用长长的尾巴或手等拍打对手进行攻击。",
					"detail": "消耗100能量，使出【拍击】。使用长长的尾巴或手等拍打对手进行攻击。 对目标造成182点伤害。",
					"power": 182,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "tackle",
					"sfx": "attack",
					"scale": 0.28
				},
				{
					"name": "掷泥",
					"desc": "向对手的脸等投掷泥块进行攻击。会降低对手的命中率。",
					"detail": "消耗100能量，使出【掷泥】。向对手的脸等投掷泥块进行攻击。会降低对手的命中率。 对目标造成140点伤害。",
					"power": 140,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "mud_slap",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "泥巴射击",
					"desc": "向对手投掷泥块进行攻击。同时降低对手的速度。",
					"detail": "消耗100能量，使出【泥巴射击】。向对手投掷泥块进行攻击。同时降低对手的速度。 对目标造成210点伤害。",
					"power": 210,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "poison_sting",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "污泥攻击",
					"desc": "用污泥投掷对手进行攻击。有时会让对手陷入中毒状态。",
					"detail": "消耗100能量，爆发【污泥攻击】。用污泥投掷对手进行攻击。有时会让对手陷入中毒状态。 对范围内最多3名敌人造成325点伤害，并施加战术压制。",
					"power": 325,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "sludge_bomb",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "泥巴炸弹",
					"desc": "向对手发射坚硬的泥弹进行攻击。有时会降低对手的命中率。",
					"detail": "消耗100能量，爆发【泥巴炸弹】！向对手发射坚硬的泥弹进行攻击。有时会降低对手的命中率。 对范围内最多3名敌人造成315点伤害，并施加战术压制。",
					"power": 315,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "earthquake",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "垃圾射击",
					"desc": "用肮脏的垃圾撞向对手进行攻击。有时会让对手陷入中毒状态。",
					"detail": "消耗100能量，爆发【垃圾射击】！用肮脏的垃圾撞向对手进行攻击。有时会让对手陷入中毒状态。 对范围内最多2名敌人造成480点伤害，并施加战术压制。",
					"power": 480,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "gunk_shot",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "溶化",
					"desc": "通过细胞的变化进行液化，从而大幅提高自己的防御。",
					"detail": "消耗100能量，释放终极奥义【溶化】！通过细胞的变化进行液化，从而大幅提高自己的防御。 席卷战场对最多6名敌人造成600点巨额伤害与强力击破！",
					"power": 600,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "acid_armor",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "泰山压顶",
					"desc": "用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，释放终极奥义【泰山压顶】！用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。 席卷战场对最多4名敌人造成605点巨额伤害与强力击破！",
					"power": 605,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "十万伏特",
					"desc": "向对手发出强力电击进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，释放终极奥义【十万伏特】！向对手发出强力电击进行攻击。有时会让对手陷入麻痹状态。 席卷战场对最多6名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "thunderbolt",
					"sfx": "thunder",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/grimer.png"
	},
	"muk": {
		"id": "muk",
		"name": "臭臭泥",
		"title": "污泥宝可梦",
		"cost": 3,
		"types": ["Poison"],
		"hp": 1150,
		"atk": 76,
		"armor": 45,
		"mr": 45,
		"range": 1,
		"atk_speed": 0.65,
		"max_mana": 85,
		"desc": "身体散发出的强烈恶臭甚至能让周围的花草树木顷刻枯萎死绝，即使只碰到它滴下的一滴体液也会引发严重中毒。",
		"skill_name": "污泥攻击",
		"skill_desc": "用污泥投掷对手进行攻击。有时会让对手陷入中毒状态。",
		"skill_detail": "消耗100能量，使出【污泥攻击】。用污泥投掷对手进行攻击。有时会让对手陷入中毒状态。 对目标造成202点伤害。",
		"skill_power": 202,
		"basic_attack": {
			"type": "physical",
			"name": "撞击",
			"style": "tackle",
			"sfx": "attack"
		},
						"skills": {
			1: [
				{
					"name": "污泥攻击",
					"desc": "用污泥投掷对手进行攻击。有时会让对手陷入中毒状态。",
					"detail": "消耗100能量，使出【污泥攻击】。用污泥投掷对手进行攻击。有时会让对手陷入中毒状态。 对目标造成202点伤害。",
					"power": 202,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "sludge_bomb",
					"sfx": "skill",
					"scale": 0.28
				},
				{
					"name": "拍击",
					"desc": "使用长长的尾巴或手等拍打对手进行攻击。",
					"detail": "消耗100能量，使出【拍击】。使用长长的尾巴或手等拍打对手进行攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "tackle",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "泥巴射击",
					"desc": "向对手投掷泥块进行攻击。同时降低对手的速度。",
					"detail": "消耗100能量，使出【泥巴射击】。向对手投掷泥块进行攻击。同时降低对手的速度。 对目标造成210点伤害。",
					"power": 210,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "mud_slap",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "溶化",
					"desc": "通过细胞的变化进行液化，从而大幅提高自己的防御。",
					"detail": "消耗100能量，爆发【溶化】。通过细胞的变化进行液化，从而大幅提高自己的防御。 对范围内最多3名敌人造成300点伤害，并施加战术压制。",
					"power": 300,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "acid_armor",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "泥巴炸弹",
					"desc": "向对手发射坚硬的泥弹进行攻击。有时会降低对手的命中率。",
					"detail": "消耗100能量，爆发【泥巴炸弹】！向对手发射坚硬的泥弹进行攻击。有时会降低对手的命中率。 对范围内最多3名敌人造成315点伤害，并施加战术压制。",
					"power": 315,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "earthquake",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "泰山压顶",
					"desc": "用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，爆发【泰山压顶】！用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。 对范围内最多2名敌人造成375点伤害，并施加战术压制。",
					"power": 375,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "垃圾射击",
					"desc": "用肮脏的垃圾撞向对手进行攻击。有时会让对手陷入中毒状态。",
					"detail": "消耗100能量，释放终极奥义【垃圾射击】！用肮脏的垃圾撞向对手进行攻击。有时会让对手陷入中毒状态。 席卷战场对最多6名敌人造成700点巨额伤害与强力击破！",
					"power": 700,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "gunk_shot",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "十万伏特",
					"desc": "向对手发出强力电击进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，释放终极奥义【十万伏特】！向对手发出强力电击进行攻击。有时会让对手陷入麻痹状态。 席卷战场对最多6名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "thunderbolt",
					"sfx": "thunder",
					"scale": 1.55
				},
				{
					"name": "打嗝",
					"desc": "朝着对手打嗝，并给予伤害。如果不吃树果则无法使出。",
					"detail": "消耗100能量，释放终极奥义【打嗝】！朝着对手打嗝，并给予伤害。如果不吃树果则无法使出。 席卷战场对最多6名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "poison_sting",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/muk.png"
	},
	"shellder": {
		"id": "shellder",
		"name": "大舌贝",
		"title": "双壳贝宝可梦",
		"cost": 1,
		"types": ["Water"],
		"hp": 580,
		"atk": 45,
		"armor": 50,
		"mr": 25,
		"range": 2,
		"atk_speed": 0.65,
		"max_mana": 75,
		"desc": "坚硬的贝壳能抵御任何强力攻击，但贝壳打开露出柔软本体时是其最脆弱的时刻，伸出大舌头来引诱并夹住猎物。",
		"skill_name": "水枪",
		"skill_desc": "向对手猛烈地喷射水流进行攻击。",
		"skill_detail": "消耗100能量，使出【水枪】。向对手猛烈地喷射水流进行攻击。 对目标造成182点伤害。",
		"skill_power": 182,
		"basic_attack": {
			"type": "special",
			"name": "水滴弹",
			"style": "water_bullet",
			"sfx": "water"
		},
						"skills": {
			1: [
				{
					"name": "水枪",
					"desc": "向对手猛烈地喷射水流进行攻击。",
					"detail": "消耗100能量，使出【水枪】。向对手猛烈地喷射水流进行攻击。 对目标造成182点伤害。",
					"power": 182,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "water_gun",
					"sfx": "water",
					"scale": 0.28
				},
				{
					"name": "撞击",
					"desc": "用整个身体撞向对手进行攻击。",
					"detail": "消耗100能量，使出【撞击】。用整个身体撞向对手进行攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "tackle",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "贝壳夹击",
					"desc": "用非常坚固且厚实的贝壳，在４～５回合内夹住对手进行攻击。",
					"detail": "消耗100能量，使出【贝壳夹击】。用非常坚固且厚实的贝壳，在４～５回合内夹住对手进行攻击。 对目标造成170点伤害。",
					"power": 170,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "water_pulse",
					"sfx": "water",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "极光束",
					"desc": "向对手发射虹色光束进行攻击。有时会降低对手的攻击。",
					"detail": "消耗100能量，爆发【极光束】。向对手发射虹色光束进行攻击。有时会降低对手的攻击。 对范围内最多3名敌人造成325点伤害，并施加战术压制。",
					"power": 325,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "aurora_beam",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，爆发【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 对范围内最多2名敌人造成390点伤害，并施加战术压制。",
					"power": 390,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "舍身冲撞",
					"desc": "拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。",
					"detail": "消耗100能量，爆发【舍身冲撞】！拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。 对范围内最多2名敌人造成480点伤害，并施加战术压制。",
					"power": 480,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "double_edge",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "冰冻光束",
					"desc": "向对手发射冰冻光束进行攻击。有时会让对手陷入冰冻状态。",
					"detail": "消耗100能量，释放终极奥义【冰冻光束】！向对手发射冰冻光束进行攻击。有时会让对手陷入冰冻状态。 席卷战场对最多6名敌人造成655点巨额伤害与强力击破！",
					"power": 655,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "ice_beam",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "冲浪",
					"desc": "利用大浪攻击自己周围所有的宝可梦。",
					"detail": "消耗100能量，释放终极奥义【冲浪】！利用大浪攻击自己周围所有的宝可梦。 席卷战场对最多6名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "surf",
					"sfx": "water",
					"scale": 1.55
				},
				{
					"name": "水炮",
					"desc": "向对手猛烈地喷射大量水流进行攻击。",
					"detail": "消耗100能量，释放终极奥义【水炮】！向对手猛烈地喷射大量水流进行攻击。 席卷战场对最多6名敌人造成730点巨额伤害与强力击破！",
					"power": 730,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "hydro_pump",
					"sfx": "water",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/shellder.png"
	},
	"cloyster": {
		"id": "cloyster",
		"name": "刺甲贝",
		"title": "双壳贝宝可梦",
		"cost": 4,
		"types": ["Water", "Ice"],
		"hp": 1100,
		"atk": 90,
		"armor": 75,
		"mr": 45,
		"range": 2,
		"atk_speed": 0.7,
		"max_mana": 85,
		"desc": "贝壳极其坚硬，即使是用炸药也无法在上面留下一点裂痕。遇到强敌时会连续发射坚硬锐利的黑色尖刺进行反击！",
		"skill_name": "冰锥",
		"skill_desc": "向对手发射锋利的冰柱进行攻击。连续攻击２～５次。",
		"skill_detail": "消耗100能量，使出【冰锥】。向对手发射锋利的冰柱进行攻击。连续攻击２～５次。 对目标造成170点伤害。",
		"skill_power": 170,
		"basic_attack": {
			"type": "special",
			"name": "水滴弹",
			"style": "water_bullet",
			"sfx": "water"
		},
						"skills": {
			1: [
				{
					"name": "冰锥",
					"desc": "向对手发射锋利的冰柱进行攻击。连续攻击２～５次。",
					"detail": "消耗100能量，使出【冰锥】。向对手发射锋利的冰柱进行攻击。连续攻击２～５次。 对目标造成170点伤害。",
					"power": 170,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "icicle_spear",
					"sfx": "skill",
					"scale": 0.28
				},
				{
					"name": "尖刺加农炮",
					"desc": "向对手发射锐针进行攻击。连续攻击２～５次。",
					"detail": "消耗100能量，使出【尖刺加农炮】。向对手发射锐针进行攻击。连续攻击２～５次。 对目标造成140点伤害。",
					"power": 140,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "pin_missile",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "冰柱坠击",
					"desc": "用大冰柱激烈地撞向对手进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，使出【冰柱坠击】。用大冰柱激烈地撞向对手进行攻击。有时会使对手畏缩。 对目标造成270点伤害。",
					"power": 270,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "water_gun",
					"sfx": "water",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "水炮",
					"desc": "向对手猛烈地喷射大量水流进行攻击。",
					"detail": "消耗100能量，爆发【水炮】。向对手猛烈地喷射大量水流进行攻击。 对范围内最多3名敌人造成370点伤害，并施加战术压制。",
					"power": 370,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "hydro_pump",
					"sfx": "water",
					"scale": 0.36
				},
				{
					"name": "冲浪",
					"desc": "利用大浪攻击自己周围所有的宝可梦。",
					"detail": "消耗100能量，爆发【冲浪】！利用大浪攻击自己周围所有的宝可梦。 对范围内最多3名敌人造成390点伤害，并施加战术压制。",
					"power": 390,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "surf",
					"sfx": "water",
					"scale": 1.10
				},
				{
					"name": "蟹钳锤",
					"desc": "用大钳子敲打对手进行攻击。容易击中要害。",
					"detail": "消耗100能量，爆发【蟹钳锤】！用大钳子敲打对手进行攻击。容易击中要害。 对范围内最多2名敌人造成420点伤害，并施加战术压制。",
					"power": 420,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "crabhammer",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "暴风雪",
					"desc": "将猛烈的暴风雪刮向对手进行攻击。有时会让对手陷入冰冻状态。",
					"detail": "消耗100能量，释放终极奥义【暴风雪】！将猛烈的暴风雪刮向对手进行攻击。有时会让对手陷入冰冻状态。 席卷战场对最多6名敌人造成685点巨额伤害与强力击破！",
					"power": 685,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "blizzard",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "加农水炮",
					"desc": "向对手喷射水炮进行攻击。下一回合自己将无法动弹。",
					"detail": "消耗100能量，释放终极奥义【加农水炮】！向对手喷射水炮进行攻击。下一回合自己将无法动弹。 席卷战场对最多6名敌人造成930点巨额伤害与强力击破！",
					"power": 930,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "hydro_cannon",
					"sfx": "water",
					"scale": 1.55
				},
				{
					"name": "极光束",
					"desc": "向对手发射虹色光束进行攻击。有时会降低对手的攻击。",
					"detail": "消耗100能量，释放终极奥义【极光束】！向对手发射虹色光束进行攻击。有时会降低对手的攻击。 席卷战场对最多6名敌人造成505点巨额伤害与强力击破！",
					"power": 505,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "aurora_beam",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/cloyster.png"
	},
	"gastly": {
		"id": "gastly",
		"name": "鬼斯",
		"title": "幽灵宝可梦",
		"cost": 1,
		"types": ["Ghost", "Poison"],
		"hp": 480,
		"atk": 45,
		"armor": 18,
		"mr": 30,
		"range": 2,
		"atk_speed": 0.72,
		"max_mana": 70,
		"desc": "身体的95%都是由气体组成的幽灵，只要被其充满毒气的瓦斯身体包裹住，不管多强壮的生物都会顷刻窒息倒下。",
		"skill_name": "舌舔",
		"skill_desc": "用长长的舌头，舔遍对手进行攻击。有时会让对手陷入麻痹状态。",
		"skill_detail": "消耗100能量，使出【舌舔】。用长长的舌头，舔遍对手进行攻击。有时会让对手陷入麻痹状态。 对目标造成174点伤害。",
		"skill_power": 174,
		"basic_attack": {
			"type": "special",
			"name": "暗影弹",
			"style": "shadow_orb",
			"sfx": "swift"
		},
						"skills": {
			1: [
				{
					"name": "舌舔",
					"desc": "用长长的舌头，舔遍对手进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，使出【舌舔】。用长长的舌头，舔遍对手进行攻击。有时会让对手陷入麻痹状态。 对目标造成174点伤害。",
					"power": 174,
					"target_count": 1,
					"stun_duration": 0.5,
					"vfx": "lick",
					"sfx": "skill",
					"scale": 0.28
				},
				{
					"name": "催眠术",
					"desc": "施以诱导睡意的暗示，让对手陷入睡眠状态。",
					"detail": "消耗100能量，使出【催眠术】。施以诱导睡意的暗示，让对手陷入睡眠状态。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "hypnosis",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "突袭",
					"desc": "可以比对手先攻击。对手使出的招式如果不是攻击招式则会失败。",
					"detail": "消耗100能量，使出【突袭】。可以比对手先攻击。对手使出的招式如果不是攻击招式则会失败。 对目标造成240点伤害。",
					"power": 240,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "mach_punch",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "黑夜魔影",
					"desc": "显示恐怖幻影，只给予对手和自己等级相同的伤害。",
					"detail": "消耗100能量，爆发【黑夜魔影】。显示恐怖幻影，只给予对手和自己等级相同的伤害。 对范围内最多3名敌人造成300点伤害，并施加战术压制。",
					"power": 300,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "night_shade",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "毒液冲击",
					"desc": "将特殊的毒液泼向对手。对处于中毒状态的对手，威力会变成２倍。",
					"detail": "消耗100能量，爆发【毒液冲击】！将特殊的毒液泼向对手。对处于中毒状态的对手，威力会变成２倍。 对范围内最多3名敌人造成315点伤害，并施加战术压制。",
					"power": 315,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "poison_sting",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "恶之波动",
					"desc": "从体内发出充满恶意的恐怖气场。有时会使对手畏缩。",
					"detail": "消耗100能量，爆发【恶之波动】！从体内发出充满恶意的恐怖气场。有时会使对手畏缩。 对范围内最多3名敌人造成360点伤害，并施加战术压制。",
					"power": 360,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "dark_pulse",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "暗影球",
					"desc": "投掷一团黑影进行攻击。有时会降低对手的特防。",
					"detail": "消耗100能量，释放终极奥义【暗影球】！投掷一团黑影进行攻击。有时会降低对手的特防。 席卷战场对最多6名敌人造成640点巨额伤害与强力击破！",
					"power": 640,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "shadow_ball",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "同命",
					"desc": "使出招式后，当受到对手攻击陷入濒死时，对手也会一同濒死。连续使出则会失败。",
					"detail": "消耗100能量，释放终极奥义【同命】！使出招式后，当受到对手攻击陷入濒死时，对手也会一同濒死。连续使出则会失败。 席卷战场对最多6名敌人造成680点巨额伤害与强力击破！",
					"power": 680,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "hex_nightmare",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "终极冲击",
					"desc": "使出自己浑身力量突击对手。下一回合自己将无法动弹。",
					"detail": "消耗100能量，释放终极奥义【终极冲击】！使出自己浑身力量突击对手。下一回合自己将无法动弹。 席卷战场对最多4名敌人造成930点巨额伤害与强力击破！",
					"power": 930,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "giga_impact",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/gastly.png"
	},
	"haunter": {
		"id": "haunter",
		"name": "鬼斯通",
		"title": "气体宝可梦",
		"cost": 2,
		"types": ["Ghost", "Poison"],
		"hp": 660,
		"atk": 62,
		"armor": 25,
		"mr": 35,
		"range": 2,
		"atk_speed": 0.75,
		"max_mana": 75,
		"desc": "身体可以随意穿透墙壁，喜欢潜伏在黑暗阴影中悄悄靠近猎物，用悬浮的两只手掌拍击目标肩膀惊吓对手。",
		"skill_name": "舌舔",
		"skill_desc": "用长长的舌头，舔遍对手进行攻击。有时会让对手陷入麻痹状态。",
		"skill_detail": "消耗100能量，使出【舌舔】。用长长的舌头，舔遍对手进行攻击。有时会让对手陷入麻痹状态。 对目标造成174点伤害。",
		"skill_power": 174,
		"basic_attack": {
			"type": "special",
			"name": "暗影弹",
			"style": "shadow_orb",
			"sfx": "swift"
		},
						"skills": {
			1: [
				{
					"name": "舌舔",
					"desc": "用长长的舌头，舔遍对手进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，使出【舌舔】。用长长的舌头，舔遍对手进行攻击。有时会让对手陷入麻痹状态。 对目标造成174点伤害。",
					"power": 174,
					"target_count": 1,
					"stun_duration": 0.5,
					"vfx": "lick",
					"sfx": "skill",
					"scale": 0.28
				},
				{
					"name": "黑夜魔影",
					"desc": "显示恐怖幻影，只给予对手和自己等级相同的伤害。",
					"detail": "消耗100能量，使出【黑夜魔影】。显示恐怖幻影，只给予对手和自己等级相同的伤害。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "night_shade",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "突袭",
					"desc": "可以比对手先攻击。对手使出的招式如果不是攻击招式则会失败。",
					"detail": "消耗100能量，使出【突袭】。可以比对手先攻击。对手使出的招式如果不是攻击招式则会失败。 对目标造成240点伤害。",
					"power": 240,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "mach_punch",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "暗影拳",
					"desc": "使出混影之拳。攻击必定会命中。",
					"detail": "消耗100能量，爆发【暗影拳】。使出混影之拳。攻击必定会命中。 对范围内最多3名敌人造成320点伤害，并施加战术压制。",
					"power": 320,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "shadow_punch",
					"sfx": "punch",
					"scale": 0.36
				},
				{
					"name": "毒液冲击",
					"desc": "将特殊的毒液泼向对手。对处于中毒状态的对手，威力会变成２倍。",
					"detail": "消耗100能量，爆发【毒液冲击】！将特殊的毒液泼向对手。对处于中毒状态的对手，威力会变成２倍。 对范围内最多3名敌人造成315点伤害，并施加战术压制。",
					"power": 315,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "poison_sting",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "恶之波动",
					"desc": "从体内发出充满恶意的恐怖气场。有时会使对手畏缩。",
					"detail": "消耗100能量，爆发【恶之波动】！从体内发出充满恶意的恐怖气场。有时会使对手畏缩。 对范围内最多3名敌人造成360点伤害，并施加战术压制。",
					"power": 360,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "dark_pulse",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "暗影球",
					"desc": "投掷一团黑影进行攻击。有时会降低对手的特防。",
					"detail": "消耗100能量，释放终极奥义【暗影球】！投掷一团黑影进行攻击。有时会降低对手的特防。 席卷战场对最多6名敌人造成640点巨额伤害与强力击破！",
					"power": 640,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "shadow_ball",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "催眠术",
					"desc": "施以诱导睡意的暗示，让对手陷入睡眠状态。",
					"detail": "消耗100能量，释放终极奥义【催眠术】！施以诱导睡意的暗示，让对手陷入睡眠状态。 席卷战场对最多6名敌人造成680点巨额伤害与强力击破！",
					"power": 680,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "hypnosis",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "同命",
					"desc": "使出招式后，当受到对手攻击陷入濒死时，对手也会一同濒死。连续使出则会失败。",
					"detail": "消耗100能量，释放终极奥义【同命】！使出招式后，当受到对手攻击陷入濒死时，对手也会一同濒死。连续使出则会失败。 席卷战场对最多6名敌人造成680点巨额伤害与强力击破！",
					"power": 680,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "hex_nightmare",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/haunter.png"
	},
	"onix": {
		"id": "onix",
		"name": "大岩蛇",
		"title": "岩蛇宝可梦",
		"cost": 2,
		"types": ["Rock", "Ground"],
		"hp": 900,
		"atk": 58,
		"armor": 65,
		"mr": 25,
		"range": 1,
		"atk_speed": 0.6,
		"max_mana": 85,
		"desc": "在地下以时速80公里的速度高速挖掘前进，巨大的身躯由许多巨型坚岩串联而成，挖掘隧道时会发出轰隆巨响！",
		"skill_name": "绑紧",
		"skill_desc": "使用长长的身体或藤蔓等，在４～５回合内绑紧对手进行攻击。",
		"skill_detail": "消耗100能量，使出【绑紧】。使用长长的身体或藤蔓等，在４～５回合内绑紧对手进行攻击。 对目标造成162点伤害。",
		"skill_power": 162,
		"basic_attack": {
			"type": "physical",
			"name": "撞击",
			"style": "tackle",
			"sfx": "attack"
		},
						"skills": {
			1: [
				{
					"name": "绑紧",
					"desc": "使用长长的身体或藤蔓等，在４～５回合内绑紧对手进行攻击。",
					"detail": "消耗100能量，使出【绑紧】。使用长长的身体或藤蔓等，在４～５回合内绑紧对手进行攻击。 对目标造成162点伤害。",
					"power": 162,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "stone_edge",
					"sfx": "attack",
					"scale": 0.28
				},
				{
					"name": "撞击",
					"desc": "用整个身体撞向对手进行攻击。",
					"detail": "消耗100能量，使出【撞击】。用整个身体撞向对手进行攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "tackle",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "落石",
					"desc": "拿起小岩石，投掷对手进行攻击。",
					"detail": "消耗100能量，使出【落石】。拿起小岩石，投掷对手进行攻击。 对目标造成200点伤害。",
					"power": 200,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "rock_throw",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "岩崩",
					"desc": "将大岩石猛烈地撞向对手进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，爆发【岩崩】。将大岩石猛烈地撞向对手进行攻击。有时会使对手畏缩。 对范围内最多3名敌人造成335点伤害，并施加战术压制。",
					"power": 335,
					"target_count": 3,
					"stun_duration": 0.8,
					"vfx": "rock_slide",
					"sfx": "attack",
					"scale": 0.36
				},
				{
					"name": "陀螺球",
					"desc": "让身体高速旋转并撞击对手。速度比对手越慢，威力越大。",
					"detail": "消耗100能量，爆发【陀螺球】！让身体高速旋转并撞击对手。速度比对手越慢，威力越大。 对范围内最多2名敌人造成320点伤害，并施加战术压制。",
					"power": 320,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，爆发【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 对范围内最多2名敌人造成390点伤害，并施加战术压制。",
					"power": 390,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "地震",
					"desc": "利用地震的冲击，攻击自己周围所有的宝可梦。",
					"detail": "消耗100能量，释放终极奥义【地震】！利用地震的冲击，攻击自己周围所有的宝可梦。 席卷战场对最多6名敌人造成670点巨额伤害与强力击破！",
					"power": 670,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "earthquake",
					"sfx": "attack",
					"scale": 0.48
				},
				{
					"name": "舍身冲撞",
					"desc": "拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。",
					"detail": "消耗100能量，释放终极奥义【舍身冲撞】！拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "double_edge",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "头锤",
					"desc": "将头伸出，笔直地扑向对手进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，释放终极奥义【头锤】！将头伸出，笔直地扑向对手进行攻击。有时会使对手畏缩。 席卷战场对最多4名敌人造成530点巨额伤害与强力击破！",
					"power": 530,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "headbutt",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/onix.png"
	},
	"drowzee": {
		"id": "drowzee",
		"name": "催眠貘",
		"title": "催眠宝可梦",
		"cost": 1,
		"types": ["Psychic"],
		"hp": 600,
		"atk": 46,
		"armor": 25,
		"mr": 35,
		"range": 2,
		"atk_speed": 0.65,
		"max_mana": 75,
		"desc": "传说中食梦貘的后裔，最喜欢吞食人们快乐美妙的梦境，动动长长的鼻子就能知晓对方正在做什么样的梦。",
		"skill_name": "拍击",
		"skill_desc": "使用长长的尾巴或手等拍打对手进行攻击。",
		"skill_detail": "消耗100能量，使出【拍击】。使用长长的尾巴或手等拍打对手进行攻击。 对目标造成182点伤害。",
		"skill_power": 182,
		"basic_attack": {
			"type": "special",
			"name": "念力波",
			"style": "psywave",
			"sfx": "swift"
		},
						"skills": {
			1: [
				{
					"name": "拍击",
					"desc": "使用长长的尾巴或手等拍打对手进行攻击。",
					"detail": "消耗100能量，使出【拍击】。使用长长的尾巴或手等拍打对手进行攻击。 对目标造成182点伤害。",
					"power": 182,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "tackle",
					"sfx": "attack",
					"scale": 0.28
				},
				{
					"name": "催眠术",
					"desc": "施以诱导睡意的暗示，让对手陷入睡眠状态。",
					"detail": "消耗100能量，使出【催眠术】。施以诱导睡意的暗示，让对手陷入睡眠状态。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "hypnosis",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "幻象光线",
					"desc": "向对手发射神奇的光线进行攻击。有时会使对手混乱。",
					"detail": "消耗100能量，使出【幻象光线】。向对手发射神奇的光线进行攻击。有时会使对手混乱。 对目标造成230点伤害。",
					"power": 230,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "psybeam",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "念力",
					"desc": "向对手发送微弱的念力进行攻击。有时会使对手混乱。",
					"detail": "消耗100能量，爆发【念力】。向对手发送微弱的念力进行攻击。有时会使对手混乱。 对范围内最多3名敌人造成310点伤害，并施加战术压制。",
					"power": 310,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "confusion",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "头锤",
					"desc": "将头伸出，笔直地扑向对手进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，爆发【头锤】！将头伸出，笔直地扑向对手进行攻击。有时会使对手畏缩。 对范围内最多2名敌人造成330点伤害，并施加战术压制。",
					"power": 330,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "headbutt",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "食梦",
					"desc": "吃掉正在睡觉的对手的梦进行攻击。回复对手所受到伤害的一半ＨＰ。",
					"detail": "消耗100能量，爆发【食梦】！吃掉正在睡觉的对手的梦进行攻击。回复对手所受到伤害的一半ＨＰ。 对范围内最多3名敌人造成420点伤害，并施加战术压制。",
					"power": 420,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "dream_eater",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "精神强念",
					"desc": "向对手发送强大的念力进行攻击。有时会降低对手的特防。",
					"detail": "消耗100能量，释放终极奥义【精神强念】！向对手发送强大的念力进行攻击。有时会降低对手的特防。 席卷战场对最多6名敌人造成655点巨额伤害与强力击破！",
					"power": 655,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "psychic",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "百万吨重拳",
					"desc": "用充满力量的拳头攻击对手。",
					"detail": "消耗100能量，释放终极奥义【百万吨重拳】！用充满力量的拳头攻击对手。 席卷战场对最多4名敌人造成580点巨额伤害与强力击破！",
					"power": 580,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "mega_punch",
					"sfx": "punch",
					"scale": 1.55
				},
				{
					"name": "精神冲击",
					"desc": "将神奇的念波实体化攻击对手。给予物理伤害。",
					"detail": "消耗100能量，释放终极奥义【精神冲击】！将神奇的念波实体化攻击对手。给予物理伤害。 席卷战场对最多6名敌人造成580点巨额伤害与强力击破！",
					"power": 580,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "psystrike",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/drowzee.png"
	},
	"hypno": {
		"id": "hypno",
		"name": "引梦貘人",
		"title": "催眠宝可梦",
		"cost": 3,
		"types": ["Psychic"],
		"hp": 900,
		"atk": 72,
		"armor": 38,
		"mr": 55,
		"range": 2,
		"atk_speed": 0.7,
		"max_mana": 80,
		"desc": "手里总是悬挂着一枚钟摆般的发光银色圆环，只要目光注视着圆环三秒钟，就会陷入绝对无法醒来的深度催眠。",
		"skill_name": "念力",
		"skill_desc": "向对手发送微弱的念力进行攻击。有时会使对手混乱。",
		"skill_detail": "消耗100能量，使出【念力】。向对手发送微弱的念力进行攻击。有时会使对手混乱。 对目标造成190点伤害。",
		"skill_power": 190,
		"basic_attack": {
			"type": "special",
			"name": "念力波",
			"style": "psywave",
			"sfx": "swift"
		},
						"skills": {
			1: [
				{
					"name": "念力",
					"desc": "向对手发送微弱的念力进行攻击。有时会使对手混乱。",
					"detail": "消耗100能量，使出【念力】。向对手发送微弱的念力进行攻击。有时会使对手混乱。 对目标造成190点伤害。",
					"power": 190,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "confusion",
					"sfx": "skill",
					"scale": 0.28
				},
				{
					"name": "拍击",
					"desc": "使用长长的尾巴或手等拍打对手进行攻击。",
					"detail": "消耗100能量，使出【拍击】。使用长长的尾巴或手等拍打对手进行攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "tackle",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "幻象光线",
					"desc": "向对手发射神奇的光线进行攻击。有时会使对手混乱。",
					"detail": "消耗100能量，使出【幻象光线】。向对手发射神奇的光线进行攻击。有时会使对手混乱。 对目标造成230点伤害。",
					"power": 230,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "psybeam",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "催眠术",
					"desc": "施以诱导睡意的暗示，让对手陷入睡眠状态。",
					"detail": "消耗100能量，爆发【催眠术】。施以诱导睡意的暗示，让对手陷入睡眠状态。 对范围内最多3名敌人造成300点伤害，并施加战术压制。",
					"power": 300,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "hypnosis",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "头锤",
					"desc": "将头伸出，笔直地扑向对手进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，爆发【头锤】！将头伸出，笔直地扑向对手进行攻击。有时会使对手畏缩。 对范围内最多2名敌人造成330点伤害，并施加战术压制。",
					"power": 330,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "headbutt",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "百万吨重拳",
					"desc": "用充满力量的拳头攻击对手。",
					"detail": "消耗100能量，爆发【百万吨重拳】！用充满力量的拳头攻击对手。 对范围内最多2名敌人造成360点伤害，并施加战术压制。",
					"power": 360,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "mega_punch",
					"sfx": "punch",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "精神强念",
					"desc": "向对手发送强大的念力进行攻击。有时会降低对手的特防。",
					"detail": "消耗100能量，释放终极奥义【精神强念】！向对手发送强大的念力进行攻击。有时会降低对手的特防。 席卷战场对最多6名敌人造成655点巨额伤害与强力击破！",
					"power": 655,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "psychic",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "意念头锤",
					"desc": "将思念的力量集中在前额进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，释放终极奥义【意念头锤】！将思念的力量集中在前额进行攻击。有时会使对手畏缩。 席卷战场对最多4名敌人造成580点巨额伤害与强力击破！",
					"power": 580,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "zen_headbutt",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "食梦",
					"desc": "吃掉正在睡觉的对手的梦进行攻击。回复对手所受到伤害的一半ＨＰ。",
					"detail": "消耗100能量，释放终极奥义【食梦】！吃掉正在睡觉的对手的梦进行攻击。回复对手所受到伤害的一半ＨＰ。 席卷战场对最多6名敌人造成680点巨额伤害与强力击破！",
					"power": 680,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "dream_eater",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/hypno.png"
	},
	"krabby": {
		"id": "krabby",
		"name": "大钳蟹",
		"title": "水蟹宝可梦",
		"cost": 1,
		"types": ["Water"],
		"hp": 540,
		"atk": 62,
		"armor": 38,
		"mr": 20,
		"range": 1,
		"atk_speed": 0.7,
		"max_mana": 70,
		"desc": "在沙滩上挖掘洞穴居住，如果钳子在战斗中折断了也能迅速重新长出，巨大的蟹钳拥有轻易夹断木桩的惊人力量。",
		"skill_name": "泡沫",
		"skill_desc": "向对手用力吹起无数泡泡进行攻击。有时会降低对手的速度。",
		"skill_detail": "消耗100能量，使出【泡沫】。向对手用力吹起无数泡泡进行攻击。有时会降低对手的速度。 对目标造成182点伤害。",
		"skill_power": 182,
		"basic_attack": {
			"type": "physical",
			"name": "撞击",
			"style": "tackle",
			"sfx": "attack"
		},
						"skills": {
			1: [
				{
					"name": "泡沫",
					"desc": "向对手用力吹起无数泡泡进行攻击。有时会降低对手的速度。",
					"detail": "消耗100能量，使出【泡沫】。向对手用力吹起无数泡泡进行攻击。有时会降低对手的速度。 对目标造成182点伤害。",
					"power": 182,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "bubble_beam",
					"sfx": "water",
					"scale": 0.28
				},
				{
					"name": "水枪",
					"desc": "向对手猛烈地喷射水流进行攻击。",
					"detail": "消耗100能量，使出【水枪】。向对手猛烈地喷射水流进行攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "water_gun",
					"sfx": "water",
					"scale": 0.82
				},
				{
					"name": "泡沫光线",
					"desc": "向对手猛烈地喷射泡沫进行攻击。有时会降低对手的速度。",
					"detail": "消耗100能量，使出【泡沫光线】。向对手猛烈地喷射泡沫进行攻击。有时会降低对手的速度。 对目标造成230点伤害。",
					"power": 230,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "water_pulse",
					"sfx": "water",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "夹住",
					"desc": "将对手从两侧夹住，给予伤害。",
					"detail": "消耗100能量，爆发【夹住】。将对手从两侧夹住，给予伤害。 对范围内最多3名敌人造成315点伤害，并施加战术压制。",
					"power": 315,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "crabhammer",
					"sfx": "slash",
					"scale": 0.36
				},
				{
					"name": "踩踏",
					"desc": "用大脚踩踏对手进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，爆发【踩踏】！用大脚踩踏对手进行攻击。有时会使对手畏缩。 对范围内最多2名敌人造成315点伤害，并施加战术压制。",
					"power": 315,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "居合斩",
					"desc": "用镰刀或爪子等切斩对手进行攻击。",
					"detail": "消耗100能量，爆发【居合斩】！用镰刀或爪子等切斩对手进行攻击。 对范围内最多2名敌人造成270点伤害，并施加战术压制。",
					"power": 270,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "slash",
					"sfx": "slash",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "冲浪",
					"desc": "利用大浪攻击自己周围所有的宝可梦。",
					"detail": "消耗100能量，释放终极奥义【冲浪】！利用大浪攻击自己周围所有的宝可梦。 席卷战场对最多6名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "surf",
					"sfx": "water",
					"scale": 1.55
				},
				{
					"name": "泰山压顶",
					"desc": "用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，释放终极奥义【泰山压顶】！用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。 席卷战场对最多4名敌人造成605点巨额伤害与强力击破！",
					"power": 605,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，释放终极奥义【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 席卷战场对最多4名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/krabby.png"
	},
	"kingler": {
		"id": "kingler",
		"name": "巨钳蟹",
		"title": "剪刀宝可梦",
		"cost": 3,
		"types": ["Water"],
		"hp": 880,
		"atk": 94,
		"armor": 55,
		"mr": 30,
		"range": 1,
		"atk_speed": 0.75,
		"max_mana": 75,
		"desc": "巨大的左钳重达一万马力，威力大得惊人，虽然由于过重行动有些笨拙，但只要挥舞起来就能粉碎坚固的钢铁战舰！",
		"skill_name": "踩踏",
		"skill_desc": "用大脚踩踏对手进行攻击。有时会使对手畏缩。",
		"skill_detail": "消耗100能量，使出【踩踏】。用大脚踩踏对手进行攻击。有时会使对手畏缩。 对目标造成202点伤害。",
		"skill_power": 202,
		"basic_attack": {
			"type": "physical",
			"name": "撞击",
			"style": "tackle",
			"sfx": "attack"
		},
						"skills": {
			1: [
				{
					"name": "踩踏",
					"desc": "用大脚踩踏对手进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，使出【踩踏】。用大脚踩踏对手进行攻击。有时会使对手畏缩。 对目标造成202点伤害。",
					"power": 202,
					"target_count": 1,
					"stun_duration": 0.5,
					"vfx": "body_slam",
					"sfx": "attack",
					"scale": 0.28
				},
				{
					"name": "泡沫",
					"desc": "向对手用力吹起无数泡泡进行攻击。有时会降低对手的速度。",
					"detail": "消耗100能量，使出【泡沫】。向对手用力吹起无数泡泡进行攻击。有时会降低对手的速度。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "bubble_beam",
					"sfx": "water",
					"scale": 0.82
				},
				{
					"name": "居合斩",
					"desc": "用镰刀或爪子等切斩对手进行攻击。",
					"detail": "消耗100能量，使出【居合斩】。用镰刀或爪子等切斩对手进行攻击。 对目标造成200点伤害。",
					"power": 200,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "slash",
					"sfx": "slash",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "蟹钳锤",
					"desc": "用大钳子敲打对手进行攻击。容易击中要害。",
					"detail": "消耗100能量，爆发【蟹钳锤】。用大钳子敲打对手进行攻击。容易击中要害。 对范围内最多3名敌人造成360点伤害，并施加战术压制。",
					"power": 360,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "crabhammer",
					"sfx": "water",
					"scale": 0.36
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，爆发【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 对范围内最多2名敌人造成390点伤害，并施加战术压制。",
					"power": 390,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "摔打",
					"desc": "使用长长的尾巴或藤蔓等摔打对手进行攻击。",
					"detail": "消耗100能量，爆发【摔打】！使用长长的尾巴或藤蔓等摔打对手进行攻击。 对范围内最多2名敌人造成360点伤害，并施加战术压制。",
					"power": 360,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "water_gun",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "断头钳",
					"desc": "用大钳子或剪刀等夹断对手进行攻击。只要命中就会一击濒死。",
					"detail": "消耗100能量，释放终极奥义【断头钳】！用大钳子或剪刀等夹断对手进行攻击。只要命中就会一击濒死。 席卷战场对最多6名敌人造成600点巨额伤害与强力击破！",
					"power": 600,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "giga_impact",
					"sfx": "slash",
					"scale": 0.48
				},
				{
					"name": "舍身冲撞",
					"desc": "拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。",
					"detail": "消耗100能量，释放终极奥义【舍身冲撞】！拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "double_edge",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "盐水",
					"desc": "当对手的ＨＰ负伤到一半左右时，招式威力会变成２倍。",
					"detail": "消耗100能量，释放终极奥义【盐水】！当对手的ＨＰ负伤到一半左右时，招式威力会变成２倍。 席卷战场对最多6名敌人造成505点巨额伤害与强力击破！",
					"power": 505,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "water_pulse",
					"sfx": "water",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/kingler.png"
	},
	"voltorb": {
		"id": "voltorb",
		"name": "霹雳电球",
		"title": "球宝可梦",
		"cost": 1,
		"types": ["Electric"],
		"hp": 520,
		"atk": 50,
		"armor": 25,
		"mr": 25,
		"range": 2,
		"atk_speed": 0.78,
		"max_mana": 70,
		"desc": "外形极其酷似红白精灵球，真实身份成谜。只要受到极小的刺激或惊吓，就会毫不犹豫地在瞬间引发强力自爆！",
		"skill_name": "电击",
		"skill_desc": "发出电流刺激对手进行攻击。有时会让对手陷入麻痹状态。",
		"skill_detail": "消耗100能量，使出【电击】。发出电流刺激对手进行攻击。有时会让对手陷入麻痹状态。 对目标造成182点伤害。",
		"skill_power": 182,
		"basic_attack": {
			"type": "special",
			"name": "电火花",
			"style": "spark",
			"sfx": "spark"
		},
						"skills": {
			1: [
				{
					"name": "电击",
					"desc": "发出电流刺激对手进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，使出【电击】。发出电流刺激对手进行攻击。有时会让对手陷入麻痹状态。 对目标造成182点伤害。",
					"power": 182,
					"target_count": 1,
					"stun_duration": 0.5,
					"vfx": "thundershock",
					"sfx": "spark",
					"scale": 0.28
				},
				{
					"name": "撞击",
					"desc": "用整个身体撞向对手进行攻击。",
					"detail": "消耗100能量，使出【撞击】。用整个身体撞向对手进行攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "tackle",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "电球",
					"desc": "用电气团撞向对手。自己比对手速度越快，威力越大。",
					"detail": "消耗100能量，使出【电球】。用电气团撞向对手。自己比对手速度越快，威力越大。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "electro_ball",
					"sfx": "thunder",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "电光",
					"desc": "让电流覆盖全身，猛撞向对手进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，爆发【电光】。让电流覆盖全身，猛撞向对手进行攻击。有时会让对手陷入麻痹状态。 对范围内最多3名敌人造成325点伤害，并施加战术压制。",
					"power": 325,
					"target_count": 3,
					"stun_duration": 0.8,
					"vfx": "spark",
					"sfx": "spark",
					"scale": 0.36
				},
				{
					"name": "自爆",
					"desc": "引发爆炸，攻击自己周围所有的宝可梦。使用后陷入濒死。",
					"detail": "消耗100能量，爆发【自爆】！引发爆炸，攻击自己周围所有的宝可梦。使用后陷入濒死。 对范围内最多2名敌人造成720点伤害，并施加战术压制。",
					"power": 720,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "fire_blast",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "陀螺球",
					"desc": "让身体高速旋转并撞击对手。速度比对手越慢，威力越大。",
					"detail": "消耗100能量，爆发【陀螺球】！让身体高速旋转并撞击对手。速度比对手越慢，威力越大。 对范围内最多2名敌人造成320点伤害，并施加战术压制。",
					"power": 320,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "十万伏特",
					"desc": "向对手发出强力电击进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，释放终极奥义【十万伏特】！向对手发出强力电击进行攻击。有时会让对手陷入麻痹状态。 席卷战场对最多6名敌人造成655点巨额伤害与强力击破！",
					"power": 655,
					"target_count": 6,
					"stun_duration": 1.2,
					"vfx": "thunderbolt",
					"sfx": "thunder",
					"scale": 0.48
				},
				{
					"name": "放电",
					"desc": "用耀眼的电击攻击自己周围所有的宝可梦。有时会陷入麻痹状态。",
					"detail": "消耗100能量，释放终极奥义【放电】！用耀眼的电击攻击自己周围所有的宝可梦。有时会陷入麻痹状态。 席卷战场对最多6名敌人造成580点巨额伤害与强力击破！",
					"power": 580,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "discharge",
					"sfx": "thunder",
					"scale": 1.55
				},
				{
					"name": "光墙",
					"desc": "利用神奇的墙壁，在５回合内减弱从对手那里受到的特殊攻击的伤害。",
					"detail": "消耗100能量，释放终极奥义【光墙】！利用神奇的墙壁，在５回合内减弱从对手那里受到的特殊攻击的伤害。 席卷战场对最多6名敌人造成680点巨额伤害与强力击破！",
					"power": 680,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "light_screen",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/voltorb.png"
	},
	"electrode": {
		"id": "electrode",
		"name": "顽皮雷弹",
		"title": "球宝可梦",
		"cost": 3,
		"types": ["Electric"],
		"hp": 850,
		"atk": 74,
		"armor": 38,
		"mr": 38,
		"range": 2,
		"atk_speed": 0.9,
		"max_mana": 75,
		"desc": "吃下的电能越多奔跑速度就越快。体内储存了过于庞大的暴烈电流，稍有不慎甚至吹过一阵强风都会导致轰然大爆炸！",
		"skill_name": "电光",
		"skill_desc": "让电流覆盖全身，猛撞向对手进行攻击。有时会让对手陷入麻痹状态。",
		"skill_detail": "消耗100能量，使出【电光】。让电流覆盖全身，猛撞向对手进行攻击。有时会让对手陷入麻痹状态。 对目标造成202点伤害。",
		"skill_power": 202,
		"basic_attack": {
			"type": "special",
			"name": "电火花",
			"style": "spark",
			"sfx": "spark"
		},
						"skills": {
			1: [
				{
					"name": "电光",
					"desc": "让电流覆盖全身，猛撞向对手进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，使出【电光】。让电流覆盖全身，猛撞向对手进行攻击。有时会让对手陷入麻痹状态。 对目标造成202点伤害。",
					"power": 202,
					"target_count": 1,
					"stun_duration": 0.5,
					"vfx": "spark",
					"sfx": "spark",
					"scale": 0.28
				},
				{
					"name": "撞击",
					"desc": "用整个身体撞向对手进行攻击。",
					"detail": "消耗100能量，使出【撞击】。用整个身体撞向对手进行攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "tackle",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "电球",
					"desc": "用电气团撞向对手。自己比对手速度越快，威力越大。",
					"detail": "消耗100能量，使出【电球】。用电气团撞向对手。自己比对手速度越快，威力越大。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "electro_ball",
					"sfx": "thunder",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "放电",
					"desc": "用耀眼的电击攻击自己周围所有的宝可梦。有时会陷入麻痹状态。",
					"detail": "消耗100能量，爆发【放电】。用耀眼的电击攻击自己周围所有的宝可梦。有时会陷入麻痹状态。 对范围内最多3名敌人造成340点伤害，并施加战术压制。",
					"power": 340,
					"target_count": 3,
					"stun_duration": 0.8,
					"vfx": "discharge",
					"sfx": "thunder",
					"scale": 0.36
				},
				{
					"name": "自爆",
					"desc": "引发爆炸，攻击自己周围所有的宝可梦。使用后陷入濒死。",
					"detail": "消耗100能量，爆发【自爆】！引发爆炸，攻击自己周围所有的宝可梦。使用后陷入濒死。 对范围内最多2名敌人造成720点伤害，并施加战术压制。",
					"power": 720,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "rock_throw",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "光墙",
					"desc": "利用神奇的墙壁，在５回合内减弱从对手那里受到的特殊攻击的伤害。",
					"detail": "消耗100能量，爆发【光墙】！利用神奇的墙壁，在５回合内减弱从对手那里受到的特殊攻击的伤害。 对范围内最多3名敌人造成320点伤害，并施加战术压制。",
					"power": 320,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "light_screen",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "十万伏特",
					"desc": "向对手发出强力电击进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，释放终极奥义【十万伏特】！向对手发出强力电击进行攻击。有时会让对手陷入麻痹状态。 席卷战场对最多6名敌人造成655点巨额伤害与强力击破！",
					"power": 655,
					"target_count": 6,
					"stun_duration": 1.2,
					"vfx": "thunderbolt",
					"sfx": "thunder",
					"scale": 0.48
				},
				{
					"name": "高速星星",
					"desc": "发射星形的光攻击对手。攻击必定会命中。",
					"detail": "消耗100能量，释放终极奥义【高速星星】！发射星形的光攻击对手。攻击必定会命中。 席卷战场对最多6名敌人造成480点巨额伤害与强力击破！",
					"power": 480,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "swift",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "镜面反射",
					"desc": "从对手那里受到特殊攻击的伤害将以２倍返还给同一个对手。",
					"detail": "消耗100能量，释放终极奥义【镜面反射】！从对手那里受到特殊攻击的伤害将以２倍返还给同一个对手。 席卷战场对最多6名敌人造成680点巨额伤害与强力击破！",
					"power": 680,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "confusion",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/electrode.png"
	},
	"exeggcute": {
		"id": "exeggcute",
		"name": "蛋蛋",
		"title": "蛋宝可梦",
		"cost": 1,
		"types": ["Grass", "Psychic"],
		"hp": 560,
		"atk": 44,
		"armor": 35,
		"mr": 30,
		"range": 2,
		"atk_speed": 0.62,
		"max_mana": 75,
		"desc": "由六只蛋紧紧聚在一起组成的心灵共同体，通过彼此的心灵感应互相沟通，哪怕偶尔有一只分开了也能很快找到归队。",
		"skill_name": "催眠术",
		"skill_desc": "施以诱导睡意的暗示，让对手陷入睡眠状态。",
		"skill_detail": "消耗100能量，使出【催眠术】。施以诱导睡意的暗示，让对手陷入睡眠状态。 对目标造成160点伤害。",
		"skill_power": 160,
		"basic_attack": {
			"type": "special",
			"name": "飞叶",
			"style": "leaf",
			"sfx": "swift"
		},
						"skills": {
			1: [
				{
					"name": "催眠术",
					"desc": "施以诱导睡意的暗示，让对手陷入睡眠状态。",
					"detail": "消耗100能量，使出【催眠术】。施以诱导睡意的暗示，让对手陷入睡眠状态。 对目标造成160点伤害。",
					"power": 160,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "hypnosis",
					"sfx": "skill",
					"scale": 0.28
				},
				{
					"name": "投球",
					"desc": "向对手投掷圆形物体进行攻击。连续攻击２～５次。",
					"detail": "消耗100能量，使出【投球】。向对手投掷圆形物体进行攻击。连续攻击２～５次。 对目标造成130点伤害。",
					"power": 130,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "种子机关枪",
					"desc": "向对手猛烈地发射种子进行攻击。连续攻击２～５次。",
					"detail": "消耗100能量，使出【种子机关枪】。向对手猛烈地发射种子进行攻击。连续攻击２～５次。 对目标造成150点伤害。",
					"power": 150,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "seed_bomb",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "念力",
					"desc": "向对手发送微弱的念力进行攻击。有时会使对手混乱。",
					"detail": "消耗100能量，爆发【念力】。向对手发送微弱的念力进行攻击。有时会使对手混乱。 对范围内最多3名敌人造成310点伤害，并施加战术压制。",
					"power": 310,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "confusion",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "幻象光线",
					"desc": "向对手发射神奇的光线进行攻击。有时会使对手混乱。",
					"detail": "消耗100能量，爆发【幻象光线】！向对手发射神奇的光线进行攻击。有时会使对手混乱。 对范围内最多3名敌人造成315点伤害，并施加战术压制。",
					"power": 315,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "psybeam",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "反射壁",
					"desc": "利用神奇的墙壁，在５回合内减弱从对手那里受到的物理攻击的伤害。",
					"detail": "消耗100能量，爆发【反射壁】！利用神奇的墙壁，在５回合内减弱从对手那里受到的物理攻击的伤害。 对范围内最多3名敌人造成320点伤害，并施加战术压制。",
					"power": 320,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "reflect",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "精神强念",
					"desc": "向对手发送强大的念力进行攻击。有时会降低对手的特防。",
					"detail": "消耗100能量，释放终极奥义【精神强念】！向对手发送强大的念力进行攻击。有时会降低对手的特防。 席卷战场对最多6名敌人造成655点巨额伤害与强力击破！",
					"power": 655,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "psychic",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "终极吸取",
					"desc": "吸取对手的养分进行攻击。可以回复给予对手伤害的一半ＨＰ。",
					"detail": "消耗100能量，释放终极奥义【终极吸取】！吸取对手的养分进行攻击。可以回复给予对手伤害的一半ＨＰ。 席卷战场对最多6名敌人造成555点巨额伤害与强力击破！",
					"power": 555,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "leech_seed",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "日光束",
					"desc": "第１回合收集满满的日光，第２回合发射光束进行攻击。",
					"detail": "消耗100能量，释放终极奥义【日光束】！第１回合收集满满的日光，第２回合发射光束进行攻击。 席卷战场对最多6名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "solar_beam",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/exeggcute.png"
	},
	"exeggutor": {
		"id": "exeggutor",
		"name": "椰蛋树",
		"title": "椰子宝可梦",
		"cost": 4,
		"types": ["Grass", "Psychic"],
		"hp": 1150,
		"atk": 88,
		"armor": 50,
		"mr": 48,
		"range": 2,
		"atk_speed": 0.68,
		"max_mana": 85,
		"desc": "三个椰子脑袋各自拥有独立思考的大脑，阳光越充足三个头就笑得越欢，被称为行走的热带雨林之神！",
		"skill_name": "种子机关枪",
		"skill_desc": "向对手猛烈地发射种子进行攻击。连续攻击２～５次。",
		"skill_detail": "消耗100能量，使出【种子机关枪】。向对手猛烈地发射种子进行攻击。连续攻击２～５次。 对目标造成170点伤害。",
		"skill_power": 170,
		"basic_attack": {
			"type": "special",
			"name": "飞叶",
			"style": "leaf",
			"sfx": "swift"
		},
						"skills": {
			1: [
				{
					"name": "种子机关枪",
					"desc": "向对手猛烈地发射种子进行攻击。连续攻击２～５次。",
					"detail": "消耗100能量，使出【种子机关枪】。向对手猛烈地发射种子进行攻击。连续攻击２～５次。 对目标造成170点伤害。",
					"power": 170,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "seed_bomb",
					"sfx": "slash",
					"scale": 0.28
				},
				{
					"name": "踩踏",
					"desc": "用大脚踩踏对手进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，使出【踩踏】。用大脚踩踏对手进行攻击。有时会使对手畏缩。 对目标造成230点伤害。",
					"power": 230,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "精神冲击",
					"desc": "将神奇的念波实体化攻击对手。给予物理伤害。",
					"detail": "消耗100能量，使出【精神冲击】。将神奇的念波实体化攻击对手。给予物理伤害。 对目标造成260点伤害。",
					"power": 260,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "psystrike",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "精神强念",
					"desc": "向对手发送强大的念力进行攻击。有时会降低对手的特防。",
					"detail": "消耗100能量，爆发【精神强念】。向对手发送强大的念力进行攻击。有时会降低对手的特防。 对范围内最多3名敌人造成350点伤害，并施加战术压制。",
					"power": 350,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "psychic",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "飞叶快刀",
					"desc": "飞出叶片，切斩对手进行攻击。容易击中要害。",
					"detail": "消耗100能量，爆发【飞叶快刀】！飞出叶片，切斩对手进行攻击。容易击中要害。 对范围内最多2名敌人造成285点伤害，并施加战术压制。",
					"power": 285,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "razor_leaf",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "终极吸取",
					"desc": "吸取对手的养分进行攻击。可以回复给予对手伤害的一半ＨＰ。",
					"detail": "消耗100能量，爆发【终极吸取】！吸取对手的养分进行攻击。可以回复给予对手伤害的一半ＨＰ。 对范围内最多3名敌人造成345点伤害，并施加战术压制。",
					"power": 345,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "leech_seed",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "飞叶风暴",
					"desc": "用尖尖的叶片向对手卷起风暴。使用之后因为反作用力自己的特攻会大幅降低。",
					"detail": "消耗100能量，释放终极奥义【飞叶风暴】！用尖尖的叶片向对手卷起风暴。使用之后因为反作用力自己的特攻会大幅降低。 席卷战场对最多6名敌人造成715点巨额伤害与强力击破！",
					"power": 715,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "petal_dance",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "疯狂植物",
					"desc": "用大树摔打对手进行攻击。下一回合自己将无法动弹。",
					"detail": "消耗100能量，释放终极奥义【疯狂植物】！用大树摔打对手进行攻击。下一回合自己将无法动弹。 席卷战场对最多6名敌人造成930点巨额伤害与强力击破！",
					"power": 930,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "frenzy_plant",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "日光束",
					"desc": "第１回合收集满满的日光，第２回合发射光束进行攻击。",
					"detail": "消耗100能量，释放终极奥义【日光束】！第１回合收集满满的日光，第２回合发射光束进行攻击。 席卷战场对最多6名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "solar_beam",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/exeggutor.png"
	},
	"cubone": {
		"id": "cubone",
		"name": "卡拉卡拉",
		"title": "孤独宝可梦",
		"cost": 1,
		"types": ["Ground"],
		"hp": 580,
		"atk": 54,
		"armor": 35,
		"mr": 25,
		"range": 1,
		"atk_speed": 0.68,
		"max_mana": 75,
		"desc": "头戴着死去的母亲留下的头骨，感到孤独悲伤时会在夜里对着月亮哭泣，手中握着的骨头棒是唯一的寄托与武器。",
		"skill_name": "骨棒",
		"skill_desc": "用手中的骨头殴打对手进行攻击。有时会使对手畏缩。",
		"skill_detail": "消耗100能量，使出【骨棒】。用手中的骨头殴打对手进行攻击。有时会使对手畏缩。 对目标造成202点伤害。",
		"skill_power": 202,
		"basic_attack": {
			"type": "physical",
			"name": "撞击",
			"style": "tackle",
			"sfx": "attack"
		},
						"skills": {
			1: [
				{
					"name": "骨棒",
					"desc": "用手中的骨头殴打对手进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，使出【骨棒】。用手中的骨头殴打对手进行攻击。有时会使对手畏缩。 对目标造成202点伤害。",
					"power": 202,
					"target_count": 1,
					"stun_duration": 0.5,
					"vfx": "bone_rush",
					"sfx": "attack",
					"scale": 0.28
				},
				{
					"name": "掷泥",
					"desc": "向对手的脸等投掷泥块进行攻击。会降低对手的命中率。",
					"detail": "消耗100能量，使出【掷泥】。向对手的脸等投掷泥块进行攻击。会降低对手的命中率。 对目标造成140点伤害。",
					"power": 140,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "mud_slap",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "百万吨重拳",
					"desc": "用充满力量的拳头攻击对手。",
					"detail": "消耗100能量，使出【百万吨重拳】。用充满力量的拳头攻击对手。 对目标造成260点伤害。",
					"power": 260,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "mega_punch",
					"sfx": "punch",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "骨头回力镖",
					"desc": "用手中的骨头投掷对手，来回连续２次给予伤害。",
					"detail": "消耗100能量，爆发【骨头回力镖】。用手中的骨头投掷对手，来回连续２次给予伤害。 对范围内最多3名敌人造成310点伤害，并施加战术压制。",
					"power": 310,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "bonemerang",
					"sfx": "attack",
					"scale": 0.36
				},
				{
					"name": "愤怒",
					"desc": "如果在使出招式后受到攻击的话，会因愤怒的力量而提高攻击。",
					"detail": "消耗100能量，爆发【愤怒】！如果在使出招式后受到攻击的话，会因愤怒的力量而提高攻击。 对范围内最多2名敌人造成180点伤害，并施加战术压制。",
					"power": 180,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "大闹一番",
					"desc": "在２～３回合内，乱打一气地攻击对手。大闹一番后自己会陷入混乱。",
					"detail": "消耗100能量，爆发【大闹一番】！在２～３回合内，乱打一气地攻击对手。大闹一番后自己会陷入混乱。 对范围内最多2名敌人造成480点伤害，并施加战术压制。",
					"power": 480,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "double_edge",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "地震",
					"desc": "利用地震的冲击，攻击自己周围所有的宝可梦。",
					"detail": "消耗100能量，释放终极奥义【地震】！利用地震的冲击，攻击自己周围所有的宝可梦。 席卷战场对最多6名敌人造成670点巨额伤害与强力击破！",
					"power": 670,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "earthquake",
					"sfx": "attack",
					"scale": 0.48
				},
				{
					"name": "百万吨重踢",
					"desc": "使出力大无穷的重踢踢飞对手进行攻击。",
					"detail": "消耗100能量，释放终极奥义【百万吨重踢】！使出力大无穷的重踢踢飞对手进行攻击。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "mega_kick",
					"sfx": "punch",
					"scale": 1.55
				},
				{
					"name": "泰山压顶",
					"desc": "用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，释放终极奥义【泰山压顶】！用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。 席卷战场对最多4名敌人造成605点巨额伤害与强力击破！",
					"power": 605,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/cubone.png"
	},
	"marowak": {
		"id": "marowak",
		"name": "嘎啦嘎啦",
		"title": "骨头宝可梦",
		"cost": 3,
		"types": ["Ground"],
		"hp": 920,
		"atk": 82,
		"armor": 52,
		"mr": 38,
		"range": 1,
		"atk_speed": 0.74,
		"max_mana": 80,
		"desc": "克服了丧母之痛进化后的勇猛战士，手中的骨头经过千锤百炼变得坚硬胜过金刚石，舞动起来如行云流水般致命！",
		"skill_name": "骨棒",
		"skill_desc": "用手中的骨头殴打对手进行攻击。有时会使对手畏缩。",
		"skill_detail": "消耗100能量，使出【骨棒】。用手中的骨头殴打对手进行攻击。有时会使对手畏缩。 对目标造成202点伤害。",
		"skill_power": 202,
		"basic_attack": {
			"type": "physical",
			"name": "撞击",
			"style": "tackle",
			"sfx": "attack"
		},
						"skills": {
			1: [
				{
					"name": "骨棒",
					"desc": "用手中的骨头殴打对手进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，使出【骨棒】。用手中的骨头殴打对手进行攻击。有时会使对手畏缩。 对目标造成202点伤害。",
					"power": 202,
					"target_count": 1,
					"stun_duration": 0.5,
					"vfx": "bone_rush",
					"sfx": "attack",
					"scale": 0.28
				},
				{
					"name": "头锤",
					"desc": "将头伸出，笔直地扑向对手进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，使出【头锤】。将头伸出，笔直地扑向对手进行攻击。有时会使对手畏缩。 对目标造成240点伤害。",
					"power": 240,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "headbutt",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "百万吨重拳",
					"desc": "用充满力量的拳头攻击对手。",
					"detail": "消耗100能量，使出【百万吨重拳】。用充满力量的拳头攻击对手。 对目标造成260点伤害。",
					"power": 260,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "mega_punch",
					"sfx": "punch",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "骨头回力镖",
					"desc": "用手中的骨头投掷对手，来回连续２次给予伤害。",
					"detail": "消耗100能量，爆发【骨头回力镖】。用手中的骨头投掷对手，来回连续２次给予伤害。 对范围内最多3名敌人造成310点伤害，并施加战术压制。",
					"power": 310,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "bonemerang",
					"sfx": "attack",
					"scale": 0.36
				},
				{
					"name": "愤怒",
					"desc": "如果在使出招式后受到攻击的话，会因愤怒的力量而提高攻击。",
					"detail": "消耗100能量，爆发【愤怒】！如果在使出招式后受到攻击的话，会因愤怒的力量而提高攻击。 对范围内最多2名敌人造成180点伤害，并施加战术压制。",
					"power": 180,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "大闹一番",
					"desc": "在２～３回合内，乱打一气地攻击对手。大闹一番后自己会陷入混乱。",
					"detail": "消耗100能量，爆发【大闹一番】！在２～３回合内，乱打一气地攻击对手。大闹一番后自己会陷入混乱。 对范围内最多2名敌人造成480点伤害，并施加战术压制。",
					"power": 480,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "mud_slap",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "地震",
					"desc": "利用地震的冲击，攻击自己周围所有的宝可梦。",
					"detail": "消耗100能量，释放终极奥义【地震】！利用地震的冲击，攻击自己周围所有的宝可梦。 席卷战场对最多6名敌人造成670点巨额伤害与强力击破！",
					"power": 670,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "earthquake",
					"sfx": "attack",
					"scale": 0.48
				},
				{
					"name": "百万吨重踢",
					"desc": "使出力大无穷的重踢踢飞对手进行攻击。",
					"detail": "消耗100能量，释放终极奥义【百万吨重踢】！使出力大无穷的重踢踢飞对手进行攻击。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "mega_kick",
					"sfx": "punch",
					"scale": 1.55
				},
				{
					"name": "舍身冲撞",
					"desc": "拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。",
					"detail": "消耗100能量，释放终极奥义【舍身冲撞】！拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "double_edge",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/marowak.png"
	},
	"hitmonlee": {
		"id": "hitmonlee",
		"name": "飞腿郎",
		"title": "踢腿宝可梦",
		"cost": 3,
		"types": ["Fighting"],
		"hp": 860,
		"atk": 90,
		"armor": 38,
		"mr": 35,
		"range": 1,
		"atk_speed": 0.82,
		"max_mana": 75,
		"desc": "拥有弹簧般自由伸缩的修长强健双腿，能从意想不到的极远距离发动狂暴飞踢，任何坚固的盾牌在其踢击下都会粉碎！",
		"skill_name": "二连踢",
		"skill_desc": "用２只脚踢飞对手进行攻击。连续２次给予伤害。",
		"skill_detail": "消耗100能量，使出【二连踢】。用２只脚踢飞对手进行攻击。连续２次给予伤害。 对目标造成174点伤害。",
		"skill_power": 174,
		"basic_attack": {
			"type": "physical",
			"name": "撞击",
			"style": "tackle",
			"sfx": "attack"
		},
						"skills": {
			1: [
				{
					"name": "二连踢",
					"desc": "用２只脚踢飞对手进行攻击。连续２次给予伤害。",
					"detail": "消耗100能量，使出【二连踢】。用２只脚踢飞对手进行攻击。连续２次给予伤害。 对目标造成174点伤害。",
					"power": 174,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "low_kick",
					"sfx": "punch",
					"scale": 0.28
				},
				{
					"name": "劈瓦",
					"desc": "将手刀猛烈地挥下攻击对手。还可以破坏光墙和反射壁等。",
					"detail": "消耗100能量，使出【劈瓦】。将手刀猛烈地挥下攻击对手。还可以破坏光墙和反射壁等。 对目标造成250点伤害。",
					"power": 250,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "cross_chop",
					"sfx": "punch",
					"scale": 0.82
				},
				{
					"name": "突袭",
					"desc": "可以比对手先攻击。对手使出的招式如果不是攻击招式则会失败。",
					"detail": "消耗100能量，使出【突袭】。可以比对手先攻击。对手使出的招式如果不是攻击招式则会失败。 对目标造成240点伤害。",
					"power": 240,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "mach_punch",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "飞膝踢",
					"desc": "跳起后用膝盖撞对手进行攻击。如果撞偏则自己会受到伤害。",
					"detail": "消耗100能量，爆发【飞膝踢】。跳起后用膝盖撞对手进行攻击。如果撞偏则自己会受到伤害。 对范围内最多3名敌人造成390点伤害，并施加战术压制。",
					"power": 390,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "mega_kick",
					"sfx": "punch",
					"scale": 0.36
				},
				{
					"name": "火焰踢",
					"desc": "攻击对手后，有时会使其陷入灼伤状态。也容易击中要害。",
					"detail": "消耗100能量，爆发【火焰踢】！攻击对手后，有时会使其陷入灼伤状态。也容易击中要害。 对范围内最多2名敌人造成375点伤害，并施加战术压制。",
					"power": 375,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "ember",
					"sfx": "fire",
					"scale": 1.10
				},
				{
					"name": "硬撑",
					"desc": "当自己处于中毒、麻痹、灼伤状态时，向对手使出此招式的话，威力会变成２倍。",
					"detail": "消耗100能量，爆发【硬撑】！当自己处于中毒、麻痹、灼伤状态时，向对手使出此招式的话，威力会变成２倍。 对范围内最多2名敌人造成330点伤害，并施加战术压制。",
					"power": 330,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "近身战",
					"desc": "放弃守护，向对手的怀里突击。自己的防御和特防会降低。",
					"detail": "消耗100能量，释放终极奥义【近身战】！放弃守护，向对手的怀里突击。自己的防御和特防会降低。 席卷战场对最多6名敌人造成700点巨额伤害与强力击破！",
					"power": 700,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "close_combat",
					"sfx": "punch",
					"scale": 0.48
				},
				{
					"name": "百万吨重拳",
					"desc": "用充满力量的拳头攻击对手。",
					"detail": "消耗100能量，释放终极奥义【百万吨重拳】！用充满力量的拳头攻击对手。 席卷战场对最多4名敌人造成580点巨额伤害与强力击破！",
					"power": 580,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "mega_punch",
					"sfx": "punch",
					"scale": 1.55
				},
				{
					"name": "泰山压顶",
					"desc": "用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，释放终极奥义【泰山压顶】！用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。 席卷战场对最多4名敌人造成605点巨额伤害与强力击破！",
					"power": 605,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/hitmonlee.png"
	},
	"hitmonchan": {
		"id": "hitmonchan",
		"name": "快拳郎",
		"title": "拳击宝可梦",
		"cost": 3,
		"types": ["Fighting"],
		"hp": 860,
		"atk": 88,
		"armor": 42,
		"mr": 38,
		"range": 1,
		"atk_speed": 0.85,
		"max_mana": 75,
		"desc": "拥有世界拳击冠军般的坚毅意志，双拳能挥出肉眼无法捕捉的音速刺拳，甚至能一边旋转拳头一边击穿坚硬的混凝土壁！",
		"skill_name": "音速拳",
		"skill_desc": "以迅雷不及掩耳之势出拳。必定能够先制攻击。",
		"skill_detail": "消耗100能量，使出【音速拳】。以迅雷不及掩耳之势出拳。必定能够先制攻击。 对目标造成182点伤害。",
		"skill_power": 182,
		"basic_attack": {
			"type": "physical",
			"name": "连续拳",
			"style": "punch",
			"sfx": "punch"
		},
						"skills": {
			1: [
				{
					"name": "音速拳",
					"desc": "以迅雷不及掩耳之势出拳。必定能够先制攻击。",
					"detail": "消耗100能量，使出【音速拳】。以迅雷不及掩耳之势出拳。必定能够先制攻击。 对目标造成182点伤害。",
					"power": 182,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "mach_punch",
					"sfx": "punch",
					"scale": 0.28
				},
				{
					"name": "连续拳",
					"desc": "用拳头怒涛般的殴打对手进行攻击。连续攻击２～５次。",
					"detail": "消耗100能量，使出【连续拳】。用拳头怒涛般的殴打对手进行攻击。连续攻击２～５次。 对目标造成136点伤害。",
					"power": 136,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "高速星星",
					"desc": "发射星形的光攻击对手。攻击必定会命中。",
					"detail": "消耗100能量，使出【高速星星】。发射星形的光攻击对手。攻击必定会命中。 对目标造成220点伤害。",
					"power": 220,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "swift",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "火焰拳",
					"desc": "用充满火焰的拳头攻击对手。有时会让对手陷入灼伤状态。",
					"detail": "消耗100能量，爆发【火焰拳】。用充满火焰的拳头攻击对手。有时会让对手陷入灼伤状态。 对范围内最多3名敌人造成335点伤害，并施加战术压制。",
					"power": 335,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "fire_punch",
					"sfx": "fire",
					"scale": 0.36
				},
				{
					"name": "冰冻拳",
					"desc": "用充满寒气的拳头攻击对手。有时会让对手陷入冰冻状态。",
					"detail": "消耗100能量，爆发【冰冻拳】！用充满寒气的拳头攻击对手。有时会让对手陷入冰冻状态。 对范围内最多2名敌人造成345点伤害，并施加战术压制。",
					"power": 345,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "ice_punch",
					"sfx": "punch",
					"scale": 1.10
				},
				{
					"name": "百万吨重拳",
					"desc": "用充满力量的拳头攻击对手。",
					"detail": "消耗100能量，爆发【百万吨重拳】！用充满力量的拳头攻击对手。 对范围内最多2名敌人造成360点伤害，并施加战术压制。",
					"power": 360,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "mega_punch",
					"sfx": "punch",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "近身战",
					"desc": "放弃守护，向对手的怀里突击。自己的防御和特防会降低。",
					"detail": "消耗100能量，释放终极奥义【近身战】！放弃守护，向对手的怀里突击。自己的防御和特防会降低。 席卷战场对最多6名敌人造成700点巨额伤害与强力击破！",
					"power": 700,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "close_combat",
					"sfx": "punch",
					"scale": 0.48
				},
				{
					"name": "冲天拳",
					"desc": "用冲向天空般高高的上勾拳顶起对手进行攻击。",
					"detail": "消耗100能量，释放终极奥义【冲天拳】！用冲向天空般高高的上勾拳顶起对手进行攻击。 席卷战场对最多4名敌人造成605点巨额伤害与强力击破！",
					"power": 605,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "low_kick",
					"sfx": "punch",
					"scale": 1.55
				},
				{
					"name": "雷电拳",
					"desc": "用充满电流的拳头攻击对手。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，释放终极奥义【雷电拳】！用充满电流的拳头攻击对手。有时会让对手陷入麻痹状态。 席卷战场对最多4名敌人造成555点巨额伤害与强力击破！",
					"power": 555,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "thunder_punch",
					"sfx": "thunder",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/hitmonchan.png"
	},
	"lickitung": {
		"id": "lickitung",
		"name": "大舌头",
		"title": "舔舐宝可梦",
		"cost": 2,
		"types": ["Normal"],
		"hp": 850,
		"atk": 62,
		"armor": 40,
		"mr": 40,
		"range": 1,
		"atk_speed": 0.65,
		"max_mana": 80,
		"desc": "拥有一条超过身体两倍长的巨型大舌头，舌头上的唾液极度黏腻，能够灵巧地卷起任何远处的物体并吞入腹中。",
		"skill_name": "舌舔",
		"skill_desc": "用长长的舌头，舔遍对手进行攻击。有时会让对手陷入麻痹状态。",
		"skill_detail": "消耗100能量，使出【舌舔】。用长长的舌头，舔遍对手进行攻击。有时会让对手陷入麻痹状态。 对目标造成174点伤害。",
		"skill_power": 174,
		"basic_attack": {
			"type": "physical",
			"name": "撞击",
			"style": "tackle",
			"sfx": "attack"
		},
						"skills": {
			1: [
				{
					"name": "舌舔",
					"desc": "用长长的舌头，舔遍对手进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，使出【舌舔】。用长长的舌头，舔遍对手进行攻击。有时会让对手陷入麻痹状态。 对目标造成174点伤害。",
					"power": 174,
					"target_count": 1,
					"stun_duration": 0.5,
					"vfx": "lick",
					"sfx": "skill",
					"scale": 0.28
				},
				{
					"name": "紧束",
					"desc": "使用长长的身体或藤蔓等，在４～５回合内紧束对手进行攻击。",
					"detail": "消耗100能量，使出【紧束】。使用长长的身体或藤蔓等，在４～５回合内紧束对手进行攻击。 对目标造成130点伤害。",
					"power": 130,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "意念头锤",
					"desc": "将思念的力量集中在前额进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，使出【意念头锤】。将思念的力量集中在前额进行攻击。有时会使对手畏缩。 对目标造成260点伤害。",
					"power": 260,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "zen_headbutt",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "踩踏",
					"desc": "用大脚踩踏对手进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，爆发【踩踏】。用大脚踩踏对手进行攻击。有时会使对手畏缩。 对范围内最多3名敌人造成325点伤害，并施加战术压制。",
					"power": 325,
					"target_count": 3,
					"stun_duration": 0.8,
					"vfx": "body_slam",
					"sfx": "attack",
					"scale": 0.36
				},
				{
					"name": "百万吨重拳",
					"desc": "用充满力量的拳头攻击对手。",
					"detail": "消耗100能量，爆发【百万吨重拳】！用充满力量的拳头攻击对手。 对范围内最多2名敌人造成360点伤害，并施加战术压制。",
					"power": 360,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "mega_punch",
					"sfx": "punch",
					"scale": 1.10
				},
				{
					"name": "居合斩",
					"desc": "用镰刀或爪子等切斩对手进行攻击。",
					"detail": "消耗100能量，爆发【居合斩】！用镰刀或爪子等切斩对手进行攻击。 对范围内最多2名敌人造成270点伤害，并施加战术压制。",
					"power": 270,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "slash",
					"sfx": "slash",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "强力鞭打",
					"desc": "激烈地挥舞青藤或触手摔打对手进行攻击。",
					"detail": "消耗100能量，释放终极奥义【强力鞭打】！激烈地挥舞青藤或触手摔打对手进行攻击。 席卷战场对最多6名敌人造成700点巨额伤害与强力击破！",
					"power": 700,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "power_whip",
					"sfx": "slash",
					"scale": 0.48
				},
				{
					"name": "百万吨重踢",
					"desc": "使出力大无穷的重踢踢飞对手进行攻击。",
					"detail": "消耗100能量，释放终极奥义【百万吨重踢】！使出力大无穷的重踢踢飞对手进行攻击。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "mega_kick",
					"sfx": "punch",
					"scale": 1.55
				},
				{
					"name": "绞紧",
					"desc": "用力勒紧对手进行攻击。对手的HP越多，威力越大。",
					"detail": "消耗100能量，释放终极奥义【绞紧】！用力勒紧对手进行攻击。对手的HP越多，威力越大。 席卷战场对最多6名敌人造成680点巨额伤害与强力击破！",
					"power": 680,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "tackle",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/lickitung.png"
	},
	"koffing": {
		"id": "koffing",
		"name": "瓦斯弹",
		"title": "毒气宝可梦",
		"cost": 1,
		"types": ["Poison"],
		"hp": 550,
		"atk": 48,
		"armor": 35,
		"mr": 25,
		"range": 2,
		"atk_speed": 0.65,
		"max_mana": 70,
		"desc": "薄薄的球状身体内部充斥着高度易燃易爆的剧毒瓦斯，周身的小孔不断向外喷发呛人的毒雾，靠近时极其危险。",
		"skill_name": "毒瓦斯",
		"skill_desc": "将毒瓦斯吹到对手的脸上，从而让对手陷入中毒状态。",
		"skill_detail": "消耗100能量，使出【毒瓦斯】。将毒瓦斯吹到对手的脸上，从而让对手陷入中毒状态。 对目标造成160点伤害。",
		"skill_power": 160,
		"basic_attack": {
			"type": "special",
			"name": "毒液飞弹",
			"style": "water_bullet",
			"sfx": "swift"
		},
						"skills": {
			1: [
				{
					"name": "毒瓦斯",
					"desc": "将毒瓦斯吹到对手的脸上，从而让对手陷入中毒状态。",
					"detail": "消耗100能量，使出【毒瓦斯】。将毒瓦斯吹到对手的脸上，从而让对手陷入中毒状态。 对目标造成160点伤害。",
					"power": 160,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "poison_sting",
					"sfx": "skill",
					"scale": 0.28
				},
				{
					"name": "撞击",
					"desc": "用整个身体撞向对手进行攻击。",
					"detail": "消耗100能量，使出【撞击】。用整个身体撞向对手进行攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "tackle",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "剧毒",
					"desc": "让对手陷入剧毒状态。随着回合的推进，中毒伤害会增加。",
					"detail": "消耗100能量，使出【剧毒】。让对手陷入剧毒状态。随着回合的推进，中毒伤害会增加。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "toxic",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "污泥攻击",
					"desc": "用污泥投掷对手进行攻击。有时会让对手陷入中毒状态。",
					"detail": "消耗100能量，爆发【污泥攻击】。用污泥投掷对手进行攻击。有时会让对手陷入中毒状态。 对范围内最多3名敌人造成325点伤害，并施加战术压制。",
					"power": 325,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "sludge_bomb",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "陀螺球",
					"desc": "让身体高速旋转并撞击对手。速度比对手越慢，威力越大。",
					"detail": "消耗100能量，爆发【陀螺球】！让身体高速旋转并撞击对手。速度比对手越慢，威力越大。 对范围内最多2名敌人造成320点伤害，并施加战术压制。",
					"power": 320,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "自爆",
					"desc": "引发爆炸，攻击自己周围所有的宝可梦。使用后陷入濒死。",
					"detail": "消耗100能量，爆发【自爆】！引发爆炸，攻击自己周围所有的宝可梦。使用后陷入濒死。 对范围内最多2名敌人造成720点伤害，并施加战术压制。",
					"power": 720,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "rock_throw",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "大爆炸",
					"desc": "引发大爆炸，攻击自己周围所有的宝可梦。使用后自己会陷入濒死。",
					"detail": "消耗100能量，释放终极奥义【大爆炸】！引发大爆炸，攻击自己周围所有的宝可梦。使用后自己会陷入濒死。 席卷战场对最多6名敌人造成895点巨额伤害与强力击破！",
					"power": 895,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "fire_blast",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "十万伏特",
					"desc": "向对手发出强力电击进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，释放终极奥义【十万伏特】！向对手发出强力电击进行攻击。有时会让对手陷入麻痹状态。 席卷战场对最多6名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "thunderbolt",
					"sfx": "thunder",
					"scale": 1.55
				},
				{
					"name": "打雷",
					"desc": "向对手劈下暴雷进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，释放终极奥义【打雷】！向对手劈下暴雷进行攻击。有时会让对手陷入麻痹状态。 席卷战场对最多6名敌人造成730点巨额伤害与强力击破！",
					"power": 730,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "thunder",
					"sfx": "thunder",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/koffing.png"
	},
	"weezing": {
		"id": "weezing",
		"name": "双弹瓦斯",
		"title": "毒气宝可梦",
		"cost": 3,
		"types": ["Poison"],
		"hp": 900,
		"atk": 74,
		"armor": 50,
		"mr": 40,
		"range": 2,
		"atk_speed": 0.7,
		"max_mana": 80,
		"desc": "由两个大小不同的瓦斯弹融合而成，双头交替吸入垃圾腐烂的气体并在体内进行混合，能制造出毒性翻倍的致命恶毒之雾！",
		"skill_name": "污泥攻击",
		"skill_desc": "用污泥投掷对手进行攻击。有时会让对手陷入中毒状态。",
		"skill_detail": "消耗100能量，使出【污泥攻击】。用污泥投掷对手进行攻击。有时会让对手陷入中毒状态。 对目标造成202点伤害。",
		"skill_power": 202,
		"basic_attack": {
			"type": "special",
			"name": "毒液飞弹",
			"style": "water_bullet",
			"sfx": "swift"
		},
						"skills": {
			1: [
				{
					"name": "污泥攻击",
					"desc": "用污泥投掷对手进行攻击。有时会让对手陷入中毒状态。",
					"detail": "消耗100能量，使出【污泥攻击】。用污泥投掷对手进行攻击。有时会让对手陷入中毒状态。 对目标造成202点伤害。",
					"power": 202,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "poison_sting",
					"sfx": "skill",
					"scale": 0.28
				},
				{
					"name": "二连击",
					"desc": "使用尾巴等拍打对手进行攻击。连续２次给予伤害。",
					"detail": "消耗100能量，使出【二连击】。使用尾巴等拍打对手进行攻击。连续２次给予伤害。 对目标造成170点伤害。",
					"power": 170,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "恶意追击",
					"desc": "如果此回合内对手已经受到伤害的话，招式威力会变成２倍。",
					"detail": "消耗100能量，使出【恶意追击】。如果此回合内对手已经受到伤害的话，招式威力会变成２倍。 对目标造成220点伤害。",
					"power": 220,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "污泥炸弹",
					"desc": "用污泥投掷对手进行攻击。有时会让对手陷入中毒状态。",
					"detail": "消耗100能量，爆发【污泥炸弹】。用污泥投掷对手进行攻击。有时会让对手陷入中毒状态。 对范围内最多3名敌人造成350点伤害，并施加战术压制。",
					"power": 350,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "sludge_bomb",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "撞击",
					"desc": "用整个身体撞向对手进行攻击。",
					"detail": "消耗100能量，爆发【撞击】！用整个身体撞向对手进行攻击。 对范围内最多2名敌人造成240点伤害，并施加战术压制。",
					"power": 240,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "tackle",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "自爆",
					"desc": "引发爆炸，攻击自己周围所有的宝可梦。使用后陷入濒死。",
					"detail": "消耗100能量，爆发【自爆】！引发爆炸，攻击自己周围所有的宝可梦。使用后陷入濒死。 对范围内最多2名敌人造成720点伤害，并施加战术压制。",
					"power": 720,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "rock_throw",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "大爆炸",
					"desc": "引发大爆炸，攻击自己周围所有的宝可梦。使用后自己会陷入濒死。",
					"detail": "消耗100能量，释放终极奥义【大爆炸】！引发大爆炸，攻击自己周围所有的宝可梦。使用后自己会陷入濒死。 席卷战场对最多6名敌人造成895点巨额伤害与强力击破！",
					"power": 895,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "fire_blast",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "十万伏特",
					"desc": "向对手发出强力电击进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，释放终极奥义【十万伏特】！向对手发出强力电击进行攻击。有时会让对手陷入麻痹状态。 席卷战场对最多6名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "thunderbolt",
					"sfx": "thunder",
					"scale": 1.55
				},
				{
					"name": "打雷",
					"desc": "向对手劈下暴雷进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，释放终极奥义【打雷】！向对手劈下暴雷进行攻击。有时会让对手陷入麻痹状态。 席卷战场对最多6名敌人造成730点巨额伤害与强力击破！",
					"power": 730,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "thunder",
					"sfx": "thunder",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/weezing.png"
	},
	"rhyhorn": {
		"id": "rhyhorn",
		"name": "独角犀牛",
		"title": "尖角宝可梦",
		"cost": 2,
		"types": ["Ground", "Rock"],
		"hp": 850,
		"atk": 68,
		"armor": 55,
		"mr": 25,
		"range": 1,
		"atk_speed": 0.62,
		"max_mana": 85,
		"desc": "脑筋非常简单，一旦开始直线狂奔就很难停下来，即使一头撞上坚固的钢筋混凝土大楼也能将其撞个粉碎！",
		"skill_name": "角撞",
		"skill_desc": "用尖锐的角攻击对手。",
		"skill_detail": "消耗100能量，使出【角撞】。用尖锐的角攻击对手。 对目标造成202点伤害。",
		"skill_power": 202,
		"basic_attack": {
			"type": "physical",
			"name": "撞击",
			"style": "tackle",
			"sfx": "attack"
		},
						"skills": {
			1: [
				{
					"name": "角撞",
					"desc": "用尖锐的角攻击对手。",
					"detail": "消耗100能量，使出【角撞】。用尖锐的角攻击对手。 对目标造成202点伤害。",
					"power": 202,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "body_slam",
					"sfx": "attack",
					"scale": 0.28
				},
				{
					"name": "撞击",
					"desc": "用整个身体撞向对手进行攻击。",
					"detail": "消耗100能量，使出【撞击】。用整个身体撞向对手进行攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "tackle",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "落石",
					"desc": "拿起小岩石，投掷对手进行攻击。",
					"detail": "消耗100能量，使出【落石】。拿起小岩石，投掷对手进行攻击。 对目标造成200点伤害。",
					"power": 200,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "rock_throw",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "岩崩",
					"desc": "将大岩石猛烈地撞向对手进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，爆发【岩崩】。将大岩石猛烈地撞向对手进行攻击。有时会使对手畏缩。 对范围内最多3名敌人造成335点伤害，并施加战术压制。",
					"power": 335,
					"target_count": 3,
					"stun_duration": 0.8,
					"vfx": "rock_slide",
					"sfx": "attack",
					"scale": 0.36
				},
				{
					"name": "角钻",
					"desc": "用旋转的角刺入对手进行攻击。只要命中就会一击濒死。",
					"detail": "消耗100能量，爆发【角钻】！用旋转的角刺入对手进行攻击。只要命中就会一击濒死。 对范围内最多2名敌人造成320点伤害，并施加战术压制。",
					"power": 320,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "drill_peck",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，爆发【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 对范围内最多2名敌人造成390点伤害，并施加战术压制。",
					"power": 390,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "地震",
					"desc": "利用地震的冲击，攻击自己周围所有的宝可梦。",
					"detail": "消耗100能量，释放终极奥义【地震】！利用地震的冲击，攻击自己周围所有的宝可梦。 席卷战场对最多6名敌人造成670点巨额伤害与强力击破！",
					"power": 670,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "earthquake",
					"sfx": "attack",
					"scale": 0.48
				},
				{
					"name": "十万马力",
					"desc": "使出全身力量，猛攻对手。",
					"detail": "消耗100能量，释放终极奥义【十万马力】！使出全身力量，猛攻对手。 席卷战场对最多4名敌人造成655点巨额伤害与强力击破！",
					"power": 655,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "mud_slap",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "终极冲击",
					"desc": "使出自己浑身力量突击对手。下一回合自己将无法动弹。",
					"detail": "消耗100能量，释放终极奥义【终极冲击】！使出自己浑身力量突击对手。下一回合自己将无法动弹。 席卷战场对最多4名敌人造成930点巨额伤害与强力击破！",
					"power": 930,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "giga_impact",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/rhyhorn.png"
	},
	"rhydon": {
		"id": "rhydon",
		"name": "钻角犀兽",
		"title": "钻锥宝可梦",
		"cost": 4,
		"types": ["Ground", "Rock"],
		"hp": 1250,
		"atk": 98,
		"armor": 68,
		"mr": 35,
		"range": 1,
		"atk_speed": 0.68,
		"max_mana": 90,
		"desc": "后肢站立行走的重装战士，头顶的利角能像金刚石钻头一样高速旋转，轻而易举便能钻透坚硬的花岗岩山峰！",
		"skill_name": "岩崩",
		"skill_desc": "将大岩石猛烈地撞向对手进行攻击。有时会使对手畏缩。",
		"skill_detail": "消耗100能量，使出【岩崩】。将大岩石猛烈地撞向对手进行攻击。有时会使对手畏缩。 对目标造成210点伤害。",
		"skill_power": 210,
		"basic_attack": {
			"type": "physical",
			"name": "撞击",
			"style": "tackle",
			"sfx": "attack"
		},
						"skills": {
			1: [
				{
					"name": "岩崩",
					"desc": "将大岩石猛烈地撞向对手进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，使出【岩崩】。将大岩石猛烈地撞向对手进行攻击。有时会使对手畏缩。 对目标造成210点伤害。",
					"power": 210,
					"target_count": 1,
					"stun_duration": 0.5,
					"vfx": "rock_slide",
					"sfx": "attack",
					"scale": 0.28
				},
				{
					"name": "臂锤",
					"desc": "挥舞强力而沉重的拳头，给予对手伤害。自己的速度会降低。",
					"detail": "消耗100能量，使出【臂锤】。挥舞强力而沉重的拳头，给予对手伤害。自己的速度会降低。 对目标造成300点伤害。",
					"power": 300,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "low_kick",
					"sfx": "punch",
					"scale": 0.82
				},
				{
					"name": "落石",
					"desc": "拿起小岩石，投掷对手进行攻击。",
					"detail": "消耗100能量，使出【落石】。拿起小岩石，投掷对手进行攻击。 对目标造成200点伤害。",
					"power": 200,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "rock_throw",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "直冲钻",
					"desc": "像钢钻一样，一边旋转身体一边撞击对手。容易击中要害。",
					"detail": "消耗100能量，爆发【直冲钻】。像钢钻一样，一边旋转身体一边撞击对手。容易击中要害。 对范围内最多3名敌人造成340点伤害，并施加战术压制。",
					"power": 340,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "drill_peck",
					"sfx": "attack",
					"scale": 0.36
				},
				{
					"name": "角撞",
					"desc": "用尖锐的角攻击对手。",
					"detail": "消耗100能量，爆发【角撞】！用尖锐的角攻击对手。 对范围内最多2名敌人造成315点伤害，并施加战术压制。",
					"power": 315,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "headbutt",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，爆发【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 对范围内最多2名敌人造成390点伤害，并施加战术压制。",
					"power": 390,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "地震",
					"desc": "利用地震的冲击，攻击自己周围所有的宝可梦。",
					"detail": "消耗100能量，释放终极奥义【地震】！利用地震的冲击，攻击自己周围所有的宝可梦。 席卷战场对最多6名敌人造成670点巨额伤害与强力击破！",
					"power": 670,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "earthquake",
					"sfx": "attack",
					"scale": 0.48
				},
				{
					"name": "十万马力",
					"desc": "使出全身力量，猛攻对手。",
					"detail": "消耗100能量，释放终极奥义【十万马力】！使出全身力量，猛攻对手。 席卷战场对最多4名敌人造成655点巨额伤害与强力击破！",
					"power": 655,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "mud_slap",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "终极冲击",
					"desc": "使出自己浑身力量突击对手。下一回合自己将无法动弹。",
					"detail": "消耗100能量，释放终极奥义【终极冲击】！使出自己浑身力量突击对手。下一回合自己将无法动弹。 席卷战场对最多4名敌人造成930点巨额伤害与强力击破！",
					"power": 930,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "giga_impact",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/rhydon.png"
	},
	"chansey": {
		"id": "chansey",
		"name": "吉利蛋",
		"title": "蛋宝可梦",
		"cost": 3,
		"types": ["Normal"],
		"hp": 1400,
		"atk": 40,
		"armor": 30,
		"mr": 60,
		"range": 2,
		"atk_speed": 0.65,
		"max_mana": 85,
		"desc": "每天都会下一颗营养极其丰富的美味幸福蛋，会把蛋分享给受伤的宝可梦和人类，心地极度温柔纯洁。",
		"skill_name": "拍击",
		"skill_desc": "使用长长的尾巴或手等拍打对手进行攻击。",
		"skill_detail": "消耗100能量，使出【拍击】。使用长长的尾巴或手等拍打对手进行攻击。 对目标造成182点伤害。",
		"skill_power": 182,
		"basic_attack": {
			"type": "special",
			"name": "魔法弹",
			"style": "spark",
			"sfx": "swift"
		},
						"skills": {
			1: [
				{
					"name": "拍击",
					"desc": "使用长长的尾巴或手等拍打对手进行攻击。",
					"detail": "消耗100能量，使出【拍击】。使用长长的尾巴或手等拍打对手进行攻击。 对目标造成182点伤害。",
					"power": 182,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "tackle",
					"sfx": "attack",
					"scale": 0.28
				},
				{
					"name": "连环巴掌",
					"desc": "用连环巴掌拍打对手进行攻击。连续攻击２～５次。",
					"detail": "消耗100能量，使出【连环巴掌】。用连环巴掌拍打对手进行攻击。连续攻击２～５次。 对目标造成130点伤害。",
					"power": 130,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "投掷",
					"desc": "快速投掷携带的道具进行攻击。根据道具不同，威力和效果会改变。",
					"detail": "消耗100能量，使出【投掷】。快速投掷携带的道具进行攻击。根据道具不同，威力和效果会改变。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "生蛋",
					"desc": "回复自己最大ＨＰ的一半。",
					"detail": "消耗100能量，爆发【生蛋】。回复自己最大ＨＰ的一半。 对范围内最多3名敌人造成300点伤害，并施加战术压制。",
					"power": 300,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "softboiled",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "光墙",
					"desc": "利用神奇的墙壁，在５回合内减弱从对手那里受到的特殊攻击的伤害。",
					"detail": "消耗100能量，爆发【光墙】！利用神奇的墙壁，在５回合内减弱从对手那里受到的特殊攻击的伤害。 对范围内最多3名敌人造成320点伤害，并施加战术压制。",
					"power": 320,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "light_screen",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "舍身冲撞",
					"desc": "拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。",
					"detail": "消耗100能量，爆发【舍身冲撞】！拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。 对范围内最多2名敌人造成480点伤害，并施加战术压制。",
					"power": 480,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "double_edge",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "巨声",
					"desc": "给予对手又吵又响的巨大震动进行攻击。",
					"detail": "消耗100能量，释放终极奥义【巨声】！给予对手又吵又响的巨大震动进行攻击。 席卷战场对最多6名敌人造成655点巨额伤害与强力击破！",
					"power": 655,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "giga_impact",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "百万吨重拳",
					"desc": "用充满力量的拳头攻击对手。",
					"detail": "消耗100能量，释放终极奥义【百万吨重拳】！用充满力量的拳头攻击对手。 席卷战场对最多4名敌人造成580点巨额伤害与强力击破！",
					"power": 580,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "mega_punch",
					"sfx": "punch",
					"scale": 1.55
				},
				{
					"name": "百万吨重踢",
					"desc": "使出力大无穷的重踢踢飞对手进行攻击。",
					"detail": "消耗100能量，释放终极奥义【百万吨重踢】！使出力大无穷的重踢踢飞对手进行攻击。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "mega_kick",
					"sfx": "punch",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/chansey.png"
	},
	"tangela": {
		"id": "tangela",
		"name": "蔓藤怪",
		"title": "藤蔓宝可梦",
		"cost": 2,
		"types": ["Grass"],
		"hp": 780,
		"atk": 56,
		"armor": 45,
		"mr": 35,
		"range": 2,
		"atk_speed": 0.65,
		"max_mana": 75,
		"desc": "全身被无数蓝色粗藤蔓紧紧包裹，真实的面貌至今无人见过，受到攻击时藤蔓会迅速再生并缠绕反制敌人。",
		"skill_name": "吸取",
		"skill_desc": "吸取对手的养分进行攻击。可以回复给予对手伤害的一半ＨＰ。",
		"skill_detail": "消耗100能量，使出【吸取】。吸取对手的养分进行攻击。可以回复给予对手伤害的一半ＨＰ。 对目标造成166点伤害。",
		"skill_power": 166,
		"basic_attack": {
			"type": "special",
			"name": "飞叶",
			"style": "leaf",
			"sfx": "swift"
		},
						"skills": {
			1: [
				{
					"name": "吸取",
					"desc": "吸取对手的养分进行攻击。可以回复给予对手伤害的一半ＨＰ。",
					"detail": "消耗100能量，使出【吸取】。吸取对手的养分进行攻击。可以回复给予对手伤害的一半ＨＰ。 对目标造成166点伤害。",
					"power": 166,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "leech_seed",
					"sfx": "skill",
					"scale": 0.28
				},
				{
					"name": "绑紧",
					"desc": "使用长长的身体或藤蔓等，在４～５回合内绑紧对手进行攻击。",
					"detail": "消耗100能量，使出【绑紧】。使用长长的身体或藤蔓等，在４～５回合内绑紧对手进行攻击。 对目标造成130点伤害。",
					"power": 130,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "stone_edge",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "二连击",
					"desc": "使用尾巴等拍打对手进行攻击。连续２次给予伤害。",
					"detail": "消耗100能量，使出【二连击】。使用尾巴等拍打对手进行攻击。连续２次给予伤害。 对目标造成170点伤害。",
					"power": 170,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "飞叶快刀",
					"desc": "飞出叶片，切斩对手进行攻击。容易击中要害。",
					"detail": "消耗100能量，爆发【飞叶快刀】！飞出叶片，切斩对手进行攻击。容易击中要害。 对范围内最多2名敌人造成285点伤害，并施加战术压制。",
					"power": 285,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "razor_leaf",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "居合斩",
					"desc": "用镰刀或爪子等切斩对手进行攻击。",
					"detail": "消耗100能量，爆发【居合斩】！用镰刀或爪子等切斩对手进行攻击。 对范围内最多2名敌人造成270点伤害，并施加战术压制。",
					"power": 270,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "slash",
					"sfx": "slash",
					"scale": 1.10
				},
				{
					"name": "摔打",
					"desc": "使用长长的尾巴或藤蔓等摔打对手进行攻击。",
					"detail": "消耗100能量，爆发【摔打】！使用长长的尾巴或藤蔓等摔打对手进行攻击。 对范围内最多2名敌人造成360点伤害，并施加战术压制。",
					"power": 360,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "seed_bomb",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "强力鞭打",
					"desc": "激烈地挥舞青藤或触手摔打对手进行攻击。",
					"detail": "消耗100能量，释放终极奥义【强力鞭打】！激烈地挥舞青藤或触手摔打对手进行攻击。 席卷战场对最多6名敌人造成700点巨额伤害与强力击破！",
					"power": 700,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "power_whip",
					"sfx": "slash",
					"scale": 0.48
				},
				{
					"name": "泰山压顶",
					"desc": "用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，释放终极奥义【泰山压顶】！用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。 席卷战场对最多4名敌人造成605点巨额伤害与强力击破！",
					"power": 605,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，释放终极奥义【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 席卷战场对最多4名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/tangela.png"
	},
	"kangaskhan": {
		"id": "kangaskhan",
		"name": "袋兽",
		"title": "亲子宝可梦",
		"cost": 4,
		"types": ["Normal"],
		"hp": 1200,
		"atk": 95,
		"armor": 50,
		"mr": 45,
		"range": 1,
		"atk_speed": 0.78,
		"max_mana": 85,
		"desc": "腹部的育儿袋中抚养着幼崽，为了保护宝宝即使面对再强大的敌人也绝不后退，母子合体攻击默契无间！",
		"skill_name": "连续拳",
		"skill_desc": "用拳头怒涛般的殴打对手进行攻击。连续攻击２～５次。",
		"skill_detail": "消耗100能量，使出【连续拳】。用拳头怒涛般的殴打对手进行攻击。连续攻击２～５次。 对目标造成164点伤害。",
		"skill_power": 164,
		"basic_attack": {
			"type": "physical",
			"name": "连续拳",
			"style": "punch",
			"sfx": "punch"
		},
						"skills": {
			1: [
				{
					"name": "连续拳",
					"desc": "用拳头怒涛般的殴打对手进行攻击。连续攻击２～５次。",
					"detail": "消耗100能量，使出【连续拳】。用拳头怒涛般的殴打对手进行攻击。连续攻击２～５次。 对目标造成164点伤害。",
					"power": 164,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "cross_chop",
					"sfx": "punch",
					"scale": 0.28
				},
				{
					"name": "愤怒",
					"desc": "如果在使出招式后受到攻击的话，会因愤怒的力量而提高攻击。",
					"detail": "消耗100能量，使出【愤怒】。如果在使出招式后受到攻击的话，会因愤怒的力量而提高攻击。 对目标造成140点伤害。",
					"power": 140,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "二连击",
					"desc": "使用尾巴等拍打对手进行攻击。连续２次给予伤害。",
					"detail": "消耗100能量，使出【二连击】。使用尾巴等拍打对手进行攻击。连续２次给予伤害。 对目标造成170点伤害。",
					"power": 170,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "tackle",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "迷昏拳",
					"desc": "有节奏地出拳攻击对手。有时会使对手混乱。",
					"detail": "消耗100能量，爆发【迷昏拳】。有节奏地出拳攻击对手。有时会使对手混乱。 对范围内最多3名敌人造成330点伤害，并施加战术压制。",
					"power": 330,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "dynamic_punch",
					"sfx": "punch",
					"scale": 0.36
				},
				{
					"name": "百万吨重拳",
					"desc": "用充满力量的拳头攻击对手。",
					"detail": "消耗100能量，爆发【百万吨重拳】！用充满力量的拳头攻击对手。 对范围内最多2名敌人造成360点伤害，并施加战术压制。",
					"power": 360,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "mega_punch",
					"sfx": "punch",
					"scale": 1.10
				},
				{
					"name": "咬住",
					"desc": "用尖锐的牙咬住对手进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，爆发【咬住】！用尖锐的牙咬住对手进行攻击。有时会使对手畏缩。 对范围内最多2名敌人造成300点伤害，并施加战术压制。",
					"power": 300,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "bite",
					"sfx": "bite",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "逆鳞",
					"desc": "在２～３回合内，乱打一气地进行攻击。大闹一番后自己会陷入混乱。",
					"detail": "消耗100能量，释放终极奥义【逆鳞】！在２～３回合内，乱打一气地进行攻击。大闹一番后自己会陷入混乱。 席卷战场对最多6名敌人造成700点巨额伤害与强力击破！",
					"power": 700,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "dragon_apocalypse",
					"sfx": "attack",
					"scale": 0.48
				},
				{
					"name": "起死回生",
					"desc": "竭尽全力进行攻击。自己的ＨＰ越少，招式的威力越大。",
					"detail": "消耗100能量，释放终极奥义【起死回生】！竭尽全力进行攻击。自己的ＨＰ越少，招式的威力越大。 席卷战场对最多4名敌人造成680点巨额伤害与强力击破！",
					"power": 680,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "low_kick",
					"sfx": "punch",
					"scale": 1.55
				},
				{
					"name": "珍藏",
					"desc": "当战斗中已学会的招式全部使用过后，才能开始使出珍藏的招式。",
					"detail": "消耗100能量，释放终极奥义【珍藏】！当战斗中已学会的招式全部使用过后，才能开始使出珍藏的招式。 席卷战场对最多4名敌人造成880点巨额伤害与强力击破！",
					"power": 880,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "giga_impact",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/kangaskhan.png"
	},
	"horsea": {
		"id": "horsea",
		"name": "墨海马",
		"title": "龙宝可梦",
		"cost": 1,
		"types": ["Water"],
		"hp": 500,
		"atk": 46,
		"armor": 25,
		"mr": 25,
		"range": 2,
		"atk_speed": 0.72,
		"max_mana": 70,
		"desc": "在珊瑚丛的阴影中建立巢穴，感知到危险时会从口中猛烈喷射出乌黑的墨汁逃之夭夭，拥有龙族的远古血脉潜能。",
		"skill_name": "水枪",
		"skill_desc": "向对手猛烈地喷射水流进行攻击。",
		"skill_detail": "消耗100能量，使出【水枪】。向对手猛烈地喷射水流进行攻击。 对目标造成182点伤害。",
		"skill_power": 182,
		"basic_attack": {
			"type": "special",
			"name": "水滴弹",
			"style": "water_bullet",
			"sfx": "water"
		},
						"skills": {
			1: [
				{
					"name": "水枪",
					"desc": "向对手猛烈地喷射水流进行攻击。",
					"detail": "消耗100能量，使出【水枪】。向对手猛烈地喷射水流进行攻击。 对目标造成182点伤害。",
					"power": 182,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "water_gun",
					"sfx": "water",
					"scale": 0.28
				},
				{
					"name": "剧毒",
					"desc": "让对手陷入剧毒状态。随着回合的推进，中毒伤害会增加。",
					"detail": "消耗100能量，使出【剧毒】。让对手陷入剧毒状态。随着回合的推进，中毒伤害会增加。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "toxic",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "龙息",
					"desc": "将强烈的气息吹向对手进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，使出【龙息】。将强烈的气息吹向对手进行攻击。有时会让对手陷入麻痹状态。 对目标造成220点伤害。",
					"power": 220,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "dragon_breath",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "泡沫光线",
					"desc": "向对手猛烈地喷射泡沫进行攻击。有时会降低对手的速度。",
					"detail": "消耗100能量，爆发【泡沫光线】。向对手猛烈地喷射泡沫进行攻击。有时会降低对手的速度。 对范围内最多3名敌人造成325点伤害，并施加战术压制。",
					"power": 325,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "bubble_beam",
					"sfx": "water",
					"scale": 0.36
				},
				{
					"name": "水炮",
					"desc": "向对手猛烈地喷射大量水流进行攻击。",
					"detail": "消耗100能量，爆发【水炮】！向对手猛烈地喷射大量水流进行攻击。 对范围内最多3名敌人造成450点伤害，并施加战术压制。",
					"power": 450,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "hydro_pump",
					"sfx": "water",
					"scale": 1.10
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，爆发【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 对范围内最多2名敌人造成390点伤害，并施加战术压制。",
					"power": 390,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "龙之波动",
					"desc": "从大大的口中掀起冲击波攻击对手。",
					"detail": "消耗100能量，释放终极奥义【龙之波动】！从大大的口中掀起冲击波攻击对手。 席卷战场对最多6名敌人造成647点巨额伤害与强力击破！",
					"power": 647,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "dragon_pulse",
					"sfx": "water",
					"scale": 0.48
				},
				{
					"name": "舍身冲撞",
					"desc": "拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。",
					"detail": "消耗100能量，释放终极奥义【舍身冲撞】！拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "double_edge",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "水之波动",
					"desc": "用水的震动攻击对手。有时会使对手混乱。",
					"detail": "消耗100能量，释放终极奥义【水之波动】！用水的震动攻击对手。有时会使对手混乱。 席卷战场对最多6名敌人造成480点巨额伤害与强力击破！",
					"power": 480,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "water_pulse",
					"sfx": "water",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/horsea.png"
	},
	"seadra": {
		"id": "seadra",
		"name": "海刺龙",
		"title": "龙宝可梦",
		"cost": 3,
		"types": ["Water"],
		"hp": 850,
		"atk": 75,
		"armor": 45,
		"mr": 40,
		"range": 2,
		"atk_speed": 0.78,
		"max_mana": 75,
		"desc": "周身覆盖着锐利的毒刺，能在急流旋涡中安然睡眠，从嘴里喷射出的水流拥有连大岩石都能穿透的惊人破坏力！",
		"skill_name": "泡沫光线",
		"skill_desc": "向对手猛烈地喷射泡沫进行攻击。有时会降低对手的速度。",
		"skill_detail": "消耗100能量，使出【泡沫光线】。向对手猛烈地喷射泡沫进行攻击。有时会降低对手的速度。 对目标造成202点伤害。",
		"skill_power": 202,
		"basic_attack": {
			"type": "special",
			"name": "水滴弹",
			"style": "water_bullet",
			"sfx": "water"
		},
						"skills": {
			1: [
				{
					"name": "泡沫光线",
					"desc": "向对手猛烈地喷射泡沫进行攻击。有时会降低对手的速度。",
					"detail": "消耗100能量，使出【泡沫光线】。向对手猛烈地喷射泡沫进行攻击。有时会降低对手的速度。 对目标造成202点伤害。",
					"power": 202,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "bubble_beam",
					"sfx": "water",
					"scale": 0.28
				},
				{
					"name": "泡沫",
					"desc": "向对手用力吹起无数泡泡进行攻击。有时会降低对手的速度。",
					"detail": "消耗100能量，使出【泡沫】。向对手用力吹起无数泡泡进行攻击。有时会降低对手的速度。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "water_gun",
					"sfx": "water",
					"scale": 0.82
				},
				{
					"name": "龙息",
					"desc": "将强烈的气息吹向对手进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，使出【龙息】。将强烈的气息吹向对手进行攻击。有时会让对手陷入麻痹状态。 对目标造成220点伤害。",
					"power": 220,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "dragon_breath",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "龙之波动",
					"desc": "从大大的口中掀起冲击波攻击对手。",
					"detail": "消耗100能量，爆发【龙之波动】。从大大的口中掀起冲击波攻击对手。 对范围内最多3名敌人造成345点伤害，并施加战术压制。",
					"power": 345,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "dragon_pulse",
					"sfx": "water",
					"scale": 0.36
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，爆发【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 对范围内最多2名敌人造成390点伤害，并施加战术压制。",
					"power": 390,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "水之波动",
					"desc": "用水的震动攻击对手。有时会使对手混乱。",
					"detail": "消耗100能量，爆发【水之波动】！用水的震动攻击对手。有时会使对手混乱。 对范围内最多3名敌人造成300点伤害，并施加战术压制。",
					"power": 300,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "water_pulse",
					"sfx": "water",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "水炮",
					"desc": "向对手猛烈地喷射大量水流进行攻击。",
					"detail": "消耗100能量，释放终极奥义【水炮】！向对手猛烈地喷射大量水流进行攻击。 席卷战场对最多6名敌人造成685点巨额伤害与强力击破！",
					"power": 685,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "hydro_pump",
					"sfx": "water",
					"scale": 0.48
				},
				{
					"name": "舍身冲撞",
					"desc": "拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。",
					"detail": "消耗100能量，释放终极奥义【舍身冲撞】！拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "double_edge",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "冲浪",
					"desc": "利用大浪攻击自己周围所有的宝可梦。",
					"detail": "消耗100能量，释放终极奥义【冲浪】！利用大浪攻击自己周围所有的宝可梦。 席卷战场对最多6名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "surf",
					"sfx": "water",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/seadra.png"
	},
	"goldeen": {
		"id": "goldeen",
		"name": "角金鱼",
		"title": "金鱼宝可梦",
		"cost": 1,
		"types": ["Water"],
		"hp": 520,
		"atk": 52,
		"armor": 22,
		"mr": 22,
		"range": 1,
		"atk_speed": 0.72,
		"max_mana": 70,
		"desc": "头顶长有一支锋利的尖角，在水中游泳的姿态如同身披华丽丝绸的舞者般优雅，被称为水中的水中皇后。",
		"skill_name": "啄",
		"skill_desc": "用尖锐的喙或角刺向对手进行攻击。",
		"skill_detail": "消耗100能量，使出【啄】。用尖锐的喙或角刺向对手进行攻击。 对目标造成178点伤害。",
		"skill_power": 178,
		"basic_attack": {
			"type": "physical",
			"name": "撞击",
			"style": "tackle",
			"sfx": "attack"
		},
						"skills": {
			1: [
				{
					"name": "啄",
					"desc": "用尖锐的喙或角刺向对手进行攻击。",
					"detail": "消耗100能量，使出【啄】。用尖锐的喙或角刺向对手进行攻击。 对目标造成178点伤害。",
					"power": 178,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "drill_peck",
					"sfx": "slash",
					"scale": 0.28
				},
				{
					"name": "角撞",
					"desc": "用尖锐的角攻击对手。",
					"detail": "消耗100能量，使出【角撞】。用尖锐的角攻击对手。 对目标造成230点伤害。",
					"power": 230,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "乱击",
					"desc": "用角或喙刺向对手进行攻击。连续攻击２～５次。",
					"detail": "消耗100能量，使出【乱击】。用角或喙刺向对手进行攻击。连续攻击２～５次。 对目标造成130点伤害。",
					"power": 130,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "water_gun",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "水之波动",
					"desc": "用水的震动攻击对手。有时会使对手混乱。",
					"detail": "消耗100能量，爆发【水之波动】。用水的震动攻击对手。有时会使对手混乱。 对范围内最多3名敌人造成320点伤害，并施加战术压制。",
					"power": 320,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "water_pulse",
					"sfx": "water",
					"scale": 0.36
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，爆发【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 对范围内最多2名敌人造成390点伤害，并施加战术压制。",
					"power": 390,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "超级角击",
					"desc": "用坚硬且华丽的角狠狠地刺入对手进行攻击。",
					"detail": "消耗100能量，爆发【超级角击】！用坚硬且华丽的角狠狠地刺入对手进行攻击。 对范围内最多2名敌人造成480点伤害，并施加战术压制。",
					"power": 480,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "攀瀑",
					"desc": "以惊人的气势扑向对手。有时会使对手畏缩。",
					"detail": "消耗100能量，释放终极奥义【攀瀑】！以惊人的气势扑向对手。有时会使对手畏缩。 席卷战场对最多6名敌人造成640点巨额伤害与强力击破！",
					"power": 640,
					"target_count": 6,
					"stun_duration": 1.2,
					"vfx": "aqua_tail",
					"sfx": "water",
					"scale": 0.48
				},
				{
					"name": "舍身冲撞",
					"desc": "拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。",
					"detail": "消耗100能量，释放终极奥义【舍身冲撞】！拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "double_edge",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "冲浪",
					"desc": "利用大浪攻击自己周围所有的宝可梦。",
					"detail": "消耗100能量，释放终极奥义【冲浪】！利用大浪攻击自己周围所有的宝可梦。 席卷战场对最多6名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "surf",
					"sfx": "water",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/goldeen.png"
	},
	"seaking": {
		"id": "seaking",
		"name": "金鱼王",
		"title": "金鱼宝可梦",
		"cost": 3,
		"types": ["Water"],
		"hp": 880,
		"atk": 82,
		"armor": 40,
		"mr": 38,
		"range": 1,
		"atk_speed": 0.78,
		"max_mana": 75,
		"desc": "在秋天的繁殖季节，全身会染上艳丽斑斓的红白色彩，雄性会用额头那支坚固的尖角在河底岩石上凿洞筑巢。",
		"skill_name": "水之波动",
		"skill_desc": "用水的震动攻击对手。有时会使对手混乱。",
		"skill_detail": "消耗100能量，使出【水之波动】。用水的震动攻击对手。有时会使对手混乱。 对目标造成198点伤害。",
		"skill_power": 198,
		"basic_attack": {
			"type": "physical",
			"name": "撞击",
			"style": "tackle",
			"sfx": "attack"
		},
						"skills": {
			1: [
				{
					"name": "水之波动",
					"desc": "用水的震动攻击对手。有时会使对手混乱。",
					"detail": "消耗100能量，使出【水之波动】。用水的震动攻击对手。有时会使对手混乱。 对目标造成198点伤害。",
					"power": 198,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "water_pulse",
					"sfx": "water",
					"scale": 0.28
				},
				{
					"name": "啄",
					"desc": "用尖锐的喙或角刺向对手进行攻击。",
					"detail": "消耗100能量，使出【啄】。用尖锐的喙或角刺向对手进行攻击。 对目标造成170点伤害。",
					"power": 170,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "drill_peck",
					"sfx": "slash",
					"scale": 0.82
				},
				{
					"name": "乱击",
					"desc": "用角或喙刺向对手进行攻击。连续攻击２～５次。",
					"detail": "消耗100能量，使出【乱击】。用角或喙刺向对手进行攻击。连续攻击２～５次。 对目标造成130点伤害。",
					"power": 130,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "攀瀑",
					"desc": "以惊人的气势扑向对手。有时会使对手畏缩。",
					"detail": "消耗100能量，爆发【攀瀑】。以惊人的气势扑向对手。有时会使对手畏缩。 对范围内最多3名敌人造成340点伤害，并施加战术压制。",
					"power": 340,
					"target_count": 3,
					"stun_duration": 0.8,
					"vfx": "aqua_tail",
					"sfx": "water",
					"scale": 0.36
				},
				{
					"name": "角撞",
					"desc": "用尖锐的角攻击对手。",
					"detail": "消耗100能量，爆发【角撞】！用尖锐的角攻击对手。 对范围内最多2名敌人造成315点伤害，并施加战术压制。",
					"power": 315,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "headbutt",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "角钻",
					"desc": "用旋转的角刺入对手进行攻击。只要命中就会一击濒死。",
					"detail": "消耗100能量，爆发【角钻】！用旋转的角刺入对手进行攻击。只要命中就会一击濒死。 对范围内最多2名敌人造成320点伤害，并施加战术压制。",
					"power": 320,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "water_gun",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "超级角击",
					"desc": "用坚硬且华丽的角狠狠地刺入对手进行攻击。",
					"detail": "消耗100能量，释放终极奥义【超级角击】！用坚硬且华丽的角狠狠地刺入对手进行攻击。 席卷战场对最多6名敌人造成700点巨额伤害与强力击破！",
					"power": 700,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "giga_impact",
					"sfx": "attack",
					"scale": 0.48
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，释放终极奥义【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 席卷战场对最多4名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "根源波动",
					"desc": "用无数青白色且闪耀的光线攻击对手。",
					"detail": "消耗100能量，释放终极奥义【根源波动】！用无数青白色且闪耀的光线攻击对手。 席卷战场对最多6名敌人造成730点巨额伤害与强力击破！",
					"power": 730,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "hydro_cannon",
					"sfx": "water",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/seaking.png"
	},
	"staryu": {
		"id": "staryu",
		"name": "海星星",
		"title": "星形宝可梦",
		"cost": 1,
		"types": ["Water"],
		"hp": 520,
		"atk": 48,
		"armor": 28,
		"mr": 30,
		"range": 2,
		"atk_speed": 0.72,
		"max_mana": 70,
		"desc": "身体中央有一颗红色的发光核心，在夜里会随着天空中闪烁的星辰一同闪耀，即使身体残破也能迅速自我再生。",
		"skill_name": "水枪",
		"skill_desc": "向对手猛烈地喷射水流进行攻击。",
		"skill_detail": "消耗100能量，使出【水枪】。向对手猛烈地喷射水流进行攻击。 对目标造成182点伤害。",
		"skill_power": 182,
		"basic_attack": {
			"type": "special",
			"name": "水滴弹",
			"style": "water_bullet",
			"sfx": "water"
		},
						"skills": {
			1: [
				{
					"name": "水枪",
					"desc": "向对手猛烈地喷射水流进行攻击。",
					"detail": "消耗100能量，使出【水枪】。向对手猛烈地喷射水流进行攻击。 对目标造成182点伤害。",
					"power": 182,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "water_gun",
					"sfx": "water",
					"scale": 0.28
				},
				{
					"name": "撞击",
					"desc": "用整个身体撞向对手进行攻击。",
					"detail": "消耗100能量，使出【撞击】。用整个身体撞向对手进行攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "tackle",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "泡沫光线",
					"desc": "向对手猛烈地喷射泡沫进行攻击。有时会降低对手的速度。",
					"detail": "消耗100能量，使出【泡沫光线】。向对手猛烈地喷射泡沫进行攻击。有时会降低对手的速度。 对目标造成230点伤害。",
					"power": 230,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "bubble_beam",
					"sfx": "water",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "高速星星",
					"desc": "发射星形的光攻击对手。攻击必定会命中。",
					"detail": "消耗100能量，爆发【高速星星】。发射星形的光攻击对手。攻击必定会命中。 对范围内最多3名敌人造成320点伤害，并施加战术压制。",
					"power": 320,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "swift",
					"sfx": "swift",
					"scale": 0.36
				},
				{
					"name": "光墙",
					"desc": "利用神奇的墙壁，在５回合内减弱从对手那里受到的特殊攻击的伤害。",
					"detail": "消耗100能量，爆发【光墙】！利用神奇的墙壁，在５回合内减弱从对手那里受到的特殊攻击的伤害。 对范围内最多3名敌人造成320点伤害，并施加战术压制。",
					"power": 320,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "light_screen",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "力量宝石",
					"desc": "发射如宝石般闪耀的光芒攻击对手。",
					"detail": "消耗100能量，爆发【力量宝石】！发射如宝石般闪耀的光芒攻击对手。 对范围内最多3名敌人造成360点伤害，并施加战术压制。",
					"power": 360,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "rock_slide",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "精神强念",
					"desc": "向对手发送强大的念力进行攻击。有时会降低对手的特防。",
					"detail": "消耗100能量，释放终极奥义【精神强念】！向对手发送强大的念力进行攻击。有时会降低对手的特防。 席卷战场对最多6名敌人造成655点巨额伤害与强力击破！",
					"power": 655,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "psychic",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "水炮",
					"desc": "向对手猛烈地喷射大量水流进行攻击。",
					"detail": "消耗100能量，释放终极奥义【水炮】！向对手猛烈地喷射大量水流进行攻击。 席卷战场对最多6名敌人造成730点巨额伤害与强力击破！",
					"power": 730,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "hydro_pump",
					"sfx": "water",
					"scale": 1.55
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，释放终极奥义【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 席卷战场对最多4名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/staryu.png"
	},
	"starmie": {
		"id": "starmie",
		"name": "宝石海星",
		"title": "谜宝可梦",
		"cost": 3,
		"types": ["Water", "Psychic"],
		"hp": 880,
		"atk": 78,
		"armor": 42,
		"mr": 45,
		"range": 3,
		"atk_speed": 0.85,
		"max_mana": 75,
		"desc": "身体中心的红宝石核心如七彩宝石般璀璨闪烁，被称为水中的外星来客。能以极高转速如同齿轮般在水面和空中飞速切割！",
		"skill_name": "高速星星",
		"skill_desc": "发射星形的光攻击对手。攻击必定会命中。",
		"skill_detail": "消耗100能量，使出【高速星星】。发射星形的光攻击对手。攻击必定会命中。 对目标造成198点伤害。",
		"skill_power": 198,
		"basic_attack": {
			"type": "special",
			"name": "水滴弹",
			"style": "water_bullet",
			"sfx": "water"
		},
						"skills": {
			1: [
				{
					"name": "高速星星",
					"desc": "发射星形的光攻击对手。攻击必定会命中。",
					"detail": "消耗100能量，使出【高速星星】。发射星形的光攻击对手。攻击必定会命中。 对目标造成198点伤害。",
					"power": 198,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "swift",
					"sfx": "swift",
					"scale": 0.28
				},
				{
					"name": "撞击",
					"desc": "用整个身体撞向对手进行攻击。",
					"detail": "消耗100能量，使出【撞击】。用整个身体撞向对手进行攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "tackle",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "力量宝石",
					"desc": "发射如宝石般闪耀的光芒攻击对手。",
					"detail": "消耗100能量，使出【力量宝石】。发射如宝石般闪耀的光芒攻击对手。 对目标造成260点伤害。",
					"power": 260,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "rock_slide",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "精神强念",
					"desc": "向对手发送强大的念力进行攻击。有时会降低对手的特防。",
					"detail": "消耗100能量，爆发【精神强念】。向对手发送强大的念力进行攻击。有时会降低对手的特防。 对范围内最多3名敌人造成350点伤害，并施加战术压制。",
					"power": 350,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "psychic",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "水枪",
					"desc": "向对手猛烈地喷射水流进行攻击。",
					"detail": "消耗100能量，爆发【水枪】！向对手猛烈地喷射水流进行攻击。 对范围内最多3名敌人造成240点伤害，并施加战术压制。",
					"power": 240,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "water_gun",
					"sfx": "water",
					"scale": 1.10
				},
				{
					"name": "蟹钳锤",
					"desc": "用大钳子敲打对手进行攻击。容易击中要害。",
					"detail": "消耗100能量，爆发【蟹钳锤】！用大钳子敲打对手进行攻击。容易击中要害。 对范围内最多2名敌人造成420点伤害，并施加战术压制。",
					"power": 420,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "crabhammer",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "水炮",
					"desc": "向对手猛烈地喷射大量水流进行攻击。",
					"detail": "消耗100能量，释放终极奥义【水炮】！向对手猛烈地喷射大量水流进行攻击。 席卷战场对最多6名敌人造成685点巨额伤害与强力击破！",
					"power": 685,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "hydro_pump",
					"sfx": "water",
					"scale": 0.48
				},
				{
					"name": "加农水炮",
					"desc": "向对手喷射水炮进行攻击。下一回合自己将无法动弹。",
					"detail": "消耗100能量，释放终极奥义【加农水炮】！向对手喷射水炮进行攻击。下一回合自己将无法动弹。 席卷战场对最多6名敌人造成930点巨额伤害与强力击破！",
					"power": 930,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "hydro_cannon",
					"sfx": "water",
					"scale": 1.55
				},
				{
					"name": "光墙",
					"desc": "利用神奇的墙壁，在５回合内减弱从对手那里受到的特殊攻击的伤害。",
					"detail": "消耗100能量，释放终极奥义【光墙】！利用神奇的墙壁，在５回合内减弱从对手那里受到的特殊攻击的伤害。 席卷战场对最多6名敌人造成680点巨额伤害与强力击破！",
					"power": 680,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "light_screen",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/starmie.png"
	},
	"mr-mime": {
		"id": "mr-mime",
		"name": "魔墙人偶",
		"title": "屏障宝可梦",
		"cost": 2,
		"types": ["Psychic"],
		"hp": 740,
		"atk": 58,
		"armor": 35,
		"mr": 50,
		"range": 2,
		"atk_speed": 0.7,
		"max_mana": 80,
		"desc": "擅长默剧哑剧表演，双掌能凝结空气制造出真实存在的不可见透明防护墙，任何蛮力猛攻都会被弹开。",
		"skill_name": "念力",
		"skill_desc": "向对手发送微弱的念力进行攻击。有时会使对手混乱。",
		"skill_detail": "消耗100能量，使出【念力】。向对手发送微弱的念力进行攻击。有时会使对手混乱。 对目标造成190点伤害。",
		"skill_power": 190,
		"basic_attack": {
			"type": "special",
			"name": "念力波",
			"style": "psywave",
			"sfx": "swift"
		},
						"skills": {
			1: [
				{
					"name": "念力",
					"desc": "向对手发送微弱的念力进行攻击。有时会使对手混乱。",
					"detail": "消耗100能量，使出【念力】。向对手发送微弱的念力进行攻击。有时会使对手混乱。 对目标造成190点伤害。",
					"power": 190,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "confusion",
					"sfx": "skill",
					"scale": 0.28
				},
				{
					"name": "魔法叶",
					"desc": "散落可以追踪对手的神奇叶片。攻击必定会命中。",
					"detail": "消耗100能量，使出【魔法叶】。散落可以追踪对手的神奇叶片。攻击必定会命中。 对目标造成220点伤害。",
					"power": 220,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "razor_leaf",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "意念头锤",
					"desc": "将思念的力量集中在前额进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，使出【意念头锤】。将思念的力量集中在前额进行攻击。有时会使对手畏缩。 对目标造成260点伤害。",
					"power": 260,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "zen_headbutt",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "反射壁",
					"desc": "利用神奇的墙壁，在５回合内减弱从对手那里受到的物理攻击的伤害。",
					"detail": "消耗100能量，爆发【反射壁】。利用神奇的墙壁，在５回合内减弱从对手那里受到的物理攻击的伤害。 对范围内最多3名敌人造成300点伤害，并施加战术压制。",
					"power": 300,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "reflect",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "撞击",
					"desc": "用整个身体撞向对手进行攻击。",
					"detail": "消耗100能量，爆发【撞击】！用整个身体撞向对手进行攻击。 对范围内最多2名敌人造成240点伤害，并施加战术压制。",
					"power": 240,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "tackle",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "突袭",
					"desc": "可以比对手先攻击。对手使出的招式如果不是攻击招式则会失败。",
					"detail": "消耗100能量，爆发【突袭】！可以比对手先攻击。对手使出的招式如果不是攻击招式则会失败。 对范围内最多2名敌人造成330点伤害，并施加战术压制。",
					"power": 330,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "mach_punch",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "精神强念",
					"desc": "向对手发送强大的念力进行攻击。有时会降低对手的特防。",
					"detail": "消耗100能量，释放终极奥义【精神强念】！向对手发送强大的念力进行攻击。有时会降低对手的特防。 席卷战场对最多6名敌人造成655点巨额伤害与强力击破！",
					"power": 655,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "psychic",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "日光束",
					"desc": "第１回合收集满满的日光，第２回合发射光束进行攻击。",
					"detail": "消耗100能量，释放终极奥义【日光束】！第１回合收集满满的日光，第２回合发射光束进行攻击。 席卷战场对最多6名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "solar_beam",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "魔法闪耀",
					"desc": "向对手发射强光，并给予伤害。",
					"detail": "消耗100能量，释放终极奥义【魔法闪耀】！向对手发射强光，并给予伤害。 席卷战场对最多6名敌人造成580点巨额伤害与强力击破！",
					"power": 580,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/mr-mime.png"
	},
	"scyther": {
		"id": "scyther",
		"name": "飞天螳螂",
		"title": "螳螂宝可梦",
		"cost": 3,
		"types": ["Bug", "Flying"],
		"hp": 860,
		"atk": 92,
		"armor": 40,
		"mr": 35,
		"range": 1,
		"atk_speed": 0.88,
		"max_mana": 70,
		"desc": "拥有锋利胜过名刀的双臂巨大镰刀，能在疾速飞行中斩断眼前的大树，高速移动时甚至只能看到绿色的残影！",
		"skill_name": "电光一闪",
		"skill_desc": "以迅雷不及掩耳之势扑向对手。必定能够先制攻击。",
		"skill_detail": "消耗100能量，使出【电光一闪】。以迅雷不及掩耳之势扑向对手。必定能够先制攻击。 对目标造成182点伤害。",
		"skill_power": 182,
		"basic_attack": {
			"type": "physical",
			"name": "抓击",
			"style": "slash",
			"sfx": "slash"
		},
						"skills": {
			1: [
				{
					"name": "电光一闪",
					"desc": "以迅雷不及掩耳之势扑向对手。必定能够先制攻击。",
					"detail": "消耗100能量，使出【电光一闪】。以迅雷不及掩耳之势扑向对手。必定能够先制攻击。 对目标造成182点伤害。",
					"power": 182,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "quick_attack",
					"sfx": "swift",
					"scale": 0.28
				},
				{
					"name": "真空波",
					"desc": "挥动拳头，掀起真空波。必定能够先制攻击。",
					"detail": "消耗100能量，使出【真空波】。挥动拳头，掀起真空波。必定能够先制攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "mach_punch",
					"sfx": "punch",
					"scale": 0.82
				},
				{
					"name": "空气斩",
					"desc": "用连天空也能劈开的空气之刃进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，使出【空气斩】。用连天空也能劈开的空气之刃进行攻击。有时会使对手畏缩。 对目标造成250点伤害。",
					"power": 250,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "air_slash",
					"sfx": "slash",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "劈开",
					"desc": "用爪子或镰刀等劈开对手进行攻击。容易击中要害。",
					"detail": "消耗100能量，爆发【劈开】。用爪子或镰刀等劈开对手进行攻击。容易击中要害。 对范围内最多3名敌人造成330点伤害，并施加战术压制。",
					"power": 330,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "slash",
					"sfx": "slash",
					"scale": 0.36
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，爆发【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 对范围内最多2名敌人造成390点伤害，并施加战术压制。",
					"power": 390,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "舍身冲撞",
					"desc": "拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。",
					"detail": "消耗100能量，爆发【舍身冲撞】！拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。 对范围内最多2名敌人造成480点伤害，并施加战术压制。",
					"power": 480,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "double_edge",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "十字剪",
					"desc": "将镰刀或爪子像剪刀般地交叉，顺势劈开对手。",
					"detail": "消耗100能量，释放终极奥义【十字剪】！将镰刀或爪子像剪刀般地交叉，顺势劈开对手。 席卷战场对最多6名敌人造成640点巨额伤害与强力击破！",
					"power": 640,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "x_scissor",
					"sfx": "slash",
					"scale": 0.48
				},
				{
					"name": "破坏光线",
					"desc": "向对手发射强烈的光线进行攻击。下一回合自己将无法动弹。",
					"detail": "消耗100能量，释放终极奥义【破坏光线】！向对手发射强烈的光线进行攻击。下一回合自己将无法动弹。 席卷战场对最多6名敌人造成930点巨额伤害与强力击破！",
					"power": 930,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "hyper_beam",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "翅膀攻击",
					"desc": "大大地展开美丽的翅膀，将其撞向对手进行攻击。",
					"detail": "消耗100能量，释放终极奥义【翅膀攻击】！大大地展开美丽的翅膀，将其撞向对手进行攻击。 席卷战场对最多4名敌人造成480点巨额伤害与强力击破！",
					"power": 480,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "wing_attack",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/scyther.png"
	},
	"jynx": {
		"id": "jynx",
		"name": "迷唇姐",
		"title": "人形宝可梦",
		"cost": 2,
		"types": ["Ice", "Psychic"],
		"hp": 720,
		"atk": 62,
		"armor": 25,
		"mr": 45,
		"range": 2,
		"atk_speed": 0.72,
		"max_mana": 80,
		"desc": "伴随着充满节奏感的韵律摇曳起舞，看到它跳舞的人也会不由自主地跟着摆动身体，口中能呼出极寒玄冰之息。",
		"skill_name": "拍击",
		"skill_desc": "使用长长的尾巴或手等拍打对手进行攻击。",
		"skill_detail": "消耗100能量，使出【拍击】。使用长长的尾巴或手等拍打对手进行攻击。 对目标造成182点伤害。",
		"skill_power": 182,
		"basic_attack": {
			"type": "special",
			"name": "细雪",
			"style": "spark",
			"sfx": "water"
		},
						"skills": {
			1: [
				{
					"name": "拍击",
					"desc": "使用长长的尾巴或手等拍打对手进行攻击。",
					"detail": "消耗100能量，使出【拍击】。使用长长的尾巴或手等拍打对手进行攻击。 对目标造成182点伤害。",
					"power": 182,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "tackle",
					"sfx": "attack",
					"scale": 0.28
				},
				{
					"name": "舌舔",
					"desc": "用长长的舌头，舔遍对手进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，使出【舌舔】。用长长的舌头，舔遍对手进行攻击。有时会让对手陷入麻痹状态。 对目标造成160点伤害。",
					"power": 160,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "lick",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "爱心印章",
					"desc": "以可爱的动作使对手疏忽，乘机给出强烈的一击。有时会使对手畏缩。",
					"detail": "消耗100能量，使出【爱心印章】。以可爱的动作使对手疏忽，乘机给出强烈的一击。有时会使对手畏缩。 对目标造成220点伤害。",
					"power": 220,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "confusion",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "冰冻光束",
					"desc": "向对手发射冰冻光束进行攻击。有时会让对手陷入冰冻状态。",
					"detail": "消耗100能量，爆发【冰冻光束】。向对手发射冰冻光束进行攻击。有时会让对手陷入冰冻状态。 对范围内最多3名敌人造成350点伤害，并施加战术压制。",
					"power": 350,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "ice_beam",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "冰冻拳",
					"desc": "用充满寒气的拳头攻击对手。有时会让对手陷入冰冻状态。",
					"detail": "消耗100能量，爆发【冰冻拳】！用充满寒气的拳头攻击对手。有时会让对手陷入冰冻状态。 对范围内最多2名敌人造成345点伤害，并施加战术压制。",
					"power": 345,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "ice_punch",
					"sfx": "water",
					"scale": 1.10
				},
				{
					"name": "精神强念",
					"desc": "向对手发送强大的念力进行攻击。有时会降低对手的特防。",
					"detail": "消耗100能量，爆发【精神强念】！向对手发送强大的念力进行攻击。有时会降低对手的特防。 对范围内最多3名敌人造成390点伤害，并施加战术压制。",
					"power": 390,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "psychic",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "暴风雪",
					"desc": "将猛烈的暴风雪刮向对手进行攻击。有时会让对手陷入冰冻状态。",
					"detail": "消耗100能量，释放终极奥义【暴风雪】！将猛烈的暴风雪刮向对手进行攻击。有时会让对手陷入冰冻状态。 席卷战场对最多6名敌人造成685点巨额伤害与强力击破！",
					"power": 685,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "blizzard",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "雪崩",
					"desc": "如果受到对手的招式攻击，就能给予该对手２倍威力的攻击。",
					"detail": "消耗100能量，释放终极奥义【雪崩】！如果受到对手的招式攻击，就能给予该对手２倍威力的攻击。 席卷战场对最多4名敌人造成480点巨额伤害与强力击破！",
					"power": 480,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "avalanche",
					"sfx": "water",
					"scale": 1.55
				},
				{
					"name": "大闹一番",
					"desc": "在２～３回合内，乱打一气地攻击对手。大闹一番后自己会陷入混乱。",
					"detail": "消耗100能量，释放终极奥义【大闹一番】！在２～３回合内，乱打一气地攻击对手。大闹一番后自己会陷入混乱。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/jynx.png"
	},
	"magmar": {
		"id": "magmar",
		"name": "鸭嘴火兽",
		"title": "吐火宝可梦",
		"cost": 3,
		"types": ["Fire"],
		"hp": 900,
		"atk": 86,
		"armor": 38,
		"mr": 42,
		"range": 2,
		"atk_speed": 0.78,
		"max_mana": 75,
		"desc": "诞生于活火山的火山口深处，全身如岩浆般不断散发出滚烫的热浪，口中能喷射出足以融化一切的千度烈火！",
		"skill_name": "火花",
		"skill_desc": "向对手发射小型火焰进行攻击。有时会让对手陷入灼伤状态。",
		"skill_detail": "消耗100能量，使出【火花】。向对手发射小型火焰进行攻击。有时会让对手陷入灼伤状态。 对目标造成182点伤害。",
		"skill_power": 182,
		"basic_attack": {
			"type": "special",
			"name": "火花",
			"style": "fire_ember",
			"sfx": "fire"
		},
						"skills": {
			1: [
				{
					"name": "火花",
					"desc": "向对手发射小型火焰进行攻击。有时会让对手陷入灼伤状态。",
					"detail": "消耗100能量，使出【火花】。向对手发射小型火焰进行攻击。有时会让对手陷入灼伤状态。 对目标造成182点伤害。",
					"power": 182,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "ember",
					"sfx": "fire",
					"scale": 0.28
				},
				{
					"name": "百万吨重拳",
					"desc": "用充满力量的拳头攻击对手。",
					"detail": "消耗100能量，使出【百万吨重拳】。用充满力量的拳头攻击对手。 对目标造成260点伤害。",
					"power": 260,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "mega_punch",
					"sfx": "punch",
					"scale": 0.82
				},
				{
					"name": "踢倒",
					"desc": "用力踢对手的脚，使其摔倒进行攻击。对手越重，威力越大。",
					"detail": "消耗100能量，使出【踢倒】。用力踢对手的脚，使其摔倒进行攻击。对手越重，威力越大。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "low_kick",
					"sfx": "punch",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "火焰拳",
					"desc": "用充满火焰的拳头攻击对手。有时会让对手陷入灼伤状态。",
					"detail": "消耗100能量，爆发【火焰拳】。用充满火焰的拳头攻击对手。有时会让对手陷入灼伤状态。 对范围内最多3名敌人造成335点伤害，并施加战术压制。",
					"power": 335,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "fire_punch",
					"sfx": "fire",
					"scale": 0.36
				},
				{
					"name": "浊雾",
					"desc": "将肮脏的浓雾吹向对手进行攻击。有时会让对手陷入中毒状态。",
					"detail": "消耗100能量，爆发【浊雾】！将肮脏的浓雾吹向对手进行攻击。有时会让对手陷入中毒状态。 对范围内最多3名敌人造成210点伤害，并施加战术压制。",
					"power": 210,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "sludge_bomb",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "喷射火焰",
					"desc": "向对手发射烈焰进行攻击。有时会让对手陷入灼伤状态。",
					"detail": "消耗100能量，爆发【喷射火焰】！向对手发射烈焰进行攻击。有时会让对手陷入灼伤状态。 对范围内最多3名敌人造成390点伤害，并施加战术压制。",
					"power": 390,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "flamethrower",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "大字爆炎",
					"desc": "用大字形状的火焰烧尽对手。有时会让对手陷入灼伤状态。",
					"detail": "消耗100能量，释放终极奥义【大字爆炎】！用大字形状的火焰烧尽对手。有时会让对手陷入灼伤状态。 席卷战场对最多6名敌人造成685点巨额伤害与强力击破！",
					"power": 685,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "fire_blast",
					"sfx": "fire",
					"scale": 0.48
				},
				{
					"name": "百万吨重踢",
					"desc": "使出力大无穷的重踢踢飞对手进行攻击。",
					"detail": "消耗100能量，释放终极奥义【百万吨重踢】！使出力大无穷的重踢踢飞对手进行攻击。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "mega_kick",
					"sfx": "punch",
					"scale": 1.55
				},
				{
					"name": "破坏光线",
					"desc": "向对手发射强烈的光线进行攻击。下一回合自己将无法动弹。",
					"detail": "消耗100能量，释放终极奥义【破坏光线】！向对手发射强烈的光线进行攻击。下一回合自己将无法动弹。 席卷战场对最多6名敌人造成930点巨额伤害与强力击破！",
					"power": 930,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "hyper_beam",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/magmar.png"
	},
	"pinsir": {
		"id": "pinsir",
		"name": "凯罗斯",
		"title": "锹形宝可梦",
		"cost": 3,
		"types": ["Bug"],
		"hp": 920,
		"atk": 96,
		"armor": 50,
		"mr": 35,
		"range": 1,
		"atk_speed": 0.76,
		"max_mana": 75,
		"desc": "头顶长着一对巨大且长满尖刺的粗壮大角，一旦夹住猎物就绝不松开，拥有能把坚固大树齐根斩断的惊人巨力！",
		"skill_name": "夹住",
		"skill_desc": "将对手从两侧夹住，给予伤害。",
		"skill_detail": "消耗100能量，使出【夹住】。将对手从两侧夹住，给予伤害。 对目标造成194点伤害。",
		"skill_power": 194,
		"basic_attack": {
			"type": "physical",
			"name": "撞击",
			"style": "tackle",
			"sfx": "attack"
		},
						"skills": {
			1: [
				{
					"name": "夹住",
					"desc": "将对手从两侧夹住，给予伤害。",
					"detail": "消耗100能量，使出【夹住】。将对手从两侧夹住，给予伤害。 对目标造成194点伤害。",
					"power": 194,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "crabhammer",
					"sfx": "slash",
					"scale": 0.28
				},
				{
					"name": "绑紧",
					"desc": "使用长长的身体或藤蔓等，在４～５回合内绑紧对手进行攻击。",
					"detail": "消耗100能量，使出【绑紧】。使用长长的身体或藤蔓等，在４～５回合内绑紧对手进行攻击。 对目标造成130点伤害。",
					"power": 130,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "stone_edge",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "二连击",
					"desc": "使用尾巴等拍打对手进行攻击。连续２次给予伤害。",
					"detail": "消耗100能量，使出【二连击】。使用尾巴等拍打对手进行攻击。连续２次给予伤害。 对目标造成170点伤害。",
					"power": 170,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "十字剪",
					"desc": "将镰刀或爪子像剪刀般地交叉，顺势劈开对手。",
					"detail": "消耗100能量，爆发【十字剪】。将镰刀或爪子像剪刀般地交叉，顺势劈开对手。 对范围内最多3名敌人造成340点伤害，并施加战术压制。",
					"power": 340,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "x_scissor",
					"sfx": "slash",
					"scale": 0.36
				},
				{
					"name": "劈开",
					"desc": "用爪子或镰刀等劈开对手进行攻击。容易击中要害。",
					"detail": "消耗100能量，爆发【劈开】！用爪子或镰刀等劈开对手进行攻击。容易击中要害。 对范围内最多2名敌人造成330点伤害，并施加战术压制。",
					"power": 330,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "slash",
					"sfx": "slash",
					"scale": 1.10
				},
				{
					"name": "泰山压顶",
					"desc": "用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，爆发【泰山压顶】！用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。 对范围内最多2名敌人造成375点伤害，并施加战术压制。",
					"power": 375,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "蛮力",
					"desc": "发挥惊人的力量攻击对手。自己的攻击和防御会降低。",
					"detail": "消耗100能量，释放终极奥义【蛮力】！发挥惊人的力量攻击对手。自己的攻击和防御会降低。 席卷战场对最多6名敌人造成700点巨额伤害与强力击破！",
					"power": 700,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "mega_punch",
					"sfx": "punch",
					"scale": 0.48
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，释放终极奥义【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 席卷战场对最多4名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "舍身冲撞",
					"desc": "拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。",
					"detail": "消耗100能量，释放终极奥义【舍身冲撞】！拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "double_edge",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/pinsir.png"
	},
	"tauros": {
		"id": "tauros",
		"name": "肯泰罗",
		"title": "暴牛宝可梦",
		"cost": 3,
		"types": ["Normal"],
		"hp": 960,
		"atk": 88,
		"armor": 48,
		"mr": 38,
		"range": 1,
		"atk_speed": 0.82,
		"max_mana": 75,
		"desc": "拥有三条甩动有力的尾巴，经常用尾巴抽打自己的身体来鼓舞狂暴战意，一旦开始野蛮奔腾就无人能够阻挡！",
		"skill_name": "角撞",
		"skill_desc": "用尖锐的角攻击对手。",
		"skill_detail": "消耗100能量，使出【角撞】。用尖锐的角攻击对手。 对目标造成202点伤害。",
		"skill_power": 202,
		"basic_attack": {
			"type": "physical",
			"name": "撞击",
			"style": "tackle",
			"sfx": "attack"
		},
						"skills": {
			1: [
				{
					"name": "角撞",
					"desc": "用尖锐的角攻击对手。",
					"detail": "消耗100能量，使出【角撞】。用尖锐的角攻击对手。 对目标造成202点伤害。",
					"power": 202,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "body_slam",
					"sfx": "attack",
					"scale": 0.28
				},
				{
					"name": "撞击",
					"desc": "用整个身体撞向对手进行攻击。",
					"detail": "消耗100能量，使出【撞击】。用整个身体撞向对手进行攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "tackle",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "踩踏",
					"desc": "用大脚踩踏对手进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，使出【踩踏】。用大脚踩踏对手进行攻击。有时会使对手畏缩。 对目标造成230点伤害。",
					"power": 230,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "意念头锤",
					"desc": "将思念的力量集中在前额进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，爆发【意念头锤】。将思念的力量集中在前额进行攻击。有时会使对手畏缩。 对范围内最多3名敌人造成340点伤害，并施加战术压制。",
					"power": 340,
					"target_count": 3,
					"stun_duration": 0.8,
					"vfx": "zen_headbutt",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，爆发【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 对范围内最多2名敌人造成390点伤害，并施加战术压制。",
					"power": 390,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "角钻",
					"desc": "用旋转的角刺入对手进行攻击。只要命中就会一击濒死。",
					"detail": "消耗100能量，爆发【角钻】！用旋转的角刺入对手进行攻击。只要命中就会一击濒死。 对范围内最多2名敌人造成320点伤害，并施加战术压制。",
					"power": 320,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "drill_peck",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "终极冲击",
					"desc": "使出自己浑身力量突击对手。下一回合自己将无法动弹。",
					"detail": "消耗100能量，释放终极奥义【终极冲击】！使出自己浑身力量突击对手。下一回合自己将无法动弹。 席卷战场对最多6名敌人造成745点巨额伤害与强力击破！",
					"power": 745,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "giga_impact",
					"sfx": "attack",
					"scale": 0.48
				},
				{
					"name": "舍身冲撞",
					"desc": "拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。",
					"detail": "消耗100能量，释放终极奥义【舍身冲撞】！拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "double_edge",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "逆鳞",
					"desc": "在２～３回合内，乱打一气地进行攻击。大闹一番后自己会陷入混乱。",
					"detail": "消耗100能量，释放终极奥义【逆鳞】！在２～３回合内，乱打一气地进行攻击。大闹一番后自己会陷入混乱。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "dragon_apocalypse",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/tauros.png"
	},
	"magikarp": {
		"id": "magikarp",
		"name": "鲤鱼王",
		"title": "鱼宝可梦",
		"cost": 1,
		"types": ["Water"],
		"hp": 450,
		"atk": 25,
		"armor": 25,
		"mr": 20,
		"range": 1,
		"atk_speed": 0.6,
		"max_mana": 60,
		"desc": "被称为世界上最弱小的宝可梦，无论在陆地还是水中都只会无力地水溅跃，然而在体内潜藏着蜕变成凶猛神龙的奇迹潜质！",
		"skill_name": "跃起",
		"skill_desc": "也不攻击只是一蹦一蹦地跳，什么都不会发生……",
		"skill_detail": "消耗100能量，使出【跃起】。也不攻击只是一蹦一蹦地跳，什么都不会发生…… 对目标造成160点伤害。",
		"skill_power": 160,
		"basic_attack": {
			"type": "physical",
			"name": "撞击",
			"style": "tackle",
			"sfx": "attack"
		},
						"skills": {
			1: [
				{
					"name": "跃起",
					"desc": "也不攻击只是一蹦一蹦地跳，什么都不会发生……",
					"detail": "消耗100能量，使出【跃起】。也不攻击只是一蹦一蹦地跳，什么都不会发生…… 对目标造成160点伤害。",
					"power": 160,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "water_gun",
					"sfx": "water",
					"scale": 0.28
				},
				{
					"name": "咬住",
					"desc": "用尖锐的牙咬住对手进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，使出【咬住】。用尖锐的牙咬住对手进行攻击。有时会使对手畏缩。 对目标造成220点伤害。",
					"power": 220,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "bite",
					"sfx": "bite",
					"scale": 0.82
				},
				{
					"name": "水流喷射",
					"desc": "以迅雷不及掩耳之势扑向对手。必定能够先制攻击。",
					"detail": "消耗100能量，使出【水流喷射】。以迅雷不及掩耳之势扑向对手。必定能够先制攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "water_pulse",
					"sfx": "water",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "撞击",
					"desc": "用整个身体撞向对手进行攻击。",
					"detail": "消耗100能量，爆发【撞击】。用整个身体撞向对手进行攻击。 对范围内最多3名敌人造成300点伤害，并施加战术压制。",
					"power": 300,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "tackle",
					"sfx": "attack",
					"scale": 0.36
				},
				{
					"name": "水炮",
					"desc": "向对手猛烈地喷射大量水流进行攻击。",
					"detail": "消耗100能量，爆发【水炮】！向对手猛烈地喷射大量水流进行攻击。 对范围内最多3名敌人造成450点伤害，并施加战术压制。",
					"power": 450,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "hydro_pump",
					"sfx": "water",
					"scale": 1.10
				},
				{
					"name": "蟹钳锤",
					"desc": "用大钳子敲打对手进行攻击。容易击中要害。",
					"detail": "消耗100能量，爆发【蟹钳锤】！用大钳子敲打对手进行攻击。容易击中要害。 对范围内最多2名敌人造成420点伤害，并施加战术压制。",
					"power": 420,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "crabhammer",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "抓狂",
					"desc": "抓狂般乱打进行攻击。自己的ＨＰ越少，招式的威力越大。",
					"detail": "消耗100能量，释放终极奥义【抓狂】！抓狂般乱打进行攻击。自己的ＨＰ越少，招式的威力越大。 席卷战场对最多6名敌人造成600点巨额伤害与强力击破！",
					"power": 600,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "body_slam",
					"sfx": "attack",
					"scale": 0.48
				},
				{
					"name": "加农水炮",
					"desc": "向对手喷射水炮进行攻击。下一回合自己将无法动弹。",
					"detail": "消耗100能量，释放终极奥义【加农水炮】！向对手喷射水炮进行攻击。下一回合自己将无法动弹。 席卷战场对最多6名敌人造成930点巨额伤害与强力击破！",
					"power": 930,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "hydro_cannon",
					"sfx": "water",
					"scale": 1.55
				},
				{
					"name": "破坏光线",
					"desc": "向对手发射强烈的光线进行攻击。下一回合自己将无法动弹。",
					"detail": "消耗100能量，释放终极奥义【破坏光线】！向对手发射强烈的光线进行攻击。下一回合自己将无法动弹。 席卷战场对最多6名敌人造成930点巨额伤害与强力击破！",
					"power": 930,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "hyper_beam",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/magikarp.png"
	},
	"ditto": {
		"id": "ditto",
		"name": "百变怪",
		"title": "变身宝可梦",
		"cost": 2,
		"types": ["Normal"],
		"hp": 750,
		"atk": 60,
		"armor": 35,
		"mr": 35,
		"range": 1,
		"atk_speed": 0.7,
		"max_mana": 60,
		"desc": "身体由能够自由重组的黏液细胞构成，能瞬间重组体内的遗传基因，变身成为眼前看到的任何宝可梦一模一样的形态！",
		"skill_name": "撞击",
		"skill_desc": "用整个身体撞向对手进行攻击。",
		"skill_detail": "消耗100能量，使出【撞击】。用整个身体撞向对手进行攻击。 对目标造成182点伤害。",
		"skill_power": 182,
		"basic_attack": {
			"type": "physical",
			"name": "撞击",
			"style": "tackle",
			"sfx": "attack"
		},
						"skills": {
			1: [
				{
					"name": "撞击",
					"desc": "用整个身体撞向对手进行攻击。",
					"detail": "消耗100能量，使出【撞击】。用整个身体撞向对手进行攻击。 对目标造成182点伤害。",
					"power": 182,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "tackle",
					"sfx": "attack",
					"scale": 0.28
				},
				{
					"name": "电光一闪",
					"desc": "以迅雷不及掩耳之势扑向对手。必定能够先制攻击。",
					"detail": "消耗100能量，使出【电光一闪】。以迅雷不及掩耳之势扑向对手。必定能够先制攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "头锤",
					"desc": "将头伸出，笔直地扑向对手进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，使出【头锤】。将头伸出，笔直地扑向对手进行攻击。有时会使对手畏缩。 对目标造成240点伤害。",
					"power": 240,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "headbutt",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "变身",
					"desc": "变身成对手宝可梦的样子，能够使用和对手完全相同的招式。",
					"detail": "消耗100能量，爆发【变身】。变身成对手宝可梦的样子，能够使用和对手完全相同的招式。 对范围内最多3名敌人造成300点伤害，并施加战术压制。",
					"power": 300,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "transform",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "劈开",
					"desc": "用爪子或镰刀等劈开对手进行攻击。容易击中要害。",
					"detail": "消耗100能量，爆发【劈开】！用爪子或镰刀等劈开对手进行攻击。容易击中要害。 对范围内最多2名敌人造成330点伤害，并施加战术压制。",
					"power": 330,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "slash",
					"sfx": "slash",
					"scale": 1.10
				},
				{
					"name": "高速星星",
					"desc": "发射星形的光攻击对手。攻击必定会命中。",
					"detail": "消耗100能量，爆发【高速星星】！发射星形的光攻击对手。攻击必定会命中。 对范围内最多3名敌人造成300点伤害，并施加战术压制。",
					"power": 300,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "swift",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "破坏光线",
					"desc": "向对手发射强烈的光线进行攻击。下一回合自己将无法动弹。",
					"detail": "消耗100能量，释放终极奥义【破坏光线】！向对手发射强烈的光线进行攻击。下一回合自己将无法动弹。 席卷战场对最多6名敌人造成745点巨额伤害与强力击破！",
					"power": 745,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "hyper_beam",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "终极冲击",
					"desc": "使出自己浑身力量突击对手。下一回合自己将无法动弹。",
					"detail": "消耗100能量，释放终极奥义【终极冲击】！使出自己浑身力量突击对手。下一回合自己将无法动弹。 席卷战场对最多4名敌人造成930点巨额伤害与强力击破！",
					"power": 930,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "giga_impact",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "舍身冲撞",
					"desc": "拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。",
					"detail": "消耗100能量，释放终极奥义【舍身冲撞】！拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "double_edge",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/ditto.png"
	},
	"vaporeon": {
		"id": "vaporeon",
		"name": "水伊布",
		"title": "吐水宝可梦",
		"cost": 3,
		"types": ["Water"],
		"hp": 1100,
		"atk": 74,
		"armor": 42,
		"mr": 48,
		"range": 2,
		"atk_speed": 0.72,
		"max_mana": 80,
		"desc": "细胞结构极其酷似水分子，能完全溶化在清澈的水中悄无声息地接近对手，尾鳍长有美丽的鱼鳍尾巴。",
		"skill_name": "水之波动",
		"skill_desc": "用水的震动攻击对手。有时会使对手混乱。",
		"skill_detail": "消耗100能量，使出【水之波动】。用水的震动攻击对手。有时会使对手混乱。 对目标造成198点伤害。",
		"skill_power": 198,
		"basic_attack": {
			"type": "special",
			"name": "水滴弹",
			"style": "water_bullet",
			"sfx": "water"
		},
						"skills": {
			1: [
				{
					"name": "水之波动",
					"desc": "用水的震动攻击对手。有时会使对手混乱。",
					"detail": "消耗100能量，使出【水之波动】。用水的震动攻击对手。有时会使对手混乱。 对目标造成198点伤害。",
					"power": 198,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "water_pulse",
					"sfx": "water",
					"scale": 0.28
				},
				{
					"name": "水枪",
					"desc": "向对手猛烈地喷射水流进行攻击。",
					"detail": "消耗100能量，使出【水枪】。向对手猛烈地喷射水流进行攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "water_gun",
					"sfx": "water",
					"scale": 0.82
				},
				{
					"name": "极光束",
					"desc": "向对手发射虹色光束进行攻击。有时会降低对手的攻击。",
					"detail": "消耗100能量，使出【极光束】。向对手发射虹色光束进行攻击。有时会降低对手的攻击。 对目标造成230点伤害。",
					"power": 230,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "aurora_beam",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "溶化",
					"desc": "通过细胞的变化进行液化，从而大幅提高自己的防御。",
					"detail": "消耗100能量，爆发【溶化】。通过细胞的变化进行液化，从而大幅提高自己的防御。 对范围内最多3名敌人造成300点伤害，并施加战术压制。",
					"power": 300,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "acid_armor",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "水流尾",
					"desc": "如惊涛骇浪般挥动大尾巴攻击对手。",
					"detail": "消耗100能量，爆发【水流尾】！如惊涛骇浪般挥动大尾巴攻击对手。 对范围内最多2名敌人造成390点伤害，并施加战术压制。",
					"power": 390,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "aqua_tail",
					"sfx": "water",
					"scale": 1.10
				},
				{
					"name": "浊流",
					"desc": "向对手喷射浑浊的水进行攻击。有时会降低对手的命中率。",
					"detail": "消耗100能量，爆发【浊流】！向对手喷射浑浊的水进行攻击。有时会降低对手的命中率。 对范围内最多3名敌人造成390点伤害，并施加战术压制。",
					"power": 390,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "surf",
					"sfx": "water",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "水炮",
					"desc": "向对手猛烈地喷射大量水流进行攻击。",
					"detail": "消耗100能量，释放终极奥义【水炮】！向对手猛烈地喷射大量水流进行攻击。 席卷战场对最多6名敌人造成685点巨额伤害与强力击破！",
					"power": 685,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "hydro_pump",
					"sfx": "water",
					"scale": 0.48
				},
				{
					"name": "咬住",
					"desc": "用尖锐的牙咬住对手进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，释放终极奥义【咬住】！用尖锐的牙咬住对手进行攻击。有时会使对手畏缩。 席卷战场对最多4名敌人造成480点巨额伤害与强力击破！",
					"power": 480,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "bite",
					"sfx": "bite",
					"scale": 1.55
				},
				{
					"name": "珍藏",
					"desc": "当战斗中已学会的招式全部使用过后，才能开始使出珍藏的招式。",
					"detail": "消耗100能量，释放终极奥义【珍藏】！当战斗中已学会的招式全部使用过后，才能开始使出珍藏的招式。 席卷战场对最多4名敌人造成880点巨额伤害与强力击破！",
					"power": 880,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "giga_impact",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/vaporeon.png"
	},
	"jolteon": {
		"id": "jolteon",
		"name": "雷伊布",
		"title": "雷宝可梦",
		"cost": 3,
		"types": ["Electric"],
		"hp": 850,
		"atk": 86,
		"armor": 35,
		"mr": 42,
		"range": 2,
		"atk_speed": 0.95,
		"max_mana": 70,
		"desc": "毛发全部竖起时就像锋利坚硬的钢针一样，体内产生一万伏特的高压电荷，咆哮时会迸射出无数道耀眼电弧！",
		"skill_name": "电光",
		"skill_desc": "让电流覆盖全身，猛撞向对手进行攻击。有时会让对手陷入麻痹状态。",
		"skill_detail": "消耗100能量，使出【电光】。让电流覆盖全身，猛撞向对手进行攻击。有时会让对手陷入麻痹状态。 对目标造成202点伤害。",
		"skill_power": 202,
		"basic_attack": {
			"type": "special",
			"name": "电火花",
			"style": "spark",
			"sfx": "spark"
		},
						"skills": {
			1: [
				{
					"name": "电光",
					"desc": "让电流覆盖全身，猛撞向对手进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，使出【电光】。让电流覆盖全身，猛撞向对手进行攻击。有时会让对手陷入麻痹状态。 对目标造成202点伤害。",
					"power": 202,
					"target_count": 1,
					"stun_duration": 0.5,
					"vfx": "spark",
					"sfx": "spark",
					"scale": 0.28
				},
				{
					"name": "电击",
					"desc": "发出电流刺激对手进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，使出【电击】。发出电流刺激对手进行攻击。有时会让对手陷入麻痹状态。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "thundershock",
					"sfx": "thunder",
					"scale": 0.82
				},
				{
					"name": "雷电牙",
					"desc": "用蓄满电流的牙齿咬住对手。有时会使对手畏缩或陷入麻痹状态。",
					"detail": "消耗100能量，使出【雷电牙】。用蓄满电流的牙齿咬住对手。有时会使对手畏缩或陷入麻痹状态。 对目标造成230点伤害。",
					"power": 230,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "thunder_fang",
					"sfx": "thunder",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "飞弹针",
					"desc": "向对手发射锐针进行攻击。连续攻击２～５次。",
					"detail": "消耗100能量，爆发【飞弹针】。向对手发射锐针进行攻击。连续攻击２～５次。 对范围内最多3名敌人造成285点伤害，并施加战术压制。",
					"power": 285,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "pin_missile",
					"sfx": "slash",
					"scale": 0.36
				},
				{
					"name": "撞击",
					"desc": "用整个身体撞向对手进行攻击。",
					"detail": "消耗100能量，爆发【撞击】！用整个身体撞向对手进行攻击。 对范围内最多2名敌人造成240点伤害，并施加战术压制。",
					"power": 240,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "tackle",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "放电",
					"desc": "用耀眼的电击攻击自己周围所有的宝可梦。有时会陷入麻痹状态。",
					"detail": "消耗100能量，爆发【放电】！用耀眼的电击攻击自己周围所有的宝可梦。有时会陷入麻痹状态。 对范围内最多3名敌人造成360点伤害，并施加战术压制。",
					"power": 360,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "discharge",
					"sfx": "thunder",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "打雷",
					"desc": "向对手劈下暴雷进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，释放终极奥义【打雷】！向对手劈下暴雷进行攻击。有时会让对手陷入麻痹状态。 席卷战场对最多6名敌人造成685点巨额伤害与强力击破！",
					"power": 685,
					"target_count": 6,
					"stun_duration": 1.2,
					"vfx": "thunder",
					"sfx": "thunder",
					"scale": 0.48
				},
				{
					"name": "泰山压顶",
					"desc": "用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，释放终极奥义【泰山压顶】！用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。 席卷战场对最多4名敌人造成605点巨额伤害与强力击破！",
					"power": 605,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "珍藏",
					"desc": "当战斗中已学会的招式全部使用过后，才能开始使出珍藏的招式。",
					"detail": "消耗100能量，释放终极奥义【珍藏】！当战斗中已学会的招式全部使用过后，才能开始使出珍藏的招式。 席卷战场对最多4名敌人造成880点巨额伤害与强力击破！",
					"power": 880,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "giga_impact",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/jolteon.png"
	},
	"flareon": {
		"id": "flareon",
		"name": "火伊布",
		"title": "火宝可梦",
		"cost": 3,
		"types": ["Fire"],
		"hp": 880,
		"atk": 98,
		"armor": 38,
		"mr": 45,
		"range": 1,
		"atk_speed": 0.78,
		"max_mana": 75,
		"desc": "蓬松的毛发能向空气中散发高达900度的惊人热量，体内拥有特殊的火焰袋，深吸一口气就能吐出炽热烈火！",
		"skill_name": "火花",
		"skill_desc": "向对手发射小型火焰进行攻击。有时会让对手陷入灼伤状态。",
		"skill_detail": "消耗100能量，使出【火花】。向对手发射小型火焰进行攻击。有时会让对手陷入灼伤状态。 对目标造成182点伤害。",
		"skill_power": 182,
		"basic_attack": {
			"type": "physical",
			"name": "撞击",
			"style": "tackle",
			"sfx": "attack"
		},
						"skills": {
			1: [
				{
					"name": "火花",
					"desc": "向对手发射小型火焰进行攻击。有时会让对手陷入灼伤状态。",
					"detail": "消耗100能量，使出【火花】。向对手发射小型火焰进行攻击。有时会让对手陷入灼伤状态。 对目标造成182点伤害。",
					"power": 182,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "ember",
					"sfx": "fire",
					"scale": 0.28
				},
				{
					"name": "撞击",
					"desc": "用整个身体撞向对手进行攻击。",
					"detail": "消耗100能量，使出【撞击】。用整个身体撞向对手进行攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "tackle",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "浊雾",
					"desc": "将肮脏的浓雾吹向对手进行攻击。有时会让对手陷入中毒状态。",
					"detail": "消耗100能量，使出【浊雾】。将肮脏的浓雾吹向对手进行攻击。有时会让对手陷入中毒状态。 对目标造成160点伤害。",
					"power": 160,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "sludge_bomb",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "火焰牙",
					"desc": "用覆盖着火焰的牙齿咬住对手。有时会使对手畏缩或陷入灼伤状态。",
					"detail": "消耗100能量，爆发【火焰牙】。用覆盖着火焰的牙齿咬住对手。有时会使对手畏缩或陷入灼伤状态。 对范围内最多3名敌人造成325点伤害，并施加战术压制。",
					"power": 325,
					"target_count": 3,
					"stun_duration": 0.8,
					"vfx": "fire_fang",
					"sfx": "fire",
					"scale": 0.36
				},
				{
					"name": "电光一闪",
					"desc": "以迅雷不及掩耳之势扑向对手。必定能够先制攻击。",
					"detail": "消耗100能量，爆发【电光一闪】！以迅雷不及掩耳之势扑向对手。必定能够先制攻击。 对范围内最多2名敌人造成240点伤害，并施加战术压制。",
					"power": 240,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "咬住",
					"desc": "用尖锐的牙咬住对手进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，爆发【咬住】！用尖锐的牙咬住对手进行攻击。有时会使对手畏缩。 对范围内最多2名敌人造成300点伤害，并施加战术压制。",
					"power": 300,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "bite",
					"sfx": "bite",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "闪焰冲锋",
					"desc": "让火焰覆盖全身猛撞向对手。自己也会受到不小的伤害。有时会让对手陷入灼伤状态。",
					"detail": "消耗100能量，释放终极奥义【闪焰冲锋】！让火焰覆盖全身猛撞向对手。自己也会受到不小的伤害。有时会让对手陷入灼伤状态。 席卷战场对最多6名敌人造成700点巨额伤害与强力击破！",
					"power": 700,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "flare_blitz",
					"sfx": "fire",
					"scale": 0.48
				},
				{
					"name": "火焰旋涡",
					"desc": "将对手困在激烈的火焰旋涡中，在４～５回合内进行攻击。",
					"detail": "消耗100能量，释放终极奥义【火焰旋涡】！将对手困在激烈的火焰旋涡中，在４～５回合内进行攻击。 席卷战场对最多6名敌人造成355点巨额伤害与强力击破！",
					"power": 355,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "fire_spin",
					"sfx": "fire",
					"scale": 1.55
				},
				{
					"name": "喷射火焰",
					"desc": "向对手发射烈焰进行攻击。有时会让对手陷入灼伤状态。",
					"detail": "消耗100能量，释放终极奥义【喷射火焰】！向对手发射烈焰进行攻击。有时会让对手陷入灼伤状态。 席卷战场对最多6名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "flamethrower",
					"sfx": "fire",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/flareon.png"
	},
	"porygon": {
		"id": "porygon",
		"name": "多边兽",
		"title": "虚拟宝可梦",
		"cost": 2,
		"types": ["Normal"],
		"hp": 700,
		"atk": 65,
		"armor": 35,
		"mr": 40,
		"range": 3,
		"atk_speed": 0.72,
		"max_mana": 70,
		"desc": "由最顶尖的科学家运用完全的代码数据制造出的虚拟宝可梦，能随意穿梭在计算机网络之中自由畅游。",
		"skill_name": "幻象光线",
		"skill_desc": "向对手发射神奇的光线进行攻击。有时会使对手混乱。",
		"skill_detail": "消耗100能量，使出【幻象光线】。向对手发射神奇的光线进行攻击。有时会使对手混乱。 对目标造成202点伤害。",
		"skill_power": 202,
		"basic_attack": {
			"type": "special",
			"name": "魔法弹",
			"style": "spark",
			"sfx": "swift"
		},
						"skills": {
			1: [
				{
					"name": "幻象光线",
					"desc": "向对手发射神奇的光线进行攻击。有时会使对手混乱。",
					"detail": "消耗100能量，使出【幻象光线】。向对手发射神奇的光线进行攻击。有时会使对手混乱。 对目标造成202点伤害。",
					"power": 202,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "psybeam",
					"sfx": "skill",
					"scale": 0.28
				},
				{
					"name": "撞击",
					"desc": "用整个身体撞向对手进行攻击。",
					"detail": "消耗100能量，使出【撞击】。用整个身体撞向对手进行攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "tackle",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "剧毒",
					"desc": "让对手陷入剧毒状态。随着回合的推进，中毒伤害会增加。",
					"detail": "消耗100能量，使出【剧毒】。让对手陷入剧毒状态。随着回合的推进，中毒伤害会增加。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "toxic",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "三重攻击",
					"desc": "用３种光线进行攻击。有时会让对手陷入麻痹、灼伤或冰冻的状态。",
					"detail": "消耗100能量，爆发【三重攻击】。用３种光线进行攻击。有时会让对手陷入麻痹、灼伤或冰冻的状态。 对范围内最多3名敌人造成340点伤害，并施加战术压制。",
					"power": 340,
					"target_count": 3,
					"stun_duration": 0.8,
					"vfx": "tri_attack",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，爆发【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 对范围内最多2名敌人造成390点伤害，并施加战术压制。",
					"power": 390,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "破坏光线",
					"desc": "向对手发射强烈的光线进行攻击。下一回合自己将无法动弹。",
					"detail": "消耗100能量，爆发【破坏光线】！向对手发射强烈的光线进行攻击。下一回合自己将无法动弹。 对范围内最多3名敌人造成570点伤害，并施加战术压制。",
					"power": 570,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "hyper_beam",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "电磁炮",
					"desc": "发射大炮一样的电流进行攻击。让对手陷入麻痹状态。",
					"detail": "消耗100能量，释放终极奥义【电磁炮】！发射大炮一样的电流进行攻击。让对手陷入麻痹状态。 席卷战场对最多6名敌人造成700点巨额伤害与强力击破！",
					"power": 700,
					"target_count": 6,
					"stun_duration": 1.2,
					"vfx": "electro_ball",
					"sfx": "thunder",
					"scale": 0.48
				},
				{
					"name": "放电",
					"desc": "用耀眼的电击攻击自己周围所有的宝可梦。有时会陷入麻痹状态。",
					"detail": "消耗100能量，释放终极奥义【放电】！用耀眼的电击攻击自己周围所有的宝可梦。有时会陷入麻痹状态。 席卷战场对最多6名敌人造成580点巨额伤害与强力击破！",
					"power": 580,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "discharge",
					"sfx": "thunder",
					"scale": 1.55
				},
				{
					"name": "舍身冲撞",
					"desc": "拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。",
					"detail": "消耗100能量，释放终极奥义【舍身冲撞】！拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "double_edge",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/porygon.png"
	},
	"omanyte": {
		"id": "omanyte",
		"name": "菊石兽",
		"title": "螺旋宝可梦",
		"cost": 2,
		"types": ["Rock", "Water"],
		"hp": 720,
		"atk": 56,
		"armor": 50,
		"mr": 30,
		"range": 2,
		"atk_speed": 0.65,
		"max_mana": 80,
		"desc": "由古代化石中复活的远古宝可梦，依靠背上十根柔软的触须和坚硬的螺旋贝壳在远古沧海中乘风破浪。",
		"skill_name": "水枪",
		"skill_desc": "向对手猛烈地喷射水流进行攻击。",
		"skill_detail": "消耗100能量，使出【水枪】。向对手猛烈地喷射水流进行攻击。 对目标造成182点伤害。",
		"skill_power": 182,
		"basic_attack": {
			"type": "special",
			"name": "魔法弹",
			"style": "spark",
			"sfx": "swift"
		},
						"skills": {
			1: [
				{
					"name": "水枪",
					"desc": "向对手猛烈地喷射水流进行攻击。",
					"detail": "消耗100能量，使出【水枪】。向对手猛烈地喷射水流进行攻击。 对目标造成182点伤害。",
					"power": 182,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "water_gun",
					"sfx": "water",
					"scale": 0.28
				},
				{
					"name": "缠绕",
					"desc": "用触手或青藤等缠绕进行攻击。有时会降低对手的速度。",
					"detail": "消耗100能量，使出【缠绕】。用触手或青藤等缠绕进行攻击。有时会降低对手的速度。 对目标造成120点伤害。",
					"power": 120,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "咬住",
					"desc": "用尖锐的牙咬住对手进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，使出【咬住】。用尖锐的牙咬住对手进行攻击。有时会使对手畏缩。 对目标造成220点伤害。",
					"power": 220,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "bite",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "原始之力",
					"desc": "用原始之力进行攻击。有时会提高自己所有的能力。",
					"detail": "消耗100能量，爆发【原始之力】。用原始之力进行攻击。有时会提高自己所有的能力。 对范围内最多3名敌人造成320点伤害，并施加战术压制。",
					"power": 320,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "ancient_power",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "泥巴射击",
					"desc": "向对手投掷泥块进行攻击。同时降低对手的速度。",
					"detail": "消耗100能量，爆发【泥巴射击】！向对手投掷泥块进行攻击。同时降低对手的速度。 对范围内最多3名敌人造成285点伤害，并施加战术压制。",
					"power": 285,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "mud_slap",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "岩崩",
					"desc": "将大岩石猛烈地撞向对手进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，爆发【岩崩】！将大岩石猛烈地撞向对手进行攻击。有时会使对手畏缩。 对范围内最多2名敌人造成345点伤害，并施加战术压制。",
					"power": 345,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "rock_slide",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "水炮",
					"desc": "向对手猛烈地喷射大量水流进行攻击。",
					"detail": "消耗100能量，释放终极奥义【水炮】！向对手猛烈地喷射大量水流进行攻击。 席卷战场对最多6名敌人造成685点巨额伤害与强力击破！",
					"power": 685,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "hydro_pump",
					"sfx": "water",
					"scale": 0.48
				},
				{
					"name": "角撞",
					"desc": "用尖锐的角攻击对手。",
					"detail": "消耗100能量，释放终极奥义【角撞】！用尖锐的角攻击对手。 席卷战场对最多4名敌人造成505点巨额伤害与强力击破！",
					"power": 505,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "headbutt",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "冲浪",
					"desc": "利用大浪攻击自己周围所有的宝可梦。",
					"detail": "消耗100能量，释放终极奥义【冲浪】！利用大浪攻击自己周围所有的宝可梦。 席卷战场对最多6名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "surf",
					"sfx": "water",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/omanyte.png"
	},
	"omastar": {
		"id": "omastar",
		"name": "多刺菊石兽",
		"title": "螺旋宝可梦",
		"cost": 4,
		"types": ["Rock", "Water"],
		"hp": 1150,
		"atk": 90,
		"armor": 70,
		"mr": 45,
		"range": 2,
		"atk_speed": 0.7,
		"max_mana": 85,
		"desc": "坚硬的螺旋外壳上长出了锋利的尖刺，尖锐如鸟喙般的口齿甚至能咬碎坚硬的大舌贝外壳吸食内部的软体。",
		"skill_name": "原始之力",
		"skill_desc": "用原始之力进行攻击。有时会提高自己所有的能力。",
		"skill_detail": "消耗100能量，使出【原始之力】。用原始之力进行攻击。有时会提高自己所有的能力。 对目标造成198点伤害。",
		"skill_power": 198,
		"basic_attack": {
			"type": "special",
			"name": "魔法弹",
			"style": "spark",
			"sfx": "swift"
		},
						"skills": {
			1: [
				{
					"name": "原始之力",
					"desc": "用原始之力进行攻击。有时会提高自己所有的能力。",
					"detail": "消耗100能量，使出【原始之力】。用原始之力进行攻击。有时会提高自己所有的能力。 对目标造成198点伤害。",
					"power": 198,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "ancient_power",
					"sfx": "skill",
					"scale": 0.28
				},
				{
					"name": "水枪",
					"desc": "向对手猛烈地喷射水流进行攻击。",
					"detail": "消耗100能量，使出【水枪】。向对手猛烈地喷射水流进行攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "water_gun",
					"sfx": "water",
					"scale": 0.82
				},
				{
					"name": "滚动",
					"desc": "在５回合内连续滚动攻击对手。招式每次击中，威力就会提高。",
					"detail": "消耗100能量，使出【滚动】。在５回合内连续滚动攻击对手。招式每次击中，威力就会提高。 对目标造成160点伤害。",
					"power": 160,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "rock_slide",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "尖刺加农炮",
					"desc": "向对手发射锐针进行攻击。连续攻击２～５次。",
					"detail": "消耗100能量，爆发【尖刺加农炮】。向对手发射锐针进行攻击。连续攻击２～５次。 对范围内最多3名敌人造成280点伤害，并施加战术压制。",
					"power": 280,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "pin_missile",
					"sfx": "slash",
					"scale": 0.36
				},
				{
					"name": "泥巴射击",
					"desc": "向对手投掷泥块进行攻击。同时降低对手的速度。",
					"detail": "消耗100能量，爆发【泥巴射击】！向对手投掷泥块进行攻击。同时降低对手的速度。 对范围内最多3名敌人造成285点伤害，并施加战术压制。",
					"power": 285,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "mud_slap",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "角撞",
					"desc": "用尖锐的角攻击对手。",
					"detail": "消耗100能量，爆发【角撞】！用尖锐的角攻击对手。 对范围内最多2名敌人造成315点伤害，并施加战术压制。",
					"power": 315,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "headbutt",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "水炮",
					"desc": "向对手猛烈地喷射大量水流进行攻击。",
					"detail": "消耗100能量，释放终极奥义【水炮】！向对手猛烈地喷射大量水流进行攻击。 席卷战场对最多6名敌人造成685点巨额伤害与强力击破！",
					"power": 685,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "hydro_pump",
					"sfx": "water",
					"scale": 0.48
				},
				{
					"name": "泰山压顶",
					"desc": "用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，释放终极奥义【泰山压顶】！用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。 席卷战场对最多4名敌人造成605点巨额伤害与强力击破！",
					"power": 605,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "冲浪",
					"desc": "利用大浪攻击自己周围所有的宝可梦。",
					"detail": "消耗100能量，释放终极奥义【冲浪】！利用大浪攻击自己周围所有的宝可梦。 席卷战场对最多6名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "surf",
					"sfx": "water",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/omastar.png"
	},
	"kabuto": {
		"id": "kabuto",
		"name": "化石盔",
		"title": "甲壳宝可梦",
		"cost": 2,
		"types": ["Rock", "Water"],
		"hp": 720,
		"atk": 62,
		"armor": 52,
		"mr": 30,
		"range": 1,
		"atk_speed": 0.72,
		"max_mana": 75,
		"desc": "潜伏在三亿年前远古海底的活化石宝可梦，后背坚固硬壳上长有发光的红色眼睛，能够在黑暗的海沟中洞察周围。",
		"skill_name": "抓",
		"skill_desc": "用坚硬且无比锋利的爪子抓对手进行攻击。",
		"skill_detail": "消耗100能量，使出【抓】。用坚硬且无比锋利的爪子抓对手进行攻击。 对目标造成182点伤害。",
		"skill_power": 182,
		"basic_attack": {
			"type": "physical",
			"name": "撞击",
			"style": "tackle",
			"sfx": "attack"
		},
						"skills": {
			1: [
				{
					"name": "抓",
					"desc": "用坚硬且无比锋利的爪子抓对手进行攻击。",
					"detail": "消耗100能量，使出【抓】。用坚硬且无比锋利的爪子抓对手进行攻击。 对目标造成182点伤害。",
					"power": 182,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "slash",
					"sfx": "slash",
					"scale": 0.28
				},
				{
					"name": "吸取",
					"desc": "吸取对手的养分进行攻击。可以回复给予对手伤害的一半ＨＰ。",
					"detail": "消耗100能量，使出【吸取】。吸取对手的养分进行攻击。可以回复给予对手伤害的一半ＨＰ。 对目标造成140点伤害。",
					"power": 140,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "leech_seed",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "泥巴射击",
					"desc": "向对手投掷泥块进行攻击。同时降低对手的速度。",
					"detail": "消耗100能量，使出【泥巴射击】。向对手投掷泥块进行攻击。同时降低对手的速度。 对目标造成210点伤害。",
					"power": 210,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "mud_slap",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "原始之力",
					"desc": "用原始之力进行攻击。有时会提高自己所有的能力。",
					"detail": "消耗100能量，爆发【原始之力】。用原始之力进行攻击。有时会提高自己所有的能力。 对范围内最多3名敌人造成320点伤害，并施加战术压制。",
					"power": 320,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "ancient_power",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "落石",
					"desc": "拿起小岩石，投掷对手进行攻击。",
					"detail": "消耗100能量，爆发【落石】！拿起小岩石，投掷对手进行攻击。 对范围内最多2名敌人造成270点伤害，并施加战术压制。",
					"power": 270,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "rock_throw",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "水炮",
					"desc": "向对手猛烈地喷射大量水流进行攻击。",
					"detail": "消耗100能量，爆发【水炮】！向对手猛烈地喷射大量水流进行攻击。 对范围内最多3名敌人造成450点伤害，并施加战术压制。",
					"power": 450,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "hydro_pump",
					"sfx": "water",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "岩崩",
					"desc": "将大岩石猛烈地撞向对手进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，释放终极奥义【岩崩】！将大岩石猛烈地撞向对手进行攻击。有时会使对手畏缩。 席卷战场对最多6名敌人造成632点巨额伤害与强力击破！",
					"power": 632,
					"target_count": 6,
					"stun_duration": 1.2,
					"vfx": "rock_slide",
					"sfx": "attack",
					"scale": 0.48
				},
				{
					"name": "盐水",
					"desc": "当对手的ＨＰ负伤到一半左右时，招式威力会变成２倍。",
					"detail": "消耗100能量，释放终极奥义【盐水】！当对手的ＨＰ负伤到一半左右时，招式威力会变成２倍。 席卷战场对最多6名敌人造成505点巨额伤害与强力击破！",
					"power": 505,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "water_pulse",
					"sfx": "water",
					"scale": 1.55
				},
				{
					"name": "尖石攻击",
					"desc": "用尖尖的岩石刺入对手进行攻击。容易击中要害。",
					"detail": "消耗100能量，释放终极奥义【尖石攻击】！用尖尖的岩石刺入对手进行攻击。容易击中要害。 席卷战场对最多4名敌人造成680点巨额伤害与强力击破！",
					"power": 680,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "stone_edge",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/kabuto.png"
	},
	"kabutops": {
		"id": "kabutops",
		"name": "镰刀盔",
		"title": "甲壳宝可梦",
		"cost": 4,
		"types": ["Rock", "Water"],
		"hp": 1100,
		"atk": 105,
		"armor": 60,
		"mr": 40,
		"range": 1,
		"atk_speed": 0.85,
		"max_mana": 80,
		"desc": "生活在太古海洋的顶级捕食者，双臂进化成了两把锋利至极的骨质巨镰，能像撕开纸张一样轻易斩断猎物！",
		"skill_name": "原始之力",
		"skill_desc": "用原始之力进行攻击。有时会提高自己所有的能力。",
		"skill_detail": "消耗100能量，使出【原始之力】。用原始之力进行攻击。有时会提高自己所有的能力。 对目标造成198点伤害。",
		"skill_power": 198,
		"basic_attack": {
			"type": "physical",
			"name": "抓击",
			"style": "slash",
			"sfx": "slash"
		},
						"skills": {
			1: [
				{
					"name": "原始之力",
					"desc": "用原始之力进行攻击。有时会提高自己所有的能力。",
					"detail": "消耗100能量，使出【原始之力】。用原始之力进行攻击。有时会提高自己所有的能力。 对目标造成198点伤害。",
					"power": 198,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "ancient_power",
					"sfx": "skill",
					"scale": 0.28
				},
				{
					"name": "吸取",
					"desc": "吸取对手的养分进行攻击。可以回复给予对手伤害的一半ＨＰ。",
					"detail": "消耗100能量，使出【吸取】。吸取对手的养分进行攻击。可以回复给予对手伤害的一半ＨＰ。 对目标造成140点伤害。",
					"power": 140,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "leech_seed",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "泥巴射击",
					"desc": "向对手投掷泥块进行攻击。同时降低对手的速度。",
					"detail": "消耗100能量，使出【泥巴射击】。向对手投掷泥块进行攻击。同时降低对手的速度。 对目标造成210点伤害。",
					"power": 210,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "mud_slap",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "劈开",
					"desc": "用爪子或镰刀等劈开对手进行攻击。容易击中要害。",
					"detail": "消耗100能量，爆发【劈开】。用爪子或镰刀等劈开对手进行攻击。容易击中要害。 对范围内最多3名敌人造成330点伤害，并施加战术压制。",
					"power": 330,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "slash",
					"sfx": "slash",
					"scale": 0.36
				},
				{
					"name": "落石",
					"desc": "拿起小岩石，投掷对手进行攻击。",
					"detail": "消耗100能量，爆发【落石】！拿起小岩石，投掷对手进行攻击。 对范围内最多2名敌人造成270点伤害，并施加战术压制。",
					"power": 270,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "rock_throw",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "水炮",
					"desc": "向对手猛烈地喷射大量水流进行攻击。",
					"detail": "消耗100能量，爆发【水炮】！向对手猛烈地喷射大量水流进行攻击。 对范围内最多3名敌人造成450点伤害，并施加战术压制。",
					"power": 450,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "hydro_pump",
					"sfx": "water",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "尖石攻击",
					"desc": "用尖尖的岩石刺入对手进行攻击。容易击中要害。",
					"detail": "消耗100能量，释放终极奥义【尖石攻击】！用尖尖的岩石刺入对手进行攻击。容易击中要害。 席卷战场对最多6名敌人造成670点巨额伤害与强力击破！",
					"power": 670,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "stone_edge",
					"sfx": "attack",
					"scale": 0.48
				},
				{
					"name": "盐水",
					"desc": "当对手的ＨＰ负伤到一半左右时，招式威力会变成２倍。",
					"detail": "消耗100能量，释放终极奥义【盐水】！当对手的ＨＰ负伤到一半左右时，招式威力会变成２倍。 席卷战场对最多6名敌人造成505点巨额伤害与强力击破！",
					"power": 505,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "water_pulse",
					"sfx": "water",
					"scale": 1.55
				},
				{
					"name": "绞紧",
					"desc": "用力勒紧对手进行攻击。对手的HP越多，威力越大。",
					"detail": "消耗100能量，释放终极奥义【绞紧】！用力勒紧对手进行攻击。对手的HP越多，威力越大。 席卷战场对最多6名敌人造成680点巨额伤害与强力击破！",
					"power": 680,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/kabutops.png"
	},
	"aerodactyl": {
		"id": "aerodactyl",
		"name": "化石翼龙",
		"title": "化石宝可梦",
		"cost": 4,
		"types": ["Rock", "Flying"],
		"hp": 1050,
		"atk": 100,
		"armor": 45,
		"mr": 45,
		"range": 1,
		"atk_speed": 0.9,
		"max_mana": 80,
		"desc": "生活在恐龙时代的远古天空霸主，凭借锯齿般坚硬的利齿咬断猎物的喉咙，高亢清脆的咆哮声能传遍整个天际！",
		"skill_name": "翅膀攻击",
		"skill_desc": "大大地展开美丽的翅膀，将其撞向对手进行攻击。",
		"skill_detail": "消耗100能量，使出【翅膀攻击】。大大地展开美丽的翅膀，将其撞向对手进行攻击。 对目标造成198点伤害。",
		"skill_power": 198,
		"basic_attack": {
			"type": "physical",
			"name": "撞击",
			"style": "tackle",
			"sfx": "attack"
		},
						"skills": {
			1: [
				{
					"name": "翅膀攻击",
					"desc": "大大地展开美丽的翅膀，将其撞向对手进行攻击。",
					"detail": "消耗100能量，使出【翅膀攻击】。大大地展开美丽的翅膀，将其撞向对手进行攻击。 对目标造成198点伤害。",
					"power": 198,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "wing_attack",
					"sfx": "slash",
					"scale": 0.28
				},
				{
					"name": "咬住",
					"desc": "用尖锐的牙咬住对手进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，使出【咬住】。用尖锐的牙咬住对手进行攻击。有时会使对手畏缩。 对目标造成220点伤害。",
					"power": 220,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "bite",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "落石",
					"desc": "拿起小岩石，投掷对手进行攻击。",
					"detail": "消耗100能量，使出【落石】。拿起小岩石，投掷对手进行攻击。 对目标造成200点伤害。",
					"power": 200,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "rock_throw",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "原始之力",
					"desc": "用原始之力进行攻击。有时会提高自己所有的能力。",
					"detail": "消耗100能量，爆发【原始之力】。用原始之力进行攻击。有时会提高自己所有的能力。 对范围内最多3名敌人造成320点伤害，并施加战术压制。",
					"power": 320,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "ancient_power",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "岩崩",
					"desc": "将大岩石猛烈地撞向对手进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，爆发【岩崩】！将大岩石猛烈地撞向对手进行攻击。有时会使对手畏缩。 对范围内最多2名敌人造成345点伤害，并施加战术压制。",
					"power": 345,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "rock_slide",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，爆发【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 对范围内最多2名敌人造成390点伤害，并施加战术压制。",
					"power": 390,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "破坏光线",
					"desc": "向对手发射强烈的光线进行攻击。下一回合自己将无法动弹。",
					"detail": "消耗100能量，释放终极奥义【破坏光线】！向对手发射强烈的光线进行攻击。下一回合自己将无法动弹。 席卷战场对最多6名敌人造成745点巨额伤害与强力击破！",
					"power": 745,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "hyper_beam",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "旋风刀",
					"desc": "制造风之刃，于第２回合攻击对手。容易击中要害。",
					"detail": "消耗100能量，释放终极奥义【旋风刀】！制造风之刃，于第２回合攻击对手。容易击中要害。 席卷战场对最多6名敌人造成580点巨额伤害与强力击破！",
					"power": 580,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "air_slash",
					"sfx": "slash",
					"scale": 1.55
				},
				{
					"name": "终极冲击",
					"desc": "使出自己浑身力量突击对手。下一回合自己将无法动弹。",
					"detail": "消耗100能量，释放终极奥义【终极冲击】！使出自己浑身力量突击对手。下一回合自己将无法动弹。 席卷战场对最多4名敌人造成930点巨额伤害与强力击破！",
					"power": 930,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "giga_impact",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/aerodactyl.png"
	},
	"articuno": {
		"id": "articuno",
		"name": "急冻鸟",
		"title": "冻结宝可梦",
		"cost": 5,
		"types": ["Ice", "Flying"],
		"hp": 1350,
		"atk": 105,
		"armor": 55,
		"mr": 70,
		"range": 3,
		"atk_speed": 0.78,
		"max_mana": 90,
		"desc": "传说中的三大神鸟之一，拍打由纯粹极寒冰晶构成的美丽羽翼，能在寒冬的雪山中降下漫天暴风雪，所过之处万物皆被冰封！",
		"skill_name": "冰砾",
		"skill_desc": "瞬间制作冰块，快速地扔向对手。必定能够先制攻击。",
		"skill_detail": "消耗100能量，使出【冰砾】。瞬间制作冰块，快速地扔向对手。必定能够先制攻击。 对目标造成182点伤害。",
		"skill_power": 182,
		"basic_attack": {
			"type": "special",
			"name": "细雪",
			"style": "spark",
			"sfx": "water"
		},
						"skills": {
			1: [
				{
					"name": "冰砾",
					"desc": "瞬间制作冰块，快速地扔向对手。必定能够先制攻击。",
					"detail": "消耗100能量，使出【冰砾】。瞬间制作冰块，快速地扔向对手。必定能够先制攻击。 对目标造成182点伤害。",
					"power": 182,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "ice_shard",
					"sfx": "skill",
					"scale": 0.28
				},
				{
					"name": "啄",
					"desc": "用尖锐的喙或角刺向对手进行攻击。",
					"detail": "消耗100能量，使出【啄】。用尖锐的喙或角刺向对手进行攻击。 对目标造成170点伤害。",
					"power": 170,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "drill_peck",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "冷冻干燥",
					"desc": "急剧冷冻对手，有时会让对手陷入冰冻状态。对于水属性宝可梦也是效果绝佳。",
					"detail": "消耗100能量，使出【冷冻干燥】。急剧冷冻对手，有时会让对手陷入冰冻状态。对于水属性宝可梦也是效果绝佳。 对目标造成240点伤害。",
					"power": 240,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "icicle_spear",
					"sfx": "water",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "冰冻光束",
					"desc": "向对手发射冰冻光束进行攻击。有时会让对手陷入冰冻状态。",
					"detail": "消耗100能量，爆发【冰冻光束】。向对手发射冰冻光束进行攻击。有时会让对手陷入冰冻状态。 对范围内最多3名敌人造成350点伤害，并施加战术压制。",
					"power": 350,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "ice_beam",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "镜面反射",
					"desc": "从对手那里受到特殊攻击的伤害将以２倍返还给同一个对手。",
					"detail": "消耗100能量，爆发【镜面反射】！从对手那里受到特殊攻击的伤害将以２倍返还给同一个对手。 对范围内最多3名敌人造成320点伤害，并施加战术压制。",
					"power": 320,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "confusion",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "原始之力",
					"desc": "用原始之力进行攻击。有时会提高自己所有的能力。",
					"detail": "消耗100能量，爆发【原始之力】！用原始之力进行攻击。有时会提高自己所有的能力。 对范围内最多3名敌人造成300点伤害，并施加战术压制。",
					"power": 300,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "ancient_power",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "暴风雪",
					"desc": "将猛烈的暴风雪刮向对手进行攻击。有时会让对手陷入冰冻状态。",
					"detail": "消耗100能量，释放终极奥义【暴风雪】！将猛烈的暴风雪刮向对手进行攻击。有时会让对手陷入冰冻状态。 席卷战场对最多6名敌人造成685点巨额伤害与强力击破！",
					"power": 685,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "blizzard",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "神鸟猛击",
					"desc": "第２回合攻击对手。偶尔使对手畏缩。也容易击中要害。",
					"detail": "消耗100能量，释放终极奥义【神鸟猛击】！第２回合攻击对手。偶尔使对手畏缩。也容易击中要害。 席卷战场对最多4名敌人造成880点巨额伤害与强力击破！",
					"power": 880,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "air_slash",
					"sfx": "slash",
					"scale": 1.55
				},
				{
					"name": "飞翔",
					"desc": "第１回合飞上天空，第２回合攻击对手。",
					"detail": "消耗100能量，释放终极奥义【飞翔】！第１回合飞上天空，第２回合攻击对手。 席卷战场对最多4名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "brave_bird",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/articuno.png"
	},
	"zapdos": {
		"id": "zapdos",
		"name": "闪电鸟",
		"title": "电击宝可梦",
		"cost": 5,
		"types": ["Electric", "Flying"],
		"hp": 1350,
		"atk": 110,
		"armor": 50,
		"mr": 65,
		"range": 3,
		"atk_speed": 0.88,
		"max_mana": 85,
		"desc": "传说中的雷神之鸟，栖息于滚滚雷云深处，挥动尖锐如雷电般的金黄羽翼时会迸发万道金色狂雷撕裂苍穹！",
		"skill_name": "电击",
		"skill_desc": "发出电流刺激对手进行攻击。有时会让对手陷入麻痹状态。",
		"skill_detail": "消耗100能量，使出【电击】。发出电流刺激对手进行攻击。有时会让对手陷入麻痹状态。 对目标造成182点伤害。",
		"skill_power": 182,
		"basic_attack": {
			"type": "special",
			"name": "电火花",
			"style": "spark",
			"sfx": "spark"
		},
						"skills": {
			1: [
				{
					"name": "电击",
					"desc": "发出电流刺激对手进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，使出【电击】。发出电流刺激对手进行攻击。有时会让对手陷入麻痹状态。 对目标造成182点伤害。",
					"power": 182,
					"target_count": 1,
					"stun_duration": 0.5,
					"vfx": "thundershock",
					"sfx": "spark",
					"scale": 0.28
				},
				{
					"name": "啄钻",
					"desc": "一边旋转，一边将尖喙刺入对手进行攻击。",
					"detail": "消耗100能量，使出【啄钻】。一边旋转，一边将尖喙刺入对手进行攻击。 对目标造成260点伤害。",
					"power": 260,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "drill_peck",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "啄食",
					"desc": "用喙进行攻击。当对手携带树果时，可以食用并获得其效果。",
					"detail": "消耗100能量，使出【啄食】。用喙进行攻击。当对手携带树果时，可以食用并获得其效果。 对目标造成220点伤害。",
					"power": 220,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "air_slash",
					"sfx": "slash",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "放电",
					"desc": "用耀眼的电击攻击自己周围所有的宝可梦。有时会陷入麻痹状态。",
					"detail": "消耗100能量，爆发【放电】。用耀眼的电击攻击自己周围所有的宝可梦。有时会陷入麻痹状态。 对范围内最多3名敌人造成340点伤害，并施加战术压制。",
					"power": 340,
					"target_count": 3,
					"stun_duration": 0.8,
					"vfx": "discharge",
					"sfx": "thunder",
					"scale": 0.36
				},
				{
					"name": "原始之力",
					"desc": "用原始之力进行攻击。有时会提高自己所有的能力。",
					"detail": "消耗100能量，爆发【原始之力】！用原始之力进行攻击。有时会提高自己所有的能力。 对范围内最多3名敌人造成300点伤害，并施加战术压制。",
					"power": 300,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "ancient_power",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "十万伏特",
					"desc": "向对手发出强力电击进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，爆发【十万伏特】！向对手发出强力电击进行攻击。有时会让对手陷入麻痹状态。 对范围内最多3名敌人造成390点伤害，并施加战术压制。",
					"power": 390,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "thunderbolt",
					"sfx": "thunder",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "打雷",
					"desc": "向对手劈下暴雷进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，释放终极奥义【打雷】！向对手劈下暴雷进行攻击。有时会让对手陷入麻痹状态。 席卷战场对最多6名敌人造成685点巨额伤害与强力击破！",
					"power": 685,
					"target_count": 6,
					"stun_duration": 1.2,
					"vfx": "thunder",
					"sfx": "thunder",
					"scale": 0.48
				},
				{
					"name": "光墙",
					"desc": "利用神奇的墙壁，在５回合内减弱从对手那里受到的特殊攻击的伤害。",
					"detail": "消耗100能量，释放终极奥义【光墙】！利用神奇的墙壁，在５回合内减弱从对手那里受到的特殊攻击的伤害。 席卷战场对最多6名敌人造成680点巨额伤害与强力击破！",
					"power": 680,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "light_screen",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "飞翔",
					"desc": "第１回合飞上天空，第２回合攻击对手。",
					"detail": "消耗100能量，释放终极奥义【飞翔】！第１回合飞上天空，第２回合攻击对手。 席卷战场对最多4名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "brave_bird",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/zapdos.png"
	},
	"moltres": {
		"id": "moltres",
		"name": "火焰鸟",
		"title": "火焰宝可梦",
		"cost": 5,
		"types": ["Fire", "Flying"],
		"hp": 1350,
		"atk": 115,
		"armor": 50,
		"mr": 60,
		"range": 3,
		"atk_speed": 0.82,
		"max_mana": 85,
		"desc": "传说中的火神之鸟，翅膀和冠羽燃烧着永恒不灭的熊熊神火，拍打双翼掠过长空时会洒下温暖炽烈的火星，被称为带来春天的神鸟！",
		"skill_name": "火花",
		"skill_desc": "向对手发射小型火焰进行攻击。有时会让对手陷入灼伤状态。",
		"skill_detail": "消耗100能量，使出【火花】。向对手发射小型火焰进行攻击。有时会让对手陷入灼伤状态。 对目标造成182点伤害。",
		"skill_power": 182,
		"basic_attack": {
			"type": "special",
			"name": "火花",
			"style": "fire_ember",
			"sfx": "fire"
		},
						"skills": {
			1: [
				{
					"name": "火花",
					"desc": "向对手发射小型火焰进行攻击。有时会让对手陷入灼伤状态。",
					"detail": "消耗100能量，使出【火花】。向对手发射小型火焰进行攻击。有时会让对手陷入灼伤状态。 对目标造成182点伤害。",
					"power": 182,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "ember",
					"sfx": "fire",
					"scale": 0.28
				},
				{
					"name": "啄",
					"desc": "用尖锐的喙或角刺向对手进行攻击。",
					"detail": "消耗100能量，使出【啄】。用尖锐的喙或角刺向对手进行攻击。 对目标造成170点伤害。",
					"power": 170,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "drill_peck",
					"sfx": "slash",
					"scale": 0.82
				},
				{
					"name": "起风",
					"desc": "用翅膀将刮起的狂风袭向对手进行攻击。",
					"detail": "消耗100能量，使出【起风】。用翅膀将刮起的狂风袭向对手进行攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "gust",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "热风",
					"desc": "将炎热的气息吹向对手进行攻击。有时会让对手陷入灼伤状态。",
					"detail": "消耗100能量，爆发【热风】。将炎热的气息吹向对手进行攻击。有时会让对手陷入灼伤状态。 对范围内最多3名敌人造成355点伤害，并施加战术压制。",
					"power": 355,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "heat_wave",
					"sfx": "fire",
					"scale": 0.36
				},
				{
					"name": "空气斩",
					"desc": "用连天空也能劈开的空气之刃进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，爆发【空气斩】！用连天空也能劈开的空气之刃进行攻击。有时会使对手畏缩。 对范围内最多3名敌人造成345点伤害，并施加战术压制。",
					"power": 345,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "air_slash",
					"sfx": "slash",
					"scale": 1.10
				},
				{
					"name": "喷射火焰",
					"desc": "向对手发射烈焰进行攻击。有时会让对手陷入灼伤状态。",
					"detail": "消耗100能量，爆发【喷射火焰】！向对手发射烈焰进行攻击。有时会让对手陷入灼伤状态。 对范围内最多3名敌人造成390点伤害，并施加战术压制。",
					"power": 390,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "flamethrower",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "大字爆炎",
					"desc": "用大字形状的火焰烧尽对手。有时会让对手陷入灼伤状态。",
					"detail": "消耗100能量，释放终极奥义【大字爆炎】！用大字形状的火焰烧尽对手。有时会让对手陷入灼伤状态。 席卷战场对最多6名敌人造成685点巨额伤害与强力击破！",
					"power": 685,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "fire_blast",
					"sfx": "fire",
					"scale": 0.48
				},
				{
					"name": "神鸟猛击",
					"desc": "第２回合攻击对手。偶尔使对手畏缩。也容易击中要害。",
					"detail": "消耗100能量，释放终极奥义【神鸟猛击】！第２回合攻击对手。偶尔使对手畏缩。也容易击中要害。 席卷战场对最多4名敌人造成880点巨额伤害与强力击破！",
					"power": 880,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "brave_bird",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，释放终极奥义【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 席卷战场对最多4名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/moltres.png"
	},
	"dratini": {
		"id": "dratini",
		"name": "迷你龙",
		"title": "龙宝可梦",
		"cost": 1,
		"types": ["Dragon"],
		"hp": 550,
		"atk": 52,
		"armor": 25,
		"mr": 25,
		"range": 2,
		"atk_speed": 0.7,
		"max_mana": 70,
		"desc": "自古以来就被视为虚幻幻兽般的存在，栖息在深不见底的瀑布深潭中，通过一次次蜕皮不断成长积蓄龙威。",
		"skill_name": "龙卷风",
		"skill_desc": "兴起龙卷风，将对手卷入进行攻击。有时会使对手畏缩。",
		"skill_detail": "消耗100能量，使出【龙卷风】。兴起龙卷风，将对手卷入进行攻击。有时会使对手畏缩。 对目标造成182点伤害。",
		"skill_power": 182,
		"basic_attack": {
			"type": "special",
			"name": "魔法弹",
			"style": "spark",
			"sfx": "swift"
		},
						"skills": {
			1: [
				{
					"name": "龙卷风",
					"desc": "兴起龙卷风，将对手卷入进行攻击。有时会使对手畏缩。",
					"detail": "消耗100能量，使出【龙卷风】。兴起龙卷风，将对手卷入进行攻击。有时会使对手畏缩。 对目标造成182点伤害。",
					"power": 182,
					"target_count": 1,
					"stun_duration": 0.5,
					"vfx": "twister",
					"sfx": "swift",
					"scale": 0.28
				},
				{
					"name": "紧束",
					"desc": "使用长长的身体或藤蔓等，在４～５回合内紧束对手进行攻击。",
					"detail": "消耗100能量，使出【紧束】。使用长长的身体或藤蔓等，在４～５回合内紧束对手进行攻击。 对目标造成130点伤害。",
					"power": 130,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "泰山压顶",
					"desc": "用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，使出【泰山压顶】。用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。 对目标造成270点伤害。",
					"power": 270,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "龙息",
					"desc": "将强烈的气息吹向对手进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，爆发【龙息】。将强烈的气息吹向对手进行攻击。有时会让对手陷入麻痹状态。 对范围内最多3名敌人造成320点伤害，并施加战术压制。",
					"power": 320,
					"target_count": 3,
					"stun_duration": 0.8,
					"vfx": "dragon_breath",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "破坏光线",
					"desc": "向对手发射强烈的光线进行攻击。下一回合自己将无法动弹。",
					"detail": "消耗100能量，爆发【破坏光线】！向对手发射强烈的光线进行攻击。下一回合自己将无法动弹。 对范围内最多3名敌人造成570点伤害，并施加战术压制。",
					"power": 570,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "hyper_beam",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "龙之俯冲",
					"desc": "释放出骇人的杀气，一边威慑一边撞击对手。有时会使对手畏缩。",
					"detail": "消耗100能量，爆发【龙之俯冲】！释放出骇人的杀气，一边威慑一边撞击对手。有时会使对手畏缩。 对范围内最多2名敌人造成420点伤害，并施加战术压制。",
					"power": 420,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "dragon_claw",
					"sfx": "slash",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "龙之波动",
					"desc": "从大大的口中掀起冲击波攻击对手。",
					"detail": "消耗100能量，释放终极奥义【龙之波动】！从大大的口中掀起冲击波攻击对手。 席卷战场对最多6名敌人造成647点巨额伤害与强力击破！",
					"power": 647,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "dragon_pulse",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，释放终极奥义【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 席卷战场对最多4名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.55
				},
				{
					"name": "舍身冲撞",
					"desc": "拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。",
					"detail": "消耗100能量，释放终极奥义【舍身冲撞】！拼命地猛撞向对手进行攻击。自己也会受到不小的伤害。 席卷战场对最多4名敌人造成780点巨额伤害与强力击破！",
					"power": 780,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "double_edge",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/dratini.png"
	},
	"dragonair": {
		"id": "dragonair",
		"name": "哈克龙",
		"title": "龙宝可梦",
		"cost": 2,
		"types": ["Dragon"],
		"hp": 780,
		"atk": 68,
		"armor": 35,
		"mr": 35,
		"range": 2,
		"atk_speed": 0.75,
		"max_mana": 75,
		"desc": "颈部和尾部各有一颗散发着圣洁幽蓝光芒的水晶宝珠，能随意操控周围的天气变化，在湖面上空优雅飞舞。",
		"skill_name": "龙息",
		"skill_desc": "将强烈的气息吹向对手进行攻击。有时会让对手陷入麻痹状态。",
		"skill_detail": "消耗100能量，使出【龙息】。将强烈的气息吹向对手进行攻击。有时会让对手陷入麻痹状态。 对目标造成198点伤害。",
		"skill_power": 198,
		"basic_attack": {
			"type": "special",
			"name": "魔法弹",
			"style": "spark",
			"sfx": "swift"
		},
						"skills": {
			1: [
				{
					"name": "龙息",
					"desc": "将强烈的气息吹向对手进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，使出【龙息】。将强烈的气息吹向对手进行攻击。有时会让对手陷入麻痹状态。 对目标造成198点伤害。",
					"power": 198,
					"target_count": 1,
					"stun_duration": 0.5,
					"vfx": "dragon_breath",
					"sfx": "skill",
					"scale": 0.28
				},
				{
					"name": "紧束",
					"desc": "使用长长的身体或藤蔓等，在４～５回合内紧束对手进行攻击。",
					"detail": "消耗100能量，使出【紧束】。使用长长的身体或藤蔓等，在４～５回合内紧束对手进行攻击。 对目标造成130点伤害。",
					"power": 130,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "quick_attack",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "摔打",
					"desc": "使用长长的尾巴或藤蔓等摔打对手进行攻击。",
					"detail": "消耗100能量，使出【摔打】。使用长长的尾巴或藤蔓等摔打对手进行攻击。 对目标造成260点伤害。",
					"power": 260,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "dragon_claw",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "龙之波动",
					"desc": "从大大的口中掀起冲击波攻击对手。",
					"detail": "消耗100能量，爆发【龙之波动】。从大大的口中掀起冲击波攻击对手。 对范围内最多3名敌人造成345点伤害，并施加战术压制。",
					"power": 345,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "dragon_pulse",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "破坏光线",
					"desc": "向对手发射强烈的光线进行攻击。下一回合自己将无法动弹。",
					"detail": "消耗100能量，爆发【破坏光线】！向对手发射强烈的光线进行攻击。下一回合自己将无法动弹。 对范围内最多3名敌人造成570点伤害，并施加战术压制。",
					"power": 570,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "hyper_beam",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "泰山压顶",
					"desc": "用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。",
					"detail": "消耗100能量，爆发【泰山压顶】！用整个身体压住对手进行攻击。有时会让对手陷入麻痹状态。 对范围内最多2名敌人造成375点伤害，并施加战术压制。",
					"power": 375,
					"target_count": 2,
					"stun_duration": 0.4,
					"vfx": "body_slam",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "逆鳞",
					"desc": "在２～３回合内，乱打一气地进行攻击。大闹一番后自己会陷入混乱。",
					"detail": "消耗100能量，释放终极奥义【逆鳞】！在２～３回合内，乱打一气地进行攻击。大闹一番后自己会陷入混乱。 席卷战场对最多6名敌人造成700点巨额伤害与强力击破！",
					"power": 700,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "dragon_apocalypse",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "水流尾",
					"desc": "如惊涛骇浪般挥动大尾巴攻击对手。",
					"detail": "消耗100能量，释放终极奥义【水流尾】！如惊涛骇浪般挥动大尾巴攻击对手。 席卷战场对最多4名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "aqua_tail",
					"sfx": "water",
					"scale": 1.55
				},
				{
					"name": "猛撞",
					"desc": "以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。",
					"detail": "消耗100能量，释放终极奥义【猛撞】！以惊人的气势撞向对手进行攻击。自己也会受到少许伤害。 席卷战场对最多4名敌人造成630点巨额伤害与强力击破！",
					"power": 630,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "take_down",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/dragonair.png"
	},
	"mew": {
		"id": "mew",
		"name": "梦幻",
		"title": "新种宝可梦",
		"cost": 5,
		"types": ["Psychic"],
		"hp": 1300,
		"atk": 110,
		"armor": 60,
		"mr": 60,
		"range": 3,
		"atk_speed": 0.9,
		"max_mana": 75,
		"desc": "拥有所有宝可梦的遗传基因，被学者们公认为所有宝可梦的共同始祖，能在空气中自由隐形穿梭，心灵极其纯真无暇！",
		"skill_name": "幻象光线",
		"skill_desc": "向对手发射神奇的光线进行攻击。有时会使对手混乱。",
		"skill_detail": "消耗100能量，使出【幻象光线】。向对手发射神奇的光线进行攻击。有时会使对手混乱。 对目标造成202点伤害。",
		"skill_power": 202,
		"basic_attack": {
			"type": "special",
			"name": "念力波",
			"style": "psywave",
			"sfx": "swift"
		},
						"skills": {
			1: [
				{
					"name": "幻象光线",
					"desc": "向对手发射神奇的光线进行攻击。有时会使对手混乱。",
					"detail": "消耗100能量，使出【幻象光线】。向对手发射神奇的光线进行攻击。有时会使对手混乱。 对目标造成202点伤害。",
					"power": 202,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "psybeam",
					"sfx": "skill",
					"scale": 0.28
				},
				{
					"name": "拍击",
					"desc": "使用长长的尾巴或手等拍打对手进行攻击。",
					"detail": "消耗100能量，使出【拍击】。使用长长的尾巴或手等拍打对手进行攻击。 对目标造成180点伤害。",
					"power": 180,
					"target_count": 1,
					"stun_duration": 0.0,
					"vfx": "tackle",
					"sfx": "skill",
					"scale": 0.82
				},
				{
					"name": "高速星星",
					"desc": "发射星形的光攻击对手。攻击必定会命中。",
					"detail": "消耗100能量，使出【高速星星】。发射星形的光攻击对手。攻击必定会命中。 对目标造成220点伤害。",
					"power": 220,
					"target_count": 2,
					"stun_duration": 0.0,
					"vfx": "swift",
					"sfx": "skill",
					"scale": 0.82
				}
			],
			2: [
				{
					"name": "反射壁",
					"desc": "利用神奇的墙壁，在５回合内减弱从对手那里受到的物理攻击的伤害。",
					"detail": "消耗100能量，爆发【反射壁】。利用神奇的墙壁，在５回合内减弱从对手那里受到的物理攻击的伤害。 对范围内最多3名敌人造成300点伤害，并施加战术压制。",
					"power": 300,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "reflect",
					"sfx": "skill",
					"scale": 0.36
				},
				{
					"name": "精神强念",
					"desc": "向对手发送强大的念力进行攻击。有时会降低对手的特防。",
					"detail": "消耗100能量，爆发【精神强念】！向对手发送强大的念力进行攻击。有时会降低对手的特防。 对范围内最多3名敌人造成390点伤害，并施加战术压制。",
					"power": 390,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "psychic",
					"sfx": "skill",
					"scale": 1.10
				},
				{
					"name": "精神波",
					"desc": "向对手发射神奇的念波进行攻击。每次使用，伤害都会改变。",
					"detail": "消耗100能量，爆发【精神波】！向对手发射神奇的念波进行攻击。每次使用，伤害都会改变。 对范围内最多3名敌人造成320点伤害，并施加战术压制。",
					"power": 320,
					"target_count": 3,
					"stun_duration": 0.4,
					"vfx": "confusion",
					"sfx": "skill",
					"scale": 1.10
				}
			],
			3: [
				{
					"name": "cosmic-singularity",
					"desc": "使出cosmic-singularity攻击敌人。",
					"detail": "消耗100能量，释放终极奥义【cosmic-singularity】！使出cosmic-singularity攻击敌人。 席卷战场对最多6名敌人造成610点巨额伤害与强力击破！",
					"power": 610,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "cosmic_singularity",
					"sfx": "skill",
					"scale": 0.48
				},
				{
					"name": "百万吨重拳",
					"desc": "用充满力量的拳头攻击对手。",
					"detail": "消耗100能量，释放终极奥义【百万吨重拳】！用充满力量的拳头攻击对手。 席卷战场对最多4名敌人造成580点巨额伤害与强力击破！",
					"power": 580,
					"target_count": 4,
					"stun_duration": 0.8,
					"vfx": "mega_punch",
					"sfx": "punch",
					"scale": 1.55
				},
				{
					"name": "波导弹",
					"desc": "从体内产生出波导之力，然后向对手发出。攻击必定会命中。",
					"detail": "消耗100能量，释放终极奥义【波导弹】！从体内产生出波导之力，然后向对手发出。攻击必定会命中。 席卷战场对最多6名敌人造成580点巨额伤害与强力击破！",
					"power": 580,
					"target_count": 6,
					"stun_duration": 0.8,
					"vfx": "aura_sphere",
					"sfx": "skill",
					"scale": 1.55
				}
			]
		},
		"icon": "res://assets/units/mew.png"
	}
}

# Synergy definitions

var synergies: Dictionary = {
	"Fire": {
		"name": "火系",
		"icon": "res://assets/ui/type_fire.png",
		"tiers": [
			{"count": 2, "desc": "友军攻击附加灼烧效果(每秒25真实伤害)，攻速+25%"},
			{"count": 3, "desc": "灼烧伤害提升至每秒60，攻速+50%"}
		]
	},
	"Water": {
		"name": "水系",
		"icon": "res://assets/ui/type_water.png",
		"tiers": [
			{"count": 2, "desc": "友军最大生命值+250，每秒回复2.5%最大生命值"},
			{"count": 4, "desc": "最大生命值+600，每秒回复5%最大生命值"}
		]
	},
	"Grass": {
		"name": "草系",
		"icon": "res://assets/ui/type_grass.png",
		"tiers": [
			{"count": 1, "desc": "自身获得25%普攻全能吸血，护甲+20"}
		]
	},
	"Electric": {
		"name": "电系",
		"icon": "res://assets/ui/type_electric.png",
		"tiers": [
			{"count": 1, "desc": "普攻获得额外+5点法力，每次普攻有25%几率触发弹射闪电"},
			{"count": 2, "desc": "全队攻速+25%，电系普攻触发弹射闪电几率提升至50%"}
		]
	},
	"Psychic": {
		"name": "超能系",
		"icon": "res://assets/ui/type_psychic.png",
		"tiers": [
			{"count": 2, "desc": "全队技能伤害提升+35%"},
			{"count": 3, "desc": "全队技能伤害提升+75%，开局获得30点初始法力"}
		]
	},
	"Fighting": {
		"name": "格斗系",
		"icon": "res://assets/ui/type_fighting.png",
		"tiers": [
			{"count": 1, "desc": "攻击力+30点，暴击几率+30%"},
			{"count": 2, "desc": "攻击力+65点，暴击几率+50%，暴击伤害提升+40%"}
		]
	},
	"Dragon": {
		"name": "龙系",
		"icon": "res://assets/ui/type_dragon.png",
		"tiers": [
			{"count": 2, "desc": "战斗开局获得350点魔免护盾，大招技能伤害+30%"}
		]
	},
	"Normal": {
		"name": "一般系",
		"icon": "res://assets/ui/type_normal.png",
		"tiers": [
			{"count": 1, "desc": "受到伤害减免15%"},
			{"count": 2, "desc": "受到伤害减免25%，每秒回复3%最大生命值"}
		]
	},
	"Ghost": {
		"name": "幽灵系",
		"icon": "res://assets/ui/type_ghost.png",
		"tiers": [
			{"count": 1, "desc": "拥有25%物理闪避几率，攻击无视目标20点护甲"}
		]
	},
	"Poison": {
		"name": "毒系",
		"icon": "res://assets/ui/type_poison.png",
		"tiers": [
			{"count": 2, "desc": "友军普攻与技能附加剧毒，每秒造成25点真实伤害并降低敌方20%双抗"},
			{"count": 4, "desc": "剧毒伤害提升至每秒60点，敌方双抗降低40%"}
		]
	},
	"Bug": {
		"name": "虫系",
		"icon": "res://assets/ui/type_bug.png",
		"tiers": [
			{"count": 2, "desc": "虫系单位攻速+30%，每次普攻获得额外+5点能量"},
			{"count": 4, "desc": "全队攻速+45%，开局获得30点初始能量"}
		]
	},
	"Flying": {
		"name": "飞行系",
		"icon": "res://assets/ui/type_flying.png",
		"tiers": [
			{"count": 2, "desc": "飞行系单位获得25%物理闪避率，移动速度+30%"},
			{"count": 4, "desc": "全队获得30%闪避率，闪避成功时回复自身5%最大生命值"}
		]
	},
	"Ground": {
		"name": "地面系",
		"icon": "res://assets/ui/type_ground.png",
		"tiers": [
			{"count": 2, "desc": "地面系单位攻击附带震荡波，削弱目标30%护甲，自身护甲+30"},
			{"count": 4, "desc": "全队护甲+60，技能伤害附带30%真实破甲伤害"}
		]
	},
	"Rock": {
		"name": "岩石系",
		"icon": "res://assets/ui/type_rock.png",
		"tiers": [
			{"count": 2, "desc": "战斗开始时全队获得300点坚岩护盾，受到暴击伤害降低50%"},
			{"count": 4, "desc": "坚岩护盾提升至650点，护盾存在期间免控并反弹20%受到的伤害"}
		]
	},
	"Ice": {
		"name": "冰系",
		"icon": "res://assets/ui/type_ice.png",
		"tiers": [
			{"count": 2, "desc": "冰系技能使目标减速40%，对受控目标造成伤害提升30%"},
			{"count": 4, "desc": "全队普攻有20%几率冰冻目标1秒，对冰冻目标造成伤害提升60%"}
		]
	}
}

# Shop tier probability curves by player level [tier1, tier2, tier3, tier4, tier5]
var shop_rates: Dictionary = {
	1: [100, 0, 0, 0, 0],
	2: [100, 0, 0, 0, 0],
	3: [75, 25, 0, 0, 0],
	4: [55, 30, 15, 0, 0],
	5: [45, 33, 20, 2, 0],
	6: [30, 40, 25, 5, 0],
	7: [20, 35, 30, 14, 1],
	8: [15, 25, 35, 21, 4],
	9: [10, 15, 30, 35, 10]
}

func get_skill_data(pokemon_id: String, star_level: int = 1, choice_idx: int = 0) -> Dictionary:
	var data = get_pokemon(pokemon_id)
	if data.is_empty():
		return {}
	if data.has("skills") and data["skills"].has(star_level):
		var star_skills = data["skills"][star_level]
		if star_skills is Array:
			if choice_idx >= 0 and choice_idx < star_skills.size():
				return star_skills[choice_idx].duplicate(true)
			elif star_skills.size() > 0:
				return star_skills[0].duplicate(true)
		elif star_skills is Dictionary:
			return star_skills.duplicate(true)
	return {
		"name": data.get("skill_name", ""),
		"desc": data.get("skill_desc", ""),
		"detail": data.get("skill_detail", ""),
		"power": data.get("skill_power", 200),
		"vfx": "thunderbolt",
		"sfx": "skill",
		"scale": 0.4
	}

func get_skill_choices(pokemon_id: String, star_level: int = 1) -> Array:
	var data = get_pokemon(pokemon_id)
	if data.is_empty() or not data.has("skills"):
		return []
	if data["skills"].has(star_level):
		var s = data["skills"][star_level]
		if s is Array:
			return s.duplicate(true)
		elif s is Dictionary:
			return [s.duplicate(true)]
	return []

func get_basic_attack(pokemon_id: String) -> Dictionary:
	var data = get_pokemon(pokemon_id)
	if data.has("basic_attack"):
		return data["basic_attack"].duplicate(true)
	var is_ranged = data.get("range", 1) >= 2
	return {
		"type": "special" if is_ranged else "physical",
		"name": "普通攻击",
		"style": "spark" if is_ranged else "punch",
		"sfx": "swift" if is_ranged else "attack"
	}

func get_pokemon(id: String) -> Dictionary:
	if pokemons.has(id):
		return pokemons[id].duplicate(true)
	return {}

func get_pokemons_by_cost(cost: int) -> Array[String]:
	var result: Array[String] = []
	for pid in pokemons:
		if pokemons[pid]["cost"] == cost:
			result.append(pid)
	return result

# Evolution Chains mapping for all 152 Pokemon
var evolution_chains: Dictionary = {
	"abra": {"next": "kadabra", "stage": 1, "root": "abra"},
	"aerodactyl": {"next": "", "stage": 1, "root": "aerodactyl"},
	"alakazam": {"next": "", "stage": 3, "root": "abra"},
	"arbok": {"next": "", "stage": 2, "root": "ekans"},
	"arcanine": {"next": "", "stage": 2, "root": "growlithe"},
	"articuno": {"next": "", "stage": 1, "root": "articuno"},
	"beedrill": {"next": "", "stage": 3, "root": "weedle"},
	"bellsprout": {"next": "weepinbell", "stage": 1, "root": "bellsprout"},
	"blastoise": {"next": "", "stage": 3, "root": "squirtle"},
	"bulbasaur": {"next": "ivysaur", "stage": 1, "root": "bulbasaur"},
	"butterfree": {"next": "", "stage": 3, "root": "caterpie"},
	"caterpie": {"next": "metapod", "stage": 1, "root": "caterpie"},
	"chansey": {"next": "", "stage": 1, "root": "chansey"},
	"charizard": {"next": "", "stage": 3, "root": "charmander"},
	"charmander": {"next": "charmeleon", "stage": 1, "root": "charmander"},
	"charmeleon": {"next": "charizard", "stage": 2, "root": "charmander"},
	"clefable": {"next": "", "stage": 2, "root": "clefairy"},
	"clefairy": {"next": "clefable", "stage": 1, "root": "clefairy"},
	"cloyster": {"next": "", "stage": 2, "root": "shellder"},
	"cubone": {"next": "marowak", "stage": 1, "root": "cubone"},
	"dewgong": {"next": "", "stage": 2, "root": "seel"},
	"diglett": {"next": "dugtrio", "stage": 1, "root": "diglett"},
	"ditto": {"next": "", "stage": 1, "root": "ditto"},
	"dodrio": {"next": "", "stage": 2, "root": "doduo"},
	"doduo": {"next": "dodrio", "stage": 1, "root": "doduo"},
	"dragonair": {"next": "dragonite", "stage": 2, "root": "dratini"},
	"dragonite": {"next": "", "stage": 3, "root": "dratini"},
	"dratini": {"next": "dragonair", "stage": 1, "root": "dratini"},
	"drowzee": {"next": "hypno", "stage": 1, "root": "drowzee"},
	"dugtrio": {"next": "", "stage": 2, "root": "diglett"},
	"eevee": {"next": "vaporeon", "stage": 1, "root": "eevee", "branches": ["vaporeon", "jolteon", "flareon"]},
	"ekans": {"next": "arbok", "stage": 1, "root": "ekans"},
	"electabuzz": {"next": "", "stage": 1, "root": "electabuzz"},
	"electrode": {"next": "", "stage": 2, "root": "voltorb"},
	"exeggcute": {"next": "exeggutor", "stage": 1, "root": "exeggcute"},
	"exeggutor": {"next": "", "stage": 2, "root": "exeggcute"},
	"farfetchd": {"next": "", "stage": 1, "root": "farfetchd"},
	"fearow": {"next": "", "stage": 2, "root": "spearow"},
	"flareon": {"next": "", "stage": 2, "root": "eevee"},
	"gastly": {"next": "haunter", "stage": 1, "root": "gastly"},
	"gengar": {"next": "", "stage": 3, "root": "gastly"},
	"geodude": {"next": "graveler", "stage": 1, "root": "geodude"},
	"gloom": {"next": "vileplume", "stage": 2, "root": "oddish"},
	"golbat": {"next": "", "stage": 2, "root": "zubat"},
	"goldeen": {"next": "seaking", "stage": 1, "root": "goldeen"},
	"golduck": {"next": "", "stage": 2, "root": "psyduck"},
	"golem": {"next": "", "stage": 3, "root": "geodude"},
	"graveler": {"next": "golem", "stage": 2, "root": "geodude"},
	"grimer": {"next": "muk", "stage": 1, "root": "grimer"},
	"growlithe": {"next": "arcanine", "stage": 1, "root": "growlithe"},
	"gyarados": {"next": "", "stage": 2, "root": "magikarp"},
	"haunter": {"next": "gengar", "stage": 2, "root": "gastly"},
	"hitmonchan": {"next": "", "stage": 1, "root": "hitmonchan"},
	"hitmonlee": {"next": "", "stage": 1, "root": "hitmonlee"},
	"horsea": {"next": "seadra", "stage": 1, "root": "horsea"},
	"hypno": {"next": "", "stage": 2, "root": "drowzee"},
	"ivysaur": {"next": "venusaur", "stage": 2, "root": "bulbasaur"},
	"jigglypuff": {"next": "wigglytuff", "stage": 1, "root": "jigglypuff"},
	"jolteon": {"next": "", "stage": 2, "root": "eevee"},
	"jynx": {"next": "", "stage": 1, "root": "jynx"},
	"kabuto": {"next": "kabutops", "stage": 1, "root": "kabuto"},
	"kabutops": {"next": "", "stage": 2, "root": "kabuto"},
	"kadabra": {"next": "alakazam", "stage": 2, "root": "abra"},
	"kakuna": {"next": "beedrill", "stage": 2, "root": "weedle"},
	"kangaskhan": {"next": "", "stage": 1, "root": "kangaskhan"},
	"kingler": {"next": "", "stage": 2, "root": "krabby"},
	"koffing": {"next": "weezing", "stage": 1, "root": "koffing"},
	"krabby": {"next": "kingler", "stage": 1, "root": "krabby"},
	"lapras": {"next": "", "stage": 1, "root": "lapras"},
	"lickitung": {"next": "", "stage": 1, "root": "lickitung"},
	"lucario": {"next": "", "stage": 1, "root": "lucario"},
	"machamp": {"next": "", "stage": 3, "root": "machop"},
	"machoke": {"next": "machamp", "stage": 2, "root": "machop"},
	"machop": {"next": "machoke", "stage": 1, "root": "machop"},
	"magikarp": {"next": "gyarados", "stage": 1, "root": "magikarp"},
	"magmar": {"next": "", "stage": 1, "root": "magmar"},
	"magnemite": {"next": "magneton", "stage": 1, "root": "magnemite"},
	"magneton": {"next": "", "stage": 2, "root": "magnemite"},
	"mankey": {"next": "primeape", "stage": 1, "root": "mankey"},
	"marowak": {"next": "", "stage": 2, "root": "cubone"},
	"meowth": {"next": "persian", "stage": 1, "root": "meowth"},
	"metapod": {"next": "butterfree", "stage": 2, "root": "caterpie"},
	"mew": {"next": "", "stage": 1, "root": "mew"},
	"mewtwo": {"next": "", "stage": 1, "root": "mewtwo"},
	"moltres": {"next": "", "stage": 1, "root": "moltres"},
	"mr-mime": {"next": "", "stage": 1, "root": "mr-mime"},
	"muk": {"next": "", "stage": 2, "root": "grimer"},
	"nidoking": {"next": "", "stage": 3, "root": "nidoran_m"},
	"nidoqueen": {"next": "", "stage": 3, "root": "nidoran_f"},
	"nidoran_f": {"next": "nidorina", "stage": 1, "root": "nidoran_f"},
	"nidoran_m": {"next": "nidorino", "stage": 1, "root": "nidoran_m"},
	"nidorina": {"next": "nidoqueen", "stage": 2, "root": "nidoran_f"},
	"nidorino": {"next": "nidoking", "stage": 2, "root": "nidoran_m"},
	"ninetales": {"next": "", "stage": 2, "root": "vulpix"},
	"oddish": {"next": "gloom", "stage": 1, "root": "oddish"},
	"omanyte": {"next": "omastar", "stage": 1, "root": "omanyte"},
	"omastar": {"next": "", "stage": 2, "root": "omanyte"},
	"onix": {"next": "", "stage": 1, "root": "onix"},
	"paras": {"next": "parasect", "stage": 1, "root": "paras"},
	"parasect": {"next": "", "stage": 2, "root": "paras"},
	"persian": {"next": "", "stage": 2, "root": "meowth"},
	"pidgeot": {"next": "", "stage": 3, "root": "pidgey"},
	"pidgeotto": {"next": "pidgeot", "stage": 2, "root": "pidgey"},
	"pidgey": {"next": "pidgeotto", "stage": 1, "root": "pidgey"},
	"pikachu": {"next": "raichu", "stage": 1, "root": "pikachu"},
	"pinsir": {"next": "", "stage": 1, "root": "pinsir"},
	"poliwag": {"next": "poliwhirl", "stage": 1, "root": "poliwag"},
	"poliwhirl": {"next": "poliwrath", "stage": 2, "root": "poliwag"},
	"poliwrath": {"next": "", "stage": 3, "root": "poliwag"},
	"ponyta": {"next": "rapidash", "stage": 1, "root": "ponyta"},
	"porygon": {"next": "", "stage": 1, "root": "porygon"},
	"primeape": {"next": "", "stage": 2, "root": "mankey"},
	"psyduck": {"next": "golduck", "stage": 1, "root": "psyduck"},
	"raichu": {"next": "", "stage": 2, "root": "pikachu"},
	"rapidash": {"next": "", "stage": 2, "root": "ponyta"},
	"raticate": {"next": "", "stage": 2, "root": "rattata"},
	"rattata": {"next": "raticate", "stage": 1, "root": "rattata"},
	"rhydon": {"next": "", "stage": 2, "root": "rhyhorn"},
	"rhyhorn": {"next": "rhydon", "stage": 1, "root": "rhyhorn"},
	"sandshrew": {"next": "sandslash", "stage": 1, "root": "sandshrew"},
	"sandslash": {"next": "", "stage": 2, "root": "sandshrew"},
	"scyther": {"next": "", "stage": 1, "root": "scyther"},
	"seadra": {"next": "", "stage": 2, "root": "horsea"},
	"seaking": {"next": "", "stage": 2, "root": "goldeen"},
	"seel": {"next": "dewgong", "stage": 1, "root": "seel"},
	"shellder": {"next": "cloyster", "stage": 1, "root": "shellder"},
	"slowbro": {"next": "", "stage": 2, "root": "slowpoke"},
	"slowpoke": {"next": "slowbro", "stage": 1, "root": "slowpoke"},
	"snorlax": {"next": "", "stage": 1, "root": "snorlax"},
	"spearow": {"next": "fearow", "stage": 1, "root": "spearow"},
	"squirtle": {"next": "wartortle", "stage": 1, "root": "squirtle"},
	"starmie": {"next": "", "stage": 2, "root": "staryu"},
	"staryu": {"next": "starmie", "stage": 1, "root": "staryu"},
	"tangela": {"next": "", "stage": 1, "root": "tangela"},
	"tauros": {"next": "", "stage": 1, "root": "tauros"},
	"tentacool": {"next": "tentacruel", "stage": 1, "root": "tentacool"},
	"tentacruel": {"next": "", "stage": 2, "root": "tentacool"},
	"vaporeon": {"next": "", "stage": 2, "root": "eevee"},
	"venomoth": {"next": "", "stage": 2, "root": "venonat"},
	"venonat": {"next": "venomoth", "stage": 1, "root": "venonat"},
	"venusaur": {"next": "", "stage": 3, "root": "bulbasaur"},
	"victreebel": {"next": "", "stage": 3, "root": "bellsprout"},
	"vileplume": {"next": "", "stage": 3, "root": "oddish"},
	"voltorb": {"next": "electrode", "stage": 1, "root": "voltorb"},
	"vulpix": {"next": "ninetales", "stage": 1, "root": "vulpix"},
	"wartortle": {"next": "blastoise", "stage": 2, "root": "squirtle"},
	"weedle": {"next": "kakuna", "stage": 1, "root": "weedle"},
	"weepinbell": {"next": "victreebel", "stage": 2, "root": "bellsprout"},
	"weezing": {"next": "", "stage": 2, "root": "koffing"},
	"wigglytuff": {"next": "", "stage": 2, "root": "jigglypuff"},
	"zapdos": {"next": "", "stage": 1, "root": "zapdos"},
	"zubat": {"next": "golbat", "stage": 1, "root": "zubat"},
}

func get_next_evolution(pokemon_id: String) -> String:
	if evolution_chains.has(pokemon_id):
		return evolution_chains[pokemon_id].get("next", "")
	return ""

func get_root_pokemon(pokemon_id: String) -> String:
	if evolution_chains.has(pokemon_id):
		return evolution_chains[pokemon_id].get("root", pokemon_id)
	return pokemon_id

func is_base_form(pokemon_id: String) -> bool:
	if evolution_chains.has(pokemon_id):
		return evolution_chains[pokemon_id].get("stage", 1) == 1
	return true

func get_evolution_chain(pokemon_id: String) -> Array[String]:
	var root = get_root_pokemon(pokemon_id)
	var chain: Array[String] = [root]
	var cur = root
	while true:
		var next_p = get_next_evolution(cur)
		if next_p == "" or next_p == cur or chain.has(next_p):
			break
		chain.append(next_p)
		cur = next_p
	return chain

func get_evolution_options(pokemon_id: String) -> Array[String]:
	var root = get_root_pokemon(pokemon_id)
	if evolution_chains.has(root) and evolution_chains[root].has("branches"):
		var branches: Array = evolution_chains[root]["branches"]
		var res: Array[String] = []
		for b in branches:
			if str(b) != pokemon_id:
				res.append(str(b))
		return res
		
	var chain = get_evolution_chain(pokemon_id)
	var idx = chain.find(pokemon_id)
	var options: Array[String] = []
	if idx != -1:
		for i in range(idx + 1, chain.size()):
			options.append(chain[i])
	return options

func get_all_chain_forms(pokemon_id: String) -> Array[String]:
	var root = get_root_pokemon(pokemon_id)
	if evolution_chains.has(root) and evolution_chains[root].has("branches"):
		var res: Array[String] = [root]
		for b in evolution_chains[root]["branches"]:
			res.append(str(b))
		return res
	return get_evolution_chain(pokemon_id)

func get_shop_eligible_pokemons(cost: int) -> Array[String]:
	var result: Array[String] = []
	for pid in pokemons:
		if pokemons[pid].get("cost", 1) == cost and is_base_form(pid):
			result.append(pid)
	if result.is_empty():
		for pid in pokemons:
			if is_base_form(pid):
				result.append(pid)
	return result


var cached_sprite_frames: Dictionary = {}

func get_sprite_frames(pokemon_id: String) -> SpriteFrames:
	if cached_sprite_frames.has(pokemon_id):
		return cached_sprite_frames[pokemon_id]
		
	var sf = SpriteFrames.new()
	var base_dir = "res://assets/units/anim/%s" % pokemon_id
	
	# 1. Idle animation
	sf.add_animation("idle")
	sf.set_animation_loop("idle", true)
	sf.set_animation_speed("idle", 3.0)
	var idle_path = "%s/idle.png" % base_dir
	if ResourceLoader.exists(idle_path):
		sf.add_frame("idle", load(idle_path))
	elif ResourceLoader.exists("%s/walk_0.png" % base_dir):
		sf.add_frame("idle", load("%s/walk_0.png" % base_dir))
		
	var expected_size = Vector2.ZERO
	if sf.get_frame_count("idle") > 0:
		var idle_tex = sf.get_frame_texture("idle", 0)
		if idle_tex:
			expected_size = idle_tex.get_size()
		
	# 2. Walk animation (up to 6 uniform frames)
	sf.add_animation("walk")
	sf.set_animation_loop("walk", true)
	sf.set_animation_speed("walk", 8.0)
	for w_idx in range(6):
		var w_path = "%s/walk_%d.png" % [base_dir, w_idx]
		if ResourceLoader.exists(w_path):
			var tex = load(w_path) as Texture2D
			if tex and (expected_size == Vector2.ZERO or tex.get_size() == expected_size):
				sf.add_frame("walk", tex)
	if sf.get_frame_count("walk") == 0 and sf.get_frame_count("idle") > 0:
		sf.add_frame("walk", sf.get_frame_texture("idle", 0))
		
	# 3. Attack animation (up to 6 uniform frames)
	sf.add_animation("attack")
	sf.set_animation_loop("attack", false)
	sf.set_animation_speed("attack", 14.0)
	for a_idx in range(6):
		var a_path = "%s/attack_%d.png" % [base_dir, a_idx]
		if ResourceLoader.exists(a_path):
			var tex = load(a_path) as Texture2D
			if tex and (expected_size == Vector2.ZERO or tex.get_size() == expected_size):
				sf.add_frame("attack", tex)
	if sf.get_frame_count("attack") == 0 and sf.get_frame_count("idle") > 0:
		sf.add_frame("attack", sf.get_frame_texture("idle", 0))

	# 3.1 Physical Attack animation (up to 6 uniform frames)
	sf.add_animation("attack_physical")
	sf.set_animation_loop("attack_physical", false)
	sf.set_animation_speed("attack_physical", 14.0)
	for p_idx in range(6):
		var p_path = "%s/attack_physical_%d.png" % [base_dir, p_idx]
		if ResourceLoader.exists(p_path):
			var tex = load(p_path) as Texture2D
			if tex and (expected_size == Vector2.ZERO or tex.get_size() == expected_size):
				sf.add_frame("attack_physical", tex)
	if sf.get_frame_count("attack_physical") == 0:
		for i in range(sf.get_frame_count("attack")):
			sf.add_frame("attack_physical", sf.get_frame_texture("attack", i))

	# 3.2 Special Attack animation (up to 6 uniform frames)
	sf.add_animation("attack_special")
	sf.set_animation_loop("attack_special", false)
	sf.set_animation_speed("attack_special", 14.0)
	for s_idx in range(6):
		var s_path = "%s/attack_special_%d.png" % [base_dir, s_idx]
		if ResourceLoader.exists(s_path):
			var tex = load(s_path) as Texture2D
			if tex and (expected_size == Vector2.ZERO or tex.get_size() == expected_size):
				sf.add_frame("attack_special", tex)
	if sf.get_frame_count("attack_special") == 0:
		for i in range(sf.get_frame_count("attack")):
			sf.add_frame("attack_special", sf.get_frame_texture("attack", i))

	# 3.3 Skill Cast animation (up to 6 uniform frames)
	sf.add_animation("cast_skill")
	sf.set_animation_loop("cast_skill", false)
	sf.set_animation_speed("cast_skill", 12.0)
	for c_idx in range(6):
		var c_path = "%s/cast_skill_%d.png" % [base_dir, c_idx]
		if ResourceLoader.exists(c_path):
			var tex = load(c_path) as Texture2D
			if tex and (expected_size == Vector2.ZERO or tex.get_size() == expected_size):
				sf.add_frame("cast_skill", tex)
	if sf.get_frame_count("cast_skill") == 0:
		for i in range(sf.get_frame_count("attack")):
			sf.add_frame("cast_skill", sf.get_frame_texture("attack", i))
		
	# 4. Hurt animation (up to 2 uniform frames)
	sf.add_animation("hurt")
	sf.set_animation_loop("hurt", false)
	sf.set_animation_speed("hurt", 6.0)
	for h_idx in range(2):
		var h_path = "%s/hurt_%d.png" % [base_dir, h_idx]
		if ResourceLoader.exists(h_path):
			var tex = load(h_path) as Texture2D
			if tex and (expected_size == Vector2.ZERO or tex.get_size() == expected_size):
				sf.add_frame("hurt", tex)
	if sf.get_frame_count("hurt") == 0 and sf.get_frame_count("idle") > 0:
		sf.add_frame("hurt", sf.get_frame_texture("idle", 0))
		
	cached_sprite_frames[pokemon_id] = sf
	return sf
