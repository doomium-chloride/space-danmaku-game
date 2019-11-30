extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var global = get_node("/root/global")
const health = preload("res://sauce/PowerUp/Health.tscn")
#const spread = preload("res://sauce/PowerUp/SpreadStyle.tscn")
#const normal = preload("res://sauce/PowerUp/NormalStyle.tscn")
#const narrow = preload("res://sauce/PowerUp/NarrowStyle.tscn")
const damage = preload("res://sauce/PowerUp/PowerUpDamage.tscn")
const regen = preload("res://sauce/PowerUp/PowerUpRegen.tscn")
const time_regen = preload("res://sauce/PowerUp/PowerUpTimeRegen.tscn")

export var spawn_delay = 3.0
export var spawn = true

var list = [health, damage, regen, time_regen]

var container = null
var spawn_now = false
var timer = null
# Called when the node enters the scene tree for the first time.
func _ready():
	global.connect("timestop",self,"pause_spawn_timer")
	timer = get_node("Timer")
	container = get_node("Container")
	start_spawning()
	set_process(true)
	
	

func start_spawning():
	timer = get_node("Timer") 
	timer.wait_time = spawn_delay
	timer.connect("timeout",self,"spawn_ok")
	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not spawn:
		return
	if global.time_stopped:
		return
	spawn()
	
	# begin testing code
#	if Input.is_action_just_pressed("test"):
#		spawn_choice()
	# end testing code

func spawn_ok():
	spawn_now = true

func spawn():
	if spawn_now:
		spawn_choice()
		spawn_now = false
func spawn_choice(choice = null):
	if choice != null:
		spawn_powerup(list[choice])
		return
	if randi() % 2 < 1:
		return
	var sample = randi() % list.size()
	spawn_powerup(list[sample])
	
func spawn_powerup(powerup):
	var pu = powerup.instance()
	pu.position = choose_location()
	pu.velocity.y = 100
	container.add_child(pu)

func choose_location():
	var x_max = get_viewport().size.x
	var x = rand_range(10,x_max-10)
	var y = -10
	return Vector2(x,y)
	
func pause_spawn_timer():
	timer.paused = global.time_stopped