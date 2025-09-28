extends Node

class_name State

var state_owner : Node

#------------------------------------------------------------------------------|
func enter(prev_state: State) -> void:
	pass

#------------------------------------------------------------------------------|
func exit(next_state: State) -> void:
	pass

#------------------------------------------------------------------------------|
func update(delta: float) -> void:
	pass

#------------------------------------------------------------------------------|
func handle_input(event: InputEvent) -> void:
	pass
