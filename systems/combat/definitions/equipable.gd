@abstract
class_name Equipable
extends Resource

enum Type {
	HEAD,
	TORSO,
	HANDS,
	LEGS,
	FEET,
	WEAPON
}

@export var combat_actions: Array[CombatAction]
