extends Node

# "level name": preload("level path")
const LEVELS: Dictionary = {
	"Level 0": preload("res://MainMenu/main_menu.tscn"),
	"Level 1": preload("res://Levels/level_1.tscn"),
	"Level 2": preload("res://Levels/level_2.tscn"),
	"Level 3": preload("res://Levels/level_4.tscn"),
	"Level 4": preload("res://Levels/level_5.tscn"),
	"Level 5": preload("res://Levels/level_3.tscn"),
	"Level 6": preload("res://Levels/level_6.tscn"),
}

var current_level: int = 0


func _ready() -> void:
	next_level()


func next_level() -> void:
	# remove old level
	for child in get_children():
		child.queue_free()
	
	# reset the player
	$"../Player".global_position = Vector2.ZERO
	$"../Player".velocity = Vector2.ZERO
	$"../Player".launch_timer = 0.0
	$"../Player".launch_velocity = Vector2.ZERO
	$"../Player".paused = false
	# spawn new level
	var level_id: String = "Level " + str(current_level)
	var level = LEVELS[level_id].instantiate()
	add_child(level)
	if current_level > 0:
		$"..".reset_timer()
		$"..".start_timer()
	$"..".level_deaths = 0
	current_level += 1


func retry(reset_timer: bool = false, reset_deaths: bool = false) -> void:
	# hide death menu and reset the player
	$"../DeathMenu".hide()
	$"../Player".global_position = Vector2.ZERO
	$"../Player".velocity = Vector2.ZERO
	$"../Player".launch_timer = 0.0
	$"../Player".launch_velocity = Vector2.ZERO
	$"../Player".paused = false
	if reset_timer:
		$"..".reset_timer()
		$"..".start_timer()
	if reset_deaths:
		$"..".level_deaths = 0


func win_level() -> void:
	$"../Player".paused = true
	$"../Player".win()
	$"..".stop_timer()
	$"../WinMenu".show()
	$"../WinMenu/AnimationPlayer".play("popup")
