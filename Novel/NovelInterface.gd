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
	setTimerSpeed(0.05)

func setTimerSpeed(newSpeed):
	typeTimer.set_wait_time(newSpeed)

func changeName(name):
	nameLabel.text = name

func typeText(newText : String):
	
	currentDialogue = newText
	charIndex = 0
#	var t : float = 0
#
#	while charIndex < newText.length():
#		t += self.get_process_delta_time() * typeSpeed
#		charIndex = int(t)
#		charIndex = clamp(charIndex, 0, newText.length())
#		textBox.text = newText.substr(0, charIndex)
	
	textBox.clear()
	
	while charIndex < currentDialogue.length():
		typeTimer.start()
		charIndex += 1
		textBox.text = currentDialogue.substr(0, charIndex)
		yield(typeTimer, "timeout")
	
	emit_signal("phraseFin")

func changeText(newText):
	textBox.text = newText

func dialogueInput(event):
	if event.is_action_pressed("ui_accept"):
		textBox.text = currentDialogue
		charIndex = 10000

func textboxReveal(condition):
	textPanel.visible = condition
