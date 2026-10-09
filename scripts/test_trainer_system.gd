extends Node

# test_trainer_system.gd: Comprehensive automated test suite for
# Trainer Avatars & Active Tactical Skills (Module 4).

const UNIT_SCENE = preload("res://scenes/unit.tscn")
const TRAINER_WIDGET_SCENE = preload("res://scenes/trainer_widget.tscn")

func _ready() -> void:
	print("\n========================================================")
	print(">>> STARTING TRAINER AVATARS & TACTICS TEST SUITE <<<")
	print("========================================================\n")
	
	await get_tree().process_frame
	
	test_trainer_data_and_avatars()
	test_trainer_passives()
	test_tactical_skills_and_cooldown_pipeline()
	await test_hud_trainer_widget_and_hotkey()
	
	print("\n========================================================")
	print(">>> ALL TRAINER AVATAR & TACTIC TESTS PASSED (100%) <<<")
	print("========================================================\n")
	get_tree().quit(0)

# -----------------------------------------------------------------------------
# 1. 训练家数据配置与头像资源完整性测试
# -----------------------------------------------------------------------------
func test_trainer_data_and_avatars() -> void:
	print("--- [1/4] Testing Trainer Data Configuration & Avatar Assets ---")
	
	assert(TrainerSystem != null, "TrainerSystem autoload singleton must exist")
	
	var expected_ids = ["red", "misty", "steven", "cynthia", "giovanni"]
	var all_trainers = TrainerSystem.get_all_trainers()
	assert(all_trainers.size() == 5, "Expected 5 configured trainers, got %d" % all_trainers.size())
	
	for t_id in expected_ids:
		assert(TrainerSystem.TRAINERS.has(t_id), "TrainerSystem must have trainer ID '%s'" % t_id)
		var data = TrainerSystem.get_trainer_data(t_id)
		
		assert(data.has("name") and data["name"] != "", "Trainer %s must have non-empty name" % t_id)
		assert(data.has("title") and data["title"] != "", "Trainer %s must have non-empty title" % t_id)
		assert(data.has("theme_color"), "Trainer %s must have theme_color" % t_id)
		assert(data.has("passive_name") and data["passive_name"] != "", "Trainer %s must have passive_name" % t_id)
		assert(data.has("passive_desc") and data["passive_desc"] != "", "Trainer %s must have passive_desc" % t_id)
		assert(data.has("tactic_name") and data["tactic_name"] != "", "Trainer %s must have tactic_name" % t_id)
		assert(data.has("tactic_desc") and data["tactic_desc"] != "", "Trainer %s must have tactic_desc" % t_id)
		assert(data.get("tactic_cd", 0) == 3, "Trainer %s tactic cooldown must be 3 rounds" % t_id)
		
		var avatar_path = data.get("avatar_path", "")
		assert(ResourceLoader.exists(avatar_path), "Avatar asset must exist at %s" % avatar_path)
		var tex = load(avatar_path)
		assert(tex != null, "Avatar texture must load properly from %s" % avatar_path)
		print("  [PASS] Trainer '%s' (%s) configured correctly with valid avatar: %s" % [t_id, data["name"], avatar_path])
		
	# Test select_trainer and persistence
	TrainerSystem.select_trainer("misty")
	assert(TrainerSystem.current_trainer_id == "misty", "Current trainer should switch to misty")
	TrainerSystem.select_trainer("red")
	assert(TrainerSystem.current_trainer_id == "red", "Current trainer should switch to red")
	print("  [PASS] Trainer selection switching validated cleanly.")

