extends Node

func _ready():
	randomize()

var audio_library = {
	"STONE_HIT":["res://ExternalSources/BreakableThings/sfx/stone_hit.wav", "res://ExternalSources/BreakableThings/sfx/stone_hit_2.wav"],
	"STONE_BREAK":["res://ExternalSources/BreakableThings/sfx/stone_break.wav"],
	"LAND":["res://ExternalSources/BreakableThings/sfx/land.wav", "res://ExternalSources/BreakableThings/sfx/land_2.wav"],
}

func play_audio(audio_name):
	#Instantiate scene for audio kinda idk
	var sfx = load("res://ExternalSources/BreakableThings/sfx/SFXTiles.tscn").instantiate()
	#Play Audiou called sahneye ekliyor
	get_node("/root").add_child(sfx)
	var audio = load(audio_library[audio_name][randi()%audio_library[audio_name].size()])
	sfx.stream = audio
	sfx.play()
