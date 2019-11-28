extends Node2D

var RotateSpeed = 5
var Radius = 50
const centre = Vector2()
export var angle = 0

export var type = "damage"

func _ready():
	var offset = Vector2(sin(angle), cos(angle)) * Radius;
	var pos = centre + offset
	position = pos
	set_process(true)

func _process(delta): 
	angle += RotateSpeed * delta;

	var offset = Vector2(sin(angle), cos(angle)) * Radius;
	var pos = centre + offset
	position = pos