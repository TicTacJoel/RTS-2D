extends StaticBody2D

@export var unit: PackedScene

@onready var selected_box: Panel = $Selected
@onready var spawn_point: Node2D = $SpawnPoint

var mouseEntered = false
var selected = false

#------------------------------------------------------------------------------|
func _process(delta: float) -> void:
	pass

#------------------------------------------------------------------------------|
func spawn_unit():
	
