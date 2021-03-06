
extends Node

# This script will be "auto-loaded" (Scene -> Project Settings -> AutoLoad),
# which means it's going to be loaded before the other scripts and scenes

# declaring constants
const MATERIAL_NEUTRAL = 0
const MATERIAL_PLAYER1 = 1
const MATERIAL_PLAYER2 = 2

const ROTATION_X_AXIS = Vector3(1,0,0)
const ROTATION_Y_AXIS = Vector3(0,1,0)
const ROTATION_Z_AXIS = Vector3(0,0,1)

const ROTATION_CLOCKWISE = 1
const ROTATION_COUNTERCLOCKWISE = -1

const VECTORS_LEFT_SIDE = [		Vector3(2,0,0),Vector3(2,0,1),Vector3(2,0,2),
								Vector3(2,1,0),Vector3(2,1,1),Vector3(2,1,2),
								Vector3(2,2,0),Vector3(2,2,1),Vector3(2,2,2)]
const VECTORS_RIGHT_SIDE = [	Vector3(0,0,0),Vector3(0,0,1),Vector3(0,0,2),
								Vector3(0,1,0),Vector3(0,1,1),Vector3(0,1,2),
								Vector3(0,2,0),Vector3(0,2,1),Vector3(0,2,2)]
const VECTORS_UP_SIDE = [		Vector3(0,2,0),Vector3(0,2,1),Vector3(0,2,2),
								Vector3(1,2,0),Vector3(1,2,1),Vector3(1,2,2),
								Vector3(2,2,0),Vector3(2,2,1),Vector3(2,2,2)]
const VECTORS_DOWN_SIDE = [		Vector3(0,0,0),Vector3(0,0,1),Vector3(0,0,2),
								Vector3(1,0,0),Vector3(1,0,1),Vector3(1,0,2),
								Vector3(2,0,0),Vector3(2,0,1),Vector3(2,0,2)]
const VECTORS_FRONT_SIDE = [	Vector3(0,0,0),Vector3(0,1,0),Vector3(0,2,0),
								Vector3(1,0,0),Vector3(1,1,0),Vector3(1,2,0),
								Vector3(2,0,0),Vector3(2,1,0),Vector3(2,2,0)]
const VECTORS_BACK_SIDE = [		Vector3(0,0,2),Vector3(0,1,2),Vector3(0,2,2),
								Vector3(1,0,2),Vector3(1,1,2),Vector3(1,2,2),
								Vector3(2,0,2),Vector3(2,1,2),Vector3(2,2,2)]
const VECTORS_ALL = [			Vector3(2,0,0),Vector3(2,0,1),Vector3(2,0,2),
								Vector3(2,1,0),Vector3(2,1,1),Vector3(2,1,2),
								Vector3(2,2,0),Vector3(2,2,1),Vector3(2,2,2),
								Vector3(1,0,0),Vector3(1,0,1),Vector3(1,0,2),
								Vector3(1,1,0),               Vector3(1,1,2),
								Vector3(1,2,0),Vector3(1,2,1),Vector3(1,2,2),
								Vector3(0,0,0),Vector3(0,0,1),Vector3(0,0,2),
								Vector3(0,1,0),Vector3(0,1,1),Vector3(0,1,2),
								Vector3(0,2,0),Vector3(0,2,1),Vector3(0,2,2)]

const CHANGING_MIDDLE_CUBE_ORDER = [0,1,2,1]
const CHANGING_CORNER_CUBE_ORDER = [0,2,2,0]

# declaring variables
var materials = {}
var current_scene = null

func _ready():
	# Loading all materials on a dictionary
	materials["neutral"] = load("Assets/neutral_fixedmaterial.mtl")
	materials["player1"] = load("Assets/player1_fixedmaterial.mtl")
	materials["player2"] = load("Assets/player2_fixedmaterial.mtl")
	
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)
	
	pass


func goto_scene(path):
	call_deferred("_deferred_goto_scene",path)
	
func _deferred_goto_scene(path):
	current_scene.free()
	var s = ResourceLoader.load(path)
	current_scene = s.instance()
	get_tree().get_root().add_child(current_scene)
	get_tree().set_current_scene(current_scene)