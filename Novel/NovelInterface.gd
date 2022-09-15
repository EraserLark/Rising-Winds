extends Control

onready var centerContainer = $CenterContainer
onready var textPanel = $Panel
onready var textBox = $Panel/RichTextLabel
onready var nameLabel = $Panel/NameLabel

onready var typeTimer = $Panel/Timer
var defaultTypeSpeed = 0.05
onready var typeSound = $Panel/AudioStreamPlayer
#var charIndex : int = 0
#var currentDialogue
var skip = false
var inTag = false
signal phraseFin()

#var typeSpeed = 30

func _ready():
	pass

func setTimerSpeed(multiplier):
	typeTimer.set_wait_time(defaultTypeSpeed * multiplier)

func setTimer(time):
	typeTimer.set_wait_time(time)

func typeText(newText : String):
	
	textBox.clear()
	showTextbox(true)
	setTimerSpeed(1) #Set type speed
	
	var currentDialogue = newText
	var charIndex = 0
	skip = false
	
	#for loop instead?
	while charIndex < currentDialogue.length():
		#https://youtu.be/jhwfA-QF54M?t=414
		checkTag(currentDialogue, charIndex)
		
		if !inTag:
			textBox.text += currentDialogue[charIndex]
			typeSound.play()
			if !skip:
				typeTimer.start()
				yield(typeTimer, "timeout")
		
		charIndex += 1
	
	emit_signal("phraseFin")

#https://youtu.be/jhwfA-QF54M?t=403
func checkTag(fullText, characterIndex):
		if fullText[characterIndex] == "<":
			inTag = true
			var nextChar = fullText[characterIndex + 1]
			
			#Typing Speed
			if nextChar == "S":
				var customWaitMult = int(fullText[characterIndex + 2])
				setTimerSpeed(customWaitMult)
			#Pause Typing
			elif nextChar == "P":
				var pauseTime = int(fullText[characterIndex + 2])
				setTimer(pauseTime)
				
		elif inTag:
			if fullText[characterIndex - 1] == ">":
				inTag = false

func dialogueInput(event):
	if event.is_action_pressed("ui_accept"):
		skip = true
		typeTimer.stop()
		typeTimer.emit_signal("timeout")	#Skips to end of current 'yield' timer, based off typing speed

func changeText(newText):
	textBox.text = newText

func changeName(name):
	nameLabel.text = name

func showTextbox(condition):
	textPanel.visible = condition
