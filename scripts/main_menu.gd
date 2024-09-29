extends Control

# Load the scenes
#var levelOne = preload("res://scenes/levelOne.tscn")
var levelTwo = preload("res://scenes/levelTwo.tscn")
var setting_scene = preload("res://scenes/setting.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

	# Start the transition
	# $AnimationPlayer.play('fadeFromBlack')
	# await $AnimationPlayer.animation_finished
	# $AnimationPlayer.stop()
	
	var continueButton = $VBoxContainer/Continue

	# Load the game if needed
	if (!FileAccess.file_exists(Global.SAVE_PATH + Global.INVENTORY_FILENAME) || !FileAccess.file_exists(Global.SAVE_PATH + Global.CURRENT_SCENE_FILENAME)):
		continueButton.disabled = true
	else:
		continueButton.disabled = false

func _on_new_game_pressed():
	$ClickSFX.play()
	LogoTransition.change_scene(levelTwo, false, false, false)


func _on_continue_pressed() -> void:
	$ClickSFX.play()
	LogoTransition.change_scene(levelTwo, true, false, false)


func _on_setting_pressed() -> void:
	$ClickSFX.play()
	LogoTransition.change_scene(setting_scene, false, false, false)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
