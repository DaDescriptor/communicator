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
	# print("KILL ME PLEASE")
	sendButton.connect('pressed', _send)
	inputLine.connect('text_submitted', _send)

func _get_args(text: String) -> Array:
	var result: Array = []
	var buffer: String = ""
	var isString: bool = false
	
	# go through every letter in the command and split it into multiple arguments
	for letter in text:
		if letter == " " and !isString:
			result.append(buffer)
			buffer = ""
		elif letter == "\"" and (buffer.length() > 1 and buffer[buffer.length()-2]):
			# toggle isString if processed character is unescaped double quote
			isString = !isString
		else:
			buffer = buffer+letter
	
	if buffer != "":
		result.append(buffer)
	
	if isString:
		output("Error parsing command: doublequotes are not closed.")
		return []
	
	return result

func output(text: String):
	var textInstance = textTemplate.instantiate() # create a new log message
	outputContainer.add_child(textInstance)
	textInstance.text = text # write text passed in

func _send(input: String = inputLine.text):
	output(">>> "+input) # log command written by user
	
	var args = _get_args(input).duplicate()
	args.remove_at(0) # remove the command from argument list
	
	on_send.emit(
		_get_args(input)[0], # command
		args, #arguments
		input # raw input string
	) 

func toggle_visibility(must_show: bool = !visible):
	visible = must_show

func _process(_delta):
	if Input.is_action_just_pressed("open_console"):
		toggle_visibility()
