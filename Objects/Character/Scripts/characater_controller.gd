extends CharacterBody2D


@export var speed = 300.0


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animation_tree = $AnimationTree
@onready var animated_sprite = $AnimatedSprite2D
@onready var state_machine : StateMachine = $StateMachine
@onready var laser_eyes = $LaserEyes

var isOnGround = true

func _ready():
	animation_tree.active =true
func _physics_process(delta):
	
	if Input.is_action_pressed("Left Click"):
		laser_eyes.shoot_laser(get_mouse_look_dir()) 
	
	if Input.is_action_just_released("Left Click"):
		laser_eyes.erase_laser_all()
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	var direction = Input.get_axis("LEFT", "RIGHT")
	if (direction && state_machine.check_can_move()):
		# state_machine.check_can_move() enables us to add unmoveable states
		# just change the variable 'can_move' in the  'state' 
		velocity.x = direction * speed
		# arity operator  (true_result) (if statement)( else) (false_result) just to remember 
		animated_sprite.flip_h = true if direction < 0  else false
		if(isOnGround):
			animation_tree["parameters/HorizontalMovement/blend_position"] = direction
		
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		animation_tree["parameters/HorizontalMovement/blend_position"] = 0
	
	move_and_slide()

func get_mouse_look_dir():
	return (get_global_mouse_position() - laser_eyes.global_position).normalized()
