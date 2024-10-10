extends Area2D  # Use Area2D to detect proximity

# Reference to the PopupMenu (UI) node
@onready var popup_menu = $Sign  # Assuming the popup is a child of this node

# Track whether the player is near the sign
var player_nearby = false

# Function to show the pop-up menu
func show_popup() -> void:
	popup_menu.show()  # Show the pop-up menu
	# Optionally, if it's a PopupMenu type, you can call popup_menu.popup_centered()

# Function to hide the pop-up menu
func hide_popup() -> void:
	popup_menu.hide()  # Hide the pop-up menu

# Input event for interaction when player presses a button (e.g., "E" for interaction)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player":  # Assuming the player node is named "Player"
		player_nearby = true
	print("x")
	
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "player":
		player_nearby = false
		hide_popup()
		print("o")


func _input(event):
	if event.is_action_pressed("interact"):
		if player_nearby:  # "ui_accept" is mapped to "E" by default
			if popup_menu.is_visible():
				hide_popup()  # Hide the pop-up if it's already visible
			else:
				show_popup()
