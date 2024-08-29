extends Control
class_name UI_Item

# signal item_right_clicked(item_type: ItemType)
# signal item_left_clicked(item_type: ItemType)


# Hard coded Item types
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
var is_dropped: bool = false  # This flag can be used to differentiate behavior

# Custom initializer function
func setup_item(_item_type: ItemType, count: int = 1) -> void:
	self.item_type = _item_type
	$RichTextLabel.text = str(count)
	$Sprite2D.region_rect = Rect2(itemPositions[item_type], Vector2(ITEM_SPRITE_SIZE, ITEM_SPRITE_SIZE))
