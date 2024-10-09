extends CharacterBody2D

const LEFT = 0
const RIGHT = 1
const UP = 2
const DOWN = 3
@export var SPEED = 100.0
@onready var sprite2d = $AnimatedSprite2D
@export var moveable : bool = true
var previous_position: Vector2
# --------------------- Variables ---------------------
var dir = DOWN
	
func _physics_process(delta: float) -> void:

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
		# print(sprite2d.animation)

func _ready() -> void:
	previous_position = position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Player's z_index is based on y position
	var pathfollow = get_parent() as PathFollow2D
	if pathfollow:
		var movement_vector = get_unit_offset()
		print(movement_vector)
		if moveable and movement_vector.length() > 0.01:
			if abs(movement_vector.x) > abs(movement_vector.y):
				if movement_vector.x < 0:
					dir = LEFT
				else:
					dir = RIGHT
			else:
				if movement_vector.y < 0:
					dir = UP
				else:
					dir = DOWN
		print(dir)
	
func get_unit_offset() -> Vector2:
	var pathfollow = get_parent() as PathFollow2D
	var curve = (pathfollow.get_parent() as Path2D).curve
	var current_position = curve.sample_baked(pathfollow.progress)
	var next_position = curve.sample_baked(pathfollow.progress + 0.1)
	var direction_vector = (next_position - current_position).normalized()
	return direction_vector
