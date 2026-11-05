## Handles all player interactions
extends Node2D

enum State {
	IDLE,
	SELECTED,
	INTERACTING
}

signal state_changed(state: State)

var selected: SelectableComponent
var state: State = State.IDLE:
	set(value):
		state = value
		state_changed.emit(state)

var data = {}

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			handle_right_mouse_click(event)

func _process(_delta: float) -> void:
	#TODO: remove selected when can't reach
	
	if Input.is_action_just_pressed("interact") and state == State.SELECTED:
		#TODO: use ui to determine the interaction
		interact_with_selected("")
		
		SavingSystem.save_save()
		SavingSystem.load_save()

func get_collisions_at_position(pos: Vector2) -> Array:
	var space_state := get_world_2d().direct_space_state
	var query := PhysicsShapeQueryParameters2D.new()
	var shape = CircleShape2D.new()
	shape.radius = 5
	query.shape = shape
	query.transform = Transform2D(0, pos)
	
	query.collide_with_areas = true
	query.collide_with_bodies = true
	query.collision_mask = 1
	
	var results := space_state.intersect_shape(query, 32)
	
	var colliders = []
	for result in results:
		colliders.append(result["collider"])
	
	return colliders

func handle_right_mouse_click(_event: InputEventMouseButton):
	#TODO: handle interactible tiles
	# handling just objects right now
	var world_pos = get_global_mouse_position()
	
	var colliders := get_collisions_at_position(world_pos)
	
	if len(colliders) == 0:
		state = State.IDLE
		selected = null
	
	var stop := false
	#TODO: use another way to check components
	for collider in colliders:
		if stop:
			break
			
		for sibling in collider.get_children():
			if sibling is SelectableComponent:
				var sibling2: SelectableComponent = sibling
				state = State.SELECTED
				selected = sibling2
				
				stop = true
				break
	
	# just pick the first interactible for now

func interact_with_selected(interaction: StringName):
	# empty interaction is the first one
	var to_interact: InteractibleComponent
	if interaction == "":
		to_interact = selected.interactibles.get(0)
	else:
		for interactible in selected.interactibles:
			if interactible.interaction_id == interaction:
				to_interact = interactible
				break
	if to_interact and to_interact.can_interact(data):
		#TODO: add interaction data
		state = State.INTERACTING
		
		to_interact.interaction_finished.connect(
			func():
				state = State.SELECTED
		)
		
		#TODO: do interacting state
		to_interact.interact(data)
