extends AudioStreamPlayer

onready var global = get_node("/root/global")

export var volume = 0
const min_db = -80

func _ready():
	set_process(true)
	pass

func _process(delta):
	if global.time_stopped:
		volume_db = min_db
	else:
		volume_db = volume
	pass
