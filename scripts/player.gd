extends CharacterBody2D
@onready var sprite2d = $Sprite2D

var worldItemScene = preload("res://scenes/worldItem.tscn")

# --------------------- Settings ----------------------
const SPEED = 100.0

# --------------------- Constants ---------------------
const LEFT = 0
const RIGHT = 1
const UP = 2
const DOWN = 3

# --------------------- Variables ---------------------
var dir = DOWN

# Array to store interactable objects in range
var interactables_in_range: Array = []
# Player's inventory
var inventory

# ----------------------------------------------------------------
# Helper functions
# ----------------------------------------------------------------

func init_inventory() -> void:
	# Create a new inventory instance
	inventory = Global.INV_manager.new_inventory(Global.PLAYER_INV_NAME)

	# Connect the inventory's item_dropped signal to the player
	inventory.connect("item_dropped", Callable(self, "_on_item_dropped"))

	
func _on_item_dropped(_itemData: Global.ItemData, count: int):
	var drop_position = position + Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized() * randf_range(1,8)
	print("Spawning item at position: ", drop_position)
	
	# Instance the item scene
	var newWorldItem = worldItemScene.instantiate()
	
	# Initialize the item with its type and texture
	newWorldItem.setup_item(_itemData, count)
	
	# Add the item to the root node (main scene)
	get_tree().current_scene.add_child(newWorldItem)
	
	# Set the item's position in the Global scene
	newWorldItem.global_position = drop_position

# Function to find and update the interaction prompt visibility
func update_interact_prompt():
	# Update visibility based on whether there are interactable objects in range
	Global.GUI_manager.interact_prompt.visible = interactables_in_range.size() > 0 and !inventory.visible

# ----------------------------------------------------------------
# Godot functions
# ----------------------------------------------------------------

func _ready() -> void:
	# Initialize the player's inventory and connected gui scenes
	call_deferred("init_inventory")
	
	# Connect to interactable area
	$Area2D.connect("area_entered", Callable(self, "_on_area_entered"))
	$Area2D.connect("area_exited", Callable(self, "_on_area_exited"))
	
func _physics_process(delta: float) -> void:
	# Player's z_index is based on y position
	z_index = int(position.y) + Global.Z_INDEX_OFFSET

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
		# Get energy
		var energy = Global.GUI_manager.energy_bar.energy

		# Decrease energy when moving
		update_energy(-Global.GUI_manager.energy_bar.energy*0.01*delta)

		# Normalize the vector to prevent faster diagonal movement
		motion = motion.normalized() * SPEED * (energy*0.6+0.4)
		
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
	velocity = velocity.lerp(motion, 4.0 * delta)

	# Apply velocity to the character with the move_and_slide function
	move_and_slide()

func update_energy(change: float) -> void:
	Global.GUI_manager.energy_bar.update_energy(change)

# ----------------------------------------------------------------
# Interaction logic
# ----------------------------------------------------------------

# When the player enters the range of an interactable object
func _on_area_entered(area):
	if area is Interactable:
		interactables_in_range.append(area)
		update_interact_prompt()

# When the player exits the range of an interactable object
func _on_area_exited(area):
	if area is Interactable:
		interactables_in_range.erase(area)
		update_interact_prompt()

# Helper function to find the closest interactable
func get_closest_interactable() -> Interactable:
	var closest = null
	var min_dist = INF # INTERACT_RADIUS
	
	for interactable in interactables_in_range:
		var dist = position.distance_to(interactable.position)
		if dist < min_dist:
			min_dist = dist
			closest = interactable
	
	return closest

func _input(event):
	if event.is_action_pressed("interact"):
		# Find the closest interactable if multiple are in range
		var closest_interactable = get_closest_interactable()
		if closest_interactable:
			print("Interacting with: ", closest_interactable)
			closest_interactable.interact()
			update_interact_prompt()

	elif event.is_action_pressed("inventory_toggle"):
		# Tell the inventory manager to toggle the inventory
		Global.INV_manager.toggle_inventory(Global.PLAYER_INV_NAME)
		update_interact_prompt()
