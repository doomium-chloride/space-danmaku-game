extends "res://sauce/PowerUp/PowerUp.gd"

const DamageUp = preload("res://sauce/PowerUp/DamageUp.tscn")
export var type = DamageUp

func _ready():
	connect("body_entered",self,"_on_body_entered")
	
func _on_body_entered(body):
	if body.get_name() == "player":
		global.emit_signal("power_up",type)
		queue_free()
