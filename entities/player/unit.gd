extends CharacterBody2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var selected_box: Panel = $Selected
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var state_machine: StateMachine = $StateMachine

# Stats
var health: int
var armor: int
var damage: int
var aoe_size: float
var attack_speed: float
var attack_range: float
var vision_range: float
var movement_speed: float
var cost: int
var production_time: float
var description: String
@export var team: Types.TEAM
@export var race: Types.RACE
@export var unit_type: String

var follow_cursor: bool = false
var target: Variant = null
var moving: bool = false
var selected = false

# States
var idleState = Types.unit_states[Types.UNIT_STATES.IdleState]
var walkState = Types.unit_states[Types.UNIT_STATES.WalkState]
var chaseState = Types.unit_states[Types.UNIT_STATES.ChaseState]
var attackState = Types.unit_states[Types.UNIT_STATES.AttackState]

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
	if target != null:
		update_target_position()
	state_machine_start(delta)

#------------------------------------------------------------------------------|
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("RightClick"):
		follow_cursor = true
	
	if event.is_action_released("RightClick"):
		follow_cursor = false

#------------------------------------------------------------------------------|
func get_stats() -> void:
	## get stats for current unit according to race and unit name
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
	## Add a minimap marker to the unit on spawn 
	Global.minimap.add_marker(self)

#------------------------------------------------------------------------------|
func state_machine_start(delta: float) -> void:
	if state_machine:
		state_machine._physics_process_state(delta)

#------------------------------------------------------------------------------|
func set_target_position(pos: Vector2) -> void:
	## if the target position is no enemy unit, set the target as Vector2 position
	target = pos
	nav_agent.target_position = pos
	moving = true

#------------------------------------------------------------------------------|
func set_target_node(node: Node2D) -> void:
	## if the target position is a enemy unit, set the target as Node2D position
	target = node
	nav_agent.target_position = node.global_position
	moving = true

#------------------------------------------------------------------------------|
func update_target_position():
	if target is Node2D and is_instance_valid(target):
		nav_agent.target_position = target.global_position

#------------------------------------------------------------------------------|
func set_selected(isSelected: bool):
	selected = isSelected
	selected_box.visible = isSelected

#------------------------------------------------------------------------------|
func on_player_attack_command(enemy: Node2D) -> void:
	print("Attack command")
	set_target_node(enemy)
	state_machine.change_state(chaseState)

#------------------------------------------------------------------------------|
func on_player_move_command(pos: Vector2) -> void:
	print("Move command")
	set_target_position(pos)
	state_machine.change_state(walkState)

#------------------------------------------------------------------------------|
func _on_died():
	emit_signal("died")
	queue_free()

#------------------------------------------------------------------------------|
func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity
	move_and_slide()

#------------------------------------------------------------------------------|
func _on_detection_area_body_entered(body: Node2D) -> void:
	## Chase enemy if he enters the detection area 
	## and no other movement command is given
	
	print("Body entered with team ", body.team)
	print("My own team ", team)
	# TODO: add all enemies to a list, and when there is no target anymore, get the next one
	if body.team != team and not target:
		print("chasing target")
		target = body
		state_machine.change_state(chaseState)

#------------------------------------------------------------------------------|
func _on_detection_area_body_exited(body: Node2D) -> void:
	pass
	# TODO: remove enemy from enemies list
	#if body.is_in_group("Enemy"):
		#target = null
		#state_machine.change_state(idleState)

#------------------------------------------------------------------------------|
func _on_attack_area_body_entered(body: Node2D) -> void:
	pass # Replace with function body.

#------------------------------------------------------------------------------|
func _on_attack_area_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
