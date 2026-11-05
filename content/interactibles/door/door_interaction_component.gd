class_name DoorInteractionComponent extends InteractibleComponent

@export var collider: CollisionShape2D
var open := false

func can_interact(data: Dictionary) -> bool:
	return true

func interact(data: Dictionary) -> void:
	open = not open
	
	print("setting door state to ", open)
	
	if collider:
		collider.set_deferred("disabled", open)
	else:
		printerr("Door component ", self, " does not have collider set")
	
	interaction_finished.emit()

func serialize(_data: Dictionary) -> Dictionary:
	return {
		"open": open
	}

func deserialize(dict: Dictionary, _data: Dictionary):
	open = dict["open"]
