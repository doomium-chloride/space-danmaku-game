extends Control

signal next
signal skip

onready var global = get_node("/root/global")
onready var textbox = get_node("Text")
onready var next_button = get_node("Next")
onready var skip_button = get_node("Skip")

var text_array = ["..."]
var current = 0

export var next_scene = "res://scenes/TitleScreen.tscn"

func _ready():
	connect("next",self,"next_text")
	connect("skip",self,"skip_monologue")
	init()
	set_process(true)
	pass

func _process(delta):
	pass
	
func add_text(text):
	text_array.append(text)
	
func next_text():
	current += 1
	if current >= text_array.size():
		skip_monologue()
	else:
		textbox.text = text_array[current]
		
func skip_monologue():
	global.goto_scene(next_scene)

func init():
	textbox.text = text_array[current]