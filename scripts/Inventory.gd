extends CanvasLayer
class_name Inventory

# Reference to Item Scene
var ItemScene = preload("res://scenes/UI_item.tscn")

# Signals
signal item_dropped(_itemData: Global.ItemData, count: int)

# UI Elements
var control
var richTextLabel
var scroll_container
var grid_container

# Dictionary to store items and their counts
var itemCounts: Dictionary = {}

# Initialize the inventory
func setup_inventory(titleStr: String = "Inventory") -> void:
	print("Setting up inventory with random items...")
	control = $Control
	richTextLabel = $Control/Title
	scroll_container = $Control/ScrollContainer
	grid_container = $Control/ScrollContainer/MarginContainer/GridContainer

	# Connect buttons to their respective functions
	$Control/UseButton.connect("pressed", Callable(self, "_on_use_item_pressed"))
	$Control/DropButton.connect("pressed", Callable(self, "_on_drop_item_pressed"))
	$Control/ExitButton.connect("pressed", Callable(self, "_on_exit_pressed"))
	# Set focus mode for the action buttons to None
	$Control/UseButton.focus_mode = Control.FOCUS_NONE
	$Control/DropButton.focus_mode = Control.FOCUS_NONE
	$Control/ExitButton.focus_mode = Control.FOCUS_NONE

	self.visible = false
	self.richTextLabel.text = "[center]%s[/center]" % titleStr
	
	# Initialize the inventory with random counts of each item type
	for itemData in Global.items.values():
		# Add a random count for each item type to the inventory
		var random_count = randi() % 11  # Random count between 0 and 10
		add_item(itemData, random_count)
	
	# Update the UI after initialization
	update_ui()

#----------------------------------------------------------------
# Methods for managing items
#----------------------------------------------------------------

# Add an item to the inventory
func add_item(itemData: Global.ItemData, count: int = 1) -> void:
	if itemCounts.has(itemData.name):
		itemCounts[itemData.name] += count
	else:
		itemCounts[itemData.name] = count

	update_ui()

# Remove an item from the inventory
func remove_item(itemData: Global.ItemData, count: int = 1) -> bool:
	if itemCounts.has(itemData.name):
		itemCounts[itemData.name] -= count
		if itemCounts[itemData.name] <= 0:
			itemCounts.erase(itemData.name)
		
		update_ui()

		if itemCounts.has(itemData.name):
			# Set focus to back the same item after removing it (if it still exists)
			for child in grid_container.get_children():
				if child.itemData.name == itemData.name:
					child.get_node("Button").grab_focus()
					break

		return true
	return false

# Get the count of an item
func get_item_count(itemData: Global.ItemData) -> int:
	return itemCounts.get(itemData.name, 0)

#---------------------------------------------------------------
# Helper functions for UI integration
#---------------------------------------------------------------

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
	for itemName in itemCounts.keys():
		if (itemCounts[itemName] > 0):
			# Create a new item instance
			var new_item = ItemScene.instantiate()
			new_item.setup_item(Global.items[itemName], itemCounts[itemName])
					
			# Add the item to the grid container
			grid_container.add_child(new_item)

func _on_use_item_pressed():
	print("Use item button pressed")
	# Implement your use item logic here

func _on_drop_item_pressed():
	# Find the selected item in the grid container
	for child in grid_container.get_children():
		# If each child has a Button node, check if it has focus
		var button = child.get_node("Button")
		if button and button.has_focus():
			# Get the item type and count
			var itemData = child.itemData
			var itemName = itemData["name"]
			var count = itemCounts[itemName] # Assuming the item exists in the inventory
			
			# Remove the item from the inventory
			if remove_item(itemData, count):
				# Emit a signal to drop the item in the world
				emit_signal("item_dropped", itemData, count)
				break

func _on_exit_pressed():
	self.visible = false
