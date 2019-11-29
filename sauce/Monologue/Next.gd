extends Button

onready var monologue = get_parent()

func _ready():
	set_process(true)

func _process(delta):
	if Input.is_action_just_released("default_choice"):
		_on_Next_pressed()

func _on_Next_pressed():
	monologue.emit_signal("next")
	pass # Replace with function body.
