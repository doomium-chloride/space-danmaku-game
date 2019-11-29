extends Button

onready var global = get_node("/root/global")

func _ready():
	set_process(true)

func _process(delta):
	if Input.is_action_just_released("default_choice"):
		_on_Start_pressed()


func _on_Start_pressed():
	global.goto_scene("res://scenes/Tutorial/Intro.tscn")

	pass # Replace with function body.
