extends CharacterBody2D
@onready var sprite2d = $Sprite2D


# Settings
const SPEED = 100.0
# const INTERACT_RADIUS = 20.0

# Constants
const LEFT = 0
const RIGHT = 1
const UP = 2
const DOWN = 3

# Actions
const IDLE = 0
const SIT = 1
const WALK = 2
const READ = 3


# Game variables
var dir = DOWN

# Players inventory
var inventory
# Array to store interactable objects in range
var interactables_in_range: Array = []


# ----------------------------------------------------------------
# Helper functions
# ----------------------------------------------------------------

# ----------------------------------------------------------------
# Godot functions
# ----------------------------------------------------------------

func _ready() -> void:
	# Initialize the inventory when the scene is ready using deferred initialization
	call_deferred("init_inventory")
	
	# Connect to interactable area
	$Area2D.connect("area_entered", Callable(self, "_on_area_entered"))
	$Area2D.connect("area_exited", Callable(self, "_on_area_exited"))

func _physics_process(delta: float) -> void:
	# Player's z_index is based on y position
	z_index = position.y + 1
	
	
		
	# Initialize a new vector to store the direction of movement
	var motion = Vector2()

	# Capture input and update the motion vector accordingly
	if Input.is_action_pressed("up"):
		motion.y -= 1
	if Input.is_action_pressed("down"):
		motion.y += 1
	if Input.is_action_pressed("left"):
		motion.x -= 1
	if Input.is_action_pressed("right"):
		motion.x += 1
	
	# Normalize the motion vector to prevent diagonal speed increase and scale by moveSpeed and delta time
	if motion.length() > 0.01:
		motion = motion.normalized() * SPEED
		
		if abs(motion.x) > abs(motion.y):
			if motion.x < 0:
				dir = LEFT
			else:
				dir = RIGHT
		else:
			if motion.y < 0:
				dir = UP
			else:
				dir = DOWN
		
	if abs(motion.x) < 0.01 and abs(motion.y) < 0.01:
		match dir:
			LEFT:
				sprite2d.animation = "IdleLeft"
			RIGHT:
				sprite2d.animation = "IdleRight"
			UP:
				sprite2d.animation = "IdleUp"
			DOWN:
				sprite2d.animation = "IdleDown"
	else:
		match dir:
			LEFT:
				sprite2d.animation = "WalkLeft"
			RIGHT:
				sprite2d.animation = "WalkRight"
			UP:
				sprite2d.animation = "WalkUp"
			DOWN:
				sprite2d.animation = "WalkDown"

	# Apply acceleration for a smoother start and deceleration for a smoother stop
	velocity = velocity.lerp(motion, 4.0 * delta)

	# Apply velocity to the character with the move_and_slide function
	move_and_slide()
