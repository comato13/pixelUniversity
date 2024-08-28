extends Node
class_name Inventory

const SLOT_HEIGHT = 16

# Dictionary to store items and their counts
var items: Dictionary = {}

# UI Elements
@onready var scroll_container = $ScrollContainer
@onready var grid_container = $ScrollContainer/GridContainer

# Initialize the inventory
func _init():
	items = {}

# Set the UI elements (can be set directly in the scene or dynamically in code)
func set_ui(scroll_container_node: ScrollContainer, grid_container_node: GridContainer):
	scroll_container = scroll_container_node
	grid_container = grid_container_node

#----------------------------------------------------------------
# Methods for managing items
#----------------------------------------------------------------

# Add an item to the inventory
func add_item(item_type: Item.ItemType, count: int = 1) -> void:
	if items.has(item_type):
		items[item_type] += count
	else:
		items[item_type] = count

	update_ui()

# Remove an item from the inventory
func remove_item(item_type: Item.ItemType, count: int = 1) -> bool:
	if items.has(item_type):
		items[item_type] -= count
		if items[item_type] <= 0:
			items.erase(item_type)
		update_ui()
		return true
	return false

# Get the count of an item
func get_item_count(item_type: Item.ItemType) -> int:
	return items.get(item_type, 0)

#---------------------------------------------------------------
# Helper functions for UI integration
#---------------------------------------------------------------

# Update the UI based on the inventory
func update_ui():
	# Clear previous items
	grid_container.clear_children()
	# Add items to the grid
	#
	#for item_type in items.keys():
		#var item_count = get_item_count(item_type)
		#var item_slot = create_item_slot(item_type, item_count)
		#grid_container.add_child(item_slot)
		#
	## Adjust the grid container height based on the number of items
	#var rows = ceil(float(items.size()) / grid_container.columns) + 2
	#grid_container.rect_min_size.y = rows * SLOT_HEIGHT

## Helper function to create an item slot
#func create_item_slot(item_type: Item.ItemType, count: int) -> Control:
	#var slot = TextureButton.new()
	#slot.texture_normal = get_item_texture(item_type)
	#slot.text = str(count)  # Display the item count
	#
	#return slot


func toggle_ui():
	# Logic to toggle the inventory UI visibility
	var ui_node = $InventoryUI  # Ensure this path points to your actual inventory UI node
	ui_node.visible = not ui_node.visible
