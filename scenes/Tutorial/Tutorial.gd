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
	"Numbers [1], [2] and [3] are different shooting styles. " +\
	"The higher the number the wider the shot. They all have the same " +\
	"rate of fire.",
	"Sometimes powerups appear. If the powerup's effect is instantaneous, " +\
	"it will immediately take effect. If the powerup is a " +\
	"buff, an orb will circle you indicating that the buff is active. " +\
	"The effect of the buff will last until you are hit by an enemy bullet.",
	"The top right bar is the health bar. When the health bar " +\
	"depeletes, your character is defeated.",
	"That's all for now. Happy 弾幕❕❕！"]
	init()
