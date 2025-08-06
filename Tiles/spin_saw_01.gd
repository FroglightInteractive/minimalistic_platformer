extends Area2D


func _process(delta: float) -> void:
	$Sprite2D.rotation += delta * 1.5


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.die()
