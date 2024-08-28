extends Control

@onready var grid_container = $ScrollContainer/GridContainer

var inventory: Inventory

# Set the inventory object
func set_inventory(inventory_obj: Inventory) -> void:
	inventory = inventory_obj
	update_inventory_ui()

# Update the UI based on the inventory
func update_inventory_ui():
	# Clear previous items
	grid_container.clear_children()

	# Add items to the grid
	for item_type in inventory.items.keys():
		var item_count = inventory.get_item_count(item_type)
		var item_slot = create_item_slot(item_type, item_count)
		grid_container.add_child(item_slot)

	# Adjust the grid container height based on the number of items
	var rows = ceil(float(inventory.items.size()) / grid_container.columns) + 2
	grid_container.rect_min_size.y = rows * 64  # Assuming 64 is the height of each slot

# Helper function to create an item slot
func create_item_slot(item_type: Item.ItemType, count: int) -> Control:
	var slot = TextureButton.new()
	slot.texture_normal = get_item_texture(item_type)
	slot.text = str(count)  # Display the item count

	return slot

# Helper function to get the item texture
func get_item_texture(item_type: Item.ItemType) -> Texture:
	match item_type:
		Item.ItemType.HEART:
			return preload("res://path_to_heart_icon.png")
		Item.ItemType.WATER_BOTTLE:
			return preload("res://path_to_water_bottle_icon.png")
		# Add other items as needed
		return null
