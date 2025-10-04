extends Node

#------------------------------------------------------------------------------|
# Convert enum -> string
static func race_to_string(race: Types.RACE) -> String:
	return Types.RACE.keys()[race]

#------------------------------------------------------------------------------|
# Convert string -> enum (returns -1 if not found)
static func string_to_race(race_str: String) -> int:
	return Types.RACE.get(race_str, -1)
