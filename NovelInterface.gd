extends Control

onready var choiceButtons = $CenterContainer/VBoxContainer
onready var textPanel = $Panel
onready var textBox = $Panel/RichTextLabel
onready var nameLabel = $Panel/NameLabel

func _ready():
	pass # Replace with function body.

func changeName(name):
	nameLabel.text = name

func changeText(newText):
	textBox.text = newText

func textboxReveal(condition):
	textPanel.visible = condition

func buttonReveal(condition):
	choiceButtons.visible = condition
