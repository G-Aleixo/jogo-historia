class_name FollowLeaderComponent
extends Node

@export var leader_node: Node2D

var previous_position: Vector2

func _physics_process(delta: float) -> void:
	if leader_node.global_position != previous_position:
		# maybe also add some check for distance later
		FollowSystem.add_position(leader_node.global_position)
	
	previous_position = leader_node.global_position
