extends CanvasLayer

signal restart
signal quit


func _on_quit_button_pressed() -> void:
	quit.emit()


func _on_restart_button_pressed() -> void:
	restart.emit()
