extends StaticBody2D

@export var unit: PackedScene
@export var spawn_point: Node2D

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var selected_box: Panel = $Selected
@onready var spawn_menu: CanvasLayer = $SpawnMenu

var mouseEntered = false
var spawn_menu_mouse_entered = false
var selected = false

# Building
var type
var build = false

var health: int
var cost: int
var team: Types.TEAM
var enemy: bool = false
var description: String
var footprint: Array
@export var race: Types.RACE
@export var building_type: String

signal update_location
signal destroyed

#------------------------------------------------------------------------------|
func _ready() -> void:
	get_stats()
	add_marker()
	update_location.emit(global_position)

#------------------------------------------------------------------------------|
func _process(_delta: float) -> void:
	selected_box.visible = selected

#------------------------------------------------------------------------------|
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("LeftClick"):
		if mouseEntered:
			selected = true
			spawn_menu.visible = true
			# TODO: Debugging
			#_on_destroyed()
		elif spawn_menu.clicked_outside(event):
			selected = false
			spawn_menu.visible = false

#------------------------------------------------------------------------------|
func add_marker() -> void:
	Global.minimap.add_marker(self)

#------------------------------------------------------------------------------|
func get_stats() -> void:
	var stats = BuildingData.get_building_stats(race, building_type)
	if stats.is_empty():
		push_error("Invalid building type '%s' for race %s" % [building_type, Types.RACE.keys()[race]])
		return
	
	health = stats.Health
	cost = stats.Cost
	description = stats.Description
	footprint = stats.Footprint

#------------------------------------------------------------------------------|
func _on_destroyed():
	emit_signal("destroyed")
	queue_free()

#------------------------------------------------------------------------------|
func _on_mouse_entered() -> void:
	mouseEntered = true

#------------------------------------------------------------------------------|
func _on_mouse_exited() -> void:
	mouseEntered = false
