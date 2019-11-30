extends "res://sauce/Monologue/Monologue.gd"

onready var topic = get_node("Title")
var title_array = [""]

func _ready():
	connect("next",self,"next_title")
	title_array = ["Art", "Music", "Sound FX", "Play testers", "Story", "me", "Special Thanks"]
	
	text_array = ["Gimp + hiclipart (public domain)", 
	"Kevin MacLeod.\n" +\
	"Some edited by me and Matthew Whitta",
	"esmayorga \n https://freesound.org/people \n /esmayorga/sounds/356312/",
	"Ciel and Matthew Whitta", "Matthew Whitta",
	"Doomium Chloride \n Jonathan Sulinom",
	"You \n Thank you for playing"]
	init()
	topic.text = title_array[current]


func next_title():
	if current < title_array.size():
		topic.text = title_array[current]
	else:
		topic.text = ""
		