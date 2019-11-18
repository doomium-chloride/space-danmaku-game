extends Area2D


onready var global = get_node("/root/global")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var of_player = false
export var velocity = Vector2()
export var damage = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if of_player or not get_node("/root/global").time_stopped:
		translate(velocity * delta)
	if not get_node("notifier").is_on_screen():
        queue_free()
	pass



func _on_bullet_body_shape_entered(body_id, body, body_shape, area_shape):
	if of_player:
		if body.get_name() != "player":
			global.emit_signal("enemy_hit")
			body.got_hit(damage)
			queue_free()
	else:
		if body.get_name() == "player":
			global.emit_signal("player_hit")
			queue_free()
	pass # Replace with function body.
