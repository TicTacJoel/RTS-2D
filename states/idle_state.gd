extends State

#------------------------------------------------------------------------------|
func enter(prev_state: State) -> void:
	owner.velocity = Vector2.ZERO
	owner.play_animation("idle")

#------------------------------------------------------------------------------|
func update(delta: float) -> void:
	if Input.is_action_pressed("move"):
		owner.state_machine.change_state("Walk")
	# If there's a target in range, maybe auto-attack
	#if state_owner.target and state_owner.global_position.distance_to(state_owner.target.global_position) <= state_owner.attack_range:
		#state_owner.state_machine.change_state("Attack")
