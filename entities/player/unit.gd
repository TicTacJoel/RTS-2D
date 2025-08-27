extends CharacterBody2D

@export var selected = false

@onready var selected_box: Panel = $Selected
@onready var target = position
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var follow_cursor: bool = false
var speed: int = 50

signal update_location(pos)
signal died

#------------------------------------------------------------------------------|
func _ready() -> void:
	set_selected(selected)

#------------------------------------------------------------------------------|
func _physics_process(_delta: float) -> void:
	update_location.emit(global_position)
	
	if follow_cursor:
		if selected:
			target = get_global_mouse_position()
			animation_player.play("walk_s")
	
	velocity = position.direction_to(target) * speed
	
	# simply if there are more units, that the moving animation stops
	# since the unit tries to get closer forever 
	# -> which it will still try, just not while playing the animation
	# TODO: Find a better solution for this
	if position.distance_to(target) > 15:
		move_and_slide()
	else: 
		animation_player.stop()

#------------------------------------------------------------------------------|
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("RightClick"):
		follow_cursor = true
	
	if event.is_action_released("RightClick"):
		follow_cursor = false

#------------------------------------------------------------------------------|
func set_selected(isSelected: bool):
	selected = isSelected
	selected_box.visible = isSelected

#------------------------------------------------------------------------------|
func _on_died():
	died.emit()
	queue_free()
