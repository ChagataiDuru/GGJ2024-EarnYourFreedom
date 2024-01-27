extends State

class_name  Landing_state


@export var ground_state : State

func on_enter():
	playback.travel("land")
	on_transition.emit(ground_state)
