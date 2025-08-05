extends Area2D

@export_enum("Up", "Down", "Left", "Right", "UpLeft", "UpRight", "DownLeft", "DownRight") var direction = 0

var direction_vec: Vector2


func _ready() -> void:
	match direction:
		0:
			direction_vec = Vector2.UP
		1:
			direction_vec = Vector2.DOWN
		2:
			direction_vec = Vector2.LEFT
		3:
			direction_vec = Vector2.RIGHT
		4:
			direction_vec = Vector2(-1, -1).normalized()
		5:
			direction_vec = Vector2(1, -1).normalized()
		6:
			direction_vec = Vector2(-1, 1).normalized()
		7:
			direction_vec = Vector2(1, 1).normalized()
	$ArrowSprite.rotation = direction_vec.angle() + deg_to_rad(90)


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.launch(direction_vec * 500)
