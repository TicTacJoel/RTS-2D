extends Node2D

var units = []

#------------------------------------------------------------------------------|
func _ready() -> void:
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
