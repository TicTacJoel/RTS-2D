extends CanvasLayer

@onready var wood_label: Label = $HUD/WoodLabel
@onready var gold_label: Label = $HUD/GoldLabel

##-----------------------------------------------------------------------------/
func _process(_delta: float) -> void:
	wood_label.text = "Wood: " + str(Global.Wood)
	gold_label.text = "Gold: " + str(Global.Gold)

##-----------------------------------------------------------------------------/
func set_building_preview(building_type, mouse_position) -> void:
	print("building type: ", building_type)
	var drag_tower = load("res://scenes/buildings/" + building_type + ".tscn").instantiate()
	drag_tower.set_name("DragBuilding")
	drag_tower.modulate = Global.COLORS.green

	var control = Control.new()
	control.add_child(drag_tower, true)
	control.position = mouse_position
	control.set_name("BuildingPreview")
	add_child(control, true)
	move_child(get_node("BuildingPreview"), 0)

##-----------------------------------------------------------------------------/
func update_building_preview(new_position, color):
	get_node("BuildingPreview").position = new_position
	if get_node("BuildingPreview/DragBuilding").modulate != Color(color):
		get_node("BuildingPreview/DragBuilding").modulate = Color(color)
		#get_node("BuildingPreview/Sprite2D").modulate = Color(color)

##-----------------------------------------------------------------------------/
func _on_barracks_mouse_entered() -> void:
	print("MOUSE ENTERED")

##-----------------------------------------------------------------------------/
func _on_barracks_mouse_exited() -> void:
	print("MOUSE EXITED")
