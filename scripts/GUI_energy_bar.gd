extends Node

var barStart
var barMiddle
var barEnd

const BAR_WIDTH = 65

var energy: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	barStart = $Bar/Start
	barMiddle = $Bar/Middle
	barEnd = $Bar/End

	# Set the energy bar
	energy = 1.0
	update_energy()

func update_energy(change: float = 0.0) -> void:
	# Update the energy level
	energy = clamp(energy + change, 0, 1)

	# Resize the energy bar based on the energy level
	var barPixels = int(energy * BAR_WIDTH) + 1
	barMiddle.scale.x = barPixels * 0.5
	barEnd.position.x = barPixels

	# Show/hide the energy bar when energy is low
	barStart.visible = energy > 0.01
	barMiddle.visible = energy > 0.01
	barEnd.visible = energy > 0.01

	# set the color of the energy bar based on the energy level
	if energy < 1.0/3.0:
		barStart.region_rect = Rect2(638, 778, 2, 12)
		barMiddle.region_rect = Rect2(640, 778, 2, 12)
		barEnd.region_rect = Rect2(670, 778, 4, 12)
	elif energy < 2.0/3.0:
		barStart.region_rect = Rect2(638, 810, 2, 12)
		barMiddle.region_rect = Rect2(640, 810, 2, 12)
		barEnd.region_rect = Rect2(670, 810, 4, 12)
	else:
		barStart.region_rect = Rect2(542, 810, 2, 12)
		barMiddle.region_rect = Rect2(560, 810, 2, 12)
		barEnd.region_rect = Rect2(574, 810, 4, 12)