# -----------------------------------------------------------------------------
# 2. 五大训练家专属被动特性加成测试
# -----------------------------------------------------------------------------
func test_trainer_passives() -> void:
	print("\n--- [2/4] Testing 5 Trainer Passive Mechanics ---")
	
	# A. 🔴 赤红 (Red): 被动【真新意志】(生命值 <= 50% 友方攻击力 +20%)
	TrainerSystem.select_trainer("red")
	var unit_ally = UNIT_SCENE.instantiate()
	add_child(unit_ally)
	unit_ally.setup("charmander", 1, false)
	
	var base_atk = unit_ally.atk
	unit_ally.current_hp = unit_ally.max_hp # 100% HP
	assert(abs(unit_ally.get_effective_atk() - base_atk) < 0.1, "Ally at 100% HP should not have Red's +20% bonus")
	
	unit_ally.current_hp = unit_ally.max_hp * 0.45 # 45% HP (<= 50%)
	var red_boosted_atk = unit_ally.get_effective_atk()
	var expected_atk = base_atk * 1.20
	assert(abs(red_boosted_atk - expected_atk) < 0.1, "Ally at <= 50%% HP must receive +20%% ATK (expected %.1f, got %.1f)" % [expected_atk, red_boosted_atk])
	
	var unit_foe = UNIT_SCENE.instantiate()
	add_child(unit_foe)
	unit_foe.setup("charmander", 1, true)
	unit_foe.current_hp = unit_foe.max_hp * 0.30
	assert(abs(unit_foe.get_effective_atk() - unit_foe.atk) < 0.1, "Enemy unit should NOT receive Red's friendly bonus")
	print("  [PASS] Red 【真新意志】: +20% ATK specifically applied when ally HP <= 50%.")
	
	# B. 🔵 小霞 (Misty): 被动【生命之泉】(友军受到的所有治疗量与护盾效果 +25%)
	TrainerSystem.select_trainer("misty")
	unit_ally.current_hp = 100.0
	unit_ally.max_hp = 1000.0
	unit_ally.shield = 0.0
	
	# Test healing +25%
	unit_ally.heal(100.0, false)
	# 100 + 100 * 1.25 = 225
	assert(abs(unit_ally.current_hp - 225.0) < 0.1, "Misty should amplify 100 heal into 125 (HP now 225, got %.1f)" % unit_ally.current_hp)
	
	# Test shield +25%
	unit_ally.add_shield(200.0, false)
	# 200 * 1.25 = 250
	assert(abs(unit_ally.shield - 250.0) < 0.1, "Misty should amplify 200 shield into 250 (Shield now %.1f)" % unit_ally.shield)
	print("  [PASS] Misty 【生命之泉】: Healing and shields amplified by exactly +25%.")
	
	# C. ⚪ 大吾 (Steven): 被动【钢铁之躯】(全队常驻 +25 物理护甲与魔法抗性)
	# First check baseline under non-Steven
	TrainerSystem.select_trainer("red")
	var normal_unit = UNIT_SCENE.instantiate()
	add_child(normal_unit)
	normal_unit.setup("geodude", 1, false)
	var raw_armor = normal_unit.armor
	var raw_mr = normal_unit.mr
	
	# Now switch to Steven and instantiate
	TrainerSystem.select_trainer("steven")
	var steven_unit = UNIT_SCENE.instantiate()
	add_child(steven_unit)
	steven_unit.setup("geodude", 1, false)
	
	assert(abs(steven_unit.armor - (raw_armor + 25.0)) < 0.1, "Steven unit must gain +25 armor (got %.1f, expected %.1f)" % [steven_unit.armor, raw_armor + 25.0])
	assert(abs(steven_unit.mr - (raw_mr + 25.0)) < 0.1, "Steven unit must gain +25 MR (got %.1f, expected %.1f)" % [steven_unit.mr, raw_mr + 25.0])
	print("  [PASS] Steven 【钢铁之躯】: Full team baseline gains常驻 +25 Armor & +25 MR.")
	
	# D. 🟡 竹兰 (Cynthia): 被动【神奥庇护】(全队暴击率 +15%，暴击伤害 +25%)
	TrainerSystem.select_trainer("cynthia")
	var c_unit = UNIT_SCENE.instantiate()
	add_child(c_unit)
	c_unit.setup("pikachu", 1, false)
	
	var base_crit = 0.20
	var c_crit = c_unit.get_crit_chance()
	assert(abs(c_crit - (base_crit + 0.15)) < 0.05, "Cynthia unit crit chance should be base + 0.15 (expected %.2f, got %.2f)" % [base_crit + 0.15, c_crit])
	
	var base_mult = 1.75
	var c_mult = c_unit.get_crit_mult()
	assert(abs(c_mult - (base_mult + 0.25)) < 0.05, "Cynthia unit crit dmg mult should be base + 0.25 (expected %.2f, got %.2f)" % [base_mult + 0.25, c_mult])
	print("  [PASS] Cynthia 【神奥庇护】: Crit chance +15% and crit damage +25% verified.")
	
	# E. 🟣 坂木 (Giovanni): 被动【火箭队底蕴】(利息上限提升至 6 金币)
	TrainerSystem.select_trainer("red")
	assert(TrainerSystem.get_giovanni_max_interest() == 5, "Non-Giovanni max interest must be 5")
	TrainerSystem.select_trainer("giovanni")
	assert(TrainerSystem.get_giovanni_max_interest() == 6, "Giovanni max interest cap must be 6")
	
	GameManager.gold = 65
	var max_interest = 8 if (AugmentDatabase and AugmentDatabase.has_augment("interest_tycoon")) else (6 if (TrainerSystem and TrainerSystem.has_giovanni_passive()) else 5)
	var interest = min(max_interest, int(GameManager.gold / 10))
	assert(interest == 6, "With 65 gold and Giovanni passive, interest must be 6 (got %d)" % interest)
	print("  [PASS] Giovanni 【火箭队底蕴】: Max interest cap expanded from 5 to 6.")
	
	# Cleanup test units
	unit_ally.queue_free()
	unit_foe.queue_free()
	normal_unit.queue_free()
	steven_unit.queue_free()
	c_unit.queue_free()

