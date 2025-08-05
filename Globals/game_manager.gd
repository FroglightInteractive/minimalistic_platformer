extends Node


func win() -> void:
	pass


func next_level() -> void:
	get_tree().root.get_node("Main/LevelManager").next_level()
