extends Panel
class_name TeamCompPlanner

## TeamCompPlanner: Strategic Team Composition Guide & Target Assistant
## Allows players to select recommended Pokemon lineups (Deep Sea, Blazing Sun, Thunder Overload, Sandstorm Wall).
## When a lineup is selected, matching cards in the shop illuminate with a golden star banner.

@onready var close_btn: Button = $Dialog/Header/CloseBtn
@onready var comp_list: VBoxContainer = $Dialog/Scroll/CompList
@onready var current_status_lbl: Label = $Dialog/Header/StatusLabel

const PRESET_COMPS: Array[Dictionary] = [
	{
		"id": "deep_sea",
		"name": "🌊 深海风暴流",
		"desc": "以水系为核召唤倾盆大雨，雨中每秒持续回血，配合电龙狂暴输出！",
		"synergies": ["6 水", "3 雨天", "2 龙"],
		"units": ["squirtle", "gyarados", "dragonite", "pikachu"],
		"color": Color(0.3, 0.65, 1.0)
	},
	{
		"id": "blazing_sun",
		"name": "🔥 烈焰狂潮流",
		"desc": "大晴天火系伤害 +35%，全屏真伤灼烧，猛火攻速爆发熔化一切！",
		"synergies": ["6 火", "3 晴天", "2 龙"],
		"units": ["charmander", "charizard", "dragonite"],
		"color": Color(1.0, 0.45, 0.2)
	},
	{
		"id": "thunder_overload",
		"name": "⚡ 雷霆超载流",
		"desc": "电气场地免控，高额攻速与暴击，念力风暴压迫敌军法力！",
		"synergies": ["4 电", "4 超能"],
		"units": ["pikachu", "alakazam", "mewtwo"],
		"color": Color(1.0, 0.85, 0.2)
	},
	{
		"id": "sandstorm_fortress",
		"name": "🛡️ 沙暴铁壁流",
		"desc": "黄沙漫天双抗 +40%，非岩地单位持续流血，厚脂肪前排坚不可摧！",
		"synergies": ["4 岩石", "4 地面", "2 一般"],
		"units": ["snorlax", "machop"],
		"color": Color(0.85, 0.72, 0.4)
	},
	{
		"id": "grassy_sanctuary",
		"name": "🌿 青草自然盟",
		"desc": "青草场地每秒群体回血，高额法术吸血与群体缠绕控制！",
		"synergies": ["6 草", "3 毒"],
		"units": ["bulbasaur", "gengar"],
		"color": Color(0.4, 0.85, 0.35)
	},
	{
		"id": "phantom_underworld",
		"name": "👻 幽魂死神流",
		"desc": "高闪避幽灵漫步，诅咒之躯缴械敌方核心，全屏念力斩杀！",
		"synergies": ["4 幽灵", "4 超能"],
		"units": ["gengar", "mewtwo", "alakazam"],
		"color": Color(0.65, 0.4, 0.9)
	}
]

func _ready() -> void:
	visible = false
	if close_btn:
		close_btn.pressed.connect(close)
	_populate_comps()

func open_modal() -> void:
	_populate_comps()
	visible = true
	modulate.a = 0.0
	var tw = create_tween()
	tw.tween_property(self, "modulate:a", 1.0, 0.18)
	AudioManager.play_sfx("click")

func open() -> void:
	open_modal()

func close() -> void:
	visible = false
	modulate.a = 1.0

func _populate_comps() -> void:
	if comp_list == null:
		return
	for c in comp_list.get_children():
		c.queue_free()
		
	var active_comp_id = GameManager.target_team_comp.get("id", "")
	
	for comp in PRESET_COMPS:
		var card = _create_comp_card(comp, comp["id"] == active_comp_id)
		comp_list.add_child(card)
		
	if active_comp_id != "":
		current_status_lbl.text = "当前追踪: 【%s】 (商店将高亮对应棋子)" % GameManager.target_team_comp.get("name", "")
		current_status_lbl.modulate = Color(1.0, 0.9, 0.3)
	else:
		current_status_lbl.text = "暂未设置目标阵容 (点击下方流派设为目标)"
		current_status_lbl.modulate = Color(0.7, 0.75, 0.85)

