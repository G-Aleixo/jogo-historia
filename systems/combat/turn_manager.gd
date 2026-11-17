class_name TurnManager
extends Resource

signal turn_started(combatant: Combatant)
signal turn_ended(combatant: Combatant)
signal round_started(round_number: int)

var combatants: Array[Combatant] = []

var current_index: int = -1
var current_round: int = 0

var current_combatant: Combatant:
	get:
		if current_index < 0 or current_index >= combatants.size():
			return null

		return combatants[current_index]

func initialize(p_combatants: Array[Combatant]) -> void:
	combatants = p_combatants
	current_index = -1
	current_round = 0

func start() -> void:
	current_round = 1
	round_started.emit(current_round)
	advance_turn()

func advance_turn() -> void:
	if current_combatant != null:
		turn_ended.emit(current_combatant)

	var checked := 0

	while checked < combatants.size():
		current_index += 1

		if current_index >= combatants.size():
			current_index = 0
			current_round += 1
			round_started.emit(current_round)

		var candidate := combatants[current_index]

		checked += 1

		if candidate.is_alive() and not candidate.is_incapacitated():
			candidate.reset_turn()
			turn_started.emit(candidate)
			return

	current_index = -1
