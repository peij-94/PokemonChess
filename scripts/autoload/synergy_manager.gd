extends Node

# SynergyManager: Computes and distributes active team synergy traits

signal synergies_updated(active_synergies: Dictionary)

# Stores currently active synergies: { "Fire": 2, "Water": 1, ... }
var active_counts: Dictionary = {}
var active_tiers: Dictionary = {}

func update_synergies_from_units(units: Array) -> void:
	active_counts.clear()
	active_tiers.clear()
	
	# Only unique Pokemon contribute to synergies
	var counted_ids: Dictionary = {}
	for unit in units:
		if unit == null or not is_instance_valid(unit) or unit.is_dead or unit.is_enemy:
			continue
		var pid = unit.pokemon_id
		if counted_ids.has(pid):
			continue
		counted_ids[pid] = true
		
		for t in unit.types:
			active_counts[t] = active_counts.get(t, 0) + 1

	# Trainer Augment: Nature Alliance grants +1 Grass synergy count
	if AugmentDatabase and AugmentDatabase.has_augment("nature_alliance"):
		active_counts["Grass"] = active_counts.get("Grass", 0) + 1
			
	# Determine reached tier for each type
	for t in active_counts:
		var count = active_counts[t]
		if PokemonDatabase.synergies.has(t):
			var syn_info = PokemonDatabase.synergies[t]
			var highest_tier = 0
			for i in range(syn_info["tiers"].size()):
				if count >= syn_info["tiers"][i]["count"]:
					highest_tier = i + 1
			if highest_tier > 0:
				active_tiers[t] = highest_tier

	synergies_updated.emit(get_active_synergy_summary())

func get_active_synergy_summary() -> Dictionary:
	var summary: Dictionary = {}
	for t in active_counts:
		var count = active_counts[t]
		var tier = active_tiers.get(t, 0)
		summary[t] = {
			"count": count,
			"tier": tier,
			"name": PokemonDatabase.synergies[t]["name"] if PokemonDatabase.synergies.has(t) else t,
			"icon": PokemonDatabase.synergies[t]["icon"] if PokemonDatabase.synergies.has(t) else ""
		}
	return summary

func get_spell_amp(is_enemy: bool) -> float:
	if is_enemy:
		return 1.0
	var tier = active_tiers.get("Psychic", 0)
	if tier == 1:
		return 1.35
	elif tier >= 2:
		return 1.75
	return 1.0

func has_fire_burn(is_enemy: bool) -> bool:
	if is_enemy:
		return false
	return active_tiers.get("Fire", 0) >= 1

func get_fire_atk_speed_bonus(is_enemy: bool) -> float:
	if is_enemy:
		return 0.0
	var tier = active_tiers.get("Fire", 0)
	if tier == 1:
		return 0.25
	elif tier >= 2:
		return 0.50
	return 0.0

func get_water_hp_bonus(is_enemy: bool) -> int:
	if is_enemy:
		return 0
	var tier = active_tiers.get("Water", 0)
	if tier == 1:
		return 250
	elif tier >= 2:
		return 600
	return 0

func get_water_regen_ratio(is_enemy: bool) -> float:
	if is_enemy:
		return 0.0
	var tier = active_tiers.get("Water", 0)
	if tier == 1:
		return 0.025
	elif tier >= 2:
		return 0.05
	return 0.0

func get_normal_damage_reduction(is_enemy: bool) -> float:
	if is_enemy:
		return 0.0
	var tier = active_tiers.get("Normal", 0)
	if tier == 1:
		return 0.15
	elif tier >= 2:
		return 0.25
	return 0.0

func get_normal_regen_ratio(is_enemy: bool) -> float:
	if is_enemy:
		return 0.0
	var tier = active_tiers.get("Normal", 0)
	if tier >= 2:
		return 0.03
	return 0.0

func get_fighting_atk_bonus(is_enemy: bool) -> float:
	if is_enemy:
		return 0.0
	var tier = active_tiers.get("Fighting", 0)
	if tier == 1:
		return 30.0
	elif tier >= 2:
		return 65.0
	return 0.0

func get_fighting_crit_bonus(is_enemy: bool) -> float:
	if is_enemy:
		return 0.0
	var tier = active_tiers.get("Fighting", 0)
	if tier == 1:
		return 0.30
	elif tier >= 2:
		return 0.50
	return 0.0

func get_electric_bounce_chance(is_enemy: bool) -> float:
	if is_enemy:
		return 0.0
	var tier = active_tiers.get("Electric", 0)
	if tier == 1:
		return 0.25
	elif tier >= 2:
		return 0.50
	return 0.0

func get_electric_team_atk_speed(is_enemy: bool) -> float:
	if is_enemy:
		return 0.0
	var tier = active_tiers.get("Electric", 0)
	if tier >= 2:
		return 0.25
	return 0.0

func has_poison_debuff(is_enemy: bool) -> bool:
	if is_enemy:
		return false
	return active_tiers.get("Poison", 0) >= 1

func get_poison_dps(is_enemy: bool) -> float:
	if is_enemy:
		return 0.0
	var tier = active_tiers.get("Poison", 0)
	if tier == 1:
		return 25.0
	elif tier >= 2:
		return 60.0
	return 0.0

func get_bug_atk_speed_bonus(is_enemy: bool) -> float:
	if is_enemy:
		return 0.0
	var tier = active_tiers.get("Bug", 0)
	if tier == 1:
		return 0.30
	elif tier >= 2:
		return 0.45
	return 0.0

func get_flying_dodge_bonus(is_enemy: bool) -> float:
	if is_enemy:
		return 0.0
	var tier = active_tiers.get("Flying", 0)
	if tier == 1:
		return 0.25
	elif tier >= 2:
		return 0.30
	return 0.0

func get_ground_armor_bonus(is_enemy: bool) -> float:
	if is_enemy:
		return 0.0
	var tier = active_tiers.get("Ground", 0)
	if tier == 1:
		return 30.0
	elif tier >= 2:
		return 60.0
	return 0.0

func get_rock_shield_bonus(is_enemy: bool) -> int:
	if is_enemy:
		return 0
	var tier = active_tiers.get("Rock", 0)
	if tier == 1:
		return 300
	elif tier >= 2:
		return 650
	return 0

func get_ice_damage_amp(is_enemy: bool) -> float:
	if is_enemy:
		return 1.0
	var tier = active_tiers.get("Ice", 0)
	if tier == 1:
		return 1.30
	elif tier >= 2:
		return 1.60
	return 1.0

