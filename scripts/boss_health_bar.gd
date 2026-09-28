extends PanelContainer
class_name BossHealthBar

# BossHealthBar: Epic, prominent top-screen boss encounter bar
# Width ~500px, gold frame, skull/crown icon, phase/enrage indicator, dual-layer damage meter.

signal boss_enraged()
signal boss_defeated()

@onready var crown_icon: Label = $Margin/VBox/HeaderRow/CrownIcon
@onready var boss_name_label: Label = $Margin/VBox/HeaderRow/BossNameLabel
@onready var phase_label: Label = $Margin/VBox/HeaderRow/PhaseIndicator/PhaseLabel
@onready var phase_indicator_panel: PanelContainer = $Margin/VBox/HeaderRow/PhaseIndicator
@onready var damage_bar: ProgressBar = $Margin/VBox/BarContainer/DamageBar
@onready var hp_bar: ProgressBar = $Margin/VBox/BarContainer/HPBar
@onready var hp_text_label: Label = $Margin/VBox/BarContainer/HPTextLabel

var boss_ref: WeakRef = null
var current_phase: int = 1
var is_enraged: bool = false
var enrage_threshold: float = 0.50
var is_active: bool = false
var _enrage_pulse_time: float = 0.0

func _ready() -> void:
	visible = false

# Starts tracking a boss Unit
func track_boss(boss_unit: Unit) -> void:
	if not is_instance_valid(boss_unit):
		return
		
	boss_ref = weakref(boss_unit)
	is_active = true
	current_phase = 1
	is_enraged = false
	_enrage_pulse_time = 0.0
	
	# Determine Boss display name & icon
	var p_id = boss_unit.pokemon_id if "pokemon_id" in boss_unit else ""
	var p_name = p_id
	if PokemonDatabase:
		var p_data = PokemonDatabase.get_pokemon(p_id)
		p_name = p_data.get("name", p_id)
		
	var star_count = boss_unit.star_level if "star_level" in boss_unit else 3
	var star_str = ""
	for i in range(star_count):
		star_str += "★"
		
	if boss_name_label:
		boss_name_label.text = "👑 [首领 BOSS] %s %s" % [p_name, star_str]
		
	if crown_icon:
		crown_icon.text = "👑"
		crown_icon.modulate = Color(1.0, 0.85, 0.2)
		
	# Phase 1 Initial Status
	_set_phase_display(1, false)
	
	# Setup HP Bars
	var max_h = boss_unit.max_hp
	var curr_h = boss_unit.current_hp
	
	if hp_bar:
		hp_bar.max_value = max_h
		hp_bar.value = curr_h
	if damage_bar:
		damage_bar.max_value = max_h
		damage_bar.value = curr_h
		
	_update_hp_text(curr_h, max_h, boss_unit.shield)
	
	# Connect to unit_died
	if boss_unit.has_signal("unit_died"):
		if not boss_unit.unit_died.is_connected(_on_boss_unit_died):
			boss_unit.unit_died.connect(_on_boss_unit_died)
			
	# Dramatic Entrance Animation
	visible = true
	modulate.a = 0.0
	position.y = -70.0
	
	var tw = create_tween().set_parallel(true)
	tw.tween_property(self, "position:y", 10.0, 0.35).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tw.tween_property(self, "modulate:a", 1.0, 0.25).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	if AudioManager:
		AudioManager.play_sfx("round_start")

# Hides the boss health bar
func hide_bar() -> void:
	if not visible:
		return
	is_active = false
	boss_ref = null
	
	var tw = create_tween().set_parallel(true)
	tw.tween_property(self, "position:y", -70.0, 0.25).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	tw.tween_property(self, "modulate:a", 0.0, 0.25)
	await tw.finished
	visible = false
	modulate.a = 1.0

