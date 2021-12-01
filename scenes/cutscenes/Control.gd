extends Control

export (PackedScene) var next_scene
export (Script) var text_script
onready var text = text_script.new().dialogue_1

onready var textbox = $MarginContainer/TextBox
onready var timer = $Timer
onready var rtlabel = $MarginContainer/TextBox/MarginContainer/RichTextLabel

var dialogue_index = 0
var finished
var active
var position
var expression

func _ready():
	load_dialogue()

func _physics_process(delta):
	if active:

		if Input.is_action_just_pressed("ui_accept"):
			if finished == true:
				load_dialogue()
			else:
				timer.stop()
				rtlabel.percent_visible = 1
				finished = true

func load_dialogue():
	if dialogue_index < text.size():
		active = true
		finished = false
		textbox.visible = true
		rtlabel.bbcode_text = text[dialogue_index]["Text"]
		rtlabel.visible_characters = 0
		timer.start()
	else:
		finished = true
		get_tree().change_scene_to(next_scene)
	dialogue_index += 1

func _on_Timer_timeout():
	if rtlabel.visible_characters >= rtlabel.get_total_character_count():
		timer.stop()
		finished = true
	else:
		rtlabel.visible_characters += 1
