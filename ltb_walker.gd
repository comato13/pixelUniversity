extends CharacterBody2D

#	These are the people to dodge when doing the crossy road mini game

@onready var sprite : AnimatedSprite2D = get_node("AnimatedSprite2D")

const DESPAWN_LOC_LEFT  = -192
const DESPAWN_LOC_RIGHT = 383

const DIR_LEFT = -1
const DIR_RIGHT = 1

const ANIM_SPEED_LOW  = 0.5
const ANIM_SPEED_MED  = 1.0
const ANIM_SPEED_HIGH = 1.5

const WALKER_SPEED_LOW  = 20
const WALKER_SPEED_MED  = 50
const WALKER_SPEED_HIGH = 90

var set_animation = "Animation1Right"
var set_speed = 0
var set_loc_x = 0
var set_loc_y = 0
var set_dir = 0

func _ready() -> void:
	sprite.play(set_animation + ("Left" if set_dir == -1 else "Right"))
	#match set_speed:
		#WALKER_SPEED_LOW:
			#sprite2d.speedScale = ANIM_SPEED_LOW
		#WALKER_SPEED_MED:
			#sprite2d.speedScale = ANIM_SPEED_MED
		#WALKER_SPEED_HIGH:
			#sprite2d.speedScale = ANIM_SPEED_HIGH
		
	velocity.x = set_speed * set_dir
	global_position = Vector2(set_loc_x, set_loc_y)
	move_and_slide()

func init_walker(animation: String, speed: int, loc_x: int, loc_y, dir: int):
	set_animation = animation
	set_speed = speed
	set_loc_x = loc_x
	set_loc_y = loc_y
	set_dir = dir

func _process(_delta: float) -> void:
	move_and_slide()
	if (position.x < DESPAWN_LOC_LEFT or position.x > DESPAWN_LOC_RIGHT):
		queue_free()


func _on_reset_level_body_entered(body: Node2D) -> void:
	var reset_level = load("res://scenes/ltb.tscn")
	LogoTransition.change_scene(reset_level, false)
