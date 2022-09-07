extends Control

onready var centerContainer = $CenterContainer
onready var textPanel = $Panel
onready var textBox = $Panel/RichTextLabel
onready var nameLabel = $Panel/NameLabel

onready var typeTimer = $Panel/Timer
var defaultTypeSpeed = 0.05
var charIndex : int = 0
var currentDialogue
var inTag = false
var skip = false
signal phraseFin()

#var typeSpeed = 30

func _ready():
	pass

func setTimerSpeed(multiplier):
	typeTimer.set_wait_time(defaultTypeSpeed * multiplier)

func typeText(newText : String):
	
	textBox.clear()
	showTextbox(true)
	setTimerSpeed(1) #Set type speed
	
	currentDialogue = newText
	charIndex = 0
	skip = false
	
	#for loop instead?
	while charIndex < currentDialogue.length():
		#https://youtu.be/jhwfA-QF54M?t=414
		checkTag(currentDialogue, charIndex)
		
		if !inTag:
			textBox.text += currentDialogue[charIndex]
			if !skip:
				typeTimer.start()
				yield(typeTimer, "timeout")
		
		charIndex += 1
	
	emit_signal("phraseFin")

func checkTag(fullText, characterIndex):
		if fullText[characterIndex] == "<":
			var customWaitMult = int(fullText[characterIndex + 1])
			setTimerSpeed(customWaitMult)
			inTag = true
		elif inTag:
			if fullText[characterIndex - 1] == ">":
				inTag = false

func dialogueInput(event):
	if event.is_action_pressed("ui_accept"):
		typeTimer.emit_signal("timeout")	#Skips to end of current 'yield' timer, based off typing speed
		skip = true

func changeText(newText):
	textBox.text = newText

func changeName(name):
	nameLabel.text = name

func showTextbox(condition):
	textPanel.visible = condition
