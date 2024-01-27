extends State

class_name  Air_state

@export var landing_state : State

var is_emitted : bool = false
var is_falling: bool = false
func state_process(delta):
	if(character.velocity.y > 0 && !is_falling):
		playback.travel("land")  
		is_falling =true
		
	if(character.is_on_floor() && !is_emitted):
		on_transition.emit(landing_state)
		is_emitted =true
		
func on_enter():
	is_emitted = false
	is_falling = false


