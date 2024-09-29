extends Node

# Load manager scenes
var GUI_manager_scene = preload("res://scenes/GUI_manager.tscn")
var INV_manager_scene = preload("res://scenes/INV_manager.tscn")

# Define the ItemData class to hold item details
class ItemData:
	var name: String
	var position: Vector2
	var size: Vector2

	func _init(_name: String, _position: Vector2, _size: Vector2):
		self.name = _name
		self.position = _position
		self.size = _size

# Global variables
var items = {}
var are_items_loaded: bool = false

var GUI_manager
var INV_manager

# Constants
const SAVE_PATH = "res://saves/"
const INVENTORY_FILENAME = "saved_INV_manager.tscn"
const CURRENT_SCENE_FILENAME = "saved_current_scene.tscn"
const Z_INDEX_OFFSET = 1000
const PLAYER_INV_NAME = "Backpack Inventory"

func _ready():
	# Initialize the managers
	GUI_manager = GUI_manager_scene.instantiate()
	INV_manager = INV_manager_scene.instantiate()

	# Add the managers to the scene tree
	add_child(GUI_manager)
	add_child(INV_manager)

	# Load the item data
	load_item_data()

func load_item_data():
	var file = FileAccess.open("res://data/items.json", FileAccess.READ)
	if file:
		var json = JSON.new()
		var parse_result = json.parse(file.get_as_text())
		file.close()
		
		print("parse_result: ", parse_result)

		# Check if parsing was successful
		if parse_result == OK:
			var data = json.data
			
			for item in data["items"]:
				var item_name = item["name"]
				var item_position = Vector2(item["position"][0], item["position"][1])
				var item_size = Vector2(item["size"][0], item["size"][1])
				var item_data = ItemData.new(item_name, item_position, item_size)
				items[item_name] = item_data
			
			are_items_loaded = true
			print("Items loaded")
		else:
			print("Failed to parse JSON: ", parse_result.error)
	else:
		print("Item file not found!")
