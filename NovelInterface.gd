extends Control

onready var choiceButtons = $CenterContainer/VBoxContainer
onready var textBox = $Panel/RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_Button_pressed():
	changeText("Button Pressed!")

func changeText(newText):
	textBox.text = newText
