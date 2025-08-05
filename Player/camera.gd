extends Camera2D

@export var vertical_speed: float = 2.5
@export var horizontal_speed: float = 5.0
@export var horizontal_offset_amount: float = 96.0
@export var vertical_offset_amount: float = 64
@export var target: Node2D


func _process(delta: float) -> void:
	if not target:
		return
	
	global_position.x = lerp(global_position.x, target.global_position.x, horizontal_speed * delta)	# move x position towards target x position
	global_position.y = lerp(global_position.y, target.global_position.y, vertical_speed * delta)	# move y position towards target y position
	
	if target.velocity.x > 0:	# going right
		offset.x = lerp(offset.x, horizontal_offset_amount, horizontal_speed * 0.5 * delta)	# move camera offset x to the right so that the player can look ahead
	elif target.velocity.x < 0: 	# going left
		offset.x = lerp(offset.x, -horizontal_offset_amount, horizontal_speed * 0.5 * delta)	# move camera offset x to the left so that the player can look ahead
	if target.velocity.y < 0:	# going up
		offset.y = lerp(offset.y, -vertical_offset_amount, vertical_speed * delta)	# move camera offset y upwards so that the player can look ahead
	elif target.velocity.y > 0:	# going down
		offset.y = lerp(offset.y, vertical_offset_amount, vertical_speed * delta)	# move camera offset y downwards so that the player can look ahead
	else:	# not moving vertically
		offset.y = lerp(offset.y, -vertical_offset_amount, vertical_speed * delta)	# move camera so that the player can see above them
