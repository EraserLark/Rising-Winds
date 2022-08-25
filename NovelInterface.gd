extends Node

onready var choiceButtons = $NovelInterface/CenterContainer/VBoxContainer
onready var textBox = $NovelInterface/Panel/RichTextLabel
onready var nameLabel = $NovelInterface/Panel/NameLabel
onready var actor1 = $Actor

#Dialogue Dictionary Test
onready var masterDict = {
1: {"Name": actor1.actorName, 	"Face": "Happy", 	"Dialogue": "Howdy howdy."},
2: {"Name": "Bismelda", 		"Face": "Angry", 	"Dialogue": "Who are you?"},
3: {"Name": actor1.actorName,	"Face": "Normal", 	"Dialogue": "Sorry to bother you, name's " + actor1.actorName},
4: {"Name": "Bismelda", 		"Face": "Sad", 		"Dialogue": "No worries. Been a long day."}
}
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
	actor1.changeFace(dict["Face"])
	changeText(dict["Dialogue"])

func changeText(newText):
	textBox.text = newText
	
func _on_Button_pressed():
	changeText("Button Pressed!")
