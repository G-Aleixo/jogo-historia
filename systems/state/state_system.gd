## Handles focusing on different windows, blocking movements and such
extends Node

# emulate a small state machine with an unknown amount of states basically
# this system IS fixed to the game logic and things
#TODO: make a full diagram of the state transitions and add missing states once there's an actual mechanics docs.

# IN_GAME <-> GAME_MENU
# MAIN_MENU -> IN_GAME
# GAME_MENU -> MAIN_MENU
# IN_GAME <-> COMBAT
# IN_GAME <-> WAR
enum GameState {
	IN_GAME,
	MAIN_MENU,
	GAME_MENU,
	COMBAT,
	WAR # unused for now
}

var game_state: GameState = GameState.IN_GAME:
	set(value):
		game_state_altered.emit(game_state, value)
		game_state = value

signal game_state_altered(from: GameState, to: GameState)
