extends Node

var unit_states = {
	UNIT_STATES.IdleState: "IdleState",
	UNIT_STATES.WalkState: "WalkState",
	UNIT_STATES.ChaseState: "ChaseState",
	UNIT_STATES.AttackState: "AttackState",
}

enum UNIT_STATES {
	IdleState,
	WalkState,
	ChaseState,
	AttackState,
}

enum RACE {
	Human,
	Orc, 
	Undead,
	Elf,
	Dwarf
}

enum TEAM {
	team1,
	team2,
	team3,
	team4,
	team5,
	team6,
	team7,
	team8
}
