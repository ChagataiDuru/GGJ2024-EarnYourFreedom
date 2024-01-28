extends Node

func _ready():
	randomize()

var audio_library = {
	"STONE_HIT":["res://ExternalSources/BreakableThings/sfx/stone_hit.wav", "res://ExternalSources/BreakableThings/sfx/stone_hit_2.wav"],
	"STONE_BREAK":["res://ExternalSources/BreakableThings/sfx/stone_break.wav"],
	"LAND":["res://ExternalSources/BreakableThings/sfx/land.wav", "res://ExternalSources/BreakableThings/sfx/land_2.wav"],
	"LAUGHING":["res://ExternalSources/Sounds/audience-laughing-6323.mp3", "res://ExternalSources/Sounds/crowd_laughingwav-14578.mp3"],
	"DEATH":["res://ExternalSources/Sounds/male-scream-in-fear-123079.mp3"],
	"DIRT_RUN":["res://ExternalSources/Sounds/Running On Dirt - Sound Effect.mp3"],
	"FOREST_RUN":["res://ExternalSources/Sounds/Footsteps Running in Pine Forest  HQ Sound Effects.mp3"],
	"METAL_RUN":["res://ExternalSources/Sounds/Running On Metal Plank [SOUND EFFECT].mp3"],
	"SOUNDTRACK":["res://ExternalSources/Sounds/MiniMusicMan - Crazy La Paint.mp3"],
	"CHEERS":["res://ExternalSources/Sounds/congratulations-deep-voice-172193.mp3"]
}

func play_audio(audio_name):
	#Instantiate scene for audio kinda idk
	var sfx = load("res://ExternalSources/BreakableThings/sfx/SFXTiles.tscn").instantiate()
	#Play Audiou called sahneye ekliyor
	get_node("/root").add_child(sfx)
	var audio = load(audio_library[audio_name][randi()%audio_library[audio_name].size()])
	sfx.stream = audio
	sfx.play()
