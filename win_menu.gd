extends CanvasLayer


func _on_retry_pressed() -> void:
	self.hide()
	$"../LevelManager".retry(true, true)


func _on_next_pressed() -> void:
	match $PanelContainer/VBoxContainer/HBoxContainer/Next.text:
		"Main Menu":
			self.hide()
			GameManager.back_to_menu()
		"Next Level":
			self.hide()
			GameManager.next_level()


func _on_visibility_changed() -> void:
	$PanelContainer/VBoxContainer/TimeLabel.text = "Time: " + $"../UI/SpeedrunTimer".text
	$PanelContainer/VBoxContainer/DeathsLabel.text = "Deaths: " + str($"..".level_deaths)


func show_last() -> void:
	show()
	$AnimationPlayer.play("popup")
	$PanelContainer/VBoxContainer/HBoxContainer/Next.text = "Main Menu"


func show_normal() -> void:
	show()
	$AnimationPlayer.play("popup")
	$PanelContainer/VBoxContainer/HBoxContainer/Next.text = "Next Level"
