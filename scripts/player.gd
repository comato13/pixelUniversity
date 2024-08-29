extends CharacterBody2D
@onready var sprite2d = $Sprite2D

var worldItemScene = preload("res://scenes/worldItem.tscn")
var inventoryScene = preload("res://scenes/inventory.tscn")

# Settings
const SPEED = 100.0

# Constants
const LEFT = 0
const RIGHT = 1
const UP = 2
const DOWN = 3

# Game variables
var dir = DOWN  
#var inventory

# ----------------------------------------------------------------
# Helper functions
# ----------------------------------------------------------------

func init_inventory() -> void:
	print("Initialising player inventory...")
	
	# Add the inventory to the scene tree
	var inventory = inventoryScene.instantiate()
	
	# Call the setup function to initialize the inventory
	inventory.setup_inventory("Backpack Inventory")
	
	# Connect the inventory's item_dropped signal to the player
	inventory.connect("item_dropped", Callable(self, "_on_item_dropped"))

	# Get the level node (assuming the level is second child of root)
	var root_node = get_tree().root.get_child(1)
	
	root_node.add_child(inventory)

	
func _on_item_dropped(item_type: UI_Item.ItemType, count: int):
	var drop_position = position + Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized() * randf_range(1,8)
	print("Spawning item at position: ", drop_position)
	
	# Instance the item scene
	var newWorldItem = worldItemScene.instantiate()
	
	# Initialize the item with its type and texture
	newWorldItem.setup_item(item_type, count)
	
	# Get the root node (assuming the main scene is the root)
	var root_node = get_tree().root.get_child(1)
	
	# Add the item to the root node (main scene)
	root_node.add_child(newWorldItem)
	
	# Set the item's position in the global scene
	newWorldItem.global_position = drop_position

# ----------------------------------------------------------------
# Godot functions
# ----------------------------------------------------------------

func _ready() -> void:
	# Initialize the inventory when the scene is ready using deferred initialization
	call_deferred("init_inventory")

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

	


#func get_closest_item() -> Item:
	## Logic to get the closest item to the player
	## For simplicity, you might use a signal or area detection
	#return null
