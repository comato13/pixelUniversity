extends PathFollow2D


@export var runSpeed = 120

func _process(delta: float) -> void:
	set_progress(get_progress() + runSpeed * delta)

func _ready() -> void:
	runSpeed = get_child(0).SPEED
