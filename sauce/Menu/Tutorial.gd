extends Button

onready var global = get_node("/root/global")

func _ready():
	pass


func _on_Tutorial_pressed():
	global.goto_scene("res://scenes/Tutorial/Tutorial.tscn")
	pass # Replace with function body.
