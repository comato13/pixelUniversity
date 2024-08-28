extends CharacterBody2D
@onready var sprite2d = $Sprite2D
var ItemScene = preload("res://scenes/Item.tscn")

# Settings
const SPEED = 100.0

# Constants
const LEFT = 0
const RIGHT = 1
const UP = 2
const DOWN = 3

# Game variables
var dir = DOWN  
var inventory: Inventory

# ----------------------------------------------------------------
# Helper functions
# ----------------------------------------------------------------

# Spawn an item of a given type at a given position
func spawn_item(item_type: Item.ItemType, position: Vector2):
	print("Spawning item at position: ", position)
	
	# Instance the item scene
	var new_item = ItemScene.instantiate()
	
	# Set the item type
	new_item.item_type = item_type
	
	# Get the root node (assuming the main scene is the root and one index after logo tranition)
	var root_node = get_tree().root.get_child(1)
	
	# Add the item to the root node (main scene)
	root_node.add_child(new_item)
	
	# Set the item's position in the global scene
	new_item.global_position = position

# Spawn a random item at a given position (Debug)
func spawn_random_item(position: Vector2):
	# Generate a random integer between 0 and the number of enum values - 1
	var random_index = randi() % Item.ItemType.size()
	
	# Get the random item type from the enum
	var random_item_type = Item.ItemType.values()[random_index]
	
	# Spawn the item with the random type
	spawn_item(random_item_type, position)

# Example function to pick up an item
func pick_up_item(item_type: Item.ItemType):
	inventory.add_item(item_type)

# Example function to drop an item
func drop_item(item_type: Item.ItemType):
	if inventory.remove_item(item_type):
		spawn_item(item_type, position)  # Drop the item in the world

# ----------------------------------------------------------------
# Godot functions
# ----------------------------------------------------------------

func _ready() -> void:
	# Add the inventory to the scene tree, but make sure it's not visible
	inventory = Inventory.new()
	add_child(inventory)

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

	# Apply acceleration for a smoother start and deceleration for a smoother stop
	velocity = velocity.lerp(motion, 16.0 * delta)

	# Apply velocity to the character with the move_and_slide function
	move_and_slide()

	
func _input(event):
	#if event.is_action_pressed("pick_up") and held_item == null:
		#var item = get_closest_item()
		#if item:
			#item.pick_up(self)
			#held_item = item

	if event.is_action_pressed("drop_item"):# and held_item != null:
		#held_item.drop()
		print("Drop item action detected")
		#held_item = null
		# Spawn a HEART item at position (200, 200)
		spawn_random_item(position)

#func get_closest_item() -> Item:
	## Logic to get the closest item to the player
	## For simplicity, you might use a signal or area detection
	#return null
