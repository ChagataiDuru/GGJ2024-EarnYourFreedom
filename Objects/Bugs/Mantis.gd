extends CharacterBody2D

@export var gravity_scale : float = 1.2
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	randomize()
	setup()
	
func _physics_process(delta):
	if not is_on_floor(): 
		velocity.y += gravity * gravity_scale * delta
	move_and_slide()
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().name == "MainCharacter":
			print("I collided with ", collision.get_collider().name)
			collision.get_collider().get_hit()
			self.queue_free()

func setup(pos = Vector2(0,0)):
	self.global_position = pos
