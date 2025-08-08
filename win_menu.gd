extends CanvasLayer


func _on_retry_pressed() -> void:
	self.hide()
	$"../LevelManager".retry(true)


func _on_next_pressed() -> void:
	self.hide()
	$"../LevelManager".next_level()
