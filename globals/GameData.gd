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
		"description": "Gold mine to mine gold in."
	},
	"barracks": {
		"hp": 100,
		"race": RACE.Human,
		"cost": 0,
		"description": "Barracks to train soldiers."
	},
}
