extends HBoxContainer

@export var save_button: Button
@export var exit_button: Button

var is_shown := false

func _ready() -> void:
	save_button.pressed.connect(_on_save_button_pressed)
	exit_button.pressed.connect(_on_exit_button_pressed)

func _process(_delta: float) -> void:
	#TODO: move this to a proper menu system and user input  system to just listen to the state signals
	if Input.is_action_just_pressed("menu"):
		if StateSystem.game_state == StateSystem.GameState.IN_GAME:
			visible = true
			StateSystem.game_state = StateSystem.GameState.GAME_MENU
		elif StateSystem.game_state == StateSystem.GameState.GAME_MENU:
			visible = false

func _on_save_button_pressed():
	SavingSystem.save_save()

func _on_exit_button_pressed():
	get_tree().quit()
