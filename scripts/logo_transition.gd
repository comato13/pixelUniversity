extends CanvasLayer

@onready var color_rect = $ColorRect

# var player_target_position: Vector2

func _ready():
	color_rect.visible = false

func change_scene(target_scene: PackedScene, move_player: bool = true, player_position: Vector2 = Vector2(0, 0)) -> void:
	# Start the transition
	color_rect.visible = true
	$Swoosh.play()
	$AnimationPlayer.play('fadeToBlack')
	await $AnimationPlayer.animation_finished

	
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
	if (move_player):
		move_player_to_new_scene(current_scene, new_scene, player_position)

	# End the transition
	$ReverseSwoosh.play()
	$AnimationPlayer.play('fadeFromBlack')
	await $AnimationPlayer.animation_finished
	color_rect.visible = false


func move_player_to_new_scene(current_scene, new_scene, player_position):
	if current_scene.has_node("Player"):
		# If the player exists in the current scene, move it to the new scene
		var player = current_scene.get_node("Player")
		
		# Remove the player from the current scene (but don't free it)
		current_scene.remove_child(player)

		# Delete the player from the new scene if it exists
		if new_scene.has_node("player"):
			new_scene.get_node("player").queue_free()

		# Add the player to the new scene
		new_scene.add_child(player)
		player.global_position = player_position
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
