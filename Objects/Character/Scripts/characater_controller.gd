extends CharacterBody2D


@export var speed = 300.0
@export var acceleration = 200.0
@export var friction = 500.0
@export var jump_velocity = -300.0
@export var gravity_scale = 1.0
@export var air_resistance = 200.0
@export var air_acceleration = 300.0

var air_jump = false
var death_collision_check: bool

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animation_tree = $AnimationTree
@onready var animated_sprite = $AnimatedSprite2D
@onready var state_machine : StateMachine = $StateMachine
@onready var coyote_jump_timer = $CoyoteTimer
@onready var death_timer = $DeathTimer 

func _ready():
	death_collision_check = false
	animation_tree.active = true
func _physics_process(delta):
	apply_gravity(delta)
	handle_jump()
	var input_axis = Input.get_axis("LEFT", "RIGHT")
	handle_acceleration(input_axis,delta)
	handle_air_acceleration(input_axis,delta)
	apply_friction(input_axis,delta)
	apply_air_resistance(input_axis,delta)
	var was_on_floor = is_on_floor()
	move_and_slide()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().name == "TileMapEnemy" and !death_collision_check:
			print("I collided with ", collision.get_collider().name)
			death_collision_check = true
			get_hit()

	var left_ledge = was_on_floor and not is_on_floor() and velocity.y >= 0
	if left_ledge:
		coyote_jump_timer.start()

func apply_gravity(delta):
	if not is_on_floor(): 
		velocity.y += gravity * gravity_scale * delta
		
func handle_jump():
	if is_on_floor(): air_jump = true
	if is_on_floor() or coyote_jump_timer.time_left > 0.0:
		if Input.is_action_just_pressed("JUMP"):
			velocity.y = jump_velocity
	if not is_on_floor():
		if Input.is_action_just_released("JUMP") and velocity.y < jump_velocity / 2:
			velocity.y = jump_velocity / 2
		if Input.is_action_just_pressed("JUMP") and air_jump:
			velocity.y = jump_velocity * 0.5
			air_jump = false
			
func handle_acceleration(input_axis,delta):
	if not is_on_floor(): return
	if (input_axis != 0 and state_machine.check_can_move()):
		velocity.x = move_toward(velocity.x, speed * input_axis, acceleration * delta)
		animated_sprite.flip_h = true if input_axis < 0  else false
		animation_tree["parameters/HorizontalMovement/blend_position"] = input_axis
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		animation_tree["parameters/HorizontalMovement/blend_position"] = 0
func handle_air_acceleration(input_axis,delta):
	if is_on_floor(): return
	if input_axis !=0:
		velocity.x = move_toward(velocity.x, speed*input_axis, air_acceleration * delta)
func apply_friction(input_axis,delta):
	if input_axis == 0 and is_on_floor():
		velocity.x = move_toward(velocity.x,0, friction*delta)
func apply_air_resistance(input_axis,delta):
	if input_axis == 0 and not is_on_floor():
		velocity.x = move_toward(velocity.x, 0, air_resistance * delta)

func apply_central_impulse(vector):
	velocity.x = vector.x
	velocity.y = vector.y

func get_hit() -> void:
	death_timer.start(randf_range(1.5,2.5))
	var tween = create_tween().set_loops(4)
	tween.tween_property(animated_sprite, "modulate", Color(1, 0, 0), .1)
	animated_sprite.play("death")
	tween.tween_property(animated_sprite, "modulate", Color(1, 1, 1), .1)
	animated_sprite.play("death")

func _on_death_timer_timeout():
	get_tree().reload_current_scene()




