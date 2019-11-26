extends "res://sauce/Enemies/Enemy.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const bullet_class = preload("res://sauce/Enemies/EnemyBullet.tscn")

var shoot_delay = 1.0
var timer = null
var bullet_speed = 100
var shoot_now = false

# Called when the node enters the scene tree for the first time.
func _ready():
	global.connect("timestop",self,"pause_shoot_timer")
	velocity.y = 100
	begin_shooting()
	set_process(true)
	pass # Replace with function body.
func shoot_bullet(speed):
	var bullet = bullet_class.instance()
	bullet.velocity.x = speed
	bullet.position = position
	get_tree().get_root().add_child(bullet)
	pass

func shoot():
	if shoot_now:
		shoot_bullet(bullet_speed)
		shoot_bullet(bullet_speed*-1)
		shoot_now = false

func shoot_update():
	shoot_now = true

func begin_shooting():
	timer = get_node("Timer") 
	timer.wait_time = shoot_delay
	timer.connect("timeout",self,"shoot_update")
	timer.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global.time_stopped:
		return
	shoot()
	pass

func pause_shoot_timer():
	timer.paused = global.time_stopped
