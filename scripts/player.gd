# Because the player is CharacterBody2D, extend from the same class
extends CharacterBody2D

# Settings
const moveSpeed : float = 50

# Define variables
#var velocity : Vector2 = Vector2()
#var direction : Vector2 = Vector2()

func read_input(delta: float):
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
	if motion.length() > 0:
		motion = motion.normalized() * moveSpeed

	# Apply acceleration for a smoother start and deceleration for a smoother stop
	velocity = velocity.lerp(motion, 8.0 * delta)

	# Apply velocity to the character with the move_and_slide function
	move_and_slide()

		
func _physics_process(delta: float) -> void:
	read_input(delta)

## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
