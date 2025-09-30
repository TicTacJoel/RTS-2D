extends CharacterBody2D

@export var selected = false

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var selected_box: Panel = $Selected
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var unit: CharacterBody2D = $"."
@onready var state_machine: StateMachine = $StateMachine

var follow_cursor: bool = false
var speed: int = 50
var target: Vector2
var moving: bool = false

signal update_location(pos)
signal died

#------------------------------------------------------------------------------|
func _ready() -> void:
	set_selected(selected)
	Global.minimap.add_marker(self)

#------------------------------------------------------------------------------|
func _physics_process(delta: float) -> void:
	emit_signal("update_location", global_position)
	
	if state_machine:
		state_machine._physics_process_state(delta)

#------------------------------------------------------------------------------|
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("RightClick"):
		follow_cursor = true
	
	if event.is_action_released("RightClick"):
		follow_cursor = false

#------------------------------------------------------------------------------|
func set_target(pos: Vector2) -> void:
	target = pos
	nav_agent.target_position = pos
	moving = true

#------------------------------------------------------------------------------|
func set_selected(isSelected: bool):
	selected = isSelected
	selected_box.visible = isSelected

#------------------------------------------------------------------------------|
func _on_died():
	emit_signal("died")
	queue_free()

#------------------------------------------------------------------------------|
func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity
	move_and_slide()
