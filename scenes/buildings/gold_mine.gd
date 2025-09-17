extends StaticBody2D

@onready var progress_bar: ProgressBar = $ProgressBar
@onready var timer: Timer = $Timer

var pop_label = preload("res://scenes/helper/pop_label.tscn")

var total_time = 50
var current_time
var gold_increase: int = 10

# Building
var type
var build = false

signal update_location
signal destroyed

#------------------------------------------------------------------------------|
func _ready() -> void:
	reset()
	
	await get_tree().create_timer(1.0).timeout
	update_location.emit(global_position)

#------------------------------------------------------------------------------|
func _process(_delta: float) -> void:
	if current_time >= total_time:
		gold_collected()
		reset()

#------------------------------------------------------------------------------|
func gold_collected():
	Global.Gold += gold_increase
	var pop = pop_label.instantiate()
	add_child(pop)
	pop.show_value(str(gold_increase), false)

#------------------------------------------------------------------------------|
func reset():
	current_time = 0
	progress_bar.max_value = total_time
	timer.start()

#------------------------------------------------------------------------------|
func _on_timer_timeout() -> void:
	current_time += 1
	var tween = get_tree().create_tween()
	tween.tween_property(progress_bar, "value", current_time, 0.2).set_trans(Tween.TRANS_LINEAR)
