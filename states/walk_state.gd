extends State

#------------------------------------------------------------------------------|
func enter(prev_state: State) -> void:
	if state_owner.has_method("play_animation"):
		state_owner.play_animation("walk")

#------------------------------------------------------------------------------|
func update(delta: float) -> void:
	var input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if input_vector == Vector2.ZERO:
		state_owner.state_machine.change_state("Idle")
		return

	state_owner.velocity = input_vector * state_owner.speed
	state_owner.move_and_slide()
