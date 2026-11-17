# simple attack
@abstract
class_name CombatAction
extends SerdeJSON

enum ActionType {
	WEAPON,
	ABILITY,
	ITEM
}

enum TargetType {
	NONE,
	SELF,
	SINGLE_ALLY,
	ALL_ALLIES,
	SINGLE_ENEMY,
	ALL_ENEMIES,
	ANY_SINGLE
}

@export var action_name: String
@export_multiline var description: String
@export var icon: Texture2D

@export var action_type: ActionType
@export var target_type: TargetType

@export var ap_cost: int = 1 # moral
@export var priority: int = 0

func can_execute(context: CombatContext) -> bool:
	if context == null:
		return false

	if context.user == null:
		return false

	if not context.user.is_alive():
		return false

	if context.user.action_points < ap_cost:
		return false

	return true

func execute(_context: CombatContext) -> void:
	push_error("CombatAction.execute() not implemented")

func on_action_finished(_context: CombatContext) -> void:
	pass
