extends PanelContainer
class_name ItemBench

## ItemBench: 8-slot horizontal inventory bench for Pokemon Auto-Battler held items.
## Supports adding, removing, drag-and-drop, combining base components, and equipping to units.

signal item_added(slot_index: int, item_id: String)
signal item_removed(slot_index: int, item_id: String)
signal item_combined(slot_index: int, new_item_id: String)
signal item_equipped(item_id: String, unit: Node)
signal slot_selected(slot_index: int)

const MAX_SLOTS: int = 9

# Bench state: Array of 9 String item IDs ("" if empty) for 3x3 grid
var slots: Array[String] = ["", "", "", "", "", "", "", "", ""]
var selected_slot: int = -1
var current_hovered_slot: int = -1

# Node references
@onready var slots_container: Container = $MarginContainer/VBox/SlotsContainer
@onready var title_label: Label = $MarginContainer/VBox/Header/TitleLabel
@onready var count_label: Label = $MarginContainer/VBox/Header/CountLabel
@onready var tooltip_panel: PanelContainer = $TooltipPanel

# Slot UI references
var slot_buttons: Array[PanelContainer] = []
var slot_icons: Array[TextureRect] = []
var slot_highlights: Array[ReferenceRect] = []

# Styleboxes for slots
var slot_normal_style: StyleBoxFlat
var slot_hover_style: StyleBoxFlat
var slot_selected_style: StyleBoxFlat
var slot_highlight_style: StyleBoxFlat

func _ready() -> void:
	_init_styles()
	_setup_slots()
	_setup_tooltip()
	update_all_slots()

func _init_styles() -> void:
	slot_normal_style = StyleBoxFlat.new()
	slot_normal_style.bg_color = Color(0.10, 0.12, 0.17, 0.95)
	slot_normal_style.border_color = Color(0.24, 0.30, 0.42, 1.0)
	slot_normal_style.set_border_width_all(1)
	slot_normal_style.set_corner_radius_all(4)

	slot_hover_style = StyleBoxFlat.new()
	slot_hover_style.bg_color = Color(0.14, 0.18, 0.26, 0.98)
	slot_hover_style.border_color = Color(0.40, 0.65, 0.95, 1.0)
	slot_hover_style.set_border_width_all(2)
	slot_hover_style.set_corner_radius_all(4)

	slot_selected_style = StyleBoxFlat.new()
	slot_selected_style.bg_color = Color(0.18, 0.20, 0.28, 1.0)
	slot_selected_style.border_color = Color(1.0, 0.85, 0.25, 1.0)
	slot_selected_style.set_border_width_all(2)
	slot_selected_style.set_corner_radius_all(4)

func _setup_slots() -> void:
	slot_buttons.clear()
	slot_icons.clear()
	slot_highlights.clear()

	for i in range(MAX_SLOTS):
		var slot_node = slots_container.get_node_or_null("Slot%d" % i) as PanelContainer
		if slot_node == null:
			# Fallback: create dynamically if not present in tscn
			slot_node = _create_slot_node(i)
			slots_container.add_child(slot_node)

		slot_node.custom_minimum_size = Vector2(44, 44)
		slot_node.add_theme_stylebox_override("panel", slot_normal_style)

		# Make sure slot handles mouse input
		slot_node.mouse_filter = Control.MOUSE_FILTER_STOP
		var slot_idx = i
		slot_node.gui_input.connect(func(ev: InputEvent): _on_slot_gui_input(slot_idx, ev))
		slot_node.mouse_entered.connect(func(): _on_slot_mouse_entered(slot_idx))
		slot_node.mouse_exited.connect(func(): _on_slot_mouse_exited(slot_idx))

		# Item icon inside slot
		var icon_rect = slot_node.get_node_or_null("Icon") as TextureRect
		if icon_rect == null:
			icon_rect = TextureRect.new()
			icon_rect.name = "Icon"
			icon_rect.custom_minimum_size = Vector2(36, 36)
			icon_rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
			icon_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
			icon_rect.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
			icon_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
			slot_node.add_child(icon_rect)

		# Slot key label (1-9)
		var key_label = slot_node.get_node_or_null("KeyLabel") as Label
		if key_label == null:
			key_label = Label.new()
			key_label.name = "KeyLabel"
			key_label.text = str(i + 1)
			key_label.add_theme_font_size_override("font_size", 9)
			key_label.add_theme_color_override("font_color", Color(0.65, 0.70, 0.80, 0.6))
			key_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
			key_label.vertical_alignment = VERTICAL_ALIGNMENT_BOTTOM
			key_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
			slot_node.add_child(key_label)

		slot_buttons.append(slot_node)
		slot_icons.append(icon_rect)

