extends Area2D

func _ready() -> void:
	$LTBSign.hide()
	print("1")


func _on_body_entered(body: Node2D) -> void:
	print("2")
	$LTBSign.show()


func _on_body_exited(body: Node2D) -> void:
	print("3")
	$LTBSign.hide()
