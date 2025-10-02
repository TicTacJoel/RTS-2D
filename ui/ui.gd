extends CanvasLayer

@onready var wood_label: Label = $HUD/WoodLabel
@onready var gold_label: Label = $HUD/GoldLabel

var map_node: Node2D
var building_preview: Node2D

##-----------------------------------------------------------------------------/
func _process(_delta: float) -> void:
	wood_label.text = "Wood: " + str(Global.Wood)
	gold_label.text = "Gold: " + str(Global.Gold)

##-----------------------------------------------------------------------------/
func set_building_preview(building_type, mouse_position) -> void:
	var drag_building = load("res://scenes/buildings/" + building_type + ".tscn").instantiate()
	drag_building.name = "BuildingPreview"
	drag_building.modulate = Global.COLORS.green
	map_node.add_child(drag_building)
	drag_building.position = mouse_position
	drag_building.collision_shape.disabled = true
	
	building_preview = drag_building

##-----------------------------------------------------------------------------/
func update_building_preview(new_position, color):
	if building_preview and is_instance_valid(building_preview):
		building_preview.position = new_position
		building_preview.modulate = Color(color)

##-----------------------------------------------------------------------------/
func _on_barracks_mouse_entered() -> void:
	pass

##-----------------------------------------------------------------------------/
func _on_barracks_mouse_exited() -> void:
	pass
