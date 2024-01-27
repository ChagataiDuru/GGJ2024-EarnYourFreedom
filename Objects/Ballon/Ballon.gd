extends Node2D

@export var impulse: float

@onready var left_hitbox : Area2D = $Sprite2D/Area2DLeft
@onready var right_hitbox : Area2D = $Sprite2D/Area2DRight

func _on_area_2d_right_body_entered(body):
	print(body.name)
	if body.has_method("get_hit"):
		var direction = (body.global_position - get_global_position()).normalized()
		var force = direction * impulse
		body.apply_central_impulse(force)


func _on_area_2d_left_body_entered(body):
	print(body.name)
	if body.has_method("get_hit"):
		var direction = (body.global_position - get_global_position()).normalized()
		var force = direction * impulse
		body.apply_central_impulse(force)
