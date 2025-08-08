extends Node2D

var level_time: float = 0.0
var is_timer_running: bool = false


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
