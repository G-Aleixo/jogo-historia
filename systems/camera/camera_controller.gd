extends Camera2D

@export var lerp_speed := 5.0
@export var max_distance := Vector2(10, 10)

var enable_lerp := false

var follow: Node2D

func set_follow(target: Node2D):
	follow = target

func _process(delta: float) -> void:
	if follow is Node2D:
		if enable_lerp:
			global_position = global_position.lerp(follow.global_position, lerp_speed * delta).clamp(follow.global_position - max_distance, follow.global_position + max_distance)
		else:
			global_position = follow.global_position
