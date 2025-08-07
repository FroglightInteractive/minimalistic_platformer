extends Node2D

@export_enum("Up", "Down", "Left", "Right", "UpLeft", "UpRight", "DownLeft", "DownRight") var direction = 0
@export var offset: float = 0.0	# in seconds the time of offset that the turret will start at
@export var wait_time: float = 1.0	# in seconds the wait time of the timer node

var direction_vec: Vector2


func _ready() -> void:
	$FireTimer.wait_time = wait_time	# set the wait time of the timer to the turret wait time (see above)
	
	if offset == 0.0:	# there is no offset, start the timer right away
		$FireTimer.start()
	else:	# there is an offset, start the timer after the offset
		await get_tree().create_timer(offset).timeout
		$FireTimer.start()
	
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


func _on_fire_timer_timeout() -> void:
	var arrow = preload("res://Arrow/arrow.tscn").instantiate()	# create the arrow
	get_tree().current_scene.add_child(arrow)	# add the arrow to the scene
	arrow.global_position = global_position + direction_vec	# set the arrow's position to the position of the turret + an offset
	arrow.global_rotation = direction_vec.angle() + deg_to_rad(90)	# rotate the arrow to look in the right direction
	arrow.velocity = direction_vec	# set the velocity of the arrow (see arrow.gd)
	$FireTimer.start()	# restart the fire timer
