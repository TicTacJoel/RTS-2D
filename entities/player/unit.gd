extends CharacterBody2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var selected_box: Panel = $Selected
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var unit: CharacterBody2D = $"."
@onready var state_machine: StateMachine = $StateMachine
@onready var knight: CharacterBody2D = $"."

# Stats
var health: int
var damage: int
var attack_speed: float
var movement_speed: float
var cost: int
var team: Types.TEAM
var enemy: bool = false
@export var race: Types.RACE
@export var unit_type: String

var follow_cursor: bool = false
var target: Vector2
var moving: bool = false
var selected = false

signal update_location(pos)
signal died

#------------------------------------------------------------------------------|
func _ready() -> void:
	get_stats()
	set_selected(selected)
	add_marker()

#------------------------------------------------------------------------------|
func _physics_process(delta: float) -> void:
	emit_signal("update_location", global_position)
	state_machine_start(delta)

#------------------------------------------------------------------------------|
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("RightClick"):
		follow_cursor = true
	
	if event.is_action_released("RightClick"):
		follow_cursor = false

#------------------------------------------------------------------------------|
func get_stats() -> void:
	var stats = UnitData.get_unit_stats(race, unit_type)
	if stats.is_empty():
		push_error("Invalid unit type '%s' for race %s" % [unit_type, Types.RACE.keys()[race]])
		return
	
	health = stats.Health
	damage = stats.Damage
	attack_speed = stats.Attack_speed
	movement_speed = stats.Movement_speed
	cost = stats.Cost

#------------------------------------------------------------------------------|
func add_marker() -> void:
	Global.minimap.add_marker(self)

#------------------------------------------------------------------------------|
func state_machine_start(delta: float) -> void:
	if state_machine:
		state_machine._physics_process_state(delta)

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
