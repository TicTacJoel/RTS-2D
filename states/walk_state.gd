extends State

var destination : Vector2 = Vector2.ZERO

#------------------------------------------------------------------------------|
func enter(prev_state: State) -> void:
	state_owner.play_animation("walk")
	destination = state_owner.get_global_mouse_position()

#------------------------------------------------------------------------------|
func update(delta: float) -> void:
	var dir = (destination - state_owner.global_position)
	if dir.length() < 5:
		state_owner.state_machine.change_state("Idle")
		return
	state_owner.velocity = dir.normalized() * state_owner.move_speed
	state_owner.move_and_slide()
