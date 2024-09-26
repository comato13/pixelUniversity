extends Interactable
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

# Override the interact method from the Interactable class
func interact() -> void:
	handle_item_pickup()

# Custom logic to handle item pickup
func handle_item_pickup():
	print("Picking up item: ", itemData.name)
	# Add item to the player's inventory here
	# Notify the player or inventory system that the item was picked up
	queue_free()  # This would remove the item from the world

# Handle physics process for z-index sorting
func _physics_process(_delta: float) -> void:
	# z_index is based on y position
	z_index = int(position.y) + 1000
