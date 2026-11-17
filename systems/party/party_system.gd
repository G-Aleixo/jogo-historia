extends Node

signal party_member_added
#signal party_member_removed

var party_members: Array[PartyMemberData]

@onready var battle_controller: BattleController = $BattleController

func begin_combat(enemies: Array[PartyMemberData]) -> void:
	battle_controller.start_battle(
		PartySystem.party_members,
		enemies
	)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SavingSystem.to_save.append(self)
	
	#TODO: REMOVE THIS, JUST A DEBUG FOR NOW
	
	var member = PartyMemberData.new()
	
	member.id = "test"
	member.display_name = "Tester member"
	
	new_party_member(member)

func new_party_member(member: PartyMemberData):
	party_members.append(member)
	party_member_added.emit()

func get_id() -> String:
	return "party_system"

func serialize() -> Dictionary:
	var members = []
	
	for party_member in party_members:
		members.append(party_member.serialize())
	
	return {
		"party_members": members
	}

func deserialize(data: Dictionary):
	for party_member in data["party_members"]:
		var member = PartyMemberData.new()
		member.deserialize(party_member)
		new_party_member(member)
