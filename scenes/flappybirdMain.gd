extends Node2D

@export var pipe_scene : PackedScene

var game_running : bool
var game_over : bool
var scroll
var score
var ground_offset : int = 999
const SCROLL_SPEED : float = 0.03
var screen_size : Vector2i
var ground_height : int
var pipes : Array
const PIPE_DELAY : int = 500
const PIPE_RANGE : int = 50

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_window().size
	ground_height = $Ground.get_node("Sprite2D").texture.get_height()
	new_game()
	
func new_game():
	get_tree().call_group("pipes", "queue_free")
	for i in pipes:
		i.queue_free()
	game_running = false
	game_over = false
	score = 0 
	scroll = 0
	$Score.text = str(score)
	$FlappyBirdOver.hide()
	pipes.clear()
	generate_pipes()
	$Book.reset()

func _input(event: InputEvent) -> void:
	if game_over == false:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				if game_running == false:
					start_game()
				else:
					if $Book.flying:
						$Book.flap()
						
func start_game():
	game_running = true
	$Book.flying = true
	$Book.flap()
	$Timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if game_running:
		scroll += SCROLL_SPEED
		if scroll >= screen_size.x - ground_offset:
			scroll = 0
			
		$Ground.position.x = -scroll
		
		for pipe in pipes:
			pipe.position.x -= SCROLL_SPEED


func _on_timer_timeout() -> void:
	generate_pipes()
	
func generate_pipes():
	var pipe = pipe_scene.instantiate()
	pipe.position.x = screen_size.x + PIPE_DELAY
	pipe.position.y = (screen_size.y - ground_height) / 2 + randi_range(-PIPE_RANGE, PIPE_RANGE)
	pipe.hit.connect(book_hit)
	pipe.scored.connect(scored)
	add_child(pipe)
	pipes.append(pipe)
	
func scored():
	score += 1
	$Score.text = str(score)
	
func check_top():
	if $Book.position.y+500 < 0:
		$Book.falling = true
		stop_game()
		#need fix

func stop_game():
	$Timer.stop()
	$FlappyBirdOver.show()
	$Book.flying = false
	game_running = false
	game_over = true

func book_hit():
	$Book.falling = true
	stop_game()


func _on_ground_hit() -> void:
	$Book.falling = true
	stop_game()


func _on_flappy_bird_over_quit() -> void:
	pass # Replace with function body.


func _on_flappy_bird_over_restart() -> void:
	new_game()