func _create_slot_node(index: int) -> PanelContainer:
	var slot = PanelContainer.new()
	slot.name = "Slot%d" % index
	slot.custom_minimum_size = Vector2(44, 44)
	return slot

func _setup_tooltip() -> void:
	if tooltip_panel == null:
		tooltip_panel = PanelContainer.new()
		tooltip_panel.name = "TooltipPanel"
		add_child(tooltip_panel)
	tooltip_panel.top_level = true
	tooltip_panel.visible = false
	tooltip_panel.z_index = 50
	tooltip_panel.mouse_filter = Control.MOUSE_FILTER_IGNORE

# ==============================================================================
# PUBLIC API METHODS
# ==============================================================================

## Adds an item to the first empty bench slot. Returns true if added, false if bench is full.
func add_item(item_id: String) -> bool:
	if item_id == "":
		return false
	var db_item = ItemDatabase.get_item(item_id)
	if db_item.is_empty():
		push_error("ItemBench: Unknown item ID: %s" % item_id)
		return false

	for i in range(MAX_SLOTS):
		if slots[i] == "":
			slots[i] = item_id
			update_slot_visual(i)
			_update_count_label()
			item_added.emit(i, item_id)
			return true

	return false

## Removes the item at index. Returns the removed item_id, or "" if slot was empty/invalid.
func remove_item_at(index: int) -> String:
	if index < 0 or index >= MAX_SLOTS:
		return ""
	var removed = slots[index]
	if removed != "":
		slots[index] = ""
		if selected_slot == index:
			deselect_all()
		update_slot_visual(index)
		_update_count_label()
		item_removed.emit(index, removed)
	return removed

## Returns the item_id at index, or "" if empty.
func get_item_at(index: int) -> String:
	if index < 0 or index >= MAX_SLOTS:
		return ""
	return slots[index]

## Returns the number of empty slots on the bench.
func get_free_slot_count() -> int:
	var free_count = 0
	for it in slots:
		if it == "":
			free_count += 1
	return free_count

## Returns the number of occupied slots on the bench.
func get_occupied_slot_count() -> int:
	return MAX_SLOTS - get_free_slot_count()

func get_item_count() -> int:
	return get_occupied_slot_count()

func take_item_at(index: int) -> String:
	return remove_item_at(index)

## Combines two base components at slot_a and slot_b into an advanced item.
## The result is placed in slot_a, and slot_b is cleared. Returns true if combined.
func combine_slots(slot_a: int, slot_b: int) -> bool:
	if slot_a < 0 or slot_a >= MAX_SLOTS or slot_b < 0 or slot_b >= MAX_SLOTS:
		return false
	if slot_a == slot_b:
		return false
	var id_a = slots[slot_a]
	var id_b = slots[slot_b]
	if id_a == "" or id_b == "":
		return false

	var result_id = ItemDatabase.get_recipe(id_a, id_b)
	if result_id == "":
		return false

	# Successfully combined!
	slots[slot_a] = result_id
	slots[slot_b] = ""
	deselect_all()
	update_slot_visual(slot_a)
	update_slot_visual(slot_b)
	_update_count_label()
	item_combined.emit(slot_a, result_id)
	return true

