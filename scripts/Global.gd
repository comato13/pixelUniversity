extends Node

# Define the ItemData class to hold item details
class ItemData:
	var name: String
	var position: Vector2
	var size: Vector2

	func _init(_name: String, _position: Vector2, _size: Vector2):
		self.name = _name
		self.position = _position
		self.size = _size


var items = {}
var are_items_loaded: bool = false

func _ready():
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
