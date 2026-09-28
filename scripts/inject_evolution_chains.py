import json

with open("scripts/autoload/pokemon_database.gd", "r") as f:
    code = f.read()

# 3-stage families (16):
three_stage = [
    ("bulbasaur", "ivysaur", "venusaur"),
    ("charmander", "charmeleon", "charizard"),
    ("squirtle", "wartortle", "blastoise"),
    ("caterpie", "metapod", "butterfree"),
    ("weedle", "kakuna", "beedrill"),
    ("pidgey", "pidgeotto", "pidgeot"),
    ("nidoran_f", "nidorina", "nidoqueen"),
    ("nidoran_m", "nidorino", "nidoking"),
    ("oddish", "gloom", "vileplume"),
    ("poliwag", "poliwhirl", "poliwrath"),
    ("abra", "kadabra", "alakazam"),
    ("machop", "machoke", "machamp"),
    ("bellsprout", "weepinbell", "victreebel"),
    ("geodude", "graveler", "golem"),
    ("gastly", "haunter", "gengar"),
    ("dratini", "dragonair", "dragonite"),
]

# 2-stage families (37):
two_stage = [
    ("rattata", "raticate"),
    ("spearow", "fearow"),
    ("ekans", "arbok"),
    ("pikachu", "raichu"),
    ("sandshrew", "sandslash"),
    ("clefairy", "clefable"),
    ("vulpix", "ninetales"),
    ("jigglypuff", "wigglytuff"),
    ("zubat", "golbat"),
    ("paras", "parasect"),
    ("venonat", "venomoth"),
    ("diglett", "dugtrio"),
    ("meowth", "persian"),
    ("psyduck", "golduck"),
    ("mankey", "primeape"),
    ("growlithe", "arcanine"),
    ("tentacool", "tentacruel"),
    ("ponyta", "rapidash"),
    ("slowpoke", "slowbro"),
    ("magnemite", "magneton"),
    ("doduo", "dodrio"),
    ("seel", "dewgong"),
    ("grimer", "muk"),
    ("shellder", "cloyster"),
    ("drowzee", "hypno"),
    ("krabby", "kingler"),
    ("voltorb", "electrode"),
    ("exeggcute", "exeggutor"),
    ("cubone", "marowak"),
    ("koffing", "weezing"),
    ("rhyhorn", "rhydon"),
    ("horsea", "seadra"),
    ("goldeen", "seaking"),
    ("staryu", "starmie"),
    ("magikarp", "gyarados"),
    ("omanyte", "omastar"),
    ("kabuto", "kabutops"),
]

# Independent / Single-stage (26):
single_stage = [
    "aerodactyl", "articuno", "chansey", "ditto", "electabuzz", "farfetchd",
    "hitmonchan", "hitmonlee", "jynx", "kangaskhan", "lapras", "lickitung",
    "lucario", "magmar", "mew", "mewtwo", "moltres", "mr-mime", "onix",
    "pinsir", "porygon", "scyther", "snorlax", "tangela", "tauros", "zapdos"
]

chains = {}
for s1, s2, s3 in three_stage:
    chains[s1] = {"next": s2, "stage": 1, "root": s1}
    chains[s2] = {"next": s3, "stage": 2, "root": s1}
    chains[s3] = {"next": "", "stage": 3, "root": s1}

for s1, s2 in two_stage:
    chains[s1] = {"next": s2, "stage": 1, "root": s1}
    chains[s2] = {"next": "", "stage": 2, "root": s1}

chains["eevee"] = {"next": "vaporeon", "stage": 1, "root": "eevee", "branches": ["vaporeon", "jolteon", "flareon"]}
chains["vaporeon"] = {"next": "", "stage": 2, "root": "eevee"}
chains["jolteon"] = {"next": "", "stage": 2, "root": "eevee"}
chains["flareon"] = {"next": "", "stage": 2, "root": "eevee"}

for s in single_stage:
    chains[s] = {"next": "", "stage": 1, "root": s}

gd_dict_lines = ["# Evolution Chains mapping for all 152 Pokemon", "var evolution_chains: Dictionary = {"]
for pid in sorted(chains.keys()):
    info = chains[pid]
    if "branches" in info:
        gd_dict_lines.append(f'\t"{pid}": {{"next": "{info["next"]}", "stage": {info["stage"]}, "root": "{info["root"]}", "branches": ["vaporeon", "jolteon", "flareon"]}},')
    else:
        gd_dict_lines.append(f'\t"{pid}": {{"next": "{info["next"]}", "stage": {info["stage"]}, "root": "{info["root"]}"}},')
gd_dict_lines.append("}\n")

helper_methods = """
func get_next_evolution(pokemon_id: String) -> String:
\tif evolution_chains.has(pokemon_id):
\t\treturn evolution_chains[pokemon_id].get("next", "")
\treturn ""

func get_root_pokemon(pokemon_id: String) -> String:
\tif evolution_chains.has(pokemon_id):
\t\treturn evolution_chains[pokemon_id].get("root", pokemon_id)
\treturn pokemon_id

func is_base_form(pokemon_id: String) -> bool:
\tif evolution_chains.has(pokemon_id):
\t\treturn evolution_chains[pokemon_id].get("stage", 1) == 1
\treturn true

func get_shop_eligible_pokemons(cost: int) -> Array[String]:
\tvar result: Array[String] = []
\tfor pid in pokemons:
\t\tif pokemons[pid].get("cost", 1) == cost and is_base_form(pid):
\t\t\tresult.append(pid)
\tif result.is_empty():
\t\tfor pid in pokemons:
\t\t\tif is_base_form(pid):
\t\t\t\tresult.append(pid)
\treturn result
"""

insertion_block = "\n".join(gd_dict_lines) + helper_methods

# Find where to insert: right after get_pokemons_by_cost function
target_str = """func get_pokemons_by_cost(cost: int) -> Array[String]:
\tvar result: Array[String] = []
\tfor pid in pokemons:
\t\tif pokemons[pid]["cost"] == cost:
\t\t\tresult.append(pid)
\treturn result"""

if target_str in code:
    new_code = code.replace(target_str, target_str + "\n\n" + insertion_block)
    with open("scripts/autoload/pokemon_database.gd", "w") as f:
        f.write(new_code)
    print("SUCCESS: Injected evolution_chains and helper methods into pokemon_database.gd")
else:
    print("ERROR: Target string not found in pokemon_database.gd")
