extends State

class_name  Ground_state

@export var air_state : State
func state_process(delta):
	if !character.is_on_floor():
		on_transition.emit(air_state)
	
func handle_input(event : InputEvent):
	if event.is_action_pressed("JUMP") && character.is_on_floor():
		playback.travel("jump")
		on_transition.emit(air_state)
	


