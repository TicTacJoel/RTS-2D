extends CanvasLayer

@onready var wood_label: Label = $WoodLabel

func _process(_delta: float) -> void:
	wood_label.text = "Wood: " + str(Global.Wood)

##-----------------------------------------------------------------------------/
func set_tower_preview(tower_type, mouse_position):
	pass
	# TODO: some changes
	#var drag_tower = load("res://Scenes/Turrets/" + tower_type + ".tscn").instantiate()
	#drag_tower.set_name("DragTower")
	#drag_tower.modulate = Color("ad54ff3c")
#
	#var range_texture = Sprite2D.new()
	#range_texture.position = Vector2(0, 0)
	#var scaling = GameData.tower_data[tower_type]["range"] / 600.0
	#range_texture.scale = Vector2(scaling, scaling)
	#var texture = load("res://Assets/UI/range_overlay.png")
	#range_texture.texture = texture
	#range_texture.modulate = Color("ad54ff3c")
#
	#var control = Control.new()
	#control.add_child(drag_tower, true)
	#control.add_child(range_texture, true)
	#control.position = mouse_position
	#control.set_name("TowerPreview")
	#add_child(control, true)
	#move_child(get_node("TowerPreview"), 0)

##-----------------------------------------------------------------------------/
func update_tower_preview(new_position, color):
	pass
	# TODO: some changes
	#get_node("TowerPreview").position = new_position
	#if get_node("TowerPreview/DragTower").modulate != Color(color):
		#get_node("TowerPreview/DragTower").modulate = Color(color)
		#get_node("TowerPreview/Sprite2D").modulate = Color(color)
