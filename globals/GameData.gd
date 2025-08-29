extends Node

enum RACE {
	Human,
	Orc
}

var building_data = {
	"GoldMine": {
		"hp": 100,
		"race": RACE.Human,
		"cost": 100,
		"description": "Gold mine to mine gold in."
	},
	"Barracks": {
		"hp": 100,
		"race": RACE.Human,
		"cost": 200,
		"description": "Barracks to train soldiers."
	},
}
