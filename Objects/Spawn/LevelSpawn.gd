extends Node


func _ready():
	var main_character = $MainCharacter
	print("ch: ",main_character)
	var target_position = self.position
	print(target_position)
	main_character.position = target_position

