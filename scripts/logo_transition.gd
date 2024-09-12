extends CanvasLayer

@onready var color_rect = $ColorRect

func _ready():
	color_rect.visible = false

func change_scene(target: String) -> void:
	color_rect.visible = true
	$Swoosh.play()
	$AnimationPlayer.play('fadeToBlack')
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(target)
	$ReverseSwoosh.play()
	$AnimationPlayer.play('fadeFromBlack')
	await $AnimationPlayer.animation_finished
	color_rect.visible = false
