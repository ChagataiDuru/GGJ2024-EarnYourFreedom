extends Node2D


@onready var hitbox : Area2D = $Sprite2D/Area2D


func _on_area_2d_right_body_entered(body):
	print(body.name)
	if body.has_method("get_hit"):
		body.get_hit()
