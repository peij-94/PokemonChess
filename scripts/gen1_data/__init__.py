# scripts/gen1_data/__init__.py
from .chunk_1_to_30 import POKEMON_CHUNK_1
from .chunk_31_to_60 import POKEMON_CHUNK_2
from .chunk_61_to_90 import POKEMON_CHUNK_3
from .chunk_91_to_120 import POKEMON_CHUNK_4
from .chunk_121_to_151 import POKEMON_CHUNK_5

ALL_GEN1_POKEMON = {}
ALL_GEN1_POKEMON.update(POKEMON_CHUNK_1)
ALL_GEN1_POKEMON.update(POKEMON_CHUNK_2)
ALL_GEN1_POKEMON.update(POKEMON_CHUNK_3)
ALL_GEN1_POKEMON.update(POKEMON_CHUNK_4)
ALL_GEN1_POKEMON.update(POKEMON_CHUNK_5)
