extends Node2D

var level_time: float = 0.0	# the amount of time that the player has been in the current level (does not reset upon death)
var is_timer_running: bool = false	# whether the speedrun timer should be running

var level_deaths: int = 0	# amount of times the player has died in the current level


func _process(delta: float) -> void:
	if is_timer_running:
		level_time += delta


func start_timer() -> void:
	is_timer_running = true


func stop_timer() -> void:
	is_timer_running = false


func reset_timer() -> void:
	is_timer_running = false
	level_time = 0.0
