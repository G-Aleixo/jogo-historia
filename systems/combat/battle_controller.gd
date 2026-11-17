class_name BattleController
extends Node

signal battle_started
signal battle_ended(victory: bool)

signal action_performed(
	user: Combatant,
	action: CombatAction,
	targets: Array[Combatant]
)

var party: Array[Combatant] = []
var enemies: Array[Combatant] = []

var turn_manager := TurnManager.new()

var battle_active: bool = false

func start_battle(
	party_data: Array[PartyMemberData],
	enemy_data: Array[PartyMemberData]
) -> void:

	party.clear()
	enemies.clear()

	for data in party_data:
		var combatant := Combatant.new()
		combatant.initialize(data, true)
		party.append(combatant)

	for data in enemy_data:
		var combatant := Combatant.new()
		combatant.initialize(data, false)
		enemies.append(combatant)

	var all_combatants: Array[Combatant] = []
	all_combatants.append_array(party)
	all_combatants.append_array(enemies)

	turn_manager.initialize(all_combatants)

	battle_active = true

	battle_started.emit()
	turn_manager.start()


func perform_action(
	user: Combatant,
	action: CombatAction,
	targets: Array[Combatant]
) -> bool:

	if not battle_active:
		return false

	if user != turn_manager.current_combatant:
		return false

	var context := CombatContext.new(
		user,
		targets,
		self
	)

	if not action.can_execute(context):
		return false

	if not validate_targets(action, user, targets):
		return false

	user.action_points -= action.ap_cost

	action.execute(context)
	action.on_action_finished(context)

	action_performed.emit(user, action, targets)

	check_battle_end()

	return true


func validate_targets(
	action: CombatAction,
	user: Combatant,
	targets: Array[Combatant]
) -> bool:

	match action.target_type:
		CombatAction.TargetType.NONE:
			return targets.is_empty()

		CombatAction.TargetType.SELF:
			return targets.size() == 1 and targets[0] == user

		CombatAction.TargetType.SINGLE_ALLY:
			return targets.size() == 1 and targets[0] in party

		CombatAction.TargetType.ALL_ALLIES:
			return targets.size() > 0 and targets.all(
				func(target): return target in party
			)

		CombatAction.TargetType.SINGLE_ENEMY:
			return targets.size() == 1 and targets[0] in enemies

		CombatAction.TargetType.ALL_ENEMIES:
			return targets.size() > 0 and targets.all(
				func(target): return target in enemies
			)

		CombatAction.TargetType.ANY_SINGLE:
			return targets.size() == 1 and (
				targets[0] in party or targets[0] in enemies
			)

	return false


func end_turn() -> void:
	if not battle_active:
		return

	turn_manager.advance_turn()


func check_battle_end() -> void:
	var party_alive := party.any(
		func(member): return member.is_alive()
	)

	var enemies_alive := enemies.any(
		func(member): return member.is_alive()
	)

	if not enemies_alive:
		finish_battle(true)

	elif not party_alive:
		finish_battle(false)


func finish_battle(victory: bool) -> void:
	if not battle_active:
		return

	battle_active = false
	battle_ended.emit(victory)
