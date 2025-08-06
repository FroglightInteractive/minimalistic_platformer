extends Node


func win() -> void:
	pass


func next_level() -> void:
	get_tree().root.get_node("Main/LevelManager").next_level()


func retry() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()


func die() -> void:
	get_tree().root.get_node("Main/DeathMenu").show()
	get_tree().paused = true


func quit() -> void:
	get_tree().paused = false
	get_tree().quit()
