extends Area2D

func _on_body_entered(body):
	if body.has_method("get_hit"):
		get_tree().change_scene_to_file("res://GameScenes/Level_City.tscn")
