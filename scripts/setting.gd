extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)


func _on_texture_button_pressed() -> void:
	$ClickSFX.play()
	var mainMenu = load("res://scenes/mainMenu.tscn")
	LogoTransition.change_scene(mainMenu, false)


func _on_texture_button_2_pressed() -> void:
	OS.shell_open("https://docs.google.com/forms/d/1OcL_N0nlRP-aiP-SdveSl_WWQ9GKjPN2WSHMpW2JnmY/edit")
