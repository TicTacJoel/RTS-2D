extends StaticBody2D

@onready var progress_bar: ProgressBar = $ProgressBar
@onready var timer: Timer = $Timer

var maxHealth: float = 5
var currentHealth: float
var units: int = 0
var cutSpeed: float = 1
var woodGain: int = 1

#------------------------------------------------------------------------------|
func _ready() -> void:
	currentHealth = maxHealth
	progress_bar.max_value = maxHealth

#------------------------------------------------------------------------------|
func _process(_delta: float) -> void:
	if currentHealth <= 0:
		treeCutDown()

#------------------------------------------------------------------------------|
func treeCutDown():
	Global.Wood += woodGain
	queue_free()

#------------------------------------------------------------------------------|
func startCuttingTree():
	timer.start()

#------------------------------------------------------------------------------|
func _on_work_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("unit"):
		units += 1
		startCuttingTree()

#------------------------------------------------------------------------------|
func _on_work_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("unit"):
		units -= 1
		if units <= 0:
			timer.stop()

#------------------------------------------------------------------------------|
func _on_timer_timeout() -> void:
	currentHealth -= cutSpeed * units
	var tween = get_tree().create_tween()
	tween.tween_property(progress_bar, "value", currentHealth, 0.2).set_trans(Tween.TRANS_LINEAR)
