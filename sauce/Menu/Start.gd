extends Button

onready var global = get_node("/root/global")

func _ready():
	pass


func _on_Start_pressed():
	global.goto_scene("res://scenes/Level1.tscn")

	pass # Replace with function body.
