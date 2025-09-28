extends State

#------------------------------------------------------------------------------|
func enter(prev_state: State) -> void:
	owner.velocity = Vector2.ZERO
	owner.play_animation("idle")

#------------------------------------------------------------------------------|
func update(delta: float) -> void:
	if Input.is_action_pressed("move"):
		owner.state_machine.change_state("Walk")
