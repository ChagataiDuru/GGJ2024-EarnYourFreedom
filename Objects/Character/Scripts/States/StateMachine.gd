extends Node

class_name StateMachine

var states : Array[State]


@export var current_state : State
@export var character : CharacterBody2D
@export var animation_tree : AnimationTree


func _ready():
	for child in get_children():
		if(child is State):
			# TODO set up states
			child.character = character
			child.playback= animation_tree["parameters/playback"]
			states.append(child)
			
		else:
			push_warning("Child " + child.name  + " is not a State.")
			

func _physics_process(delta):
	current_state.state_process(delta)
	
func check_can_move():
	return current_state.can_move


	
func _input(event:InputEvent):
	current_state.handle_input(event)
	
func _on_transition(new_state):
	if(current_state):
		current_state.on_exit()
		
	current_state= new_state
	current_state.on_enter()

func get_current_state_name():
	return current_state.name
