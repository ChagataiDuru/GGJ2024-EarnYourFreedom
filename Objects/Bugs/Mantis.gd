extends RigidBody2D

func _ready():
	randomize()
	setup()
	
func _on_body_entered(body):
	if body.has_method("get_hit"):
		body.get_hit()

func setup(pos = Vector2(0,0)):
	self.global_position = pos
