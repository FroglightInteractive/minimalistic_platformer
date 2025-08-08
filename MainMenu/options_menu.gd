extends CanvasLayer


func _on_volume_slider_value_changed(value: float) -> void:
	var main_vol_value: float = -(100 - value)
	$PanelContainer/VBoxContainer/ScrollContainer/MarginContainer/VBoxContainer/Volume/Label2.text = str(int(value)) + "%"


func _on_music_volume_slider_value_changed(value: float) -> void:
	var music_vol_value: float = -(100 - value)
	$PanelContainer/VBoxContainer/ScrollContainer/MarginContainer/VBoxContainer/MusicVolume/Label2.text = str(int(value)) + "%"


func _on_sfx_volume_slider_value_changed(value: float) -> void:
	var sfx_vol_value: float = -(100 - value)
	$PanelContainer/VBoxContainer/ScrollContainer/MarginContainer/VBoxContainer/SFXVolume/Label2.text = str(int(value)) + "%"


func _on_back_button_pressed() -> void:
	self.hide()
	get_tree().root.get_node("Main/Player").paused = false
