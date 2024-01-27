extends Node2D

func _on_area_2d_detect_body_entered(body):
	print(body.name)
	if body.has_method("get_hit"):
		self.position.y -= 8

func _on_area_2d_body_entered(body):
	print(body.name)
	if body.has_method("get_hit"):
		body.get_hit()
