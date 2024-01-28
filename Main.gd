extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready():
	animation_player.play("StartAnim")

func _on_quit_pressed():
	get_tree().quit()


func _on_play_pressed():
	AudioManager.play_audio("CHEERS")
	get_tree().change_scene_to_file("res://GameScenes/Level_Dungeon.tscn")
