extends Node

#------------------------------------------------------------------------------|
# Get all unit names per race (returns dictionary: RACE -> [unit_names])
func get_units_per_race() -> Dictionary:
	var result := {}
	for race_str in unit_data.keys():
		var race_enum = GameData.string_to_race(race_str)
		if race_enum != -1:
			result[race_enum] = unit_data[race_str].keys()
	return result

#------------------------------------------------------------------------------|
# Get stats for a specific unit
func get_unit_stats(race: Types.RACE, unit_name: String) -> Dictionary:
	var race_str = GameData.race_to_string(race)
	if race_str in unit_data and unit_name in unit_data[race_str]:
		return unit_data[race_str][unit_name]
	return {}

#------------------------------------------------------------------------------|
var unit_data = {
	"Human": {
		"Knight": {
			"Health": 50,
			"Damage": 10,
			"Attack_speed": 1.0,
			"Movement_speed": 50.0,
			"Cost": 100,
		}, 
		"Archer": {
			"Health": 50,
			"Damage": 10,
			"Attack_speed": 1.0,
			"Movement_speed": 50.0,
			"Cost": 100,
		}, 
		"Cavalry": {
			"Health": 50,
			"Damage": 10,
			"Attack_speed": 1.0,
			"Movement_speed": 50.0,
			"Cost": 100,
		}
	},
	"Orc": {
		"Warrior": {
			"Health": 50,
			"Damage": 10,
			"Attack_speed": 1.0,
			"Movement_speed": 50.0,
			"Cost": 100,
		}, 
		"Spearman": {
			"Health": 50,
			"Damage": 10,
			"Attack_speed": 1.0,
			"Movement_speed": 50.0,
			"Cost": 100,
		}, 
		"Warg": {
			"Health": 50,
			"Damage": 10,
			"Attack_speed": 1.0,
			"Movement_speed": 50.0,
			"Cost": 100,
		}
	},
}
