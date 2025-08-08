extends Node

# saved as "level name": time
var level_times: Dictionary[String, float] = {}
var player_is_dead: bool = false


func win() -> void:
	get_tree().root.get_node("Main/LevelManager").win_level()


func next_level() -> void:
	get_tree().root.get_node("Main/LevelManager").next_level()
	player_is_dead = false


func retry() -> void:
	get_tree().root.get_node("Main/LevelManager").retry()
	player_is_dead = false


func die() -> void:
	if player_is_dead:
		return
	
	player_is_dead = true
	get_tree().root.get_node("Main/DeathMenu").show()
	get_tree().root.get_node("Main").level_deaths += 1
	print("added deaths")
	get_tree().root.get_node("Main/Player").paused = true


func quit() -> void:
	get_tree().paused = false
	get_tree().quit()
