extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var global = get_node("/root/global")

export var hp = 10
export var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	if not global.is_connected("enemy_hit",self,"_on_enemy_hit"):
		global.connect("enemy_hit",self,"_on_enemy_hit")
	randomize()
	set_process(true)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not global.time_stopped:
		translate(velocity*delta)
	if hp <= 0:
		die()
	if position.y > get_viewport_rect().size.y:
		die()
	pass

func die():
	queue_free()
	
func _on_enemy_hit():
	print(get_name()," enemy is hit")
	pass

