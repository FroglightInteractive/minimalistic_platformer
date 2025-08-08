extends CanvasLayer


func _on_retry_pressed() -> void:
	self.hide()
	$"../LevelManager".retry(true, true)


func _on_next_pressed() -> void:
	self.hide()
	GameManager.next_level()


func _on_visibility_changed() -> void:
	$PanelContainer/VBoxContainer/TimeLabel.text = "Time: " + $"../UI/SpeedrunTimer".text
	$PanelContainer/VBoxContainer/DeathsLabel.text = "Deaths: " + str($"..".level_deaths)
