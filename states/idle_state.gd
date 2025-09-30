extends State

#------------------------------------------------------------------------------|
func enter(prev_state: State) -> void:
	state_owner.moving = false
	state_owner.velocity = Vector2.ZERO
	state_owner.animation_player.play("idle")

#------------------------------------------------------------------------------|
func update(delta: float) -> void:
	if state_owner.moving:
		state_owner.state_machine.change_state("WalkState")
