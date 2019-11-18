extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 200
var moving = false


# Called when the node enters the scene tree for the first time.
func _ready():
	# Replace with function body.
	pass

func _physics_process(delta):
	var move_vec = Vector2()
	if Input.is_action_pressed("move_up"):
		move_vec.y -= 1
	if Input.is_action_pressed("move_down"):
		move_vec.y += 1
	if Input.is_action_pressed("move_left"):
		move_vec.x -= 1
	if Input.is_action_pressed("move_right"):
		move_vec.x += 1
	moving = move_vec.length() != 0
	move_vec = move_vec.normalized()
	move_and_collide(move_vec * speed * delta)
	
	#clamping
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
