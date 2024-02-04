# Console.gd
# root node for Dconsole, provides an API to interact with the console

class_name Console extends Panel

signal on_send(input: String)

@onready var send: Button = $Send
@onready var output: VBoxContainer = $Output/VBoxContainer
@onready var input: LineEdit = $Command/LineEdit

func _ready():
	on_send.emit("Hello, World!")
