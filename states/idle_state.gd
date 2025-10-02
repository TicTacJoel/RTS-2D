extends State

#------------------------------------------------------------------------------|
func enter(prev_state: State) -> void:
	idle()

#------------------------------------------------------------------------------|
func update(delta: float) -> void:
	if state_owner.moving:
		walk()
	#attack()

#------------------------------------------------------------------------------|
func idle() -> void:
	state_owner.moving = false
	state_owner.velocity = Vector2.ZERO
	state_owner.animation_player.play("idle")

#------------------------------------------------------------------------------|
func walk() -> void:
	state_owner.state_machine.change_state("WalkState")

#------------------------------------------------------------------------------|
func attack() -> void:
	pass
