class_name ConfettiSpawnerInteractionComponent extends InteractibleComponent

var emitting := false
@export var emitter: CPUParticles2D

func _ready() -> void:
	emitter.finished.connect(on_emitter_finished)

func can_interact(_data: Dictionary) -> bool:
	return not emitting

func interact(_data: Dictionary) -> void:
	emitting = true
	emitter.emitting = true

func serialize(_data: Dictionary) -> Dictionary:
	return {
		"emitting": emitting
	}

func deserialize(dict: Dictionary, _data: Dictionary):
	emitting = dict["emitting"]

func on_emitter_finished():
	emitting = false
	interaction_finished.emit()
