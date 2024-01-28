extends Node2D

func _on_play_pressed():
	AudioManager.play_audio("CHEERS")
	get_tree().change_scene_to_file("res://GameScenes/Level_Dungeon.tscn")
