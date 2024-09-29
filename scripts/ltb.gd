extends Node

var worldItemScene = preload("res://scenes/worldItem.tscn")

#	This is baaaaasically crossy road (or frogger, w/e)
#	Preload the walker
var ltb_walker := preload("res://Scenes/ltb_walker.tscn")

#	Different spawn related constants
const N_SPAWN_LOCS    = 3

const SPAWN_FREQ_LOW  = 0.5
const SPAWN_FREQ_MED  = 0.7
const SPAWN_FREQ_HIGH = 0.9

const WALKER_SPEED_LOW  = 50
const WALKED_SPEED_MED  = 90
const WALKER_SPEED_HIGH = 150

const SPAWN_LOC_LEFT  = -192
const SPAWN_LOC_RIGHT = 383

const ANIMATION1 = "Animation1"
const ANIMATION2 = "Animation2"
const ANIMATION3 = "Animation3"
const ANIMATION4 = "Animation4"
const ANIMATION5 = "Animation5"

const DIR_LEFT_SIGN  = -1
const DIR_RIGHT_SIGN = 1

#	Spawn location data
#	All arrays should have the same size as N_SPAWN_LOCS

const SPAWN_LOC_X = [
	SPAWN_LOC_RIGHT,
	SPAWN_LOC_LEFT,
	SPAWN_LOC_RIGHT,
]

const SPAWN_LOC_Y = [
	-50,
	-190,
	-285,
]

const SPAWN_LOC_SPEED = [
	WALKER_SPEED_LOW,
	WALKED_SPEED_MED,
	WALKER_SPEED_HIGH,
]

const SPAWN_LOC_FREQ = [
	SPAWN_FREQ_LOW,
	SPAWN_FREQ_MED,
	SPAWN_FREQ_HIGH,
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	call_deferred("spawn_trophy")

func spawn_trophy() -> void:
	# Spawn trophy -----------------------------------
	
	# Instance the item scene
	var newWorldItem = worldItemScene.instantiate()
	
	# Get the item data from the global item manager
	var itemData = Global.items["Trophy"]
	newWorldItem.setup_item(itemData, 1)
	
	# Add the item to the current scene
	get_tree().current_scene.add_child(newWorldItem)
	
	# Set the item's position in the Global scene
	newWorldItem.global_position = Vector2(65, -329)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_spawn_timer_timeout() -> void:
	#	For each location, randomly determine whether or not to spawn a new walker
	for i in N_SPAWN_LOCS:
		if randf() < SPAWN_LOC_FREQ[i]:
			var walker = ltb_walker.instantiate()
			
			walker.init_walker(
				"Animation" + str(randi_range(1, 8)),
				SPAWN_LOC_SPEED[i],
				SPAWN_LOC_X[i],
				SPAWN_LOC_Y[i],
				(1 if SPAWN_LOC_X[i] == SPAWN_LOC_LEFT else -1)
			)
			
			add_child(walker)
