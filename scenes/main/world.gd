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
	if event.is_action_pressed("RightClick") and !build_mode:
		move_selected_units(get_global_mouse_position())
	
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
func move_selected_units(click_pos: Vector2) -> void:
	var selected_units: Array = []
	for u in units:
		if u.selected:
			selected_units.append(u)
	if selected_units.is_empty():
		return

	# force integer types where needed
	var count: int = selected_units.size()
	var formation_size: int = int(ceil(sqrt(count)))
	var spacing: float = 16.0

	for i in count:
		var row: int = i / formation_size
		var col: int = i % formation_size
		var offset: Vector2 = Vector2(
			(col - formation_size / 2.0) * spacing,
			(row - formation_size / 2.0) * spacing
		)
		selected_units[i].set_target(click_pos + offset)

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
	var mouse_position = map_node.to_local(get_global_mouse_position())
	var current_tile = map_node.get_node("BuildingExclusion").local_to_map(mouse_position)
	var tile_position = map_node.get_node("BuildingExclusion").map_to_local(current_tile)
	
	# Assume valid until proven otherwise
	build_valid = true
	
	# Get the building's footprint
	var building_footprint = GameData.building_data[build_type]["footprint"]
	
	# Check if all tiles in the footprint are clear
	for relative_pos in building_footprint:
		var tile_to_check = current_tile + relative_pos
		if map_node.get_node("BuildingExclusion").get_cell_source_id(tile_to_check) != -1:
			build_valid = false
			break  # Exit the loop as soon as an invalid tile is found
	
	if current_gold < GameData.building_data[build_type]["cost"]:
		build_valid = false
	
	if build_valid:
		ui.update_building_preview(tile_position, Global.COLORS.green)
		build_location = tile_position
		build_tile = current_tile
	else:
		ui.update_building_preview(tile_position, Global.COLORS.red)

#------------------------------------------------------------------------------|
func cancel_build_mode():
	build_mode = false
	build_valid = false
	get_node("Map1/BuildingPreview").free()

#------------------------------------------------------------------------------|
func verify_and_build():
	var building_exclusion = map_node.get_node("BuildingExclusion")
	# Get size and footprint of building
	var building_footprint = GameData.building_data[build_type]["footprint"]
	var ground_tilemap = map_node.get_node("Ground")
	
	if  build_valid:
		if current_gold >= GameData.building_data[build_type]["cost"]:
			var new_tower = load("res://scenes/buildings/" + build_type + ".tscn").instantiate()
			new_tower.position = build_location
			new_tower.type = build_type
			# Add building to Buildings Node
			map_node.get_node("Buildings").add_child(new_tower, true)
			# Replace cell with non-navigation cell, empty cell on tilemap
			for relative_pos in building_footprint:
				var current_tile = build_tile + relative_pos
				# Set the tile on the BuildingExclusion layer
				building_exclusion.set_cell(current_tile, 5, Vector2(1,0)) # coords, sourceId, atlas
			
			# Let ground know, it needs to rebake
			ground_tilemap.notify_runtime_tile_data_update()
			Global.Gold -= GameData.building_data[build_type]["cost"]

#------------------------------------------------------------------------------|
func show_building_info():
	pass
