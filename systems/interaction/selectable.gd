class_name SelectableComponent extends Component

@export var priority: int

@export var interactibles: Array[InteractibleComponent]

func get_priority() -> int:
	return priority

func serialize(_data: Dictionary) -> Dictionary:
	return {
		"priority": priority
	}

func deserialize(dict: Dictionary, _data: Dictionary):
	priority = dict["priority"]
