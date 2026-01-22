extends State

var stop_distance: float = 50.0
var idleState = Types.unit_states[Types.UNIT_STATES.IdleState]
var attackState = Types.unit_states[Types.UNIT_STATES.AttackState]

func enter(prev_state):
	print("Entered chase state")
	state_owner.animation_player.play("walk")
	stop_distance = state_owner.vision_range

func update(delta):
	state_owner.update_target_position()
	
	if not is_instance_valid(state_owner.target):
		state_owner.state_machine.change_state(idleState)
		return
	
	var distance = state_owner.global_position.distance_to(state_owner.target.global_position)
	if distance <= stop_distance:
		state_owner.state_machine.change_state(attackState)
		return
	
	if not state_owner.target:
	#if state_owner.nav_agent.is_navigation_finished():
		state_owner.nav_agent.target_position = state_owner.target.global_position
