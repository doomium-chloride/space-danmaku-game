extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var timestop_bar = get_node("TimestopBar")
onready var hp_bar = get_node("HealthBar")

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)
	global.connect("timestop_counter",self,"update_timestop")
	global.connect("player_hp",self,"update_hp")
	pass # Replace with function body.

func update_timestop(value):
	timestop_bar.value = value
	
func update_hp(value):
	hp_bar.value = value

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
