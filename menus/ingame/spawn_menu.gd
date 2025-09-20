extends CanvasLayer

@onready var unit = get_parent().unit
@onready var spawn_point = get_parent().spawn_point.global_position
# TODO: find some cleaner way of doing this
@onready var world_path = get_tree().get_root().get_node("World")
@onready var units_container_path = get_tree().get_root().get_node("World/Map1/Units")

#------------------------------------------------------------------------------|
func spawn_unit() -> void:
	var unitContainer = units_container_path
	var unitInstance = unit.instantiate()
	unitInstance.position = spawn_point
	unitContainer.add_child(unitInstance)
	world_path.get_units()

#------------------------------------------------------------------------------|
func _on_confirm_btn_pressed() -> void:
	spawn_unit()

#------------------------------------------------------------------------------|
func _on_cancel_btn_pressed() -> void:
	visible = false
	get_parent().selected = false
