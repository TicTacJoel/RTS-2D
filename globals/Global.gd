extends Node

#@onready var spawn = preload("res://menus/ingame/spawn_menu.tscn")

var Wood: int = 0
var Gold: int = 0

var minimap_zoom_factor = 3

const COLORS = {
	"red": "bf001e",
	"green": "adff4545"
}

#func spawnUnit():
	#var spawnUnit = spawn.instantiate()
	#add_child(spawnUnit)
