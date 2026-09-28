# Gen 1 Pokemon: 061 - 090
POKEMON_CHUNK_3 = {
	"poliwhirl": {
		"num": 61, "id": "poliwhirl", "name": "蚊香君", "title": "蝌蚪宝可梦", "cost": 2,
		"types": ["Water"], "hp": 740, "atk": 65, "armor": 35, "mr": 30, "range": 1, "atk_speed": 0.70, "max_mana": 85,
		"desc": "两只脚健步如飞，在陆地上也能敏捷行动。身体表面总是被一层滑溜溜的液体所包裹，不易被抓到。",
		"skill_name": "连环巴掌", "skill_desc": "水流包裹手掌连续拍击，造成280点伤害并眩晕0.8秒。",
		"skill_detail": "消耗85能量，双掌灌注激流水流连续狂甩目标，造成280点水系物理伤害并使目标眩晕0.8秒。",
		"skill_power": 280,
		"skills": {
			1: {"name": "泡沫连打", "desc": "水流拍击造成180点伤害并减速。", "detail": "消耗85能量，挥出水流重拳造成180点伤害并使目标减速30%。", "power": 180, "vfx": "water_gun", "sfx": "water", "scale": 0.35},
			2: {"name": "连环巴掌·急流", "desc": "疾速连环掌击造成280点伤害并眩晕0.8秒。", "detail": "消耗85能量，疾速连掌造成280点伤害并附带0.8秒眩晕。", "power": 280, "vfx": "hydro_pump", "sfx": "water", "scale": 0.44},
			3: {"name": "水之波动·真空气旋破", "desc": "双掌凝聚高压水核引爆，造成660点大范围伤害与全员击退。", "detail": "消耗85能量，压缩四周水汽化为超压水球炸裂，对大范围所有敌人造成660点伤害并强力击退2格！", "power": 660, "vfx": "hydro_cannon", "sfx": "water", "scale": 0.58}
		},
		"visual": {"primary": (50, 110, 200), "secondary": (240, 240, 245), "accent": (30, 30, 30), "eye": (20, 20, 20), "archetype": "biped", "features": ["ears"]}
	},
	"poliwrath": {
		"num": 62, "id": "poliwrath", "name": "蚊香泳士", "title": "蝌蚪宝可梦", "cost": 4,
		"types": ["Water", "Fighting"], "hp": 1150, "atk": 95, "armor": 52, "mr": 48, "range": 1, "atk_speed": 0.75, "max_mana": 90,
		"desc": "拥有无比强健的肌肉，即使在狂风巨浪的大海中也能逆流畅游，双拳重击甚至能击碎坚固的花岗岩！",
		"skill_name": "爆裂重拳·巨浪轰鸣", "skill_desc": "汇聚怒涛之力轰出破甲重拳，造成580点伤害并眩晕1.5秒。",
		"skill_detail": "消耗90能量，深吸一口气将全身肌肉紧绷，挥出伴随海啸轰鸣的爆裂重拳，造成580点物理伤害，粉碎敌方40%护甲并眩晕1.5秒。",
		"skill_power": 580,
		"skills": {
			1: {"name": "水流裂破", "desc": "强力水重拳造成320点伤害并碎甲25%。", "detail": "消耗90能量，激流水拳重击目标造成320点伤害并削弱25%护甲。", "power": 320, "vfx": "water_gun", "sfx": "water", "scale": 0.42},
			2: {"name": "爆裂重拳", "desc": "轰出重拳造成580点伤害并眩晕1.5秒。", "detail": "消耗90能量，重拳出击造成580点物理伤害，粉碎40%护甲并眩晕1.5秒。", "power": 580, "vfx": "hydro_pump", "sfx": "water", "scale": 0.52},
			3: {"name": "海皇狂怒·泰坦怒涛碎岳破", "desc": "化身海皇轰出百裂水神拳，造成1250点真实伤害并震撼全场！", "detail": "消耗90能量，唤醒太古海潮神威，朝前方爆发百裂怒涛拳芒，对扇形全体敌军造成1250点毁灭真实伤害并击飞2秒！", "power": 1250, "vfx": "hydro_cannon", "sfx": "water", "scale": 0.70}
		},
		"visual": {"primary": (40, 95, 185), "secondary": (245, 245, 250), "accent": (30, 30, 30), "eye": (20, 20, 20), "archetype": "biped", "features": ["ears"]}
	},
	"abra": {
		"num": 63, "id": "abra", "name": "凯西", "title": "念力宝可梦", "cost": 1,
		"types": ["Psychic"], "hp": 480, "atk": 42, "armor": 18, "mr": 35, "range": 3, "atk_speed": 0.65, "max_mana": 70,
		"desc": "每天必须睡上18个小时。在睡梦中也能感知周围的危险，一旦感觉到危险就会通过瞬间移动逃离。",
		"skill_name": "折射念力", "skill_desc": "睡梦中发射幻象光波，造成170点超能伤害并闪烁避险。",
		"skill_detail": "消耗70能量，在睡梦中感知敌方意图并射出幻象光波，造成170点超能法术伤害，同时瞬间移动闪烁至安全距离。",
		"skill_power": 170,
		"skills": {
			1: {"name": "念力弹", "desc": "发射念力光弹造成170点伤害并闪烁避险。", "detail": "消耗70能量，射出念力光弹造成170点伤害并闪烁避险。", "power": 170, "vfx": "confusion", "sfx": "skill", "scale": 0.30},
			2: {"name": "折射幻象", "desc": "扭曲空间造成310点伤害并致盲目标2秒。", "detail": "消耗70能量，扭曲周围光线造成310点法术伤害，使目标致盲2秒。", "power": 310, "vfx": "psybeam", "sfx": "skill", "scale": 0.40},
			3: {"name": "虚空跃迁·超能星陨", "desc": "撕开维度唤下群星，造成600点穿透伤害并全员定身1.5秒。", "detail": "消耗70能量，在空间裂隙中唤出星能陨石，对敌阵造成600点穿透真实伤害并定身1.5秒。", "power": 600, "vfx": "psychic", "sfx": "skill", "scale": 0.52}
		},
		"visual": {"primary": (230, 190, 60), "secondary": (160, 120, 40), "accent": (90, 50, 20), "eye": (40, 30, 20), "archetype": "biped", "features": ["ears", "tail"]}
	},
	"kadabra": {
		"num": 64, "id": "kadabra", "name": "勇基拉", "title": "念力宝可梦", "cost": 2,
		"types": ["Psychic"], "hp": 650, "atk": 58, "armor": 25, "mr": 45, "range": 3, "atk_speed": 0.70, "max_mana": 80,
		"desc": "手中握着银勺以集中和放大精神力量。身体会向四周释放强烈的特殊阿尔法波，导致身旁的精密仪器彻底失灵。",
		"skill_name": "幻象光线", "skill_desc": "银勺聚能发射七彩幻象光束，造成260点伤害并混乱敌人。",
		"skill_detail": "消耗80能量，手中银勺汇聚狂暴念力，激射出一道七彩幻象光束，造成260点超能伤害并让敌人混乱1.5秒（攻击其友军）。",
		"skill_power": 260,
		"skills": {
			1: {"name": "精神光束", "desc": "发射精神光束造成190点伤害。", "detail": "消耗80能量，银勺凝聚精神波造成190点超能伤害。", "power": 190, "vfx": "confusion", "sfx": "skill", "scale": 0.35},
			2: {"name": "幻象光线", "desc": "发射七彩光束造成260点伤害并混乱目标。", "detail": "消耗80能量，发射七彩幻象光造成260点伤害并混乱目标1.5秒。", "power": 260, "vfx": "psybeam", "sfx": "skill", "scale": 0.45},
			3: {"name": "念力扭曲·次元风暴", "desc": "银勺挥舞引爆空间旋涡，造成680点范围伤害并粉碎法抗。", "detail": "消耗80能量，空间在银勺挥动下崩塌，对范围内所有敌人造成680点法术伤害并粉碎50%法抗！", "power": 680, "vfx": "psychic", "sfx": "skill", "scale": 0.58}
		},
		"visual": {"primary": (230, 185, 55), "secondary": (155, 115, 35), "accent": (180, 50, 50), "eye": (40, 30, 20), "archetype": "biped", "features": ["ears", "tail"]}
	},
	"alakazam": {
		"num": 65, "id": "alakazam", "name": "胡地", "title": "念力宝可梦", "cost": 4,
		"types": ["Psychic"], "hp": 900, "atk": 85, "armor": 35, "mr": 60, "range": 3, "atk_speed": 0.75, "max_mana": 80,
		"desc": "智商高达5000，脑细胞会无限分裂生长。双手各持一把超能银勺，能随意运用不可思议的精神超自然力量！",
		"skill_name": "精神强念", "skill_desc": "双勺释放毁灭念力风暴，造成450点法术伤害并偷取法抗。",
		"skill_detail": "消耗80能量，双勺交叠释放极度凝缩的精神狂澜，对目标及周围单位造成450点超能伤害，并偷取目标40%法抗附加给自身。",
		"skill_power": 450,
		"skills": {
			1: {"name": "幻象术", "desc": "发射强力精神波造成280点伤害并降低法抗。", "detail": "消耗80能量，强力精神波造成280点法术伤害并削弱30%法抗。", "power": 280, "vfx": "psybeam", "sfx": "skill", "scale": 0.40},
			2: {"name": "精神强念", "desc": "释放念力风暴造成450点伤害并偷取法抗。", "detail": "消耗80能量，念力风暴造成450点超能伤害并偷取40%法抗。", "power": 450, "vfx": "psychic", "sfx": "skill", "scale": 0.50},
			3: {"name": "星宿神念·大荒虚空寂灭劫", "desc": "唤醒5000智商终极神识，造成1100点真实伤害并全图禁魔3秒！", "detail": "消耗80能量，唤醒终极宇宙神识，双勺引动星河共鸣，对全图所有敌人造成1100点真实伤害并禁魔3秒！", "power": 1100, "vfx": "future_sight", "sfx": "skill", "scale": 0.68}
		},
		"visual": {"primary": (235, 190, 50), "secondary": (150, 110, 30), "accent": (210, 210, 220), "eye": (40, 30, 20), "archetype": "biped", "features": ["ears", "tail"]}
	},
	"machop": {
		"num": 66, "id": "machop", "name": "腕力", "title": "怪力宝可梦", "cost": 1,
		"types": ["Fighting"], "hp": 650, "atk": 58, "armor": 30, "mr": 20, "range": 1, "atk_speed": 0.65, "max_mana": 80,
		"desc": "全身都是健壮肌肉，哪怕是小孩子的身躯也能举起相当于一百个成年人的岩石。每天都在刻苦修行！",
		"skill_name": "下盘踢", "skill_desc": "横扫下盘造成190点物理伤害并击倒减速。",
		"skill_detail": "消耗80能量，敏捷滑铲横扫目标下盘，造成190点格斗物理伤害并降低其50%移动速度，持续2.5秒。",
		"skill_power": 190,
		"skills": {
			1: {"name": "下盘踢", "desc": "横扫下盘造成190点物理伤害并减速50%。", "detail": "消耗80能量，横扫下盘造成190点格斗物理伤害并减速50%。", "power": 190, "vfx": "cross_chop", "sfx": "skill", "scale": 0.34},
			2: {"name": "过肩摔", "desc": "抱摔敌人造成320点伤害并砸晕周围单位。", "detail": "消耗80能量，将目标抱起猛摔在地造成320点伤害，砸晕周围敌军1秒。", "power": 320, "vfx": "close_combat", "sfx": "skill", "scale": 0.44},
			3: {"name": "碎石霸皇拳", "desc": "蓄力重拳轰碎坚岩，造成620点巨额物理伤害与全员破甲。", "detail": "消耗80能量，凝聚浑身筋骨之力爆发一击，对前方直线造成620点物理伤害并降低40%护甲持续4秒。", "power": 620, "vfx": "dynamic_punch", "sfx": "skill", "scale": 0.56}
		},
		"visual": {"primary": (130, 160, 185), "secondary": (190, 130, 80), "accent": (180, 50, 50), "eye": (180, 40, 40), "archetype": "biped", "features": ["horns", "tail"]}
	},
	"machoke": {
		"num": 67, "id": "machoke", "name": "豪力", "title": "怪力宝可梦", "cost": 2,
		"types": ["Fighting"], "hp": 850, "atk": 74, "armor": 38, "mr": 25, "range": 1, "atk_speed": 0.70, "max_mana": 85,
		"desc": "腰间佩戴着金色的力量限制腰带，以此来抑制自身过于膨胀的毁灭怪力，即使背着沉重大卡车也能健步如飞。",
		"skill_name": "十字手刀", "skill_desc": "双臂交叠挥出强力十字斩，造成280点伤害并高概率暴击。",
		"skill_detail": "消耗85能量，双臂呈十字交叉暴烈斩出，对目标造成280点格斗伤害，本技能拥有50%的基础暴击率。",
		"skill_power": 280,
		"skills": {
			1: {"name": "空手劈", "desc": "手刀劈击造成200点物理伤害。", "detail": "消耗85能量，手刀破空劈下造成200点格斗物理伤害。", "power": 200, "vfx": "cross_chop", "sfx": "skill", "scale": 0.38},
			2: {"name": "十字手刀", "desc": "十字交叠斩击造成280点伤害并50%暴击。", "detail": "消耗85能量，十字斩击造成280点伤害并拥有50%暴击率。", "power": 280, "vfx": "close_combat", "sfx": "skill", "scale": 0.48},
			3: {"name": "金刚解禁·爆裂山河崩", "desc": "解除金带狂暴怒击，造成720点伤害并获得40%吸血护盾！", "detail": "消耗85能量，短暂松开腰带释放潜能，撼地狂砸造成720点伤害，自身获得40%全能吸血护盾持续5秒！", "power": 720, "vfx": "dynamic_punch", "sfx": "skill", "scale": 0.60}
		},
		"visual": {"primary": (125, 150, 180), "secondary": (210, 175, 40), "accent": (180, 50, 50), "eye": (180, 40, 40), "archetype": "biped", "features": ["horns"]}
	},
	"machamp": {
		"num": 68, "id": "machamp", "name": "怪力", "title": "怪力宝可梦", "cost": 4,
		"types": ["Fighting"], "hp": 1200, "atk": 105, "armor": 55, "mr": 40, "range": 1, "atk_speed": 0.80, "max_mana": 85,
		"desc": "拥有四只极其强壮的手臂，能在两秒内轰出整整一千记重拳！四手同时攻击能彻底压制并击溃任何防御！",
		"skill_name": "近身战·千裂拳", "skill_desc": "四拳疾风骤雨连打，造成620点破甲伤害并击飞目标。",
		"skill_detail": "消耗85能量，四条手臂化作肉眼无法看清的重拳残影狂轰目标，造成620点巨额物理伤害，粉碎其50%防御并将目标击飞1.2秒。",
		"skill_power": 620,
		"skills": {
			1: {"name": "爆裂拳", "desc": "重拳狂暴轰击造成360点伤害并混乱目标。", "detail": "消耗85能量，单拳出击造成360点物理伤害并使目标混乱1秒。", "power": 360, "vfx": "cross_chop", "sfx": "skill", "scale": 0.45},
			2: {"name": "近身战·千裂拳", "desc": "四拳狂轰造成620点破甲伤害并击飞。", "detail": "消耗85能量，四臂狂轰造成620点物理伤害并击飞1.2秒。", "power": 620, "vfx": "close_combat", "sfx": "skill", "scale": 0.58},
			3: {"name": "万夫莫敌·八荒神武灭世印", "desc": "四拳引动武圣真意震碎虚空，造成1350点毁灭真实伤害与全屏击退！", "detail": "消耗85能量，全身气魄化为金刚武神，四拳同时撼地引爆地脉核心，对全屏敌军造成1350点毁灭真实伤害与2秒全员震退！", "power": 1350, "vfx": "dynamic_punch", "sfx": "skill", "scale": 0.72}
		},
		"visual": {"primary": (120, 145, 175), "secondary": (220, 180, 50), "accent": (190, 50, 50), "eye": (190, 40, 40), "archetype": "biped", "features": ["horns"]}
	},
	"bellsprout": {
		"num": 69, "id": "bellsprout", "name": "喇叭芽", "title": "捕蝇宝可梦", "cost": 1,
		"types": ["Grass", "Poison"], "hp": 520, "atk": 50, "armor": 20, "mr": 25, "range": 2, "atk_speed": 0.68, "max_mana": 75,
		"desc": "喜欢潮湿温热的地方，身体细长柔软，即使受到猛烈的攻击也能像水草一样摇曳化解，擅长从口中喷吐强腐蚀胃液。",
		"skill_name": "溶解液", "skill_desc": "喷吐强酸腐蚀目标，造成160点伤害并降低25%护甲与魔抗。",
		"skill_detail": "消耗75能量，从喇叭状口中喷射出强烈腐蚀酸液，对目标造成160点草/毒混合法术伤害，并削弱其25%双抗，持续3秒。",
		"skill_power": 160,
		"skills": {
			1: {"name": "强酸喷吐", "desc": "喷吐酸液造成160点伤害并削弱25%双抗。", "detail": "消耗75能量，喷射酸液造成160点伤害并削弱25%双抗。", "power": 160, "vfx": "sludge_bomb", "sfx": "skill", "scale": 0.32},
			2: {"name": "飞叶快刀·酸蚀", "desc": "飞叶带毒扫荡前方造成300点伤害并中毒。", "detail": "消耗75能量，扇形飞叶伴随毒液造成300点伤害并中毒3秒。", "power": 300, "vfx": "razor_leaf", "sfx": "skill", "scale": 0.42},
			3: {"name": "捕蝇天罗·腐骨毒藤狂澜", "desc": "漫天毒藤缠绕战场，造成620点巨额范围毒伤并禁锢2秒。", "detail": "消耗75能量，地面涌出大量腐蚀毒藤，对范围内所有敌人造成620点真实伤害并禁锢2秒！", "power": 620, "vfx": "frenzy_plant", "sfx": "skill", "scale": 0.54}
		},
		"visual": {"primary": (230, 220, 60), "secondary": (110, 180, 60), "accent": (140, 90, 50), "eye": (20, 20, 20), "archetype": "plant", "features": ["leaves"]}
	},
	"weepinbell": {
		"num": 70, "id": "weepinbell", "name": "口呆花", "title": "捕蝇宝可梦", "cost": 2,
		"types": ["Grass", "Poison"], "hp": 680, "atk": 66, "armor": 28, "mr": 30, "range": 2, "atk_speed": 0.70, "max_mana": 80,
		"desc": "肚子饿的时候会大口吞食眼前的一切活物，体内强酸无论什么都能融化，甚至连坚硬的钢铁都能溶成一滩液体。",
		"skill_name": "毒粉飞叶", "skill_desc": "两片利刃大叶挥洒剧毒粉末，造成270点伤害并剧毒感染。",
		"skill_detail": "消耗80能量，摆动锋利双叶射出浸润毒液的刀叶，对目标及周围敌军造成270点伤害并附加剧毒感染（每秒造成40点真实伤害）。",
		"skill_power": 270,
		"skills": {
			1: {"name": "毒液冲击", "desc": "毒液喷射造成190点伤害并中毒。", "detail": "消耗80能量，喷洒毒液造成190点法术伤害并中毒2秒。", "power": 190, "vfx": "sludge_bomb", "sfx": "skill", "scale": 0.36},
			2: {"name": "毒粉飞叶", "desc": "挥洒剧毒飞叶造成270点伤害并剧毒感染。", "detail": "消耗80能量，剧毒飞叶造成270点伤害并每秒造成40点真实毒伤。", "power": 270, "vfx": "razor_leaf", "sfx": "skill", "scale": 0.46},
			3: {"name": "强酸溶蚀·百毒噬魂绝", "desc": "倾泻熔融酸液暴雨，造成700点范围伤害并彻底瓦解50%防御！", "detail": "消耗80能量，高高扬起大嘴喷出漫天强酸毒雨，对大范围敌军造成700点伤害并削弱50%防御持续4秒！", "power": 700, "vfx": "gunk_shot", "sfx": "skill", "scale": 0.58}
		},
		"visual": {"primary": (225, 215, 50), "secondary": (95, 170, 50), "accent": (140, 80, 40), "eye": (20, 20, 20), "archetype": "plant", "features": ["leaves"]}
	},
	"victreebel": {
		"num": 71, "id": "victreebel", "name": "大食花", "title": "蝇捕宝可梦", "cost": 4,
		"types": ["Grass", "Poison"], "hp": 1050, "atk": 90, "armor": 45, "mr": 45, "range": 2, "atk_speed": 0.72, "max_mana": 85,
		"desc": "在深山密林深处建立自己的领地，散发出甜美如同蜂蜜般的香气诱捕猎物，一旦掉入口中就会被顷刻溶解消化。",
		"skill_name": "飞叶风暴·溶胃大嚼", "skill_desc": "狂暴飞叶席卷敌阵造成520点伤害，并将目标吞噬禁锢1.5秒。",
		"skill_detail": "消耗85能量，藤蔓化作天罗地网缠住目标并吞入巨口溶蚀，造成520点巨额草/毒混合伤害，禁锢1.5秒并为自身恢复350点生命。",
		"skill_power": 520,
		"skills": {
			1: {"name": "毒液大嚼", "desc": "巨口撕咬造成300点伤害并吸血150点。", "detail": "消耗85能量，巨口撕咬造成300点伤害并恢复150点生命。", "power": 300, "vfx": "sludge_bomb", "sfx": "skill", "scale": 0.42},
			2: {"name": "飞叶风暴·溶胃大嚼", "desc": "飞叶吞噬造成520点伤害并禁锢1.5秒。", "detail": "消耗85能量，吞噬目标造成520点伤害并禁锢1.5秒回血350点。", "power": 520, "vfx": "razor_leaf", "sfx": "skill", "scale": 0.54},
			3: {"name": "太古魔植·吞天噬地万毒宴", "desc": "化身远古魔花吞噬半场敌军，造成1180点毁灭伤害并吸血600点！", "detail": "消耗85能量，唤醒太古肉食魔植本能，漫天腐蚀酸流横扫全场，对所有敌人造成1180点真实毒害，为自身回复600点生命并削减目标全属性30%！", "power": 1180, "vfx": "frenzy_plant", "sfx": "skill", "scale": 0.70}
		},
		"visual": {"primary": (220, 205, 45), "secondary": (80, 160, 45), "accent": (130, 70, 30), "eye": (20, 20, 20), "archetype": "plant", "features": ["leaves", "mouth"]}
	},
	"tentacool": {
		"num": 72, "id": "tentacool", "name": "玛瑙水母", "title": "水母宝可梦", "cost": 1,
		"types": ["Water", "Poison"], "hp": 550, "atk": 44, "armor": 22, "mr": 45, "range": 2, "atk_speed": 0.65, "max_mana": 80,
		"desc": "身体的99%都是由水组成的，在海水里漂浮时几乎透明不可见。两只红色的透明发光水晶能发射神秘的光线。",
		"skill_name": "毒针射击", "skill_desc": "触手激射密集毒针，造成160点伤害并中毒3秒。",
		"skill_detail": "消耗80能量，舒展触手向目标射出一簇浸透剧毒的毒针，造成160点水/毒混合伤害，并使其陷入剧毒状态持续3秒。",
		"skill_power": 160,
		"skills": {
			1: {"name": "毒针", "desc": "发射毒针造成160点伤害并中毒3秒。", "detail": "消耗80能量，发射毒针造成160点伤害并中毒3秒。", "power": 160, "vfx": "poison_sting", "sfx": "skill", "scale": 0.32},
			2: {"name": "水之波动·剧毒环", "desc": "释放毒性水环波震退敌人，造成280点伤害。", "detail": "消耗80能量，释放剧毒水环对周围敌军造成280点伤害并击退1格。", "power": 280, "vfx": "water_gun", "sfx": "water", "scale": 0.42},
			3: {"name": "深海毒咒·千触狂澜引", "desc": "海底深渊万触狂舞，造成620点穿透法术伤害并定身2秒。", "detail": "消耗80能量，引动深海暗流，无数剧毒触须缠绕全场，造成620点法术伤害并定身2秒！", "power": 620, "vfx": "hydro_pump", "sfx": "water", "scale": 0.54}
		},
		"visual": {"primary": (70, 140, 210), "secondary": (225, 45, 60), "accent": (30, 70, 120), "eye": (20, 20, 20), "archetype": "floating", "features": ["tentacles"]}
	},
	"tentacruel": {
		"num": 73, "id": "tentacruel", "name": "毒刺水母", "title": "水母宝可梦", "cost": 3,
		"types": ["Water", "Poison"], "hp": 950, "atk": 70, "armor": 42, "mr": 65, "range": 2, "atk_speed": 0.70, "max_mana": 85,
		"desc": "拥有整整80条能够自由伸缩的致命触须，头顶红色宝珠会闪耀刺目光芒发出超声波，被称为深海暴徒！",
		"skill_name": "污泥波·八十触狂刺", "skill_desc": "80条毒触须狂刺全场，造成420点伤害并剧毒腐蚀。",
		"skill_detail": "消耗85能量，头顶红水晶怒放强光，80根毒刺触手狂扫半场，对多名敌人造成420点混合伤害并削弱30%双抗持续3秒。",
		"skill_power": 420,
		"skills": {
			1: {"name": "毒刺穿透", "desc": "毒触突刺造成240点伤害并剧毒腐蚀。", "detail": "消耗85能量，触手突刺造成240点法伤并削弱20%双抗。", "power": 240, "vfx": "poison_sting", "sfx": "skill", "scale": 0.38},
			2: {"name": "污泥波·八十触狂刺", "desc": "漫天毒触狂扫造成420点伤害并剧毒腐蚀。", "detail": "消耗85能量，八十条触手乱舞造成420点伤害并削弱30%双抗。", "power": 420, "vfx": "sludge_bomb", "sfx": "skill", "scale": 0.50},
			3: {"name": "深渊海皇魔触·万毒蚀天诛", "desc": "唤醒深渊海怪血脉，对全图造成980点毁灭毒伤并全员沉默2.5秒！", "detail": "消耗85能量，化作百米深海巨妖，喷射遮天蔽日的剧毒海啸，对全屏敌军造成980点真实伤害并施加沉默2.5秒！", "power": 980, "vfx": "hydro_cannon", "sfx": "water", "scale": 0.68}
		},
		"visual": {"primary": (60, 130, 200), "secondary": (230, 40, 55), "accent": (25, 60, 110), "eye": (20, 20, 20), "archetype": "floating", "features": ["tentacles", "horns"]}
	},
	"geodude": {
		"num": 74, "id": "geodude", "name": "小拳石", "title": "岩石宝可梦", "cost": 1,
		"types": ["Rock", "Ground"], "hp": 680, "atk": 56, "armor": 45, "mr": 20, "range": 1, "atk_speed": 0.60, "max_mana": 85,
		"desc": "坚硬无比的圆滚滚身体看起来就像一块普通石头，擅长用两条粗壮的手臂攀爬险峻的山崖，并挥拳猛击！",
		"skill_name": "落石", "skill_desc": "举起巨石砸向目标，造成190点物理伤害并眩晕0.5秒。",
		"skill_detail": "消耗85能量，凭借惊人臂力从地面掀起巨岩狠狠砸向目标，造成190点岩石物理伤害并附带0.5秒眩晕。",
		"skill_power": 190,
		"skills": {
			1: {"name": "撞击·滚石", "desc": "硬化身体冲撞造成190点物理伤害。", "detail": "消耗85能量，坚硬身体撞击目标造成190点物理伤害。", "power": 190, "vfx": "rock_slide", "sfx": "skill", "scale": 0.34},
			2: {"name": "落石砸击", "desc": "掀起巨岩怒砸造成310点伤害并眩晕0.8秒。", "detail": "消耗85能量，投掷巨石造成310点伤害并眩晕0.8秒。", "power": 310, "vfx": "stone_edge", "sfx": "skill", "scale": 0.44},
			3: {"name": "大爆炸·万钧崩岩破", "desc": "引爆体内地核能量，造成650点范围巨额物理伤害与全员击飞！", "detail": "消耗85能量，引爆体内岩浆核心引发惊天大爆炸，对周围大范围所有敌军造成650点真实物理伤害并击飞1.5秒！", "power": 650, "vfx": "earthquake", "sfx": "skill", "scale": 0.56}
		},
		"visual": {"primary": (150, 145, 135), "secondary": (110, 105, 95), "accent": (70, 65, 60), "eye": (20, 20, 20), "archetype": "orb", "features": ["horns"]}
	},
	"graveler": {
		"num": 75, "id": "graveler", "name": "隆隆石", "title": "岩石宝可梦", "cost": 2,
		"types": ["Rock", "Ground"], "hp": 880, "atk": 72, "armor": 55, "mr": 25, "range": 1, "atk_speed": 0.65, "max_mana": 90,
		"desc": "在险峻的山道上以惊人的速度滚落前行，无论遇到什么障碍物都会毫不犹豫地一路碾压碾碎过去。",
		"skill_name": "滚动冲撞", "skill_desc": "蜷缩成巨岩高速滚动碾压，造成290点伤害并击退。",
		"skill_detail": "消耗90能量，四只手臂收缩成浑圆巨岩，以摧枯拉朽之势直线滚过战场，对沿途敌人造成290点物理伤害并击退1.5格。",
		"skill_power": 290,
		"skills": {
			1: {"name": "岩石飞刃", "desc": "射出锋利碎石造成200点物理伤害。", "detail": "消耗90能量，射出碎石造成200点伤害并削弱15%护甲。", "power": 200, "vfx": "rock_slide", "sfx": "skill", "scale": 0.38},
			2: {"name": "滚动冲撞", "desc": "高速滚动碾压造成290点伤害并击退1.5格。", "detail": "消耗90能量，滚动碾压造成290点伤害并强力击退。", "power": 290, "vfx": "stone_edge", "sfx": "skill", "scale": 0.48},
			3: {"name": "泰山陨落·十方崩山绝", "desc": "跃至半空轰然坠击，造成720点伤害并获得400点坚岩护盾！", "detail": "消耗90能量，跃起泰山压顶狂砸地面，造成720点范围伤害，并为自身施加400点无法被打破的坚岩护盾！", "power": 720, "vfx": "earthquake", "sfx": "skill", "scale": 0.60}
		},
		"visual": {"primary": (145, 135, 125), "secondary": (105, 98, 90), "accent": (65, 60, 55), "eye": (20, 20, 20), "archetype": "orb", "features": ["horns"]}
	},
	"golem": {
		"num": 76, "id": "golem", "name": "隆隆岩", "title": "重量级宝可梦", "cost": 4,
		"types": ["Rock", "Ground"], "hp": 1300, "atk": 98, "armor": 70, "mr": 35, "range": 1, "atk_speed": 0.65, "max_mana": 90,
		"desc": "外壳坚硬胜过钻石，甚至连炸药也无法在上面留下丝毫痕迹。在火山爆发时会像炮弹一样从山顶轰鸣滚落！",
		"skill_name": "地震·天崩地裂", "skill_desc": "撼动大地引爆十级大地震，造成560点范围伤害并全员眩晕1.5秒。",
		"skill_detail": "消耗90能量，重重顿足引发全场十级强烈地震，对大范围所有敌人造成560点地面物理伤害，并使全体目标眩晕1.5秒。",
		"skill_power": 560,
		"skills": {
			1: {"name": "岩崩", "desc": "召唤乱石砸击造成330点伤害并减速40%。", "detail": "消耗90能量，乱石从天而降造成330点物理伤害并减速40%。", "power": 330, "vfx": "rock_slide", "sfx": "skill", "scale": 0.44},
			2: {"name": "地震·天崩地裂", "desc": "引发地震造成560点范围伤害并眩晕1.5秒。", "detail": "消耗90能量，引发大地震造成560点物理伤害并眩晕1.5秒。", "power": 560, "vfx": "earthquake", "sfx": "skill", "scale": 0.56},
			3: {"name": "太古陨星·地心灭世核爆", "desc": "化身地核陨星毁灭全场，造成1300点真实物理伤害并全图击飞！", "detail": "消耗90能量，引爆地幔核心太古熔岩神能，对战场全屏敌人造成1300点毁灭真实物理伤害，全图击飞2秒并为全队附加350点坚岩护盾！", "power": 1300, "vfx": "stone_edge", "sfx": "skill", "scale": 0.72}
		},
		"visual": {"primary": (140, 130, 115), "secondary": (95, 90, 80), "accent": (60, 55, 50), "eye": (180, 40, 40), "archetype": "quadruped", "features": ["shell", "horns"]}
	},
	"ponyta": {
		"num": 77, "id": "ponyta", "name": "小火马", "title": "火马宝可梦", "cost": 1,
		"types": ["Fire"], "hp": 560, "atk": 54, "armor": 24, "mr": 24, "range": 1, "atk_speed": 0.75, "max_mana": 80,
		"desc": "刚出生时几乎站不稳，但在追赶父母的过程中锻炼出了惊人的脚力，鬃毛和尾巴燃烧着美丽炽热的烈火。",
		"skill_name": "火焰轮·烈蹄冲刺", "skill_desc": "踏火疾驰猛撞敌人，造成190点伤害并灼烧目标。",
		"skill_detail": "消耗80能量，四蹄烈火翻涌向前疾驰践踏，对目标造成190点火系物理伤害并附加2秒灼烧（每秒25点伤害）。",
		"skill_power": 190,
		"skills": {
			1: {"name": "烈焰踢", "desc": "燃火马蹄飞踢造成190点伤害并灼烧。", "detail": "消耗80能量，烈火飞踢造成190点伤害并灼烧2秒。", "power": 190, "vfx": "ember", "sfx": "fire", "scale": 0.32},
			2: {"name": "火焰轮·烈蹄冲刺", "desc": "化作火轮冲刺造成310点伤害并击退。", "detail": "消耗80能量，火焰轮突进造成310点伤害并击退目标。", "power": 310, "vfx": "flame_wheel", "sfx": "fire", "scale": 0.42},
			3: {"name": "炽烈飞鬃·踏火追风劫", "desc": "四蹄化作火海席卷敌阵，造成640点范围伤害并提升全队攻速25%。", "detail": "消耗80能量，奔腾引爆滔天火浪，对直线敌军造成640点伤害，全队攻击速度提升25%持续3秒。", "power": 640, "vfx": "flare_blitz", "sfx": "fire", "scale": 0.54}
		},
		"visual": {"primary": (245, 235, 210), "secondary": (240, 90, 30), "accent": (245, 170, 40), "eye": (30, 30, 40), "archetype": "quadruped", "features": ["ears", "tail", "tail_fire"]}
	},
	"rapidash": {
		"num": 78, "id": "rapidash", "name": "烈焰马", "title": "火马宝可梦", "cost": 3,
		"types": ["Fire"], "hp": 880, "atk": 78, "armor": 38, "mr": 35, "range": 1, "atk_speed": 0.85, "max_mana": 85,
		"desc": "最高时速可达240公里，奔跑起来就如同一道掠过草原的赤红火流星，马鬃上翻滚的烈火甚至能照亮夜空！",
		"skill_name": "闪焰冲锋·极速流火", "skill_desc": "化身流星火雨撞穿整排敌军，造成460点穿透火伤并全员灼烧。",
		"skill_detail": "消耗85能量，全身燃起深红烈焰以音速破空冲刺，贯穿整排所有敌人造成460点伤害，并使全体被穿透目标灼烧3秒。",
		"skill_power": 460,
		"skills": {
			1: {"name": "高速烈焰轮", "desc": "极速突进造成260点伤害并灼烧目标。", "detail": "消耗85能量，高速突击造成260点伤害并灼烧3秒。", "power": 260, "vfx": "flame_wheel", "sfx": "fire", "scale": 0.38},
			2: {"name": "闪焰冲锋·极速流火", "desc": "化身流星火雨撞穿整排造成460点穿透伤害。", "detail": "消耗85能量，流星贯穿造成460点穿透伤害并灼烧整排。", "power": 460, "vfx": "flare_blitz", "sfx": "fire", "scale": 0.50},
			3: {"name": "天马踏燕·焚天神圣烈火劫", "desc": "天马凌空践踏出八方火海，造成1050点巨额真实伤害与全员击飞！", "detail": "消耗85能量，脚踏虚空烈火化作天马凌空怒踏，震裂大地倾泻八荒火海，造成1050点毁灭真实伤害并击飞2秒！", "power": 1050, "vfx": "blast_burn", "sfx": "fire", "scale": 0.68}
		},
		"visual": {"primary": (245, 235, 210), "secondary": (245, 80, 25), "accent": (250, 180, 40), "eye": (30, 30, 40), "archetype": "quadruped", "features": ["ears", "tail", "tail_fire", "horns"]}
	},
	"slowpoke": {
		"num": 79, "id": "slowpoke", "name": "呆呆兽", "title": "憨憨宝可梦", "cost": 1,
		"types": ["Water", "Psychic"], "hp": 720, "atk": 45, "armor": 35, "mr": 35, "range": 1, "atk_speed": 0.55, "max_mana": 85,
		"desc": "总是呆呆地把尾巴垂进水里钓鱼。就算尾巴被咬住了，也要过整整一天才能感觉到疼痛，反应极度迟钝。",
		"skill_name": "迟钝哈欠·水流喷射", "skill_desc": "打哈欠使目标昏睡1.5秒，并喷出水流造成180点伤害。",
		"skill_detail": "消耗85能量，打一个大大的哈欠使当前攻击目标陷入嗜睡昏迷1.5秒，并慢悠悠喷出一股水流造成180点水系法术伤害。",
		"skill_power": 180,
		"skills": {
			1: {"name": "水枪·哈欠", "desc": "哈欠昏睡1.5秒并造成180点伤害。", "detail": "消耗85能量，哈欠催眠1.5秒并造成180点伤害。", "power": 180, "vfx": "water_gun", "sfx": "water", "scale": 0.32},
			2: {"name": "念力水弹", "desc": "念力催动水球造成310点伤害并减速40%。", "detail": "消耗85能量，念力水球造成310点伤害并降低40%攻速。", "power": 310, "vfx": "confusion", "sfx": "skill", "scale": 0.42},
			3: {"name": "万物皆空·大智若愚神念界", "desc": "进入绝对空灵顿悟境界，全体友军获得350护盾并嘲讽敌方！", "detail": "消耗85能量，引发天地空灵超能波动，使全场敌人被迫嘲讽自身攻击，自身受到伤害降低60%，并为全队附加350点超能护盾！", "power": 600, "vfx": "psychic", "sfx": "skill", "scale": 0.54}
		},
		"visual": {"primary": (245, 150, 175), "secondary": (245, 220, 200), "accent": (180, 90, 110), "eye": (20, 20, 20), "archetype": "quadruped", "features": ["ears", "tail"]}
	},
	"slowbro": {
		"num": 80, "id": "slowbro", "name": "呆壳兽", "title": "寄居蟹宝可梦", "cost": 3,
		"types": ["Water", "Psychic"], "hp": 1100, "atk": 68, "armor": 55, "mr": 50, "range": 1, "atk_speed": 0.60, "max_mana": 90,
		"desc": "尾巴被大舌贝咬住后发生了合体进化。大舌贝的毒素刺激了它的大脑，使其觉醒了不可思议的强大超能力！",
		"skill_name": "意念移物·巨贝守护", "skill_desc": "将目标悬浮禁锢2秒造成440点伤害，自身回复300点生命。",
		"skill_detail": "消耗90能量，尾部宝贝释放强大念力将敌方目标悬空定身2秒，造成440点超能伤害，同时自身激发再生力回复300点生命值。",
		"skill_power": 440,
		"skills": {
			1: {"name": "超能水炮", "desc": "发射超能水炮造成250点伤害并回复150生命。", "detail": "消耗90能量，念力水炮造成250点伤害并回血150点。", "power": 250, "vfx": "water_gun", "sfx": "water", "scale": 0.38},
			2: {"name": "意念移物·巨贝守护", "desc": "禁锢目标2秒造成440点伤害并回血300点。", "detail": "消耗90能量，悬空定身2秒造成440点伤害并回血300点。", "power": 440, "vfx": "psychic", "sfx": "skill", "scale": 0.50},
			3: {"name": "不动如山·天外神贝寂灭潮", "desc": "贝壳怒放终极念力狂潮，造成1020点伤害并使自身无敌2秒！", "detail": "消耗90能量，沟通深海古贝核心念力，对全场所有敌人造成1020点穿透伤害，自身进入绝对无敌状态2秒并为全队回血400点！", "power": 1020, "vfx": "hydro_cannon", "sfx": "water", "scale": 0.68}
		},
		"visual": {"primary": (240, 145, 170), "secondary": (160, 150, 160), "accent": (240, 215, 195), "eye": (20, 20, 20), "archetype": "biped", "features": ["ears", "tail", "shell"]}
	},
	"magnemite": {
		"num": 81, "id": "magnemite", "name": "小磁怪", "title": "磁铁宝可梦", "cost": 1,
		"types": ["Electric"], "hp": 500, "atk": 52, "armor": 35, "mr": 30, "range": 3, "atk_speed": 0.68, "max_mana": 75,
		"desc": "身体两侧的U形磁铁能释放强烈的电磁波，使自己始终漂浮在空中，靠近发电厂和电线杆时会被强大的电磁吸引。",
		"skill_name": "电击·电磁波", "skill_desc": "释放高压电流电击目标，造成170点伤害并麻痹敌人1.5秒。",
		"skill_detail": "消耗75能量，两端磁铁交替蓄电射出强力电弧，对目标造成170点雷电法术伤害，并附加1.5秒麻痹（攻速降低50%）。",
		"skill_power": 170,
		"skills": {
			1: {"name": "电击", "desc": "释放电弧造成170点伤害并麻痹1.5秒。", "detail": "消耗75能量，射出电弧造成170点伤害并麻痹1.5秒。", "power": 170, "vfx": "thunderbolt", "sfx": "electric", "scale": 0.30},
			2: {"name": "电磁炮·蓄能", "desc": "蓄能发射电磁重炮造成310点伤害并眩晕1秒。", "detail": "消耗75能量，发射电磁重炮造成310点伤害并眩晕1秒。", "power": 310, "vfx": "thunder", "sfx": "electric", "scale": 0.40},
			3: {"name": "磁暴天劫·雷极风暴界", "desc": "两极过载引爆全屏磁暴，造成620点巨额雷伤并全员麻痹2秒。", "detail": "消耗75能量，引爆体内两极磁场形成天劫雷暴，对全场所有敌人造成620点雷电伤害并使全员麻痹2秒！", "power": 620, "vfx": "hyper_beam", "sfx": "electric", "scale": 0.52}
		},
		"visual": {"primary": (175, 180, 190), "secondary": (215, 50, 50), "accent": (45, 95, 210), "eye": (20, 20, 20), "archetype": "orb", "features": ["floating"]}
	},
	"magneton": {
		"num": 82, "id": "magneton", "name": "三合一磁怪", "title": "磁铁宝可梦", "cost": 3,
		"types": ["Electric"], "hp": 850, "atk": 82, "armor": 48, "mr": 42, "range": 3, "atk_speed": 0.72, "max_mana": 80,
		"desc": "由三只小磁怪通过强大的电磁力紧密连接在一起，释放出的强劲磁力甚至能将周围半径一公里内的水分全部蒸发！",
		"skill_name": "三重电磁加农炮", "skill_desc": "三眼齐射超能电磁光束，造成440点伤害并瓦解40%魔抗。",
		"skill_detail": "消耗80能量，三个核心同步过载共振，向前方发射三道交织的毁灭电磁光束，造成440点雷电法术伤害并粉碎目标40%法抗，持续3秒。",
		"skill_power": 440,
		"skills": {
			1: {"name": "十万伏特", "desc": "发射强力雷电造成250点伤害并麻痹。", "detail": "消耗80能量，发射十万伏特造成250点伤害并麻痹1.5秒。", "power": 250, "vfx": "thunderbolt", "sfx": "electric", "scale": 0.38},
			2: {"name": "三重电磁加农炮", "desc": "三核发射电磁光束造成440点伤害并碎抗。", "detail": "消耗80能量，三核射出电磁束造成440点伤害并削弱40%法抗。", "power": 440, "vfx": "thunder", "sfx": "electric", "scale": 0.48},
			3: {"name": "神罚磁场·九天玄雷毁灭阵", "desc": "三位一体引下天罚狂雷，造成1050点毁灭真实伤害与全员瘫痪2秒！", "detail": "消耗80能量，三具身体形成太极磁矩阵贯通苍穹，召唤九天狂雷洗地，对全图所有敌人造成1050点真实雷电伤害并瘫痪2秒！", "power": 1050, "vfx": "hyper_beam", "sfx": "electric", "scale": 0.68}
		},
		"visual": {"primary": (170, 175, 185), "secondary": (220, 45, 45), "accent": (40, 90, 205), "eye": (20, 20, 20), "archetype": "orb", "features": ["floating"]}
	},
	"farfetchd": {
		"num": 83, "id": "farfetchd", "name": "大葱鸭", "title": "大葱宝可梦", "cost": 2,
		"types": ["Normal", "Flying"], "hp": 680, "atk": 70, "armor": 30, "mr": 30, "range": 1, "atk_speed": 0.78, "max_mana": 75,
		"desc": "总是随身携带一根品质上乘的大葱，把大葱当作武器如同真正的剑客一般舞动，如果大葱损坏了就会陷入恐慌。",
		"skill_name": "大葱连斩·一闪", "skill_desc": "化身剑客瞬步连斩，造成280点穿透物理伤害并击飞。",
		"skill_detail": "消耗75能量，拔出大葱化作青翠剑气瞬步斩过目标，造成280点穿透物理伤害并造成0.8秒挑空击飞，必定暴击。",
		"skill_power": 280,
		"skills": {
			1: {"name": "葱刀劈砍", "desc": "大葱挥击造成190点物理伤害。", "detail": "消耗75能量，挥舞大葱斩击造成190点物理伤害。", "power": 190, "vfx": "slash", "sfx": "skill", "scale": 0.34},
			2: {"name": "大葱连斩·一闪", "desc": "瞬步连斩造成280点穿透物理伤害并挑飞。", "detail": "消耗75能量，瞬步剑斩造成280点穿透伤害并击飞0.8秒。", "power": 280, "vfx": "air_slash", "sfx": "skill", "scale": 0.44},
			3: {"name": "剑圣真传·青葱百裂断岳斩", "desc": "大葱化作百丈青罡剑芒，造成700点真实暴击伤害并斩杀虚弱目标！", "detail": "消耗75能量，领悟无上葱剑道奥义，斩出裂地惊天剑芒，对直线敌人造成700点真实物理伤害，若目标生命低于30%则直接斩杀！", "power": 700, "vfx": "brave_bird", "sfx": "skill", "scale": 0.58}
		},
		"visual": {"primary": (160, 115, 75), "secondary": (240, 235, 220), "accent": (70, 170, 70), "eye": (20, 20, 20), "archetype": "avian", "features": ["wings", "beak"]}
	},
	"doduo": {
		"num": 84, "id": "doduo", "name": "嘟嘟", "title": "双头鸟宝可梦", "cost": 1,
		"types": ["Normal", "Flying"], "hp": 550, "atk": 58, "armor": 22, "mr": 20, "range": 1, "atk_speed": 0.80, "max_mana": 70,
		"desc": "长有两个脑袋，两只脑袋的大脑通过心灵感应彼此相通。虽然翅膀退化无法飞翔，但双腿奔跑速度可达时速100公里！",
		"skill_name": "疯狂乱打·双喙连啄", "skill_desc": "两个脑袋狂风暴雨连啄，造成190点伤害并破甲20%。",
		"skill_detail": "消耗70能量，两个头颅以惊人频率交替啄击目标，造成190点普通物理伤害并撕裂其20%护甲持续2.5秒。",
		"skill_power": 190,
		"skills": {
			1: {"name": "啄击", "desc": "高速啄击造成190点物理伤害并破甲。", "detail": "消耗70能量，双喙啄击造成190点伤害并削弱20%护甲。", "power": 190, "vfx": "slash", "sfx": "skill", "scale": 0.32},
			2: {"name": "疾风双头突刺", "desc": "高速突刺造成310点伤害并使其流血。", "detail": "消耗70能量，狂风突刺造成310点物理伤害并附加流血。", "power": 310, "vfx": "drill_peck", "sfx": "skill", "scale": 0.42},
			3: {"name": "狂飙奔雷·千影神速践踏", "desc": "双足踏破疾风残影，造成620点巨额物理伤害与全员挑飞！", "detail": "消耗70能量，化身双头狂风在敌阵中高速穿梭践踏，对最多4名敌军造成620点伤害并击飞1秒！", "power": 620, "vfx": "brave_bird", "sfx": "skill", "scale": 0.54}
		},
		"visual": {"primary": (175, 130, 85), "secondary": (230, 205, 150), "accent": (30, 30, 30), "eye": (20, 20, 20), "archetype": "avian", "features": ["beak", "wings"]}
	},
	"dodrio": {
		"num": 85, "id": "dodrio", "name": "嘟嘟利", "title": "三头鸟宝可梦", "cost": 3,
		"types": ["Normal", "Flying"], "hp": 860, "atk": 85, "armor": 35, "mr": 30, "range": 1, "atk_speed": 0.90, "max_mana": 75,
		"desc": "三个脑袋分别代表喜悦、悲伤与愤怒。三个头交替巡视敌情从不入睡，奔跑在广阔草原上时宛如贴地狂飙的战车！",
		"skill_name": "三重钻角啄·暴风三连击", "skill_desc": "三头高速旋转如钻头突刺，造成450点高额伤害并粉碎护甲。",
		"skill_detail": "消耗75能量，三个头颅同时高速旋转化作强力破甲钻头，猛烈贯穿目标，造成450点巨额物理伤害并粉碎45%护甲持续3秒。",
		"skill_power": 450,
		"skills": {
			1: {"name": "钻孔啄", "desc": "旋转啄击造成250点物理伤害并破甲30%。", "detail": "消耗75能量，钻孔啄击造成250点伤害并削弱30%护甲。", "power": 250, "vfx": "drill_peck", "sfx": "skill", "scale": 0.38},
			2: {"name": "三重钻角啄·暴风三连击", "desc": "三头旋转突刺造成450点伤害并粉碎护甲。", "detail": "消耗75能量，三钻头贯穿造成450点伤害并粉碎45%护甲。", "power": 450, "vfx": "brave_bird", "sfx": "skill", "scale": 0.50},
			3: {"name": "修罗三面·怒涛极速狂飙劫", "desc": "三面修罗神速分身践踏，造成1020点穿透真实伤害并全图流血！", "detail": "消耗75能量，三颗头颅同时引动喜怒哀三面煞气，化作三道残影分身洗劫战场，对所有敌军造成1020点真实伤害并附加持续4秒的剧烈流血！", "power": 1020, "vfx": "air_slash", "sfx": "skill", "scale": 0.68}
		},
		"visual": {"primary": (170, 125, 80), "secondary": (235, 205, 145), "accent": (30, 30, 30), "eye": (20, 20, 20), "archetype": "avian", "features": ["beak", "wings"]}
	},
	"seel": {
		"num": 86, "id": "seel", "name": "小海狮", "title": "海狮宝可梦", "cost": 1,
		"types": ["Water"], "hp": 620, "atk": 48, "armor": 30, "mr": 35, "range": 2, "atk_speed": 0.65, "max_mana": 80,
		"desc": "覆盖着纯白厚实毛皮的小海狮不怕严寒，头顶突出的尖角极其坚硬，能轻松撞碎厚重的极地浮冰捕食海鱼。",
		"skill_name": "冰冻之风", "skill_desc": "从口中呼出极寒冻气，造成170点法术伤害并降低40%攻速。",
		"skill_detail": "消耗80能量，吐出刺骨的冰霜寒风吹拂目标，造成170点水/冰法术伤害，并降低其40%移动速度与攻击速度持续3秒。",
		"skill_power": 170,
		"skills": {
			1: {"name": "冰冻之风", "desc": "寒风吹拂造成170点伤害并减速40%。", "detail": "消耗80能量，吐出冻风造成170点伤害并减速40%。", "power": 170, "vfx": "ice_beam", "sfx": "skill", "scale": 0.32},
			2: {"name": "极光束·破冰角撞", "desc": "极光照耀尖角撞击造成300点伤害并冰冻1秒。", "detail": "消耗80能量，极光伴随冰角冲撞造成300点伤害并冰冻目标1秒。", "power": 300, "vfx": "aurora_beam", "sfx": "skill", "scale": 0.42},
			3: {"name": "极地暴风雪·万载玄冰魄", "desc": "召唤极地大暴风雪，造成620点巨额伤害并全员冻结1.5秒。", "detail": "消耗80能量，引动北极玄冰暴风雪笼罩全场，造成620点大范围法术伤害并强制冰冻所有敌人1.5秒！", "power": 620, "vfx": "blizzard", "sfx": "skill", "scale": 0.54}
		},
		"visual": {"primary": (245, 245, 250), "secondary": (205, 225, 245), "accent": (140, 180, 220), "eye": (20, 20, 20), "archetype": "quadruped", "features": ["tail", "horns"]}
	},
	"dewgong": {
		"num": 87, "id": "dewgong", "name": "白海狮", "title": "海狮宝可梦", "cost": 3,
		"types": ["Water", "Ice"], "hp": 980, "atk": 70, "armor": 45, "mr": 55, "range": 2, "atk_speed": 0.70, "max_mana": 85,
		"desc": "全身雪白流线型的身躯在冰冷的海水中优雅游弋，白天在冰山上晒太阳储存热量，夜晚则能在冰海中高速狩猎！",
		"skill_name": "绝对零度·极光射线", "skill_desc": "头角汇聚万载玄冰激射极光，造成440点伤害并冰冻2秒。",
		"skill_detail": "消耗85能量，头顶玉角汇聚刺骨寒芒，向前方扇形喷发绚丽的极光光束，造成440点冰系伤害，并使被命中的首要目标陷入绝对冰冻2秒。",
		"skill_power": 440,
		"skills": {
			1: {"name": "极光束", "desc": "发射极光造成240点伤害并降低30%攻击力。", "detail": "消耗85能量，极光扫射造成240点伤害并降低30%敌方攻击力。", "power": 240, "vfx": "aurora_beam", "sfx": "skill", "scale": 0.38},
			2: {"name": "绝对零度·极光射线", "desc": "极光喷发造成440点伤害并绝对冰冻2秒。", "detail": "消耗85能量，扇形极光造成440点伤害并冻结目标2秒。", "power": 440, "vfx": "ice_beam", "sfx": "skill", "scale": 0.50},
			3: {"name": "极寒霜天·万丈冰川封神破", "desc": "召唤极北万里冰川撞击战场，造成1020点真实伤害并全图冻结2秒！", "detail": "消耗85能量，引爆极地玄冰圣力，苍穹降下万丈冰川崩塌，对全体敌军造成1020点毁灭真实伤害并绝对冰冻全场2秒！", "power": 1020, "vfx": "blizzard", "sfx": "skill", "scale": 0.68}
		},
		"visual": {"primary": (245, 245, 255), "secondary": (195, 220, 245), "accent": (130, 175, 220), "eye": (20, 20, 20), "archetype": "quadruped", "features": ["tail", "horns"]}
	},
	"grimer": {
		"num": 88, "id": "grimer", "name": "臭泥", "title": "污泥宝可梦", "cost": 1,
		"types": ["Poison"], "hp": 680, "atk": 52, "armor": 30, "mr": 30, "range": 1, "atk_speed": 0.60, "max_mana": 80,
		"desc": "诞生于受到工厂污水严重污染的烂泥中，喜欢以充满恶臭的垃圾和毒性废液为食，身体黏滑无论穿过什么都会留下毒渍。",
		"skill_name": "掷泥·污泥攻击", "skill_desc": "甩出腐蚀剧毒烂泥团，造成180点伤害并降低目标40%命中。",
		"skill_detail": "消耗80能量，从体内扯出一大团恶臭剧毒污泥砸向目标，造成180点毒系伤害，并使其失明致盲（40%攻击落空），持续3秒。",
		"skill_power": 180,
		"skills": {
			1: {"name": "掷泥", "desc": "投掷烂泥造成180点伤害并致盲40%。", "detail": "消耗80能量，投掷污泥造成180点伤害并致盲40%。", "power": 180, "vfx": "sludge_bomb", "sfx": "skill", "scale": 0.32},
			2: {"name": "溶化·剧毒涌动", "desc": "身体化为毒池造成300点范围伤害并自身护甲+30%。", "detail": "消耗80能量，融化为毒液造成300点范围伤害并提升自身30%护甲。", "power": 300, "vfx": "acid_armor", "sfx": "skill", "scale": 0.42},
			3: {"name": "万毒浊流·剧毒天幕倾泻", "desc": "喷发恶臭毒泥海啸淹没敌阵，造成640点伤害并全员剧毒腐蚀！", "detail": "消耗80能量，引爆体内千钧剧毒淤泥，化作惊涛毒浪吞噬敌阵，造成640点真实毒伤并削弱40%护甲与魔抗持续4秒！", "power": 640, "vfx": "gunk_shot", "sfx": "skill", "scale": 0.55}
		},
		"visual": {"primary": (160, 100, 170), "secondary": (115, 65, 125), "accent": (60, 30, 70), "eye": (20, 20, 20), "archetype": "orb", "features": ["sludge"]}
	},
	"muk": {
		"num": 89, "id": "muk", "name": "臭臭泥", "title": "污泥宝可梦", "cost": 3,
		"types": ["Poison"], "hp": 1150, "atk": 76, "armor": 45, "mr": 45, "range": 1, "atk_speed": 0.65, "max_mana": 85,
		"desc": "身体散发出的强烈恶臭甚至能让周围的花草树木顷刻枯萎死绝，即使只碰到它滴下的一滴体液也会引发严重中毒。",
		"skill_name": "垃圾射击·蚀骨剧毒沼", "skill_desc": "喷吐巨型剧毒垃圾球，造成440点伤害并在地面留下持续毒沼。",
		"skill_detail": "消耗85能量，凝聚体内最浓烈的恶臭剧毒污泥轰向目标区域，造成440点毒系伤害，并在地面生成一片持续5秒的毒沼（踩踏敌人每秒受到60点真实伤害并减速40%）。",
		"skill_power": 440,
		"skills": {
			1: {"name": "污泥炸弹", "desc": "发射毒弹造成250点伤害并中毒3秒。", "detail": "消耗85能量，发射毒弹造成250点伤害并使目标中毒3秒。", "power": 250, "vfx": "sludge_bomb", "sfx": "skill", "scale": 0.38},
			2: {"name": "垃圾射击·蚀骨剧毒沼", "desc": "发射毒泥球造成440点伤害并生成持续毒沼。", "detail": "消耗85能量，发射垃圾毒泥造成440点伤害并形成减速毒沼5秒。", "power": 440, "vfx": "gunk_shot", "sfx": "skill", "scale": 0.50},
			3: {"name": "毒霸天下·无相化尸太阴绝", "desc": "化身千吨毒沼吞噬全场，造成1050点毁灭毒伤并让全屏敌人瘫痪！", "detail": "消耗85能量，整个身躯溶化为覆盖全图的遮天毒云，对所有敌人造成1050点毁灭真实毒伤，粉碎50%双抗并瘫痪其普攻2.5秒！", "power": 1050, "vfx": "acid_armor", "sfx": "skill", "scale": 0.70}
		},
		"visual": {"primary": (150, 90, 160), "secondary": (105, 55, 115), "accent": (55, 25, 65), "eye": (20, 20, 20), "archetype": "orb", "features": ["sludge"]}
	},
	"shellder": {
		"num": 90, "id": "shellder", "name": "大舌贝", "title": "双壳贝宝可梦", "cost": 1,
		"types": ["Water"], "hp": 580, "atk": 45, "armor": 50, "mr": 25, "range": 2, "atk_speed": 0.65, "max_mana": 75,
		"desc": "坚硬的贝壳能抵御任何强力攻击，但贝壳打开露出柔软本体时是其最脆弱的时刻，伸出大舌头来引诱并夹住猎物。",
		"skill_name": "极光束·贝壳夹击", "skill_desc": "张合贝壳发射极光，造成180点伤害并夹击眩晕0.8秒。",
		"skill_detail": "消耗75能量，瞬间合拢坚固贝壳迸发一道极光光束，造成180点水/冰法术伤害，并将目标死死夹住造成0.8秒眩晕。",
		"skill_power": 180,
		"skills": {
			1: {"name": "水枪·贝夹", "desc": "水流夹击造成180点伤害并眩晕0.8秒。", "detail": "消耗75能量，贝壳夹击造成180点伤害并眩晕0.8秒。", "power": 180, "vfx": "water_gun", "sfx": "water", "scale": 0.32},
			2: {"name": "冰锥乱射", "desc": "连续发射锋利冰锥造成300点伤害并减速。", "detail": "消耗75能量，连续射出5枚冰锥造成300点伤害并减速40%。", "power": 300, "vfx": "ice_beam", "sfx": "skill", "scale": 0.42},
			3: {"name": "玄武神甲·万仞寒冰断罪破", "desc": "贝壳极速张合引发极寒冰浪，造成620点伤害并为自身施加500坚甲！", "detail": "消耗75能量，贝壳剧烈闭合引爆澎湃寒冰冲击波，造成620点伤害，自身获得500点绝对物理防御护盾！", "power": 620, "vfx": "blizzard", "sfx": "skill", "scale": 0.54}
		},
		"visual": {"primary": (135, 95, 175), "secondary": (245, 120, 140), "accent": (240, 240, 245), "eye": (20, 20, 20), "archetype": "shell", "features": ["tongue"]}
	}
}
