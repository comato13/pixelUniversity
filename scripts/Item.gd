extends Sprite2D
class_name Item

var is_picked_up: bool = false
var player: Node = null

enum ItemType { HEART, WATER_BOTTLE }

# define item position in the spritesheet
const itemPositions = {
	ItemType.HEART: Vector2(80.5, -1),
	ItemType.WATER_BOTTLE: Vector2(80, 96)
}

var item_type: ItemType

func _ready():
	# Initialization code
	region_rect = Rect2(itemPositions[item_type], Vector2(16, 16))
	
func _physics_process(_delta: float) -> void:
	# z_index is based on y position
	z_index = position.y + 1

#func pick_up(player_node: Node):
	#is_picked_up = true
	#player = player_node
	#hide() # Hide the item when picked up
#
#func drop():
	#if is_picked_up:
		#is_picked_up = false
		#show() # Show the item when dropped
		#position = player.position + Vector2(0, 50) # Drop the item near the player
		#player = null
#
#func _process(delta):
	#if is_picked_up and player:
		#position = player.position # Follow the player when picked up
