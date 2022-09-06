extends Control

onready var centerContainer = $CenterContainer
onready var textPanel = $Panel
onready var textBox = $Panel/RichTextLabel
onready var nameLabel = $Panel/NameLabel

onready var typeTimer = $Panel/Timer
var charIndex : int = 0
var currentDialogue
signal phraseFin()

#var typeSpeed = 30

func _ready():
	setTimerSpeed(0.05)	#Set type speed

func setTimerSpeed(newSpeed):
	typeTimer.set_wait_time(newSpeed)

func typeText(newText : String):
	
	textBox.clear()
	showTextbox(true)
	
	currentDialogue = newText
	charIndex = 0
	
	while charIndex < currentDialogue.length():
		typeTimer.start()
		charIndex += 1
		textBox.text = currentDialogue.substr(0, charIndex)
		yield(typeTimer, "timeout")
	
	emit_signal("phraseFin")

func dialogueInput(event):
	if event.is_action_pressed("ui_accept"):
		textBox.text = currentDialogue
		charIndex = currentDialogue.length()

func changeText(newText):
	textBox.text = newText

func changeName(name):
	nameLabel.text = name

func showTextbox(condition):
	textPanel.visible = condition
