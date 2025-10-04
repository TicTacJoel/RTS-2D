extends CanvasLayer

@onready var unit = get_parent().unit
@onready var spawn_point = get_parent().spawn_point.global_position
# TODO: find some cleaner way of doing this
@onready var world_path = get_tree().get_root().get_node("World")
@onready var units_container_path = get_tree().get_root().get_node("World/Map1/Units")
@onready var hud: Control = $HUD

@export var spawn_radius: float = 32.0

var spawn_menu_mouse_entered: bool = false

#------------------------------------------------------------------------------|
func spawn_unit() -> void:
	var unitContainer = units_container_path
	var unitInstance = unit.instantiate()
	var unitOffset: Vector2
	var tries := 0
	var max_tries := 10
	
	while tries < max_tries:
		unitOffset = Vector2(
			randf_range(-spawn_radius, spawn_radius),
			randf_range(-spawn_radius, spawn_radius)
		)
		var pos = spawn_point + unitOffset
		unitInstance.position = pos
		tries += 1
	
	#unitInstance.position = pos
	unitContainer.add_child(unitInstance)
	world_path.get_units()

#------------------------------------------------------------------------------|
func _on_confirm_btn_pressed() -> void:
	spawn_unit()

#------------------------------------------------------------------------------|
func _on_cancel_btn_pressed() -> void:
	visible = false
	get_parent().selected = false

#------------------------------------------------------------------------------|
func is_mouse_inside() -> bool:
	var rect = hud.get_global_rect()
	return rect.has_point(get_viewport().get_mouse_position())

#------------------------------------------------------------------------------|
func clicked_outside(event: InputEvent) -> bool:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		return not is_mouse_inside()
	return false
