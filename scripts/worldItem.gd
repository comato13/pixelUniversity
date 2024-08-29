extends Area2D
class_name WorldItem

# Signal to notify that the item was clicked
signal item_clicked(item_type: String)


# Get Hard coded Item types from UI_Item.gd
enum ItemType {
	HEART,
	WATER_BOTTLE,
	SPEED_UP,
	COFFEE,
	MONEY,
	LEAF,
	PERFUME
}

# Hard coded item position in the spritesheet
const itemPositions = {
	ItemType.HEART: Vector2(80, 0),
	ItemType.WATER_BOTTLE: Vector2(80, 97),
	ItemType.SPEED_UP: Vector2(80, 33),
	ItemType.COFFEE: Vector2(80, 63),
	ItemType.MONEY: Vector2(64, 15),
	ItemType.LEAF: Vector2(112, 15),
	ItemType.PERFUME: Vector2(0, 80)
}

# Item Sprite Size in pixels
const ITEM_SPRITE_SIZE: int = 16

var item_type: ItemType

# Custom initializer function
func setup_item(_item_type: ItemType, count: int = 1) -> void:
	self.item_type = _item_type
	$RichTextLabel.text = str(count)
	$Sprite2D.region_rect = Rect2(itemPositions[item_type], Vector2(ITEM_SPRITE_SIZE, ITEM_SPRITE_SIZE))

func _ready():
	# Ensure the CollisionShape2D is enabled
	$CollisionShape2D.disabled = false

# Handle input events
func _input_event(_viewport, event, _shape_idx):
	print("Input event on item")
	# Check if the left mouse button was pressed
	#if event is InputEventMouseButton:
		##if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		#print("Item clicked in the world: %s" % item_type)
		#emit_signal("item_clicked", item_type)
		## Additional logic to pick up the item or interact
		#handle_item_pickup()

# Custom logic to handle item pickup
func handle_item_pickup():
	# Example logic to pick up the item
	queue_free()  # This would remove the item from the world
	# You can also notify the player or inventory system here


# Handle physics process
func _physics_process(_delta: float) -> void:
	# z_index is based on y position
	z_index = position.y + 1
