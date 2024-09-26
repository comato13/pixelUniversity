extends Control


func _on_continue_pressed() -> void:
	pass # Replace with function body.

func _on_settings_pressed() -> void:
	$ClickSFX.play()
	var setting_scene = load("res://scenes/setting.tscn")
	LogoTransition.change_scene(setting_scene, false)

func _on_main_menu_pressed() -> void:
	$ClickSFX.play()
	var main_menu = load("res://scenes/mainMenu.tscn")
	LogoTransition.change_scene(main_menu, false)
