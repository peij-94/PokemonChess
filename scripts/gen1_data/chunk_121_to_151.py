# Gen 1 Pokemon: 121 - 151
POKEMON_CHUNK_5 = {
	"starmie": {
		"num": 121, "id": "starmie", "name": "宝石海星", "title": "谜宝可梦", "cost": 3,
		"types": ["Water", "Psychic"], "hp": 880, "atk": 78, "armor": 42, "mr": 45, "range": 3, "atk_speed": 0.85, "max_mana": 75,
		"desc": "身体中心的红宝石核心如七彩宝石般璀璨闪烁，被称为水中的外星来客。能以极高转速如同齿轮般在水面和空中飞速切割！",
		"skill_name": "精神强念·水炮星爆", "skill_desc": "高速旋转释放超能水炮，造成450点法术伤害并穿透直线。",
		"skill_detail": "消耗75能量，中心红宝石绽放耀眼光谱，整个身躯高速旋转化为超能飞轮，向前方贯穿喷发高压念力水炮，造成450点法术伤害并削弱35%法抗。",
		"skill_power": 450,
		"skills": {
			1: {"name": "高速水之波动", "desc": "旋转发射水弹造成260点伤害。", "detail": "消耗75能量，旋转喷射水之波动造成260点水系法术伤害。", "power": 260, "vfx": "water_gun", "sfx": "water", "scale": 0.38},
			2: {"name": "精神强念·水炮星爆", "desc": "高速旋转发射念力水炮造成450点穿透伤害。", "detail": "消耗75能量，红核闪烁发射超能水炮造成450点直线法伤并碎抗。", "power": 450, "vfx": "psychic", "sfx": "skill", "scale": 0.50},
			3: {"name": "星河璀璨·七宿天晶寂灭轮", "desc": "七彩宝石引爆宇宙星轨，造成1050点毁灭真实伤害并全图禁魔！", "detail": "消耗75能量，宝石核心沟通宇宙外太空神秘星轨，引下七彩星辉洗礼全图，对全场所有敌人造成1050点真实伤害并禁魔2.5秒！", "power": 1050, "vfx": "hyper_beam", "sfx": "skill", "scale": 0.68}
		},
		"visual": {"primary": (130, 85, 175), "secondary": (230, 195, 55), "accent": (225, 45, 45), "eye": (225, 45, 45), "archetype": "star", "features": ["gem"]}
	},
	"mr-mime": {
		"num": 122, "id": "mr-mime", "name": "魔墙人偶", "title": "屏障宝可梦", "cost": 2,
		"types": ["Psychic"], "hp": 740, "atk": 58, "armor": 35, "mr": 50, "range": 2, "atk_speed": 0.70, "max_mana": 80,
		"desc": "擅长默剧哑剧表演，双掌能凝结空气制造出真实存在的不可见透明防护墙，任何蛮力猛攻都会被弹开。",
		"skill_name": "光墙·念力反弹", "skill_desc": "制造透明屏障吸收伤害，反射造成280点伤害并眩晕1秒。",
		"skill_detail": "消耗80能量，双手按压空气凝结出一堵不可见的念力魔墙，抵挡接下来受到的全部伤害并反弹造成280点超能伤害，使攻击者眩晕1秒。",
		"skill_power": 280,
		"skills": {
			1: {"name": "光墙反震", "desc": "生成光墙反震敌人造成180点伤害。", "detail": "消耗80能量，光墙反震造成180点法伤并击退1格。", "power": 180, "vfx": "reflect", "sfx": "skill", "scale": 0.36},
			2: {"name": "光墙·念力反弹", "desc": "制造屏障反弹造成280点伤害并眩晕1秒。", "detail": "消耗80能量，透明屏障吸收伤害并反弹造成280点伤害眩晕1秒。", "power": 280, "vfx": "light_screen", "sfx": "skill", "scale": 0.46},
			3: {"name": "绝对结界·万象镜像封魔境", "desc": "召唤全屏透明镜牢，为全队加400点护盾并禁锢全屏敌人2秒！", "detail": "消耗80能量，哑剧手势缔造绝对空间镜像结界，全体友军获得400点念力护盾，全体敌军被困于无形镜牢禁锢2秒！", "power": 680, "vfx": "hyper_beam", "sfx": "skill", "scale": 0.58}
		},
		"visual": {"primary": (245, 175, 190), "secondary": (245, 245, 250), "accent": (50, 70, 160), "eye": (20, 20, 20), "archetype": "biped", "features": ["ears"]}
	},
	"scyther": {
		"num": 123, "id": "scyther", "name": "飞天螳螂", "title": "螳螂宝可梦", "cost": 3,
		"types": ["Bug", "Flying"], "hp": 860, "atk": 92, "armor": 40, "mr": 35, "range": 1, "atk_speed": 0.88, "max_mana": 70,
		"desc": "拥有锋利胜过名刀的双臂巨大镰刀，能在疾速飞行中斩断眼前的大树，高速移动时甚至只能看到绿色的残影！",
		"skill_name": "连斩·双镰十字绝命切", "skill_desc": "瞬步掠过敌阵挥出十字双镰，造成460点伤害并流血。",
		"skill_detail": "消耗70能量，身形化作绿色闪电瞬步掠至敌军身后，双镰交叉斩出破空十字剑气，造成460点穿透物理伤害并附加3秒剧烈流血（每秒50点真实伤害）。",
		"skill_power": 460,
		"skills": {
			1: {"name": "连斩", "desc": "双镰斩击造成250点物理伤害。", "detail": "消耗70能量，高速双斩造成250点伤害并附带流血。", "power": 250, "vfx": "slash", "sfx": "skill", "scale": 0.38},
			2: {"name": "连斩·双镰十字绝命切", "desc": "十字双镰斩击造成460点穿透伤害并剧烈流血。", "detail": "消耗70能量，瞬步十字绝杀造成460点伤害并流血3秒。", "power": 460, "vfx": "air_slash", "sfx": "skill", "scale": 0.50},
			3: {"name": "极速神锋·千影绝息断天斩", "desc": "化身千道镰影穿梭战场，造成1050点真实暴击伤害！", "detail": "消耗70能量，突破音障化作万千绿色刀光，对全场所有敌人进行无差别千段神速斩击，造成1050点毁灭真实暴击物理伤害！", "power": 1050, "vfx": "brave_bird", "sfx": "skill", "scale": 0.68}
		},
		"visual": {"primary": (100, 195, 80), "secondary": (240, 240, 245), "accent": (60, 140, 50), "eye": (20, 20, 20), "archetype": "biped", "features": ["wings", "scythes"]}
	},
	"jynx": {
		"num": 124, "id": "jynx", "name": "迷唇姐", "title": "人形宝可梦", "cost": 2,
		"types": ["Ice", "Psychic"], "hp": 720, "atk": 62, "armor": 25, "mr": 45, "range": 2, "atk_speed": 0.72, "max_mana": 80,
		"desc": "伴随着充满节奏感的韵律摇曳起舞，看到它跳舞的人也会不由自主地跟着摆动身体，口中能呼出极寒玄冰之息。",
		"skill_name": "恶魔之吻·极度深寒", "skill_desc": "送出冰霜之吻使目标冻结沉睡2秒，造成280点伤害。",
		"skill_detail": "消耗80能量，踏着迷幻舞步向目标送出刺骨寒霜飞吻，造成280点冰/超混合法术伤害，并使目标陷入极度深寒冻结2秒。",
		"skill_power": 280,
		"skills": {
			1: {"name": "冰冻之吻", "desc": "冰霜飞吻造成180点伤害并减速40%。", "detail": "消耗80能量，冰吻造成180点伤害并降低40%移速与攻速。", "power": 180, "vfx": "ice_beam", "sfx": "skill", "scale": 0.36},
			2: {"name": "恶魔之吻·极度深寒", "desc": "送出飞吻造成280点伤害并冻结2秒。", "detail": "消耗80能量，深寒之吻造成280点伤害并冻结目标2秒。", "power": 280, "vfx": "blizzard", "sfx": "skill", "scale": 0.46},
			3: {"name": "冰姬狂舞·万丈极寒夺魄曲", "desc": "曼妙极寒舞步引爆暴风雪，造成700点范围伤害并全屏冰冻1.5秒！", "detail": "消耗80能量，引动九幽极寒冰魄起舞，冰风暴肆虐全场，对所有敌人造成700点法术伤害并全图冰冻1.5秒！", "power": 700, "vfx": "aurora_beam", "sfx": "skill", "scale": 0.58}
		},
		"visual": {"primary": (195, 45, 65), "secondary": (245, 220, 110), "accent": (145, 75, 175), "eye": (20, 20, 20), "archetype": "biped", "features": ["hair", "dress"]}
	},
	"electabuzz": {
		"num": 125, "id": "electabuzz", "name": "电击兽", "title": "电击宝可梦", "cost": 3,
		"types": ["Electric"], "hp": 900, "atk": 85, "armor": 40, "mr": 40, "range": 1, "atk_speed": 0.80, "max_mana": 75,
		"desc": "身体表面总是有电流在噼啪作响，发怒时全身会绽放出耀眼的万丈雷光，最喜欢大口吞食强烈的电流充饥。",
		"skill_name": "雷电拳·雷霆万钧", "skill_desc": "高压雷电缠绕双拳怒砸，造成450点伤害并麻痹2秒。",
		"skill_detail": "消耗75能量，手臂飞速旋转聚集上万伏特的高压暴烈狂雷轰出重拳，造成450点雷电物理伤害并使目标重度麻痹2秒。",
		"skill_power": 450,
		"skills": {
			1: {"name": "雷电拳", "desc": "雷拳轰击造成250点伤害并麻痹1秒。", "detail": "消耗75能量，雷霆拳击造成250点伤害并麻痹1秒。", "power": 250, "vfx": "thunder_punch", "sfx": "electric", "scale": 0.38},
			2: {"name": "雷电拳·雷霆万钧", "desc": "狂暴雷拳造成450点伤害并麻痹2秒。", "detail": "消耗75能量，万伏雷拳造成450点伤害并使目标麻痹2秒。", "power": 450, "vfx": "thunderbolt", "sfx": "electric", "scale": 0.50},
			3: {"name": "雷帝降临·九霄天雷断空灭", "desc": "召唤天劫雷帝虚影轰碎全场，造成1020点真实伤害并全图瘫痪！", "detail": "消耗75能量，肉身化作雷帝核心贯通天际，引九天玄雷万道齐轰敌阵，造成1020点毁灭真实雷伤并瘫痪全场普攻2秒！", "power": 1020, "vfx": "thunder", "sfx": "electric", "scale": 0.68}
		},
		"visual": {"primary": (245, 205, 45), "secondary": (25, 25, 30), "accent": (245, 245, 250), "eye": (20, 20, 20), "archetype": "biped", "features": ["horns", "tail"]}
	},
	"magmar": {
		"num": 126, "id": "magmar", "name": "鸭嘴火兽", "title": "吐火宝可梦", "cost": 3,
		"types": ["Fire"], "hp": 900, "atk": 86, "armor": 38, "mr": 42, "range": 2, "atk_speed": 0.78, "max_mana": 75,
		"desc": "诞生于活火山的火山口深处，全身如岩浆般不断散发出滚烫的热浪，口中能喷射出足以融化一切的千度烈火！",
		"skill_name": "火焰拳·大字爆炎喷吐", "skill_desc": "喷吐赤红大字烈焰，造成460点伤害并全员灼烧。",
		"skill_detail": "消耗75能量，深吸一口气从嘴中喷射出炽热的大字形爆裂烈焰，轰入敌阵造成460点火系范围法术伤害并施加持续3秒的剧烈灼烧。",
		"skill_power": 460,
		"skills": {
			1: {"name": "火焰拳·炎弹", "desc": "轰出火炎弹造成250点伤害并灼烧。", "detail": "消耗75能量，喷吐烈火弹造成250点伤害并灼烧2秒。", "power": 250, "vfx": "fire_punch", "sfx": "fire", "scale": 0.38},
			2: {"name": "火焰拳·大字爆炎喷吐", "desc": "大字烈火造成460点范围伤害并剧烈灼烧。", "detail": "消耗75能量，大字爆炎造成460点范围法术伤害并灼烧3秒。", "power": 460, "vfx": "fire_blast", "sfx": "fire", "scale": 0.50},
			3: {"name": "地心熔核·八荒焚天烈焰劫", "desc": "引爆地底千度岩浆海啸，造成1020点真实伤害并永久熔岩灼烧！", "detail": "消耗75能量，沟通地脉核心唤出翻滚岩浆海啸淹没战场，对所有敌军造成1020点真实火伤并附加持续整场的熔岩灼烧！", "power": 1020, "vfx": "blast_burn", "sfx": "fire", "scale": 0.68}
		},
		"visual": {"primary": (235, 75, 40), "secondary": (245, 195, 55), "accent": (180, 40, 25), "eye": (20, 20, 20), "archetype": "biped", "features": ["tail", "horns"]}
	},
	"pinsir": {
		"num": 127, "id": "pinsir", "name": "凯罗斯", "title": "锹形宝可梦", "cost": 3,
		"types": ["Bug"], "hp": 920, "atk": 96, "armor": 50, "mr": 35, "range": 1, "atk_speed": 0.76, "max_mana": 75,
		"desc": "头顶长着一对巨大且长满尖刺的粗壮大角，一旦夹住猎物就绝不松开，拥有能把坚固大树齐根斩断的惊人巨力！",
		"skill_name": "断头钳·万钧巨力剪切", "skill_desc": "头上巨角死死剪切目标，造成480点物理伤害并碎甲50%。",
		"skill_detail": "消耗75能量，头顶长满倒刺的双角爆发出十万斤神力剪合，重重绞碎目标防御，造成480点巨额物理伤害并粉碎50%护甲持续3秒。",
		"skill_power": 480,
		"skills": {
			1: {"name": "夹住绞杀", "desc": "巨角夹杀造成260点伤害并碎甲25%。", "detail": "消耗75能量，大角夹击造成260点物理伤害并削弱25%护甲。", "power": 260, "vfx": "cross_chop", "sfx": "skill", "scale": 0.38},
			2: {"name": "断头钳·万钧巨力剪切", "desc": "万钧剪切造成480点伤害并碎甲50%。", "detail": "消耗75能量，断头巨剪造成480点物理伤害并撕裂50%护甲。", "power": 480, "vfx": "close_combat", "sfx": "skill", "scale": 0.50},
			3: {"name": "霸王神角·开天辟地断天剪", "desc": "神角斩断虚空，造成1080点真实暴击伤害若目标生命低直接斩杀！", "detail": "消耗75能量，神角爆燃战狂血芒，对前方直线敌军造成1080点毁灭真实暴击物理伤害，若目标生命低于30%直接斩杀！", "power": 1080, "vfx": "dynamic_punch", "sfx": "skill", "scale": 0.68}
		},
		"visual": {"primary": (160, 115, 80), "secondary": (240, 235, 225), "accent": (75, 50, 35), "eye": (20, 20, 20), "archetype": "biped", "features": ["horns"]}
	},
	"tauros": {
		"num": 128, "id": "tauros", "name": "肯泰罗", "title": "暴牛宝可梦", "cost": 3,
		"types": ["Normal"], "hp": 960, "atk": 88, "armor": 48, "mr": 38, "range": 1, "atk_speed": 0.82, "max_mana": 75,
		"desc": "拥有三条甩动有力的尾巴，经常用尾巴抽打自己的身体来鼓舞狂暴战意，一旦开始野蛮奔腾就无人能够阻挡！",
		"skill_name": "猛撞·三尾狂暴冲锋", "skill_desc": "狂暴战牛冲穿敌阵，造成460点穿透物理伤害并击飞。",
		"skill_detail": "消耗75能量，三条尾巴疯狂抽打自身激发狂战血脉，以千军万马之势冲穿直线敌军，造成460点穿透物理伤害并将所有阻挡者击飞1.2秒。",
		"skill_power": 460,
		"skills": {
			1: {"name": "狂暴角撞", "desc": "蛮力角撞造成250点伤害并击退。", "detail": "消耗75能量，牛角猛撞造成250点伤害并击退1格。", "power": 250, "vfx": "slash", "sfx": "skill", "scale": 0.38},
			2: {"name": "猛撞·三尾狂暴冲锋", "desc": "战牛冲锋造成460点穿透伤害并击飞1.2秒。", "detail": "消耗75能量，狂野冲锋贯穿整排造成460点物理伤害并击飞。", "power": 460, "vfx": "brave_bird", "sfx": "skill", "scale": 0.50},
			3: {"name": "万牛奔腾·踏碎山河灭神击", "desc": "唤出千百狂牛虚影踏平全屏，造成1020点真实物理伤害！", "detail": "消耗75能量，引动太古蛮荒牛群之灵踏碎虚空，无数蛮牛践踏全场，对全图所有敌人造成1020点真实物理伤害并震晕2秒！", "power": 1020, "vfx": "earthquake", "sfx": "skill", "scale": 0.68}
		},
		"visual": {"primary": (195, 140, 70), "secondary": (145, 100, 50), "accent": (80, 55, 30), "eye": (20, 20, 20), "archetype": "quadruped", "features": ["horns", "tail"]}
	},
	"magikarp": {
		"num": 129, "id": "magikarp", "name": "鲤鱼王", "title": "鱼宝可梦", "cost": 1,
		"types": ["Water"], "hp": 450, "atk": 25, "armor": 25, "mr": 20, "range": 1, "atk_speed": 0.60, "max_mana": 60,
		"desc": "被称为世界上最弱小的宝可梦，无论在陆地还是水中都只会无力地水溅跃，然而在体内潜藏着蜕变成凶猛神龙的奇迹潜质！",
		"skill_name": "水溅跃·龙门觉醒", "skill_desc": "拼尽全力扑腾水花，获得150护盾并积攒潜能。",
		"skill_detail": "消耗60能量，拼尽全力高高跃起拍击地面，飞溅起微弱水花造成120点伤害，自身获得150点护盾，并为下一次攻击提升50%暴击率。",
		"skill_power": 120,
		"skills": {
			1: {"name": "水溅跃", "desc": "扑腾水花造成120点伤害并获得150护盾。", "detail": "消耗60能量，跃起拍击造成120点伤害并获得150护盾。", "power": 120, "vfx": "water_gun", "sfx": "water", "scale": 0.30},
			2: {"name": "跃龙门·飞流击", "desc": "逆流飞跃造成260点伤害并眩晕目标0.8秒。", "detail": "消耗60能量，奋力飞跃撞击造成260点伤害并眩晕0.8秒。", "power": 260, "vfx": "hydro_pump", "sfx": "water", "scale": 0.40},
			3: {"name": "潜龙在渊·九天真龙怒破天", "desc": "引动体内太古龙祖神血，造成680点巨额真龙伤害与全屏击退！", "detail": "消耗60能量，短暂唤醒真龙之魂化作通天水龙卷，对全屏所有敌人造成680点真实伤害并震退2格！", "power": 680, "vfx": "hydro_cannon", "sfx": "water", "scale": 0.58}
		},
		"visual": {"primary": (235, 80, 45), "secondary": (245, 235, 175), "accent": (240, 200, 50), "eye": (20, 20, 20), "archetype": "fish", "features": ["fins", "tail", "whiskers"]}
	},
	"gyarados": {
		"num": 130, "id": "gyarados", "name": "暴鲤龙", "title": "凶恶宝可梦", "cost": 5,
		"types": ["Water", "Flying"], "hp": 1350, "atk": 115, "armor": 55, "mr": 50, "range": 1, "atk_speed": 0.80, "max_mana": 90,
		"desc": "从弱小的鲤鱼王进化而来的狂暴海龙，体内细胞经历剧烈改变导致性格变得极度残暴，一旦发怒就会毁灭周围的一切城镇！",
		"skill_name": "水炮·龙之怒咆哮", "skill_desc": "引爆怒涛狂澜喷射毁灭水炮，造成720点伤害并击退全屏。",
		"skill_detail": "消耗90能量，仰天发出震耳欲聋的狂暴龙吟，口中汇聚万顷汪洋水能喷射出毁灭水炮，贯穿整片战场造成720点水/龙混合法术伤害并强力击退全场敌军。",
		"skill_power": 720,
		"skills": {
			1: {"name": "水炮怒涛", "desc": "喷射巨流水炮造成420点穿透伤害。", "detail": "消耗90能量，喷射高压水炮造成420点水系伤害。", "power": 420, "vfx": "hydro_pump", "sfx": "water", "scale": 0.48},
			2: {"name": "水炮·龙之怒咆哮", "desc": "龙怒喷射造成720点伤害并击退整排。", "detail": "消耗90能量，水炮轰鸣造成720点混合伤害并强力击退。", "power": 720, "vfx": "dragon_breath", "sfx": "water", "scale": 0.60},
			3: {"name": "太古海皇·翻江倒海天崩寂灭破", "desc": "化身海皇引动灭世大海啸，造成1450点毁灭真实伤害！", "detail": "消耗90能量，龙皇咆哮唤醒毁灭天灾，百丈海啸洗礼整片战场，对全屏所有敌人造成1450点真实毁灭伤害并全员击飞2.5秒！", "power": 1450, "vfx": "hydro_cannon", "sfx": "water", "scale": 0.78}
		},
		"visual": {"primary": (50, 110, 195), "secondary": (245, 230, 170), "accent": (230, 50, 50), "eye": (230, 50, 50), "archetype": "serpentine", "features": ["fins", "horns", "whiskers"]}
	},
	"lapras": {
		"num": 131, "id": "lapras", "name": "拉普拉斯", "title": "乘载宝可梦", "cost": 4,
		"types": ["Water", "Ice"], "hp": 1300, "atk": 85, "armor": 50, "mr": 60, "range": 2, "atk_speed": 0.70, "max_mana": 85,
		"desc": "心地善良聪明伶俐，最喜欢载着人们在大海中悠然航行，能用美妙空灵的歌声在冰海中与远方的同伴互相呼应。",
		"skill_name": "绝对零度·灭亡之歌", "skill_desc": "吟唱冰雪悲歌造成540点伤害，并为全队施加350点坚冰护盾。",
		"skill_detail": "消耗85能量，引吭高歌吟唱空灵绝美的灭亡之歌，席卷极寒冰晶对全场敌人造成540点水/冰法术伤害，同时为全体友军施加350点坚冰护盾并免疫控制3秒。",
		"skill_power": 540,
		"skills": {
			1: {"name": "冰冻光束", "desc": "射出冷气造成320点伤害并减速40%。", "detail": "消耗85能量，发射极寒光束造成320点伤害并减速40%。", "power": 320, "vfx": "ice_beam", "sfx": "skill", "scale": 0.42},
			2: {"name": "绝对零度·灭亡之歌", "desc": "空灵歌声造成540点伤害并为全队加350护盾。", "detail": "消耗85能量，冰雪歌声造成540点伤害并为全体施加350坚冰护盾。", "power": 540, "vfx": "perish_song", "sfx": "skill", "scale": 0.54},
			3: {"name": "神圣冰皇·万载玄冰永生界", "desc": "极北冰川降临，造成1250点真实伤害并全图冻结2.5秒！", "detail": "消耗85能量，引动太古冰皇圣歌，千里冰川冻结全场，对所有敌人造成1250点真实伤害并绝对冰冻2.5秒，全体友军回血600点！", "power": 1250, "vfx": "blizzard", "sfx": "skill", "scale": 0.72}
		},
		"visual": {"primary": (70, 140, 215), "secondary": (245, 240, 215), "accent": (100, 105, 115), "eye": (20, 20, 20), "archetype": "quadruped", "features": ["shell", "horns", "ears"]}
	},
	"ditto": {
		"num": 132, "id": "ditto", "name": "百变怪", "title": "变身宝可梦", "cost": 2,
		"types": ["Normal"], "hp": 750, "atk": 60, "armor": 35, "mr": 35, "range": 1, "atk_speed": 0.70, "max_mana": 60,
		"desc": "身体由能够自由重组的黏液细胞构成，能瞬间重组体内的遗传基因，变身成为眼前看到的任何宝可梦一模一样的形态！",
		"skill_name": "变身·基因复制", "skill_desc": "完美复制敌方最强单位攻击力与护甲，造成260点伤害。",
		"skill_detail": "消耗60能量，重组自身细胞复制当前目标30%的攻击力与双抗加持于自身，并轰出一击造成260点真实物理伤害。",
		"skill_power": 260,
		"skills": {
			1: {"name": "黏液拍击", "desc": "黏液攻击造成180点物理伤害。", "detail": "消耗60能量，重组身躯拍击造成180点伤害。", "power": 180, "vfx": "slash", "sfx": "skill", "scale": 0.32},
			2: {"name": "变身·基因复制", "desc": "偷取目标30%攻防造成260点伤害。", "detail": "消耗60能量，复制目标30%双抗与攻击并造成260点真实伤害。", "power": 260, "vfx": "transform", "sfx": "skill", "scale": 0.44},
			3: {"name": "千变万化·无相混元万神化身", "desc": "化身全能幻神，获得500全属护盾并复制全屏技能轰炸！", "detail": "消耗60能量，觉醒无相造物神能，获得500点全能生命护盾，并对全场敌人释放混沌裂变造成680点毁灭真实伤害！", "power": 680, "vfx": "hyper_beam", "sfx": "skill", "scale": 0.58}
		},
		"visual": {"primary": (195, 140, 210), "secondary": (160, 100, 175), "accent": (130, 75, 145), "eye": (20, 20, 20), "archetype": "blob", "features": ["blob"]}
	},
	"eevee": {
		"num": 133, "id": "eevee", "name": "伊布", "title": "进化宝可梦", "cost": 1,
		"types": ["Normal"], "hp": 550, "atk": 52, "armor": 25, "mr": 25, "range": 1, "atk_speed": 0.75, "max_mana": 70,
		"desc": "体内蕴含着极其不稳定的奇迹基因，能根据周围环境的辐射进化成多种不同属性的形态，拥有无限的潜能。",
		"skill_name": "高速星星·萌力全开", "skill_desc": "释放漫天闪耀星光，造成180点穿透伤害并鼓舞自身。",
		"skill_detail": "消耗70能量，摇曳毛茸茸的尾巴向目标发射璀璨的高速星光，造成180点物理法术混合伤害，并使自身攻速提升30%持续3秒。",
		"skill_power": 180,
		"skills": {
			1: {"name": "高速星星", "desc": "射出闪光星弹造成180点伤害且必中。", "detail": "消耗70能量，发射高速星星造成180点伤害并提升攻速。", "power": 180, "vfx": "swift", "sfx": "skill", "scale": 0.32},
			2: {"name": "祈愿·三重属性脉冲", "desc": "水火雷三色脉冲造成320点伤害并回血150点。", "detail": "消耗70能量，激发水火雷三色潜能造成320点伤害并回血150点。", "power": 320, "vfx": "quick_attack", "sfx": "skill", "scale": 0.42},
			3: {"name": "九彩升华·伊布奇迹全开劫", "desc": "八系潜能全开轰出彩虹天幕，造成650点真实伤害并全队加攻30%！", "detail": "消耗70能量，引动体内八系进化祖符共鸣，降下九彩天幕轰击全场，造成650点真实伤害，全队攻击力提升30%持续5秒！", "power": 650, "vfx": "hyper_beam", "sfx": "skill", "scale": 0.56}
		},
		"visual": {"primary": (185, 135, 80), "secondary": (245, 235, 210), "accent": (130, 85, 45), "eye": (30, 25, 20), "archetype": "quadruped", "features": ["ears", "tail", "fur"]}
	},
	"vaporeon": {
		"num": 134, "id": "vaporeon", "name": "水伊布", "title": "吐水宝可梦", "cost": 3,
		"types": ["Water"], "hp": 1100, "atk": 74, "armor": 42, "mr": 48, "range": 2, "atk_speed": 0.72, "max_mana": 80,
		"desc": "细胞结构极其酷似水分子，能完全溶化在清澈的水中悄无声息地接近对手，尾鳍长有美丽的鱼鳍尾巴。",
		"skill_name": "溶化·极光水炮", "skill_desc": "身躯溶化潜入水中躲避伤害，随后喷射高压水炮造成440点伤害。",
		"skill_detail": "消耗80能量，身躯瞬间溶化于水流中规避一切攻击1秒，随后从水花中跃起喷发极光高压水炮，对目标造成440点水系法术伤害。",
		"skill_power": 440,
		"skills": {
			1: {"name": "水之波动", "desc": "喷射水浪造成250点伤害并减速30%。", "detail": "消耗80能量，水波冲击造成250点伤害并减速30%。", "power": 250, "vfx": "water_gun", "sfx": "water", "scale": 0.38},
			2: {"name": "溶化·极光水炮", "desc": "溶化无敌1秒并喷射水炮造成440点伤害。", "detail": "消耗80能量，遁入水中1秒后喷出水炮造成440点伤害。", "power": 440, "vfx": "hydro_pump", "sfx": "water", "scale": 0.50},
			3: {"name": "碧水清辉·太虚灵泉润物劫", "desc": "召唤圣泉冲刷战场，造成1000点伤害并为全队回血500点！", "detail": "消耗80能量，化作汪洋圣水狂澜洗涤全场，对所有敌军造成1000点真实伤害，并为全队友军恢复500点生命值！", "power": 1000, "vfx": "hydro_cannon", "sfx": "water", "scale": 0.68}
		},
		"visual": {"primary": (70, 160, 215), "secondary": (240, 240, 245), "accent": (40, 110, 180), "eye": (20, 20, 20), "archetype": "quadruped", "features": ["ears", "tail", "fins"]}
	},
	"jolteon": {
		"num": 135, "id": "jolteon", "name": "雷伊布", "title": "雷宝可梦", "cost": 3,
		"types": ["Electric"], "hp": 850, "atk": 86, "armor": 35, "mr": 42, "range": 2, "atk_speed": 0.95, "max_mana": 70,
		"desc": "毛发全部竖起时就像锋利坚硬的钢针一样，体内产生一万伏特的高压电荷，咆哮时会迸射出无数道耀眼电弧！",
		"skill_name": "飞弹针·万伏雷暴针", "skill_desc": "全身钢针毛发裹带高压电激射，造成450点穿透雷伤并麻痹。",
		"skill_detail": "消耗70能量，全身尖锐针毛竖立并充盈金色强电流，化作暴雨般的闪电飞针扫射前方，造成450点穿透雷电伤害并麻痹所有被命中敌人1.5秒。",
		"skill_power": 450,
		"skills": {
			1: {"name": "电光一闪·雷针", "desc": "雷针刺出造成250点伤害并麻痹。", "detail": "消耗70能量，射出雷电飞针造成250点伤害并麻痹1秒。", "power": 250, "vfx": "thunderbolt", "sfx": "electric", "scale": 0.38},
			2: {"name": "飞弹针·万伏雷暴针", "desc": "雷暴针雨造成450点穿透伤害并麻痹1.5秒。", "detail": "消耗70能量，万伏雷针造成450点穿透伤害并麻痹1.5秒。", "power": 450, "vfx": "pin_missile", "sfx": "electric", "scale": 0.50},
			3: {"name": "九天雷煞·狂雷极速诛神刺", "desc": "化身金色狂雷穿刺全屏，造成1050点毁灭真实雷伤！", "detail": "消耗70能量，身化金色流星电光瞬间贯穿全场所有敌军，造成1050点毁灭真实雷伤并使全员瘫痪2秒！", "power": 1050, "vfx": "thunder", "sfx": "electric", "scale": 0.68}
		},
		"visual": {"primary": (245, 215, 50), "secondary": (245, 245, 250), "accent": (30, 30, 30), "eye": (20, 20, 20), "archetype": "quadruped", "features": ["ears", "tail", "fur"]}
	},
	"flareon": {
		"num": 136, "id": "flareon", "name": "火伊布", "title": "火宝可梦", "cost": 3,
		"types": ["Fire"], "hp": 880, "atk": 98, "armor": 38, "mr": 45, "range": 1, "atk_speed": 0.78, "max_mana": 75,
		"desc": "蓬松的毛发能向空气中散发高达900度的惊人热量，体内拥有特殊的火焰袋，深吸一口气就能吐出炽热烈火！",
		"skill_name": "闪焰冲锋·千度焚天爆", "skill_desc": "全身燃起九百度烈火猛烈撞击，造成480点伤害并永久灼烧。",
		"skill_detail": "消耗75能量，体内火焰袋瞬间达到沸点，化作一团滚烫火球撞穿目标，造成480点暴击火系伤害，并使其受到永久灼烧效果（每秒40点真实伤害）。",
		"skill_power": 480,
		"skills": {
			1: {"name": "火花牙", "desc": "燃火撕咬造成260点伤害并灼烧。", "detail": "消耗75能量，炽热火齿撕咬造成260点伤害并灼烧2秒。", "power": 260, "vfx": "ember", "sfx": "fire", "scale": 0.38},
			2: {"name": "闪焰冲锋·千度焚天爆", "desc": "九百度烈火撞击造成480点伤害并永久灼烧。", "detail": "消耗75能量，烈焰冲锋造成480点火系伤害并永久灼烧。", "power": 480, "vfx": "flare_blitz", "sfx": "fire", "scale": 0.50},
			3: {"name": "三昧真火·太古炎帝涅槃劫", "desc": "引爆千度烈阳神焰焚尽八荒，造成1080点真实火焰伤害！", "detail": "消耗75能量，怒火冲天引动炎帝涅槃圣火，漫天火柱从地底喷发，对所有敌军造成1080点毁灭真实火伤并全员击退！", "power": 1080, "vfx": "blast_burn", "sfx": "fire", "scale": 0.68}
		},
		"visual": {"primary": (235, 105, 45), "secondary": (250, 225, 155), "accent": (210, 50, 20), "eye": (20, 20, 20), "archetype": "quadruped", "features": ["ears", "tail", "fur"]}
	},
	"porygon": {
		"num": 137, "id": "porygon", "name": "多边兽", "title": "虚拟宝可梦", "cost": 2,
		"types": ["Normal"], "hp": 700, "atk": 65, "armor": 35, "mr": 40, "range": 3, "atk_speed": 0.72, "max_mana": 70,
		"desc": "由最顶尖的科学家运用完全的代码数据制造出的虚拟宝可梦，能随意穿梭在计算机网络之中自由畅游。",
		"skill_name": "纹理改变·三重攻击", "skill_desc": "射出虚拟数据光束造成280点伤害，随机附加火冰雷异常。",
		"skill_detail": "消耗70能量，改写自身代码纹理，向目标发射交织着火冰电三原色的数据光波，造成280点法术伤害并随机附加冰冻、灼烧或麻痹2秒。",
		"skill_power": 280,
		"skills": {
			1: {"name": "数据光波", "desc": "射出数据光波造成190点伤害。", "detail": "消耗70能量，虚拟数据弹造成190点普通法术伤害。", "power": 190, "vfx": "swift", "sfx": "skill", "scale": 0.36},
			2: {"name": "纹理改变·三重攻击", "desc": "三重光束造成280点伤害并随机附加异常。", "detail": "消耗70能量，三色数据光波造成280点伤害并随机附加强力异常。", "power": 280, "vfx": "tri_attack", "sfx": "skill", "scale": 0.46},
			3: {"name": "代码崩坏·赛博空间大清除", "desc": "格式化敌方数据，造成680点真实伤害并抹除其全部增益！", "detail": "消耗70能量，引爆赛博空间降维打击，对全场所有敌人造成680点真实伤害，并强制抹除目标身上全部护盾与增益状态！", "power": 680, "vfx": "hyper_beam", "sfx": "skill", "scale": 0.60}
		},
		"visual": {"primary": (230, 80, 110), "secondary": (60, 160, 215), "accent": (40, 40, 45), "eye": (20, 20, 20), "archetype": "avian", "features": ["tail", "poly"]}
	},
	"omanyte": {
		"num": 138, "id": "omanyte", "name": "菊石兽", "title": "螺旋宝可梦", "cost": 2,
		"types": ["Rock", "Water"], "hp": 720, "atk": 56, "armor": 50, "mr": 30, "range": 2, "atk_speed": 0.65, "max_mana": 80,
		"desc": "由古代化石中复活的远古宝可梦，依靠背上十根柔软的触须和坚硬的螺旋贝壳在远古沧海中乘风破浪。",
		"skill_name": "原始之力·螺旋水枪", "skill_desc": "召唤古岩石投掷并喷射急流，造成270点伤害并提升自身双抗。",
		"skill_detail": "消耗80能量，沟通太古海洋远古之力，召唤坚岩与急流螺旋轰向目标，造成270点岩石/水法术伤害，并使自身双抗提升25%持续4秒。",
		"skill_power": 270,
		"skills": {
			1: {"name": "水枪古岩", "desc": "发射古岩水流造成180点伤害。", "detail": "消耗80能量，急流喷射造成180点岩石水系伤害。", "power": 180, "vfx": "ancient_power", "sfx": "water", "scale": 0.36},
			2: {"name": "原始之力·螺旋水枪", "desc": "古岩水枪造成270点伤害并自身双抗+25%。", "detail": "消耗80能量，远古之力造成270点伤害并提升25%双抗。", "power": 270, "vfx": "water_gun", "sfx": "water", "scale": 0.46},
			3: {"name": "太古沧海·万劫螺旋覆天劫", "desc": "召唤远古沧海浪潮破灭敌阵，造成680点伤害并眩晕全员1.5秒！", "detail": "消耗80能量，唤醒太古沧海古神虚影，巨型浪潮挟带亿万古岩冲刷全场，造成680点法术伤害并眩晕全员1.5秒！", "power": 680, "vfx": "hydro_pump", "sfx": "water", "scale": 0.58}
		},
		"visual": {"primary": (80, 160, 220), "secondary": (245, 235, 210), "accent": (140, 115, 80), "eye": (20, 20, 20), "archetype": "shell", "features": ["shell", "tentacles"]}
	},
	"omastar": {
		"num": 139, "id": "omastar", "name": "多刺菊石兽", "title": "螺旋宝可梦", "cost": 4,
		"types": ["Rock", "Water"], "hp": 1150, "atk": 90, "armor": 70, "mr": 45, "range": 2, "atk_speed": 0.70, "max_mana": 85,
		"desc": "坚硬的螺旋外壳上长出了锋利的尖刺，尖锐如鸟喙般的口齿甚至能咬碎坚硬的大舌贝外壳吸食内部的软体。",
		"skill_name": "水炮·远古万刺穿甲破", "skill_desc": "贝壳尖刺与暴烈水炮齐射，造成550点伤害并碎甲50%。",
		"skill_detail": "消耗85能量，贝壳上数根坚硬古刺化作破甲飞矛，伴随暴怒水炮狂轰目标阵列，造成550点巨额混合伤害并粉碎50%护甲持续3秒。",
		"skill_power": 550,
		"skills": {
			1: {"name": "原始水炮", "desc": "喷射高压水炮造成320点伤害并碎甲25%。", "detail": "消耗85能量，原始水炮造成320点伤害并削弱25%护甲。", "power": 320, "vfx": "ancient_power", "sfx": "water", "scale": 0.42},
			2: {"name": "水炮·远古万刺穿甲破", "desc": "万刺水炮造成550点穿甲伤害并碎甲50%。", "detail": "消耗85能量，古刺与水炮合击造成550点伤害并碎甲50%。", "power": 550, "vfx": "hydro_pump", "sfx": "water", "scale": 0.54},
			3: {"name": "太古深渊海妖·八荒破灭灭世刺", "desc": "引爆远古海渊万丈神刺，造成1250点真实伤害与全员穿透！", "detail": "消耗85能量，引动太古深渊古神之威，万丈刺甲神芒破浪而出，对全图所有敌人造成1250点毁灭真实伤害并全图击退！", "power": 1250, "vfx": "hydro_cannon", "sfx": "water", "scale": 0.70}
		},
		"visual": {"primary": (75, 150, 210), "secondary": (245, 235, 210), "accent": (135, 110, 75), "eye": (20, 20, 20), "archetype": "shell", "features": ["shell", "tentacles", "horns"]}
	},
	"kabuto": {
		"num": 140, "id": "kabuto", "name": "化石盔", "title": "甲壳宝可梦", "cost": 2,
		"types": ["Rock", "Water"], "hp": 720, "atk": 62, "armor": 52, "mr": 30, "range": 1, "atk_speed": 0.72, "max_mana": 75,
		"desc": "潜伏在三亿年前远古海底的活化石宝可梦，后背坚固硬壳上长有发光的红色眼睛，能够在黑暗的海沟中洞察周围。",
		"skill_name": "吸取·硬化甲壳重击", "skill_desc": "硬化身体撞击造成270点伤害，并将50%转化为自身回复。",
		"skill_detail": "消耗75能量，将四肢缩入金刚石般的坚硬甲壳内撞击目标，造成270点岩石物理伤害，并将造成的50%伤害转化为自身治疗。",
		"skill_power": 270,
		"skills": {
			1: {"name": "甲壳冲击", "desc": "坚甲撞击造成180点伤害并吸血30%。", "detail": "消耗75能量，坚甲撞击造成180点伤害并回血30%。", "power": 180, "vfx": "ancient_power", "sfx": "skill", "scale": 0.36},
			2: {"name": "吸取·硬化甲壳重击", "desc": "硬化重击造成270点伤害并吸血50%。", "detail": "消耗75能量，硬化撞击造成270点伤害并回血50%。", "power": 270, "vfx": "rock_slide", "sfx": "skill", "scale": 0.46},
			3: {"name": "太古冥甲·三亿年古神护佑劫", "desc": "激发古甲神威造成680点物理伤害，并获400点绝对格挡盾！", "detail": "消耗75能量，唤醒三亿年前古神甲胄，震裂大地造成680点物理伤害，并为自身施加400点绝对格挡护盾持续5秒！", "power": 680, "vfx": "earthquake", "sfx": "skill", "scale": 0.58}
		},
		"visual": {"primary": (145, 100, 60), "secondary": (25, 25, 30), "accent": (220, 45, 45), "eye": (220, 45, 45), "archetype": "shell", "features": ["shell"]}
	},
	"kabutops": {
		"num": 141, "id": "kabutops", "name": "镰刀盔", "title": "甲壳宝可梦", "cost": 4,
		"types": ["Rock", "Water"], "hp": 1100, "atk": 105, "armor": 60, "mr": 40, "range": 1, "atk_speed": 0.85, "max_mana": 80,
		"desc": "生活在太古海洋的顶级捕食者，双臂进化成了两把锋利至极的骨质巨镰，能像撕开纸张一样轻易斩断猎物！",
		"skill_name": "修罗双镰·绝命水刃破", "skill_desc": "双镰斩出破空水刃造成580点伤害，附带50%暴击与吸血。",
		"skill_detail": "消耗80能量，双臂骨质巨镰高速舞动交叉斩出狂暴水刃，造成580点巨额物理伤害，本技能拥有50%额外暴击率，并将造成伤害的50%转化为自身治疗。",
		"skill_power": 580,
		"skills": {
			1: {"name": "骨镰斩击", "desc": "锋利双镰造成320点物理伤害并吸血30%。", "detail": "消耗80能量，巨镰斩击造成320点伤害并吸血30%。", "power": 320, "vfx": "slash", "sfx": "skill", "scale": 0.42},
			2: {"name": "修罗双镰·绝命水刃破", "desc": "水刃狂斩造成580点伤害，50%暴击与吸血。", "detail": "消耗80能量，双镰水刃造成580点伤害，附带50%暴击吸血。", "power": 580, "vfx": "air_slash", "sfx": "skill", "scale": 0.54},
			3: {"name": "太古猎皇·万刃绝杀断沧海", "desc": "化身太古死神斩出千重刀芒，造成1300点真实暴击伤害！", "detail": "消耗80能量，觉醒远古海洋霸主杀伐意境，斩碎虚空引动九天刀浪，对全场所有敌人造成1300点毁灭真实暴击物理伤害并必定斩杀虚弱目标！", "power": 1300, "vfx": "dynamic_punch", "sfx": "skill", "scale": 0.72}
		},
		"visual": {"primary": (140, 95, 55), "secondary": (240, 240, 245), "accent": (25, 25, 30), "eye": (20, 20, 20), "archetype": "biped", "features": ["scythes", "shell"]}
	},
	"aerodactyl": {
		"num": 142, "id": "aerodactyl", "name": "化石翼龙", "title": "化石宝可梦", "cost": 4,
		"types": ["Rock", "Flying"], "hp": 1050, "atk": 100, "armor": 45, "mr": 45, "range": 1, "atk_speed": 0.90, "max_mana": 80,
		"desc": "生活在恐龙时代的远古天空霸主，凭借锯齿般坚硬的利齿咬断猎物的喉咙，高亢清脆的咆哮声能传遍整个天际！",
		"skill_name": "原始之力·破空神速俯冲", "skill_desc": "从万米高空极速俯冲轰炸敌阵，造成560点伤害并全员击退。",
		"skill_detail": "消耗80能量，振动双翼冲入九霄云外，以流星之势携万钧巨岩俯冲轰炸敌阵中心，造成560点大范围物理伤害并强力击退所有敌人1.5格。",
		"skill_power": 560,
		"skills": {
			1: {"name": "岩崩俯冲", "desc": "利爪俯冲造成320点物理伤害并击退。", "detail": "消耗80能量，利爪俯冲造成320点伤害并击退1格。", "power": 320, "vfx": "ancient_power", "sfx": "skill", "scale": 0.42},
			2: {"name": "原始之力·破空神速俯冲", "desc": "九霄俯冲轰炸造成560点范围伤害并击退。", "detail": "消耗80能量，神速俯冲造成560点物理伤害并击退全员。", "power": 560, "vfx": "brave_bird", "sfx": "skill", "scale": 0.54},
			3: {"name": "远古空皇·裂地崩天狂龙啸", "desc": "天空霸主怒鸣引爆天外流星雨，造成1280点毁灭真实伤害！", "detail": "消耗80能量，咆哮唤醒太古苍穹威能，召唤漫天燃烧的远古流星陨石雨轰砸战场，造成1280点真实伤害并全图眩晕2秒！", "power": 1280, "vfx": "hyper_beam", "sfx": "skill", "scale": 0.72}
		},
		"visual": {"primary": (175, 165, 185), "secondary": (125, 75, 145), "accent": (30, 30, 35), "eye": (20, 20, 20), "archetype": "avian", "features": ["wings", "tail", "teeth"]}
	},
	"snorlax": {
		"num": 143, "id": "snorlax", "name": "卡比兽", "title": "瞌睡宝可梦", "cost": 5,
		"types": ["Normal"], "hp": 1600, "atk": 95, "armor": 65, "mr": 65, "range": 1, "atk_speed": 0.60, "max_mana": 100,
		"desc": "一天只要吃下400公斤的食物就会心满意足地呼呼大睡，身体极其庞大厚实，即使小孩子在它的肚皮上跳跃也不会醒来。",
		"skill_name": "睡觉·泰山压顶", "skill_desc": "酣睡回复全部生命与异常，随后巨躯翻身砸扁全场造成650点伤害。",
		"skill_detail": "消耗100能量，原地倒地沉睡，瞬间清除自身所有异常状态并恢复600点生命值，随后翻身施展泰山压顶轰碎地面，对周围大范围敌人造成650点物理伤害并眩晕2秒。",
		"skill_power": 650,
		"skills": {
			1: {"name": "泰山压顶", "desc": "重躯压顶造成380点伤害并眩晕1.2秒。", "detail": "消耗100能量，巨大身躯重砸造成380点物理伤害并眩晕1.2秒。", "power": 380, "vfx": "body_slam", "sfx": "skill", "scale": 0.48},
			2: {"name": "睡觉·泰山压顶", "desc": "沉睡回血600点并翻身砸晕全场造成650点伤害。", "detail": "消耗100能量，回血600点净化自身，翻身造成650点范围伤害并眩晕2秒。", "power": 650, "vfx": "rest", "sfx": "skill", "scale": 0.62},
			3: {"name": "绝对巨无霸·崩星碎岳撼地灭", "desc": "化身千吨巨兽怒砸全屏，造成1400点真实伤害并永久嘲讽！", "detail": "消耗100能量，巨化为顶天立地的超级巨兽，向战场中心悍然坐下，引发大地震对全图敌人造成1400点毁灭真实物理伤害并嘲讽全体敌人！", "power": 1400, "vfx": "hyper_beam", "sfx": "skill", "scale": 0.80}
		},
		"visual": {"primary": (35, 80, 95), "secondary": (245, 235, 205), "accent": (30, 60, 75), "eye": (20, 20, 20), "archetype": "biped", "features": ["belly", "ears"]}
	},
	"articuno": {
		"num": 144, "id": "articuno", "name": "急冻鸟", "title": "冻结宝可梦", "cost": 5,
		"types": ["Ice", "Flying"], "hp": 1350, "atk": 105, "armor": 55, "mr": 70, "range": 3, "atk_speed": 0.78, "max_mana": 90,
		"desc": "传说中的三大神鸟之一，拍打由纯粹极寒冰晶构成的美丽羽翼，能在寒冬的雪山中降下漫天暴风雪，所过之处万物皆被冰封！",
		"skill_name": "绝对零度·暴风雪天罚", "skill_desc": "召唤极寒暴风雪降临全场，造成680点法术伤害并绝对冻结2.5秒。",
		"skill_detail": "消耗90能量，神圣冰晶双翼展开引动万古玄冰之威，召唤遮天蔽日的绝对零度暴风雪席卷全场，对所有敌军造成680点冰系毁灭法术伤害并强制冰冻2.5秒。",
		"skill_power": 680,
		"skills": {
			1: {"name": "急冻光束", "desc": "冰晶神翼射出冻光造成400点伤害并冰冻1.5秒。", "detail": "消耗90能量，神鸟冻光贯穿目标造成400点法术伤害并冰冻1.5秒。", "power": 400, "vfx": "ice_beam", "sfx": "skill", "scale": 0.48},
			2: {"name": "绝对零度·暴风雪天罚", "desc": "暴风雪肆虐全场造成680点伤害并冻结2.5秒。", "detail": "消耗90能量，全图暴风雪造成680点伤害并强制冻结2.5秒。", "power": 680, "vfx": "blizzard", "sfx": "skill", "scale": 0.62},
			3: {"name": "神鸟冰魄·万里苍茫万劫冰封界", "desc": "神鸟真身现世降下极寒神罚，造成1450点毁灭真实伤害！", "detail": "消耗90能量，急冻鸟引吭神鸣唤醒极地天神之怒，万载玄冰封死天地，对全图所有敌人造成1450点毁灭真实伤害并使全场攻速降为0持续3秒！", "power": 1450, "vfx": "hyper_beam", "sfx": "skill", "scale": 0.80}
		},
		"visual": {"primary": (110, 185, 240), "secondary": (245, 245, 255), "accent": (50, 120, 200), "eye": (220, 40, 40), "archetype": "avian", "features": ["wings", "tail", "crown"]}
	},
	"zapdos": {
		"num": 145, "id": "zapdos", "name": "闪电鸟", "title": "电击宝可梦", "cost": 5,
		"types": ["Electric", "Flying"], "hp": 1350, "atk": 110, "armor": 50, "mr": 65, "range": 3, "atk_speed": 0.88, "max_mana": 85,
		"desc": "传说中的雷神之鸟，栖息于滚滚雷云深处，挥动尖锐如雷电般的金黄羽翼时会迸发万道金色狂雷撕裂苍穹！",
		"skill_name": "打雷·雷神降世天谴劫", "skill_desc": "引下万道天劫神雷轰炸全屏，造成700点雷电伤害并全员麻痹。",
		"skill_detail": "消耗85能量，翱翔于狂暴雷云之巅引动九天玄雷，无数金色雷柱如同暴雨倾泻而下，对全场所有敌人造成700点毁灭雷电伤害并使全员陷入麻痹2秒。",
		"skill_power": 700,
		"skills": {
			1: {"name": "十万伏特狂雷", "desc": "金雷轰顶造成420点伤害并麻痹1.5秒。", "detail": "消耗85能量，九天落雷轰击造成420点雷电伤害并麻痹1.5秒。", "power": 420, "vfx": "thunderbolt", "sfx": "electric", "scale": 0.48},
			2: {"name": "打雷·雷神降世天谴劫", "desc": "万道金雷轰炸造成700点范围伤害并全员麻痹2秒。", "detail": "消耗85能量，天劫神雷倾泻造成700点伤害并麻痹全员2秒。", "power": 700, "vfx": "thunder", "sfx": "electric", "scale": 0.62},
			3: {"name": "太古雷帝·万钧苍穹灭世狂澜", "desc": "化身雷帝引爆亿万伏特终极天罚，造成1480点毁灭真实雷伤！", "detail": "消耗85能量，双翼化作贯通天地的金色雷柱，引爆亿万伏特终极雷劫，对全图所有敌人造成1480点毁灭真实雷伤并瘫痪全场3秒！", "power": 1480, "vfx": "hyper_beam", "sfx": "electric", "scale": 0.80}
		},
		"visual": {"primary": (245, 225, 45), "secondary": (25, 25, 30), "accent": (240, 160, 20), "eye": (20, 20, 20), "archetype": "avian", "features": ["wings", "beak", "crown"]}
	},
	"moltres": {
		"num": 146, "id": "moltres", "name": "火焰鸟", "title": "火焰宝可梦", "cost": 5,
		"types": ["Fire", "Flying"], "hp": 1350, "atk": 115, "armor": 50, "mr": 60, "range": 3, "atk_speed": 0.82, "max_mana": 85,
		"desc": "传说中的火神之鸟，翅膀和冠羽燃烧着永恒不灭的熊熊神火，拍打双翼掠过长空时会洒下温暖炽烈的火星，被称为带来春天的神鸟！",
		"skill_name": "热风·焚天涅槃神火", "skill_desc": "展翼卷起遮天烈焰风暴，造成720点火伤并永久灼烧。",
		"skill_detail": "消耗85能量，金色火羽舒展引发焚天火浪，向整片战场席卷炽热狂暴的热风风暴，对全场所有敌军造成720点毁灭火系伤害，并附加持续整场的神圣灼烧（每秒50点真实伤害）。",
		"skill_power": 720,
		"skills": {
			1: {"name": "大字炎爆", "desc": "大字烈火造成420点伤害并灼烧3秒。", "detail": "消耗85能量，喷射大字烈火造成420点伤害并灼烧3秒。", "power": 420, "vfx": "fire_blast", "sfx": "fire", "scale": 0.48},
			2: {"name": "热风·焚天涅槃神火", "desc": "烈焰风暴席卷全场造成720点伤害并永久灼烧。", "detail": "消耗85能量，焚天热风造成720点伤害并永久灼烧全场敌军。", "power": 720, "vfx": "flamethrower", "sfx": "fire", "scale": 0.62},
			3: {"name": "朱雀真神·不死天火涅槃劫", "desc": "真凰涅槃天火降世，造成1500点毁灭真实伤害并自愈满血！", "detail": "消耗85能量，火鸟长鸣化身太古不死火凰，烈阳天火焚尽苍穹，对全屏敌军造成1500点毁灭真实火伤，自身瞬间恢复全部生命值！", "power": 1500, "vfx": "blast_burn", "sfx": "fire", "scale": 0.80}
		},
		"visual": {"primary": (245, 220, 110), "secondary": (235, 65, 30), "accent": (245, 140, 35), "eye": (20, 20, 20), "archetype": "avian", "features": ["wings", "tail_fire", "crown"]}
	},
	"dratini": {
		"num": 147, "id": "dratini", "name": "迷你龙", "title": "龙宝可梦", "cost": 1,
		"types": ["Dragon"], "hp": 550, "atk": 52, "armor": 25, "mr": 25, "range": 2, "atk_speed": 0.70, "max_mana": 70,
		"desc": "自古以来就被视为虚幻幻兽般的存在，栖息在深不见底的瀑布深潭中，通过一次次蜕皮不断成长积蓄龙威。",
		"skill_name": "龙卷风·神龙幼息", "skill_desc": "卷起狂暴小龙卷风撕裂目标，造成180点伤害并击飞。",
		"skill_detail": "消耗70能量，摆动修长身躯在目标脚下卷起一道呼啸的龙之旋风，造成180点龙系法术伤害并将目标击飞1秒。",
		"skill_power": 180,
		"skills": {
			1: {"name": "龙卷风", "desc": "卷起龙卷风造成180点伤害并击飞1秒。", "detail": "消耗70能量，龙卷风击飞目标1秒并造成180点伤害。", "power": 180, "vfx": "twister", "sfx": "skill", "scale": 0.32},
			2: {"name": "龙之怒·激流喷射", "desc": "龙怒水炮贯穿造成310点伤害并破甲25%。", "detail": "消耗70能量，龙怒爆发造成310点伤害并削弱25%护甲。", "power": 310, "vfx": "dragon_breath", "sfx": "skill", "scale": 0.42},
			3: {"name": "幼龙腾渊·九天应龙祖血劫", "desc": "唤醒太古应龙血脉，造成620点真实伤害并全员击退！", "detail": "消耗70能量，幼小身躯迸发出浩瀚龙皇真威，对前方整排敌人造成620点真实龙系伤害并震退2格！", "power": 620, "vfx": "draco_meteor", "sfx": "skill", "scale": 0.54}
		},
		"visual": {"primary": (110, 155, 235), "secondary": (245, 245, 250), "accent": (240, 240, 245), "eye": (140, 70, 180), "archetype": "serpentine", "features": ["wings_ears", "tail"]}
	},
	"dragonair": {
		"num": 148, "id": "dragonair", "name": "哈克龙", "title": "龙宝可梦", "cost": 2,
		"types": ["Dragon"], "hp": 780, "atk": 68, "armor": 35, "mr": 35, "range": 2, "atk_speed": 0.75, "max_mana": 75,
		"desc": "颈部和尾部各有一颗散发着圣洁幽蓝光芒的水晶宝珠，能随意操控周围的天气变化，在湖面上空优雅飞舞。",
		"skill_name": "龙之波动·宝珠唤雷雨", "skill_desc": "宝珠共鸣引动雷雨水龙卷，造成300点伤害并降低30%移速。",
		"skill_detail": "消耗75能量，颈项与尾部发光宝珠释放天青色龙灵神光，召唤雷雨龙卷风轰炸目标区域，造成300点龙系范围法术伤害并降低其30%攻速与移速。",
		"skill_power": 300,
		"skills": {
			1: {"name": "龙之吐息", "desc": "龙息喷射造成200点伤害并麻痹1秒。", "detail": "消耗75能量，喷射龙息造成200点伤害并麻痹1秒。", "power": 200, "vfx": "dragon_breath", "sfx": "skill", "scale": 0.38},
			2: {"name": "龙之波动·宝珠唤雷雨", "desc": "宝珠共鸣造成300点范围伤害并减速30%。", "detail": "消耗75能量，雷雨龙波造成300点伤害并降低30%攻速。", "power": 300, "vfx": "twister", "sfx": "skill", "scale": 0.48},
			3: {"name": "风雨化龙·青天碧海唤雨诀", "desc": "引动苍天雷雨洗礼全场，造成680点伤害并为全队回血300点！", "detail": "消耗75能量，沟通天地灵气引来甘霖与雷暴，对所有敌人造成680点法术伤害，同时为全队回复300点生命！", "power": 680, "vfx": "draco_meteor", "sfx": "skill", "scale": 0.60}
		},
		"visual": {"primary": (100, 145, 230), "secondary": (245, 245, 250), "accent": (50, 110, 210), "eye": (130, 60, 170), "archetype": "serpentine", "features": ["wings_ears", "tail", "orbs"]}
	},
	"dragonite": {
		"num": 149, "id": "dragonite", "name": "快龙", "title": "龙宝可梦", "cost": 5,
		"types": ["Dragon", "Flying"], "hp": 1350, "atk": 115, "armor": 60, "mr": 60, "range": 2, "atk_speed": 0.85, "max_mana": 85,
		"desc": "体型虽然庞大，但仅需约16小时就能环绕地球一周！性情极其温和善良，经常会在狂风暴雨的大海中救助落水遇难的人类。",
		"skill_name": "流星群·毁灭龙炎息", "skill_desc": "从苍穹召唤漫天真龙陨石雨，造成750点巨额真实范围伤害。",
		"skill_detail": "消耗85能量，仰天咆哮沟通浩瀚宇宙真龙神星，从天外虚空引召无数炽热龙血陨石疯狂轰炸战场，对全屏所有敌人造成750点巨额龙系真实伤害并击晕1.5秒。",
		"skill_power": 750,
		"skills": {
			1: {"name": "神速龙之爪", "desc": "神速破空抓击造成440点物理伤害。", "detail": "消耗85能量，神速突进撕裂目标造成440点物理伤害。", "power": 440, "vfx": "dragon_claw", "sfx": "skill", "scale": 0.48},
			2: {"name": "流星群·毁灭龙炎息", "desc": "真龙陨石坠落造成750点巨额真实伤害。", "detail": "消耗85能量，漫天龙星群轰炸全场造成750点真实伤害并眩晕1.5秒。", "power": 750, "vfx": "draco_meteor", "sfx": "skill", "scale": 0.62},
			3: {"name": "万界龙祖·太古真龙灭世大荒劫", "desc": "唤醒太古龙皇真身引爆宇宙龙星，造成1500点毁灭真实伤害！", "detail": "消耗85能量，显化九万丈太古神龙金身虚影，一爪撕碎虚空苍穹，对全屏敌军造成1500点毁灭真实暴击伤害并使全场全属性削弱40%！", "power": 1500, "vfx": "hyper_beam", "sfx": "skill", "scale": 0.80}
		},
		"visual": {"primary": (240, 165, 60), "secondary": (245, 240, 200), "accent": (65, 160, 140), "eye": (30, 80, 150), "archetype": "biped", "features": ["wings", "tail", "horns"]}
	},
	"mewtwo": {
		"num": 150, "id": "mewtwo", "name": "超梦", "title": "基因宝可梦", "cost": 5,
		"types": ["Psychic"], "hp": 1300, "atk": 118, "armor": 55, "mr": 65, "range": 3, "atk_speed": 0.88, "max_mana": 80,
		"desc": "由人类科学家提取梦幻的基因重组诞生的究极超能力宝可梦，拥有冷酷无情的纯粹战斗心智与摧枯拉朽的毁灭超能力！",
		"skill_name": "精神击破·超能黑洞破", "skill_desc": "手心凝聚湮灭黑洞轰击，造成780点法术伤害并粉碎50%法抗。",
		"skill_detail": "消耗80能量，单手托起吞噬一切光芒的深紫超能微型黑洞，骤然向敌阵中心轰炸炸裂，造成780点超能穿透法术伤害，粉碎50%法抗并把全场敌人向中心强制引力拉拽！",
		"skill_power": 780,
		"skills": {
			1: {"name": "精神利刃", "desc": "念力神刃穿透造成440点伤害并碎抗30%。", "detail": "消耗80能量，射出锋利念力利刃造成440点伤害并削弱30%法抗。", "power": 440, "vfx": "psystrike", "sfx": "skill", "scale": 0.48},
			2: {"name": "精神击破·超能黑洞破", "desc": "超能黑洞造成780点伤害并引力拉拽全员。", "detail": "消耗80能量，轰出毁灭黑洞造成780点伤害并碎抗50%引力聚怪。", "power": 780, "vfx": "future_sight", "sfx": "skill", "scale": 0.62},
			3: {"name": "神之基因·次元崩坏宇宙湮灭劫", "desc": "撕开宇宙黑洞坍缩维度，造成1550点毁灭真实伤害与全图禁锢！", "detail": "消耗80能量，双眼绽放神之冷冽神辉，意念一动撕裂现实维度引发超空间大坍塌，对全图所有敌人造成1550点毁灭真实伤害并禁锢全员3秒！", "power": 1550, "vfx": "hyper_beam", "sfx": "skill", "scale": 0.80}
		},
		"visual": {"primary": (220, 215, 230), "secondary": (135, 60, 160), "accent": (95, 35, 120), "eye": (130, 50, 150), "archetype": "biped", "features": ["tail", "ears"]}
	},
	"mew": {
		"num": 151, "id": "mew", "name": "梦幻", "title": "新种宝可梦", "cost": 5,
		"types": ["Psychic"], "hp": 1300, "atk": 110, "armor": 60, "mr": 60, "range": 3, "atk_speed": 0.90, "max_mana": 75,
		"desc": "拥有所有宝可梦的遗传基因，被学者们公认为所有宝可梦的共同始祖，能在空气中自由隐形穿梭，心灵极其纯真无暇！",
		"skill_name": "起源起源光球·万象超能破", "skill_desc": "释放万物始祖纯净光球，造成760点真实伤害并全队净化+加盾。",
		"skill_detail": "消耗75能量，在掌心凝聚孕育万千生命的粉色太古始祖原初光球射向全场，对所有敌人造成760点纯净真实伤害，同时净化全体友军所有异常状态并施加450点全能生命护盾！",
		"skill_power": 760,
		"skills": {
			1: {"name": "幻象光波·始祖之灵", "desc": "粉色光束造成420点真实伤害。", "detail": "消耗75能量，始祖念力光束造成420点真实伤害。", "power": 420, "vfx": "psychic", "sfx": "skill", "scale": 0.48},
			2: {"name": "起源光球·万象超能破", "desc": "始祖光球造成760点伤害并全队净化加450盾。", "detail": "消耗75能量，原初光球造成760点伤害，全队净化并获450盾。", "power": 760, "vfx": "hyper_beam", "sfx": "skill", "scale": 0.62},
			3: {"name": "创生始祖·大千宇宙生命之树", "desc": "召唤生命之树虚影，造成1500点毁灭真实伤害并复活一名友军！", "detail": "消耗75能量，显化贯通万界的太古生命之树，无尽生机与寂灭神威涤荡人间，对所有敌人造成1500点毁灭真实伤害，并以50%生命复活最近阵亡的友军！", "power": 1500, "vfx": "future_sight", "sfx": "skill", "scale": 0.80}
		},
		"visual": {"primary": (245, 185, 210), "secondary": (240, 150, 185), "accent": (100, 180, 230), "eye": (70, 160, 220), "archetype": "biped", "features": ["tail", "ears", "floating"]}
	}
}
