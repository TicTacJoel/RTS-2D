extends StaticBody2D

@export var unit: PackedScene
@export var spawn_point: Node2D

@onready var selected_box: Panel = $Selected
@onready var spawn_menu: CanvasLayer = $SpawnMenu

var mouseEntered = false
var selected = false

#signal spawnUnit

#------------------------------------------------------------------------------|
func _process(delta: float) -> void:
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
	print("mouse entered")

#------------------------------------------------------------------------------|
func _on_mouse_exited() -> void:
	mouseEntered = false
	print("mouse exited")
