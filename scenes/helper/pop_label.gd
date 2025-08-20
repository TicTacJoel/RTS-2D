extends Label

var travel = Vector2(0, -20)
var duration = 1
var spread = PI/2

#------------------------------------------------------------------------------|
func show_value(value, crit):
	var tween = create_tween()
	text = "+ " + str(value)
	pivot_offset = size / 4
	
	var movement = travel.rotated(randi_range(-spread/2, spread/2))
	
	# Animate Position of Label
	tween.tween_property(self, "position", position + movement, duration)
	
	# Animate Position of Label
	tween.tween_property(self, "modulate:a", 0.0, duration)
	
	#if crit:
		#modulate = Color(1, 0, 0)
		#scale *= 2
		#tween.tween_property(self, "scale", scale, 0.4)
	
	tween.play()
	tween.tween_callback(self.queue_free)
