## For now it's basically just a list of positions that others can index and lerp to
extends Node


var position_list: Array[Vector2] = []
@export var max_positions: int = 64
@export var index_multiplier: int = 8

func add_position(position: Vector2):
	if len(position_list) >= max_positions:
		position_list.pop_back()
	position_list.push_front(position)

func get_position(index: int) -> Vector2:
	var actual_index := clampi(index * index_multiplier, 0, len(position_list) - 1)
	
	if len(position_list) == 0:
		return Vector2(-6942.0, 6942.0)
	else:
		return position_list.get(actual_index)
