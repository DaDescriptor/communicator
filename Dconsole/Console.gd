# Console.gd
# root node for Dconsole, provides an API to interact with the console

class_name Console
extends Panel

signal on_send(command: String, arguments: Array, raw_input: String)

@onready var sendButton: Button = $Send
@onready var outputContainer: VBoxContainer = $Output/VBoxContainer
@onready var inputLine: LineEdit = $Command/LineEdit
@onready var textTemplate = load("res://Dconsole/output.tscn")

func _ready():
	print("KILL ME PLEASE")
	sendButton.connect('pressed', _send)

func output(text: String):
	print(text)
	
	var textInstance = textTemplate.instantiate() # create a new log message
	textInstance.reparent(outputContainer) # move it to the VBoxContainer
	textInstance.text = text # write text passed in

func _send():
	var input = inputLine.text
	print(">>> "+input)
	output(">>> "+input) # log command written by user
	
	
	
	on_send.emit(input) # emit send signal to note other scripts

func toggle_visibility(is_visible: bool = !visible):
	visible = is_visible

func _process(_delta):
	if Input.is_action_just_pressed("open_console"):
		toggle_visibility()
