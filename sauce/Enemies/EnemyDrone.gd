extends "res://sauce/Enemies/EnemyPawn.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var move_timer = get_node("MoveTimer")
var move_timer_delay = 0.5


func shoot_bullet(direction):
	var bullet = bullet_class.instance()
	bullet.velocity = direction
	bullet.position = position
	get_tree().get_root().add_child(bullet)
	pass

func shoot():
	if shoot_now:
		shoot_bullet(bullet_speed * global.get_down_angle_vector(-30))
		shoot_bullet(bullet_speed * global.get_down_angle_vector(0))
		shoot_bullet(bullet_speed * global.get_down_angle_vector(30))
		shoot_now = false
# Called when the node enters the scene tree for the first time.
func _ready():
	hp = 20
	bullet_speed = 150
	shoot_delay = 0.5
	start_movement_timer()
	pass # Replace with function body.
	
func random_direction():
	var x_length = get_viewport_rect().size.x
	var y_length = get_viewport_rect().size.y
	var angle = 0
	if position.x < x_length*0.1:
		if position.y > y_length*0.9:
			angle = rand_range(90,181)
		elif position.y < y_length*0.1:
			angle = rand_range(0,91)
		else:
			angle = rand_range(0,181)
	elif position.x > x_length*0.9:
		if position.y > y_length*0.9:
			angle = rand_range(-180,-89)
		elif position.y < y_length*0.1:
			angle = rand_range(-90,1)
		else:
			angle = rand_range(-180,1)
	elif position.y > y_length*0.9:
		angle = rand_range(90,271)
	elif position.y < y_length*0.1:
		angle = rand_range(-90,91)
	else:
		angle = rand_range(-180,180)
	return global.get_down_angle_vector(angle)

func movement_change():
	velocity = velocity.length() * random_direction()
	pass
func start_movement_timer():
	move_timer.wait_time = move_timer_delay
	move_timer.connect("timeout",self,"movement_change")
	move_timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
