extends CanvasLayer

@onready var color_rect = $ColorRect

func _ready():
	color_rect.visible = false

func change_scene(
	target_scene: PackedScene,
	load_game: bool = false,
	save_game: bool = false,
	move_player: bool = true, 
	player_position: Vector2 = Vector2(0, 0)
) -> void:
	if load_game:
		if (!FileAccess.file_exists(Global.SAVE_PATH + Global.INVENTORY_FILENAME) || !FileAccess.file_exists(Global.SAVE_PATH + Global.CURRENT_SCENE_FILENAME)):
			print("Error: No save data found!")
			return

	# Start the transition
	color_rect.visible = true
	$Swoosh.play()
	$AnimationPlayer.play('fadeToBlack')
	await $AnimationPlayer.animation_finished

	# Load the game if needed
	if load_game:
		# Load the game
		target_scene = load_game_state()
		if not target_scene:
			print("Error: Failed to load the game!")
			return

	# Save the game if needed
	if save_game:
		save_game_state()

		# Clear manager nodes

	# Get the current scene and the player node
	var current_scene = get_tree().current_scene

	# Delete the current scene
	current_scene.queue_free()

	# Load the new scene
	var new_scene = target_scene.instantiate()
	if not new_scene:
		print("Error: Could not instance the new scene!")
		return

	# Add the new scene to the tree
	get_tree().root.add_child(new_scene)

	# Set the new scene as the current scene
	get_tree().current_scene = new_scene

	# Handle player switching between scenes
	if move_player:
		# We are switching to a game scene, move the player
		move_player_to_new_scene(current_scene, new_scene, player_position)


	# End the transition
	$ReverseSwoosh.play()
	$AnimationPlayer.play('fadeFromBlack')
	await $AnimationPlayer.animation_finished
	color_rect.visible = false


func move_player_to_new_scene(current_scene, new_scene, player_position):
	if current_scene.has_node("player"):
		# If the player exists in the current scene, move it to the new scene
		var player = current_scene.get_node("player")
		
		# Remove the player from the current scene (but don't free it)
		current_scene.remove_child(player)

		# Delete the player from the new scene if it exists
		if new_scene.has_node("player"):
			new_scene.get_node("player").queue_free()

		# Add the player to the new scene
		new_scene.add_child(player)
		player.global_position = player_position
		player.update_interact_prompt()
		
	else:
		# Current scene doesn't have a player, check if the new scene has one

		# If player is in new scene already, use that instance
		if new_scene.has_node("player"):
			var player = new_scene.get_node("player")
			player.global_position = player_position
		else:
			# If the player doesn't exist in the new scene, create a new player
			var new_player = preload("res://scenes/player.tscn").instantiate()
			new_scene.add_child(new_player)
			new_player.global_position = player_position


# ----------------------------------------------------------------

# Save and load game state functions

func save_game_state():
	# Ensure every child are owned by the inventory manager
	set_ownership_recursive(Global.INV_manager, Global.INV_manager)
	# Save all inventory data in INV_manager to a file
	save_scene_to_file(Global.INV_manager, Global.SAVE_PATH + Global.INVENTORY_FILENAME)

	# Save the current scene to a file
	var current_scene = get_tree().current_scene
	set_ownership_recursive(current_scene, current_scene)
	save_scene_to_file(current_scene, Global.SAVE_PATH + Global.CURRENT_SCENE_FILENAME)
	
	print("Game saved successfully!")

func set_ownership_recursive(parent: Node, owner: Node) -> void:
	# Ensures everything under the parant is saved with the owner
	# Set the owner for the current node
	parent.set_owner(owner)

	# Recursively set ownership for all children
	for child in parent.get_children():
		set_ownership_recursive(child, owner)


func save_scene_to_file(scene: Node, file_path: String) -> void:
	# Create a packed scene from the current node and its children
	var packed_scene = PackedScene.new()
	var result = packed_scene.pack(scene)
	
	# Check if the scene was successfully packed
	if result == OK:
		var error = ResourceSaver.save(packed_scene, file_path)
		if error == OK:
			print("Scene saved successfully to ", file_path)
		else:
			print("Failed to save scene: ", error)
	else:
		print("Failed to pack the scene: ", result)

func load_game_state() -> PackedScene:
	# # Load the inventory data from the file
	# var saved_inv_manager = ResourceLoader.load(Global.SAVE_PATH + Global.INVENTORY_FILENAME).instantiate()
	# # Replace the existing inventory manager with the loaded one
	# saved_inv_manager.name = Global.INV_manager.name
	# Global.INV_manager.queue_free()
	# Global.INV_manager = saved_inv_manager
	# Global.add_child(saved_inv_manager)
	# for child in Global.INV_manager.canvas_layer.get_children():
	# 	# Remove child immediately
	# 	child.queue_free()
	# Wait for the children to finish deleting
	# for child in saved_inv_manager.canvas_layer.get_children():
	# 	Global.INV_manager.canvas_layer.add_child(child)
	
	# Load the current scene from the file
	var target_scene = ResourceLoader.load(Global.SAVE_PATH + Global.CURRENT_SCENE_FILENAME)

	print("Game loaded successfully!")

	# Return the target scene to continue the scene transition
	return target_scene
