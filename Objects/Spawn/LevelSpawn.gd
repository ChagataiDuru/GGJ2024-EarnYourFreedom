extends Node2D

@onready var main_character = $MainCharacter

func _ready():
	print("ch: ",main_character)
	var target_position = self.position
	print(target_position)
	main_character.position = target_position

