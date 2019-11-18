extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var time_stopped = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
signal enemy_hit
signal player_hit
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


# angle= 0 is straight down, 90 is right, -90 is left
func get_down_angle_vector(angle):
	var rad = deg2rad(angle)
	return Vector2(sin(rad),cos(rad))
