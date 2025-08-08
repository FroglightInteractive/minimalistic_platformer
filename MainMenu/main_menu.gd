extends Node2D


func options_pressed() -> void:
	$OptionsMenu.show()
	get_tree().root.get_node("Main/Player").paused = true


func quit_pressed() -> void:
	get_tree().quit()
