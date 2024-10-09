extends Interactable
class_name Door

@export var target_scene_path: String # Path to the scene to transition to
@export var target_position: Vector2 # Position to place the player in the new scene
@export var keep_player: bool = true # Flag to indicate if the target scene is not a player scene

func _ready() -> void:
	# Optional: Ensure necessary attributes are set
	if not target_scene_path:
		print("Warning: No target scene assigned to door!")
	if not target_position:
		print("Warning: No target position assigned to door!")

# Override the interact method to transition the player
func interact() -> void:
	transition()

func _process(_delta: float) -> void:
	# Set the door's z-index based on its y position
	z_index = int(position.y) + Global.Z_INDEX_OFFSET

# Custom method to handle scene transition
func transition():
	print("Transitioning to new scene...")

	# Load the target scene
	var is_valid_scene = false
	if target_scene_path:
		var target_scene = ResourceLoader.load(target_scene_path)
		if target_scene:
			is_valid_scene = true
			LogoTransition.change_scene(target_scene, false, false, keep_player, target_position)	

	# Check if target_scene is valid
	if !is_valid_scene:
		print("Error: target scene couldn't be loaded!")

		# # Move the player to the target position without changing the scene
		# var current_scene = get_tree().current_scene
		# var player = current_scene.get_node("player")
		# if player:
		# 	player.global_position = target_position
		# else:
		# 	print("Warning: Player not found in the current scene!")
	return



	
