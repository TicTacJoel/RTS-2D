extends TileMapLayer

@onready var building_exclusion: TileMapLayer = $"../BuildingExclusion"

#------------------------------------------------------------------------------|
func _use_tile_data_runtime_update(coords: Vector2i) -> bool:
	if coords in building_exclusion.get_used_cells():
		return true
	return false

#------------------------------------------------------------------------------|
func _tile_data_runtime_update(coords: Vector2i, tile_data: TileData) -> void:
	if coords in building_exclusion.get_used_cells():
		tile_data.set_navigation_polygon(0, null)
