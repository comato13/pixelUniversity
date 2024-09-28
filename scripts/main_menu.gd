extends Control

# Load the scenes
#var levelOne = preload("res://scenes/levelOne.tscn")
var levelTwo = preload("res://scenes/levelTwo.tscn")
var setting_scene = preload("res://scenes/setting.tscn")

func _on_new_game_pressed():
	$ClickSFX.play()
	LogoTransition.change_scene(levelTwo, false)


func _on_continue_pressed() -> void:
	pass # Replace with function body.


func _on_setting_pressed() -> void:
	$ClickSFX.play()
	LogoTransition.change_scene(setting_scene, false)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
