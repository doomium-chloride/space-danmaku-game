extends "res://sauce/PowerUp/SpreadStyle.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	style = "narrow"
	delay = 0.05
	damage = 5
	
	connect("body_entered",self,"_on_body_entered")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
