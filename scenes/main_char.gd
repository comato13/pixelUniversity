extends CharacterBody2D


const SPEED = 50.0
const LEFT = 0
const RIGHT = 1
const UP = 2
const DOWN = 3


@onready var sprite2d = $Sprite2D

var dir = DOWN
#const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction_x := Input.get_axis("ui_left", "ui_right")
	var direction_y := Input.get_axis("ui_up", "ui_down")
	
	if direction_x:
		velocity.x = direction_x * SPEED
		if direction_x == 1:
			dir = RIGHT
		else:
			dir = LEFT
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if direction_y and velocity.x == 0:
		velocity.y = direction_y * SPEED
		if direction_y == 1:
			dir = DOWN
		else:
			dir = UP
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	if velocity.x == 0 and velocity.y == 0:
		match dir:
			LEFT:
				sprite2d.animation = "adamLeftIdle"
			RIGHT:
				sprite2d.animation = "adamRightIdle"
			UP:
				sprite2d.animation = "adamUpIdle"
			DOWN:
				sprite2d.animation = "adamDownIdle"
	else:
		match dir:
			LEFT:
				sprite2d.animation = "adamLeftRun"
			RIGHT:
				sprite2d.animation = "adamRightRun"
			UP:
				sprite2d.animation = "adamUpRun"
			DOWN:
				sprite2d.animation = "adamDownRun"
			
	move_and_slide()
