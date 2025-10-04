extends Node

#------------------------------------------------------------------------------|
# Get all building names per race (returns dictionary: RACE -> [building_names])
func get_buildings_per_race() -> Dictionary:
	var result := {}
	for race_str in building_data.keys():
		var race_enum = GameData.string_to_race(race_str)
		if race_enum != -1:
			result[race_enum] = building_data[race_str].keys()
	return result

#------------------------------------------------------------------------------|
# Get stats for a specific building
func get_building_stats(race: Types.RACE, building_name: String) -> Dictionary:
	var race_str = GameData.race_to_string(race)
	if race_str in building_data and building_name in building_data[race_str]:
		return building_data[race_str][building_name]
	return {}

#------------------------------------------------------------------------------|
var building_data = {
	"Human": {
		"Goldmine": {
			"Health": 100,
			"Race": Types.RACE.Human,
			"Cost": 0,
			"Description": "Gold mine to mine gold in.",
			"Footprint": [
				Vector2i(0, 0),
				Vector2i(-1, 0),
				Vector2i(1, 0),
				Vector2i(-1, -1),
				Vector2i(0, -1),
				Vector2i(1, -1),
				]
		},
		"Barracks": {
			"Health": 100,
			"Race": Types.RACE.Human,
			"Cost": 0,
			"Description": "Barracks to train soldiers.",
			"Footprint": [
				Vector2i(0, 0),
				Vector2i(-1, 0),
				Vector2i(1, 0),
				Vector2i(-1, -1),
				Vector2i(0, -1),
				Vector2i(1, -1),
			]
		},
	}, 
	"Orc": {},
	"Undead": {},
	"Elf": {},
	"Dwarf": {}
}