## Equips the item in slot_index to a target unit.
## Removes the item from the bench if successfully equipped.
func equip_to_unit(slot_index: int, unit: Node) -> bool:
	if slot_index < 0 or slot_index >= MAX_SLOTS:
		return false
	var item_id = slots[slot_index]
	if item_id == "":
		return false
	if unit == null:
		return false

	if unit.has_method("equip_item"):
		var ok = unit.equip_item(item_id)
		if ok:
			remove_item_at(slot_index)
			item_equipped.emit(item_id, unit)
			return true

	return false

## Clears all slots on the bench.
func clear_all() -> void:
	for i in range(MAX_SLOTS):
		slots[i] = ""
	deselect_all()
	update_all_slots()

# ==============================================================================
# SELECTION & INTERACTION
# ==============================================================================

func select_slot(index: int) -> void:
	if index < 0 or index >= MAX_SLOTS:
		deselect_all()
		return
	if slots[index] == "":
		deselect_all()
		return

	# If another slot was already selected, attempt to combine or swap
	if selected_slot != -1 and selected_slot != index:
		var item_sel = slots[selected_slot]
		var item_tgt = slots[index]
		# Try combining if both are base items
		if ItemDatabase.is_base_item(item_sel) and ItemDatabase.is_base_item(item_tgt):
			var recipe = ItemDatabase.get_recipe(item_sel, item_tgt)
			if recipe != "":
				combine_slots(selected_slot, index)
				return
		# Otherwise swap slots
		var temp = slots[selected_slot]
		slots[selected_slot] = slots[index]
		slots[index] = temp
		var old_sel = selected_slot
		deselect_all()
		update_slot_visual(old_sel)
		update_slot_visual(index)
		return

	selected_slot = index
	_refresh_slot_borders()
	slot_selected.emit(index)

func deselect_all() -> void:
	selected_slot = -1
	_refresh_slot_borders()

