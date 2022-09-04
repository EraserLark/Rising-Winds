extends Control

onready var centerContainer = $CenterContainer
onready var textPanel = $Panel
onready var textBox = $Panel/RichTextLabel
onready var nameLabel = $Panel/NameLabel

func _ready():
	pass

func changeName(name):
	nameLabel.text = name

func changeText(newText : String):
	textBox.text = newText

func textboxReveal(condition):
	textPanel.visible = condition
