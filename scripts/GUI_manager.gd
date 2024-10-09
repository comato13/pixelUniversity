extends Node

var GUI_FPS_scene = preload("res://scenes/GUI_FPS.tscn")
var GUI_interact_prompt_scene = preload("res://scenes/GUI_interact_prompt.tscn")
var GUI_pause_menu_scene = preload("res://scenes/GUI_pause_menu.tscn")
var GUI_energy_bar_scene = preload("res://scenes/GUI_energy_bar.tscn")

var fps_label
var interact_prompt
var pause_menu
var energy_bar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Get the canvas layer node
	var canvas_layer = $CanvasLayer

	# Add the gui components to the scene
	fps_label = GUI_FPS_scene.instantiate()
	interact_prompt = GUI_interact_prompt_scene.instantiate()
	pause_menu = GUI_pause_menu_scene.instantiate()
	energy_bar = GUI_energy_bar_scene.instantiate()

	# Add them as children of the canvas layer
	canvas_layer.add_child(fps_label)
	canvas_layer.add_child(interact_prompt)
	canvas_layer.add_child(pause_menu)
	canvas_layer.add_child(energy_bar)
	
	# Hide the interact prompt by default
	interact_prompt.visible = false

	# Hide the pause menu by default
	pause_menu.visible = false


# Called every frame to check for input
func _process(_delta: float) -> void:
	# Check if the 'pause' input (Escape key) is pressed
	if Input.is_action_just_pressed("pause"):
		# First exit the currently shown inventory if it is open
		if !pause_menu.visible and Global.INV_manager.shown_inv != "":
			Global.INV_manager.toggle_inventory(Global.INV_manager.shown_inv)
			return
		
		# Proceed to toggle the pause menu
		toggle_pause_menu()

# Function to toggle the pause menu and game state
func toggle_pause_menu() -> void:
	var is_paused = !pause_menu.visible  # Get and flip the current pause state

	# Get the game scene (child at index 2)
	var game_scene = get_tree().root.get_child(2)

	# Pause or unpause the game scene
	if is_paused:
		game_scene.process_mode = Node.PROCESS_MODE_DISABLED
	else:
		game_scene.process_mode = Node.PROCESS_MODE_INHERIT

	# Show or hide the pause menu
	pause_menu.visible = is_paused


# Functions to control visibility of GUI (it needs to be hidden in menus such as settings)
func hide_all_gui() -> void:
	$CanvasLayer.hide()

func show_all_gui() -> void:
	$CanvasLayer.show()
