extends AudioStreamPlayer

onready var global = get_node("/root/global")

export var volume = 0
const min_db = -80

func _ready():
	set_process(true)
	pass

func _process(delta):
	if global.time_stopped:
		volume_db = volume
	else:
		volume_db = min_db
	pass