func _process(delta: float) -> void:
	if not is_active or boss_ref == null:
		return
		
	var boss = boss_ref.get_ref() as Unit
	if not is_instance_valid(boss):
		_handle_boss_vanished()
		return
		
	if boss.is_dead:
		_handle_boss_defeated()
		return
		
	var curr_hp = boss.current_hp
	var max_hp = boss.max_hp
	var shield_val = boss.shield if "shield" in boss else 0.0
	
	# Check Enrage Transition (Phase 2 at <= 50% HP)
	if curr_hp <= max_hp * enrage_threshold and not is_enraged:
		_trigger_enrage()
		
	# Update primary HP bar
	if hp_bar:
		hp_bar.max_value = max_hp
		hp_bar.value = curr_hp
		
	# Smoothly drain damage follower bar for visual impact
	if damage_bar:
		damage_bar.max_value = max_hp
		if damage_bar.value > curr_hp:
			damage_bar.value = move_toward(damage_bar.value, curr_hp, delta * max_hp * 0.45)
		else:
			damage_bar.value = curr_hp
			
	_update_hp_text(curr_hp, max_hp, shield_val)
	
	# Enraged Visual Pulse
	if is_enraged:
		_enrage_pulse_time += delta
		var pulse = (sin(_enrage_pulse_time * 6.0) + 1.0) * 0.5
		if phase_indicator_panel:
			phase_indicator_panel.modulate = Color(1.0, 0.4 + 0.4 * pulse, 0.4 + 0.4 * pulse)

func _trigger_enrage() -> void:
	is_enraged = true
	current_phase = 2
	boss_enraged.emit()
	
	if crown_icon:
		crown_icon.text = "💀"
		crown_icon.modulate = Color(1.0, 0.25, 0.25)
		
	_set_phase_display(2, true)
	
	# Screen flash / shake feedback
	var tw = create_tween()
	tw.tween_property(self, "scale", Vector2(1.06, 1.06), 0.1).set_trans(Tween.TRANS_QUAD)
	tw.tween_property(self, "scale", Vector2.ONE, 0.15).set_trans(Tween.TRANS_BOUNCE)
	
	if AudioManager:
		AudioManager.play_sfx("skill")

func _set_phase_display(phase: int, enraged: bool) -> void:
	if not phase_label:
		return
		
	if enraged or phase >= 2:
		phase_label.text = "🔥 阶段 2: 极巨狂暴 (ENRAGED)"
		phase_label.add_theme_color_override("font_color", Color(1.0, 0.3, 0.2))
		if phase_indicator_panel:
			var style = phase_indicator_panel.get_theme_stylebox("panel") as StyleBoxFlat
			if style:
				style.border_color = Color(1.0, 0.3, 0.2)
				style.bg_color = Color(0.35, 0.08, 0.08, 0.9)
	else:
		phase_label.text = "阶段 1: 精神压迫"
		phase_label.add_theme_color_override("font_color", Color(0.4, 0.85, 1.0))
		if phase_indicator_panel:
			var style = phase_indicator_panel.get_theme_stylebox("panel") as StyleBoxFlat
			if style:
				style.border_color = Color(0.3, 0.7, 1.0)
				style.bg_color = Color(0.08, 0.18, 0.28, 0.9)

func _update_hp_text(curr: float, max_h: float, shield_val: float) -> void:
	if not hp_text_label:
		return
	var pct = 0 if max_h <= 0 else int((curr / max_h) * 100.0)
	var text_content = "%s / %s (%d%%)" % [_format_num(curr), _format_num(max_h), pct]
	if shield_val > 0.0:
		text_content += " [+%s 护盾]" % _format_num(shield_val)
	hp_text_label.text = text_content

func _format_num(n: float) -> String:
	var val = int(max(0.0, n))
	if val >= 10000:
		return "%.1fw" % (float(val) / 10000.0)
	return str(val)

func _on_boss_unit_died(_unit: Unit) -> void:
	_handle_boss_defeated()

func _handle_boss_defeated() -> void:
	if not is_active:
		return
	is_active = false
	boss_defeated.emit()
	
	if boss_name_label:
		boss_name_label.text = "💀 [首领 BOSS] 已击溃 (DEFEATED)!"
		boss_name_label.modulate = Color(0.6, 0.6, 0.6)
	if crown_icon:
		crown_icon.text = "☠️"
	if phase_label:
		phase_label.text = "战局胜利"
		phase_label.modulate = Color(0.4, 1.0, 0.4)
	if hp_bar:
		hp_bar.value = 0
	if damage_bar:
		damage_bar.value = 0
	if hp_text_label:
		hp_text_label.text = "0 / %s (0%%)" % _format_num(hp_bar.max_value if hp_bar else 1000.0)
		
	# Fade out after brief pause
	var tw = create_tween()
	tw.tween_interval(1.8)
	tw.tween_property(self, "modulate:a", 0.0, 0.5)
	tw.tween_callback(func(): visible = false; boss_ref = null)

func _handle_boss_vanished() -> void:
	hide_bar()
