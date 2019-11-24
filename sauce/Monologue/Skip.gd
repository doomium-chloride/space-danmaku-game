extends Button

onready var monologue = get_parent()

func _ready():
	pass


func _on_Skip_pressed():
	monologue.emit_signal("skip")
	pass # Replace with function body.
