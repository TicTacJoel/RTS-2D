extends Control

@onready var camera: Camera2D = $SubViewportContainer/SubViewport/Camera
@onready var ground: TileMapLayer = $SubViewportContainer/SubViewport/MiniWorld/Ground
@onready var sub_viewport: SubViewport = $SubViewportContainer/SubViewport

var buildings: Node2D
var units: Node2D
const marker_scene = preload("res://ui/minimap_marker.tscn")

var zoom_factor = Global.minimap_zoom_factor

#------------------------------------------------------------------------------|
func _enter_tree():
	Global.minimap = self
	buildings = $SubViewportContainer/SubViewport/Buildings
	units = $SubViewportContainer/SubViewport/Units

#------------------------------------------------------------------------------|
func _physics_process(_delta: float) -> void:
	# TODO: maybe make zoom on minimap separate
	var camera_path = get_tree().get_root().get_node("World/Camera")
	camera.position = camera_path.position / zoom_factor
	camera.zoom = camera_path.zoom

#------------------------------------------------------------------------------|
func add_marker(object: Node2D) -> void:
	var marker = marker_scene.instantiate()
	if object.is_in_group("building"):
		marker.modulate = Color.GREEN
		marker.scale = Vector2(1, 1)
		buildings.add_child(marker)
		object.destroyed.connect(marker.delete_marker)
	elif object.is_in_group("unit"):
		marker.modulate = Color.GREEN
		units.add_child(marker)
		object.died.connect(marker.delete_marker)
	
	object.update_location.connect(marker.update_position)
