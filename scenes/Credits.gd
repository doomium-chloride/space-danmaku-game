extends Button

onready var global = get_node("/root/global")

func _ready():
	pass


func _on_Credits_pressed():
	global.goto_scene("res://scenes/Tutorial/Credits.tscn")
	pass # Replace with function body.