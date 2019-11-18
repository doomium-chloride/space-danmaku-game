extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var global = get_node("/root/global")
const enemy_testing = preload("res://sauce/Enemy.tscn")
const enemy_pawn = preload("res://sauce/EnemyPawn.tscn")
const enemy_drone = preload("res://sauce/EnemyDrone.tscn")

export var spawn_delay = 2.0

var container = null
var spawn_now = false
var timer = null
# Called when the node enters the scene tree for the first time.
func _ready():
	timer = get_node("Timer")
	container = get_node("Container")
	start_spawning()
	set_process(true)
	pass # Replace with function body.

func start_spawning():
	timer = get_node("Timer") 
	timer.wait_time = spawn_delay
	timer.connect("timeout",self,"spawn_ok")
	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global.time_stopped:
		return
	spawn()
	pass

func spawn_ok():
	spawn_now = true

func spawn():
	if spawn_now:
		spawn_choice()
		spawn_now = false
func spawn_choice():
	var sample = rand_range(1,3)
	if sample < 1:
		spawn_test()
	elif sample < 2:
		spawn_enemy(enemy_pawn)
	elif sample < 3:
		spawn_enemy(enemy_drone)
	pass
func spawn_test():
	var enemy = enemy_testing.instance()
	enemy.position = choose_location()
	enemy.velocity.y = 100
	container.add_child(enemy)
	pass
func spawn_enemy(enemy_class):
	var enemy = enemy_class.instance()
	enemy.position = choose_location()
	container.add_child(enemy)

func choose_location():
	var x_max = get_viewport().size.x
	var x = rand_range(10,x_max-10)
	var y = -10
	return Vector2(x,y)