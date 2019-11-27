extends KinematicBody2D

var RotateSpeed = 5
var Radius = 50
const centre = Vector2()
export var angle = 0
export var hp = 20

var of_player = true

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
	
func damage(damage):
	hp -= damage
	if hp <= 0:
		print("shield down")
		queue_free()
	pass