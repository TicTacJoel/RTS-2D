extends CanvasLayer

@onready var wood_label: Label = $HUD/WoodLabel
@onready var gold_label: Label = $HUD/GoldLabel

var map_node: Node2D

##-----------------------------------------------------------------------------/
func _process(_delta: float) -> void:
	wood_label.text = "Wood: " + str(Global.Wood)
	gold_label.text = "Gold: " + str(Global.Gold)

##-----------------------------------------------------------------------------/
func set_building_preview(building_type, mouse_position) -> void:
	var drag_tower = load("res://scenes/buildings/" + building_type + ".tscn").instantiate()
	drag_tower.name = "BuildingPreview"
	drag_tower.modulate = Global.COLORS.green
	map_node.add_child(drag_tower)
	drag_tower.position = mouse_position

##-----------------------------------------------------------------------------/
func update_building_preview(new_position, color):
	get_node("../Map1/BuildingPreview").position = new_position
	if get_node("../Map1/BuildingPreview").modulate != Color(color):
		get_node("../Map1/BuildingPreview").modulate = Color(color)

##-----------------------------------------------------------------------------/
func _on_barracks_mouse_entered() -> void:
	pass

##-----------------------------------------------------------------------------/
func _on_barracks_mouse_exited() -> void:
	pass