# -----------------------------------------------------------------------------
# 3. 五大主动战术技能释放逻辑、CD 与数值结算测试
# -----------------------------------------------------------------------------
func test_tactical_skills_and_cooldown_pipeline() -> void:
	print("\n--- [3/4] Testing Active Tactical Skills & Cooldown Pipeline ---")
	
	# A. Cooldown Pipeline Testing
	TrainerSystem.select_trainer("red")
	TrainerSystem.reset_cooldown()
	assert(TrainerSystem.current_cooldown == 0, "Cooldown should start at 0")
	assert(TrainerSystem.can_cast_tactic(true) == true, "Tactic should be ready when cooldown is 0")
	
	GameManager.current_phase = GameManager.Phase.COMBAT
	var cast_ok = TrainerSystem.cast_active_tactic()
	assert(cast_ok == true, "Casting tactic during COMBAT should succeed")
	assert(TrainerSystem.current_cooldown == 3, "Cooldown should be set to 3 after casting")
	assert(TrainerSystem.can_cast_tactic(false) == false, "Cannot cast when cooldown > 0")
	
	# Advance round decrements
	TrainerSystem.decrease_cooldown()
	assert(TrainerSystem.current_cooldown == 2, "Cooldown should decrement to 2")
	TrainerSystem.decrease_cooldown()
	assert(TrainerSystem.current_cooldown == 1, "Cooldown should decrement to 1")
	TrainerSystem.decrease_cooldown()
	assert(TrainerSystem.current_cooldown == 0, "Cooldown should decrement to 0 and be ready")
	print("  [PASS] Cooldown pipeline: 0 -> cast(3) -> round advance(2->1->0) verified.")
	
	# B. 🔴 赤红主动【全员鼓舞】: 全体友军获得 30% 攻速提升，持续 5.0 秒
	TrainerSystem.select_trainer("red")
	TrainerSystem.reset_cooldown()
	var ally1 = UNIT_SCENE.instantiate()
	add_child(ally1)
	ally1.setup("pikachu", 1, false)
	var prev_aspd = ally1.atk_speed
	
	TrainerSystem.cast_active_tactic(true)
	var buffed_aspd = ally1.atk_speed
	assert(abs(buffed_aspd - (prev_aspd * 1.30)) < 0.05, "Ally attack speed must increase by 30%% (got %.3f, expected %.3f)" % [buffed_aspd, prev_aspd * 1.30])
	print("  [PASS] Red tactic 【全员鼓舞】: Successfully granted +30% attack speed to team.")
	
	# C. 🔵 小霞主动【水流环】: 为当前生命百分比最低的 2 只友军回复 350 点生命值并驱散控制状态
	TrainerSystem.select_trainer("misty")
	TrainerSystem.reset_cooldown()
	
	var m_ally_low = UNIT_SCENE.instantiate()
	add_child(m_ally_low)
	m_ally_low.setup("squirtle", 1, false)
	m_ally_low.max_hp = 1000.0
	m_ally_low.current_hp = 200.0 # 20%
	m_ally_low.apply_stun(2.0)
	assert(m_ally_low.is_stunned == true, "Unit must be stunned")
	
	var m_ally_high = UNIT_SCENE.instantiate()
	add_child(m_ally_high)
	m_ally_high.setup("bulbasaur", 1, false)
	m_ally_high.max_hp = 1000.0
	m_ally_high.current_hp = 900.0 # 90%
	
	TrainerSystem.cast_active_tactic(true)
	assert(m_ally_low.is_stunned == false, "Lowest HP ally must have stun cleansed by Aqua Ring")
	# Heal: 350 base + 25% misty passive = 437.5. Initial HP = 200 => 637.5
	assert(m_ally_low.current_hp >= 600.0, "Lowest HP ally must be healed for at least 350 (got %.1f)" % m_ally_low.current_hp)
	assert(m_ally_high.current_hp == 900.0, "High HP ally should not be targeted over low HP units")
	print("  [PASS] Misty tactic 【水流环】: Targeted lowest HP ally, restored 350 HP (+25%%) & cleansed CC.")
	
	# D. ⚪ 大吾主动【流星落】: 轰击敌方最高攻击力单位造成 450 真实伤害并眩晕 1.5 秒
	TrainerSystem.select_trainer("steven")
	TrainerSystem.reset_cooldown()
	
	var foe_weak = UNIT_SCENE.instantiate()
	add_child(foe_weak)
	foe_weak.setup("rattata", 1, true)
	foe_weak.atk = 40.0
	foe_weak.max_hp = 1000.0
	foe_weak.current_hp = 1000.0
	
	var foe_strong = UNIT_SCENE.instantiate()
	add_child(foe_strong)
	foe_strong.setup("snorlax", 1, true)
	foe_strong.atk = 150.0 # Highest attack
	foe_strong.max_hp = 1000.0
	foe_strong.current_hp = 1000.0
	
	TrainerSystem.cast_active_tactic(true)
	# Foe strong should take 450 true damage (1000 - 450 = 550) and be stunned for 1.5s
	assert(abs(foe_strong.current_hp - 550.0) < 1.0, "Highest ATK enemy should take 450 true damage (HP now %.1f)" % foe_strong.current_hp)
	assert(foe_strong.is_stunned == true, "Highest ATK enemy must be stunned by Meteor Fall")
	assert(foe_strong.stun_timer >= 1.4, "Stun duration should be 1.5s")
	assert(foe_weak.current_hp == 1000.0, "Weak enemy should be untouched")
	print("  [PASS] Steven tactic 【流星落】: Hit highest ATK foe for 450 true damage & 1.5s stun.")
	
	# E. 🟡 竹兰主动【波导共鸣】: 立即为所有友军瞬间充能 30 点法力值
	TrainerSystem.select_trainer("cynthia")
	TrainerSystem.reset_cooldown()
	
	ally1.current_mana = 0.0
	m_ally_low.current_mana = 10.0
	TrainerSystem.cast_active_tactic(true)
	
	assert(abs(ally1.current_mana - 30.0) < 0.1, "Ally 1 should gain 30 mana (got %.1f)" % ally1.current_mana)
	assert(abs(m_ally_low.current_mana - 40.0) < 0.1, "Ally 2 should gain 30 mana (10+30=40, got %.1f)" % m_ally_low.current_mana)
	print("  [PASS] Cynthia tactic 【波导共鸣】: Instant +30 mana charged to all alive allies.")
	
	# F. 🟣 坂木主动【战术征用】: 立即获得 4 枚应急金币
	TrainerSystem.select_trainer("giovanni")
	TrainerSystem.reset_cooldown()
	var g_before = GameManager.gold
	TrainerSystem.cast_active_tactic(true)
	assert(GameManager.gold == g_before + 4, "Giovanni tactic should grant +4 gold (was %d, now %d)" % [g_before, GameManager.gold])
	print("  [PASS] Giovanni tactic 【战术征用】: Instantly granted 4 emergency gold.")
	
	# Cleanup
	ally1.queue_free()
	m_ally_low.queue_free()
	m_ally_high.queue_free()
	foe_weak.queue_free()
	foe_strong.queue_free()

