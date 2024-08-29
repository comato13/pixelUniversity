extends Control
class_name Item

signal item_right_clicked(item_type: ItemType)
signal item_left_clicked(item_type: ItemType)


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
func setup_item(item_type: ItemType, count: int = 1) -> void:
	self.item_type = item_type
	$RichTextLabel.text = str(count)
	$Sprite2D.region_rect = Rect2(itemPositions[item_type], Vector2(ITEM_SPRITE_SIZE, ITEM_SPRITE_SIZE))

func _ready():
	# Connect signals for right-click and left-click
	#connect("item_right_clicked", Callable(get_parent(), "_on_item_right_clicked"))
	#connect("item_left_clicked", Callable(get_parent(), "_on_item_left_clicked"))
	$Button.pressed.connect(self._button_pressed)
	pass

## Handle mouse input
func _button_pressed() -> void:
	print("Item clicked")
	# if Input.is_action_just_pressed("ui_right_click"):
	# 	if is_dropped:
	# 		print("Item right clicked in world")
	# 	else:
	# 		print("Item right clicked in UI")
	# 		# emit_signal("item_right_clicked", item_type)
	# elif Input.is_action_just_pressed("ui_left_click"):
	# 	if is_dropped:
	# 		print("Item left clicked in world")
	# 	else:
	# 		print("Item left clicked in UI")
			# emit_signal("item_left_clicked", item_type)

#func _gui_input(event: InputEvent) -> void:
	#if event is InputEventMouseButton:
		#print("Item clicked")
		#if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			#if is_dropped:
				#print("Item right clicked in world")
			#else:
				#print("Item right clicked in UI")
				##emit_signal("item_right_clicked", item_type)
		#elif event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			#if is_dropped:
				#print("Item left clicked in world")
			#else:
				#print("Item left clicked in UI")
				##emit_signal("item_left_clicked", item_type)

func _physics_process(_delta: float) -> void:
	# z_index is based on y position
	z_index = position.y + 1
