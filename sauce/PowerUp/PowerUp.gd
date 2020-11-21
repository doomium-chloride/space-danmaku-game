extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var global = get_node("/root/global")

export var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	global.connect("bullet_clear",self,"queue_free")
	set_process(true)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not global.time_stopped:
		translate(velocity * delta)
	if not get_node("notifier").is_on_screen():
		queue_free()
	pass
