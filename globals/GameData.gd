extends Node

enum RACE {
	Human,
	Orc, 
	Undead
}

var building_data = {
	"gold_mine": {
		"hp": 100,
		"race": RACE.Human,
		"cost": 0,
		"description": "Gold mine to mine gold in.",
		"footprint": [
			Vector2i(0, 0),
			Vector2i(-1, 0),
			Vector2i(1, 0),
			Vector2i(-1, -1),
			Vector2i(0, -1),
			Vector2i(1, -1),
		]
	},
	"barracks": {
		"hp": 100,
		"race": RACE.Human,
		"cost": 0,
		"description": "Barracks to train soldiers.",
		"footprint": [
			Vector2i(0, 0),
			Vector2i(-1, 0),
			Vector2i(1, 0),
			Vector2i(-1, -1),
			Vector2i(0, -1),
			Vector2i(1, -1),
		]
	},
}
