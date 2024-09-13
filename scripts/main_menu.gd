extends Control

func _on_new_game_pressed():
	#get_tree().change_scene_to_file("res://scenes/levelOne.tscn")
	$ClickSFX.play()
	LogoTransition.change_scene("res://scenes/levelTwo.tscn")
	pass # Replace with function body.


func _on_continue_pressed() -> void:
	pass # Replace with function body.


func _on_setting_pressed() -> void:
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
