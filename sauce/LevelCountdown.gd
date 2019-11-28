extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var global = get_node("/root/global")
onready var label = get_node("Countdown/Label")
onready var timer = get_node("Countdown/Timer")
onready var player = get_node("World/player")
var start_time = 100
var current_time = start_time
export var next_scene = "res://scenes/Monologues/Boss1Monologue.tscn"

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.wait_time = 1
	timer.connect("timeout",self,"countdown")
	global.connect("timestop",self,"pause_countdown")
	label.text = str(current_time)
	timer.start()
	pass # Replace with function body.

func countdown():
	current_time -= 1
	label.text = str(current_time)
	if current_time <= 0:
		global.hp = player.hp
		global.time = player.timestop_recharge
		global.emit_signal("bullet_clear")
		global.goto_scene(next_scene)
		pass
		
func pause_countdown():
	timer.paused = global.time_stopped

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
