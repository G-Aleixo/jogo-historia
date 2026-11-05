## Handles focusing on different windows, blocking movements and such
extends Node

signal can_move_altered(can_move: bool)
var can_move: bool = true:
	set(value):
		can_move = value
		can_move_altered.emit(can_move)
