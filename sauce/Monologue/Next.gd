extends Button

onready var monologue = get_parent()

func _ready():
	pass


func _on_Next_pressed():
	monologue.emit_signal("next")
	pass # Replace with function body.
