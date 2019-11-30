extends KinematicBody2D

const bullet_class = preload("res://sauce/PlayerBullet.tscn")
const shield_class = preload("res://sauce/PowerUp/Shield.tscn")

const DamageUp = preload("res://sauce/PowerUp/DamageUp.tscn")
const RegenUp = preload("res://sauce/PowerUp/RegenUp.tscn")
const TimeRegenUp = preload("res://sauce/PowerUp/TimeRegenUp.tscn")

onready var global = get_node("/root/global")
# Declare member variables here. Examples:
# var a = 2
# var b = "text
var on_death = "res://scenes/Tutorial/PlayerDeath.tscn"

var timestop_timer = null
var timestop_recharge = 5.0
const timestop_step = 0.01
onready var timestopFX = get_node("TimestopFX")

var is_invincible = false
var invincible = null
var invincible_time = 0.5

const base_danmaku_delay = 0.2
var danmaku_delay = base_danmaku_delay
var shoot_now = false
var bullet_speed = 500
var bullet_damage = 5
var bullet_damage_bonus = 0
var danmaku_timer = null
var danmaku_delay_mod = 1

const base_speed = 300
var speed = base_speed
var moving = false

const of_player = true

const max_hp = 100
var hp = max_hp
var regen_rate = 0
onready var regen_timer = Timer.new()

const base_time_regen = 0.5
var time_regen_mod = 1

var shoot_style = "flat"

var powerup_container = null
var powerup_names = []

# Called when the node enters the scene tree for the first time.
func _ready():
	#don't loop timestopFX
	timestopFX.stream.loop = false
	#init timestop timer
	timestop_timer = get_node("timestop_timer")
	timestop_timer.wait_time = timestop_step
	timestop_timer.one_shot = false
	timestop_timer.connect("timeout",get_node("."),"timestop_recharge")
	timestop_timer.start()
	
	if not global.is_connected("player_hit",self,"_on_player_hit"):
		global.connect("player_hit",self,"_on_player_hit")
	begin_shooting()
	
	if not global.is_connected("health_pack",self,"heal"):
		global.connect("health_pack",self,"heal")
	
	if not global.is_connected("style_change",self,"change_style"):
		global.connect("style_change",self,"change_style")
		
	if not global.is_connected("power_up",self,"add_powerup"):
		global.connect("power_up",self,"add_powerup")
	
	invincible = get_node("invincibility_timer")
	invincible.wait_time = invincible_time
	invincible.one_shot = true
	invincible.connect("timeout",self,"end_invincibility")
	
	powerup_container = Node2D.new()
	add_child(powerup_container)
	
	add_child(regen_timer)
	regen_timer.wait_time = 5
	regen_timer.connect("timeout",self,"regen")
	regen_timer.start()
	
	change_style("narrow",0.1)
	
	set_process(true)
	
	
	
	pass

func _physics_process(delta):
	var move_vec = Vector2()
	# movement controls
	if Input.is_action_pressed("move_up"):
		move_vec.y -= 1
	if Input.is_action_pressed("move_down"):
		move_vec.y += 1
	if Input.is_action_pressed("move_left"):
		move_vec.x -= 1
	if Input.is_action_pressed("move_right"):
		move_vec.x += 1
	# Stop the player from leaving the view
	if position.y < scale.y:
		move_vec.y = max(move_vec.y,0)
	if position.y > get_viewport_rect().size.y*scale.y:
		move_vec.y = min(move_vec.y,0)
	if position.x < scale.x:
		move_vec.x = max(move_vec.x,0)
	if position.x > get_viewport_rect().size.x*scale.x:
		move_vec.x = min(move_vec.x,0)
	moving = move_vec.length() != 0
	move_vec = move_vec.normalized()
	#check for collisions
	var collision = move_and_collide(move_vec * speed * delta)
	if collision:
		#print(collision.collider.get_name())
		if not collision.collider.of_player:
			collision.collider.got_hit(1)
			damage_player(1)


func begin_shooting():
	danmaku_timer = get_node("danmaku_timer")
	danmaku_timer.wait_time = danmaku_delay
	danmaku_timer.connect("timeout",get_node("."),"shoot_again")
	danmaku_timer.start()
	

