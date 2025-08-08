extends Node

# saved as "level name": time
var level_times: Dictionary[String, float] = {}


func win() -> void:
	get_tree().root.get_node("Main/LevelManager").win_level()


func next_level() -> void:
	get_tree().root.get_node("Main/LevelManager").next_level()


func retry() -> void:
	get_tree().root.get_node("Main/LevelManager").retry()


func die() -> void:
	get_tree().root.get_node("Main/DeathMenu").show()
	get_tree().root.get_node("Main/Player").paused = true


func quit() -> void:
	get_tree().paused = false
	get_tree().quit()
