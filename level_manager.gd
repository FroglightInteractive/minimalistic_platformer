extends Node

# "level name": preload("level path")
const LEVELS: Dictionary = {
	"Level 1": preload("res://Levels/level_1.tscn"),
	"Level 2": preload("res://Levels/level_2.tscn"),
	"Level 3": preload("res://Levels/level_3.tscn")
}

var current_level: int = 3


func _ready() -> void:
	next_level()


func next_level() -> void:
	for child in get_children():
		child.queue_free()
	
	$"../Player".global_position = Vector2.ZERO
	$"../Player".velocity = Vector2.ZERO
	
	var level_id: String = "Level " + str(current_level)
	var level = LEVELS[level_id].instantiate()
	add_child(level)
	current_level += 1


func retry() -> void:
	$"../DeathMenu".hide()
	$"../Player".global_position = Vector2.ZERO
	$"../Player".velocity = Vector2.ZERO
	$"../Player".paused = false
