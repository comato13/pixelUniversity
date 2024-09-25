extends Node

var FPSLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	FPSLabel = $FPSLabel


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var fps = Engine.get_frames_per_second()
	FPSLabel.text = "FPS: " + str(fps)
