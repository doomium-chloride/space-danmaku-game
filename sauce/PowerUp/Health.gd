extends "res://sauce/PowerUp/PowerUp.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var value = 10


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_HealthPack_body_entered(body):
	if body.get_name() == "player":
		global.emit_signal("health_pack",value)
		queue_free()
