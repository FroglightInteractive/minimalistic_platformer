extends CanvasLayer

@onready var speedrun_timer: Label = $SpeedrunTimer


func _process(_delta: float) -> void:
	speedrun_timer.text = format_time(get_parent().level_time)


func format_time(time: float) -> String:
	var minutes = int(time) / 60
	var seconds = int(time) % 60
	var hundreths = int((time - int(time)) * 100)
	return "%02d:%02d.%02d" % [minutes, seconds, hundreths]
