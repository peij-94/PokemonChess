# Gen 1 Pokemon: 001 - 030
POKEMON_CHUNK_1 = {
	"bulbasaur": {
		"num": 1, "id": "bulbasaur", "name": "妙蛙种子", "title": "种子宝可梦", "cost": 1,
		"types": ["Grass", "Poison"], "hp": 600, "atk": 48, "armor": 30, "mr": 30, "range": 2, "atk_speed": 0.65, "max_mana": 100,
		"desc": "背上的种子伴随它一同成长，战斗中能甩出翡翠般锋利的飞叶快刀，并汲取敌方养分回馈自身生命！",
		"skill_name": "寄生种子", "skill_desc": "寄生敌方吸取生命，造成160点伤害并将100%转化为自身回复。",
		"skill_detail": "消耗100能量，向目标射出一枚寄生种子，每秒造成80点草系伤害（共160点），并将造成的全部伤害100%转化为自身生命值。",
		"skill_power": 160,
		"skills": {
			1: {"name": "寄生种子", "desc": "寄生敌方吸取生命，造成160点伤害并将100%转化为自身回复。", "detail": "消耗100能量，向目标射出一枚寄生种子，每秒造成80点草系伤害（共160点），并将造成的全部伤害100%转化为自身生命值。", "power": 160, "vfx": "leech_seed", "sfx": "skill", "scale": 0.36},
			2: {"name": "飞叶快刀", "desc": "扇形飞射翡翠快刀，对3名敌人各造成320点伤害并回复自身220点生命。", "detail": "消耗100能量，从背后球茎两侧甩出两波破空飞行的锋利翡翠利叶，对最多3名敌方单位各造成320点草系法术伤害，同时汲取精华回复自身220点生命。", "power": 320, "vfx": "razor_leaf", "sfx": "skill", "scale": 0.45},
			3: {"name": "疯狂植物", "desc": "召唤史诗巨树狂暴根须破地而出，造成650点巨额范围伤害并禁锢2秒。", "detail": "消耗100能量，沟通大地引爆森林之力，无数巨型荆棘藤蔓与尖刺古木破土而出，对范围内所有敌方单位造成650点草系毁灭伤害，禁锢2秒并为自身回复450点生命值。", "power": 650, "vfx": "frenzy_plant", "sfx": "skill", "scale": 0.55}
		},
		"visual": {"primary": (70, 190, 155), "secondary": (40, 140, 80), "accent": (220, 40, 40), "eye": (220, 40, 40), "archetype": "quadruped", "features": ["bulb", "ears"]}
	},
	"ivysaur": {
		"num": 2, "id": "ivysaur", "name": "妙蛙草", "title": "种子宝可梦", "cost": 2,
		"types": ["Grass", "Poison"], "hp": 750, "atk": 62, "armor": 35, "mr": 35, "range": 2, "atk_speed": 0.68, "max_mana": 100,
		"desc": "背上的花苞正在吸收阳光积蓄力量，盛开前会散发出清甜的香气，能挥舞强力藤鞭抽打并束缚敌人。",
		"skill_name": "强力藤鞭", "skill_desc": "挥舞双藤猛击前方敌人，造成240点伤害并击退1格。",
		"skill_detail": "消耗100能量，从背部两侧甩出坚韧强力藤鞭狠狠抽打前方目标，造成240点草系伤害并击退1格。",
		"skill_power": 240,
		"skills": {
			1: {"name": "强力藤鞭", "desc": "挥舞双藤猛击目标造成240点伤害并击退1格。", "detail": "消耗100能量，挥舞强力双藤抽打目标造成240点草系物理伤害并击退1格。", "power": 240, "vfx": "leech_seed", "sfx": "skill", "scale": 0.40},
			2: {"name": "毒粉·落英飞叶", "desc": "喷洒毒粉飞叶对前方扇形造成420点伤害并中毒3秒。", "detail": "消耗100能量，花苞喷洒剧毒粉末伴随锋利飞叶，对前方扇形所有敌人造成420点法术伤害并附加中毒3秒。", "power": 420, "vfx": "razor_leaf", "sfx": "skill", "scale": 0.48},
			3: {"name": "荆棘绽放·生命之泉", "desc": "花苞怒放爆发巨型荆棘，造成780点伤害并为全体友军回血350。", "detail": "消耗100能量，引爆自然生命力花苞瞬间怒放，荆棘突刺对全场敌人造成780点毁灭伤害并为全体友军回复350点生命。", "power": 780, "vfx": "frenzy_plant", "sfx": "skill", "scale": 0.58}
		},
		"visual": {"primary": (65, 175, 160), "secondary": (180, 50, 90), "accent": (30, 90, 80), "eye": (200, 30, 60), "archetype": "quadruped", "features": ["bulb", "ears", "leaves"]}
	},
	"venusaur": {
		"num": 3, "id": "venusaur", "name": "妙蛙花", "title": "种子宝可梦", "cost": 4,
		"types": ["Grass", "Poison"], "hp": 1100, "atk": 85, "armor": 50, "mr": 50, "range": 3, "atk_speed": 0.70, "max_mana": 100,
		"desc": "背上盛开着巨大的花朵，能吸收太阳光能将其转化为强大的自然毁灭之力，挥动粗壮巨木根须压制战场！",
		"skill_name": "阳光烈焰", "skill_desc": "汇聚耀眼光能喷射毁灭光柱，贯穿直线造成450点法术伤害。",
		"skill_detail": "消耗100能量，背上的巨花瞬间汇聚浩瀚太阳能量，向前射出高能阳光烈焰光束，贯穿整条直线造成450点法术伤害。",
		"skill_power": 450,
		"skills": {
			1: {"name": "阳光烈焰", "desc": "聚能射出璀璨日光巨柱，贯穿直线造成450点法术伤害。", "detail": "消耗100能量，汇聚日光能量射出直线日光光柱，贯穿目标方向所有敌军造成450点草系法术伤害。", "power": 450, "vfx": "hyper_beam", "sfx": "skill", "scale": 0.48},
			2: {"name": "落英缤纷·剧毒花海", "desc": "在战场生成剧毒花海，造成680点范围伤害并瘫痪攻速50%。", "detail": "消耗100能量，释放漫天剧毒花瓣席卷半场，对范围内敌人造成680点草/毒混合伤害，削弱其50%攻击速度持续3秒。", "power": 680, "vfx": "razor_leaf", "sfx": "skill", "scale": 0.58},
			3: {"name": "森罗万象·万木狂生", "desc": "远古神树根须破地扫荡全场，造成1200点真实伤害并全员禁锢2.5秒。", "detail": "消耗100能量，沟通大地核心唤醒太古森罗古树，地底深处无数参天木根贯穿全图，对全体敌军造成1200点真实伤害，禁锢2.5秒并为自身施加800点神木护盾！", "power": 1200, "vfx": "frenzy_plant", "sfx": "skill", "scale": 0.70}
		},
		"visual": {"primary": (60, 160, 150), "secondary": (220, 60, 80), "accent": (240, 200, 60), "eye": (180, 20, 40), "archetype": "quadruped", "features": ["flower", "leaves", "ears"]}
	},
	"charmander": {
		"num": 4, "id": "charmander", "name": "小火龙", "title": "蜥蜴宝可梦", "cost": 1,
		"types": ["Fire"], "hp": 550, "atk": 52, "armor": 20, "mr": 20, "range": 2, "atk_speed": 0.70, "max_mana": 100,
		"desc": "尾巴上的火焰代表它的生命力，状态绝佳时火焰会熊熊燃烧。擅长远距离喷射烈焰并点燃多名敌方单位！",
		"skill_name": "火花", "skill_desc": "向目标吐射灼热火花，造成180点法术伤害并点燃敌人2秒。",
		"skill_detail": "消耗100能量，向目标连续吐出炽热火花，造成180点单体火系法术伤害，并附加持续2秒的轻度灼烧（每秒20点真实伤害）。",
		"skill_power": 180,
		"skills": {
			1: {"name": "火花", "desc": "向目标吐射灼热火花，造成180点法术伤害并点燃敌人2秒。", "detail": "消耗100能量，向目标连续吐出炽热火花，造成180点单体火系法术伤害，并附加持续2秒的轻度灼烧（每秒20点真实伤害）。", "power": 180, "vfx": "ember", "sfx": "fire", "scale": 0.28},
			2: {"name": "火焰旋涡", "desc": "在目标脚下召唤烈焰风暴，造成340点范围伤害并减速敌人30%。", "detail": "消耗100能量，在目标密集区域卷起炽烈的火焰旋涡，对范围内所有敌人造成340点火系范围法术伤害，降低其30%移速与攻速，并灼烧3秒（每秒30点真实伤害）。", "power": 340, "vfx": "flamethrower", "sfx": "fire", "scale": 0.35},
			3: {"name": "炼狱爆炎", "desc": "释放终极炽热炼狱，造成680点巨额范围真实火伤并永久灼烧。", "detail": "消耗100能量，引爆体内狂暴龙火化身炼狱，向正前方扇形区域喷发深红烈焰，对范围内所有敌人造成680点巨额火系真实伤害，并施加持续至战斗结束的剧烈灼烧（每秒45点真实伤害）。", "power": 680, "vfx": "inferno", "sfx": "fire", "scale": 0.46}
		},
		"visual": {"primary": (245, 130, 45), "secondary": (250, 220, 150), "accent": (240, 70, 20), "eye": (40, 130, 200), "archetype": "biped", "features": ["tail_fire"]}
	},
	"charmeleon": {
		"num": 5, "id": "charmeleon", "name": "火恐龙", "title": "火焰宝可梦", "cost": 2,
		"types": ["Fire"], "hp": 720, "atk": 68, "armor": 30, "mr": 30, "range": 2, "atk_speed": 0.72, "max_mana": 100,
		"desc": "性格粗暴好战，遇到强敌时尾巴上的火焰会化作青白色，挥动锋利双爪撕裂猎物并喷射熊熊烈焰！",
		"skill_name": "火焰牙·撕裂", "skill_desc": "燃火利齿凶狠撕咬目标，造成260点伤害并灼烧。",
		"skill_detail": "消耗100能量，双眼充血扑向目标挥动火炎利爪与炽热犬齿，造成260点物理/火焰伤害并使其灼烧3秒。",
		"skill_power": 260,
		"skills": {
			1: {"name": "火焰牙·撕裂", "desc": "燃火利齿撕咬目标造成260点伤害并灼烧3秒。", "detail": "消耗100能量，凶狠撕咬目标造成260点火系伤害并造成每秒25点真实灼烧伤害持续3秒。", "power": 260, "vfx": "fire_fang", "sfx": "fire", "scale": 0.40},
			2: {"name": "烈焰突袭", "desc": "化身火龙卷冲撞整排敌人，造成450点伤害并降低20%护甲。", "detail": "消耗100能量，全身裹挟炽热烈焰狂暴突进，穿透整排敌军造成450点伤害并撕碎其20%护甲持续3秒。", "power": 450, "vfx": "flame_wheel", "sfx": "fire", "scale": 0.48},
			3: {"name": "火龙破天击", "desc": "尾部爆炎腾空下劈，造成820点毁灭真实伤害并眩晕1.5秒。", "detail": "消耗100能量，尾部青白烈焰暴涨腾空而起，战斧劈腿重踏目标区域，造成820点真实伤害并震晕范围内敌人1.5秒！", "power": 820, "vfx": "inferno", "sfx": "fire", "scale": 0.58}
		},
		"visual": {"primary": (210, 50, 40), "secondary": (240, 190, 130), "accent": (240, 80, 20), "eye": (50, 150, 220), "archetype": "biped", "features": ["tail_fire", "horns"]}
	},
	"charizard": {
		"num": 6, "id": "charizard", "name": "喷火龙", "title": "火焰宝可梦", "cost": 4,
		"types": ["Fire", "Flying"], "hp": 950, "atk": 88, "armor": 40, "mr": 40, "range": 3, "atk_speed": 0.75, "max_mana": 100,
		"desc": "翱翔于天际寻找强劲对手，口中喷出的炽热火焰能融化一切岩石与冰川。战斗时引发全屏滔天大字爆炎！",
		"skill_name": "大字爆炎", "skill_desc": "喷射巨型“大”字烈火印记轰击，造成550点大范围爆鸣伤害。",
		"skill_detail": "消耗100能量，从深渊龙喉喷射出灼热刺目的“大”字烈焰，精准轰击敌方核心密集阵型，造成550点火系范围伤害并灼烧4秒。",
		"skill_power": 550,
		"skills": {
			1: {"name": "烈焰喷射", "desc": "扇形喷吐强力龙火，对多名敌人造成320点伤害。", "detail": "消耗100能量，展开双翼向前连续狂暴喷吐三波龙息烈焰，对扇形范围内所有敌人造成320点伤害。", "power": 320, "vfx": "flamethrower", "sfx": "fire", "scale": 0.40},
			2: {"name": "大字爆炎", "desc": "喷射巨型“大”字烈火印记轰击，造成550点大范围爆鸣伤害。", "detail": "消耗100能量，从深渊龙喉喷射出灼热刺目的“大”字烈焰，精准轰击敌方核心密集阵型，造成550点火系范围伤害并灼烧4秒。", "power": 550, "vfx": "fire_blast", "sfx": "fire", "scale": 0.50},
			3: {"name": "爆炸烈焰·天崩地裂", "desc": "全屏火山熔岩柱暴起，造成1150点毁灭伤害并施加40%易伤。", "detail": "消耗100能量，腾空至极高点俯冲引发大地板块断裂，数道炽金熔岩火柱自地心喷涌而出，对全体敌军造成1150点毁灭真实伤害，并使目标受到伤害提升40%！", "power": 1150, "vfx": "blast_burn", "sfx": "fire", "scale": 0.65}
		},
		"visual": {"primary": (240, 110, 30), "secondary": (245, 225, 140), "accent": (50, 130, 140), "eye": (50, 150, 200), "archetype": "biped", "features": ["wings", "tail_fire", "horns"]}
	},
	"squirtle": {
		"num": 7, "id": "squirtle", "name": "杰尼龟", "title": "小龟宝可梦", "cost": 1,
		"types": ["Water"], "hp": 620, "atk": 46, "armor": 35, "mr": 35, "range": 2, "atk_speed": 0.65, "max_mana": 100,
		"desc": "遇到危险时会缩入坚硬圆壳中，并以惊人的水压从口中喷出高压水枪，坚硬外壳能吸收大量战斗冲击！",
		"skill_name": "水枪", "skill_desc": "喷射高压水枪冲击敌人，造成150点法术伤害并获得200点护甲水盾。",
		"skill_detail": "消耗100能量，从口中射出一记强劲的高速水弹冲击目标，造成150点水系法术伤害，同时自身缩壳凝结水灵之气，获得持续4秒的200点护甲护盾。",
		"skill_power": 150,
		"skills": {
			1: {"name": "水枪", "desc": "喷射高压水枪冲击敌人，造成150点法术伤害并获得200点护甲水盾。", "detail": "消耗100能量，射出高压水流造成150点单体伤害并获得200点水系护盾。", "power": 150, "vfx": "water_gun", "sfx": "water", "scale": 0.32},
			2: {"name": "水炮", "desc": "双管喷出破空水柱贯穿直线，造成300点范围伤害并击退。", "detail": "消耗100能量，以强劲水流猛烈轰击目标直线，造成300点范围法术伤害并击退沿途敌人，为自身附加380点护盾。", "power": 300, "vfx": "hydro_pump", "sfx": "water", "scale": 0.40},
			3: {"name": "加农水炮", "desc": "释放滔天海啸重炮，造成620点巨额范围伤害与全体击退。", "detail": "消耗100能量，引爆深海漩涡之力轰出两道贯穿全场的加农狂涛，对全场所有敌人造成620点巨额水系伤害，强制击飞1.2秒并赋予全队650点神圣水壁护盾！", "power": 620, "vfx": "hydro_cannon", "sfx": "water", "scale": 0.52}
		},
		"visual": {"primary": (100, 190, 230), "secondary": (240, 220, 140), "accent": (150, 75, 40), "eye": (180, 50, 60), "archetype": "quadruped", "features": ["shell"]}
	},
	"wartortle": {
		"num": 8, "id": "wartortle", "name": "卡咪龟", "title": "龟宝可梦", "cost": 2,
		"types": ["Water"], "hp": 780, "atk": 58, "armor": 42, "mr": 42, "range": 2, "atk_speed": 0.67, "max_mana": 100,
		"desc": "长着蓬松毛茸茸的耳朵与尾巴，是长寿与祥瑞的象征，坚硬甲壳上带有战痕，擅长掀起旋涡水流冲散敌人。",
		"skill_name": "水之波动", "skill_desc": "发射震荡水球爆裂，造成280点伤害并眩晕目标1秒。",
		"skill_detail": "消耗100能量，双手凝聚高频震荡的水流光球砸向目标，造成280点范围伤害并使核心目标眩晕1秒。",
		"skill_power": 280,
		"skills": {
			1: {"name": "水之波动", "desc": "凝聚震荡水球轰击目标造成280点伤害并眩晕1秒。", "detail": "消耗100能量，发射震荡水球造成280点范围水系伤害并造成1秒眩晕。", "power": 280, "vfx": "water_gun", "sfx": "water", "scale": 0.38},
			2: {"name": "急流回旋", "desc": "缩入龟壳高速旋转切入，对周围造成480点伤害并提升自身40护甲。", "detail": "消耗100能量，缩入外壳以音速在敌阵中旋转切割，对周围所有敌人造成480点物理伤害，自身护甲临时提升40点持续4秒。", "power": 480, "vfx": "hydro_pump", "sfx": "water", "scale": 0.46},
			3: {"name": "深渊怒涛·惊涛骇浪", "desc": "召唤海啸冲击整排敌人造成850点伤害，全队获得450点护盾。", "detail": "消耗100能量，召唤滔天海啸巨浪横扫敌阵整排，造成850点水系伤害并强制击飞，同时为全体友方单位提供450点生命护盾！", "power": 850, "vfx": "hydro_cannon", "sfx": "water", "scale": 0.58}
		},
		"visual": {"primary": (90, 160, 220), "secondary": (220, 200, 130), "accent": (180, 200, 240), "eye": (120, 40, 50), "archetype": "quadruped", "features": ["shell", "ears"]}
	},
	"blastoise": {
		"num": 9, "id": "blastoise", "name": "水箭龟", "title": "甲壳宝可梦", "cost": 4,
		"types": ["Water"], "hp": 1200, "atk": 80, "armor": 60, "mr": 60, "range": 3, "atk_speed": 0.65, "max_mana": 100,
		"desc": "甲壳上伸出两门粗壮有力的钢铁水炮，能以穿透厚厚钢板的恐怖水压轰击敌方防线，如同战场重装堡垒！",
		"skill_name": "双联水炮轰炸", "skill_desc": "背部双炮齐鸣发射水柱，造成520点穿透伤害并击退2格。",
		"skill_detail": "消耗100能量，双门钢铁加农炮瞄准敌方重火力阵线开火，喷出巨型水龙柱造成520点范围法术伤害并击退2格。",
		"skill_power": 520,
		"skills": {
			1: {"name": "加农水炮", "desc": "双炮齐射强流水柱造成520点穿透伤害并击退2格。", "detail": "消耗100能量，双门钢炮喷射极压水龙，对扇形敌军造成520点伤害并强力击退。", "power": 520, "vfx": "hydro_pump", "sfx": "water", "scale": 0.46},
			2: {"name": "高压水炮连轰", "desc": "连续四次齐射重炮轰击全场，造成780点伤害并眩晕1.5秒。", "detail": "消耗100能量，稳固炮座进行四段高压重击，对整排敌人造成780点法术伤害并强力震荡眩晕1.5秒。", "power": 780, "vfx": "hydro_cannon", "sfx": "water", "scale": 0.56},
			3: {"name": "终极堡垒·深海灭世重炮", "desc": "展开全甲重装炮塔洗地，造成1350点毁灭真实伤害并赋予全队800护盾。", "detail": "消耗100能量，进入泰坦要塞形态，多管齐发向全场发射深海漩涡重水弹，造成1350点毁灭真实伤害，击飞全场敌军2秒，并为全队赋予800点神圣水壁护盾！", "power": 1350, "vfx": "hydro_tempest", "sfx": "water", "scale": 0.70}
		},
		"visual": {"primary": (75, 140, 205), "secondary": (210, 185, 120), "accent": (120, 60, 30), "eye": (180, 40, 40), "archetype": "quadruped", "features": ["shell", "cannons"]}
	},
	"caterpie": {
		"num": 10, "id": "caterpie", "name": "绿毛虫", "title": "虫宝宝宝可梦", "cost": 1,
		"types": ["Bug"], "hp": 500, "atk": 42, "armor": 20, "mr": 20, "range": 1, "atk_speed": 0.75, "max_mana": 80,
		"desc": "头上的红色触角能释放出强烈的臭气驱逐敌人，口中能喷射出坚韧黏稠的白色蚕丝缠绕束缚猎物。",
		"skill_name": "吐丝缠绕", "skill_desc": "向目标吐出坚韧丝线，造成140点伤害并降低其40%攻速。",
		"skill_detail": "消耗80能量，向目标吐出密集白丝蛛网，造成140点虫系法术伤害，并使目标攻击速度与移动速度降低40%持续2.5秒。",
		"skill_power": 140,
		"skills": {
			1: {"name": "吐丝缠绕", "desc": "吐出坚韧蚕丝缠绕目标，造成140点伤害并减速40%。", "detail": "消耗80能量，射出粘稠丝线造成140点法术伤害并降低目标40%攻击速度持续2.5秒。", "power": 140, "vfx": "leech_seed", "sfx": "skill", "scale": 0.32},
			2: {"name": "虫咬突刺", "desc": "敏捷跳跃啃咬敌人弱点，造成280点伤害并偷取其15点能量。", "detail": "消耗80能量，精准跳跃啃咬目标造成280点伤害，同时偷取目标15点当前能量转化给自身。", "power": 280, "vfx": "razor_leaf", "sfx": "skill", "scale": 0.38},
			3: {"name": "天蚕结茧·生命蜕变", "desc": "包裹金丝巨茧回复350生命，震碎茧壳造成580点范围爆发伤害。", "detail": "消耗80能量，瞬间用天蚕圣丝将自身包围获得免疫并回复350生命值，随后引爆茧壳对周围所有敌人造成580点真实伤害与1.5秒眩晕！", "power": 580, "vfx": "frenzy_plant", "sfx": "skill", "scale": 0.50}
		},
		"visual": {"primary": (90, 190, 60), "secondary": (230, 220, 120), "accent": (230, 50, 40), "eye": (20, 20, 20), "archetype": "bug", "features": ["horns"]}
	},
	"metapod": {
		"num": 11, "id": "metapod", "name": "铁甲蛹", "title": "蛹宝可梦", "cost": 2,
		"types": ["Bug"], "hp": 850, "atk": 35, "armor": 65, "mr": 50, "range": 1, "atk_speed": 0.55, "max_mana": 80,
		"desc": "外壳坚硬如钢铁，体内正在进行着剧烈的重构与蜕变。能通过极限硬化反弹一切物理冲击！",
		"skill_name": "铁壁·变硬", "skill_desc": "外壳硬化如钢，获得400点超强护盾并反弹30%受击伤害。",
		"skill_detail": "消耗80能量，让全身角质层硬化为坚不可摧的金刚石甲壳，获得400点强力护盾，持续时间内反弹30%受到的伤害给攻击者。",
		"skill_power": 200,
		"skills": {
			1: {"name": "铁壁变硬", "desc": "使外壳硬化如钢铁，获得400点护盾并反弹伤害。", "detail": "消耗80能量，坚硬甲壳强化，获得400点护盾并反弹30%物理伤害持续4秒。", "power": 200, "vfx": "body_slam", "sfx": "punch", "scale": 0.36},
			2: {"name": "金刚震碎击", "desc": "以钢铁之躯向前猛烈冲撞，造成360点伤害并击晕敌人1.2秒。", "detail": "消耗80能量，凭借沉重坚硬的金属甲壳向前重重撞击，对直线敌军造成360点伤害并眩晕1.2秒。", "power": 360, "vfx": "giga_impact", "sfx": "punch", "scale": 0.45},
			3: {"name": "化蝶前夜·绝对守护", "desc": "释放远古蜕变灵光，全队获得600点护盾并免疫控制2秒。", "detail": "消耗80能量，外壳绽放出即将破茧成蝶的神圣灵光，自身回复500生命，并为全体友军提供600点超强护盾与2秒控制免疫！", "power": 650, "vfx": "extreme_evoboost", "sfx": "skill", "scale": 0.55}
		},
		"visual": {"primary": (100, 180, 50), "secondary": (70, 140, 30), "accent": (240, 240, 200), "eye": (20, 20, 20), "archetype": "bug", "features": ["shell"]}
	},
	"butterfree": {
		"num": 12, "id": "butterfree", "name": "巴大蝶", "title": "蝴蝶宝可梦", "cost": 3,
		"types": ["Bug", "Flying"], "hp": 720, "atk": 65, "armor": 30, "mr": 45, "range": 3, "atk_speed": 0.72, "max_mana": 90,
		"desc": "翅膀上覆盖着防水的剧毒鳞粉，翩翩起舞时能散播出致眠粉、麻痹粉与混乱烈风，轻灵戏耍敌人。",
		"skill_name": "催眠粉·蝶舞", "skill_desc": "扇动双翅洒下催眠花粉，对多名敌人造成320点伤害并沉睡1.5秒。",
		"skill_detail": "消耗90能量，优雅振翅在目标区域散布发光的催眠磷粉，对范围内所有敌人造成320点法术伤害并施加催眠昏睡1.5秒。",
		"skill_power": 320,
		"skills": {
			1: {"name": "催眠粉·蝶舞", "desc": "洒下催眠花粉造成320点伤害并使敌人沉睡1.5秒。", "detail": "消耗90能量，洒出催眠粉对目标区域造成320点法术伤害并沉睡1.5秒。", "power": 320, "vfx": "psybeam", "sfx": "skill", "scale": 0.40},
			2: {"name": "三色毒粉风暴", "desc": "结合麻痹、剧毒与致眠三重粉尘，造成520点伤害与全属性削弱。", "detail": "消耗90能量，卷起狂暴的七彩鳞粉风暴，对全场半数敌人造成520点法术伤害，降低其35%攻击力与移速持续3秒。", "power": 520, "vfx": "blizzard", "sfx": "skill", "scale": 0.50},
			3: {"name": "幻象蝶影·极光狂风", "desc": "召唤万蝶狂舞撕裂天穹，造成950点巨额伤害并致盲全体3秒。", "detail": "消耗90能量，双翼爆发璀璨彩虹极光，无数虚幻蝶影伴随超音速狂风横扫全屏，造成950点法术毁灭伤害，并致盲全体敌人3秒（普攻100%落空）！", "power": 950, "vfx": "cosmic_singularity", "sfx": "skill", "scale": 0.62}
		},
		"visual": {"primary": (70, 60, 100), "secondary": (240, 240, 245), "accent": (210, 40, 50), "eye": (200, 30, 40), "archetype": "bug", "features": ["wings", "ears"]}
	},
	"weedle": {
		"num": 13, "id": "weedle", "name": "独角虫", "title": "毛毛虫宝可梦", "cost": 1,
		"types": ["Bug", "Poison"], "hp": 520, "atk": 46, "armor": 22, "mr": 22, "range": 1, "atk_speed": 0.72, "max_mana": 80,
		"desc": "头顶长着非常尖锐且含有剧毒的利角，遇到威胁时会使用毒针猛刺对手，将神经毒素注入敌人体内。",
		"skill_name": "毒针猛刺", "skill_desc": "尖刺毒角猛戳目标，造成160点物理伤害并施加猛毒。",
		"skill_detail": "消耗80能量，利用头顶锋锐毒角直刺敌人破绽，造成160点伤害并附加持续3秒的中毒效果（每秒20点真实伤害）。",
		"skill_power": 160,
		"skills": {
			1: {"name": "毒针猛刺", "desc": "尖刺毒角猛戳目标，造成160点伤害并中毒3秒。", "detail": "消耗80能量，直刺敌人造成160点伤害并附加持续3秒的中毒效果。", "power": 160, "vfx": "ice_shard", "sfx": "punch", "scale": 0.32},
			2: {"name": "毒液连射", "desc": "向周围喷射三枚高压毒针，各造成260点伤害。", "detail": "消耗80能量，向周围3名敌方单位同时射出淬毒骨刺，各造成260点伤害并削弱其15点护甲。", "power": 260, "vfx": "razor_leaf", "sfx": "skill", "scale": 0.40},
			3: {"name": "致命蜂刺·破甲爆刺", "desc": "凝聚全身毒素的一记死穴突刺，造成620点真实伤害。", "detail": "消耗80能量，引爆体内全部神经毒素刺穿目标防线，造成620点巨额真实伤害，若目标生命低于35%则伤害翻倍！", "power": 620, "vfx": "close_combat", "sfx": "punch", "scale": 0.52}
		},
		"visual": {"primary": (210, 160, 100), "secondary": (220, 60, 60), "accent": (240, 240, 240), "eye": (20, 20, 20), "archetype": "bug", "features": ["horns"]}
	},
	"kakuna": {
		"num": 14, "id": "kakuna", "name": "铁壳蛹", "title": "蛹宝可梦", "cost": 2,
		"types": ["Bug", "Poison"], "hp": 820, "atk": 38, "armor": 60, "mr": 50, "range": 1, "atk_speed": 0.58, "max_mana": 80,
		"desc": "身体几乎一动不动，但坚硬的金黄色外壳之下毒素正在高度压缩浓缩，受到撞击时会反弹毒液尖刺。",
		"skill_name": "金刚毒壳", "skill_desc": "外壳硬化并渗出剧毒，获得380点护盾且普攻攻击者中毒。",
		"skill_detail": "消耗80能量，外壳闪烁金芒硬化，获得380点坚实护盾，所有近战攻击它的敌人均会被附加剧毒效果。",
		"skill_power": 220,
		"skills": {
			1: {"name": "金刚毒壳", "desc": "外壳硬化获得380点护盾且让攻击者中毒。", "detail": "消耗80能量，获得380点护盾并使攻击它的敌人中毒3秒。", "power": 220, "vfx": "body_slam", "sfx": "punch", "scale": 0.36},
			2: {"name": "毒芒喷射", "desc": "甲壳开裂爆射千枚毒针，对周围造成420点范围伤害。", "detail": "消耗80能量，甲壳瞬间爆开四散飞射无数锋利毒针，对周围所有敌人造成420点伤害并减速30%。", "power": 420, "vfx": "discharge", "sfx": "skill", "scale": 0.46},
			3: {"name": "破茧爆发·毒王天降", "desc": "引爆剧毒甲壳冲击全屏，造成750点真实伤害并眩晕2秒。", "detail": "消耗80能量，提前引爆蓄积已久的毒系核能冲击波，对全屏敌军造成750点真实伤害，强行震晕全员2秒！", "power": 750, "vfx": "hex_nightmare", "sfx": "skill", "scale": 0.58}
		},
		"visual": {"primary": (230, 200, 60), "secondary": (180, 150, 40), "accent": (20, 20, 20), "eye": (20, 20, 20), "archetype": "bug", "features": ["shell"]}
	},
	"beedrill": {
		"num": 15, "id": "beedrill", "name": "大针蜂", "title": "毒蜂宝可梦", "cost": 3,
		"types": ["Bug", "Poison"], "hp": 760, "atk": 82, "armor": 35, "mr": 35, "range": 1, "atk_speed": 0.85, "max_mana": 75,
		"desc": "以极高速在敌阵穿梭突刺，双手与尾部的三枚剧毒长枪能以每秒十连击的频率撕碎目标的致命弱点！",
		"skill_name": "双针连刺", "skill_desc": "双臂长枪光速二连击，造成360点暴击伤害并剧毒感染。",
		"skill_detail": "消耗75能量，双手机械般光速刺出两记致命长枪，对目标造成360点必定暴击的物理伤害并施加高额剧毒。",
		"skill_power": 360,
		"skills": {
			1: {"name": "双针连刺", "desc": "双臂长枪光速二连击，造成360点伤害并剧毒感染。", "detail": "消耗75能量，刺出双重剧毒毒刺造成360点伤害并造成猛毒。", "power": 360, "vfx": "ice_shard", "sfx": "punch", "scale": 0.40},
			2: {"name": "飞弹针·毒蜂突袭", "desc": "高速螺旋突进连刺多名敌人，造成560点伤害并削弱30%防御。", "detail": "消耗75能量，化作残影在敌阵核心穿梭突刺，对路径上所有敌人造成560点伤害并撕碎30%护甲持续3秒。", "power": 560, "vfx": "razor_leaf", "sfx": "skill", "scale": 0.48},
			3: {"name": "死线追猎·极毒终焉枪", "desc": "三枪合一贯穿目标造成1100点毁灭真实伤害，若斩杀立即刷新能量。", "detail": "消耗75能量，双手与尾枪汇聚全部毒能化作死亡光束贯穿敌人，造成1100点终极真实伤害，若成功击杀目标则立即回满100%能量！", "power": 1100, "vfx": "close_combat", "sfx": "punch", "scale": 0.62}
		},
		"visual": {"primary": (240, 200, 40), "secondary": (30, 30, 30), "accent": (240, 240, 240), "eye": (220, 40, 40), "archetype": "bug", "features": ["wings", "spikes"]}
	},
	"pidgey": {
		"num": 16, "id": "pidgey", "name": "波波", "title": "小鸟宝可梦", "cost": 1,
		"types": ["Normal", "Flying"], "hp": 540, "atk": 48, "armor": 25, "mr": 25, "range": 3, "atk_speed": 0.72, "max_mana": 80,
		"desc": "性格温顺不喜欢争斗，但受到攻击时会猛烈拍打翅膀卷起沙尘与狂风迷住敌人的双眼并迅速拉开距离。",
		"skill_name": "起风·泼沙", "skill_desc": "扇动双翅掀起沙尘狂风，造成150点伤害并致盲目标2秒。",
		"skill_detail": "消耗80能量，急速振翅扬起漫天沙尘暴风，对目标造成150点伤害，并使其致盲2秒（命中率降低50%）。",
		"skill_power": 150,
		"skills": {
			1: {"name": "起风·泼沙", "desc": "掀起沙尘狂风造成150点伤害并使目标致盲2秒。", "detail": "消耗80能量，挥翅卷起风沙造成150点伤害并降低目标50%命中率持续2秒。", "power": 150, "vfx": "quick_attack", "sfx": "swift", "scale": 0.32},
			2: {"name": "烈暴风", "desc": "召唤锋利狂风气流呼啸穿透，对直线敌人造成320点伤害。", "detail": "消耗80能量，双翼凝聚气刃射出烈暴风，贯穿直线敌军造成320点物理伤害并微弱击退。", "power": 320, "vfx": "swift", "sfx": "swift", "scale": 0.42},
			3: {"name": "神鸟俯冲·长空裂斩", "desc": "冲上云霄俯冲重击敌方后排，造成620点伤害并击飞1.5秒。", "detail": "消耗80能量，凌空翱翔瞬间向敌方生命最低的后排单位极速俯冲，造成620点巨额伤害并强制击飞1.5秒！", "power": 620, "vfx": "flare_blitz", "sfx": "swift", "scale": 0.54}
		},
		"visual": {"primary": (180, 140, 90), "secondary": (240, 230, 200), "accent": (230, 60, 50), "eye": (20, 20, 20), "archetype": "bird", "features": ["wings", "beak"]}
	},
	"pidgeotto": {
		"num": 17, "id": "pidgeotto", "name": "比比鸟", "title": "鸟宝可梦", "cost": 2,
		"types": ["Normal", "Flying"], "hp": 740, "atk": 64, "armor": 32, "mr": 32, "range": 3, "atk_speed": 0.75, "max_mana": 80,
		"desc": "拥有极佳的视力与锐利的弯爪，在宽广领地上空巡视，俯冲时能以音速切开空气并精准猎杀敌人。",
		"skill_name": "翅膀攻击", "skill_desc": "硬化强韧羽翼横斩敌人，造成260点伤害并提升自身攻速30%。",
		"skill_detail": "消耗80能量，展开坚韧铁翼高速滑翔横斩目标，造成260点物理伤害并提升自身30%攻击速度持续3秒。",
		"skill_power": 260,
		"skills": {
			1: {"name": "翅膀攻击", "desc": "铁翼横斩造成260点伤害并提升自身30%攻速。", "detail": "消耗80能量，铁翼斩击造成260点伤害并获得30%攻速加成持续3秒。", "power": 260, "vfx": "swift", "sfx": "swift", "scale": 0.38},
			2: {"name": "顺风·空气之刃", "desc": "召唤顺风结界全队攻速+25%，射出空气利刃造成460点伤害。", "detail": "消耗80能量，振翅唤来灵动气流使全队攻速提升25%，同时射出真空风刃对直线造成460点伤害。", "power": 460, "vfx": "psycho_cut", "sfx": "swift", "scale": 0.48},
			3: {"name": "苍穹猎杀·暴风回旋斩", "desc": "极速螺旋俯冲切割战场，造成840点范围伤害并撕碎敌人防线。", "detail": "消耗80能量，在空中盘旋后以超音速陀螺形态向下螺旋俯冲突刺，对范围内敌军造成840点伤害并眩晕1.5秒！", "power": 840, "vfx": "flare_blitz", "sfx": "swift", "scale": 0.58}
		},
		"visual": {"primary": (170, 120, 80), "secondary": (240, 225, 180), "accent": (240, 50, 40), "eye": (20, 20, 20), "archetype": "bird", "features": ["wings", "beak", "crest"]}
	},
	"pidgeot": {
		"num": 18, "id": "pidgeot", "name": "大比鸟", "title": "鸟宝可梦", "cost": 3,
		"types": ["Normal", "Flying"], "hp": 920, "atk": 82, "armor": 40, "mr": 40, "range": 3, "atk_speed": 0.80, "max_mana": 80,
		"desc": "胸肌极其发达，能以2马赫的速度在天空翱翔，巨大双翼只需轻轻拍动就能制造连拔起大树的超级飓风！",
		"skill_name": "暴风龙卷", "skill_desc": "召唤撕裂大地的超级风暴龙卷，对整排敌人造成420点伤害并击飞。",
		"skill_detail": "消耗80能量，拍打金色羽翼制造出毁天灭地的飓风漩涡，将整排敌人卷入空中，造成420点范围伤害并滞空1.5秒。",
		"skill_power": 420,
		"skills": {
			1: {"name": "暴风龙卷", "desc": "召唤飓风漩涡造成420点伤害并将敌人击飞1.5秒。", "detail": "消耗80能量，掀起强风龙卷造成420点范围伤害并击飞目标1.5秒。", "power": 420, "vfx": "swift", "sfx": "swift", "scale": 0.44},
			2: {"name": "勇鸟猛攻", "desc": "收缩双翼化作流星烈鸟俯冲撞击，造成680点巨额伤害。", "detail": "消耗80能量，包裹灼目光辉以2马赫速度俯冲轰击敌方最密集区域，造成680点伤害并造成大面积震退。", "power": 680, "vfx": "flare_blitz", "sfx": "swift", "scale": 0.54},
			3: {"name": "天神下凡·终极飓风天劫", "desc": "撕裂云层召唤天穹灭世风暴，造成1150点毁灭伤害并全场易伤35%。", "detail": "消耗80能量，引动天际气流引爆全屏灭世大飓风，对全场所有敌人造成1150点真实伤害，击飞全员2秒，并使目标受到伤害永久提升35%！", "power": 1150, "vfx": "thunder_tempest", "sfx": "swift", "scale": 0.68}
		},
		"visual": {"primary": (185, 130, 75), "secondary": (245, 235, 190), "accent": (245, 70, 50), "eye": (20, 20, 20), "archetype": "bird", "features": ["wings", "beak", "crest"]}
	},
	"rattata": {
		"num": 19, "id": "rattata", "name": "小拉达", "title": "鼠宝可梦", "cost": 1,
		"types": ["Normal"], "hp": 500, "atk": 54, "armor": 20, "mr": 20, "range": 1, "atk_speed": 0.78, "max_mana": 75,
		"desc": "生命力极强的小型啮齿动物，长有一对终生生长的大门牙，无论什么坚硬的东西都能咬碎嚼烂。",
		"skill_name": "愤怒门牙", "skill_desc": "大门牙凶猛啃咬目标，造成目标当前生命25%的真实伤害。",
		"skill_detail": "消耗75能量，跃起露出锋锐大板牙撕咬敌人，造成目标当前生命值25%的真实伤害（最少160点）。",
		"skill_power": 160,
		"skills": {
			1: {"name": "愤怒门牙", "desc": "门牙撕咬造成当前生命25%真实伤害（最少160点）。", "detail": "消耗75能量，门牙强力啃咬削减目标当前25%生命值并造成基础160伤害。", "power": 160, "vfx": "quick_attack", "sfx": "punch", "scale": 0.32},
			2: {"name": "必杀门牙·碎骨击", "desc": "跃起重咬造成340点必定暴击伤害并眩晕1秒。", "detail": "消耗75能量，跳跃下压啃咬敌人头部弱点，造成340点暴击伤害并使目标眩晕1秒。", "power": 340, "vfx": "fire_fang", "sfx": "punch", "scale": 0.40},
			3: {"name": "狂暴鼠潮·万齿撕扯", "desc": "残影分身连续撕咬全场敌人，造成650点范围真实伤害。", "detail": "消耗75能量，化作无数残影在战场上来回穿梭啃咬，对全场所有敌人造成650点真实伤害并施加深度流血！", "power": 650, "vfx": "close_combat", "sfx": "punch", "scale": 0.52}
		},
		"visual": {"primary": (150, 110, 180), "secondary": (240, 235, 200), "accent": (240, 240, 240), "eye": (220, 50, 50), "archetype": "quadruped", "features": ["ears", "tail"]}
	},
	"raticate": {
		"num": 20, "id": "raticate", "name": "拉达", "title": "鼠宝可梦", "cost": 2,
		"types": ["Normal"], "hp": 760, "atk": 72, "armor": 32, "mr": 32, "range": 1, "atk_speed": 0.80, "max_mana": 75,
		"desc": "胡须用来保持平衡，坚硬的大门牙能咬穿坚实的水泥墙壁，战斗时凭借凶恶的面容恐吓对手并猛烈啃咬！",
		"skill_name": "必杀门牙", "skill_desc": "全力咬碎目标甲胄，造成320点伤害并永久削弱其40%护甲。",
		"skill_detail": "消耗75能量，倾注全力撕咬目标咽喉，造成320点物理伤害，并撕碎目标40%物理护甲持续整场战斗。",
		"skill_power": 320,
		"skills": {
			1: {"name": "必杀门牙", "desc": "咬碎目标造成320点伤害并削弱40%护甲。", "detail": "消耗75能量，咬穿敌人防御造成320点伤害并削弱40%护甲。", "power": 320, "vfx": "quick_attack", "sfx": "punch", "scale": 0.38},
			2: {"name": "暴怒撕裂斩", "desc": "双爪带獠牙狂暴连击，造成520点伤害并使自身攻速+40%。", "detail": "消耗75能量，疯狂乱抓撕咬目标造成520点物理伤害，并进入暴怒状态攻速提升40%持续4秒。", "power": 520, "vfx": "close_combat", "sfx": "punch", "scale": 0.48},
			3: {"name": "天崩牙碎·终焉死噬", "desc": "凶残噬咬造成目标当前生命50%的巨额真实斩杀。", "detail": "消耗75能量，跃上敌方首脑疯狂噬咬，直接造成相当于其当前生命值50%的恐怖真实伤害（最低900点）并瘫痪2秒！", "power": 900, "vfx": "giga_impact", "sfx": "punch", "scale": 0.60}
		},
		"visual": {"primary": (185, 145, 95), "secondary": (245, 235, 210), "accent": (240, 240, 240), "eye": (30, 30, 30), "archetype": "quadruped", "features": ["ears", "whiskers"]}
	},
	"spearow": {
		"num": 21, "id": "spearow", "name": "烈雀", "title": "小鸟宝可梦", "cost": 1,
		"types": ["Normal", "Flying"], "hp": 520, "atk": 52, "armor": 22, "mr": 22, "range": 2, "atk_speed": 0.75, "max_mana": 75,
		"desc": "脾气极其暴躁，领地意识极强，发出高亢尖叫呼唤同伴，短小双翼以极高频率扇动，俯冲啄击敌人。",
		"skill_name": "啄击·锐喙", "skill_desc": "尖锐坚硬鸟喙凶狠啄击目标，造成180点单体穿刺伤害。",
		"skill_detail": "消耗75能量，高速俯冲用坚硬锐喙连续啄刺目标弱点，造成180点穿刺伤害并附带30%暴击率。",
		"skill_power": 180,
		"skills": {
			1: {"name": "啄击·锐喙", "desc": "尖锐鸟喙俯冲啄击，造成180点穿透伤害。", "detail": "消耗75能量，尖喙直刺目标造成180点伤害并附带暴击。", "power": 180, "vfx": "quick_attack", "sfx": "swift", "scale": 0.32},
			2: {"name": "乱击狂啄", "desc": "光速四连啄击目标，造成360点伤害并施加流血。", "detail": "消耗75能量，展开双翼狂风骤雨般连续啄击目标4次，共造成360点物理伤害并使目标持续流血。", "power": 360, "vfx": "swift", "sfx": "swift", "scale": 0.42},
			3: {"name": "狂烈鹰袭·万刃破空", "desc": "高速螺旋风暴贯穿整排敌人，造成640点物理穿透伤害。", "detail": "消耗75能量，全身化作破空利箭穿透敌阵整排，造成640点伤害并使其护甲降低30点持续4秒！", "power": 640, "vfx": "flare_blitz", "sfx": "swift", "scale": 0.54}
		},
		"visual": {"primary": (160, 95, 60), "secondary": (240, 200, 160), "accent": (210, 45, 40), "eye": (20, 20, 20), "archetype": "bird", "features": ["wings", "beak"]}
	},
	"fearow": {
		"num": 22, "id": "fearow", "name": "大嘴雀", "title": "鸟宝可梦", "cost": 2,
		"types": ["Normal", "Flying"], "hp": 760, "atk": 74, "armor": 32, "mr": 32, "range": 2, "atk_speed": 0.78, "max_mana": 80,
		"desc": "长有长而尖锐的巨喙与宽大有力的翅膀，耐力惊人能整天不着地飞翔，锁定猎物后以音速钻刺轰杀目标！",
		"skill_name": "直冲钻", "skill_desc": "身体高速旋转如巨型钢钻向前贯穿，造成320点暴击伤害。",
		"skill_detail": "消耗80能量，身体如高速电钻般剧烈自转向前冲刺，贯穿目标造成320点必定暴击的强力物理伤害。",
		"skill_power": 320,
		"skills": {
			1: {"name": "直冲钻", "desc": "高速自转如钢钻冲刺，造成320点必定暴击伤害。", "detail": "消耗80能量，化身钢钻贯穿目标造成320点暴击物理伤害。", "power": 320, "vfx": "swift", "sfx": "swift", "scale": 0.38},
			2: {"name": "长空狂啸·钻击风暴", "desc": "钻刺敌方核心区域，造成520点伤害并使周围敌军眩晕1秒。", "detail": "消耗80能量，从高空呼啸旋转砸入敌阵核心，对周围所有敌人造成520点物理伤害并眩晕1秒。", "power": 520, "vfx": "flare_blitz", "sfx": "swift", "scale": 0.48},
			3: {"name": "天罚钻煞·绝命长虹贯日", "desc": "撕裂天幕的极速天击贯穿整条线，造成880点穿透真实伤害。", "detail": "消耗80能量，飞跃天幕最高峰瞬间垂直下刺贯穿整条战场直线，造成880点纯粹真实伤害并撕碎敌人全部护甲！", "power": 880, "vfx": "dragon_apocalypse", "sfx": "swift", "scale": 0.60}
		},
		"visual": {"primary": (150, 100, 70), "secondary": (230, 210, 180), "accent": (220, 50, 40), "eye": (20, 20, 20), "archetype": "bird", "features": ["wings", "beak", "crest"]}
	},
	"ekans": {
		"num": 23, "id": "ekans", "name": "阿柏蛇", "title": "蛇宝可梦", "cost": 1,
		"types": ["Poison"], "hp": 560, "atk": 50, "armor": 28, "mr": 28, "range": 1, "atk_speed": 0.70, "max_mana": 80,
		"desc": "无声无息地在草丛中潜行，下颚能完全脱臼吞下庞大的猎物，蛇信微颤能探测空气中的体温与气味。",
		"skill_name": "毒尾紧束", "skill_desc": "蛇身缠绕紧勒目标，造成160点伤害并禁锢1.5秒。",
		"skill_detail": "消耗80能量，蛇躯如铁链般迅猛缠上目标疯狂收紧，造成160点物理伤害并使其禁锢无法动弹1.5秒。",
		"skill_power": 160,
		"skills": {
			1: {"name": "毒尾紧束", "desc": "蛇身紧勒目标造成160点伤害并禁锢1.5秒。", "detail": "消耗80能量，缠绕勒紧敌人造成160点伤害并禁锢1.5秒。", "power": 160, "vfx": "lick", "sfx": "punch", "scale": 0.32},
			2: {"name": "毒液陷阱", "desc": "喷吐酸性毒雾腐蚀地面，造成320点伤害并降低25点护甲。", "detail": "消耗80能量，向目标脚下喷洒强酸毒液，对范围内所有敌人造成320点毒系伤害并削弱25点双抗持续3秒。", "power": 320, "vfx": "shadow_ball", "sfx": "skill", "scale": 0.42},
			3: {"name": "剧毒蛇噬·神经瘫痪", "desc": "毒牙撕咬注入浓缩毒素，造成620点伤害并麻痹眩晕2秒。", "detail": "消耗80能量，剧毒獠牙凶狠咬住目标注入毁灭毒液，造成620点真实伤害并使目标瘫痪眩晕2秒！", "power": 620, "vfx": "hex_nightmare", "sfx": "skill", "scale": 0.54}
		},
		"visual": {"primary": (150, 80, 180), "secondary": (240, 220, 100), "accent": (220, 40, 40), "eye": (240, 200, 30), "archetype": "serpent", "features": ["tail"]}
	},
	"arbok": {
		"num": 24, "id": "arbok", "name": "阿柏怪", "title": "眼镜蛇宝可梦", "cost": 3,
		"types": ["Poison"], "hp": 880, "atk": 78, "armor": 42, "mr": 42, "range": 1, "atk_speed": 0.75, "max_mana": 80,
		"desc": "胸腹部的恐怖花纹能恐吓并石化猎物，拥有足以压扁钢铁油桶的惊人绞杀力量，毒牙含致命剧毒。",
		"skill_name": "大蛇绞杀·蛇瞪眼", "skill_desc": "胸口花纹恐吓敌人眩晕1.5秒，蛇身绞杀造成380点伤害。",
		"skill_detail": "消耗80能量，展开恐怖的眼镜蛇胸腹花纹瞬间石化直视它的敌人眩晕1.5秒，同时蛇身全力绞杀造成380点物理伤害。",
		"skill_power": 380,
		"skills": {
			1: {"name": "大蛇绞杀·蛇瞪眼", "desc": "恐吓敌人眩晕1.5秒并绞杀造成380点伤害。", "detail": "消耗80能量，威吓使目标眩晕1.5秒并强力绞杀造成380点伤害。", "power": 380, "vfx": "lick", "sfx": "punch", "scale": 0.42},
			2: {"name": "溶解液·毒龙狂咬", "desc": "喷射腐蚀毒液后猛咬，造成580点伤害并削弱40%护甲。", "detail": "消耗80能量，喷吐强酸彻底融化目标护甲（-40%），随后撕咬造成580点高额伤害。", "power": 580, "vfx": "shadow_ball", "sfx": "skill", "scale": 0.50},
			3: {"name": "深渊冥蛇·万毒噬魂阵", "desc": "化身紫黑冥蛇掀起剧毒风暴，造成1050点范围真实伤害与全体恐惧。", "detail": "消耗80能量，唤醒深渊古蛇血脉释放漫天黑紫毒雾，对周围所有敌人造成1050点真实伤害，并施加恐惧效果（敌军乱跑无法施法2.5秒）！", "power": 1050, "vfx": "hex_nightmare", "sfx": "skill", "scale": 0.65}
		},
		"visual": {"primary": (140, 65, 175), "secondary": (245, 210, 60), "accent": (220, 30, 30), "eye": (240, 220, 40), "archetype": "serpent", "features": ["tail", "hood"]}
	},
	"pikachu": {
		"num": 25, "id": "pikachu", "name": "皮卡丘", "title": "鼠宝可梦", "cost": 2,
		"types": ["Electric"], "hp": 580, "atk": 55, "armor": 22, "mr": 22, "range": 3, "atk_speed": 0.78, "max_mana": 100,
		"desc": "双颊拥有红色的电力袋，危险时会从脸颊两侧释放强劲电流，尾巴高高竖起能感知周围的电离环境。",
		"skill_name": "十万伏特", "skill_desc": "召唤雷电直劈敌方单位，造成280点伤害并使其麻痹1.0秒。",
		"skill_detail": "消耗100能量，双颊蓄力沟通天顶聚雷，轰击目标及其附近敌人，造成280点电系伤害并使受击单位麻痹眩晕1.0秒。",
		"skill_power": 280,
		"skills": {
			1: {"name": "电击", "desc": "向目标释放急速电弧造成170点伤害并麻痹0.6秒。", "detail": "消耗100能量，释放急速电弧打击单体目标造成170点伤害并附带短暂麻痹。", "power": 170, "vfx": "thundershock", "sfx": "thunder", "scale": 0.32},
			2: {"name": "十万伏特", "desc": "引天雷直劈多名敌人造成360点伤害并眩晕1.0秒。", "detail": "消耗100能量，召唤狂雷轰击2名敌人各造成360点法术伤害并麻痹1.0秒。", "power": 360, "vfx": "thunderbolt", "sfx": "thunder", "scale": 0.45},
			3: {"name": "千万伏特·雷霆狂澜", "desc": "四雷齐发轰击全场造成750点巨额伤害并弹射麻痹1.5秒。", "detail": "消耗100能量，释放神圣Z招式千万伏特，彩色电弧在敌阵中疯狂连锁弹射，对最多4名目标造成750点真实伤害并强力眩晕1.5秒！", "power": 750, "vfx": "volt_catastrophe", "sfx": "thunder", "scale": 0.58}
		},
		"visual": {"primary": (250, 215, 45), "secondary": (220, 50, 40), "accent": (80, 50, 30), "eye": (30, 30, 30), "archetype": "biped", "features": ["ears", "tail"]}
	},
	"raichu": {
		"num": 26, "id": "raichu", "name": "雷丘", "title": "鼠宝可梦", "cost": 3,
		"types": ["Electric"], "hp": 820, "atk": 75, "armor": 35, "mr": 35, "range": 3, "atk_speed": 0.82, "max_mana": 90,
		"desc": "长长的尾巴像避雷针一样保护自己，体内储存着超过十万伏特的超高电压，战斗时周身空气都散发着蓝白色电芒！",
		"skill_name": "打雷·伏特狂冲", "skill_desc": "引动九天狂雷轰击全场，造成450点范围雷电伤害并麻痹1.2秒。",
		"skill_detail": "消耗90能量，将雷电长尾插入地面做接地，引下三道高能雷柱轰碎敌方阵列，造成450点雷系伤害并麻痹1.2秒。",
		"skill_power": 450,
		"skills": {
			1: {"name": "电球连弹", "desc": "发射两枚高压等离子雷球，各造成280点伤害。", "detail": "消耗90能量，从尾部凝聚两枚高压闪电球轰炸敌人，各造成280点雷系伤害。", "power": 280, "vfx": "thundershock", "sfx": "thunder", "scale": 0.38},
			2: {"name": "打雷·伏特狂冲", "desc": "九天狂雷劈下造成450点伤害并大范围麻痹1.2秒。", "detail": "消耗90能量，引动天雷轰击3名敌人造成450点伤害并麻痹1.2秒。", "power": 450, "vfx": "thunderbolt", "sfx": "thunder", "scale": 0.48},
			3: {"name": "神雷极意·灭世超电磁炮", "desc": "双颊蓄满毁灭电能发射超电磁死光，造成1050点毁灭伤害。", "detail": "消耗90能量，尾部与双颊全力过载发射一道刺穿战场的超电磁光束，造成1050点真实伤害并使全场敌军瘫痪2秒！", "power": 1050, "vfx": "thunder_tempest", "sfx": "thunder", "scale": 0.65}
		},
		"visual": {"primary": (240, 160, 40), "secondary": (250, 240, 210), "accent": (250, 210, 40), "eye": (40, 40, 40), "archetype": "biped", "features": ["ears", "tail"]}
	},
	"sandshrew": {
		"num": 27, "id": "sandshrew", "name": "穿山鼠", "title": "鼠宝可梦", "cost": 1,
		"types": ["Ground"], "hp": 620, "atk": 50, "armor": 40, "mr": 25, "range": 1, "atk_speed": 0.68, "max_mana": 80,
		"desc": "生活在干燥干燥的沙漠深处，遇到攻击时瞬间卷成坚硬带刺的肉球，锋利双爪擅长在坚固地底挖掘穿行。",
		"skill_name": "滚斩冲击", "skill_desc": "缩成刺球向前翻滚冲撞，造成180点伤害并获得180点护甲护盾。",
		"skill_detail": "消耗80能量，身体紧缩成硬实刺球高速翻滚撞击目标，造成180点地面物理伤害，并获得180点坚实岩盾。",
		"skill_power": 180,
		"skills": {
			1: {"name": "滚斩冲击", "desc": "缩成刺球撞击造成180点伤害并获得180点护盾。", "detail": "消耗80能量，高速翻滚撞击造成180点伤害并获得180点护甲护盾。", "power": 180, "vfx": "body_slam", "sfx": "punch", "scale": 0.32},
			2: {"name": "挖洞突袭", "desc": "钻入地底规避伤害后破土而出，造成350点伤害并击飞。", "detail": "消耗80能量，瞬间遁入地底0.8秒处于无敌状态，随后从敌人脚下破土猛击造成350点伤害并击飞。", "power": 350, "vfx": "giga_impact", "sfx": "punch", "scale": 0.42},
			3: {"name": "黄沙天葬·大地风暴", "desc": "掀起遮天沙暴席卷战场，造成650点范围伤害并全体致盲2.5秒。", "detail": "消耗80能量，疯狂撕扯地面制造出遮天蔽日的死亡沙暴，对全屏敌军造成650点真实伤害并致盲2.5秒！", "power": 650, "vfx": "thunder_tempest", "sfx": "punch", "scale": 0.54}
		},
		"visual": {"primary": (235, 205, 110), "secondary": (245, 235, 200), "accent": (80, 80, 80), "eye": (20, 20, 20), "archetype": "biped", "features": ["shell", "ears"]}
	},
	"sandslash": {
		"num": 28, "id": "sandslash", "name": "穿山王", "title": "鼠宝可梦", "cost": 3,
		"types": ["Ground"], "hp": 880, "atk": 80, "armor": 55, "mr": 35, "range": 1, "atk_speed": 0.75, "max_mana": 80,
		"desc": "背部长满坚硬锋利的尖刺，能以极高速度蜷缩成旋转刺轮碾碎一切障碍物，锋利钢铁巨爪一击切裂岩壁！",
		"skill_name": "旋风连环刺", "skill_desc": "化身带刺风暴高速旋转切割周围，造成380点物理伤害。",
		"skill_detail": "消耗80能量，身体抱团化作死亡荆棘刺轮在周围旋转横扫，对周围1格内所有敌人造成380点物理伤害。",
		"skill_power": 380,
		"skills": {
			1: {"name": "旋风连环刺", "desc": "旋转钢刺重击周围造成380点伤害。", "detail": "消耗80能量，化作旋转刺轮造成380点范围物理伤害。", "power": 380, "vfx": "body_slam", "sfx": "punch", "scale": 0.40},
			2: {"name": "撕裂爪·地裂碎击", "desc": "巨爪撕裂大地引发地刺喷发，造成580点伤害并削弱35%护甲。", "detail": "消耗80能量，双爪贯入地面激起尖锐石刺波，对直线敌人造成580点物理伤害并降低其35%护甲。", "power": 580, "vfx": "giga_impact", "sfx": "punch", "scale": 0.50},
			3: {"name": "地底霸王·太古天崩地裂", "desc": "引爆大地核心撕裂巨大深渊，造成1050点毁灭真实伤害并击飞2秒。", "detail": "消耗80能量，猛踏大地引发毁灭级十级大地震，地脉撕裂将全场敌人震飞2秒，并造成1050点毁灭真实伤害！", "power": 1050, "vfx": "cosmic_singularity", "sfx": "punch", "scale": 0.65}
		},
		"visual": {"primary": (230, 195, 90), "secondary": (180, 130, 50), "accent": (240, 235, 210), "eye": (20, 20, 20), "archetype": "biped", "features": ["spikes", "ears"]}
	},
	"nidoran_f": {
		"num": 29, "id": "nidoran_f", "name": "尼多兰", "title": "毒针宝可梦", "cost": 1,
		"types": ["Poison"], "hp": 580, "atk": 46, "armor": 30, "mr": 30, "range": 1, "atk_speed": 0.70, "max_mana": 80,
		"desc": "温顺害羞但绝不可轻视，背部隐藏着致命的剧毒尖刺，受到惊吓时会用头上的毒角反击敌人。",
		"skill_name": "毒针连发", "skill_desc": "背部尖刺射出毒雨，造成150点伤害并使敌人中毒3秒。",
		"skill_detail": "消耗80能量，抖动后背尖刺射出一蓬毒针，对目标造成150点伤害并附加持续3秒的中毒。",
		"skill_power": 150,
		"skills": {
			1: {"name": "毒针连发", "desc": "射出毒针造成150点伤害并中毒3秒。", "detail": "消耗80能量，射出毒针造成150点伤害并使目标中毒3秒。", "power": 150, "vfx": "ice_shard", "sfx": "punch", "scale": 0.32},
			2: {"name": "剧毒獠牙咬杀", "desc": "冲刺凶猛啃咬目标，造成320点伤害并降低20%攻击力。", "detail": "消耗80能量，凶猛冲咬目标造成320点伤害并使其攻击力降低20%持续3秒。", "power": 320, "vfx": "fire_fang", "sfx": "punch", "scale": 0.40},
			3: {"name": "王族血脉·毒荆爆发", "desc": "引爆王室毒能震荡全场，造成600点伤害并使全场敌人中毒。", "detail": "消耗80能量，唤醒体内潜藏的女王血脉，全身毒刺炸裂对全场所有敌人造成600点伤害并附加猛毒！", "power": 600, "vfx": "hex_nightmare", "sfx": "skill", "scale": 0.52}
		},
		"visual": {"primary": (130, 190, 220), "secondary": (240, 240, 240), "accent": (210, 40, 40), "eye": (210, 40, 40), "archetype": "quadruped", "features": ["ears", "horns"]}
	},
	"nidorina": {
		"num": 30, "id": "nidorina", "name": "尼多娜", "title": "毒针宝可梦", "cost": 2,
		"types": ["Poison"], "hp": 780, "atk": 62, "armor": 38, "mr": 38, "range": 1, "atk_speed": 0.72, "max_mana": 80,
		"desc": "性情温和，但在保护幼崽或遇到强敌时背刺会瞬间竖起，毒角硬化能轻易穿透钢板并注入高浓度毒素。",
		"skill_name": "猛毒角击", "skill_desc": "毒角全速前冲穿刺，造成280点伤害并眩晕1秒。",
		"skill_detail": "消耗80能量，头部毒角闪耀紫芒全速撞刺目标，造成280点物理伤害并使受击者眩晕1秒。",
		"skill_power": 280,
		"skills": {
			1: {"name": "猛毒角击", "desc": "毒角冲刺造成280点伤害并眩晕1秒。", "detail": "消耗80能量，冲刺突刺造成280点伤害并眩晕1秒。", "power": 280, "vfx": "ice_shard", "sfx": "punch", "scale": 0.38},
			2: {"name": "酸液狂潮", "desc": "喷射大范围腐蚀酸雾，造成480点伤害并永久降低目标30点魔抗。", "detail": "消耗80能量，向前喷吐高浓强酸水雾，对扇形敌人造成480点伤害并削弱30点魔法抗性。", "power": 480, "vfx": "shadow_ball", "sfx": "skill", "scale": 0.48},
			3: {"name": "女王守护·千针暴雨", "desc": "背部毒刺如倾盆暴雨覆盖全屏，造成820点真实伤害。", "detail": "消耗80能量，释放狂暴毒刺暴雨席卷全场，对所有敌人造成820点真实伤害并施加每秒40点持续灼热毒伤！", "power": 820, "vfx": "hex_nightmare", "sfx": "skill", "scale": 0.60}
		},
		"visual": {"primary": (120, 180, 210), "secondary": (240, 240, 240), "accent": (210, 40, 40), "eye": (210, 40, 40), "archetype": "quadruped", "features": ["ears", "horns"]}
	}
}
