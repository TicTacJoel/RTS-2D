extends Control

@onready var camera: Camera2D = $SubViewportContainer/SubViewport/Camera
var buildings: Node2D
var units: Node2D
const marker_scene = preload("res://ui/minimap_marker.tscn")

var zoom_factor = Global.minimap_zoom_factor

#------------------------------------------------------------------------------|
#func _ready() -> void:
	#Global.minimap = self

func _enter_tree():
	Global.minimap = self
	buildings = $SubViewportContainer/SubViewport/Buildings
	units = $SubViewportContainer/SubViewport/Units

#------------------------------------------------------------------------------|
func _physics_process(_delta: float) -> void:
	# TODO: find a better solution
	var camera_path = get_tree().get_root().get_node("World/Camera")
	camera.position = camera_path.position / zoom_factor
	camera.zoom = camera_path.zoom
	
	# TODO: is this efficient? -> NO
	#set_markers()
#------------------------------------------------------------------------------|
func add_marker(owner: Node2D) -> void:
	var marker = marker_scene.instantiate()
	if owner.is_in_group("building"):
		marker.modulate = Color.GREEN
		marker.scale = Vector2(1, 1)
		buildings.add_child(marker)
		owner.destroyed.connect(marker.delete_marker)
	elif owner.is_in_group("unit"):
		marker.modulate = Color.GREEN
		units.add_child(marker)
		owner.died.connect(marker.delete_marker)

	owner.update_location.connect(marker.update_position)
	owner.minimap_marker = marker

#------------------------------------------------------------------------------|
#func set_markers():
	#for unit in get_tree().get_nodes_in_group("unit"):
		#var marker = marker_scene.instantiate()
		#marker.modulate = Color.GREEN
		#units.add_child(marker)
		#
		#unit.update_location.connect(marker.update_position)
		#unit.died.connect(marker.delete_marker) 
	#
	#for building in get_tree().get_nodes_in_group("building"):
		#var marker = marker_scene.instantiate()
		#marker.modulate = Color.GREEN
		#marker.scale.x = 2
		#marker.scale.y = 2
		#buildings.add_child(marker)
		#
		#building.update_location.connect(marker.update_position)
		#building.destroyed.connect(marker.delete_marker)
