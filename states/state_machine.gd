extends Node

class_name StateMachine

var states := {}
var current_state : State = null
var character : Node

#------------------------------------------------------------------------------|
func _ready() -> void:
	character = get_parent()
	for child in get_children():
		if child is State:
			states[child.name] = child
			child.state_owner = character
	
	# Start in Idle if available
	call_deferred("start")

#------------------------------------------------------------------------------|
func start() -> void:
	if "IdleState" in states:
		change_state("IdleState")

#------------------------------------------------------------------------------|
func _physics_process_state(delta: float) -> void:
	if current_state:
		current_state.update(delta)

#------------------------------------------------------------------------------|
func change_state(new_state_name: String) -> void:
	if not states.has(new_state_name):
		push_warning("State %s not found!" % new_state_name)
		return
	
	var new_state = states[new_state_name]
	if current_state:
		current_state.exit(new_state)
	var prev_state = current_state
	current_state = new_state
	current_state.enter(prev_state)

#------------------------------------------------------------------------------|
func _unhandled_input(event: InputEvent) -> void:
	if current_state:
		current_state.handle_input(event)
