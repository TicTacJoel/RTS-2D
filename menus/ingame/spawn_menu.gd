extends Node2D

@onready var unit = preload("res://entities/player/unit.tscn")

#------------------------------------------------------------------------------|
func _on_confirm_btn_pressed() -> void:
	var unitContainer = get_tree().get_root().get_node("World/Units")
	var unitInstance = unit.instantiate()
	unitInstance.position = Vector2(200, 200)
	unitContainer.add_child(unitInstance)

#------------------------------------------------------------------------------|
func _on_cancel_btn_pressed() -> void:
	pass # Replace with function body.
