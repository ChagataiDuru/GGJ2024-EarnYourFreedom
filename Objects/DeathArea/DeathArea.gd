extends Area2D

@onready var timer = $Timer

func _ready():
	randomize()
	timer.start(randf_range(12,18))

func _on_timer_timeout():
	SignalManager.emit_signal("START_RESTART_PROCEDURE")
