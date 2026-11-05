extends HBoxContainer

@export var save_button: Button
@export var exit_button: Button

var is_shown := false

func _ready() -> void:
	save_button.pressed.connect(_on_save_button_pressed)
	exit_button.pressed.connect(_on_exit_button_pressed)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("menu"):
		is_shown = not is_shown
		print(is_shown)
		visible = is_shown
		FocusingSystem.can_move = not is_shown
		
		# emit something to make the player stop moving

func _on_save_button_pressed():
	SavingSystem.save_save()

func _on_exit_button_pressed():
	get_tree().quit()
