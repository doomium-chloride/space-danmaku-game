extends "res://sauce/PowerUp/SpreadStyle.gd"

func _ready():
	style = "flat"
	delay = 0.2
	damage = 5
	
	connect("body_entered",self,"_on_body_entered")