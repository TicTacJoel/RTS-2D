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
	current_gold = Global.Gold
	for i in get_tree().get_nodes_in_group("build_buttons"):
		i.pressed.connect(initiate_build_mode.bind(i.name))
	ui.map_node = map_node

#------------------------------------------------------------------------------|
func _process(_delta: float) -> void:
	if build_mode: 
		update_building_preview()

#------------------------------------------------------------------------------|
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("RightClick") and build_mode == true:
		cancel_build_mode()
	if event.is_action_released("LeftClick") and build_mode == true:
		verify_and_build()
		cancel_build_mode()

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
	ui.set_building_preview(build_type, get_global_mouse_position())

#------------------------------------------------------------------------------|
func update_building_preview():
	#var mouse_position = get_global_mouse_position()
	var mouse_position = map_node.to_local(get_global_mouse_position())
	var current_tile = map_node.get_node("BuildingExclusion").local_to_map(mouse_position)
	var tile_position = map_node.get_node("BuildingExclusion").map_to_local(current_tile)
	
	if map_node.get_node("BuildingExclusion").get_cell_source_id(current_tile) == -1 and current_gold >= GameData.building_data[build_type]["cost"]:
		ui.update_building_preview(tile_position, Global.COLORS.green)
		build_valid = true
		build_location = tile_position
		build_tile = current_tile
	else:
		ui.update_building_preview(tile_position, Global.COLORS.red)
		build_valid = false

#------------------------------------------------------------------------------|
func cancel_build_mode():
	build_mode = false
	build_valid = false
	get_node("Map1/BuildingPreview").free()

#------------------------------------------------------------------------------|
func verify_and_build():
	if  build_valid:
		if current_gold >= GameData.building_data[build_type]["cost"]:
			var new_tower = load("res://scenes/buildings/" + build_type + ".tscn").instantiate()
			new_tower.position = build_location
			new_tower.type = build_type
			map_node.get_node("Buildings").add_child(new_tower, true)
			map_node.get_node("BuildingExclusion").set_cell(build_tile, 5, Vector2(1,0))
			Global.Gold -= GameData.building_data[build_type]["cost"]

#------------------------------------------------------------------------------|
func show_building_info():
	pass
