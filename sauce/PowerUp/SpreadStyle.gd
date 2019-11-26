extends "res://sauce/PowerUp/PowerUp.gd"

export var style = "spread"
export var delay = 1
export var damage = 5

func _ready():
	connect("body_entered",self,"_on_body_entered")
	

func _on_body_entered(body):
	if body.get_name() == "player":
		global.emit_signal("style_change",style,delay,damage)
		queue_free()