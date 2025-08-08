extends Area2D

@onready var sprite: Sprite2D = $Sprite2D


func _process(delta: float) -> void:
	sprite.rotation += delta * 3


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		GameManager.next_level()
