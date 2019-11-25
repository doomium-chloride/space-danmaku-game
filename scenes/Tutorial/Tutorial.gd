extends "res://sauce/Monologue/Monologue.gd"

func _ready():
	next_scene = "res://scenes/TitleScreen.tscn"
	text_array = ["The game has 2 battle types. " +\
	"One is a normal level, where you need to survive " +\
	"for a set amount of time. The other is the boss level " + \
	"where you need to defeat a boss.",
	"Use the arrow keys to control your character. " +\
	"[P] is to pause the game. [Spacebar] is to use the " +\
	"timestop ability. The usage of the timestop ability " +\
	"depends on the gauge on the top left.",
	"The top right bar is the health bar. When the health bar " +\
	"depeletes, your character is defeated.",
	"That's all for now. Happy 弾幕❕❕！"]
	pass
