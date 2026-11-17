@abstract
class_name Effect
extends Resource

@export var is_debuff: bool

#TODO: define the return types
@abstract
func pre_action(context: CombatContext);

@abstract
func post_action(context: CombatContext);

@abstract
func world_tick();

@abstract
func get_defense(defense: int);

@abstract
func get_agility(agility: int);

@abstract
func get_dodge(dodge: int);

@abstract
func get_accuracy(accuracy: int);

@abstract
func get_luck(luck: int);

@abstract
func get_intellect(intellect: int);
