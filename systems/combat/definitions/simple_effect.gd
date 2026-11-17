class_name SimpleEffect
extends Effect

@export var defense_modifier: int = 10
@export var agility_modifier: int = 10
@export var dodge_modifier: int = 10
@export var accuracy_modifier: int = 10
@export var luck_modifier: int = 10
@export var intellect_modifier: int = 10

func pre_action(context: CombatContext):
	pass

func post_action(context: CombatContext):
	pass

func world_tick():
	pass

func get_defense(defense: int):
	return defense + defense_modifier

func get_agility(agility: int):
	return agility + agility_modifier

func get_dodge(dodge: int):
	return dodge + dodge_modifier

func get_accuracy(accuracy: int):
	return accuracy + accuracy_modifier

func get_luck(luck: int):
	return luck + luck_modifier

func get_intellect(intellect: int):
	return intellect + intellect_modifier
