extends "res://sauce/Enemies/EnemyDrone.gd"

onready var spawner = get_parent().get_node("World/EnemySpawner")
onready var player = get_parent().get_node("World/player")
onready var label = get_parent().get_node("Control/Label")

export var max_hp = 1000

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
	elif position.y > y_length*0.5:
		angle = rand_range(90,271)
	elif position.y < y_length*0.1:
		angle = rand_range(-90,91)
	else:
		angle = rand_range(-180,180)
	return global.get_down_angle_vector(angle)

func _ready():
	spawner.spawn = false
	player.hp = global.hp
	player.timestop_recharge = global.time
	player.damage_player(0)
	
	hp = max_hp
	bullet_speed = 300
	shoot_delay = 0.5
	timer.wait_time = shoot_delay
	
	label.text = str(hp)
	
	set_process(true)
	pass
	
func shoot():
	if shoot_now:
		boss_spray()
		shoot_now = false
func boss_spray():
	for i in range(0,10):
		var angle = rand_range(-180,180)
		shoot_bullet(bullet_speed * global.get_down_angle_vector(angle))
	for i in range(0,10):
		var angle = rand_range(-90,90)
		shoot_bullet(bullet_speed * global.get_down_angle_vector(angle))
	pass
	
func got_hit(damage):
	hp -= damage
	label.text = str(hp)
	pass
	
func die():
	global.emit_signal("bullet_clear")
	global.goto_scene("res://scenes/TitleScreen.tscn")
