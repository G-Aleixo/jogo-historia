class_name CombatContext
extends RefCounted

var user: Combatant
var targets: Array[Combatant] = []
var battle_controller: BattleController

func _init(
	p_user: Combatant = null,
	p_targets: Array[Combatant] = [],
	p_controller: BattleController = null
) -> void:
	user = p_user
	targets = p_targets
	battle_controller = p_controller
