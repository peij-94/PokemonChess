extends Node

func _ready():
    print("=== STARTING FAIRY SYNERGY VERIFICATION ===")
    
    # 1. Check registry
    assert(PokemonDatabase.synergies.has("Fairy"), "PokemonDatabase must have Fairy")
    var syn = PokemonDatabase.synergies["Fairy"]
    print("  [PASS] Fairy synergy registered: ", syn["name"])
    assert(ResourceLoader.exists(syn["icon"]), "Fairy icon must exist")
    var icon_tex = load(syn["icon"])
    assert(icon_tex != null, "Fairy icon must load cleanly")
    print("  [PASS] Fairy icon loaded successfully: ", icon_tex.get_size())
    
    # 2. Check Units with Fairy type in Database
    var fairy_pokemons = []
    for pid in PokemonDatabase.pokemons:
        if PokemonDatabase.pokemons[pid].get("types", []).has("Fairy"):
            fairy_pokemons.append(pid)
    print("  Total Fairy Pokémon in roster: %d (%s...)" % [fairy_pokemons.size(), ", ".join(fairy_pokemons.slice(0, 5))])
    assert(fairy_pokemons.size() >= 10, "Should have at least 10 Fairy Pokémon across Gen 1-3")
    print("  [PASS] Verified roster contains %d Fairy units." % fairy_pokemons.size())
    
    # 3. Simulate 2 Fairy units on board
    var u1 = Node2D.new()
    u1.set_script(load("res://scripts/unit.gd"))
    u1.pokemon_id = "clefairy"
    u1.types = ["Fairy"]
    u1.is_enemy = false
    
    var u2 = Node2D.new()
    u2.set_script(load("res://scripts/unit.gd"))
    u2.pokemon_id = "togepi"
    u2.types = ["Fairy"]
    u2.is_enemy = false
    
    SynergyManager.update_synergies_from_units([u1, u2])
    var summary = SynergyManager.get_active_synergy_summary()
    assert(summary.has("Fairy"), "Fairy must be in active synergies")
    assert(summary["Fairy"]["tier"] == 1, "2 Fairies must reach Tier 1")
    assert(summary["Fairy"]["count"] == 2, "Count should be 2")
    assert(is_equal_approx(SynergyManager.get_fairy_shield_ratio(false), 0.20), "Tier 1 shield ratio should be 0.20")
    assert(SynergyManager.has_fairy_cc_immunity(false) == true, "Tier 1 must grant CC immunity")
    assert(SynergyManager.has_fairy_shatter_blind(false) == false, "Tier 1 should not have shatter blind")
    print("  [PASS] 2-Fairy Tier 1 activation verified (20% shield, CC immune).")
    
    # 4. Simulate 4 Fairy units on board
    var u3 = Node2D.new()
    u3.set_script(load("res://scripts/unit.gd"))
    u3.pokemon_id = "ralts"
    u3.types = ["Psychic", "Fairy"]
    u3.is_enemy = false
    
    var u4 = Node2D.new()
    u4.set_script(load("res://scripts/unit.gd"))
    u4.pokemon_id = "marill"
    u4.types = ["Water", "Fairy"]
    u4.is_enemy = false
    
    SynergyManager.update_synergies_from_units([u1, u2, u3, u4])
    var summary4 = SynergyManager.get_active_synergy_summary()
    assert(summary4["Fairy"]["tier"] == 2, "4 Fairies must reach Tier 2")
    assert(is_equal_approx(SynergyManager.get_fairy_shield_ratio(false), 0.40), "Tier 2 shield ratio should be 0.40")
    assert(SynergyManager.has_fairy_shatter_blind(false) == true, "Tier 2 must grant shatter blind")
    print("  [PASS] 4-Fairy Tier 2 activation verified (40% shield, shatter blind).")
    
    # 5. Clean up mock nodes
    u1.free()
    u2.free()
    u3.free()
    u4.free()
    
    print("==============================================")
    print(">>> ALL FAIRY SYNERGY TESTS PASSED (100%) <<<")
    print("==============================================")
    get_tree().quit()
