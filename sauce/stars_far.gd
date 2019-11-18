extends Sprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var global = get_node("/root/global")
export var velocity = Vector2(0,50)

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)
	pass # Replace with function body.

func get_y():
	var this_y = position.y + get_offset()
	return this_y
	
func set_y(new_y):
	position.y = new_y - get_offset()
	pass
func get_offset():
	return offset.y * scale.y
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global.time_stopped:
		return
	translate(velocity * delta)
	if get_y() >= get_viewport_rect().size.y:
		set_y(get_rect().size.y*-1*scale.y)
	pass


