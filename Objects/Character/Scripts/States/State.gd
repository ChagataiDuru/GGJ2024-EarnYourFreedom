extends Node

class_name State

@export var  can_move : bool = true

var playback :AnimationNodeStateMachinePlayback
var character : CharacterBody2D

func handle_input(event : InputEvent):
	pass
	
func on_enter():
	pass
func on_exit():
	pass
func state_process(delta):
	pass
signal on_transition(new_state: State)
