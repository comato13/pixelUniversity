extends CanvasLayer
class_name Inventory

# Reference to Item Scene
var ItemScene = preload("res://scenes/Item.tscn")

# UI Elements
var control
var richTextLabel
var scroll_container
var grid_container

# Settings
const SLOT_HEIGHT = 16

# Dictionary to store items and their counts
var items: Dictionary = {}

# Initialize the inventory
func setup_inventory(titleStr: String = "Inventory") -> void:
	print("Setting up inventory with random items...")
	control = $Control
	richTextLabel = $Control/RichTextLabel
	scroll_container = $Control/ScrollContainer
	grid_container = $Control/ScrollContainer/GridContainer
	
	self.visible = false
	self.richTextLabel.text = "[center]%s[/center]" % titleStr
	
	# Initialize the inventory with random counts of each item type
	for item_type in Item.ItemType.values():
		# Add a random count for each item type to the inventory
		var random_count = randi() % 11  # Random count between 0 and 10
		add_item(item_type, random_count)
	
	# Update the UI after initialization
	update_ui()

#----------------------------------------------------------------
# Methods for managing items
#----------------------------------------------------------------

# Add an item to the inventory
func add_item(item_type: Item.ItemType, count: int = 1) -> void:
	if items.has(item_type):
		items[item_type] += count
	else:
		items[item_type] = count

	#update_ui()

# Remove an item from the inventory
func remove_item(item_type: Item.ItemType, count: int = 1) -> bool:
	if items.has(item_type):
		items[item_type] -= count
		if items[item_type] <= 0:
			items.erase(item_type)
		#update_ui()
		return true
	return false

# Get the count of an item
func get_item_count(item_type: Item.ItemType) -> int:
	return items.get(item_type, 0)

#---------------------------------------------------------------
# Helper functions for UI integration
#---------------------------------------------------------------

# Handle right-click on an item (e.g., to consume it)
func _on_item_right_clicked(item_type: Item.ItemType):
	print("Consume item: ", item_type)
	consume_item(item_type)

# Handle left-click on an item (e.g., to drop it)
func _on_item_left_clicked(item_type: Item.ItemType):
	print("Drop item: ", item_type)
	drop_item(item_type)

func consume_item(item_type: Item.ItemType):
	# Logic for consuming the item (e.g., eating a consumable)
	print("Consuming item: ", item_type)
	# Implement your consume logic here

func drop_item(item_type: Item.ItemType):
	# Logic for dropping the item from inventory
	print("Dropping item: ", item_type)
	# Implement your drop logic here

# Update the UI based on the inventory by placing item instances within the grid
func update_ui():
	# Ensure the grid_container is initialized
	if grid_container == null:
		print("Error: GridContainer is not initialized!")
		return
	
	# Clear all existing children from the grid container
	for n in grid_container.get_children():
		grid_container.remove_child(n)
		n.queue_free()


	# Iterate over the items dictionary
	for item_type in items.keys():
		if (items[item_type] > 0):
			# Create a new item instance
			var new_item = ItemScene.instantiate()
			new_item.setup_item(item_type, items[item_type])
				
			# Add the item to the grid container
			grid_container.add_child(new_item)

func _input(event):
	#if event.is_action_pressed("pick_up") and held_item == null:
		#var item = get_closest_item()
		#if item:
			#item.pick_up(self)
			#held_item = item

	if event.is_action_pressed("inventory_toggle"):# and held_item != null:
		self.visible = not self.visible
