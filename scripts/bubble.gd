extends Sprite2D

# Variable to keep track of visibility state
var is_visible = true

# This function is called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Create a Timer node
	var timer = Timer.new()
	
	# Set the timer to trigger every 2 seconds
	timer.wait_time = get_parent().chatTimer
	timer.autostart = true  # Automatically start the timer
	
	# Add the Timer to the current node
	add_child(timer)
	
	# Connect the timeout signal to a custom function that will be triggered every 2 seconds
	timer.connect("timeout", self._on_timer_timeout)

# This function will be called every 2 seconds when the timer times out.
func _on_timer_timeout() -> void:
	# Toggle visibility using show() and hide() methods
	if is_visible:
		hide()  # Hide the node
	else:
		show()  # Show the node
	
	# Toggle the visibility state
	is_visible = !is_visible
