extends CanvasLayer


func _on_retry_pressed() -> void:
	GameManager.retry()


func _on_quit_pressed() -> void:
	GameManager.quit()
