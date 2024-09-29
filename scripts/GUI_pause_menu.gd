extends Control


func _on_continue_pressed() -> void:
	unpause_game()
	$ClickSFX.play()
	visible = false

func _on_settings_pressed() -> void:
	unpause_game()
	$ClickSFX.play()
	var setting_scene = load("res://scenes/setting.tscn")
	LogoTransition.change_scene(setting_scene, false, false, false)

func _on_save_quit_pressed() -> void:
	unpause_game()
	$ClickSFX.play()

	# Load the main menu scene
	var main_menu = load("res://scenes/mainMenu.tscn")
	LogoTransition.change_scene(main_menu, false, true, false)

func unpause_game() -> void:
	# Get the game scene (child at index 2)
	var game_scene = get_tree().root.get_child(2)

	# Unpause the game scene
	game_scene.process_mode = Node.PROCESS_MODE_INHERIT

	visible = false
