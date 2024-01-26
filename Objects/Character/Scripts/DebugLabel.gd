extends Label


@export var state_machine :StateMachine 
# Called when the node enters the scene tree for the first time.
func _ready():
	text=  "State: " + state_machine.get_current_state_name()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text=   "State: " + state_machine.get_current_state_name()
	pass
