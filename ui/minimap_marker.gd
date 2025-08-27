extends Sprite2D

#------------------------------------------------------------------------------|
func update_position(pos):
	global_position = pos / Global.minimap_zoom_factor

#------------------------------------------------------------------------------|
func delete_marker():
	call_deferred("queue_free")
