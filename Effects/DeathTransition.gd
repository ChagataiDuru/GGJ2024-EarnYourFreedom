extends Node2D

@onready var timer = $Timer
@onready var animation_player = $AnimationPlayer
@onready var player = $"../MainCharacter"



func _process(delta):
	if player.death_collision_check:
		self.position = player.position
		animation_player.play("DeathAnim")
		animation_player.play("StartAnim")
