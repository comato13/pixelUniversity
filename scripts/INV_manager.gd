extends Node

var inventoryScene = preload("res://scenes/inventory.tscn")

var inventoryArray = []


# ----------------------------------------------------------------
# Helper functions
# ----------------------------------------------------------------

# Initialize the inventory manager
func new_inventory(name: String) -> Node:
	# Create a new inventory instance
	var inventory = inventoryScene.instantiate()
	
	# Call the setup function to initialize the inventory
	inventory.setup_inventory("Backpack Inventory")
	
	# Get the global node (assuming second child of root)
	var root_node = get_tree().root.get_child(1)
	root_node.add_child(inventory)

	# Add the inventory to the inventory array
	inventoryArray.append(inventory)

	return inventory

# Get an inventory from the inventory array
func get_inventory(name: String) -> Node:
	for inventory in inventoryArray:
		if inventory.name == name:
			return inventory
	return null

# Remove an inventory from the inventory array
func remove_inventory(inventory: Node) -> void:
	if inventory in inventoryArray:
		inventoryArray.erase(inventoryArray.find(inventory))
		inventory.queue_free()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
