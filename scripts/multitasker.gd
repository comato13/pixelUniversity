extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	# Reference the viewports
	var balancing_viewport = $SubViewportContainer1/SubViewport
	var dodging_viewport = $SubViewportContainer2/SubViewport
	var library_viewport = $SubViewportContainer3/SubViewport
	
	## Load and instance each scene
	#var balancing_scene = load("res://scenes/BalancingLevel.tscn").instantiate()
	#var dodging_scene = load("res://scenes/DodgingLevel.tscn").instance()
	#var library_scene = load("res://scenes/LibraryLevel.tscn").instance()
	#
	## Add the scenes to their respective viewports
	#balancing_viewport.add_child(balancing_scene)
	#dodging_viewport.add_child(dodging_scene)
	#library_viewport.add_child(library_scene)

	# Set up initial visibility (all black)
	#$ViewportContainer1
	#$ViewportContainer2.modulate = Color(0, 0, 0) # Black
	#$ViewportContainer3.modulate = Color(0, 0, 0) # Black
