extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var time_stopped = false
var current_scene = null

export var hp = 100
export var time = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	pause_mode = Node.PAUSE_MODE_PROCESS
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)
	set_process(true)
	pass # Replace with function body.
signal enemy_hit
signal player_hit
signal timestop_counter(value)
signal player_hp(value)
signal boss_defeated
signal bullet_clear
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = not get_tree().paused

# angle= 0 is straight down, 90 is right, -90 is left
func get_down_angle_vector(angle):
	var rad = deg2rad(angle)
	return Vector2(sin(rad),cos(rad))
	
func goto_scene(path):
    # This function will usually be called from a signal callback,
    # or some other function in the current scene.
    # Deleting the current scene at this point is
    # a bad idea, because it may still be executing code.
    # This will result in a crash or unexpected behavior.

    # The solution is to defer the load to a later time, when
    # we can be sure that no code from the current scene is running:

    call_deferred("_deferred_goto_scene", path)


func _deferred_goto_scene(path):
	# Clear and reset some stuff
	emit_signal("bullet_clear")
	time_stopped = false

    # It is now safe to remove the current scene
	current_scene.free()

    # Load the new scene.
	var s = ResourceLoader.load(path)

    # Instance the new scene.
	current_scene = s.instance()

    # Add it to the active scene, as child of root.
	get_tree().get_root().add_child(current_scene)

    # Optionally, to make it compatible with the SceneTree.change_scene() API.
	get_tree().set_current_scene(current_scene)
	