func shoot_again():
	shoot_now = true
	pass

func shoot():
	if shoot_now:
		if shoot_style == "flat":
			basic_shoot()
		elif shoot_style == "spread":
			danmaku_timer.wait_time = 1
			spread_shoot()
		elif shoot_style == "narrow":
			shoot_bullet()
		shoot_now = false

func shoot_bullet(angle = 0, pos = position):
	var bullet = bullet_class.instance()
	bullet.of_player = true
	bullet.damage = bullet_damage + bullet_damage_bonus
	bullet.velocity = bullet_speed * global.get_up_angle_vector(angle)
	bullet.position = pos
	get_tree().get_root().add_child(bullet)
	
func spread_shoot():
	for i in range(-10,11,2):
		shoot_bullet(i)
	pass

func basic_shoot():
	shoot_bullet(0,position + Vector2(-15,0))
	shoot_bullet()
	shoot_bullet(0,position + Vector2(15,0))
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	shoot()
	if Input.is_action_just_pressed("toki"):
		global.time_stopped = not global.time_stopped
		global.emit_signal("timestop")
		refresh_powerups()
		if global.time_stopped:
			timestopFX.play()
	if hp < 0:
		print("player death")
		global.emit_signal("bullet_clear")
		global.goto_scene(on_death)
	
	# Style syntax for shooting style change
	# change_style(style,delay,damage=5)
	if Input.is_action_just_pressed("FlatStyle"):
		change_style("flat",0.3)
	if Input.is_action_just_pressed("WideStyle"):
		change_style("spread",1.1)
	if Input.is_action_just_pressed("NarrowStyle"):
		change_style("narrow",0.1)
	
	
	
func _on_player_hit(damage):
	damage_player(damage)
	lose_powerup()

func damage_player(damage):
#	if is_invincible:
#		return
#	else:
#		is_invincible = true
#		invincible.start()
	hp -= damage
	if hp > max_hp:
		hp = max_hp
	global.emit_signal("player_hp",hp)

	
func timestop_add(number):
	timestop_recharge += number
	if timestop_recharge > 5.0:
		timestop_recharge = 5.0
	elif timestop_recharge < 0:
		timestop_recharge = 0.0
		global.time_stopped = false
		global.emit_signal("timestop")
	global.emit_signal("timestop_counter",timestop_recharge)

func timestop_recharge():
	if global.time_stopped:
		timestop_add(-1*timestop_step)
	else:
		timestop_add(timestop_step*base_time_regen*time_regen_mod)
		
func end_invincibility():
	is_invincible = false
	
func heal(value):
	damage_player(-value)
	
func change_style(style,delay,damage = 5):
	shoot_style = style
	danmaku_timer.wait_time = delay / danmaku_delay_mod
	bullet_damage = damage
	danmaku_timer.start()
	pass
	
func add_shield():
	var shield = shield_class.instance()
	shield.angle = rand_range(0,360)
	print("added ",shield.get_name())
	powerup_container.add_child(shield)
	
func add_powerup(powerup):
	#add damage power up
	var buff = powerup.instance()
	buff.angle = rand_range(0,360)
	powerup_names.append(buff.get_name())
	powerup_container.add_child(buff)
	refresh_powerups()
	pass
	
func lose_powerup():
	if powerup_container.get_children().size() <= 0:
		return
	var n = powerup_container.get_children().pop_back()
	n.queue_free()
	powerup_names.pop_back()
	refresh_powerups()
	
func refresh_powerups():
	bullet_damage_bonus = powerup_names.count("DamageUp")
	regen_rate = powerup_names.count("RegenUp")
	time_regen_mod = 1 + powerup_names.count("TimeRegenUp") / 5.0
	pass

func regen():
	heal(regen_rate)

func load_powerups(array):
	for power_name in array:
		var power = DamageUp
		if power_name == "RegenUp":
			power = RegenUp
		if power_name == "TimeRegenUp":
			power = TimeRegenUp
		add_powerup(power)
