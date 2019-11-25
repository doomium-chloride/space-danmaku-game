extends Sprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var global = get_node("/root/global")

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	global.connect("timestop",self,"toggle_visibility")
	pass # Replace with function body.

func toggle_visibility():
	if visible:
		hide()
	else:
		show()