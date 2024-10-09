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
	barMiddle.scale.x = barPixels
	barEnd.position.x = barPixels

	# Show/hide the energy bar when energy is low
	barStart.visible = energy > 0.01
	barMiddle.visible = energy > 0.01
	barEnd.visible = energy > 0.01

	# set the color of the energy bar based on the energy level
	if energy < 1.0/3.0:
		barStart.region_rect = Rect2(319, 389, 1, 6)
		barMiddle.region_rect = Rect2(320, 389, 1, 6)
		barEnd.region_rect = Rect2(335, 389, 2, 6)
	elif energy < 2.0/3.0:
		barStart.region_rect = Rect2(319, 405, 1, 6)
		barMiddle.region_rect = Rect2(320, 405, 1, 6)
		barEnd.region_rect = Rect2(335, 405, 2, 6)
	else:
		barStart.region_rect = Rect2(271, 405, 1, 6)
		barMiddle.region_rect = Rect2(280, 405, 1, 6)
		barEnd.region_rect = Rect2(287, 405, 2, 6)
