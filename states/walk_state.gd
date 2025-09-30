extends State

var destination : Vector2 = Vector2.ZERO

#------------------------------------------------------------------------------|
func enter(prev_state: State) -> void:
	state_owner.animation_player.play("walk")

#------------------------------------------------------------------------------|
func update(delta: float) -> void:
	if state_owner.nav_agent.is_navigation_finished():
		state_owner.moving = false
		state_owner.velocity = Vector2.ZERO
		state_owner.state_machine.change_state("IdleState")
	else: 
		var next_point: Vector2 = state_owner.nav_agent.get_next_path_position()
		var new_velocity: Vector2 = state_owner.global_position.direction_to(next_point) * state_owner.speed
		state_owner.nav_agent.velocity = new_velocity
