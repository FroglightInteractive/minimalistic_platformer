extends Area2D

@export var speed: float = 100.0

var velocity: Vector2 = Vector2.ZERO


func _process(delta: float) -> void:
	position += speed * velocity * delta	# move in the direction of velocity with speed


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.die()
	if not body.is_in_group("arrows"):
		queue_free()


func _on_lifespan_timeout() -> void:
	queue_free()
