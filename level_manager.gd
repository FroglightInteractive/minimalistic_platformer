extends Node

# "level name": preload("level path")
const LEVELS: Dictionary = {
	"Level 1": preload("res://Levels/level_1.tscn")
}

var current_level: int = 1


func _ready() -> void:
	next_level()


func next_level() -> void:
	for child in get_children():
		child.queue_free()
	
	var level_id: String = "Level " + str(current_level)
	var level = LEVELS[level_id].instantiate()
	add_child(level)
	current_level += 1
