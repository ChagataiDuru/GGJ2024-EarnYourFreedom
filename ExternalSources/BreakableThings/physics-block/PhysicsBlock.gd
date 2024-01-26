extends RigidBody2D
@export var tile_px_size = 8

@onready var sprite = $Sprite2D
@onready var timer = $Timer

var block_type = ""
var health = 10.0


func _ready():
	randomize()
	timer.start(randf_range(3.0,6.0))

func setup(coords:Vector2i,pos:Vector2,_block_type = "DIRT",apply_force = true):
	block_type = _block_type

	sprite.texture.region.size = Vector2(tile_px_size,tile_px_size)
	sprite.texture.region.position = Vector2(coords.x,coords.y) * tile_px_size
	self.global_position = pos

	if apply_force:
		var random_direction = Vector2(randf_range(-1,1), randf_range(-1,1))
		var random_strength = randf_range(10.0, 50.0)
		var force = random_direction * random_strength
		self.look_at(random_direction * 10)
		apply_force(force * 100, random_direction * 10)

func destroy():
	SignalManager.emit_signal("SPAWN_BLOCK_PARTICLES",block_type, 4, self.global_position)
	AudioManager.play_audio("STONE_BREAK")
	self.queue_free()
	
func _on_timer_timeout():
	destroy()

func _on_body_entered(body):
	AudioManager.play_audio("LAND")
	var speed = linear_velocity.length()
	health -= speed/2 #If falls higher destroy quicker
	SignalManager.emit_signal("SPAWN_BLOCK_PARTICLES",block_type, 4, self.global_position)
	if health <= 0:
		destroy()

func _on_area_2d_body_entered(body):
	var speed = linear_velocity.length()
