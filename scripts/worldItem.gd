extends Interactable
class_name WorldItem

# Load Item data from global script
# var global = preload("res://scripts/global.gd")

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
	# Add the item to the player's inventory
	var playerINV = Global.INV_manager.canvas_layer.get_node(Global.PLAYER_INV_NAME)
	if playerINV:
		playerINV.add_item(itemData, count)
	else:
		print("Player inventory not found!")
	# Remove the item from the world
	queue_free()
	print("Picked up item: ", itemData.name)

# Handle physics process for z-index sorting
func _physics_process(_delta: float) -> void:
	# z_index is based on y position
	z_index = int(position.y) + Global.Z_INDEX_OFFSET
