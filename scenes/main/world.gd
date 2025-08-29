extends Node2D

@onready var ui: CanvasLayer = $UI
@onready var map_node: Node2D = $Map1

# Build mode
var build_mode = false
var build_valid = false
var build_tile
var build_location
var build_type

var current_gold
var units = []

#------------------------------------------------------------------------------|
func _ready() -> void:
	get_units()

#------------------------------------------------------------------------------|
func get_units() -> void:
	units = null
	units = get_tree().get_nodes_in_group("unit")

#------------------------------------------------------------------------------|
func _on_area_selected(camera):
	var start = camera.start
	var end = camera.end
	var area = []
	area.append(Vector2(min(start.x, end.x), min(start.y, end.y)))
	area.append(Vector2(max(start.x, end.x), max(start.y, end.y)))
	var selected_units = get_units_in_area(area)
	for unit in units:
		# deselect all units
		unit.set_selected(false)
	for unit in selected_units:
		# select units in area
		unit.set_selected(!unit.selected)

#------------------------------------------------------------------------------|
func get_units_in_area(area):
	var _selected_units = [] # units in selected area
	for unit in units:
		if (unit.position.x > area[0].x) and (unit.position.x < area[1].x):
			if (unit.position.y > area[0].y) and (unit.position.y < area[1].y):
				_selected_units.append(unit)
	return _selected_units

#------------------------------------------------------------------------------|
# Building Functions
#------------------------------------------------------------------------------|
func initiate_build_mode(building_type):
	if build_mode:
		cancel_build_mode()
	build_type = building_type
	build_mode = true
	# TODO: create function
	#get_node("UI").set_building_preview(build_type, get_global_mouse_position())

#------------------------------------------------------------------------------|
func update_tower_preview():
	var mouse_position = get_global_mouse_position()
	var current_tile = map_node.get_node("TowerExclusion").local_to_map(mouse_position)
	var tile_position = map_node.get_node("TowerExclusion").map_to_local(current_tile)
	
	if map_node.get_node("TowerExclusion").get_cell_source_id(0, current_tile) == -1 and current_gold >= GameData.building_data[build_type]["cost"]:
		# TODO: create function
		#get_node("UI").update_tower_preview(tile_position, Globals.COLORS.green)
		build_valid = true
		build_location = tile_position
		build_tile = current_tile
	else:
		# TODO: create function
		#get_node("UI").update_tower_preview(tile_position, Globals.COLORS.red)
		build_valid = false

#------------------------------------------------------------------------------|
func cancel_build_mode():
	build_mode = false
	build_valid = false
	#get_node("UI/BuildPreview").free()

#------------------------------------------------------------------------------|
func verify_and_build():
	if  build_valid:
		if current_gold >= GameData.building_data[build_type]["cost"]:
			pass
			#var new_tower = load("res://Scenes/Turrets/" + build_type + ".tscn").instantiate()
			#new_tower.position = build_location
			#new_tower.built = true
			#new_tower.type = build_type
			#new_tower.category = GameData.tower_data[build_type]["category"]
			#map_node.get_node("Turrets").add_child(new_tower, true)
			#map_node.get_node("TowerExclusion").set_cell(0, build_tile, 5, Vector2(1,0))
			#current_gold -= GameData.building_data[build_type]["cost"]
			#money_label.text = str(current_money)

#------------------------------------------------------------------------------|
func show_building_info():
	pass
