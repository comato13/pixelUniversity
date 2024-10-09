extends PathFollow2D


@export var runSpeed = 120

func _process(delta: float) -> void:
	set_progress(get_progress() + runSpeed * delta)