func _on_slot_gui_input(index: int, event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if selected_slot == index:
				deselect_all()
			else:
				select_slot(index)
			accept_event()
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			deselect_all()
			accept_event()

func _on_slot_mouse_entered(index: int) -> void:
	current_hovered_slot = index
	if index >= 0 and index < MAX_SLOTS and slots[index] != "":
		_show_tooltip_for_item(slots[index], slot_buttons[index])
	else:
		_hide_tooltip()

func _on_slot_mouse_exited(index: int) -> void:
	if current_hovered_slot == index:
		current_hovered_slot = -1
		_hide_tooltip()

# ==============================================================================
# DRAG AND DROP
# ==============================================================================

func _get_drag_data_for_slot(index: int) -> Variant:
	if index < 0 or index >= MAX_SLOTS or slots[index] == "":
		return null
	var item_id = slots[index]
	var db_item = ItemDatabase.get_item(item_id)

	# Create drag preview
	var preview = TextureRect.new()
	preview.texture = load(db_item.get("icon_path", ""))
	preview.custom_minimum_size = Vector2(36, 36)
	preview.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	preview.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	preview.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	set_drag_preview(preview)

	return {
		"type": "held_item",
		"slot_index": index,
		"item_id": item_id
	}

func _can_drop_data_on_slot(_index: int, data: Variant) -> bool:
	if data is Dictionary and data.get("type") == "held_item":
		return true
	return false

func _drop_data_on_slot(target_index: int, data: Variant) -> void:
	if not _can_drop_data_on_slot(target_index, data):
		return
	var src_index = data.get("slot_index", -1)
	if src_index == target_index or src_index < 0:
		return

	var src_id = slots[src_index]
	var tgt_id = slots[target_index]

	# Try combining if both exist
	if tgt_id != "" and ItemDatabase.is_base_item(src_id) and ItemDatabase.is_base_item(tgt_id):
		var recipe = ItemDatabase.get_recipe(src_id, tgt_id)
		if recipe != "":
			combine_slots(src_index, target_index)
			return

	# Otherwise swap / move
	slots[src_index] = tgt_id
	slots[target_index] = src_id
	deselect_all()
	update_slot_visual(src_index)
	update_slot_visual(target_index)

# Forward drag and drop to slot container
func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return data is Dictionary and data.get("type") == "held_item"

func _drop_data(at_position: Vector2, data: Variant) -> void:
	# Find which slot was hovered
	for i in range(MAX_SLOTS):
		if slot_buttons[i].get_global_rect().has_point(get_global_mouse_position()):
			_drop_data_on_slot(i, data)
			return

# Handle external input to equip to clicked unit
func handle_unit_clicked(unit: Node) -> bool:
	if selected_slot != -1 and unit != null:
		var success = equip_to_unit(selected_slot, unit)
		if success:
			deselect_all()
		return success
	return false

# ==============================================================================
# VISUAL UPDATES & TOOLTIP
# ==============================================================================

func update_all_slots() -> void:
	for i in range(MAX_SLOTS):
		update_slot_visual(i)
	_update_count_label()
	_refresh_slot_borders()

func update_slot_visual(index: int) -> void:
	if index < 0 or index >= MAX_SLOTS:
		return
	var item_id = slots[index]
	var icon_rect = slot_icons[index]

	if item_id == "":
		icon_rect.texture = null
		icon_rect.visible = false
	else:
		var db_item = ItemDatabase.get_item(item_id)
		var icon_path = db_item.get("icon_path", "")
		if ResourceLoader.exists(icon_path):
			icon_rect.texture = load(icon_path)
			icon_rect.visible = true
		else:
			icon_rect.texture = null
			icon_rect.visible = false

func _refresh_slot_borders() -> void:
	for i in range(MAX_SLOTS):
		var slot_node = slot_buttons[i]
		if i == selected_slot:
			slot_node.add_theme_stylebox_override("panel", slot_selected_style)
		else:
			slot_node.add_theme_stylebox_override("panel", slot_normal_style)

func _update_count_label() -> void:
	if count_label:
		count_label.text = "(%d/%d)" % [get_occupied_slot_count(), MAX_SLOTS]

func _show_tooltip_for_item(item_id: String, anchor_node: Control) -> void:
	var item_data = ItemDatabase.get_item(item_id)
	if item_data.is_empty():
		_hide_tooltip()
		return

	# Build rich tooltip content
	_populate_tooltip(item_data)
	_set_mouse_filter_ignore_recursive(tooltip_panel)
	tooltip_panel.visible = true
	tooltip_panel.reset_size()

	# Position tooltip cleanly to the left of the 3x3 bench
	var slot_rect = anchor_node.get_global_rect()
	var bench_rect = get_global_rect()
	var tt_size = tooltip_panel.get_combined_minimum_size()
	var target_x = bench_rect.position.x - tt_size.x - 12.0
	if target_x < 10.0:
		target_x = bench_rect.position.x + bench_rect.size.x + 12.0
	var target_y = clampf(slot_rect.position.y - 20.0, 60.0, 720.0 - tt_size.y - 10.0)
	tooltip_panel.global_position = Vector2(target_x, target_y)

func _hide_tooltip() -> void:
	if tooltip_panel:
		tooltip_panel.visible = false

func _populate_tooltip(item_data: Dictionary) -> void:
	# Ensure internal container exists
	var vbox = tooltip_panel.get_node_or_null("VBox") as VBoxContainer
	if vbox == null:
		vbox = VBoxContainer.new()
		vbox.name = "VBox"
		vbox.add_theme_constant_override("separation", 4)
		tooltip_panel.add_child(vbox)

	# Clear previous contents synchronously
	for child in vbox.get_children():
		vbox.remove_child(child)
		child.queue_free()

	# Tooltip style
	var tt_style = StyleBoxFlat.new()
	tt_style.bg_color = Color(0.08, 0.10, 0.15, 0.98)
	tt_style.border_color = Color(0.35, 0.45, 0.65, 1.0)
	tt_style.set_border_width_all(2)
	tt_style.set_corner_radius_all(6)
	tt_style.set_content_margin_all(8)
	tooltip_panel.add_theme_stylebox_override("panel", tt_style)

	# 1. Header (Icon + Name + Tag)
	var header = HBoxContainer.new()
	header.add_theme_constant_override("separation", 6)

	var icon = TextureRect.new()
	icon.custom_minimum_size = Vector2(28, 28)
	icon.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	icon.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	if ResourceLoader.exists(item_data.get("icon_path", "")):
		icon.texture = load(item_data["icon_path"])
	header.add_child(icon)

	var title_box = VBoxContainer.new()
	var name_lbl = Label.new()
	var is_base = ItemDatabase.is_base_item(item_data.get("id", ""))
	name_lbl.text = item_data.get("name", "") + " (" + item_data.get("en_name", "") + ")"
	name_lbl.add_theme_color_override("font_color", Color(0.3, 0.85, 1.0) if is_base else Color(1.0, 0.85, 0.25))
	name_lbl.add_theme_font_size_override("font_size", 12)
	title_box.add_child(name_lbl)

	var tag_lbl = Label.new()
	tag_lbl.text = "[基础散件]" if is_base else "[已合成神装]"
	tag_lbl.add_theme_color_override("font_color", Color(0.7, 0.75, 0.85))
	tag_lbl.add_theme_font_size_override("font_size", 10)
	title_box.add_child(tag_lbl)
	header.add_child(title_box)
	vbox.add_child(header)

	# 2. Description
	var desc_lbl = Label.new()
	desc_lbl.text = item_data.get("desc", "")
	desc_lbl.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	desc_lbl.custom_minimum_size = Vector2(220, 0)
	desc_lbl.add_theme_color_override("font_color", Color(0.85, 0.88, 0.95))
	desc_lbl.add_theme_font_size_override("font_size", 11)
	vbox.add_child(desc_lbl)

	# 3. Stats section
	var stats: Dictionary = item_data.get("stats", {})
	var stat_strings: Array[String] = []
	if stats.get("atk", 0.0) > 0: stat_strings.append("⚔️ 攻击: +%d" % int(stats["atk"]))
	if stats.get("crit", 0.0) > 0: stat_strings.append("🎯 暴击: +%d%%" % int(stats["crit"] * 100))
	if stats.get("hp", 0.0) > 0: stat_strings.append("❤️ 生命: +%d" % int(stats["hp"]))
	if stats.get("hp_regen", 0.0) > 0: stat_strings.append("🌿 回血: +%d/s" % int(stats["hp_regen"]))
	if stats.get("armor", 0.0) > 0: stat_strings.append("🛡️ 护甲: +%d" % int(stats["armor"]))
	if stats.get("mr", 0.0) > 0: stat_strings.append("🔮 魔抗: +%d" % int(stats["mr"]))
	if stats.get("atk_speed", 0.0) > 0: stat_strings.append("⚡ 攻速: +%d%%" % int(stats["atk_speed"] * 100))
	if stats.get("start_mana", 0.0) > 0: stat_strings.append("💧 初始法力: +%d" % int(stats["start_mana"]))
	if stats.get("mana_per_hit", 0.0) > 0: stat_strings.append("🌀 普攻回蓝: +%d" % int(stats["mana_per_hit"]))
	if stats.get("sp_atk", 0.0) > 0: stat_strings.append("💥 特攻: +%d" % int(stats["sp_atk"]))

	if not stat_strings.is_empty():
		var stats_lbl = Label.new()
		stats_lbl.text = " ".join(stat_strings)
		stats_lbl.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		stats_lbl.custom_minimum_size = Vector2(220, 0)
		stats_lbl.add_theme_color_override("font_color", Color(0.4, 0.95, 0.55))
		stats_lbl.add_theme_font_size_override("font_size", 10)
		vbox.add_child(stats_lbl)

	# 4. Special Effect (if any)
	var effect = item_data.get("special_effect", {})
	if not effect.is_empty():
		var eff_lbl = Label.new()
		eff_lbl.text = "✨ 特效: %s" % effect.get("desc", "")
		eff_lbl.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		eff_lbl.custom_minimum_size = Vector2(220, 0)
		eff_lbl.add_theme_color_override("font_color", Color(1.0, 0.75, 0.3))
		eff_lbl.add_theme_font_size_override("font_size", 10)
		vbox.add_child(eff_lbl)

	# 5. Live Crafting Matrix with currently held bench items
	if is_base:
		var my_id = item_data.get("id", "")
		var owned_combos: Array[Dictionary] = []
		var checked_other_ids: Array[String] = []
		
		for s_id in slots:
			if s_id != "" and s_id != my_id and ItemDatabase.is_base_item(s_id):
				if not checked_other_ids.has(s_id):
					checked_other_ids.append(s_id)
					var res_id = ItemDatabase.get_recipe(my_id, s_id)
					if res_id != "":
						owned_combos.append({"other": s_id, "result": res_id})
						
		if not owned_combos.is_empty():
			var live_title = Label.new()
			live_title.text = "⚡ 与背包散件即刻可合:"
			live_title.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2))
			live_title.add_theme_font_size_override("font_size", 10)
			vbox.add_child(live_title)
			
			for combo in owned_combos:
				var other_item = ItemDatabase.get_item(combo["other"])
				var res_item = ItemDatabase.get_item(combo["result"])
				var r_lbl = Label.new()
				r_lbl.text = " • +【%s】➔ 🌟【%s】" % [other_item.get("name", ""), res_item.get("name", "")]
				r_lbl.add_theme_color_override("font_color", Color(0.35, 0.95, 0.65))
				r_lbl.add_theme_font_size_override("font_size", 10)
				vbox.add_child(r_lbl)
		else:
			# General craftable guide
			var recipe_title = Label.new()
			recipe_title.text = "📜 搭配推荐:"
			recipe_title.add_theme_color_override("font_color", Color(0.75, 0.8, 0.9))
			recipe_title.add_theme_font_size_override("font_size", 10)
			vbox.add_child(recipe_title)

			var craftables = ItemDatabase.get_craftable_recipes(my_id)
			var sample_count = min(3, craftables.size())
			for k in range(sample_count):
				var r = craftables[k]
				var other_item = ItemDatabase.get_item(r["component_b"])
				var res_item = ItemDatabase.get_item(r["result"])
				var r_lbl = Label.new()
				r_lbl.text = " + %s = %s" % [other_item.get("name", ""), res_item.get("name", "")]
				r_lbl.add_theme_color_override("font_color", Color(0.9, 0.85, 0.6))
				r_lbl.add_theme_font_size_override("font_size", 10)
				vbox.add_child(r_lbl)
	else:
		# Advanced item recipe components
		var recipe_parts = item_data.get("recipe", [])
		if recipe_parts.size() == 2:
			var part_a = ItemDatabase.get_item(recipe_parts[0])
			var part_b = ItemDatabase.get_item(recipe_parts[1])
			var recipe_lbl = Label.new()
			recipe_lbl.text = "🔨 合成: %s + %s" % [part_a.get("name", recipe_parts[0]), part_b.get("name", recipe_parts[1])]
			recipe_lbl.add_theme_color_override("font_color", Color(0.85, 0.8, 0.6))
			recipe_lbl.add_theme_font_size_override("font_size", 10)
			vbox.add_child(recipe_lbl)

func _set_mouse_filter_ignore_recursive(node: Node) -> void:
	if node is Control:
		node.mouse_filter = Control.MOUSE_FILTER_IGNORE
	for child in node.get_children():
		_set_mouse_filter_ignore_recursive(child)
