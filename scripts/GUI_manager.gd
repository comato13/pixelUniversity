extends Node

var GUI_FPS_scene = preload("res://scenes/GUI_FPS.tscn")
var GUI_interact_prompt_scene = preload("res://scenes/GUI_interact_prompt.tscn")

var fps_label
var interact_prompt

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Get the canvas layer node
	var canvas_layer = $CanvasLayer

	# Add the gui components to the scene
	fps_label = GUI_FPS_scene.instantiate()
	interact_prompt = GUI_interact_prompt_scene.instantiate()

	# Add them as children of the canvas layer
	canvas_layer.add_child(fps_label)
	canvas_layer.add_child(interact_prompt)


	# Hide the interact prompt by default
	interact_prompt.visible = false