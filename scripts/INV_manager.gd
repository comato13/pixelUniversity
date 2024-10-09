extends Node

var inventoryScene = preload("res://scenes/inventory.tscn")
var shown_inv: String
var canvas_layer

# ----------------------------------------------------------------
# Helper functions
# ----------------------------------------------------------------

# Initialize the inventory manager
func new_inventory(INVname: String) -> Node:
	# Check if an inventory with the same name already exists
	if has_node(INVname):
		print("Inventory with name ", INVname, " already exists!")
		return get_node(INVname)
	
	# Create a new inventory instance
	var inventory = inventoryScene.instantiate()
	
	# Call the setup function to initialize the inventory
	inventory.setup_inventory(INVname)
	inventory.set_owner(Global.INV_manager) # Set the owner of the inventory to the inventory manager
	
	# Add as child of the inventory manager
	canvas_layer.add_child(inventory)

	return inventory

# Remove an inventory from the inventory array
func remove_inventory(INVname: String) -> void:
	if has_node(INVname):
		get_node(INVname).queue_free()

func toggle_inventory(INVname: String) -> void:
	print("Toggling inventory: ", INVname)
	print("Shown inventory: ", shown_inv)
	# Check if an inventory is already shown, if so hide it
	if shown_inv != "":
		var inventory = canvas_layer.get_node(shown_inv)
		inventory.visible = false
		shown_inv = ""
	# Otherwise, show the requested inventory
	elif canvas_layer.has_node(INVname):
		print("Showing inventory: ", INVname)
		var inventory = canvas_layer.get_node(INVname)
		inventory.visible = true
		shown_inv = INVname

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	canvas_layer = $CanvasLayer
	shown_inv = ""

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
