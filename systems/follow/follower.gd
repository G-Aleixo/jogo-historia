class_name FollowFollowerComponent
extends Node

# should be from 1-n
@export var index: int
@export var follower_node: Node2D

func _physics_process(delta: float) -> void:
	# tie this into another component to orient the character correctly
	var new_pos = FollowSystem.get_position(index)
	if new_pos != null:
		follower_node.global_position = new_pos