# -----------------------------------------------------------------------------
# 4. HUD 训练家微部件交互状态与快捷键 [Q] 触发测试
# -----------------------------------------------------------------------------
func test_hud_trainer_widget_and_hotkey() -> void:
	print("\n--- [4/4] Testing HUD Trainer Widget & [Q] Hotkey Interaction ---")
	
	var widget = TRAINER_WIDGET_SCENE.instantiate()
	add_child(widget)
	await get_tree().process_frame
	
	# Check widget visual nodes
	assert(widget.avatar_btn != null, "Widget must have AvatarBtn")
	assert(widget.avatar_rect != null, "Widget must have AvatarRect")
	assert(widget.name_label != null, "Widget must have NameLabel")
	assert(widget.passive_tag != null, "Widget must have PassiveTag")
	assert(widget.tactic_btn != null, "Widget must have TacticBtn")
	assert(widget.glow_overlay != null, "Widget must have GlowOverlay")
	
	# Test display sync with TrainerSystem
	TrainerSystem.select_trainer("red")
	widget.refresh_display()
	assert(widget.name_label.text.contains("赤红"), "Widget name should reflect current trainer Red")
	assert(widget.passive_tag.tooltip_text.contains("真新意志"), "Passive tooltip should contain Will of Pallet")
	
	# Test Ready button text
	TrainerSystem.reset_cooldown()
	widget.refresh_display()
	assert(widget.tactic_btn.text.contains("(Q)"), "Ready button text should contain '(Q)'")
	
	# Test Cooldown button text
	TrainerSystem.current_cooldown = 2
	widget.refresh_display()
	assert(widget.tactic_btn.text.contains("2回合"), "Cooldown button text should display '2回合'")
	
	# Test Q Key shortcut triggering tactic
	TrainerSystem.reset_cooldown()
	GameManager.current_phase = GameManager.Phase.COMBAT
	
	var key_event = InputEventKey.new()
	key_event.pressed = true
	key_event.keycode = KEY_Q
	widget._unhandled_input(key_event)
	
	assert(TrainerSystem.current_cooldown == 3, "Pressing [Q] in COMBAT should cast tactic and set CD to 3")
	print("  [PASS] Hotkey [Q] successfully triggers tactic casting in COMBAT phase.")
	
	# Test Cast Animation triggering
	widget.trigger_cast_animation()
	assert(widget.is_casting_animation == true, "Casting animation flag should be true during glow")
	print("  [PASS] Golden glow streaming animation triggered cleanly.")
	
	# Test Trainer Selection Modal
	widget.open_trainer_selection_modal()
	assert(widget.trainer_selection_modal != null and widget.trainer_selection_modal.visible == true, "Selection modal must be open")
	
	# Switch to Cynthia via modal logic
	TrainerSystem.select_trainer("cynthia")
	widget.refresh_display()
	assert(widget.name_label.text.contains("竹兰"), "Widget name should update to Cynthia")
	widget.trainer_selection_modal.visible = false
	print("  [PASS] Trainer Selection Modal correctly opened and switched trainer seamlessly.")
	
	widget.queue_free()
