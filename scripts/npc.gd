extends CharacterBody2D

const LEFT = 0
const RIGHT = 1
const UP = 2
const DOWN = 3
@export var SPEED = 100.0
@onready var sprite2d = $AnimatedSprite2D
@export var moveable : bool = true

# --------------------- Variables ---------------------
var dir = DOWN
	
func _physics_process(delta: float) -> void:

	# Player's z_index is based on y position
	z_index = int(position.y) + Global.Z_INDEX_OFFSET
	
	# Initialize a new vector to store the direction of movement

	if sprite2d:
		
		match dir:
			LEFT:
				sprite2d.animation = "RunLeft"
			RIGHT:
				sprite2d.animation = "RunRight"
			UP:
				sprite2d.animation = "RunUp"
			DOWN:
				sprite2d.animation = "RunDown"
		print(sprite2d.animation)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# NPC's z_index is based on y position
	z_index = int(position.y)+1000

	if moveable and position.length() > 0.01:
		if abs(position.x) > abs(position.y):
			if position.x < 0:
				dir = LEFT
			else:
				dir = RIGHT
		else:
			if position.y < 0:
				dir = UP
			else:
				dir = DOWN
		print(dir)
	
