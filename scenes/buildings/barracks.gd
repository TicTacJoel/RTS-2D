extends StaticBody2D

@export var unit: PackedScene
@export var spawn_point: Node2D

@onready var selected_box: Panel = $Selected
@onready var spawn_menu: CanvasLayer = $SpawnMenu

var mouseEntered = false
var selected = false

signal update_location
signal destroyed

func _ready() -> void:
	
	await get_tree().create_timer(1.0).timeout
	update_location.emit(global_position)

#------------------------------------------------------------------------------|
func _process(_delta: float) -> void:
	selected_box.visible = selected

#------------------------------------------------------------------------------|
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("LeftClick"):
		if mouseEntered:
			selected = !selected
			if selected:
				spawn_menu.visible = true

#------------------------------------------------------------------------------|
func _on_mouse_entered() -> void:
	mouseEntered = true
	print("MOUSE ENTERED")

#------------------------------------------------------------------------------|
func _on_mouse_exited() -> void:
	mouseEntered = false
	print("MOUSE EXITED")
