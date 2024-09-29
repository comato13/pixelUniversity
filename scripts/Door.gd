extends Interactable
class_name Door

@export var target_scene: PackedScene # Scene to load when interacting with the door
@export var target_position: Vector2 # Position to place the player in the new scene

func _ready() -> void:
	# Optional: Ensure necessary attributes are set
	if not target_scene:
		print("Warning: No target scene assigned to door!")
	if not target_position:
		print("Warning: No target position assigned to door!")

# Override the interact method to transition the player
func interact() -> void:
	transition()

# Custom method to handle scene transition
func transition():
	print("Transitioning to new scene...")

	# Check if target_scene is valid
	if target_scene:

		# If the target_scene is different, instantiate the new scene
		LogoTransition.change_scene(target_scene, false, false, true, target_position)

		# var new_scene = get_tree().current_scene

		
	else:
		print("Error: target_scene is null!")
		print("Same scene detected, moving player to target position.")

		# Move the player to the target position without changing the scene
		var current_scene = get_tree().current_scene
		var player = current_scene.get_node("player")
		if player:
			player.global_position = target_position
		else:
			print("Warning: Player not found in the current scene!")
		
	return



	
