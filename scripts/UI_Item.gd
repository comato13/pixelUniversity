extends Control
class_name UI_Item


var itemData: Global.ItemData
var count: int

# Custom initializer function
func setup_item(_itemData: Global.ItemData, _count: int = 1) -> void:
	self.itemData = _itemData
	$Sprite2D.region_rect = Rect2(self.itemData.position, self.itemData.size)

	self.count = _count
	$RichTextLabel.text = str(count)
	