func _create_comp_card(comp: Dictionary, is_active: bool) -> PanelContainer:
	var pc = PanelContainer.new()
	var style = StyleBoxFlat.new()
	style.bg_color = Color(0.1, 0.12, 0.18, 0.95)
	style.border_color = Color(1.0, 0.85, 0.3) if is_active else Color(0.25, 0.35, 0.5, 0.8)
	style.set_border_width_all(2 if is_active else 1)
	style.set_corner_radius_all(6)
	style.content_margin_left = 12
	style.content_margin_top = 8
	style.content_margin_right = 12
	style.content_margin_bottom = 8
	pc.add_theme_stylebox_override("panel", style)
	
	var vbox = VBoxContainer.new()
	vbox.add_theme_constant_override("separation", 5)
	pc.add_child(vbox)
	
	# Header Row (Name + Button)
	var header = HBoxContainer.new()
	vbox.add_child(header)
	
	var name_lbl = Label.new()
	name_lbl.text = comp["name"]
	name_lbl.add_theme_font_size_override("font_size", 14)
	name_lbl.add_theme_color_override("font_color", comp["color"])
	header.add_child(name_lbl)
	
	# Synergies
	for syn in comp.get("synergies", []):
		var pill = PanelContainer.new()
		var p_style = StyleBoxFlat.new()
		p_style.bg_color = Color(0.18, 0.22, 0.32, 0.9)
		p_style.set_corner_radius_all(4)
		p_style.content_margin_left = 6
		p_style.content_margin_right = 6
		pill.add_theme_stylebox_override("panel", p_style)
		var p_lbl = Label.new()
		p_lbl.text = syn
		p_lbl.add_theme_font_size_override("font_size", 10)
		pill.add_child(p_lbl)
		header.add_child(pill)
		
	var spacer = Control.new()
	spacer.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	header.add_child(spacer)
	
	var select_btn = Button.new()
	select_btn.custom_minimum_size = Vector2(100, 26)
	select_btn.add_theme_font_size_override("font_size", 11)
	if is_active:
		select_btn.text = "✓ 追踪中"
		select_btn.disabled = true
	else:
		select_btn.text = "⭐ 设为目标"
		var c_data = comp
		select_btn.pressed.connect(func(): _select_comp(c_data))
	header.add_child(select_btn)
	
	# Units Row
	var units_hbox = HBoxContainer.new()
	units_hbox.add_theme_constant_override("separation", 6)
	vbox.add_child(units_hbox)
	
	var core_lbl = Label.new()
	core_lbl.text = "核心棋子: "
	core_lbl.add_theme_font_size_override("font_size", 11)
	core_lbl.add_theme_color_override("font_color", Color(0.7, 0.75, 0.85))
	units_hbox.add_child(core_lbl)
	
	for pid in comp.get("units", []):
		var p_data = PokemonDatabase.get_pokemon(pid) if PokemonDatabase else {}
		var u_lbl = Label.new()
		u_lbl.text = "【%s】" % p_data.get("name", pid)
		u_lbl.add_theme_font_size_override("font_size", 11)
		u_lbl.add_theme_color_override("font_color", Color(0.9, 0.95, 1.0))
		units_hbox.add_child(u_lbl)
		
	# Description
	var desc_lbl = Label.new()
	desc_lbl.text = comp.get("desc", "")
	desc_lbl.add_theme_font_size_override("font_size", 10)
	desc_lbl.add_theme_color_override("font_color", Color(0.65, 0.72, 0.8))
	vbox.add_child(desc_lbl)
	
	return pc

func _select_comp(comp_data: Dictionary) -> void:
	AudioManager.play_sfx("buy")
	GameManager.set_target_team_comp(comp_data)
	_populate_comps()
