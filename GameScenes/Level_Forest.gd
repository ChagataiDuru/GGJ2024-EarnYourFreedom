extends Node2D

@onready var spawn_point = $SpawnPoint
@onready var tilemap = $TileMap
@onready var character = $MainCharacter


func _ready():
	var target_position = spawn_point.position
	character.position = target_position
	character.can_double_jump = true
