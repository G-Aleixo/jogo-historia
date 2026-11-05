class_name PartyMemberData
extends SerdeJSON

@export var id: StringName
@export_placeholder("No Name Set") var display_name: String

@export_category("Health")
@export_range(0, 100, 1) var head_health: int = 100
@export_range(0, 100, 1) var torso_health: int = 100
@export_range(0, 100, 1) var arms_health: int = 100
@export_range(0, 100, 1) var leg_health: int = 100

@export_category("Extra data")
@export var extra_data: Dictionary

func serialize() -> Dictionary:
	return {
		"id": id,
		"display_name": display_name,
		
		"head_health": head_health,
		"torso_health": torso_health,
		"arms_health": arms_health,
		"leg_health": leg_health,

		"extra_data": extra_data,
	}

func deserialize(data: Dictionary):
	id = data["id"]
	display_name = data["display_name"]
	
	head_health = data["head_health"]
	torso_health = data["torso_health"]
	arms_health = data["arms_health"]
	leg_health = data["leg_health"]

	extra_data = data["extra_data"]
