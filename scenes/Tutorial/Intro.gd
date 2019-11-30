extends "res://sauce/Monologue/Monologue.gd"

func _ready():
	next_scene = "res://scenes/Level1.tscn"
	text_array = ["The distant future",
	"The year is 2020",
	"Within the distant reaches of space",
	"Planet Siog, the faire homewolrd is under assult by the Sapius empire.",
	"...",
	"The cruel Sapesians seek the faires wings which when ground becomes a powerful narcotic. " +\
	"Though the faires fought valliantly they were no match to the Sapesians superior technology.",
	"The archmagisters of Siog placed a barrier around the planet " +\
	"but as the seige continues their power wanes and the barrier grows ever thin.",
	"The planet's future appears grim...",
	"But in its darkest hour the flower of hope blossoms. " +\
	"A new type of soilder is born, one with the power to match the sapasians fleets." +\
	"Armed with strength and speed unlike anything ever seen on Siog they were dubbed the YOUSEI.",
	"-Ye \n-Old \n-Ultra \n-Super \n-Eccentric \n-Idealiser",
	"...",
	"In the upper atmostphere of siog the battle rages on..."]
	init()