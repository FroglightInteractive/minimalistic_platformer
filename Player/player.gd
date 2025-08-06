extends CharacterBody2D

# node declarations
@onready var trail: Line2D = $Trail

# export movement variables
@export var speed: float = 185.0	# the maximum speed of the player
@export var acceleration: float = 15.0	# the acceleration of the player
@export var jump_vel: float = 200.0	# how fast the player can jump (height)
@export var down_grav: float = 1200.0	# the amount of gravity that the player has when moving downwards (falling)
@export var up_grav: float = 400.0	# the amount of gravity that the player has when moving upwards (jumping)

# export trail variables
@export var trail_max_points: int = 20	# the maximum amount of points there can be in the trail
@export var trail_point_spacing: float = 5	# the amount of space between the points

# coyote time variables
var coyote_time: float = 0.08	# total amount of coyote time
var coyote_timer: float = 0.0	# current time left to jump using coyote time
# jump buffer variables
var jump_buffer_time: float = 0.1	# total amount of jump buffer time
var jump_buffer_timer: float = 0.0	# current time left to use jump buffer
# trail variables
var distance_accum: float = 0.0
# launch pad variables
var move_dir: float = 0.0	# movement input direction (-1 for left, 0 for nothing, 1 for right
var launch_velocity: Vector2 = Vector2.ZERO
var launch_timer: float = 0.0

var was_on_floor: bool = false	# whether the player was on floor in the last frame


func _ready() -> void:
	if trail == null:
		printerr("could not find node line2d")
		return
	trail.clear_points()


func _physics_process(delta: float) -> void:
	var on_floor = is_on_floor()
	
	var just_landed = (not was_on_floor) and on_floor	# check if we just landed
	if just_landed:
		$LandParticles1.restart()	# play landing particles
	
	if on_floor:
		coyote_timer = coyote_time	# reset coyote timer so that it can be used again
	else:
		handle_gravity(delta)
		coyote_timer -= delta	# if we are not on the floor, take away delta from the coyote timer thus making the time that the player has left to jump smaller
	
	handle_movement(delta)
	
	if launch_timer > 0.0:
		velocity = launch_velocity
		launch_timer -= delta
	
	move_and_slide()
	
	handle_trail()	# must be placed after move_and_slide() so that it doesn't lag one frame behind the player
	was_on_floor = on_floor	# set was on floor to on floor after we calulate movement so that it reflects what happened *last frame*


func handle_gravity(delta: float) -> void:
	if velocity.y > 0:	# going downwards
		velocity.y += down_grav * delta
	else:	# going upwards
		velocity.y += up_grav * delta


func handle_movement(delta: float) -> void:
	# horizontal movement
	move_dir = Input.get_axis("left", "right")
	velocity.x = lerp(velocity.x, move_dir * speed, acceleration * delta)	# move player velocity towards the direction of movement with speed at a rate of acceleration
	
	# jumping
	# handle jump buffer timer
	if Input.is_action_just_pressed("jump"):
		jump_buffer_timer = jump_buffer_time	# set jump buffer timer to jump buffer time so that we can see whether or not the player should jump when reaching the ground
	else:
		jump_buffer_timer -= delta	# if we have not just pressed the jump button, remove delta from jump buffer timer thus making the time that the player has to reach the ground in to jump once reaching it less
	# perform jump if possible
	var can_jump = false
	
	if is_on_floor():	# on ground, always allow jump
		can_jump = jump_buffer_timer > 0.0
	elif coyote_timer > 0.0:	# within coyote time
		can_jump = jump_buffer_timer > 0.0
	
	if can_jump:	# make sure the player a: can jump and b: has jumps left to use
		$JumpParticles1.restart()	# play the jump particles
		#$JumpParticles1.emitting = true
		velocity.y = -jump_vel	# set velocity to negative jump_velocity (upwards is negative)
		jump_buffer_timer = 0.0	# set jump buffer timer to zero so that the player cannot jump again
		coyote_timer = 0.0	# set coyote timer to zero so that the player cannot jump again


func handle_trail() -> void:
	if trail == null:	# make sure trail node exists
		return
	
	if trail.get_point_count() > 0:	# make sure the trail has points to work with
		var last_point = trail.get_point_position(trail.get_point_count() - 1)	# get the position of the last point in the list
		var distance = global_position.distance_to(last_point)	# get the distance from the player position to the position of the last trail point
		distance_accum += distance	# add to our distance
	else:	# if the trail does not have points to work with
		distance_accum = trail_point_spacing	# reset the distance
	
	if distance_accum >= trail_point_spacing:	# check if we should add a new point
		trail.add_point(global_position)	# add a new point
		distance_accum = 0.0	# reset the distance
		if trail.get_point_count() > trail_max_points:	# check if we have too many points
			trail.remove_point(0)	# remove the last point in the trail
	
	if move_dir == 0 and (velocity.y == 0 and is_on_floor()):	# check if the player is not moving
		trail.remove_point(0)	# get rid of the last point (slowly makes the trail shorter)


func reset_trail() -> void:
	if trail != null:	# make sure the trail node exists
		trail.clear_points()	# clear all the points in the trail
		distance_accum = 0.0	# reset the distance


func die() -> void:
	get_tree().reload_current_scene()


func launch(vel: Vector2) -> void:
	launch_velocity = vel
	launch_timer = 0.2	# seconds
