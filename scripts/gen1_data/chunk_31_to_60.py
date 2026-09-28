# Gen 1 Pokemon: 031 - 060
POKEMON_CHUNK_2 = {
	"nidoqueen": {
		"num": 31, "id": "nidoqueen", "name": "尼多后", "title": "钻锥宝可梦", "cost": 4,
		"types": ["Poison", "Ground"], "hp": 1150, "atk": 82, "armor": 55, "mr": 55, "range": 1, "atk_speed": 0.70, "max_mana": 100,
		"desc": "身体覆盖着坚如磐石的针状鳞片，擅长用沉重的身躯撞倒敌人，并释放猛毒地壳裂变横扫战场！",
		"skill_name": "大地毒爆振击", "skill_desc": "重踏地面引发毒浆火山爆发，造成520点伤害并眩晕1.5秒。",
		"skill_detail": "消耗100能量，双拳重锤地面激起剧毒熔岩浪涌，对范围内所有敌人造成520点毒/地双系伤害并眩晕1.5秒。",
		"skill_power": 520,
		"skills": {
			1: {"name": "大地毒爆振击", "desc": "重踏地面造成520点伤害并眩晕1.5秒。", "detail": "消耗100能量，震击地面造成520点范围伤害并眩晕1.5秒。", "power": 520, "vfx": "body_slam", "sfx": "punch", "scale": 0.46},
			2: {"name": "女皇重压·剧毒深渊", "desc": "泰山压顶造成780点伤害并赋予全队400点抗性护盾。", "detail": "消耗100能量，高高跃起重重砸向敌阵，造成780点范围真实伤害，同时为全队赋予400点双抗护盾。", "power": 780, "vfx": "giga_impact", "sfx": "punch", "scale": 0.56},
			3: {"name": "女王天威·万毒地裂劫", "desc": "撕裂大地喷射毒炎柱，造成1250点毁灭伤害并全体禁锢2.5秒。", "detail": "消耗100能量，彻底引爆大地核心毒核，全场喷发数十道剧毒岩浆火柱，造成1250点毁灭真实伤害，强力禁锢全体敌人2.5秒！", "power": 1250, "vfx": "cosmic_singularity", "sfx": "punch", "scale": 0.70}
		},
		"visual": {"primary": (80, 130, 180), "secondary": (220, 210, 180), "accent": (210, 40, 40), "eye": (210, 40, 40), "archetype": "biped", "features": ["horns", "tail"]}
	},
	"nidoran_m": {
		"num": 32, "id": "nidoran_m", "name": "尼多朗", "title": "毒针宝可梦", "cost": 1,
		"types": ["Poison"], "hp": 560, "atk": 52, "armor": 28, "mr": 28, "range": 1, "atk_speed": 0.72, "max_mana": 80,
		"desc": "头顶长着比身体还大的毒角，时刻警惕地竖起双耳倾听四周动静，一旦感知到危险便会全速突刺！",
		"skill_name": "猛撞毒刺", "skill_desc": "以锐利毒角向前猛烈冲撞，造成170点伤害并击退1格。",
		"skill_detail": "消耗80能量，利用巨大毒角全速冲撞目标，造成170点物理伤害并击退1格，使目标中毒2秒。",
		"skill_power": 170,
		"skills": {
			1: {"name": "猛撞毒刺", "desc": "向前猛冲撞击造成170点伤害并中毒。", "detail": "消耗80能量，猛冲撞击造成170点伤害并使敌人中毒。", "power": 170, "vfx": "ice_shard", "sfx": "punch", "scale": 0.32},
			2: {"name": "连环角击", "desc": "毒角连续三次挑刺目标，造成350点伤害。", "detail": "消耗80能量，锋锐毒角挑刺目标3次，造成350点伤害并削弱20点护甲。", "power": 350, "vfx": "quick_attack", "sfx": "punch", "scale": 0.40},
			3: {"name": "霸王枪刺·死线突贯", "desc": "冲刺贯穿直线造成620点暴击伤害并眩晕1.5秒。", "detail": "消耗80能量，狂化蓄力贯穿直线所有敌人，造成620点必定暴击的物理伤害并眩晕1.5秒！", "power": 620, "vfx": "close_combat", "sfx": "punch", "scale": 0.52}
		},
		"visual": {"primary": (180, 100, 190), "secondary": (240, 240, 240), "accent": (240, 50, 50), "eye": (240, 50, 50), "archetype": "quadruped", "features": ["horns", "ears"]}
	},
	"nidorino": {
		"num": 33, "id": "nidorino", "name": "尼多力诺", "title": "毒针宝可梦", "cost": 2,
		"types": ["Poison"], "hp": 760, "atk": 68, "armor": 35, "mr": 35, "range": 1, "atk_speed": 0.75, "max_mana": 80,
		"desc": "脾气极其凶暴，头顶钻石般坚硬的毒角含有烈性神经毒素，受到撞击时毒角会渗出强酸毒汁。",
		"skill_name": "剧毒角撞", "skill_desc": "硬化毒角蓄力重撞，造成300点伤害并麻痹眩晕1秒。",
		"skill_detail": "消耗80能量，硬化头部粗大毒角狠狠冲撞目标，造成300点伤害并造成1秒眩晕与猛毒。",
		"skill_power": 300,
		"skills": {
			1: {"name": "剧毒角撞", "desc": "蓄力重撞造成300点伤害并眩晕1秒。", "detail": "消耗80能量，重撞目标造成300点伤害并眩晕1秒。", "power": 300, "vfx": "ice_shard", "sfx": "punch", "scale": 0.38},
			2: {"name": "毒刺风暴冲击", "desc": "狂暴冲锋撞穿敌阵，造成500点范围伤害并削弱30%护甲。", "detail": "消耗80能量，背刺暴涨冲锋撞入敌阵，对沿途敌人造成500点伤害并削弱30%护甲。", "power": 500, "vfx": "giga_impact", "sfx": "punch", "scale": 0.48},
			3: {"name": "野兽狂怒·血毒贯心杀", "desc": "进入狂暴状态造成880点伤害并偷取40%生命吸血。", "detail": "消耗80能量，狂暴撕咬穿透目标造成880点巨额物理真实伤害，并将造成的伤害40%转化为自身生命回复！", "power": 880, "vfx": "close_combat", "sfx": "punch", "scale": 0.60}
		},
		"visual": {"primary": (170, 85, 180), "secondary": (240, 240, 240), "accent": (240, 40, 40), "eye": (240, 40, 40), "archetype": "quadruped", "features": ["horns", "ears"]}
	},
	"nidoking": {
		"num": 34, "id": "nidoking", "name": "尼多王", "title": "钻锥宝可梦", "cost": 4,
		"types": ["Poison", "Ground"], "hp": 1100, "atk": 95, "armor": 52, "mr": 52, "range": 1, "atk_speed": 0.72, "max_mana": 100,
		"desc": "坚硬外皮犹如钢铁重甲，粗壮的长尾一扫就能扫断电线杆，头顶的剧毒巨角是战场所有敌人的噩梦！",
		"skill_name": "大地之力·毒角崩击", "skill_desc": "巨角与巨尾齐发粉碎大地，造成560点伤害并击飞2格。",
		"skill_detail": "消耗100能量，以开山之势挥动钢铁巨尾与毒角轰击前方扇形，造成560点强力物理/地面伤害并强力击飞2格。",
		"skill_power": 560,
		"skills": {
			1: {"name": "大地之力·毒角崩击", "desc": "巨角巨尾粉碎大地造成560点伤害并击飞2格。", "detail": "消耗100能量，扇形轰击造成560点伤害并强力击退击飞。", "power": 560, "vfx": "body_slam", "sfx": "punch", "scale": 0.48},
			2: {"name": "污泥波·大地震怒", "desc": "引动毒浆海啸与十级地震，造成820点范围伤害并永久减速40%。", "detail": "消耗100能量，猛踏大地掀起滚滚毒泥波浪，对半场敌人造成820点高额伤害，削弱其40%攻速与移速持续整场战斗。", "power": 820, "vfx": "giga_impact", "sfx": "punch", "scale": 0.58},
			3: {"name": "暴君君临·泰坦万毒断头台", "desc": "跃起下劈轰碎整个半场，造成1350点毁灭真实伤害。", "detail": "消耗100能量，泰坦巨兽腾空下砸引发地幔撕裂，对全场所有敌人造成1350点毁灭真实伤害，若目标处于中毒状态则额外附加500点斩杀真伤！", "power": 1350, "vfx": "cosmic_singularity", "sfx": "punch", "scale": 0.72}
		},
		"visual": {"primary": (150, 70, 160), "secondary": (240, 230, 200), "accent": (240, 240, 240), "eye": (240, 40, 40), "archetype": "biped", "features": ["horns", "tail", "ears"]}
	},
	"clefairy": {
		"num": 35, "id": "clefairy", "name": "皮皮", "title": "妖精宝可梦", "cost": 2,
		"types": ["Normal"], "hp": 680, "atk": 48, "armor": 30, "mr": 45, "range": 3, "atk_speed": 0.68, "max_mana": 85,
		"desc": "在满月之夜会聚在深山跳起神秘的祈月之舞，小巧双翼储存月光，摇晃手指能引发不可思议的奇迹！",
		"skill_name": "挥指功·奇迹之手", "skill_desc": "摇动手指随机施展强力秘法，造成260点伤害或治疗全队200。",
		"skill_detail": "消耗85能量，充满期待地摇晃手指，召唤月光奇迹：有50%几率对敌方造成260点法术伤害，50%几率治疗全队200点生命值。",
		"skill_power": 260,
		"skills": {
			1: {"name": "挥指功·奇迹之手", "desc": "摇动手指触发奇迹，造成260点伤害或治疗全队200。", "detail": "消耗85能量，摇晃手指触发随机月光法术造成伤害或回血。", "power": 260, "vfx": "swift", "sfx": "skill", "scale": 0.36},
			2: {"name": "月光洗礼", "desc": "引导神圣月华照射战场，为生命最低的两名友军回复380生命。", "detail": "消耗85能量，接引皎洁月华照射战场，为生命百分比最低的2名友方单位各回复380点生命值并净化负面状态。", "power": 380, "vfx": "rest", "sfx": "skill", "scale": 0.45},
			3: {"name": "祈月神舞·天降流星雨", "desc": "月夜神舞引来九天月落星海，造成780点范围真实伤害与全队护盾。", "detail": "消耗85能量，翩跹起舞沟通太阴星神，漫天银色流星划破黑夜轰碎敌阵，造成780点范围真实伤害，同时赋予全体友军450点皎月星盾！", "power": 780, "vfx": "draco_meteor", "sfx": "skill", "scale": 0.58}
		},
		"visual": {"primary": (250, 190, 200), "secondary": (220, 120, 150), "accent": (120, 70, 40), "eye": (30, 30, 30), "archetype": "biped", "features": ["ears", "wings"]}
	},
	"clefable": {
		"num": 36, "id": "clefable", "name": "皮可西", "title": "妖精宝可梦", "cost": 3,
		"types": ["Normal"], "hp": 880, "atk": 65, "armor": 38, "mr": 55, "range": 3, "atk_speed": 0.70, "max_mana": 90,
		"desc": "长着一对灵巧的羽翼，听觉敏锐到能听到一公里外掉落在地上的针声，踏月而行时如同漫步在水面上。",
		"skill_name": "月亮之力", "skill_desc": "借用皓月伟力轰击敌人，造成420点法术伤害并降低其30%攻击力。",
		"skill_detail": "消耗90能量，沟通太阴星辰之力凝聚成炽白月光球爆碎，对目标及周围敌军造成420点伤害并降低其30%攻击力。",
		"skill_power": 420,
		"skills": {
			1: {"name": "月亮之力", "desc": "皓月光球轰击造成420点伤害并降低30%攻击力。", "detail": "消耗90能量，月神之力轰击目标造成420点伤害并降低30%攻击力。", "power": 420, "vfx": "swift", "sfx": "skill", "scale": 0.42},
			2: {"name": "月光圣域·大祝福", "desc": "展开神圣领域为全体友军回复350生命并获得25%伤害减免。", "detail": "消耗90能量，在战场中央展开神圣月光守护阵，全体友军回复350点生命值，并获得25%伤害减免持续4秒。", "power": 550, "vfx": "extreme_evoboost", "sfx": "skill", "scale": 0.52},
			3: {"name": "太阴真仙·创生月核引爆", "desc": "引爆浩瀚月核天体扫荡全屏，造成1080点真实伤害并眩晕2秒。", "detail": "消耗90能量，虚空具象化出直径百米的巨大明月天体从天砸落，对全场所有敌人造成1080点毁灭真实伤害，并强制沉睡眩晕2秒！", "power": 1080, "vfx": "cosmic_singularity", "sfx": "skill", "scale": 0.68}
		},
		"visual": {"primary": (245, 185, 195), "secondary": (210, 110, 140), "accent": (110, 60, 30), "eye": (30, 30, 30), "archetype": "biped", "features": ["ears", "wings"]}
	},
	"vulpix": {
		"num": 37, "id": "vulpix", "name": "六尾", "title": "狐狸宝可梦", "cost": 2,
		"types": ["Fire"], "hp": 620, "atk": 55, "armor": 28, "mr": 35, "range": 3, "atk_speed": 0.72, "max_mana": 80,
		"desc": "出生时只有一条白色尾巴，长大后分裂成六条美丽的卷曲长尾，口中能喷射出幽灵般幽幻的灼热狐火。",
		"skill_name": "奇异狐火", "skill_desc": "喷射三簇幽火追踪敌人，造成240点伤害并造成深度灼烧。",
		"skill_detail": "消耗80能量，从口中连吐三枚具有自动索敌功能的幽蓝狐火，各造成80点法术伤害（共240点）并附加持续灼烧。",
		"skill_power": 240,
		"skills": {
			1: {"name": "奇异狐火", "desc": "喷射幽火造成240点伤害并灼烧敌人。", "detail": "消耗80能量，吐出三枚狐火追踪敌人造成240点伤害并附带灼烧。", "power": 240, "vfx": "ember", "sfx": "fire", "scale": 0.35},
			2: {"name": "鬼火·幻境烈焰", "desc": "召唤悬浮鬼火阵列轰击，造成450点伤害并削弱30%法抗。", "detail": "消耗80能量，在目标四周凭空点燃六朵妖异鬼火同时爆碎，造成450点伤害并削弱目标30%魔抗持续4秒。", "power": 450, "vfx": "flamethrower", "sfx": "fire", "scale": 0.45},
			3: {"name": "天狐魅影·幽炎天幕", "desc": "六尾狂舞引下全屏狐火流星，造成780点真实火伤并混乱敌人。", "detail": "消耗80能量，六尾同时绽放幽冥火光，漫天幽炎流星雨笼罩整个敌阵，造成780点真实伤害并使敌军混乱自相残杀1.5秒！", "power": 780, "vfx": "inferno", "sfx": "fire", "scale": 0.58}
		},
		"visual": {"primary": (215, 90, 45), "secondary": (240, 200, 140), "accent": (180, 50, 20), "eye": (80, 40, 30), "archetype": "quadruped", "features": ["ears", "tail"]}
	},
	"ninetales": {
		"num": 38, "id": "ninetales", "name": "九尾", "title": "狐狸宝可梦", "cost": 3,
		"types": ["Fire"], "hp": 840, "atk": 75, "armor": 38, "mr": 48, "range": 3, "atk_speed": 0.78, "max_mana": 85,
		"desc": "拥有千年的超长寿命，九根金黄璀璨的长尾蕴含着神通广大的神秘灵力，双眼泛红能操纵敌人的心智！",
		"skill_name": "大晴天·神通火焰", "skill_desc": "召唤烈日当空灼烧全场，造成450点伤害且全队火系增伤30%。",
		"skill_detail": "消耗85能量，九尾向天仰啸招引炽热烈阳照耀战场，对全体敌军造成450点火系伤害，并使全体友军火系伤害提升30%持续5秒。",
		"skill_power": 450,
		"skills": {
			1: {"name": "神通火焰", "desc": "九尾烈火冲撞造成450点伤害并提升火系增伤。", "detail": "消耗85能量，喷发神通妖火造成450点伤害并让全队火系增伤30%。", "power": 450, "vfx": "flamethrower", "sfx": "fire", "scale": 0.42},
			2: {"name": "祸不单行·红莲业火", "desc": "对处于异常状态的敌人造成750点双倍伤害。", "detail": "消耗85能量，释放地狱红莲业火焚烧敌阵，对所有受负面状态影响的敌人造成750点翻倍法术伤害！", "power": 750, "vfx": "fire_blast", "sfx": "fire", "scale": 0.52},
			3: {"name": "九尾狐仙·九劫焚天阵", "desc": "九尾化身九大火龙冲霄灭世，造成1150点毁灭真实伤害与永久灼烧。", "detail": "消耗85能量，九条长尾化作九条狂暴炎龙撕裂苍穹，对全场所有敌人造成1150点纯粹真实伤害，施加永久灼烧并眩晕全员1.5秒！", "power": 1150, "vfx": "inferno", "sfx": "fire", "scale": 0.68}
		},
		"visual": {"primary": (245, 235, 170), "secondary": (220, 140, 60), "accent": (200, 50, 40), "eye": (180, 40, 40), "archetype": "quadruped", "features": ["ears", "tail"]}
	},
	"jigglypuff": {
		"num": 39, "id": "jigglypuff", "name": "胖丁", "title": "气球宝可梦", "cost": 2,
		"types": ["Normal"], "hp": 850, "atk": 45, "armor": 25, "mr": 35, "range": 2, "atk_speed": 0.65, "max_mana": 90,
		"desc": "圆滚滚的粉色身体像个大气球，能不受阻碍地不断调节声音波长，唱出让全场所有生命深陷沉睡的安眠曲。",
		"skill_name": "催眠曲·安息之歌", "skill_desc": "唱响绝美摇篮曲，使全场所有敌人陷入昏睡1.5秒并受到220伤害。",
		"skill_detail": "消耗90能量，吸饱空气鼓起圆肚唱出甜美安眠曲，强行让全屏所有敌方单位陷入昏睡1.5秒，并造成220点精神法术伤害。",
		"skill_power": 220,
		"skills": {
			1: {"name": "催眠曲·安息之歌", "desc": "唱响摇篮曲使全场敌人沉睡1.5秒并受到220点伤害。", "detail": "消耗90能量，催眠全场敌人1.5秒并造成220点伤害。", "power": 220, "vfx": "rest", "sfx": "skill", "scale": 0.38},
			2: {"name": "鼓气弹射·气球泰山击", "desc": "圆滚身体吹胀至极大下砸，造成460点伤害并弹飞敌人。", "detail": "消耗90能量，将身体吹大数倍泰山下砸，对核心区域造成460点伤害并向外弹开所有敌人。", "power": 460, "vfx": "body_slam", "sfx": "punch", "scale": 0.48},
			3: {"name": "魔音贯耳·永恒安魂弥撒", "desc": "终极歌声震碎现实，造成850点伤害并深度昏睡全场2.5秒。", "detail": "消耗90能量，引吭高歌唱出神圣天籁，震碎全场敌军心智，造成850点真实伤害并施加深度沉睡2.5秒（受到攻击不苏醒）！", "power": 850, "vfx": "extreme_evoboost", "sfx": "skill", "scale": 0.60}
		},
		"visual": {"primary": (250, 195, 205), "secondary": (255, 230, 235), "accent": (70, 160, 210), "eye": (60, 180, 220), "archetype": "orb", "features": ["ears"]}
	},
	"wigglytuff": {
		"num": 40, "id": "wigglytuff", "name": "胖可丁", "title": "气球宝可梦", "cost": 3,
		"types": ["Normal"], "hp": 1100, "atk": 65, "armor": 35, "mr": 45, "range": 2, "atk_speed": 0.68, "max_mana": 90,
		"desc": "毛发质感细腻极致，身体弹性惊人能够无限充气变大，受到攻击时会弹走敌人并用连环耳光教训对手！",
		"skill_name": "连环巴掌·连环响鸣", "skill_desc": "飞快扇出连续耳光，对目标造成420点伤害并眩晕1秒。",
		"skill_detail": "消耗90能量，双手化作狂风暴雨般连续扇出六记响亮耳光，造成420点物理伤害并使目标陷入晕眩1秒。",
		"skill_power": 420,
		"skills": {
			1: {"name": "连环巴掌·连环响鸣", "desc": "连续扇出耳光造成420点伤害并眩晕1秒。", "detail": "消耗90能量，飞快挥动双手扇击目标造成420点伤害并眩晕1秒。", "power": 420, "vfx": "quick_attack", "sfx": "punch", "scale": 0.40},
			2: {"name": "膨胀弹力罩", "desc": "膨胀为巨型弹球反弹受到的所有伤害，持续2.5秒。", "detail": "消耗90能量，将身躯猛烈吸气膨胀成弹性堡垒，获得500点护盾并将持续时间内受到的全部伤害100%反射回去！", "power": 600, "vfx": "body_slam", "sfx": "punch", "scale": 0.50},
			3: {"name": "粉红巨星·天体充气毁灭撞", "desc": "膨胀至星球级下砸敌阵，造成1100点毁灭真实伤害与全屏击飞。", "detail": "消耗90能量，吸收整片天空的气流膨胀为粉色庞然天体从九天砸落，对全场所有敌人造成1100点毁灭真实伤害并击飞2秒！", "power": 1100, "vfx": "giga_impact", "sfx": "punch", "scale": 0.66}
		},
		"visual": {"primary": (245, 190, 200), "secondary": (255, 250, 250), "accent": (70, 160, 210), "eye": (60, 180, 220), "archetype": "biped", "features": ["ears"]}
	},
	"zubat": {
		"num": 41, "id": "zubat", "name": "超音蝠", "title": "蝙蝠宝可梦", "cost": 1,
		"types": ["Poison", "Flying"], "hp": 500, "atk": 46, "armor": 20, "mr": 25, "range": 1, "atk_speed": 0.80, "max_mana": 75,
		"desc": "没有眼睛，依靠从口中发出的超音波来感知障碍物与猎物，双翼极其灵巧，擅长在黑暗中吸血突袭。",
		"skill_name": "吸血·超音波", "skill_desc": "尖锐尖叫混乱目标并吸血，造成150点伤害并将100%转化为回血。",
		"skill_detail": "消耗75能量，向目标面门释放高频刺耳超音波，造成150点伤害并将造成的伤害全部转化为自身生命，有50%几率混乱目标。",
		"skill_power": 150,
		"skills": {
			1: {"name": "吸血·超音波", "desc": "音波吸血造成150点伤害并100%回血。", "detail": "消耗75能量，释放超音波吸取敌人生命造成150点伤害并吸血。", "power": 150, "vfx": "leech_seed", "sfx": "skill", "scale": 0.32},
			2: {"name": "剧毒獠牙刺", "desc": "尖利犬齿贯穿目标动脉，造成300点伤害并深度中毒。", "detail": "消耗75能量，闪烁至目标脖颈注入剧毒，造成300点伤害并使目标中毒3秒（每秒30真实伤害）。", "power": 300, "vfx": "ice_shard", "sfx": "punch", "scale": 0.40},
			3: {"name": "蝙蝠血阵·暗夜回旋斩", "desc": "音速飞掠敌阵四连击，造成620点伤害并回复自身全部已损生命。", "detail": "消耗75能量，化作黑色狂风在全场穿梭疯狂吸血，对4名敌人各造成620点伤害并为自身回复相当于已损生命值50%的巨量生命！", "power": 620, "vfx": "hex_nightmare", "sfx": "skill", "scale": 0.52}
		},
		"visual": {"primary": (65, 105, 185), "secondary": (180, 50, 100), "accent": (240, 240, 240), "eye": (20, 20, 20), "archetype": "bird", "features": ["wings", "ears"]}
	},
	"golbat": {
		"num": 42, "id": "golbat", "name": "大嘴蝠", "title": "蝙蝠宝可梦", "cost": 2,
		"types": ["Poison", "Flying"], "hp": 740, "atk": 66, "armor": 30, "mr": 35, "range": 1, "atk_speed": 0.82, "max_mana": 75,
		"desc": "拥有一张巨大且永远大张的恐怖巨嘴，四个锋利獠牙能瞬间刺破粗糙兽皮，一次能吸食超过300毫升鲜血！",
		"skill_name": "大食吸血狂噬", "skill_desc": "张开深渊巨口狂暴撕咬吸血，造成320点伤害并回复自身320生命。",
		"skill_detail": "消耗75能量，扑向目标张开大嘴凶残撕咬，造成320点伤害并将造成的伤害100%转化为自身生命恢复。",
		"skill_power": 320,
		"skills": {
			1: {"name": "大食吸血狂噬", "desc": "巨口撕咬造成320点伤害并回复320生命。", "detail": "消耗75能量，吸血撕咬造成320点伤害并回复100%生命值。", "power": 320, "vfx": "leech_seed", "sfx": "punch", "scale": 0.38},
			2: {"name": "黑雾·暗影风刃", "desc": "散布浓厚黑雾并射出空气利刃，造成500点伤害并驱散敌人增益。", "detail": "消耗75能量，喷吐大片黑雾遮蔽战场造成500点法术伤害，并驱散受击目标身上的所有护盾与攻击增益！", "power": 500, "vfx": "psycho_cut", "sfx": "swift", "scale": 0.48},
			3: {"name": "血蝠魔王·万蝠噬身天灾", "desc": "召唤成千上万嗜血恶蝠席卷全屏，造成880点伤害并全体沉默2秒。", "detail": "消耗75能量，尖啸唤醒整个洞窟的恶蝠狂潮淹没战场，对所有敌人造成880点真实伤害，强行沉默2秒并使自身完全回满生命！", "power": 880, "vfx": "hex_nightmare", "sfx": "skill", "scale": 0.60}
		},
		"visual": {"primary": (55, 95, 175), "secondary": (220, 60, 110), "accent": (240, 240, 240), "eye": (20, 20, 20), "archetype": "bird", "features": ["wings", "ears", "teeth"]}
	},
	"oddish": {
		"num": 43, "id": "oddish", "name": "走路草", "title": "杂草宝可梦", "cost": 1,
		"types": ["Grass", "Poison"], "hp": 540, "atk": 45, "armor": 25, "mr": 30, "range": 2, "atk_speed": 0.65, "max_mana": 80,
		"desc": "白天把身体埋在冰凉土壤里只露出头顶绿叶吸收养分，晚上在月光下拔出双脚到处漫步播撒种子。",
		"skill_name": "吸取·溶解液", "skill_desc": "喷吐酸液吸收目标精气，造成150点伤害并回血100。",
		"skill_detail": "消耗80能量，向目标喷射腐蚀酸液吸取精气，造成150点法术伤害，自身回复100点生命值。",
		"skill_power": 150,
		"skills": {
			1: {"name": "吸取·溶解液", "desc": "喷吐酸液造成150点伤害并回复100生命。", "detail": "消耗80能量，酸液汲取造成150点伤害并回复自身100生命。", "power": 150, "vfx": "leech_seed", "sfx": "skill", "scale": 0.32},
			2: {"name": "麻痹毒粉", "desc": "撒下金黄麻痹粉末，对周围敌人造成300点伤害并眩晕1.2秒。", "detail": "消耗80能量，头顶叶片晃动洒下漫天毒粉，对周围敌人造成300点伤害并使其麻痹眩晕1.2秒。", "power": 300, "vfx": "razor_leaf", "sfx": "skill", "scale": 0.40},
			3: {"name": "月夜漫步·百草回春", "desc": "引动自然月华治疗全体友军350生命，对全屏敌人造成550点伤害。", "detail": "消耗80能量，月华圣光从天而降，为全体友军回复350点生命值，并对全屏所有敌人造成550点真实草系法术伤害！", "power": 550, "vfx": "frenzy_plant", "sfx": "skill", "scale": 0.52}
		},
		"visual": {"primary": (60, 80, 150), "secondary": (70, 180, 80), "accent": (220, 40, 40), "eye": (220, 40, 40), "archetype": "plant", "features": ["leaves"]}
	},
	"gloom": {
		"num": 44, "id": "gloom", "name": "臭臭花", "title": "杂草宝可梦", "cost": 2,
		"types": ["Grass", "Poison"], "hp": 750, "atk": 58, "armor": 32, "mr": 38, "range": 2, "atk_speed": 0.67, "max_mana": 85,
		"desc": "花瓣散发出极其浓烈的恶臭气味，能让2公里外的人瞬间昏厥，口中流出的甜腻花蜜含有强力神经毒素。",
		"skill_name": "恶臭毒气暴击", "skill_desc": "释放恶臭迷雾笼罩敌人，造成280点伤害并削弱30%魔抗。",
		"skill_detail": "消耗85能量，花蕊狂暴释放令人作呕的恶臭毒烟，对范围内所有敌人造成280点法术伤害并降低其30%魔抗持续3秒。",
		"skill_power": 280,
		"skills": {
			1: {"name": "恶臭毒气暴击", "desc": "释放恶臭毒烟造成280点伤害并削弱30%魔抗。", "detail": "消耗85能量，恶臭毒烟轰击造成280点伤害并降低30%魔抗。", "power": 280, "vfx": "shadow_ball", "sfx": "skill", "scale": 0.38},
			2: {"name": "甜甜香气·花粉爆弹", "desc": "抛出浓缩花粉引爆，造成460点伤害并混乱敌人1.5秒。", "detail": "消耗85能量，投掷剧毒花粉炸弹，造成460点伤害并使范围内敌人陷入混乱相互攻击1.5秒。", "power": 460, "vfx": "razor_leaf", "sfx": "skill", "scale": 0.46},
			3: {"name": "尸香魔花·幽冥毒泽", "desc": "在战场生成剧毒沼泽，造成820点范围伤害并禁锢全员2秒。", "detail": "消耗85能量，脚下大地化为翻滚的剧毒泥沼，对全场所有敌人造成820点毁灭毒性伤害，并死死禁锢其双腿2秒！", "power": 820, "vfx": "hex_nightmare", "sfx": "skill", "scale": 0.58}
		},
		"visual": {"primary": (70, 90, 160), "secondary": (180, 90, 50), "accent": (240, 200, 100), "eye": (20, 20, 20), "archetype": "plant", "features": ["leaves", "flower"]}
	},
	"vileplume": {
		"num": 45, "id": "vileplume", "name": "霸王花", "title": "花宝可梦", "cost": 3,
		"types": ["Grass", "Poison"], "hp": 920, "atk": 78, "armor": 42, "mr": 48, "range": 3, "atk_speed": 0.70, "max_mana": 90,
		"desc": "拥有世界上最巨大的深红带白点花瓣，剧毒花粉随风飘散遮蔽天日，战斗时展开霸王花域压制全场敌军！",
		"skill_name": "落英缤纷·霸王花粉", "skill_desc": "摇晃巨型红花掀起毒雾风暴，对全场敌人造成420点法术伤害。",
		"skill_detail": "消耗90能量，剧烈摇晃头顶巨大红花，释放出浓烈刺目的剧毒花粉风暴，对全场所有敌人造成420点法术伤害并降低其40%攻速。",
		"skill_power": 420,
		"skills": {
			1: {"name": "落英缤纷·霸王花粉", "desc": "巨花摇晃释放毒粉风暴，造成420点全场伤害并减速40%。", "detail": "消耗90能量，全场释放剧毒花粉造成420点伤害并降低40%攻速。", "power": 420, "vfx": "razor_leaf", "sfx": "skill", "scale": 0.44},
			2: {"name": "花瓣狂舞·血色风暴", "desc": "无数锋利血红花瓣切割全场，造成680点暴击伤害。", "detail": "消耗90能量，召唤狂暴的赤红花瓣风暴切割敌方阵型，造成680点高额草系暴击伤害并附加流血。", "power": 680, "vfx": "frenzy_plant", "sfx": "skill", "scale": 0.54},
			3: {"name": "霸王降世·太古腐骨毒瘴", "desc": "引爆霸王花魂毒瘴席卷整片大地，造成1180点真实伤害并致盲3秒。", "detail": "消耗90能量，唤醒远古霸王花树之灵，深红花粉云雾遮蔽日月，对全场所有敌人造成1180点毁灭真实伤害并致盲3秒！", "power": 1180, "vfx": "hex_nightmare", "sfx": "skill", "scale": 0.68}
		},
		"visual": {"primary": (75, 95, 165), "secondary": (220, 50, 60), "accent": (240, 240, 240), "eye": (220, 40, 40), "archetype": "plant", "features": ["flower"]}
	},
	"paras": {
		"num": 46, "id": "paras", "name": "派拉斯", "title": "蘑菇宝可梦", "cost": 1,
		"types": ["Bug", "Grass"], "hp": 540, "atk": 52, "armor": 28, "mr": 28, "range": 1, "atk_speed": 0.70, "max_mana": 80,
		"desc": "背上寄生着两朵名为冬虫夏草的红色蘑菇，蘑菇会指挥本体吸收树木养分，双爪能挥舞十字剪切开敌人。",
		"skill_name": "十字剪·双爪切", "skill_desc": "双螯交叉斩出十字刀光，造成170点物理伤害并提升自身攻速。",
		"skill_detail": "消耗80能量，锋利双钳在身前交叉成十字形迅猛剪切，造成170点物理伤害，并使自身攻击速度提升30%持续3秒。",
		"skill_power": 170,
		"skills": {
			1: {"name": "十字剪·双爪切", "desc": "双螯交叉剪切造成170点伤害并提升自身攻速。", "detail": "消耗80能量，十字交叉斩造成170点伤害并获得30%攻速。", "power": 170, "vfx": "psycho_cut", "sfx": "punch", "scale": 0.32},
			2: {"name": "蘑菇孢子·麻痹眠杀", "desc": "背后蘑菇爆散孢子，造成320点伤害并使敌人沉睡1.5秒。", "detail": "消耗80能量，背后寄生冬虫夏草喷发高浓孢子云，对周围所有敌人造成320点伤害并催眠1.5秒。", "power": 320, "vfx": "leech_seed", "sfx": "skill", "scale": 0.40},
			3: {"name": "真菌暴动·致命吸血菌丝", "desc": "无数真菌寄生藤蔓缠绕全场，造成640点伤害并将70%转化为自身回血。", "detail": "消耗80能量，引爆真菌母体向全场伸出无数嗜血菌丝，对全体敌人造成640点伤害，并将造成的总伤害70%转化为自身生命回复！", "power": 640, "vfx": "frenzy_plant", "sfx": "skill", "scale": 0.54}
		},
		"visual": {"primary": (230, 130, 60), "secondary": (230, 60, 50), "accent": (240, 240, 200), "eye": (240, 240, 240), "archetype": "bug", "features": ["horns"]}
	},
	"parasect": {
		"num": 47, "id": "parasect", "name": "派拉斯特", "title": "蘑菇宝可梦", "cost": 3,
		"types": ["Bug", "Grass"], "hp": 860, "atk": 80, "armor": 45, "mr": 45, "range": 1, "atk_speed": 0.72, "max_mana": 85,
		"desc": "虫体已被背上巨大的冬虫夏草完全操纵，白色的死寂双眼不会眨动，能从伞盖下喷洒出让一切陷入昏厥的强力孢子！",
		"skill_name": "蘑菇孢子·绝对昏眠", "skill_desc": "伞盖喷发金色真菌云雾，使扇形敌人100%沉睡2秒并造成360伤害。",
		"skill_detail": "消耗85能量，巨大菌盖剧烈震颤释放纯净蘑菇孢子，对前方扇形所有敌人造成360点伤害，并施加强制沉睡2秒（受到攻击不苏醒）。",
		"skill_power": 360,
		"skills": {
			1: {"name": "蘑菇孢子·绝对昏眠", "desc": "喷射蘑菇孢子造成360点伤害并强制沉睡2秒。", "detail": "消耗85能量，散发真菌孢子造成360点伤害并深度昏睡敌人2秒。", "power": 360, "vfx": "leech_seed", "sfx": "skill", "scale": 0.42},
			2: {"name": "吸血·寄生夺舍", "desc": "巨螯贯穿目标吸取生命，造成580点伤害并偷取其30点攻击力。", "detail": "消耗85能量，真菌巨爪狠狠刺入目标体内抽取生机，造成580点物理伤害并偷取其30点攻击力转移给自身。", "power": 580, "vfx": "close_combat", "sfx": "punch", "scale": 0.50},
			3: {"name": "真菌之王·深渊菌落天劫", "desc": "菌丝覆盖全图抽取全员生命，造成1050点毁灭伤害并为全队回血600。", "detail": "消耗85能量，引爆古菌母体让亿万真菌菌落瞬间铺满战场，抽干敌方防线造成1050点毁灭真实伤害，并为全队友军回复600点巨额生命！", "power": 1050, "vfx": "frenzy_plant", "sfx": "skill", "scale": 0.66}
		},
		"visual": {"primary": (225, 120, 50), "secondary": (220, 50, 40), "accent": (245, 235, 180), "eye": (240, 240, 240), "archetype": "bug", "features": ["horns"]}
	},
	"venonat": {
		"num": 48, "id": "venonat", "name": "毛球", "title": "昆虫宝可梦", "cost": 1,
		"types": ["Bug", "Poison"], "hp": 540, "atk": 46, "armor": 25, "mr": 28, "range": 2, "atk_speed": 0.70, "max_mana": 80,
		"desc": "全身覆盖着软绵绵的紫黑色毒毛，一双巨大的复眼具有红外雷达功能，在漆黑夜晚中也能看清一厘米的小虫。",
		"skill_name": "幻象光·毒粉", "skill_desc": "复眼发射七彩射线并伴随毒粉，造成160点伤害并混乱1秒。",
		"skill_detail": "消耗80能量，巨大复眼聚能射出精神幻象射线，造成160点法术伤害，并使目标陷入混乱1秒（随机攻击身旁单位）。",
		"skill_power": 160,
		"skills": {
			1: {"name": "幻象光·毒粉", "desc": "复眼发射射线造成160点伤害并混乱1秒。", "detail": "消耗80能量，射出彩虹光束造成160点伤害并使目标混乱1秒。", "power": 160, "vfx": "psybeam", "sfx": "skill", "scale": 0.34},
			2: {"name": "麻痹雷达波", "desc": "复眼向四周广播声呐脉冲，造成320点伤害并使敌人麻痹1.2秒。", "detail": "消耗80能量，复眼过载释放环形雷达超声波，对周围所有敌人造成320点伤害并麻痹眩晕1.2秒。", "power": 320, "vfx": "discharge", "sfx": "skill", "scale": 0.42},
			3: {"name": "百万伏特毒光·雷霆幻灭", "desc": "复眼射出贯穿全场的超能死光，造成650点范围穿透伤害。", "detail": "消耗80能量，所有小单眼同时聚焦射出一道贯穿整张棋盘的毁灭超能光柱，造成650点真实伤害并削弱全员30点护甲与魔抗！", "power": 650, "vfx": "hyper_beam", "sfx": "skill", "scale": 0.54}
		},
		"visual": {"primary": (120, 80, 150), "secondary": (220, 60, 70), "accent": (240, 240, 240), "eye": (220, 40, 50), "archetype": "bug", "features": ["ears"]}
	},
	"venomoth": {
		"num": 49, "id": "venomoth", "name": "摩鲁蛾", "title": "毒蛾宝可梦", "cost": 3,
		"types": ["Bug", "Poison"], "hp": 780, "atk": 72, "armor": 35, "mr": 45, "range": 3, "atk_speed": 0.75, "max_mana": 85,
		"desc": "翅膀上覆盖着细微的磷粉，不同颜色的磷粉代表着不同的剧毒，拍动双翅时磷粉如雨落下腐蚀一切！",
		"skill_name": "虫鸣·极光毒风", "skill_desc": "双翅剧烈共振产生高频声波，对全屏造成380点伤害并降低30%移速。",
		"skill_detail": "消耗85能量，双翼以超音速高频共振产生穿透耳膜的虫鸣音波，对全屏敌军造成380点法术伤害并降低其30%移速与攻速持续3秒。",
		"skill_power": 380,
		"skills": {
			1: {"name": "虫鸣·极光毒风", "desc": "高频声波造成380点全场伤害并降低30%移速。", "detail": "消耗85能量，释放穿透虫鸣造成380点全场伤害并降低30%攻速与移速。", "power": 380, "vfx": "psybeam", "sfx": "skill", "scale": 0.42},
			2: {"name": "银色旋风·毒蛾之舞", "desc": "召唤璀璨银色狂风切割战场，造成620点暴击伤害且全属性提升20%。", "detail": "消耗85能量，卷起闪烁银光的剧毒风暴切割敌阵造成620点暴击伤害，同时自身全属性提升20%持续整场战斗！", "power": 620, "vfx": "swift", "sfx": "skill", "scale": 0.52},
			3: {"name": "天冥毒蛾·九死还魂天劫", "desc": "引爆万蛊毒蛾毒雾覆灭敌军，造成1080点真实伤害并传染猛毒。", "detail": "消耗85能量，释放禁断万毒死光风暴席卷全场，对所有敌人造成1080点毁灭真实伤害，并在受击敌人死亡时引发连锁毒爆！", "power": 1080, "vfx": "hex_nightmare", "sfx": "skill", "scale": 0.68}
		},
		"visual": {"primary": (150, 110, 175), "secondary": (220, 200, 230), "accent": (240, 230, 240), "eye": (240, 240, 240), "archetype": "bug", "features": ["wings", "ears"]}
	},
	"diglett": {
		"num": 50, "id": "diglett", "name": "地鼠", "title": "鼹鼠宝可梦", "cost": 1,
		"types": ["Ground"], "hp": 480, "atk": 55, "armor": 25, "mr": 25, "range": 1, "atk_speed": 0.85, "max_mana": 70,
		"desc": "生活在地下一米深处的松软土壤里，以植物根茎为食，在地底以极高速度穿梭，只露出一颗圆圆的脑袋。",
		"skill_name": "掷泥·挖洞", "skill_desc": "从地底钻出向目标面部泼洒泥浆，造成150点伤害并致盲2秒。",
		"skill_detail": "消耗70能量，高速破土而出将滚烫坚硬的泥浆狠狠甩在目标脸上，造成150点物理伤害并致盲2秒（命中率降低50%）。",
		"skill_power": 150,
		"skills": {
			1: {"name": "掷泥·挖洞", "desc": "破土泼泥造成150点伤害并致盲目标2秒。", "detail": "消耗70能量，飞掷泥弹造成150点伤害并使敌人致盲2秒。", "power": 150, "vfx": "ember", "sfx": "punch", "scale": 0.30},
			2: {"name": "突袭·地心穿刺", "desc": "瞬移至敌方后排核心脚下破土攻击，造成320点伤害。", "detail": "消耗70能量，遁入地底瞬间钻至敌方攻击力最高的目标脚下破土猛撞，造成320点物理伤害并击飞1秒。", "power": 320, "vfx": "giga_impact", "sfx": "punch", "scale": 0.40},
			3: {"name": "流沙深渊·重力塌陷", "desc": "将敌阵脚下化作流沙漩涡，造成600点真实伤害并禁锢全体2秒。", "detail": "消耗70能量，疯狂挖掘将敌方半场转化为不断坍缩的流沙漩涡，对范围内敌人造成600点真实伤害并禁锢2秒！", "power": 600, "vfx": "cosmic_singularity", "sfx": "punch", "scale": 0.52}
		},
		"visual": {"primary": (160, 110, 70), "secondary": (230, 110, 130), "accent": (80, 50, 30), "eye": (20, 20, 20), "archetype": "orb", "features": ["whiskers"]}
	},
	"dugtrio": {
		"num": 51, "id": "dugtrio", "name": "三地鼠", "title": "鼹鼠宝可梦", "cost": 2,
		"types": ["Ground"], "hp": 720, "atk": 75, "armor": 35, "mr": 35, "range": 1, "atk_speed": 0.88, "max_mana": 75,
		"desc": "三个脑袋齐心协力地在地下高速挖掘，能以超过100公里的时速挖掘地底隧道，引发大范围局部地震！",
		"skill_name": "三重重力地刺", "skill_desc": "三个脑袋同时发动地震冲击波，造成320点伤害并眩晕1秒。",
		"skill_detail": "消耗75能量，三个脑袋同步敲击地壳引发三重谐振地震波，对前方直线敌军造成320点地面物理伤害并眩晕1秒。",
		"skill_power": 320,
		"skills": {
			1: {"name": "三重重力地刺", "desc": "三个脑袋引发地震波造成320点伤害并眩晕1秒。", "detail": "消耗75能量，三重地震波轰击直线造成320点伤害并眩晕1秒。", "power": 320, "vfx": "body_slam", "sfx": "punch", "scale": 0.38},
			2: {"name": "沙地狱·断头绝杀", "desc": "瞬移至敌方后排集火撕咬，造成540点必定暴击伤害。", "detail": "消耗75能量，全速潜入敌方后排脆皮核心脚下破土三连击，造成540点必定暴击的真实物理伤害。", "power": 540, "vfx": "giga_impact", "sfx": "punch", "scale": 0.48},
			3: {"name": "大地崩裂·十级地脉大逆流", "desc": "引发毁灭级地震撕裂棋盘，造成920点真实伤害并击飞全场2秒。", "detail": "消耗75能量，引爆地下板块构造引发十级超级大地震，对全场所有敌人造成920点毁灭真实伤害，强行震飞全员2秒！", "power": 920, "vfx": "cosmic_singularity", "sfx": "punch", "scale": 0.62}
		},
		"visual": {"primary": (155, 105, 65), "secondary": (225, 105, 125), "accent": (75, 45, 25), "eye": (20, 20, 20), "archetype": "orb", "features": ["whiskers"]}
	},
	"meowth": {
		"num": 52, "id": "meowth", "name": "喵喵", "title": "妖怪猫宝可梦", "cost": 1,
		"types": ["Normal"], "hp": 520, "atk": 54, "armor": 22, "mr": 22, "range": 1, "atk_speed": 0.80, "max_mana": 75,
		"desc": "额头镶嵌着一枚金灿灿的大金币，非常喜欢闪闪发光的东西，动作敏捷轻盈，爪子里隐藏着锋利的刀刃。",
		"skill_name": "聚宝功·金币飞掷", "skill_desc": "向目标掷出漫天硬币，造成180点伤害并额外掉落1金币。",
		"skill_detail": "消耗75能量，从额头金币喷射出无数闪烁金币暴击敌人，造成180点物理伤害，击杀目标时有100%几率获得1枚金币！",
		"skill_power": 180,
		"skills": {
			1: {"name": "聚宝功·金币飞掷", "desc": "掷出金币造成180点伤害并有几率获得金币。", "detail": "消耗75能量，金币飞掷造成180点伤害，击杀敌方获取1金币。", "power": 180, "vfx": "swift", "sfx": "click", "scale": 0.32},
			2: {"name": "乱抓·黄金风暴", "desc": "挥舞利爪光速四连抓，造成360点伤害并偷取敌人15能量。", "detail": "消耗75能量，闪电般四连爪击目标造成360点伤害，并偷取目标15点能量转移给自身。", "power": 360, "vfx": "close_combat", "sfx": "punch", "scale": 0.42},
			3: {"name": "招财天降·财神黄金大暴雨", "desc": "天降如山金币巨浪轰击全场，造成680点伤害并眩晕全员1.5秒。", "detail": "消耗75能量，召唤招财神猫从虚空倾倒无尽黄金金币海洋轰碎敌阵，对全场所有敌人造成680点伤害并眩晕1.5秒！", "power": 680, "vfx": "draco_meteor", "sfx": "click", "scale": 0.55}
		},
		"visual": {"primary": (245, 235, 205), "secondary": (140, 80, 50), "accent": (240, 200, 50), "eye": (30, 30, 30), "archetype": "biped", "features": ["ears", "whiskers", "tail"]}
	},
	"persian": {
		"num": 53, "id": "persian", "name": "猫老大", "title": "暹罗猫宝可梦", "cost": 3,
		"types": ["Normal"], "hp": 780, "atk": 85, "armor": 35, "mr": 35, "range": 1, "atk_speed": 0.85, "max_mana": 75,
		"desc": "举止高贵优雅，额头镶嵌着璀璨红宝石，奔跑时脚步轻灵无声无息，性情极其暴戾好战，瞬间撕碎猎物咽喉！",
		"skill_name": "力量宝石·红莲裂杀", "skill_desc": "额头红宝石发射高能射线并突刺，造成420点暴击伤害。",
		"skill_detail": "消耗75能量，额头红宝石闪耀夺目光芒射出聚焦激光，同时双爪飞扑撕咬，造成420点必定暴击的强力伤害。",
		"skill_power": 420,
		"skills": {
			1: {"name": "力量宝石·红莲裂杀", "desc": "红宝石激光轰击造成420点必定暴击伤害。", "detail": "消耗75能量，激光配合爪击造成420点暴击物理伤害。", "power": 420, "vfx": "swift", "sfx": "punch", "scale": 0.40},
			2: {"name": "击掌奇袭·瞬影绝杀", "desc": "瞬移至目标身后击掌强控眩晕1.5秒，造成620点伤害。", "detail": "消耗75能量，如幽灵般闪烁至目标身后击掌打断，强行眩晕目标1.5秒并造成620点高额刺杀伤害。", "power": 620, "vfx": "close_combat", "sfx": "punch", "scale": 0.50},
			3: {"name": "贵族死线·宝石天煞乱刃狂潮", "desc": "无数红宝石流光伴随千道抓痕席卷全场，造成1100点毁灭真实伤害。", "detail": "消耗75能量，化作残影在全场无缝穿梭瞬杀，无数道红宝石光刃与利爪印记纵横交错，对全屏敌军造成1100点毁灭真实伤害！", "power": 1100, "vfx": "dragon_apocalypse", "sfx": "punch", "scale": 0.65}
		},
		"visual": {"primary": (240, 230, 200), "secondary": (220, 40, 40), "accent": (210, 30, 30), "eye": (20, 20, 20), "archetype": "quadruped", "features": ["ears", "whiskers", "tail"]}
	},
	"psyduck": {
		"num": 54, "id": "psyduck", "name": "可达鸭", "title": "鸭宝可梦", "cost": 2,
		"types": ["Water", "Psychic"], "hp": 680, "atk": 54, "armor": 25, "mr": 35, "range": 2, "atk_speed": 0.70, "max_mana": 100,
		"desc": "经常头痛，抱头苦恼时不可思议的念力就会失控爆发。头痛剧烈到极限时能觉醒令全场敌人浮空瘫痪的神智念动力！",
		"skill_name": "念力头槌", "skill_desc": "双眼泛蓝激发超念力，造成260点伤害并眩晕敌人1.2秒。",
		"skill_detail": "消耗100能量，剧烈头痛下双眼泛起蓝光激发生物念力，撞击震飞目标周围敌军，造成260点超能伤害并使其眩晕1.2秒。",
		"skill_power": 260,
		"skills": {
			1: {"name": "水之波动", "desc": "抱头释放震荡水球造成180点伤害并减速。", "detail": "消耗100能量，抱头释放剧烈震荡水球对目标造成180点水系伤害。", "power": 180, "vfx": "water_gun", "sfx": "water", "scale": 0.32},
			2: {"name": "念力头槌", "desc": "双眼泛蓝超念力激波，对群体造成340点伤害并眩晕1.2秒。", "detail": "消耗100能量，双眼泛蓝超念力激波造成340点范围伤害并眩晕1.2秒。", "power": 340, "vfx": "zen_headbutt", "sfx": "skill", "scale": 0.42},
			3: {"name": "念动力·神智崩坏", "desc": "重力坍塌力场浮空全员2秒，造成720点巨额真实伤害。", "detail": "消耗100能量，头痛突破极限觉醒高维念动力，引发空间引力坍塌将全场敌人浮空压制2秒，并造成720点真实伤害！", "power": 720, "vfx": "psychokinesis", "sfx": "skill", "scale": 0.55}
		},
		"visual": {"primary": (250, 220, 80), "secondary": (245, 235, 170), "accent": (80, 50, 20), "eye": (20, 20, 20), "archetype": "biped", "features": ["beak"]}
	},
	"golduck": {
		"num": 55, "id": "golduck", "name": "哥达鸭", "title": "鸭宝可梦", "cost": 3,
		"types": ["Water", "Psychic"], "hp": 860, "atk": 78, "armor": 38, "mr": 48, "range": 2, "atk_speed": 0.78, "max_mana": 90,
		"desc": "额头上的红色宝石在释放念力时会发出耀眼光芒，游泳速度堪比金牌运动员，擅长以高压水流配合精神念力制霸水陆！",
		"skill_name": "水炮·精神强念", "skill_desc": "额头红宝发光发射念力水柱，造成420点伤害并眩晕1秒。",
		"skill_detail": "消耗90能量，额头红宝石绽放念力红芒，双手合拢喷射狂暴的念力水龙，对整条直线敌军造成420点水/超双系伤害并眩晕1秒。",
		"skill_power": 420,
		"skills": {
			1: {"name": "水炮·精神强念", "desc": "念力水龙贯穿直线造成420点伤害并眩晕1秒。", "detail": "消耗90能量，发射念力激流造成420点双系伤害并眩晕1秒。", "power": 420, "vfx": "hydro_pump", "sfx": "water", "scale": 0.42},
			2: {"name": "超能水牢·精神裂解", "desc": "在目标脚下凝聚水牢囚禁2秒，造成620点伤害并削弱40%魔抗。", "detail": "消耗90能量，在敌方核心脚下升起念力水牢，强力束缚敌人2秒造成620点伤害并粉碎40%魔法抗性。", "power": 620, "vfx": "psychokinesis", "sfx": "skill", "scale": 0.52},
			3: {"name": "海神狂怒·高维洪流大爆发", "desc": "召唤海神潮汐伴随高维念力震碎战场，造成1100点毁灭伤害。", "detail": "消耗90能量，额头红宝石完全觉醒引发高维引力洪流席卷全屏，造成1100点毁灭真实伤害并使全场敌军瘫痪2秒！", "power": 1100, "vfx": "hydro_tempest", "sfx": "water", "scale": 0.68}
		},
		"visual": {"primary": (75, 150, 215), "secondary": (220, 40, 40), "accent": (240, 200, 60), "eye": (220, 30, 30), "archetype": "biped", "features": ["beak"]}
	},
	"mankey": {
		"num": 56, "id": "mankey", "name": "猴怪", "title": "猪猴宝可梦", "cost": 1,
		"types": ["Fighting"], "hp": 540, "atk": 56, "armor": 24, "mr": 24, "range": 1, "atk_speed": 0.78, "max_mana": 75,
		"desc": "脾气极其暴躁，一秒内就会暴怒狂化，发怒时血液流动加速肌肉隆起，挥舞狂暴拳头不死不休地揍扁敌人！",
		"skill_name": "愤怒重拳", "skill_desc": "暴怒之下全力挥拳猛砸，造成180点暴击伤害并击退1格。",
		"skill_detail": "消耗75能量，进入暴怒状态蓄力猛轰目标面门，造成180点必定暴击的格斗物理伤害并击退目标1格。",
		"skill_power": 180,
		"skills": {
			1: {"name": "愤怒重拳", "desc": "暴怒挥拳造成180点暴击伤害并击退1格。", "detail": "消耗75能量，挥出重拳造成180点物理伤害并附带暴击。", "power": 180, "vfx": "low_kick", "sfx": "punch", "scale": 0.32},
			2: {"name": "十字劈·狂化连打", "desc": "双手交叉劈斩破开敌人防御，造成360点伤害并使自身攻速+35%。", "detail": "消耗75能量，双手成掌狂暴下劈造成360点伤害，自身攻击速度提升35%持续4秒。", "power": 360, "vfx": "close_combat", "sfx": "punch", "scale": 0.42},
			3: {"name": "疯猴血战·爆裂碎颅杀", "desc": "狂暴连续轰出十记重拳，造成680点伤害并将敌人击飞。", "detail": "消耗75能量，彻底失去理智连续疯狂轰出无敌重拳，对目标及其周围敌军造成680点巨额真实伤害并击飞1.5秒！", "power": 680, "vfx": "giga_impact", "sfx": "punch", "scale": 0.55}
		},
		"visual": {"primary": (240, 230, 210), "secondary": (140, 80, 50), "accent": (210, 50, 50), "eye": (210, 40, 40), "archetype": "biped", "features": ["ears", "tail"]}
	},
	"primeape": {
		"num": 57, "id": "primeape", "name": "火暴猴", "title": "猪猴宝可梦", "cost": 3,
		"types": ["Fighting"], "hp": 820, "atk": 85, "armor": 38, "mr": 38, "range": 1, "atk_speed": 0.82, "max_mana": 75,
		"desc": "无时无刻不在发怒，眼中只有战斗与狂暴，即使睡觉时也会因愤怒突然暴起，拳力之大能击碎一切钢铁要塞！",
		"skill_name": "大闹一番·狂怒拳击", "skill_desc": "暴走冲锋连续痛殴敌人，造成450点伤害且自身免控2秒。",
		"skill_detail": "消耗75能量，彻底暴走进入霸体免控状态，疯狂挥动拳头痛击前方扇形所有敌人，造成450点物理伤害并获得2秒完全免疫控制。",
		"skill_power": 450,
		"skills": {
			1: {"name": "大闹一番·狂怒拳击", "desc": "暴走痛击造成450点伤害且自身免控2秒。", "detail": "消耗75能量，连续出拳造成450点伤害并免控2秒。", "power": 450, "vfx": "low_kick", "sfx": "punch", "scale": 0.42},
			2: {"name": "近身战·碎骨连击", "desc": "以超音速狂轰滥炸连续出拳，造成680点伤害并撕碎40%护甲。", "detail": "消耗75能量，将敌人顶在墙角狂风骤雨般连击，造成680点伤害并彻底粉碎目标40%物理护甲。", "power": 680, "vfx": "close_combat", "sfx": "punch", "scale": 0.52},
			3: {"name": "狂战魔猿·怒火焚身灭世杀", "desc": "愤怒化为实质烈焰重拳砸碎大地，造成1150点毁灭真实伤害。", "detail": "消耗75能量，愤怒达到神之领域全身燃起实质斗气烈焰，雷霆一拳砸碎大地板块，对全场所有敌人造成1150点纯粹真实伤害并眩晕2秒！", "power": 1150, "vfx": "giga_impact", "sfx": "punch", "scale": 0.68}
		},
		"visual": {"primary": (235, 220, 195), "secondary": (120, 70, 40), "accent": (210, 40, 40), "eye": (210, 40, 40), "archetype": "biped", "features": ["ears"]}
	},
	"growlithe": {
		"num": 58, "id": "growlithe", "name": "卡蒂狗", "title": "小狗宝可梦", "cost": 2,
		"types": ["Fire"], "hp": 680, "atk": 60, "armor": 30, "mr": 30, "range": 1, "atk_speed": 0.72, "max_mana": 85,
		"desc": "性格忠诚勇敢，对主人忠心耿耿，嗅觉极其灵敏，即使对手比自己大很多倍也会勇敢咆哮并喷射烈火冲撞！",
		"skill_name": "火焰轮", "skill_desc": "全身裹上烈焰冲撞敌人，造成240点伤害并灼烧。",
		"skill_detail": "消耗85能量，全身卷起旋转烈焰轮狂暴突进冲撞目标，造成240点火系范围伤害并使其灼烧3秒。",
		"skill_power": 240,
		"skills": {
			1: {"name": "火焰牙", "desc": "火牙撕咬造成160点伤害并灼烧敌人。", "detail": "消耗85能量，燃火犬齿撕咬单体造成160点火系伤害。", "power": 160, "vfx": "fire_fang", "sfx": "fire", "scale": 0.32},
			2: {"name": "火焰轮", "desc": "火轮冲锋造成240点伤害并灼烧目标。", "detail": "消耗85能量，化作翻滚火轮突进造成240点伤害并灼烧3秒。", "power": 240, "vfx": "flame_wheel", "sfx": "fire", "scale": 0.42},
			3: {"name": "闪焰冲锋·神速", "desc": "赤金流星音速撞击，造成620点巨额范围伤害与全员击飞。", "detail": "消耗85能量，赤金神速流星轰击敌阵，对最多5名敌军造成620点真实火伤并强力击飞1.2秒！", "power": 620, "vfx": "flare_blitz", "sfx": "fire", "scale": 0.55}
		},
		"visual": {"primary": (240, 140, 60), "secondary": (245, 230, 180), "accent": (40, 40, 40), "eye": (30, 30, 30), "archetype": "quadruped", "features": ["ears", "tail"]}
	},
	"arcanine": {
		"num": 59, "id": "arcanine", "name": "风速狗", "title": "传说宝可梦", "cost": 4,
		"types": ["Fire"], "hp": 1050, "atk": 92, "armor": 48, "mr": 48, "range": 1, "atk_speed": 0.80, "max_mana": 90,
		"desc": "自古以来就被誉为传说中的神兽，能以如乘风般不可思议的速度奔跑，体内燃烧着永不熄灭的正义烈火！",
		"skill_name": "大字爆炎·神速狂袭", "skill_desc": "神速冲锋轰出炽热炎印，造成540点穿透伤害并全队攻速+35%。",
		"skill_detail": "消耗90能量，以神速化身流星撞穿敌阵整排，并在落点引爆巨型大字烈火，造成540点范围伤害，全队攻速提升35%持续4秒。",
		"skill_power": 540,
		"skills": {
			1: {"name": "神速炎撞", "desc": "神速冲锋撞穿敌阵造成540点穿透伤害。", "detail": "消耗90能量，神速突刺造成540点伤害并提升自身35%攻速。", "power": 540, "vfx": "flame_wheel", "sfx": "fire", "scale": 0.46},
			2: {"name": "闪焰冲锋·神犬降世", "desc": "全身爆燃金红天火冲撞全场，造成820点伤害并使敌人恐惧1.5秒。", "detail": "消耗90能量，化作烈火巨兽践踏全场，造成820点伤害并咆哮使周围敌军恐惧1.5秒。", "power": 820, "vfx": "flare_blitz", "sfx": "fire", "scale": 0.58},
			3: {"name": "太古神犬·天威梵天烈焰劫", "desc": "神圣烈焰火雨洗地，造成1300点毁灭真实伤害并永久灼烧全屏。", "detail": "消耗90能量，咆哮唤醒太古烈阳圣火，焚尽一切邪恶，对全场所有敌人造成1300点毁灭真实伤害并附加永久神圣灼烧！", "power": 1300, "vfx": "blast_burn", "sfx": "fire", "scale": 0.72}
		},
		"visual": {"primary": (235, 125, 45), "secondary": (245, 235, 200), "accent": (40, 40, 40), "eye": (30, 30, 30), "archetype": "quadruped", "features": ["ears", "tail"]}
	},
	"poliwag": {
		"num": 60, "id": "poliwag", "name": "蚊香蝌蚪", "title": "蝌蚪宝可梦", "cost": 1,
		"types": ["Water"], "hp": 540, "atk": 46, "armor": 25, "mr": 25, "range": 2, "atk_speed": 0.72, "max_mana": 80,
		"desc": "腹部拥有清晰可见的同心圆旋涡花纹，皮肤湿润光滑，尾鳍极其柔软，在急流中能像螺旋桨一样飞速前进。",
		"skill_name": "泡沫光线", "skill_desc": "喷射大量高压水泡泡，造成160点伤害并降低目标25%攻速。",
		"skill_detail": "消耗80能量，从口中连续喷射出大量透明水泡泡轰击目标，造成160点水系法术伤害并降低其25%攻击速度持续3秒。",
		"skill_power": 160,
		"skills": {
			1: {"name": "泡沫光线", "desc": "喷射水泡造成160点伤害并减速25%。", "detail": "消耗80能量，吐出泡沫造成160点伤害并降低25%攻速。", "power": 160, "vfx": "water_gun", "sfx": "water", "scale": 0.32},
			2: {"name": "催眠旋涡·潮涌击", "desc": "腹部旋涡旋转催眠目标1.5秒，并喷出水炮造成320点伤害。", "detail": "消耗80能量，腹部螺旋花纹高速旋转催眠目标1.5秒，随后喷发高压水柱造成320点伤害。", "power": 320, "vfx": "hydro_pump", "sfx": "water", "scale": 0.40},
			3: {"name": "逆鳞水瀑·太极旋涡连打", "desc": "召唤太极水龙卷吞噬整排敌人，造成640点伤害并击飞1.5秒。", "detail": "消耗80能量，引动太极阴阳水系灵力卷起参天大龙卷风，对整排所有敌人造成640点真实伤害并强制击飞！", "power": 640, "vfx": "hydro_cannon", "sfx": "water", "scale": 0.54}
		},
		"visual": {"primary": (70, 130, 215), "secondary": (240, 240, 245), "accent": (30, 30, 30), "eye": (20, 20, 20), "archetype": "orb", "features": ["tail"]}
	}
}
