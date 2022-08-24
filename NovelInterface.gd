extends Control

onready var choiceButtons = $CenterContainer/VBoxContainer
onready var textBox = $Panel/RichTextLabel
onready var nameLabel = $Panel/NameLabel

#Dialogue Dictionary Test
var masterDict = {1: {"Name": "Tony", "Dialogue": "Howdy howdy."},
2: {"Name": "Bismelda", "Dialogue": "Who are you?"}}
var dictCount : int = 1
var masterDictSize = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	choiceButtons.hide()
	
	masterDictSize = masterDict.size()
	displayMessage(masterDict[dictCount])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		if dictCount < masterDictSize:
			dictCount += 1
			displayMessage(masterDict[dictCount])
		else:
			textBox.hide()

func displayMessage(dict):
	nameLabel.text = dict["Name"]
	changeText(dict["Dialogue"])

func changeText(newText):
	textBox.text = newText
	
func _on_Button_pressed():
	changeText("Button Pressed!")
