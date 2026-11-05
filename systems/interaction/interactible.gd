@abstract
class_name InteractibleComponent extends Component

signal interaction_finished

@export var interaction_id: StringName

@abstract
func can_interact(data: Dictionary) -> bool;

@abstract
func interact(data: Dictionary) -> void;
