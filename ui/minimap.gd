extends Control

@onready var camera: Camera2D = $SubViewportContainer/SubViewport/Camera
@onready var buildings: Node2D = $SubViewportContainer/SubViewport/Buildings
@onready var units: Node2D = $SubViewportContainer/SubViewport/Units
@onready var marker_scene = preload("res://ui/minimap_marker.tscn")

var zoom_factor = Global.minimap_zoom_factor

#------------------------------------------------------------------------------|
func _physics_process(delta: float) -> void:
	# TODO: find a better solution
	var camera_path = get_tree().get_root().get_node("World/Camera")
	camera.position = camera_path.position / zoom_factor
	camera.zoom = camera_path.zoom
	
	# TODO: is this efficient?
	set_markers()

#------------------------------------------------------------------------------|
func set_markers():
	for unit in get_tree().get_nodes_in_group("unit"):
		var marker = marker_scene.instantiate()
		marker.modulate = Color.GREEN
		units.add_child(marker)
		
		unit.update_location.connect(marker.update_position)
		unit.died.connect(marker.delete_marker) 
	
	for building in get_tree().get_nodes_in_group("building"):
		var marker = marker_scene.instantiate()
		marker.modulate = Color.GREEN
		marker.scale.x = 2
		marker.scale.y = 2
		buildings.add_child(marker)
		
		building.update_location.connect(marker.update_position)
		building.destroyed.connect(marker.delete_marker)
