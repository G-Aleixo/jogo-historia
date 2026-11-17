class_name Combatant
extends Resource

# change this to fit the specs

var id: StringName
var display_name: String

var party_data: PartyMemberData

var is_player_controlled: bool = false

var action_points: int = 100

var is_defending: bool = false

func initialize(
	data: PartyMemberData,
	player_controlled: bool = false
) -> void:
	party_data = data

	id = data.id
	display_name = data.display_name

	is_player_controlled = player_controlled

func is_alive() -> bool:
	return party_data != null and party_data.is_alive()

func is_incapacitated() -> bool:
	return party_data == null or party_data.is_incapacitated()

func reset_turn() -> void:
	action_points = party_data.moral
	is_defending = false
