extends Node

var GUI_FPS_scene = preload("res://scenes/GUI_FPS.tscn")
var GUI_interact_prompt_scene = preload("res://scenes/GUI_interact_prompt.tscn")
var GUI_pause_menu_scene = preload("res://scenes/GUI_pause_menu.tscn")

var fps_label
var interact_prompt
var pause_menu

var is_paused = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Get the canvas layer node
	var canvas_layer = $CanvasLayer

	# Add the gui components to the scene
	fps_label = GUI_FPS_scene.instantiate()
	interact_prompt = GUI_interact_prompt_scene.instantiate()
	pause_menu = GUI_pause_menu_scene.instantiate()

	# Add them as children of the canvas layer
	canvas_layer.add_child(fps_label)
	canvas_layer.add_child(interact_prompt)
	canvas_layer.add_child(pause_menu)

	# Hide the interact prompt by default
	interact_prompt.visible = false
	

# Called every frame to check for input
func _process(delta: float) -> void:
	# Check if the 'pause' input (Escape key) is pressed
	if Input.is_action_just_pressed("pause"):
		toggle_pause_menu()

# Function to toggle the pause menu and game state
func toggle_pause_menu() -> void:
	is_paused = !is_paused  # Toggle the paused state
	get_tree().paused = is_paused  # Pause or unpause the game

	# Show or hide the pause menu
	pause_menu.visible = is_paused

	# You may also want to stop processing certain inputs or UI elements when the game is paused
	if is_paused:
		$ClickSFX.play()  # Optional: play a sound effect when pausing
