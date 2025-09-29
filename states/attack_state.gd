extends State

var cooldown_timer := 0.0

#------------------------------------------------------------------------------|
func enter(prev_state: State) -> void:
	state_owner.play_animation("attack")
	cooldown_timer = 0.0

#------------------------------------------------------------------------------|
func update(delta: float) -> void:
	if not state_owner.target:
		state_owner.state_machine.change_state("Idle")
		return

	var distance = state_owner.global_position.distance_to(state_owner.target.global_position)
	if distance > state_owner.attack_range:
		state_owner.state_machine.change_state("Move")
		return

	cooldown_timer -= delta
	if cooldown_timer <= 0.0:
		perform_attack()
		cooldown_timer = state_owner.attack_cooldown

#------------------------------------------------------------------------------|
func perform_attack() -> void:
	print("%s attacks %s for %d damage" % [state_owner.name, state_owner.target.name, state_owner.attack_damage])
	# Apply damage logic here
