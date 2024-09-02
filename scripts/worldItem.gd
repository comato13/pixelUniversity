extends Area2D
class_name WorldItem

# Load Item data from global script
# var global = preload("res://scripts/global.gd")

# Signal to notify that the item was clicked
signal item_clicked(item_type: String)

var itemData: Global.ItemData
var count: int

# Custom initializer function
func setup_item(_itemData: Global.ItemData, _count: int = 1) -> void:
	self.itemData = _itemData
	$Sprite2D.region_rect = Rect2(self.itemData.position, self.itemData.size)
	
	self.count = _count
	$RichTextLabel.text = str(count)

func _ready():
	# Ensure the CollisionShape2D is enabled
	$CollisionShape2D.disabled = false

# Custom logic to handle item pickup
func handle_item_pickup():
	# Example logic to pick up the item
	queue_free()  # This would remove the item from the world
	# You can also notify the player or inventory system here


# Handle physics process
func _physics_process(_delta: float) -> void:
	# z_index is based on y position
	z_index = position.y + 1
